{*****************************************}
{   TeeChart Pro                          }
{   TPoint3DSeries                        }
{   Copyright (c) 1995-2003 David Berneda }
{*****************************************}
unit TeePoin3;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, TeeSurfa, Series, TeCanvas;

type
   TPoint3DSeries=class;

   TSeriesClickPointer3DEvent=Procedure( Sender:TPoint3DSeries;
                                         ValueIndex:Integer;
                                         X, Y: Integer) of object;

   TPoint3DSeries = class(TCustom3DSeries)
   private
     FDepthSize : Double;
     FPointer   : TSeriesPointer;

     { events }
     FOnClickPointer    : TSeriesClickPointer3DEvent;
     FOnGetPointerStyle : TOnGetPointerStyle;

     { internal }
     IOldX     : Integer;
     IOldY     : Integer;
     IOldZ     : Integer;

     Procedure CalcZPositions(ValueIndex:Integer);
     Function GetLinePen:TChartPen;
     Procedure SetDepthSize(Const Value:Double);
     Procedure SetPointer(Value:TSeriesPointer);
   protected
     Procedure AddSampleValues(NumValues:Integer); override;
     Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
     Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
     class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
     Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
     Procedure DrawMark( ValueIndex:Integer; Const St:String;
                         APosition:TSeriesMarkPosition); override;
     class Function GetEditorClass:String; override;
     Procedure PrepareForGallery(IsEnabled:Boolean); override;
     Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
     class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
     Constructor Create(AOwner: TComponent); override;
     Destructor Destroy; override;

     Procedure Assign(Source:TPersistent); override;
     Function Clicked(x,y:Integer):Integer; override;
     Procedure DrawValue(ValueIndex:Integer); override;
     Function MaxZValue:Double; override;
   published
     property Active;
     property ColorEachPoint;
     property ColorSource;
     property Cursor;
     property HorizAxis;
     property Marks;
     property ParentChart;
     property DataSource;
     property PercentFormat;
     property SeriesColor;
     property ShowInLegend;
     property Title;
     property ValueFormat;
     property VertAxis;
     property XLabelsSource;

     { events }
     property AfterDrawValues;
     property BeforeDrawValues;
     property OnAfterAdd;
     property OnBeforeAdd;
     property OnClearValues;
     property OnClick;
     property OnDblClick;
     property OnGetMarkText;
     property OnMouseEnter;
     property OnMouseLeave;

     property DepthSize:Double read FDepthSize write SetDepthSize;
     property LinePen:TChartPen read GetLinePen write SetPen;
     property Pointer:TSeriesPointer read FPointer write SetPointer;
     property TimesZOrder;
     property XValues;
     property YValues;
     property ZValues;
   { events }
     property OnClickPointer:TSeriesClickPointer3DEvent read FOnClickPointer
                                                        write FOnClickPointer;
     property OnGetPointerStyle:TOnGetPointerStyle read FOnGetPointerStyle
                                                   write FOnGetPointerStyle;
   end;

implementation

Uses Math, Chart, TeeConst, TeeProCo;

{ TPoint3DSeries }
Constructor TPoint3DSeries.Create(AOwner: TComponent);
begin
  inherited;
  FPointer:=TSeriesPointer.Create(Self);
end;

Destructor TPoint3DSeries.Destroy;
begin
  FPointer.Free;
  inherited;
end;

Procedure TPoint3DSeries.SetPointer(Value:TSeriesPointer);
Begin
  FPointer.Assign(Value);
end;

Procedure TPoint3DSeries.CalcZPositions(ValueIndex:Integer);
var tmp : Integer;
begin
  MiddleZ:=CalcZPos(ValueIndex);
  tmp:=Math.Max(1,ParentChart.DepthAxis.CalcSizeValue(FDepthSize) div 2);
  StartZ:=MiddleZ-tmp;
  EndZ:=MiddleZ+tmp;
end;

Function TPoint3DSeries.GetLinePen:TChartPen;
begin
  result:=Pen;
end;

type TPointerAccess=class(TSeriesPointer);

Procedure TPoint3DSeries.CalcHorizMargins(Var LeftMargin,RightMargin:Integer);
begin
  inherited;
  TPointerAccess(FPointer).CalcHorizMargins(LeftMargin,RightMargin);
end;

Procedure TPoint3DSeries.CalcVerticalMargins(Var TopMargin,BottomMargin:Integer);
begin
  inherited;
  TPointerAccess(FPointer).CalcVerticalMargins(TopMargin,BottomMargin);
end;

Procedure TPoint3DSeries.DrawValue(ValueIndex:Integer);
var tmpColor : TColor;
    tmpStyle : TSeriesPointerStyle;
    tmpX     : Integer;
    tmpY     : Integer;
    tmpFirst : Integer;
begin
  CalcZPositions(ValueIndex);
  With TPointerAccess(Pointer) do
  begin
    tmpX:=CalcXPos(ValueIndex);
    tmpY:=CalcYPos(ValueIndex);
    if Visible then
    begin { emulate TCustomSeries.DrawPointer method }
      tmpColor:=ValueColor[ValueIndex];
      PrepareCanvas(ParentChart.Canvas,tmpColor);
      if Assigned(FOnGetPointerStyle) then
         tmpStyle:=FOnGetPointerStyle(Self,ValueIndex)
      else
         tmpStyle:=FPointer.Style;
      DrawPointer( ParentChart.Canvas,ParentChart.View3D,tmpX,tmpY,HorizSize,VertSize,tmpColor,tmpStyle);
    end;

    if DrawValuesForward then tmpFirst:=FirstValueIndex
                         else tmpFirst:=LastValueIndex;

    if (ValueIndex<>tmpFirst) and LinePen.Visible then
    With ParentChart.Canvas do
    begin
      AssignVisiblePen(LinePen);
      BackMode:=cbmTransparent;
      MoveTo3D(IOldX,IOldY,IOldZ);
      LineTo3D(tmpX,tmpY,MiddleZ);
    end;

    IOldX:=tmpX;
    IOldY:=tmpY;
    IOldZ:=MiddleZ;
  end;
end;

Procedure TPoint3DSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
var tmpColor : TColor;
begin
  if FPointer.Visible then
  begin
    if ValueIndex=TeeAllValues then tmpColor:=SeriesColor
                               else tmpColor:=ValueColor[ValueIndex];
    TeePointerDrawLegend(Pointer,tmpColor,Rect,LinePen.Visible);
  end
  else inherited;
end;

Procedure TPoint3DSeries.AddSampleValues(NumValues:Integer);
var t : Integer;
Begin
  for t:=1 to NumValues do
    AddXYZ( System.Random(100), System.Random(100), System.Random(100));
end;

Procedure TPoint3DSeries.SetDepthSize(Const Value:Double);
begin
  SetDoubleProperty(FDepthSize,Value);
end;

Function TPoint3DSeries.MaxZValue:Double;
begin
  result:=ZValues.MaxValue+FDepthSize;
end;

Procedure TPoint3DSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                   APosition:TSeriesMarkPosition);
begin
  CalcZPositions(ValueIndex);
  if FPointer.Visible then Marks.ZPosition:=MiddleZ
                      else Marks.ZPosition:=StartZ;
  Marks.ApplyArrowLength(APosition);
  inherited;
end;

Procedure TPoint3DSeries.Assign(Source:TPersistent);
begin
  if Source is TPoint3DSeries then
  With TPoint3DSeries(Source) do
  begin
    Self.Pointer   :=FPointer;
    Self.FDepthSize:=FDepthSize;
  end;
  inherited;
end;

class Function TPoint3DSeries.GetEditorClass:String;
Begin
  result:='TPoint3DSeriesEditor'; { <-- dont translate ! }
end;

Procedure TPoint3DSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  LinePen.Color:=clNavy;
  ParentChart.View3DOptions.Zoom:=60;
end;

Function TPoint3DSeries.Clicked(x,y:Integer):Integer;
var t    : Integer;
    tmpX : Integer;
    tmpY : Integer;
    OldX : Integer;
    OldY : Integer;
begin
  OldX:=X;
  OldY:=Y;
  result:=inherited Clicked(x,y);

  if result=TeeNoPointClicked then
  if FPointer.Visible then
  for t:=0 to Count-1  do
  begin
    tmpX:=CalcXPos(t);
    tmpY:=CalcYPos(t);
    X:=OldX;
    Y:=OldY;

    if Assigned(ParentChart) then
       ParentChart.Canvas.Calculate2DPosition(X,Y,CalcZPos(t));

    if (Abs(tmpX-X)<FPointer.HorizSize) and { <-- Canvas.Zoom? }
       (Abs(tmpY-Y)<FPointer.VertSize) then
    begin
      if Assigned(FOnClickPointer) then FOnClickPointer(Self,t,OldX,OldY);
      result:=t;
      break;
    end;
  end;
end;

procedure TPoint3DSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if Assigned(Value) then { 5.01 }
     FPointer.ParentChart:=Value;
end;

class procedure TPoint3DSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoPoint);
  AddSubChart(TeeMsg_NoLine);
  AddSubChart(TeeMsg_Colors);
  AddSubChart(TeeMsg_Marks);
  AddSubChart(TeeMsg_Hollow);
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_Point2D);
  AddSubChart(TeeMsg_Triangle);
  AddSubChart(TeeMsg_Star);
  AddSubChart(TeeMsg_Circle);
  AddSubChart(TeeMsg_DownTri);
  AddSubChart(TeeMsg_Cross);
  AddSubChart(TeeMsg_Diamond);
end;

class procedure TPoint3DSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TPoint3DSeries(ASeries) do
  Case Index of
    1: Pointer.Visible:=False;
    2: Pen.Visible:=False;
    3: ColorEachPoint:=True;
    4: Marks.Visible:=True;
    5: Pointer.Brush.Style:=bsClear;
    6: Pointer.Pen.Visible:=False;
    7: Pointer.Draw3D:=False;
    8: Pointer.Style:=psTriangle;
    9: Pointer.Style:=psStar;
   10: Pointer.Style:=psCircle;
   11: Pointer.Style:=psDownTriangle;
   12: Pointer.Style:=psCross;
   13: Pointer.Style:=psDiamond;
  else inherited;
  end;
end;

initialization
  RegisterTeeSeries(TPoint3DSeries,@TeeMsg_GalleryPoint3D,@TeeMsg_Gallery3D,1);
finalization
  UnRegisterTeeSeries([TPoint3DSeries]);
end.
