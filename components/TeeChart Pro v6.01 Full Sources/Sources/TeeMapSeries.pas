{******************************************}
{    TeeChart Map Series                   }
{ Copyright (c) 2000-2003 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeMapSeries;
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
      {$IFDEF D6}
      Types,
      {$ENDIF}
     {$ENDIF}
     TeEngine, TeCanvas, TeeProcs, TeeSurfa;

type
  TPolygonSeries=class(TChartSeries)
  protected
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure NotifyValue(ValueEvent:TValueEvent; ValueIndex:Integer); override;
    procedure PrepareLegendCanvas(ValueIndex:Integer; Var BackColor:TColor;
                                Var BrushStyle:TBrushStyle); override;
    Procedure SetActive(Value:Boolean); override;
    Procedure SetSeriesColor(AColor:TColor); override;
  public
    Procedure FillSampleValues(NumValues:Integer); override;
  end;

  TMapSeries=class;

  TTeePolygon=class(TCollectionItem)
  private
    FGradient    : TChartGradient;
    FParentBrush : Boolean;
    FParentPen   : Boolean;
    FPoints      : TPolygonSeries;
    function GetBrush: TChartBrush;
    function GetColor: TColor;
    function GetPen: TChartPen;
    Function GetSeries:TMapSeries;
    Function GetText:String;
    function GetZ: Double;
    procedure SetBrush(const Value: TChartBrush);
    procedure SetColor(const Value: TColor);
    procedure SetGradient(const Value: TChartGradient);
    procedure SetParentBrush(const Value: Boolean);
    procedure SetParentPen(const Value: Boolean);
    procedure SetPen(const Value: TChartPen);
    Procedure SetText(Const Value:String);
    procedure SetZ(const Value: Double);
  public
    Constructor Create(Collection:TCollection); override;
    Destructor Destroy; override;

    Function AddXY(Const X,Y:Double):Integer;
    Procedure Draw(ACanvas:TCanvas3D);
    Function GetBounds(Const P:TPointArray):TRect;
    Function GetPoints:TPointArray;
    property ParentSeries:TMapSeries read GetSeries;
    property Points:TPolygonSeries read FPoints;
  published
    property Brush:TChartBrush read GetBrush write SetBrush;
    property Color:TColor read GetColor write SetColor default clWhite;
    property Gradient:TChartGradient read FGradient write SetGradient;
    property ParentBrush:Boolean read FParentBrush write SetParentBrush default True;
    property ParentPen:Boolean read FParentPen write SetParentPen default True;
    property Pen:TChartPen read GetPen write SetPen;
    property Text:String read GetText write SetText;
    property Z:Double read GetZ write SetZ;
  end;

  TTeePolygonList=class(TOwnedCollection)
  private
    Procedure Delete(Start,Quantity:Integer); overload;
    Function Get(Index:Integer):TTeePolygon;
    Procedure Put(Index:Integer; Const Value:TTeePolygon);
  public
    Function Add:TTeePolygon;
    Function Owner:TMapSeries;
    property Polygon[Index:Integer]:TTeePolygon read Get write Put; default;
  end;

  TMapSeries=class(TCustom3DPaletteSeries)
  private
    FShapes : TTeePolygonList;
    procedure SetShapes(const Value: TTeePolygonList);
  protected
    Procedure AddSampleValues(NumValues:Integer); override;
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
    class procedure CreateSubGallery(AddSubChart: TChartSubGalleryProc); override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure DrawValue(ValueIndex:Integer); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    procedure PrepareForGallery(IsEnabled:Boolean); override;
    class procedure SetSubGallery(ASeries: TChartSeries; Index: Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Clear; override;
    Function Clicked(x,y:Integer):Integer; override;
    Procedure Delete(ValueIndex:Integer); overload; override;
    Procedure Delete(Start,Quantity:Integer); overload; override;
    Function MaxXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinXValue:Double; override;
    Function MinYValue:Double; override;
    procedure SwapValueIndex(a,b:Integer); override;
  published
    { Published declarations }
    property Active;
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

    property Brush;
    property EndColor;
    property MidColor;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property Shapes:TTeePolygonList read FShapes write SetShapes stored False;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetColor;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

implementation

Uses Math, TeeConst, TeeProCo, Chart;

Type TSeriesAccess=class(TChartSeries);

{ TTeePolygon }
constructor TTeePolygon.Create(Collection: TCollection);
begin
  inherited;
  FGradient:=TChartGradient.Create(TSeriesAccess(ParentSeries).CanvasChanged);
  FPoints:=TPolygonSeries.Create(ParentSeries);
  FPoints.Tag:=Integer(Self);
  FPoints.XValues.Order:=loNone;
  FPoints.ShowInLegend:=False;
  FParentPen:=True;
  FParentBrush:=True;
  ParentSeries.AddXY(0,0);
end;

Destructor TTeePolygon.Destroy;
begin
  FPoints.Free;
  FGradient.Free;
  inherited;
end;

function TTeePolygon.AddXY(const X,Y: Double): Integer;
begin
  result:=FPoints.AddXY(X,Y);
end;

{ return the array of Points in screen (pixel) coordinates }
Function TTeePolygon.GetPoints:TPointArray;
var t : Integer;
begin
  SetLength(result,FPoints.Count);
  With ParentSeries do
  for t:=0 to FPoints.Count-1 do
  With result[t] do
  begin
    X:=GetHorizAxis.CalcPosValue(FPoints.XValues.Value[t]);
    Y:=GetVertAxis.CalcPosValue(FPoints.YValues.Value[t]);
  end;
end;

{ return the minimum left / top and the maximum right / bottom
  for all the points in "P" }
Function TTeePolygon.GetBounds(Const P:TPointArray):TRect;
var t : Integer;
begin
  result:=TeeRect(0,0,0,0);
  if Length(P)>0 then
  With result do
  begin
    TopLeft:=P[0];
    BottomRight:=TopLeft;
    for t:=0 to Length(P)-1 do
    begin
      if P[t].X<Left then Left:=P[t].X
      else
      if P[t].X>Right then Right:=P[t].X;
      if P[t].Y<Top then Top:=P[t].Y
      else
      if P[t].Y>Bottom then Bottom:=P[t].Y;
    end;
  end;
end;

{ draw the polygon... }
procedure TTeePolygon.Draw(ACanvas: TCanvas3D);
Var P     : TPointArray;
    P2    : Array[0..1000] of TPoint;
    t     : Integer;
    tmpZ  : Integer;
begin
  P:=nil;
  if FPoints.Active and (FPoints.Count>0) then
  With ACanvas do
  begin
    tmpZ:=ParentSeries.CalcZPos(Index);

    { set pen and brush... }
    if ParentPen then AssignVisiblePen(ParentSeries.Pen)
                 else AssignVisiblePen(Self.Pen);
    if ParentBrush then AssignBrush(ParentSeries.Brush,Self.Color)
                   else AssignBrush(Self.Brush,Self.Color);

    P:=GetPoints;
    try
      { draw a gradient... }
      if Self.Gradient.Visible and ParentSeries.ParentChart.CanClip then
      begin
        for t:=0 to Length(P)-1 do
            P2[t]:=Calculate3DPosition(P[t],tmpZ);

        ClipPolygon(ACanvas,P2,Length(P));
        Self.Gradient.Draw(ACanvas,CalcRect3D(GetBounds(P),tmpZ));
        ACanvas.UnClipRectangle;
        Brush.Style:=bsClear;
      end;

      { draw the shape... }
      PolygonWithZ(P,tmpZ);

    finally
      P:=nil;
    end;
  end;
end;

function TTeePolygon.GetBrush: TChartBrush;
begin
  result:=FPoints.Brush;
end;

function TTeePolygon.GetColor: TColor;
begin
  result:=ParentSeries.ValueColor[Index];
end;

function TTeePolygon.GetPen: TChartPen;
begin
  result:=FPoints.Pen;
end;

function TTeePolygon.GetSeries: TMapSeries;
begin
  result:=TTeePolygonList(Collection).Owner as TMapSeries;
end;

procedure TTeePolygon.SetBrush(const Value: TChartBrush);
begin
  FPoints.Brush:=Value;
end;

procedure TTeePolygon.SetColor(const Value: TColor);
begin
  Points.SeriesColor:=Value;
end;

procedure TTeePolygon.SetGradient(const Value: TChartGradient);
begin
  FGradient.Assign(Value);
end;

procedure TTeePolygon.SetPen(const Value: TChartPen);
begin
  FPoints.Pen:=Value;
end;

procedure TTeePolygon.SetZ(const Value: Double);
begin
  ParentSeries.ZValues[Index]:=Value;
end;

function TTeePolygon.GetZ: Double;
begin
  result:=ParentSeries.ZValues[Index];
end;

function TTeePolygon.GetText: String;
begin
  result:=ParentSeries.Labels[Index];
end;

procedure TTeePolygon.SetText(const Value: String);
begin
  ParentSeries.Labels[Index]:=Value;
end;

procedure TTeePolygon.SetParentBrush(const Value: Boolean);
begin
  ParentSeries.SetBooleanProperty(FParentBrush,Value);
end;

procedure TTeePolygon.SetParentPen(const Value: Boolean);
begin
  ParentSeries.SetBooleanProperty(FParentPen,Value);
end;

{ TTeePolygonList }
type TTeePolygonAccess=class(TChartSeries);

function TTeePolygonList.Add: TTeePolygon;
begin
  result:=inherited Add as TTeePolygon;
  TTeePolygonAccess(result.Points).SetDesigning(False);
end;

procedure TTeePolygonList.Delete(Start, Quantity: Integer);
var t: Integer;
begin
  for t:=1 to Quantity do Items[Start].Free;
end;

function TTeePolygonList.Get(Index: Integer): TTeePolygon;
begin
  result:=TTeePolygon(Items[Index]);
end;

function TTeePolygonList.Owner: TMapSeries;
begin
  result:=TMapSeries(GetOwner);
end;

procedure TTeePolygonList.Put(Index: Integer; const Value: TTeePolygon);
begin
  Items[Index]:=Value;
end;

{ TMapSeries }
Constructor TMapSeries.Create(AOwner: TComponent);
begin
  inherited;
  FShapes:=TTeePolygonList.Create(Self,TTeePolygon);
  CalcVisiblePoints:=False;
  YMandatory:=False;
  MandatoryValueList:=ZValues;
end;

Destructor TMapSeries.Destroy;
begin
  FreeAndNil(FShapes);
  inherited;
end;

procedure TMapSeries.DrawValue(ValueIndex: Integer);
begin
  if Shapes.Count>ValueIndex then
     Shapes[ValueIndex].Draw(ParentChart.Canvas);
end;

Procedure TMapSeries.Delete(ValueIndex:Integer);
begin
  inherited;
  if Assigned(FShapes) then Shapes[ValueIndex].Free;
end;

Procedure TMapSeries.Delete(Start,Quantity:Integer);
begin
  inherited;
  if Assigned(FShapes) then FShapes.Delete(Start,Quantity);
end;

function TMapSeries.MaxXValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MaxXValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Max(result,Shapes[t].FPoints.MaxXValue);
  end;
end;

function TMapSeries.MaxYValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MaxYValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Max(result,Shapes[t].FPoints.MaxYValue);
  end;
end;

function TMapSeries.MinXValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MinXValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Min(result,Shapes[t].FPoints.MinXValue);
  end;
end;

function TMapSeries.MinYValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MinYValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Min(result,Shapes[t].FPoints.MinYValue);
  end;
end;

procedure TMapSeries.PrepareForGallery(IsEnabled:Boolean);
var t : Integer;
begin
  inherited;
  if not IsEnabled then
     for t:=0 to Count-1 do Shapes[t].Color:=clSilver;
end;

procedure TMapSeries.SwapValueIndex(a,b:Integer);
begin
  inherited;
  Shapes[a].Index:=b;
  Repaint;
end;

procedure TMapSeries.SetShapes(const Value: TTeePolygonList);
begin
  FShapes.Assign(Value);
end;

procedure TMapSeries.CalcHorizMargins(var LeftMargin,
  RightMargin: Integer);
begin
  inherited;
  if Pen.Visible then
  begin
    Inc(LeftMargin,Pen.Width);
    Inc(RightMargin,Pen.Width);
  end;
end;

procedure TMapSeries.CalcVerticalMargins(var TopMargin,
  BottomMargin: Integer);
begin
  inherited;
  Inc(BottomMargin);
  if Pen.Visible then
  begin
    Inc(TopMargin,Pen.Width);
    Inc(BottomMargin,Pen.Width);
  end;
end;

procedure TMapSeries.AddSampleValues(NumValues: Integer);

  Procedure AddShape(Const X,Y:Array of Integer; AColor:TColor; Const AText:String);
  var t : Integer;
  begin
    With Shapes.Add do
    begin
      for t:=Low(X) to High(X) do AddXY(X[t],Y[t]);
      Color:=AColor;
      Text:=AText;
      Z:=Random(1000)/1000.0;
    end;
  end;

Const AX:Array[0..13] of Integer=(1,3,4,4,5,5,6,6,4,3,2,1,2,2);
      AY:Array[0..13] of Integer=(7,5,5,7,8,9,10,11,11,12,12,11,10,8);
      BX:Array[0..8]  of Integer=(5,7,8,8,7,6,5,4,4);
      BY:Array[0..8]  of Integer=(4,4,5,6,7,7,8,7,5);
      CX:Array[0..15] of Integer=(9,10,11,11,12,9,8,7,6,6,5,5,6,7,8,8);
      CY:Array[0..15] of Integer=(5,6,6,7,8,11,11,12,11,10,9,8,7,7,6,5);
      DX:Array[0..7]  of Integer=(12,14,15,14,13,12,11,11);
      DY:Array[0..7]  of Integer=(5,5,6,7,7,8,7,6);
      EX:Array[0..10] of Integer=(4,6,7,7,6,6,5,4,3,3,2);
      EY:Array[0..10] of Integer=(11,11,12,13,14,15,16,16,15,14,13);
      FX:Array[0..11] of Integer=(7,8,9,11,10,8,7,6,5,5,6,6);
      FY:Array[0..11] of Integer=(13,14,14,16,17,17,18,18,17,16,15,14);
      GX:Array[0..11] of Integer=(10,12,12,14,13,11,9,8,7,7,8,9);
      GY:Array[0..11] of Integer=(10,12,13,15,16,16,14,14,13,12,11,11);
      HX:Array[0..9]  of Integer=(17,19,18,18,17,15,14,13,15,16);
      HY:Array[0..9]  of Integer=(11,13,14,16,17,15,15,14,12,12);
      IX:Array[0..14] of Integer=(15,16,17,16,15,14,14,13,12,11,10,11,12,13,14);
      IY:Array[0..14] of Integer=(6,6,7,8,8,9,10,11,12,11,10,9,8,7,7);
      JX:Array[0..11] of Integer=(15,16,16,17,17,16,15,13,12,12,14,14);
      JY:Array[0..11] of Integer=(8,8,9,10,11,12,12,14,13,12,10,9);
      KX:Array[0..9]  of Integer=(17,19,20,20,19,17,16,16,17,16);
      KY:Array[0..9]  of Integer=(5,5,6,8,8,10,9,8,7,6);
      LX:Array[0..6]  of Integer=(19,20,21,21,19,17,17);
      LY:Array[0..6]  of Integer=(8,8,9,11,13,11,10);
begin
  AddShape(AX,AY,clLime,'A');
  AddShape(BX,BY,clRed,'B');
  AddShape(CX,CY,clFuchsia,'C');
  AddShape(DX,DY,clAqua,'D');
  AddShape(EX,EY,clSilver,'E');
  AddShape(FX,FY,clAqua,'F');
  AddShape(GX,GY,clGreen,'G');
  AddShape(HX,HY,clTeal,'H');
  AddShape(IX,IY,clWhite,'I');
  AddShape(JX,JY,clRed,'J');
  AddShape(KX,KY,clBlue,'K');
  AddShape(LX,LY,clYellow,'L');
end;

function TMapSeries.Clicked(x, y: Integer): Integer;
var P    : TPointArray;
    t    : Integer;
    tmpX : Integer;
    tmpY : Integer;
begin
  result:=TeeNoPointClicked;
  for t:=0 to Shapes.Count-1 do
  begin
    tmpX:=X;
    tmpY:=Y;
    if Assigned(ParentChart) then
    With ParentChart do
       Canvas.Calculate2DPosition(tmpX,tmpY,CalcZPos(t));
    P:=Shapes[t].GetPoints;
    try
      if PointInPolygon(TeePoint(tmpX,tmpY),P) then
         result:=t;
    finally
      SetLength(P,0);
    end;
    if result<>TeeNoPointClicked then Break;
  end;
end;

procedure TMapSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
Var P : TPointArray;
begin
  if Shapes.Count>ValueIndex then
  begin
    P:=Shapes[ValueIndex].GetPoints;
    try
      with Shapes[ValueIndex].GetBounds(P) do
      begin
        APosition.LeftTop.X:=((Right+Left) div 2)-(APosition.Width div 2);
        APosition.LeftTop.Y:=((Top+Bottom) div 2)-(APosition.Height div 2);
      end;
    finally
      SetLength(P,0);
    end;
  end;
  inherited;
end;

class function TMapSeries.GetEditorClass: String;
begin
  result:='TMapSeriesEditor';
end;

procedure TMapSeries.Clear;
begin
  inherited;
  if Assigned(Shapes) then Shapes.Clear;
end;

class procedure TMapSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Colors);
end;

class procedure TMapSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TMapSeries(ASeries) do
  Case Index of
    2: ColorEachPoint:=True;
  else inherited;
  end
end;

procedure TMapSeries.GalleryChanged3D(Is3D: Boolean);
begin { 5.02 }
  if Is3D then inherited
          else ParentChart.View3D:=False;
end;

{ TPolygonSeries }
procedure TPolygonSeries.NotifyValue(ValueEvent: TValueEvent;
  ValueIndex: Integer);
begin
  inherited;
  TChartSeries(Owner).Repaint;
end;

procedure TPolygonSeries.SetActive(Value: Boolean);
begin
  inherited;
  TChartSeries(Owner).Repaint;
end;

procedure TPolygonSeries.SetSeriesColor(AColor: TColor);
begin
  inherited;
  TChartSeries(Owner).ValueColor[TTeePolygon(Tag).Index]:=AColor;
end;

procedure TPolygonSeries.PrepareLegendCanvas(ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle);
begin
  inherited;
  with TTeePolygon(Tag) do { 5.02 }
  if not Gradient.Visible then ParentChart.Canvas.Brush.Color:=Color;
end;

procedure TPolygonSeries.DrawLegendShape(ValueIndex: Integer;
  const Rect: TRect);
begin
  with TTeePolygon(Tag).Gradient do { 5.02 }
  if Visible then Draw(ParentChart.Canvas,Rect)
             else inherited;
end;

procedure TPolygonSeries.FillSampleValues(NumValues: Integer);
begin { do nothing, sample values are provided by Owner Series }
end;

initialization
  RegisterTeeSeries( TMapSeries, @TeeMsg_GalleryMap,
                     @TeeMsg_GalleryExtended,1);
finalization
  UnRegisterTeeSeries([TMapSeries]);
end.
