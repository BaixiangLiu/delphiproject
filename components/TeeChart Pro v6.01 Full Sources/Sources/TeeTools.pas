{**********************************************}
{   TeeChart Tools                             }
{   Copyright (c) 1999-2003 by David Berneda   }
{**********************************************}
unit TeeTools;
{$I TeeDefs.inc}

interface

// This unit defines and implements several "Chart Tools".
// Tools appear at the Chart editor "Tools" tab and can be added
// both at design-time and run-time.

// The purpose of a "tool" is to perform some generic functionality
// outside the Chart or Series code. Chart Tools are notified of
// chart drawing (repaints) and chart mouse events (move, up, down).

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls,
     {$ELSE}
     Graphics, Controls,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeCanvas, TeeProcs, TeEngine, Chart;

// Default number of pixels to consider a line is "clicked"
// (ie: when the mouse is more or less 3 pixels from a line)
Const TeeClickTolerance = 3;

Type
  // Style of cursor tool
  TCursorToolStyle=(cssHorizontal,cssVertical,cssBoth);

  TCursorTool=class;

  TCursorClicked=(ccNone,ccHorizontal,ccVertical,ccBoth);

  TCursorToolChangeEvent=procedure( Sender:TCursorTool;
                                    x,y:Integer;
                                    Const XValue,YValue:Double;
                                    Series:TChartSeries;
                                    ValueIndex:Integer) of object;

  TCursorToolGetAxisRect=procedure(Sender:TCursorTool; Var Rect:TRect) of object;

  // Cursor tool, use it to draw a draggable line (cursor)
  TCursorTool=class(TTeeCustomToolSeries)
  private
    FFollowMouse   : Boolean;
    FOnChange      : TCursorToolChangeEvent;
    FOnGetAxisRect : TCursorToolGetAxisRect;
    FSnap          : Boolean;
    FStyle         : TCursorToolStyle;
    FUseChartRect  : Boolean;

    IDragging      : TCursorClicked;
    Procedure CalcValuePositions(X,Y:Integer);
    Function GetAxisRect:TRect;
    Procedure SetStyle(Value:TCursorToolStyle);
    procedure SetUseChartRect(const Value: Boolean);
    procedure SetXValue(const Value: Double);
    procedure SetYValue(const Value: Double);
  protected
    IXValue     : Double;  { 5.01 }
    IYValue     : Double;
    IPoint      : TPoint;
    Procedure CalcScreenPositions; { 5.01 }
    Procedure Changed(SnapPoint:Integer); virtual;
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Constructor Create(AOwner:TComponent); override;

    Function Clicked(x,y:Integer):TCursorClicked;
    class Function Description:String; override;
    Function NearestPoint(AStyle:TCursorToolStyle; Var Difference:Double):Integer;
    Function SnapToPoint:Integer;
    procedure RedrawCursor;

    property UseChartRect:Boolean read FUseChartRect write SetUseChartRect default False;
    property XValue:Double read IXValue write SetXValue;
    property YValue:Double read IYValue write SetYValue;
    property OnGetAxisRect:TCursorToolGetAxisRect read FOnGetAxisRect write FOnGetAxisRect;
  published
    property Active;
    property FollowMouse:Boolean read FFollowMouse write FFollowMouse default False;
    property Pen;
    property Series;
    property Snap:Boolean read FSnap write FSnap default False;
    property Style:TCursorToolStyle read FStyle write SetStyle default cssBoth;
    { events }
    property OnChange:TCursorToolChangeEvent read FOnChange write FOnChange;
  end;

  // Drag Marks tool, use it to allow the end-user to drag series Marks
  TDragMarksTool=class(TTeeCustomToolSeries)
  private
    { internal }
    IOldX    : Integer;
    IOldY    : Integer;
    IPosition: TSeriesMarkPosition;
    ISeries  : TChartSeries;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
  public
    class Function Description:String; override;
  published
    property Active;
    property Series;
  end;

  TAxisArrowTool=class;

  TAxisArrowClickEvent=procedure(Sender:TAxisArrowTool; AtStart:Boolean) of object;

  TAxisArrowToolPosition=(aaStart,aaEnd,aaBoth);

  // Axis Arrow tool, use it to display small "arrows" at start and end
  // positions of an axis. These arrows can be clicked to scroll the axis.
  TAxisArrowTool=class(TTeeCustomToolAxis)
  private
    FLength        : Integer;
    FPosition      : TAxisArrowToolPosition;
    FScrollPercent : Integer;
    FScrollInverted: Boolean;

    FOnClick       : TAxisArrowClickEvent;
    
    Function ClickedArrow(x,y:Integer):Integer;
    procedure SetLength(const Value: Integer);
    procedure SetPosition(const Value: TAxisArrowToolPosition);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;

    class Function Description:String; override;
  published
    property Active;
    property Position:TAxisArrowToolPosition read FPosition write SetPosition default aaBoth;
    property Axis;
    property Brush;
    property Length:Integer read FLength write SetLength default 16;
    property Pen;
    property ScrollInverted:Boolean read FScrollInverted write FScrollInverted default False;
    property ScrollPercent:Integer read FScrollPercent write FScrollPercent default 10;

    { events }
    property OnClick:TAxisArrowClickEvent read FOnClick write FOnClick;
  end;

  TFloatPoint=packed record
    X : Double;
    Y : Double;
  end;

  TDrawLineTool=class;

  TDrawLineStyle=(dlLine,dlHorizParallel,dlVertParallel); { 5.03 }

  // Element of Lines collection in TDrawLineTool class
  TDrawLine=class(TCollectionItem)
  private
    FStyle : TDrawLineStyle;

    Function GetParent:TDrawLineTool;
    Function GetPen:TChartPen;
    function GetX0: Double;
    function GetX1: Double;
    function GetY0: Double;
    function GetY1: Double;
    Procedure SetStyle(Value:TDrawLineStyle);
    procedure SetX0(const Value: Double);
    procedure SetX1(const Value: Double);
    procedure SetY0(const Value: Double);
    procedure SetY1(const Value: Double);
  public
    EndPos   : TFloatPoint;
    StartPos : TFloatPoint;
    Constructor CreateXY(Collection:TCollection; Const X0,Y0,X1,Y1:Double);
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override; { 5.01 }
    Procedure DrawHandles;
    Function EndHandle:TRect;
    Function StartHandle:TRect;

    property Parent : TDrawLineTool read GetParent;
    property Pen    : TChartPen read GetPen;
  published
    property Style:TDrawLineStyle read FStyle write SetStyle default dlLine;
    property X0:Double read GetX0 write SetX0;
    property Y0:Double read GetY0 write SetY0;
    property X1:Double read GetX1 write SetX1;
    property Y1:Double read GetY1 write SetY1;
  end;

  // Collection of lines (TDrawLine) used in TDrawLineTool
  TDrawLines=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TDrawLine;
    Procedure Put(Index:Integer; Const Value:TDrawLine);
  public
    Function Last:TDrawLine;
    property Line[Index:Integer]:TDrawLine read Get write Put; default;
  end;

  TDrawLineHandle=(chNone,chStart,chEnd,chSeries);

  TDrawLineSelecting=procedure( Sender:TDrawLineTool; Line:TDrawLine;
                                var AllowSelect:Boolean) of object;

  // Draw Line tool, use it to allow the end-user to draw, drag, select
  // and move lines.
  TDrawLineTool=class(TTeeCustomToolSeries)
  private
    FButton       : TMouseButton;
    FEnableDraw   : Boolean;
    FEnableSelect : Boolean;
    FLines        : TDrawLines;
    FOnDraggedLine: TNotifyEvent;
    FOnDragLine   : TNotifyEvent;
    FOnNewLine    : TNotifyEvent;
    FOnSelect     : TNotifyEvent;
    FOnSelecting  : TDrawLineSelecting;

    IDrawing  : Boolean;
    IPoint    : TPoint;
    ISelected : TDrawLine;
    Procedure DrawLine(Const StartPos,EndPos:TPoint; AStyle:TDrawLineStyle);
    Function InternalClicked(X,Y:Integer; AHandle:TDrawLineHandle):TDrawLine;
    Procedure SetEnableSelect(Value:Boolean);
    Procedure SetLines(Const Value:TDrawLines);
    Procedure SetSelected(Value:TDrawLine);
    Procedure RedrawLine(ALine:TDrawLine);
  protected
    IHandle   : TDrawLineHandle;
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    Procedure ClipDrawingRegion; virtual;
    class function GetEditorClass: String; override;
  public
    FromPoint : TPoint;
    ToPoint   : TPoint;
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Function AxisPoint(Const P:TFloatPoint):TPoint;
    Function Clicked(X,Y:Integer):TDrawLine;
    Procedure DeleteSelected;
    Function ScreenPoint(P:TPoint):TFloatPoint;

    class Function Description:String; override;
    property Selected:TDrawLine read ISelected write SetSelected;
  published
    property Active;
    property Button:TMouseButton read FButton write FButton default mbLeft;
    property EnableDraw:Boolean read FEnableDraw write FEnableDraw default True;
    property EnableSelect:Boolean read FEnableSelect write SetEnableSelect default True;
    property Lines:TDrawLines read FLines write SetLines;
    property Pen;
    property Series;
    { events }
    property OnDraggedLine:TNotifyEvent read FOnDraggedLine write FOnDraggedLine; { 5.01 }
    property OnDragLine:TNotifyEvent read FOnDragLine write FOnDragLine;
    property OnNewLine:TNotifyEvent read FOnNewLine write FOnNewLine;
    property OnSelect:TNotifyEvent read FOnSelect write FOnSelect;
    property OnSelecting:TDrawLineSelecting read FOnSelecting write FOnSelecting;  { 5.03 }
  end;

{ This variable can be used to set the default "DrawLine" class used by
  TDrawLineTool when creating new lines }
  TDrawLineClass=class of TDrawLine;

Var
  TeeDrawLineClass:TDrawLineClass=TDrawLine; { 5.02 }

type
  TMarkToolMouseAction = (mtmMove, mtmClick);

  TMarksTipTool=class;

  TMarksTipGetText=procedure(Sender:TMarksTipTool; Var Text:String) of object;

  // Marks tip tool, use it to display "tips" or "hints" when the end-user
  // moves or clicks the mouse over a series point.
  TMarksTipTool=class(TTeeCustomToolSeries)
  private
    FMouseAction : TMarkToolMouseAction;
    FOnGetText   : TMarksTipGetText;
    FStyle       : TSeriesMarksStyle;
    Procedure SetMouseAction(Value:TMarkToolMouseAction);
    function GetMouseDelay: Integer;
    procedure SetMouseDelay(const Value: Integer);
  protected
    Function Chart:TCustomChart;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    Procedure SetActive(Value:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
  published
    property Active;
    property MouseAction:TMarkToolMouseAction read FMouseAction
                                               write SetMouseAction default mtmMove;
    property MouseDelay:Integer read GetMouseDelay
                                write SetMouseDelay default 500; { 5.02 }

    property Series;
    property Style:TSeriesMarksStyle read FStyle write FStyle default smsLabel;

    property OnGetText:TMarksTipGetText read FOnGetText write FOnGetText;
  end;

  TNearestToolStyle=(hsNone,hsCircle,hsRectangle,hsDiamond);

  // Nearest tool, use it to display a graphical signal when the mouse is
  // moving near a series point.
  TNearestTool=class(TTeeCustomToolSeries)
  private
    FDrawLine   : Boolean;
    FFullRepaint: Boolean;
    FSize       : Integer;
    FStyle      : TNearestToolStyle;
    FOnChange   : TNotifyEvent;

    IMouse      : TPoint;
    procedure PaintHint;
    procedure SetSize(const Value: Integer);
    procedure SetStyle(const Value: TNearestToolStyle);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
  public
    Point : Integer;
    Constructor Create(AOwner:TComponent); override;

    class Function Description:String; override;
  published
    property Active;
    property Brush;
    property DrawLine:Boolean read FDrawLine write FDrawLine default True;
    property FullRepaint:Boolean read FFullRepaint write FFullRepaint default True;
    property Pen;
    property Series;
    property Size:Integer read FSize write SetSize default 20;
    property Style:TNearestToolStyle read FStyle write SetStyle default hsCircle;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

  // Color band tool, use it to display a coloured rectangle (band)
  // at the specified axis and position.
  TColorBandTool=class(TTeeCustomToolAxis)
  private
    FColor        : TColor;
    FDrawBehind   : Boolean;
    FEnd          : Double;
    FGradient     : TChartGradient;
    FStart        : Double;
    FTransparency : TTeeTransparency;
    procedure PaintBand;
    Procedure SetColor(Value:TColor);
    procedure SetDrawBehind(const Value: Boolean);
    procedure SetEnd(const Value: Double);
    procedure SetGradient(const Value: TChartGradient);
    procedure SetStart(const Value: Double);
    procedure SetTransparency(const Value: TTeeTransparency);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
  published
    property Active;
    property Axis;
    property Brush;
    property Color:TColor read FColor write SetColor default clWhite;
    property DrawBehind:Boolean read FDrawBehind write SetDrawBehind default True;
    property EndValue:Double read FEnd write SetEnd;
    property Gradient:TChartGradient read FGradient write SetGradient;
    property Pen;
    property StartValue:Double read FStart write SetStart;
    property Transparency:TTeeTransparency read FTransparency
                                           write SetTransparency default 0;
  end;

  TGridBandBrush=class(TChartBrush)
  private
    FBackColor : TColor;
    FTransp    : TTeeTransparency;
    procedure SetBackColor(const Value: TColor);
    procedure SetTransp(const Value: TTeeTransparency);
  published
    property BackColor:TColor read FBackColor write SetBackColor default clNone;
    property Transparency:TTeeTransparency read FTransp write SetTransp default 0;
  end;

  // TGridBandTool
  // Draws alternate color bands on axis grid space.
  TGridBandTool=class(TTeeCustomToolAxis)
  private
    FBand1 : TGridBandBrush;
    FBand2 : TGridBandBrush;
    Procedure DrawGrids(Sender:TChartAxis);
    Procedure SetBand1(Value:TGridBandBrush);
    Procedure SetBand2(Value:TGridBandBrush);
  protected
    class function GetEditorClass: String; override;
    procedure SetAxis(const Value: TChartAxis); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Function BandBackColor(ABand:TGridBandBrush):TColor;
    class Function Description:String; override;
  published
    property Active;
    property Axis;
    property Band1:TGridBandBrush read FBand1 write SetBand1;
    property Band2:TGridBandBrush read FBand2 write SetBand2;
  end;

  TColorLineTool=class;

  TColorLineStyle=(clCustom,clMaximum,clCenter,clMinimum);

  TColorLineToolOnDrag=procedure(Sender:TColorLineTool) of object;

  // Color line tool, use it to display a vertical or horizontal line
  // at the specified axis and position.
  // The line can be optionally dragged at runtime.
  TColorLineTool=class(TTeeCustomToolAxis)
  private
    FAllowDrag     : Boolean;
    FDragRepaint   : Boolean;
    FDraw3D        : Boolean;
    FDrawBehind    : Boolean;
    FNoLimitDrag   : Boolean;
    FOnDragLine    : TColorLineToolOnDrag;
    FOnEndDragLine : TColorLineToolOnDrag;
    FStyle         : TColorLineStyle;
    FValue         : Double;

    IDragging      : Boolean;
    Procedure DrawColorLine(Back:Boolean); { 5.02 }
    Function LimitValue(const AValue:Double):Double;
    procedure SetDraw3D(const Value: Boolean);
    procedure SetDrawBehind(const Value: Boolean);
    procedure SetStyle(const Value: TColorLineStyle);
    procedure SetValue(const AValue: Double);
  protected
    Function CalcValue:Double;
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    procedure DoEndDragLine; virtual; { 5.02 }
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;

    Function Clicked(x,y:Integer):Boolean;
    class Function Description:String; override;
  published
    property Active;
    property Axis;
    property AllowDrag:Boolean read FAllowDrag write FAllowDrag default True;
    property DragRepaint:Boolean read FDragRepaint write FDragRepaint default False;
    property Draw3D:Boolean read FDraw3D write SetDraw3D default True;
    property DrawBehind:Boolean read FDrawBehind write SetDrawBehind default False;
    property NoLimitDrag:Boolean read FNoLimitDrag write FNoLimitDrag default False;
    property Pen;
    property Style:TColorLineStyle read FStyle write SetStyle default clCustom;
    property Value:Double read FValue write SetValue;

    property OnDragLine:TColorLineToolOnDrag read FOnDragLine write FOnDragLine;
    property OnEndDragLine:TColorLineToolOnDrag read FOnEndDragLine write FOnEndDragLine;
  end;

  // Rotate tool, use it to allow the end-user to do 3D rotation of the chart
  // at runtime by dragging the chart using the specified mouse button.

  TRotateToolStyles = ( rsAll, rsRotation, rsElevation );

  TRotateTool=class(TTeeCustomTool)
  private
    FButton    : TMouseButton;
    FInverted  : Boolean;
    FOnRotate  : TNotifyEvent;
    FStyle     : TRotateToolStyles;

    IOldX      : Integer;
    IOldY      : Integer;
    IDragging  : Boolean;
    IFirstTime : Boolean;
    IOldRepaint: Boolean;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    class function ElevationChange(FullRotation:Boolean; AAngle,AChange:Integer):Integer;
    class function RotationChange(FullRotation:Boolean; AAngle,AChange:Integer):Integer;
  published
    property Active;
    property Button:TMouseButton read FButton write FButton default mbLeft;
    property Inverted:Boolean read FInverted write FInverted default False;
    property Pen;
    property Style:TRotateToolStyles read FStyle write FStyle default rsAll;

    property OnRotate:TNotifyEvent read FOnRotate write FOnRotate;
  end;

  // Chart Image tool, use it to display a picture using the specified
  // Series axes as boundaries. When the axis are zoomed or scrolled,
  // the picture will follow the new boundaries.
  TChartImageTool=class(TTeeCustomToolSeries)
  private
    FPicture : TPicture;
    procedure SetPicture(const Value: TPicture);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    class function GetEditorClass: String; override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    class Function Description:String; override;
  published
    property Active;
    property Picture:TPicture read FPicture write SetPicture;
    property Series;
  end;

  // A Shape object (with Left and Top), publishing all properties.
  TTeeShapePosition=class(TTeeCustomShapePosition)
  published
    property Bevel;
    property BevelWidth;
    property Brush;
    property Color;
    property CustomPosition;
    property Font;
    property Frame;
    property Gradient;
    property Left;
    property Shadow;
    property ShapeStyle;
    property Top;
    property Transparency;
    property Transparent;
    property Visible default True;
  end;

  TAnnotationTool=class;

  TAnnotationPosition=(ppLeftTop,ppLeftBottom,ppRightTop,ppRightBottom);

  TAnnotationClick=procedure( Sender:TAnnotationTool;
			 Button:TMouseButton;
			 Shift: TShiftState;
			 X, Y: Integer) of object;

  TAnnotationCallout=class(TCallout)
  private
    FX : Integer;
    FY : Integer;
    FZ : Integer;

    Function CloserPoint(const R:TRect; const P:TPoint):TPoint;
    procedure SetX(const Value:Integer);
    procedure SetY(const Value:Integer);
    procedure SetZ(const Value:Integer);
  public
    constructor Create(AOwner: TChartSeries);
    Procedure Assign(Source:TPersistent); override;
  published
    property Visible default False;
    property XPosition:Integer read FX write SetX default 0;
    property YPosition:Integer read FY write SetY default 0;
    property ZPosition:Integer read FZ write SetZ default 0;
  end;

  // Annotation tool, use it to display text anywhere on the chart.
  TAnnotationTool=class(TTeeCustomTool)
  private
    FCallout   : TAnnotationCallout;
    FCursor    : TCursor;
    FOnClick   : TAnnotationClick;  // 5.03
    FPosition  : TAnnotationPosition;
    FShape     : TTeeShapePosition;
    FText      : String;
    FTextAlign : TAlignment;

    procedure SetPosition(const Value: TAnnotationPosition);
    procedure SetShape(const Value: TTeeShapePosition);
    procedure SetTextAlign(const Value: TAlignment);
    procedure SetCallout(const Value: TAnnotationCallout);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure DrawText;
    class Function GetEditorClass:String; override;
    Function GetText:String; virtual;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    Procedure SetText(Const Value:String);
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    Function Clicked(x,y:Integer):Boolean;
    class Function Description:String; override;
  published
    property Active;
    property Callout:TAnnotationCallout read FCallout write SetCallout;
    property Cursor:TCursor read FCursor write FCursor default crDefault;
    property Position:TAnnotationPosition read FPosition write SetPosition
              default ppLeftTop;
    property Shape:TTeeShapePosition read FShape write SetShape;
    property Text:String read FText write SetText;
    property TextAlignment:TAlignment read FTextAlign
                                      write SetTextAlign default taLeftJustify;

    property OnClick:TAnnotationClick read FOnClick write FOnClick; // 5.03
  end;

  TSeriesAnimationTool=class;

  TSeriesAnimationStep=procedure(Sender:TSeriesAnimationTool; Step:Integer) of object;

  TSeriesAnimationTool=class(TTeeCustomToolSeries)
  private
    FBackup     : TChartSeries;
    FDrawEvery  : Integer;
    FStartValue : Double;
    FSteps      : Integer;
    FStartAtMin : Boolean;
    { events }
    FOnStep     : TSeriesAnimationStep;

    { internal }
    IStop       : Boolean;
  protected
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    procedure Execute; virtual;
  published
    property DrawEvery:Integer read FDrawEvery write FDrawEvery default 0;
    property Series;
    property StartAtMin:Boolean read FStartAtMin write FStartAtMin default True;
    property StartValue:Double read FStartValue write FStartValue;
    property Steps:Integer read FSteps write FSteps default 100;
    { events }
    property OnStep:TSeriesAnimationStep read FOnStep write FOnStep;
  end;

implementation

Uses {$IFDEF CLX}
     QForms,
     {$ELSE}
     Forms,
     {$ENDIF}
     Math, TeeConst, TeeProCo;

{ TCursorTool }
Constructor TCursorTool.Create(AOwner:TComponent);
begin
  inherited;
  FStyle:=cssBoth;
  IPoint.X:=-1;
  IPoint.Y:=-1;
end;

Procedure TCursorTool.CalcValuePositions(X,Y:Integer);
begin
  Case IDragging of
    ccVertical  : IXValue:=GetHorizAxis.CalcPosPoint(X);
    ccHorizontal: IYValue:=GetVertAxis.CalcPosPoint(Y);
  else
  begin
    IXValue:=GetHorizAxis.CalcPosPoint(X);
    IYValue:=GetVertAxis.CalcPosPoint(Y);
  end;
  end;
end;

Procedure TCursorTool.CalcScreenPositions;
var tmpSnap : Integer;
begin
  if (IPoint.X=-1) or (IPoint.Y=-1) then
  begin
    With GetHorizAxis do IPoint.X:=(IStartPos+IEndPos) div 2;
    With GetVertAxis do IPoint.Y:=(IStartPos+IEndPos) div 2;
    CalcValuePositions(IPoint.X,IPoint.Y);
    tmpSnap:=SnapToPoint;
    CalcScreenPositions;
    Changed(tmpSnap);
  end
  else
  begin
    IPoint.X:=GetHorizAxis.CalcPosValue(IXValue);
    IPoint.Y:=GetVertAxis.CalcPosValue(IYValue);
  end;
end;

Procedure TCursorTool.Changed(SnapPoint:Integer);
begin
  if Assigned(FOnChange) then
     FOnChange(Self,IPoint.X,IPoint.Y,IXValue,IYValue,Series,SnapPoint);
end;

class Function TCursorTool.GetEditorClass:String;
begin
  result:='TCursorToolEditor';
end;

class Function TCursorTool.Description:String;
begin
  result:=TeeMsg_CursorTool;
end;

Function TeeGetFirstLastSeries(Series:TChartSeries;
                               Var AMin,AMax:Integer):Boolean; { 5.01 }
begin
  AMin:=Series.FirstValueIndex;
  if AMin<0 then AMin:=0;

  AMax:=Series.LastValueIndex;
  if AMax<0 then AMax:=Series.Count-1
  else
  if AMax>=Series.Count then AMax:=Series.Count-1; { 5.03 }

  result:=(Series.Count>0) and (AMin<=Series.Count) and (AMax<=Series.Count);
end;

Function TCursorTool.NearestPoint(AStyle:TCursorToolStyle;
                                  Var Difference:Double):Integer;
var t      : Integer;
    tmpDif : Double;
    tmpMin : Integer;
    tmpMax : Integer;
begin
  result:=-1;
  Difference:=-1;

  if TeeGetFirstLastSeries(Series,tmpMin,tmpMax) then
  for t:=tmpMin to tmpMax do
  begin
    With Series do
    Case AStyle of
      cssHorizontal: tmpDif:=Abs(IYValue-YValues.Value[t]);
      cssVertical  : tmpDif:=Abs(IXValue-XValues.Value[t]);
    else
      tmpDif:=Sqrt(Sqr(IXValue-XValues.Value[t])+Sqr(IYValue-YValues.Value[t]));
    end;

    if (Difference=-1) or (tmpDif<Difference) then
    begin
      Difference:=tmpDif;
      result:=t;
    end;
  end;
end;

Function TCursorTool.SnapToPoint:Integer;
var Difference : Double;
begin
  if Assigned(Series) and FSnap then result:=NearestPoint(FStyle,Difference)
                                else result:=-1;
  if result<>-1 then
  Case FStyle of
    cssHorizontal: IYValue:=Series.YValues.Value[result];
    cssVertical  : IXValue:=Series.XValues.Value[result];
  else
    begin
      IXValue:=Series.XValues.Value[result];
      IYValue:=Series.YValues.Value[result]
    end;
  end;
end;

Function TCursorTool.GetAxisRect:TRect;
begin
  if UseChartRect then result:=ParentChart.ChartRect
  else
  begin
    With GetHorizAxis do
    begin
      result.Left:=IStartPos;
      result.Right:=IEndPos;
    end;
    With GetVertAxis do
    begin
      result.Top:=IStartPos;
      result.Bottom:=IEndPos;
    end;
    if Assigned(FOnGetAxisRect) then FOnGetAxisRect(Self,result);
  end;
end;

procedure TCursorTool.RedrawCursor;

  Procedure DrawCursorLines(Draw3D:Boolean; Const R:TRect; X,Y:Integer);

    Procedure DrawHorizontal;
    begin
      With ParentChart.Canvas do
      if Draw3D then HorizLine3D(R.Left,R.Right,Y,0)
                else DoHorizLine(R.Left,R.Right,Y);
    end;

    Procedure DrawVertical;
    begin
      With ParentChart.Canvas do
      if Draw3D then VertLine3D(X,R.Top,R.Bottom,0)
                else DoVertLine(X,R.Top,R.Bottom);
    end;

  begin
    Case FStyle of
      cssHorizontal: DrawHorizontal;
      cssVertical  : DrawVertical;
    else
    begin
      DrawHorizontal;
      DrawVertical;
    end;
    end;
  end;

var tmpColor : TColor;
begin
  if Assigned(ParentChart) then
  begin
    tmpColor:=ParentChart.Color;
    if tmpColor=clTeeColor then tmpColor:=clBtnFace;
    With ParentChart.Canvas do
    begin
      AssignVisiblePenColor(Self.Pen,Self.Pen.Color xor ColorToRGB(tmpColor));
      Brush.Style:=bsClear;
      Pen.Mode:=pmXor;
      DrawCursorLines(ParentChart.View3D,GetAxisRect,IPoint.X,IPoint.Y);
      Pen.Mode:=pmCopy;
      ParentChart.Canvas.Invalidate;
    end;
  end;
end;

Procedure TCursorTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       Button:TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);

  Procedure MouseMove;
  var tmpSnap : Integer;
      tmp     : TCursorClicked;
  begin
    { if mouse button is pressed and dragging then... }
    if ((IDragging<>ccNone) or FollowMouse) and
       PointInRect(GetAxisRect,X,Y) then
    begin
      RedrawCursor;      { hide the cursor }
      CalcValuePositions(X,Y);
      tmpSnap:=SnapToPoint;  { snap to the nearest point of SnapSeries }
      { draw again the cursor at the new position }
      CalcScreenPositions;
      RedrawCursor;
      Changed(tmpSnap);
    end
    else
    begin  { mouse button is not pressed, user is not dragging the cursor }
           { change the mouse cursor when passing over the Cursor }
      tmp:=Clicked(x,y);
      case tmp of
         ccHorizontal : ParentChart.Cursor:=crVSplit;
         ccVertical   : ParentChart.Cursor:=crHSplit;
         ccBoth       : ParentChart.Cursor:=crSizeAll;
      end;
      ParentChart.CancelMouse:=tmp<>ccNone;
    end;
  end;

begin
  Case AEvent of
      cmeUp: IDragging:=ccNone;
    cmeMove: MouseMove;
    cmeDown: if not FFollowMouse then
             begin
               IDragging:=Clicked(x,y);
               if IDragging<>ccNone then ParentChart.CancelMouse:=True;
             end;
  end;
end;

Function TCursorTool.Clicked(x,y:Integer):TCursorClicked;
begin
  result:=ccNone;
  if PointInRect(GetAxisRect,x,y) then
  begin
    if (FStyle=cssBoth) and (Abs(Y-IPoint.Y)<TeeClickTolerance)
                        and (Abs(X-IPoint.X)<TeeClickTolerance) then
       result:=ccBoth
    else
    if ((FStyle=cssHorizontal) or (FStyle=cssBoth))
            and (Abs(Y-IPoint.Y)<TeeClickTolerance) then
       result:=ccHorizontal
    else
    if ((FStyle=cssVertical) or (FStyle=cssBoth))
            and (Abs(X-IPoint.X)<TeeClickTolerance) then
       result:=ccVertical
  end;
end;

Procedure TCursorTool.SetStyle(Value:TCursorToolStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    SnapToPoint;
    Repaint;
  end;
end;

procedure TCursorTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  if Assigned(Series) and (not (csLoading in ComponentState)) then
  begin
    if Active then RedrawCursor;
    SnapToPoint;
    CalcScreenPositions;
    if Active then RedrawCursor;
  end;
end;

procedure TCursorTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if (AEvent=cteAfterDraw) then
  begin
    CalcScreenPositions;
    RedrawCursor;
  end;
end;

procedure TCursorTool.SetXValue(const Value: Double);
begin
  if IXValue<>Value then
  begin
    IXValue:=Value;
    CalcScreenPositions;
    Repaint;
  end;
end;

procedure TCursorTool.SetYValue(const Value: Double);
begin
  if IYValue<>Value then
  begin
    IYValue:=Value;
    CalcScreenPositions;
    Repaint;
  end;
end;

procedure TCursorTool.SetUseChartRect(const Value: Boolean);
begin
  SetBooleanProperty(FUseChartRect,Value);
end;

{ TDragMarksTool }
class function TDragMarksTool.Description: String;
begin
  result:=TeeMsg_DragMarksTool;
end;

Procedure TDragMarksTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       Button:TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);

  Procedure MouseMove;

    Procedure CheckCursor;

      Function CheckCursorSeries(ASeries:TChartSeries):Boolean;
      begin
        result:=ASeries.Active and ASeries.Marks.Visible and
                (ASeries.Marks.Clicked(x,y)<>-1);
      end;

    var tmp : Boolean;
        t   : Integer;
    begin
      tmp:=False;
      if Assigned(Series) then tmp:=CheckCursorSeries(Series)
      else
      With ParentChart do
      for t:=SeriesCount-1 downto 0 do
      begin
        tmp:=CheckCursorSeries(Series[t]);
        if tmp then break;
      end;
      if tmp then
      begin
        ParentChart.Cursor:=crHandPoint;
        ParentChart.CancelMouse:=True;
      end;
    end;

  var DifX : Integer;
      DifY : Integer;
  begin
    if not Assigned(IPosition) then CheckCursor
    else
    With IPosition do
    begin
      DifX:=X-IOldX;
      DifY:=Y-IOldY;
      Custom:=True;
      Inc(LeftTop.X,DifX);
      Inc(LeftTop.Y,DifY);
      Inc(ArrowTo.X,DifX);
      Inc(ArrowTo.Y,DifY);
      IOldX:=X;
      IOldY:=Y;
      ParentChart.CancelMouse:=True;
      Repaint;
    end;
  end;

  Procedure MouseDown;

    Function CheckSeries(ASeries:TChartSeries):Integer;
    begin
      result:=-1;
      if ASeries.Active then
      begin
        result:=ASeries.Marks.Clicked(x,y);
        if result<>-1 then
        begin
          ISeries:=ASeries;
          IPosition:=ISeries.Marks.Positions.Position[result];
          Exit;
        end;
      end;
    end;

  var t : Integer;
  begin
    if Assigned(Series) then CheckSeries(Series)
    else
    With ParentChart do
    for t:=SeriesCount-1 downto 0 do
        if CheckSeries(Series[t])<>-1 then break;

    if Assigned(IPosition) then
    begin
      IOldX:=X;
      IOldY:=Y;
    end;
  end;

begin
  Case AEvent of
    cmeUp  : IPosition:=nil;
    cmeDown: begin
               MouseDown;
               if Assigned(IPosition) then ParentChart.CancelMouse:=True;
             end;
    cmeMove: MouseMove;
  end;
end;

class function TDragMarksTool.GetEditorClass: String;
begin
  result:='TDragMarksToolEditor';
end;

{ TAxisArrowTool }
Constructor TAxisArrowTool.Create(AOwner: TComponent);
begin
  inherited;
  FLength:=16;
  FPosition:=aaBoth;
  FScrollPercent:=10;
end;

procedure TAxisArrowTool.ChartEvent(AEvent: TChartToolEvent);
Var tmpZ : Integer;

  Procedure DrawArrow(APos,ALength:Integer);
  var P0 : TPoint;
      P1 : TPoint;
  begin
    With Axis do
    if Horizontal then
    begin
      P0:=TeePoint(APos+ALength,PosAxis);
      P1:=TeePoint(APos,PosAxis)
    end
    else
    begin
      P0:=TeePoint(PosAxis,APos+ALength);
      P1:=TeePoint(PosAxis,APos);
    end;
    ParentChart.Canvas.Arrow(True,P0,P1,8,8,tmpZ);
  end;

begin
  inherited;
  if (AEvent=cteAfterDraw) and Assigned(Axis) then
  begin
    ParentChart.Canvas.AssignBrush(Self.Brush,Self.Brush.Color);
    ParentChart.Canvas.AssignVisiblePen(Self.Pen);
    if ParentChart.View3D and Axis.OtherSide then
       tmpZ:=ParentChart.Width3D
    else
       tmpZ:=0;
    if (FPosition=aaStart) or (FPosition=aaBoth) then
       DrawArrow(Axis.IStartPos,Length);
    if (FPosition=aaEnd) or (FPosition=aaBoth) then
       DrawArrow(Axis.IEndPos,-Length);
  end;
end;

class function TAxisArrowTool.Description: String;
begin
  result:=TeeMsg_AxisArrowTool;
end;

procedure TAxisArrowTool.SetLength(const Value: Integer);
begin
  SetIntegerProperty(FLength,Value);
end;

Function TAxisArrowTool.ClickedArrow(x,y:Integer):Integer;

  Procedure Check(Pos1,Pos2:Integer);
  begin
    { to-do: right/top axis Z ! } 
    With Axis do
    if (Abs(Pos1-PosAxis)<TeeClickTolerance) then
    begin
      if (FPosition=aaStart) or (FPosition=aaBoth) then
        if (Pos2>IStartPos) and (Pos2<IStartPos+Length) then
        begin
          result:=0;
          exit;
        end;
      if (FPosition=aaEnd) or (FPosition=aaBoth) then
        if (Pos2<IEndPos) and (Pos2>IEndPos-Length) then
        begin
          result:=1;
          exit;
        end;
    end;
  end;

begin
  result:=-1;
  if Axis.Horizontal then Check(y,x) else Check(x,y);
end;

Procedure TAxisArrowTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       Button:TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);

  Procedure DoScroll(const ADelta:Double);

    // Returns True when there is at least on series in the chart,
    // that has "both" axis associated (left and right, or top and bottom).
    // The OtherAxis parameter returns the "other" axis (right axis if
    // series axis is left, left axis if series axis is right, and so on).
    Function AnySeriesBothAxis(Axis:TChartAxis; Var OtherAxis:TChartAxis):Boolean;
    var t : Integer;
    begin
      result:=False;
      for t:=0 to ParentChart.SeriesCount-1 do
      if ParentChart[t].AssociatedToAxis(Axis) then
      begin
        if Axis.Horizontal then
        begin
          if ParentChart[t].HorizAxis=aBothHorizAxis then
          begin
            if Axis=ParentChart.TopAxis then OtherAxis:=ParentChart.BottomAxis
                                        else OtherAxis:=ParentChart.TopAxis;
            result:=True;
          end;
        end
        else
        begin
          if ParentChart[t].VertAxis=aBothVertAxis then
          begin
            if Axis=ParentChart.LeftAxis then OtherAxis:=ParentChart.RightAxis
                                         else OtherAxis:=ParentChart.LeftAxis;
            result:=True;
          end;
        end;
      end;
    end;

  var tmp      : Boolean;
      tmpMin   : Double;
      tmpMax   : Double;
      tmpAxis2 : TChartAxis;
  begin
    tmp:=True;
    if Assigned(TCustomChart(ParentChart).OnAllowScroll) then
    begin
      tmpMin:=Axis.Minimum+ADelta;
      tmpMax:=Axis.Maximum+ADelta;
      TCustomChart(ParentChart).OnAllowScroll(Axis,tmpMin,tmpMax,tmp);
    end;

    if tmp then
    begin
      Axis.Scroll(ADelta,False);

      if AnySeriesBothAxis(Axis,tmpAxis2) then
         tmpAxis2.Scroll(ADelta,False);

      With TCustomChart(Axis.ParentChart) do
        if Assigned(OnScroll) then OnScroll(Axis.ParentChart); { 5.01 }
    end;
  end;

var tmp   : Integer;
    Delta : Double;
begin
  if Assigned(Axis) and Axis.Visible then
  Case AEvent of
    cmeDown: if ScrollPercent<>0 then
             With Axis do
             begin
               tmp:=ClickedArrow(x,y);
               Delta:=(Maximum-Minimum)*ScrollPercent/100.0;  // 5.02
               if ScrollInverted then Delta:=-Delta; // 5.02
               if tmp=0 then DoScroll(Delta)
               else
               if tmp=1 then DoScroll(-Delta);
               if (tmp=0) or (tmp=1) then ParentChart.CancelMouse:=True;

               if Assigned(FOnClick) and (tmp<>-1) then
                  FOnClick(Self,tmp=0); // 6.0
             end;
    cmeMove: begin
               if ClickedArrow(x,y)<>-1 then
               begin
                 ParentChart.Cursor:=crHandPoint;
                 ParentChart.CancelMouse:=True;
               end;
             end;
  end;
end;

class function TAxisArrowTool.GetEditorClass: String;
begin
  result:='TAxisArrowToolEditor';
end;

procedure TAxisArrowTool.SetPosition(const Value: TAxisArrowToolPosition);
begin
  if FPosition<>Value then
  begin
    FPosition:=Value;
    Repaint;
  end;
end;

{ TDrawLine }
Function TDrawLine.StartHandle:TRect;
begin
  With Parent.AxisPoint(StartPos) do result:=TeeRect(X-3,Y-3,X+3,Y+3);
end;

Function TDrawLine.EndHandle:TRect;
begin
  With Parent.AxisPoint(EndPos) do result:=TeeRect(X-3,Y-3,X+3,Y+3);
end;

Procedure TDrawLine.DrawHandles;
begin
  With Parent.ParentChart.Canvas do
  begin
    Brush.Style:=bsSolid;
    if Parent.ParentChart.Color=clBlack then Brush.Color:=clSilver
                                        else Brush.Color:=clBlack;
    Pen.Style:=psClear;
    RectangleWithZ(StartHandle,0);
    RectangleWithZ(EndHandle,0);
  end;
end;

{ TDrawLines }
function TDrawLines.Get(Index: Integer): TDrawLine;
begin
  result:=TDrawLine(inherited Items[Index]);
end;

function TDrawLines.Last: TDrawLine;
begin
  if Count=0 then result:=nil else result:=Get(Count-1);
end;

procedure TDrawLines.Put(Index: Integer; const Value: TDrawLine);
begin
  Items[Index].Assign(Value);
end;

{ TDrawLine }
Constructor TDrawLine.CreateXY(Collection:TCollection; const X0, Y0, X1, Y1: Double);
begin
  Create(Collection);
  StartPos.X:=X0;
  StartPos.Y:=Y0;
  EndPos.X:=X1;
  EndPos.Y:=Y1;
end;

Destructor TDrawLine.Destroy;  { 5.02 }
begin
  if Self=Parent.ISelected then Parent.ISelected:=nil;
  inherited;
end;

function TDrawLine.GetPen: TChartPen;
begin
  result:=Parent.Pen;
end;

procedure TDrawLine.Assign(Source: TPersistent);
begin
  if Source is TDrawLine then
  With TDrawLine(Source) do
  Begin
    Self.StartPos :=StartPos;
    Self.EndPos   :=EndPos;
    Self.FStyle   :=FStyle;
  end
  else inherited;
end;

type TOwnedCollectionAccess=class(TOwnedCollection);

function TDrawLine.GetParent: TDrawLineTool;
begin
  result:=TDrawLineTool(TOwnedCollectionAccess(Collection).GetOwner);
end;

function TDrawLine.GetX0: Double;
begin
  result:=StartPos.X;
end;

function TDrawLine.GetX1: Double;
begin
  result:=EndPos.X;
end;

function TDrawLine.GetY0: Double;
begin
  result:=StartPos.Y;
end;

function TDrawLine.GetY1: Double;
begin
  result:=EndPos.Y;
end;

Procedure TDrawLine.SetStyle(Value:TDrawLineStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Parent.Repaint;
  end;
end;

procedure TDrawLine.SetX0(const Value: Double);
begin
  Parent.SetDoubleProperty(StartPos.X,Value);
end;

procedure TDrawLine.SetX1(const Value: Double);
begin
  Parent.SetDoubleProperty(EndPos.X,Value);
end;

procedure TDrawLine.SetY0(const Value: Double);
begin
  Parent.SetDoubleProperty(StartPos.Y,Value);
end;

procedure TDrawLine.SetY1(const Value: Double);
begin
  Parent.SetDoubleProperty(EndPos.Y,Value);
end;

{ TDrawLineTool }
Constructor TDrawLineTool.Create(AOwner: TComponent);
begin
  inherited;
  FButton:=mbLeft;
  FLines:=TDrawLines.Create(Self,TDrawLine);
  FEnableDraw:=True;
  FEnableSelect:=True;
  ISelected:=nil;
  IHandle:=chNone;
end;

Destructor TDrawLineTool.Destroy;
begin
  ISelected:=nil;
  FLines.Free;
  inherited;
end;

Procedure TDrawLineTool.DrawLine( Const StartPos,EndPos:TPoint;
                                  AStyle:TDrawLineStyle);
begin
  With ParentChart.Canvas do
  if ParentChart.View3D then
  begin
    Case AStyle of
          dlLine: begin
                    MoveTo3D(StartPos.X,StartPos.Y,0);
                    LineTo3D(EndPos.X,EndPos.Y,0);
                  end;
 dlHorizParallel: begin
                    HorizLine3D(StartPos.X,EndPos.X,StartPos.Y,0);
                    HorizLine3D(StartPos.X,EndPos.X,EndPos.Y,0);
                  end;
    else
      begin
        VertLine3D(StartPos.X,StartPos.Y,EndPos.Y,0);
        VertLine3D(EndPos.X,StartPos.Y,EndPos.Y,0);
      end
    end;
  end
  else
  Case AStyle of
          dlLine: Line(StartPos.X,StartPos.Y,EndPos.X,EndPos.Y);
 dlHorizParallel: begin
                    DoHorizLine(StartPos.X,EndPos.X,StartPos.Y);
                    DoHorizLine(StartPos.X,EndPos.X,EndPos.Y);
                  end;
  else
    begin
      DoVertLine(StartPos.X,StartPos.Y,EndPos.Y);
      DoVertLine(EndPos.X,StartPos.Y,EndPos.Y);
    end
  end;
end;

procedure TDrawLineTool.ChartEvent(AEvent: TChartToolEvent);
var t : Integer;
begin
  inherited;
  if (AEvent=cteAfterDraw) and (Lines.Count>0) then
  begin
    with ParentChart do
    begin
      Canvas.BackMode:=cbmTransparent;
      ClipDrawingRegion;
    end;
    for t:=0 to Lines.Count-1 do
    With Lines[t] do
    begin
      ParentChart.Canvas.AssignVisiblePen(Pen);
      DrawLine(AxisPoint(StartPos),AxisPoint(EndPos),Style);
    end;
    if Assigned(ISelected) then ISelected.DrawHandles;
    ParentChart.Canvas.UnClipRectangle;
  end;
end;

Procedure TDrawLineTool.ClipDrawingRegion;
var R : TRect;
begin
  if Assigned(Series) then
  With Series do
     R:=TeeRect(GetHorizAxis.IStartPos,GetVertAxis.IStartPos,
                GetHorizAxis.IEndPos,GetVertAxis.IEndPos)
  else
     R:=ParentChart.ChartRect;
  With ParentChart do
  if CanClip then Canvas.ClipCube(R,0,Width3D);
end;

Function TDrawLineTool.InternalClicked(X,Y:Integer; AHandle:TDrawLineHandle):TDrawLine;
var P : TPoint;

  Function ClickedLine(ALine:TDrawLine):Boolean;
  var tmpStart : TPoint;
      tmpEnd   : TPoint;
  begin
    With ALine do
    begin
      tmpStart:=AxisPoint(StartPos);
      tmpEnd:=AxisPoint(EndPos);
      Case AHandle of
        chStart: result:=PointInRect(StartHandle,P.X,P.Y);
        chEnd  : result:=PointInRect(EndHandle,P.X,P.Y);
      else
        Case Style of
          dlLine  : result:=PointInLine(P,tmpStart,tmpEnd,4);
  dlHorizParallel : begin
                      result:=PointInLine(P,tmpStart.X,tmpStart.Y,
                                                    tmpEnd.X,tmpStart.Y,4);
                      if not result then
                         result:=PointInLine( P,tmpStart.X,tmpEnd.Y,
                                                tmpEnd.X,tmpEnd.Y,4);
                    end;
        else
          begin
            result:=PointInLine( P,tmpStart.X,tmpStart.Y,
                                   tmpStart.X,tmpEnd.Y,4);
            if not result then
               result:=PointInLine( P,tmpEnd.X,tmpStart.Y,
                                      tmpEnd.X,tmpEnd.Y,4);
          end
        end;
      end;
    end;
  end;

var t : Integer;
begin
  result:=nil;

  // convert from 3D to 2D...
  ParentChart.Canvas.Calculate2DPosition(X,Y,0);

  // first, find if clicked the selected line...
  P:=TeePoint(X,Y);
  if Assigned(ISelected) and ClickedLine(ISelected) then
  begin
    result:=ISelected;
    exit;
  end;

  // find which clicked line...
  for t:=0 to Lines.Count-1 do
      if ClickedLine(Lines[t]) then
      begin
        result:=Lines[t];
        break;
      end;
end;

Function TDrawLineTool.Clicked(X,Y:Integer):TDrawLine;
begin
  // try first with whole line...
  result:=InternalClicked(X,Y,chNone);
  // try then at start and end line points...
  if not Assigned(result) then result:=InternalClicked(X,Y,chStart);
  if not Assigned(result) then result:=InternalClicked(X,Y,chEnd);
end;

Procedure TDrawLineTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       AButton:TMouseButton;
                                       AShift: TShiftState; X, Y: Integer);

  { returns True if the mouse is over selected line ending points or over
    any non-selected line.
    If True, the Chart cursor is changed.
  }
  Function CheckCursor:Boolean;
  begin
    if Assigned(ISelected) and
       ((InternalClicked(X,Y,chStart)=ISelected) or
        (InternalClicked(X,Y,chEnd)=ISelected)) then { ending points }
    begin
      ParentChart.Cursor:=crCross;
      result:=True;
    end
    else
    if Assigned(Clicked(X,Y)) then { over a line }
    begin
      ParentChart.Cursor:=crHandPoint;  // set cursor
      result:=True;
    end
    else result:=False;
  end;

var tmpLine  : TDrawLine;
    tmpAllow : Boolean;
begin
  Case AEvent of
    cmeDown: if AButton=FButton then
             begin
               if FEnableSelect then tmpLine:=Clicked(X,Y)
                                else tmpLine:=nil;

               if Assigned(tmpLine) then { clicked line, do select }
               begin
                 FromPoint:=AxisPoint(tmpLine.StartPos);
                 ToPoint:=AxisPoint(tmpLine.EndPos);
                 IHandle:=chSeries;
                 IPoint:=TeePoint(X,Y);
                 if tmpLine<>ISelected then
                 begin
                   tmpAllow:=True;
                   if Assigned(FOnSelecting) then
                      FOnSelecting(Self,tmpLine,tmpAllow); { 5.03 }

                   if tmpAllow then
                   begin
                     { change selected line }
                     if Assigned(ISelected) then
                     begin
                       ISelected:=tmpLine;
                       Repaint;
                     end
                     else
                     begin
                       ISelected:=tmpLine;
                       ISelected.DrawHandles;
                     end;
                     { call event }
                     if Assigned(FOnSelect) then FOnSelect(Self);
                   end;
                 end
                 else
                 begin
                   { check if clicked on ending points }
                   if Assigned(InternalClicked(X,Y,chStart)) then
                      IHandle:=chStart
                   else
                   if Assigned(InternalClicked(X,Y,chEnd)) then
                      IHandle:=chEnd;
                 end;
                 ParentChart.CancelMouse:=True;
               end
               else
               begin
                 { un-select }
                 ISelected:=nil;
                 if EnableDraw then
                 begin
                   IDrawing:=True;
                   FromPoint:=TeePoint(X,Y);
                   ToPoint:=FromPoint;
                   RedrawLine(ISelected);
                   ParentChart.CancelMouse:=True;
                 end;
               end;
             end;
    cmeMove: if IDrawing or (IHandle<>chNone) then // drawing or dragging
             begin
               RedrawLine(ISelected); // hide previous line
               if IDrawing then ToPoint:=TeePoint(X,Y)
               else
               begin
                 if IHandle=chStart then FromPoint:=TeePoint(X,Y)
                 else
                 if IHandle=chEnd then ToPoint:=TeePoint(X,Y)
                 else
                 if IHandle=chSeries then
                 begin
                   Inc(FromPoint.X,X-IPoint.X);
                   Inc(FromPoint.Y,Y-IPoint.Y);
                   Inc(ToPoint.X,X-IPoint.X);
                   Inc(ToPoint.Y,Y-IPoint.Y);
                   IPoint:=TeePoint(X,Y);
                 end;
               end;
               RedrawLine(ISelected);  // show line at new position
               ParentChart.CancelMouse:=True;

               // call event
               if Assigned(FOnDragLine) then FOnDragLine(Self);
             end
             else
             if FEnableSelect then { change the cursor if mouse is over lines }
                ParentChart.CancelMouse:=CheckCursor;

      cmeUp: if AButton=FButton then
             begin
               if IHandle<>chNone then  // if dragging...
               begin
                 if (IHandle=chStart) or (IHandle=chSeries) then
                    ISelected.StartPos:=ScreenPoint(FromPoint);
                 if (IHandle=chEnd) or (IHandle=chSeries) then
                    ISelected.EndPos:=ScreenPoint(ToPoint);
                 IHandle:=chNone;

                 // stop dragging, repaint
                 Repaint;

                 // call event
                 if Assigned(FOnDraggedLine) then FOnDraggedLine(Self); { 5.01 }
               end
               else
               if IDrawing then  // drawing a new line...
               begin
                 if (FromPoint.X<>ToPoint.X) or (FromPoint.Y<>ToPoint.Y) then
                 begin
                   // create the new drawn line...
                   with TeeDrawLineClass.Create(Lines) do // 5.02
                   begin
                     StartPos:=ScreenPoint(FromPoint);
                     EndPos  :=ScreenPoint(ToPoint);
                   end;

                   // repaint chart
                   Repaint;

                   // call event
                   if Assigned(FOnNewLine) then FOnNewLine(Self);
                 end;
                 IDrawing:=False;
               end;
             end;
  end;
end;

class function TDrawLineTool.Description: String;
begin
  result:=TeeMsg_DrawLineTool
end;

type TCustomTeePanelAccess=class(TCustomTeePanel);

procedure TDrawLineTool.RedrawLine(ALine:TDrawLine);
var tmp : TColor;
begin
  // draw current selected or dragged line with "not xor" pen mode
  With ParentChart.Canvas do
  begin
    tmp:=ColorToRGB(TCustomTeePanelAccess(ParentChart).GetBackColor);
    AssignVisiblePenColor(Self.Pen,(clWhite-tmp) xor Self.Pen.Color);
    Pen.Mode:=pmNotXor;
    if Assigned(ALine) then
       DrawLine(FromPoint,ToPoint,ALine.Style)
    else
       DrawLine(FromPoint,ToPoint,dlLine);
    Pen.Mode:=pmCopy;
  end;
end;

class function TDrawLineTool.GetEditorClass: String;
begin
  result:='TDrawLineEdit';
end;

function TDrawLineTool.AxisPoint(const P: TFloatPoint): TPoint;
begin
  // convert from axis double XY to screen pixels XY
  result.X:=GetHorizAxis.CalcPosValue(P.X);
  result.Y:=GetVertAxis.CalcPosValue(P.Y);
end;

function TDrawLineTool.ScreenPoint(P: TPoint): TFloatPoint;
begin
  // convert from screen pixels XY position to axis double XY
  result.X:=GetHorizAxis.CalcPosPoint(P.X);
  result.Y:=GetVertAxis.CalcPosPoint(P.Y);
end;

procedure TDrawLineTool.SetEnableSelect(Value: Boolean);
begin
  if FEnableSelect<>Value then
  begin
    FEnableSelect:=Value;
    if not FEnableSelect then
    begin
      if Assigned(ISelected) then
      begin
        ISelected:=nil;
        Repaint;
      end;
    end;
  end;
end;

procedure TDrawLineTool.DeleteSelected;
begin
  if Assigned(ISelected) then
  begin
    IDrawing:=False; // 5.02
    IHandle:=chNone; // 5.02
    FreeAndNil(ISelected);
    Repaint;
  end;
end;

procedure TDrawLineTool.SetSelected(Value: TDrawLine);
begin
  ISelected:=Value;
  Repaint;
end;

procedure TDrawLineTool.SetLines(const Value: TDrawLines);
begin
  FLines.Assign(Value);
end;

{ TNearestTool }
Constructor TNearestTool.Create(AOwner: TComponent);
begin
  inherited;
  Point:=-1;
  FullRepaint:=True;
  Brush.Style:=bsClear;
  Pen.Style:=psDot;
  Pen.Color:=clWhite;
  FSize:=20;
  FDrawLine:=True;
  FStyle:=hsCircle;
end;

procedure TNearestTool.PaintHint;
var x : Integer;
    y : Integer;
    R : TRect;
    P : TFourPoints;
begin
  if Assigned(Series) and (Point<>-1) and (Series.Count>Point) then  // 6.01
  With ParentChart.Canvas do
  begin
    AssignVisiblePen(Self.Pen);
    if not FullRepaint then Pen.Mode:=pmNotXor;

    x:=Series.CalcXPos(Point);
    y:=Series.CalcYPos(Point);

    if Self.Style<>hsNone then
    begin
      AssignBrush(Self.Brush,clBlack);
      Case Self.Style of
        hsCircle: if ParentChart.View3D then
                     EllipseWithZ(x-FSize,y-FSize,x+FSize,y+FSize,Series.StartZ)
                  else
                     Ellipse(x-FSize,y-FSize,x+FSize,y+FSize);
     hsRectangle: begin
                    R:=TeeRect(x-FSize,y-FSize,x+FSize,y+FSize);
                    if ParentChart.View3D then RectangleWithZ(R,Series.StartZ)
                                          else Rectangle(R);
                  end;
       hsDiamond: begin
                    P[0]:=TeePoint(x,y-FSize);
                    P[1]:=TeePoint(x+FSize,y);
                    P[2]:=TeePoint(x,y+FSize);
                    P[3]:=TeePoint(x-FSize,y);
                    PolygonWithZ(P,Series.StartZ);
                  end;
      end;
    end;

    if FDrawLine then
    begin
      Pen.Style:=psSolid;
      MoveTo(IMouse.X,IMouse.Y);
      LineTo(x,y);
    end;
    if not FullRepaint then Pen.Mode:=pmCopy;
  end;
end;

procedure TNearestTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  Function GetNearestPoint:Integer;
  var t      : Integer;
      Dif    : Integer;
      Dist   : Integer;
      tmpMin : Integer;
      tmpMax : Integer;
      tmpX   : Integer;
      tmpY   : Integer;
  begin
    result:=-1;
    Dif:=10000;

    if TeeGetFirstLastSeries(Series,tmpMin,tmpMax) then
    for t:=tmpMin to tmpMax do { <-- traverse all points in a Series... }
    begin
      { calculate position in pixels }
      tmpX:=Series.CalcXPos(t);
      tmpY:=Series.CalcYPos(t);

      if PointInRect(ParentChart.ChartRect,tmpX,tmpY) then { 5.01 }
      begin
        { calculate distance in pixels... }
        Dist:=Round(TeeDistance(X-tmpX,Y-tmpY));

        if Dist<Dif then { store if distance is lower... }
        begin
          Dif:=Dist;
          result:=t;  { <-- set this point to be the nearest... }
        end;
      end;
    end;
  end;

begin
  inherited;
  if (AEvent=cmeMove) and Assigned(Series) then
  begin
    if not FullRepaint then PaintHint;
    Point:=GetNearestPoint;
    IMouse:=TeePoint(x,y);
    if not FullRepaint then PaintHint;
    if Assigned(FOnChange) then FOnChange(Self);
    if FullRepaint then Repaint;
  end;
end;

procedure TNearestTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if AEvent=cteAfterDraw then PaintHint;
end;

class Function TNearestTool.Description:String;
begin
  result:=TeeMsg_NearestTool
end;

procedure TNearestTool.SetSize(const Value: Integer);
begin
  SetIntegerProperty(FSize,Value);
end;

class function TNearestTool.GetEditorClass: String;
begin
  result:='TNearestToolEdit';
end;

procedure TNearestTool.SetStyle(const Value: TNearestToolStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

{ TColorBandTool }
Constructor TColorBandTool.Create(AOwner: TComponent);
begin
  inherited;
  FGradient:=TChartGradient.Create(CanvasChanged);
  FColor:=clWhite;
  FDrawBehind:=True;
end;

destructor TColorBandTool.Destroy;
begin
  FGradient.Free;
  inherited;
end;

procedure TColorBandTool.PaintBand;
var R    : TRect;
    tmpR : TRect;
    tmp0 : Double;
    tmp1 : Double;
    tmpDraw : Boolean;
    tmpRectBlend : TRect;
    tmpZ         : Integer;
    tmpBlend     : TTeeBlend;
begin
  if Assigned(Axis) then
  begin
    R:=ParentChart.ChartRect;
    tmp0:=FStart;
    tmp1:=FEnd;

    With Axis do
    begin
      if Inverted then
      begin
        if tmp0<tmp1 then SwapDouble(tmp0,tmp1);
        tmpDraw:=(tmp1<=Maximum) and (tmp0>=Minimum);
      end
      else
      begin
        if tmp0>tmp1 then SwapDouble(tmp0,tmp1);
        tmpDraw:=(tmp0<=Maximum) and (tmp1>=Minimum);
      end;

      if tmpDraw then
      begin
        if DrawBehind then tmpZ:=ParentChart.Width3D else tmpZ:=0; // 5.03

        if Horizontal then
        begin
          R.Left:=Math.Max(IStartPos,CalcPosValue(tmp0));
          R.Right:=Math.Min(IEndPos,CalcPosValue(tmp1));
          if not Self.Pen.Visible then Inc(R.Right);
        end
        else
        begin
          R.Top:=Math.Max(IStartPos,CalcPosValue(tmp1));
          R.Bottom:=Math.Min(IEndPos,CalcPosValue(tmp0));
          Inc(R.Left);
          if not Self.Pen.Visible then
          begin
            Inc(R.Bottom);
            Inc(R.Right);
          end;
        end;
        With ParentChart,Canvas do
        begin
          AssignBrush(Self.Brush,Self.Color);
          AssignVisiblePen(Self.Pen);

          if Self.Gradient.Visible and View3DOptions.Orthogonal then
          begin
            tmpR:=R;
            Dec(tmpR.Right);
            Dec(tmpR.Bottom);
            Self.Gradient.Draw(Canvas,CalcRect3D(tmpR,tmpZ));
            Brush.Style:=bsClear;
          end;

          if Transparency=0 then
          begin
            if View3D then RectangleWithZ(R,tmpZ)
                      else Rectangle(R);
          end
          else
          begin
            if View3D then tmpRectBlend:=RectFromRectZ(R,tmpZ)
                      else tmpRectBlend:=R;

            tmpBlend:=ParentChart.Canvas.BeginBlending(tmpRectBlend,Transparency);
            if View3D then RectangleWithZ(R,tmpZ)
                      else Rectangle(R);
            ParentChart.Canvas.EndBlending(tmpBlend);
          end;
        end;
      end;
    end;
  end;
end;

procedure TColorBandTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if ((AEvent=cteBeforeDrawSeries) and DrawBehind) or
     ((AEvent=cteAfterDraw) and (not DrawBehind)) then PaintBand;
end;

class function TColorBandTool.Description: String;
begin
  result:=TeeMsg_ColorBandTool
end;

class function TColorBandTool.GetEditorClass: String;
begin
  result:='TColorBandToolEditor';
end;

procedure TColorBandTool.SetEnd(const Value: Double);
begin
  SetDoubleProperty(FEnd,Value);
end;

procedure TColorBandTool.SetStart(const Value: Double);
begin
  SetDoubleProperty(FStart,Value);
end;

procedure TColorBandTool.SetGradient(const Value: TChartGradient);
begin
  FGradient.Assign(Value);
end;

procedure TColorBandTool.SetColor(Value: TColor);
begin
  SetColorProperty(FColor,Value);
end;

procedure TColorBandTool.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TColorBandTool.SetDrawBehind(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehind,Value);
end;

{ TColorLineTool }
constructor TColorLineTool.Create(AOwner: TComponent);
begin
  inherited;
  FAllowDrag:=True;
  FDraw3D:=True;
end;

Function TColorLineTool.CalcValue:Double;
begin
  Case Self.FStyle of
    clMaximum: result:=Axis.Maximum;
    clCenter: result:=(Axis.Maximum+Axis.Minimum)*0.5;
    clMinimum: result:=Axis.Minimum;
  else
    result:=FValue;  // clCustom
  end;
end;

Function TColorLineTool.LimitValue(const AValue:Double):Double;
var tmpLimit : Double;
begin
  result:=AValue;

  { do not use Axis Minimum & Maximum, we need the
    "real" min and max }
  if Axis.Horizontal then
  begin
    tmpLimit:=Axis.CalcPosPoint(Axis.IStartPos);
    if result<tmpLimit then result:=tmpLimit
    else
    begin
      tmpLimit:=Axis.CalcPosPoint(Axis.IEndPos);
      if result>tmpLimit then result:=tmpLimit;
    end;
  end
  else
  begin
    tmpLimit:=Axis.CalcPosPoint(Axis.IEndPos);
    if result<tmpLimit then result:=tmpLimit
    else
    begin
      tmpLimit:=Axis.CalcPosPoint(Axis.IStartPos);
      if result>tmpLimit then result:=tmpLimit;
    end;
  end;
end;

Procedure TColorLineTool.DrawColorLine(Back:Boolean);
var tmp : Integer;
begin
  { check inside axis limits }
  if not NoLimitDrag then
     FValue:=LimitValue(FValue);

  tmp:=Axis.CalcPosValue(CalcValue);

  With ParentChart,Canvas do
  begin
    if Back then
    begin
      if Axis.Horizontal then
      begin
        if Draw3D then ZLine3D(tmp,ChartRect.Bottom,0,Width3D);
        if DrawBehind or Draw3D then
           VertLine3D(tmp,ChartRect.Top,ChartRect.Bottom,Width3D);
      end
      else
      begin
        if Draw3D then ZLine3D(ChartRect.Left,tmp,0,Width3D);
        if DrawBehind or Draw3D then
           HorizLine3D(ChartRect.Left,ChartRect.Right,tmp,Width3D);
      end;
    end
    else
    if View3D or ((not IDragging) or FDragRepaint) then
      if Axis.Horizontal then
      begin
        if Draw3D then ZLine3D(tmp,ChartRect.Top,0,Width3D);
        if not DrawBehind then
           VertLine3D(tmp,ChartRect.Top,ChartRect.Bottom,0);
      end
      else
      begin
        if Draw3D then ZLine3D(ChartRect.Right,tmp,0,Width3D);
        if not DrawBehind then
           HorizLine3D(ChartRect.Left,ChartRect.Right,tmp,0);
      end;
  end;
end;

procedure TColorLineTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if Assigned(Axis) and
     ((AEvent=cteBeforeDrawSeries) or (AEvent=cteAfterDraw)) then
  begin
    ParentChart.Canvas.AssignVisiblePen(Pen);
    ParentChart.Canvas.BackMode:=cbmTransparent;  // 5.03
    DrawColorLine(AEvent=cteBeforeDrawSeries);
  end;
end;

procedure TColorLineTool.DoEndDragLine;
begin
  if Assigned(FOnEndDragLine) then FOnEndDragLine(Self);
end;

procedure TColorLineTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp       : Integer;
    tmpNew    : Double;
    tmpDoDraw : Boolean;
begin
  tmpDoDraw:=False;
  if AllowDrag and Assigned(Axis) then
  Case AEvent of
      cmeUp: begin
               IDragging:=False;
               { force repaint }
               if not FDragRepaint then
                  Repaint;
               { call event }
               DoEndDragLine;
             end;
    cmeMove: if IDragging then
             begin
               if Axis.Horizontal then tmp:=x else tmp:=y;

               { calculate new position }
               tmpNew:=Axis.CalcPosPoint(tmp);

               { check inside axis limits }
               if not NoLimitDrag then
                  tmpNew:=LimitValue(tmpNew);

               if FDragRepaint then { 5.02 }
                  Value:=tmpNew { force repaint whole chart }
               else
               begin

                 tmpDoDraw:=CalcValue<>tmpNew;

                 if tmpDoDraw then
                 begin
                   { draw line in xor mode, to avoid repaint the whole chart }
                   with ParentChart.Canvas do
                   begin
                     AssignVisiblePen(Self.Pen);
                     Pen.Mode:=pmNotXor;
                   end;

                   { hide previous line }
                   DrawColorLine(True);
                   DrawColorLine(False);

                   { set new value }
                   FStyle:=clCustom;
                   FValue:=tmpNew;
                 end;
               end;

               ParentChart.CancelMouse:=True;

               { call event, allow event to change Value }
               if Assigned(FOnDragLine) then FOnDragLine(Self);

               if tmpDoDraw then { 5.02 }
               begin
                 { draw at new position }
                 DrawColorLine(True);
                 DrawColorLine(False);

                 { reset pen mode }
                 ParentChart.Canvas.Pen.Mode:=pmCopy;
               end;
             end
             else
             begin
               { is mouse on line? }
               if Clicked(x,y) then { 5.02 }
               begin
                 { show appropiate cursor }
                 if Axis.Horizontal then
                    ParentChart.Cursor:=crHSplit
                 else
                    ParentChart.Cursor:=crVSplit;
                 ParentChart.CancelMouse:=True;
               end;
             end;
    cmeDown: begin
               { is mouse over line ? }
               IDragging:=Clicked(x,y);
               ParentChart.CancelMouse:=IDragging;
             end;
  end;
end;

function TColorLineTool.Clicked(x, y: Integer): Boolean;
var tmp : Integer;
begin
  if Axis.Horizontal then tmp:=x else tmp:=y;
  result:=Abs(tmp-Axis.CalcPosValue(CalcValue))<TeeClickTolerance;
  if result then { 5.02 }
  with ParentChart do
     if Axis.Horizontal then
        result:=(y>=ChartRect.Top) and (y<=ChartRect.Bottom)
     else
        result:=(x>=ChartRect.Left) and (x<=ChartRect.Right)
end;

class function TColorLineTool.Description: String;
begin
  result:=TeeMsg_ColorLineTool;
end;

class function TColorLineTool.GetEditorClass: String;
begin
  result:='TColorLineToolEditor';
end;

procedure TColorLineTool.SetValue(const AValue: Double);
begin
  FStyle:=clCustom;

  if (not IDragging) or FDragRepaint then { 5.02 }
     SetDoubleProperty(FValue,AValue)
  else
     FValue:=AValue;
end;

procedure TColorLineTool.SetDraw3D(const Value: Boolean);
begin
  SetBooleanProperty(FDraw3D,Value);
end;

procedure TColorLineTool.SetDrawBehind(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehind,Value);
end;

procedure TColorLineTool.SetStyle(const Value: TColorLineStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

type TChartPenAccess=class(TChartPen);

{ TRotateTool }
constructor TRotateTool.Create(AOwner: TComponent);
begin
  inherited;
  FButton:=mbLeft;
  IDragging:=False;
  FInverted:=False;
  FStyle:=rsAll;

  Pen.Visible:=False;
  TChartPenAccess(Pen).DefaultVisible:=False;
  Pen.Mode:=pmXor;
  Pen.Color:=clWhite;
end;

class Function TRotateTool.RotationChange(FullRotation:Boolean; AAngle,AChange:Integer):Integer;
begin
  result:=AAngle;
  if AChange=0 then exit;

  if AChange>0 then
  begin
    Inc(result,AChange);
    if result>360 then
       Dec(result,360)
    else
    if (result<270) and (result>90) then result:=90;
  end
  else
  begin
    if FullRotation then
       result:=Math.Max(0,AAngle+AChange)
    else
    begin
      result:=AAngle+AChange;
      if result<0 then result:=360+result
                  else
                  if (result>90) and (result<270) then result:=270;
    end;
  end;
end;

class Function TRotateTool.ElevationChange(FullRotation:Boolean; AAngle,AChange:Integer):Integer;
var tmpMinAngle : Integer;
begin
  result:=AAngle;
  if AChange=0 then exit;

  if AChange>0 then
     result:=Math.Min(360,AAngle+AChange)
  else
  begin
    if FullRotation then tmpMinAngle:=0
                    else tmpMinAngle:=TeeMinAngle;
    result:=Math.Max(tmpMinAngle,AAngle+AChange);
  end;
end;

type TCanvasAccess=class(TTeeCanvas3D);

procedure TRotateTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);

  Procedure MouseMove;

    Function CorrectAngle(Const AAngle:Integer):Integer;
    begin
      result:=AAngle;
      if result>360 then result:=result-360 else
      if result<0 then result:=360+result;
    end;

    Procedure DrawCubeOutline;
    var w : Integer;
    begin
      with ParentChart.Canvas do
      begin
        Brush.Style:=bsClear;
        AssignVisiblePen(Self.Pen);

        w:=ParentChart.Width3D;

        RectangleWithZ(ParentChart.ChartRect,0);
        RectangleWithZ(ParentChart.ChartRect,w);

        with ParentChart.ChartRect do
        begin
          MoveTo3D(Left,Top,0);
          LineTo3D(Left,Top,W);
          MoveTo3D(Right,Top,0);
          LineTo3D(Right,Top,W);
          MoveTo3D(Left,Bottom,0);
          LineTo3D(Left,Bottom,W);
          MoveTo3D(Right,Bottom,0);
          LineTo3D(Right,Bottom,W);
        end;
      end;
    end;

  Var tmpX : Integer;
      tmpY : Integer;
  begin
    tmpX:=Round(90.0*(X-IOldX)/ParentChart.Width);
    if FInverted then tmpX:=-tmpX;
    tmpY:=Round(90.0*(IOldY-Y)/ParentChart.Height);
    if FInverted then tmpY:=-tmpY;

    if Pen.Visible then
    begin
      if IFirstTime then
      begin
        IOldRepaint:=ParentChart.AutoRepaint;
        ParentChart.AutoRepaint:=False;
        IFirstTime:=False;
      end
      else DrawCubeOutline;
    end;

    ParentChart.View3D:=True;

    With ParentChart.View3DOptions do
    begin
      Orthogonal:=False;

      if ParentChart.Canvas.SupportsFullRotation then
      begin
        if (FStyle=rsRotation) or (FStyle=rsAll) then
           Rotation:=CorrectAngle(Rotation+tmpX);

        if (FStyle=rsElevation) or (FStyle=rsAll) then
           Elevation:=CorrectAngle(Elevation+tmpY);
      end
      else
      begin
        if (FStyle=rsRotation) or (FStyle=rsAll) then
        begin
          // FirstSeriesPie
          Rotation:=RotationChange(ParentChart.Canvas.SupportsFullRotation,Rotation,tmpX);
        end;

        if (FStyle=rsElevation) or (FStyle=rsAll) then
           Elevation:=ElevationChange(ParentChart.Canvas.SupportsFullRotation,Elevation,tmpY);
      end;
    end;

    IOldX:=X;
    IOldY:=Y;
    ParentChart.CancelMouse:=True;

    if Pen.Visible then
    begin
      with TCanvasAccess(ParentChart.Canvas) do
      begin
        FIsOrthogonal:=False;  // 6.01
        CalcTrigValues;
        CalcPerspective(ParentChart.ChartRect);
      end;

      DrawCubeOutline;
    end;

    if Assigned(FOnRotate) then FOnRotate(Self);
  end;

begin
  inherited;
  Case AEvent of
      cmeUp: if IDragging then  // 6.01
             begin
               IDragging:=False;
               if Pen.Visible then
               begin
                 ParentChart.AutoRepaint:=IOldRepaint;
                 Repaint;
               end;
             end;
    cmeMove: if IDragging then MouseMove;
    cmeDown: if AButton=Self.Button then
             begin
               IDragging:=True;
               IOldX:=X;
               IOldY:=Y;
               IFirstTime:=True;
               ParentChart.CancelMouse:=True;
             end;
  end;
end;

class function TRotateTool.Description: String;
begin
  result:=TeeMsg_RotateTool;
end;

class function TRotateTool.GetEditorClass: String;
begin
  result:='TRotateToolEditor';
end;

{ TChartImageTool }
Constructor TChartImageTool.Create(AOwner: TComponent);
begin
  inherited;
  FPicture:=TPicture.Create;
  FPicture.OnChange:=CanvasChanged;
end;

Destructor TChartImageTool.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TChartImageTool.ChartEvent(AEvent: TChartToolEvent);
var R : TRect;
begin
  inherited;
  if (AEvent=cteBeforeDrawSeries) and Assigned(FPicture) then
  begin
    if Assigned(Series) then
    With Series do
    begin
      R.Left:=CalcXPosValue(MinXValue);
      R.Right:=CalcXPosValue(MaxXValue);
      R.Top:=CalcYPosValue(MaxYValue);
      R.Bottom:=CalcYPosValue(MinYValue);
    end
    else
    begin
      With GetHorizAxis do
      begin
        R.Left:=CalcPosValue(Minimum);
        R.Right:=CalcPosValue(Maximum);
      end;
      With GetVertAxis do
      begin
        R.Top:=CalcYPosValue(Maximum);
        R.Bottom:=CalcYPosValue(Minimum);
      end;
    end;

    With ParentChart,Canvas do
    begin
      if CanClip then ClipCube(ChartRect,0,Width3D);
      if View3D and (not View3DOptions.Orthogonal) then
         StretchDraw(R,FPicture.Graphic,Width3D)
      else
         StretchDraw(CalcRect3D(R,Width3D),FPicture.Graphic);
      UnClipRectangle;
    end;
  end;
end;

class function TChartImageTool.Description: String;
begin
  result:=TeeMsg_ImageTool;
end;

class function TChartImageTool.GetEditorClass: String;
begin
  result:='TChartImageToolEditor';
end;

procedure TChartImageTool.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TChartImageTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  Repaint;
end;

{ TMarksToolTip }
constructor TMarksTipTool.Create(AOwner: TComponent);
begin
  inherited;
  FStyle:=smsLabel;
end;

procedure TMarksTipTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp       : Integer;
    tmpSeries : TChartSeries;

  Procedure FindClickedSeries;
  var t : Integer;
  begin
    for t:=0 to ParentChart.SeriesCount-1 do
    begin
      tmp:=ParentChart[t].Clicked(x,y);
      if tmp<>-1 then
      begin
        tmpSeries:=ParentChart[t];
        break;
      end;
    end;
  end;

var tmpStyle  : TSeriesMarksStyle;
    tmpOld    : Boolean;
    tmpText   : String;
    t         : Integer;
    tmpCancel : Boolean;
begin
  inherited;
  if ((MouseAction=mtmMove) and (AEvent=cmeMove)) or
     ((MouseAction=mtmClick) and (AEvent=cmeDown)) then
  begin
    tmpSeries:=nil;
    tmp:=-1;

    { find which series is under XY }
    if Assigned(Series) then
    begin
      tmpSeries:=Series;
      tmp:=tmpSeries.Clicked(x,y);
    end
    else FindClickedSeries; { 5.02 }

    { if not ok then cancel hint... }
    if tmp=-1 then
    begin
      tmpCancel:=True;
      { do not cancel if other MarkTipTools exist... }
      for t:=0 to Chart.Tools.Count-1 do
      if (Chart.Tools[t]<>Self) and
         (Chart.Tools[t] is TMarksTipTool) then { 5.01 }
      begin
        tmpCancel:=False;
        break;
      end;
      if tmpCancel then
      begin
        Chart.Hint:='';
        Application.CancelHint;
      end;
    end
    else
    begin
      { show hint ! }
      tmpStyle:=tmpSeries.Marks.Style;
      tmpOld:=Chart.AutoRepaint;
      Chart.AutoRepaint:=False;
      tmpSeries.Marks.Style:=FStyle;
      try
        tmpText:=tmpSeries.ValueMarkText[tmp];
        if Assigned(FOnGetText) then FOnGetText(Self,tmpText);
        if Chart.Hint<>tmpText then
        begin
          Chart.ShowHint:=True; { 5.02 }
          Chart.Hint:=tmpText;
          {$IFDEF D5}
          Application.ActivateHint(Chart.ClientToScreen(TeePoint(X,Y)));
          {$ENDIF}
        end;
      finally
        tmpSeries.Marks.Style:=tmpStyle;
        Chart.AutoRepaint:=tmpOld;
      end;
    end;
  end;
end;

class function TMarksTipTool.Description: String;
begin
  result:=TeeMsg_MarksTipTool;
end;

class function TMarksTipTool.GetEditorClass: String;
begin
  result:='TMarksTipToolEdit';
end;

Function TMarksTipTool.Chart:TCustomChart;
begin
  if Assigned(Series) then result:=TCustomChart(Series.ParentChart)
                      else result:=TCustomChart(ParentChart);
end;

procedure TMarksTipTool.SetActive(Value: Boolean);
begin
  inherited;
  if not Active then Chart.Hint:='';
end;

procedure TMarksTipTool.SetMouseAction(Value: TMarkToolMouseAction);
begin
  FMouseAction:=Value;
  Chart.Hint:='';
end;

function TMarksTipTool.GetMouseDelay: Integer;
begin
  result:=Application.HintPause;
end;

procedure TMarksTipTool.SetMouseDelay(const Value: Integer);
begin
  Application.HintPause:=Value;
end;

{ TAnnotationCallout }
Constructor TAnnotationCallout.Create(AOwner: TChartSeries);
begin
  inherited;
  Arrow.Visible:=False;
  Visible:=False;
end;

procedure TAnnotationCallout.Assign(Source: TPersistent);
begin
  if Source is TAnnotationCallout then
  With TAnnotationCallout(Source) do
  begin
    Self.FX:=XPosition;
    Self.FY:=YPosition;
    Self.FZ:=ZPosition;
  end;
  inherited;
end;

procedure TAnnotationCallout.SetX(const Value: Integer);
begin
  if FX<>Value then
  begin
    FX:=Value;
    Repaint;
  end;
end;

procedure TAnnotationCallout.SetY(const Value: Integer);
begin
  if FY<>Value then
  begin
    FY:=Value;
    Repaint;
  end;
end;

procedure TAnnotationCallout.SetZ(const Value: Integer);
begin
  if FZ<>Value then
  begin
    FZ:=Value;
    Repaint;
  end;
end;

function TAnnotationCallout.CloserPoint(const R: TRect;
  const P: TPoint): TPoint;
var tmpX : Integer;
    tmpY : Integer;
begin
  if P.X>R.Right then tmpX:=R.Right
  else
  if P.X<R.Left then tmpX:=R.Left
  else
     tmpX:=(R.Left+R.Right) div 2;

  if P.Y>R.Bottom then tmpY:=R.Bottom
  else
  if P.Y<R.Top then tmpY:=R.Top
  else
     tmpY:=(R.Top+R.Bottom) div 2;

  result:=TeePoint(tmpX,tmpY);
end;

{ TAnnotationTool }
Constructor TAnnotationTool.Create(AOwner: TComponent);
begin
  inherited;
  FCursor:=crDefault;
  FShape:=TTeeShapePosition.Create(nil);
  FCallout:=TAnnotationCallout.Create(nil);
  FPosition:=ppLeftTop;
end;

Destructor TAnnotationTool.Destroy;
begin
  FreeAndNil(FCallout);
  FreeAndNil(FShape);
  inherited;
end;

procedure TAnnotationTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if AEvent=cteAfterDraw then DrawText;
end;

Function TAnnotationTool.GetText:String;
begin
  result:=FText;
end;

procedure TAnnotationTool.SetText(const Value: String);
begin
  SetStringProperty(FText,Value);
end;

type TChartAccess=class(TCustomAxisPanel);

procedure TAnnotationTool.DrawText;
var x     : Integer;
    y     : Integer;
    tmpW  : Integer;
    tmpH  : Integer;
    t     : Integer;
    tmpX  : Integer;
    tmpY  : Integer;
    tmpN  : Integer;
    tmp   : String;
    tmpTo : TPoint;
    tmpFrom : TPoint;
begin
  With ParentChart.Canvas do
  begin
    tmp:=GetText;
    if tmp='' then tmp:=' ';  { at least one space character... }

    AssignFont(Self.Shape.Font);

    tmpW:=TChartAccess(ParentChart).MultiLineTextWidth(tmp,tmpN);
    tmpH:=tmpN*FontHeight;

    if Shape.CustomPosition then
    begin
      x:=Shape.Left+4;
      y:=Shape.Top+2;
    end
    else
    begin
      tmpX:=ParentChart.Width-tmpW-8;
      tmpY:=ParentChart.Height-tmpH-8;
      Case Position of
        ppLeftTop     : begin x:=10; y:=10; end;
        ppLeftBottom  : begin x:=10; y:=tmpY; end;
        ppRightTop    : begin x:=tmpX; y:=10; end;
      else
        begin x:=tmpX; y:=tmpY; end;
      end;
    end;

    With Shape.ShapeBounds do
    begin
      Left:=x-4;
      Right:=x+tmpW+2;
      Top:=y-2;
      Bottom:=y+tmpH+2;
    end;

    if Shape.Visible then Shape.Draw;

    BackMode:=cbmTransparent;

    case FTextAlign of
      taLeftJustify: TextAlign:=ta_Left;
      taCenter:  begin
                   TextAlign:=ta_Center;
                   with Shape.ShapeBounds do
                        x:=2+((Left+Right) div 2);
                 end;
    else
      begin
        TextAlign:=ta_Right;
        x:=Shape.ShapeBounds.Right-2;
      end;
    end;

    for t:=1 to tmpN do
        TextOut(x,y+(t-1)*FontHeight, TeeExtractField(tmp,t,TeeLineSeparator));
  end;

  with Callout do
  if Visible or Arrow.Visible then
  begin
    tmpTo:=TeePoint(XPosition,YPosition);
    tmpFrom:=CloserPoint(Shape.ShapeBounds,tmpTo);

    if Distance<>0 then
       tmpTo:=PointAtDistance(tmpFrom,tmpTo,Distance);

    Draw(clNone,tmpTo,tmpFrom,ZPosition);
  end;
end;

procedure TAnnotationTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    if Assigned(Shape) then Shape.ParentChart:=Value;
    if Assigned(Callout) then Callout.ParentChart:=Value;
    if Assigned(ParentChart) then Repaint;
  end;
end;

procedure TAnnotationTool.SetShape(const Value: TTeeShapePosition);
begin
  FShape.Assign(Value);
end;

class function TAnnotationTool.Description: String;
begin
  result:=TeeMsg_AnnotationTool;
end;

class function TAnnotationTool.GetEditorClass: String;
begin
  result:='TAnnotationToolEdit';
end;

procedure TAnnotationTool.SetPosition(const Value: TAnnotationPosition);
begin
  if FPosition<>Value then
  begin
    FPosition:=Value;
    Shape.CustomPosition:=False;
    Repaint;
  end;
end;

Function TAnnotationTool.Clicked(x,y:Integer):Boolean; // 5.03
begin
  result:=PointInRect(FShape.ShapeBounds,x,y);
end;

procedure TAnnotationTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if AEvent=cmeDown then
  begin
    if Assigned(FOnClick) and Clicked(x,y) then
       FOnClick(Self,Button,Shift,X,Y);
  end
  else
  if (AEvent=cmeMove) and (FCursor<>crDefault) then
  begin
    if Clicked(x,y) then
    begin
      ParentChart.Cursor:=FCursor;
      ParentChart.CancelMouse:=True;
    end;
  end;
end;

procedure TAnnotationTool.SetTextAlign(const Value: TAlignment);
begin
  if FTextAlign<>Value then
  begin
    FTextAlign:=Value;
    Repaint;
  end;
end;

procedure TAnnotationTool.SetCallout(const Value: TAnnotationCallout);
begin
  FCallout.Assign(Value);
end;

{ TSeriesAnimationTool }
constructor TSeriesAnimationTool.Create(AOwner: TComponent);
begin
  inherited;
  IStop:=True;
  FStartAtMin:=True;
  FSteps:=100;
end;

class function TSeriesAnimationTool.Description: String;
begin
  result:=TeeMsg_SeriesAnimTool;
end;

procedure TSeriesAnimationTool.Execute;

  Procedure UpdateChart;
  begin
    Series.ParentChart.Invalidate;
    Application.ProcessMessages;
  end;

  Procedure DoAnimation;
  var t,tt     : Integer;
      tmpBack  : TChartValueList;
      tmpList  : TChartValueList;
      tmpStart : Double;
      tmpSpeed : Double;
      tmpPoints : Integer;
      tmpPointStep : Integer;
      tmpFrom      : Integer;
      tmpTo        : Integer;
  begin
    tmpList:=Series.MandatoryValueList;

    if StartAtMin then tmpStart:=tmpList.MinValue
                  else tmpStart:=StartValue;

    // Clear values
    for t:=0 to Series.Count-1 do tmpList.Value[t]:=tmpStart;
    UpdateChart;

    tmpSpeed:=1/Steps;

    tmpBack:=FBackup.MandatoryValueList;

    if DrawEvery=0 then tmpPoints:=0
    else
    begin
      tmpPoints:=Series.Count div DrawEvery;
      if (Series.Count mod DrawEvery)=0 then Dec(tmpPoints);
    end;

    for tmpPointStep:=0 to tmpPoints do
    begin
      tmpFrom:=tmpPointStep*DrawEvery;
      if DrawEvery=0 then tmpTo:=Series.Count-1
                     else tmpTo:=Math.Min(Series.Count-1,tmpFrom+DrawEvery-1);

      for t:=0 to Steps do
      begin
        for tt:=tmpFrom to tmpTo do
            tmpList.Value[tt]:=tmpStart+((tmpBack.Value[tt]-tmpStart)*t*tmpSpeed);

        if Assigned(FOnStep) then FOnStep(Self,t);

        UpdateChart;

        if IStop then break;
      end;
    end;
  end;

begin
  if Assigned(Series) and IStop then
  begin
    FBackup:=TChartSeriesClass(Series.ClassType).Create(nil);
    try
      FBackup.AssignValues(Series);
      Series.BeginUpdate;
      IStop:=False;
      try
        DoAnimation;
      finally
        IStop:=True;
        // Series.AssignValues(FBackup);
        Series.EndUpdate;
      end;
    finally
      FBackup.Free;
    end;
  end;
end;

class function TSeriesAnimationTool.GetEditorClass: String;
begin
  result:='TSeriesAnimToolEditor';
end;

{ TGridBandBrush }
procedure TGridBandBrush.SetBackColor(const Value: TColor);
begin
  if FBackColor<>Value then
  begin
    FBackColor:=Value;
    Changed;
  end;
end;

procedure TGridBandBrush.SetTransp(const Value: TTeeTransparency);
begin
  if FTransp<>Value then
  begin
    FTransp:=Value;
    Changed;
  end;
end;

{ TGridBandTool }
constructor TGridBandTool.Create(AOwner: TComponent);
begin
  inherited;
  FBand1:=TGridBandBrush.Create(CanvasChanged);
  FBand1.BackColor:=clNone;
  FBand2:=TGridBandBrush.Create(CanvasChanged);
  FBand2.BackColor:=clNone;
end;

class function TGridBandTool.Description: String;
begin
  result:=TeeMsg_GridBandTool;
end;

type TAxisAccess=class(TChartAxis);

destructor TGridBandTool.Destroy;
begin
  if Assigned(Axis) then TAxisAccess(Axis).OnDrawGrids:=nil;
  FBand2.Free;
  FBand1.Free;
  inherited;
end;

Function TGridBandTool.BandBackColor(ABand:TGridBandBrush):TColor;
begin
  result:=ABand.BackColor;
  if result=clNone then result:=TCustomChart(ParentChart).Walls.Back.Color;
end;

Procedure TGridBandTool.DrawGrids(Sender:TChartAxis);
var tmpBand  : TGridBandBrush;
    tmpBlend : TTeeBlend;

  Procedure DrawBand(tmpPos1,tmpPos2:Integer);
  var tmpR : TRect;
  begin
    if tmpBand.Style<>bsClear then
    with ParentChart,Canvas do
    begin

      AssignBrushColor(tmpBand,tmpBand.Color,BandBackColor(tmpBand));

      if Axis.Horizontal then
         tmpR:=TeeRect(tmpPos1,ChartRect.Top,tmpPos2,ChartRect.Bottom)
      else
         tmpR:=TeeRect(ChartRect.Left+1,tmpPos1,ChartRect.Right,tmpPos2+1);

      if tmpBand.Transparency>0 then
         if View3D then tmpBlend.SetRectangle(CalcRect3D(tmpR,Width3D))
                   else tmpBlend.SetRectangle(tmpR);

      if View3D then RectangleWithZ(tmpR,Width3D)
      else
      begin
        Inc(tmpR.Right);
        Rectangle(tmpR);
      end;

      if tmpBand.Transparency>0 then
         tmpBlend.DoBlend(tmpBand.Transparency);
    end;
  end;

var t   : Integer;
    tmp : Integer;
begin
  if not Active then exit;
  
  tmp:=High(TAxisAccess(Sender).Tick);

  if (tmp>0) and (Band1.Style<>bsClear) or (Band2.Style<>bsClear) then
  begin
    tmpBlend:=TTeeBlend.Create(ParentChart.Canvas,TeeRect(0,0,0,0));
    try
      ParentChart.Canvas.Pen.Style:=psClear;
      tmpBand:=Band1;

      with TAxisAccess(Sender) do
      begin
        // first remainder band...
        if Horizontal then
        begin
          if Tick[0]<IEndPos then
          begin
            DrawBand(IEndPos-1,Tick[0]);
            tmpBand:=Band2;
          end;
        end
        else
          if Tick[0]>IStartPos then
          begin
            DrawBand(IStartPos+1,Tick[0]);
            tmpBand:=Band2;
          end;

        // all bands...
        for t:=1 to tmp do
        begin
          DrawBand(Tick[Pred(t)],Tick[t]);
          if tmpBand=Band1 then tmpBand:=Band2
                           else tmpBand:=Band1;
        end;

        // last remainder band...
        if Horizontal then
        begin
          if Tick[tmp]>IStartPos then DrawBand(Tick[tmp],IStartPos);
        end
        else
          if Tick[tmp]<IEndPos then DrawBand(Tick[tmp],IEndPos);
      end;
    finally
      tmpBlend.Free;
    end;
  end;
end;

class function TGridBandTool.GetEditorClass: String;
begin
  result:='TGridBandToolEdit';
end;

procedure TGridBandTool.SetAxis(const Value: TChartAxis);
begin
  if Assigned(Axis) then TAxisAccess(Axis).OnDrawGrids:=nil;
  inherited;
  if Assigned(Axis) then TAxisAccess(Axis).OnDrawGrids:=DrawGrids;
end;

procedure TGridBandTool.SetBand1(Value: TGridBandBrush);
begin
  FBand1.Assign(Value);
end;

procedure TGridBandTool.SetBand2(Value: TGridBandBrush);
begin
  FBand2.Assign(Value);
end;

Const T:Array[0..12] of TTeeCustomToolClass=(
                     TCursorTool,     TDragMarksTool,
                     TAxisArrowTool,  TDrawLineTool,
                     TNearestTool,    TColorBandTool,
                     TColorLineTool,  TRotateTool,
                     TChartImageTool, TMarksTipTool,
                     TAnnotationTool, TSeriesAnimationTool,
                     TGridBandTool
                     );

initialization
  RegisterTeeTools(T);
finalization
  UnRegisterTeeTools(T);
end.
