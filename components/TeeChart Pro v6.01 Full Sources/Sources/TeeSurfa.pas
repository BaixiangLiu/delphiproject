{**********************************************}
{  TeeChart Pro                                }
{                                              }
{   TCustom3DSeries                            }
{    TCustom3DPaletteSeries                    }
{     TVector3DSeries                          }
{     TCustom3DGridSeries                      }
{      TSurfaceSeries                          }
{      TContourSeries                          }
{      TWaterFallSeries                        }
{      TColorGridSeries                        }
{      TTowerSeries                            }
{                                              }
{  Functions:                                  }
{                                              }
{   TSmoothPoints                              }
{                                              }
{  Copyright (c) 1995-2003 by David Berneda    }
{**********************************************}
unit TeeSurfa;
{$I TeeDefs.inc}

interface

{$DEFINE LEVELSEGMENTS} { <--- For TContourSeries only. }

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeeProcs, TeEngine, TeCanvas, Chart;

// Const MaxAllowedCells=2000; { max 2000 x 2000 cells }

type
  TChartSurfaceGetColor=Procedure( Sender:TChartSeries;
                                   ValueIndex:Integer;
                                   Var Color:TColor) of object;

  TArrayGrid=Array of Array of TChartValue;

  TCustom3DSeries=class(TChartSeries)
  private
    FTimesZOrder : Integer;
    FZValues     : TChartValueList;
    Function GetZValue(Index:Integer):TChartValue; { 5.02 }
    Procedure SetTimesZOrder(Const Value:Integer);
    Procedure SetZValue(Index:Integer; Const Value:TChartValue); { 5.02 }
    Procedure SetZValues(Const Value:TChartValueList);
  protected
    Procedure CalcZOrder; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure PrepareLegendCanvas( ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Assign(Source:TPersistent); override;

    Procedure AddArray(Const Values:TArrayGrid); overload;
    Function AddXYZ(Const AX,AY,AZ:TChartValue):Integer; overload;
    Function AddXYZ(Const AX,AY,AZ:TChartValue;
                    Const AXLabel:String; AColor:TColor):Integer; overload; virtual;

    Function CalcZPos(ValueIndex:Integer):Integer;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxZValue:Double; override;
    Function MinZValue:Double; override;
    property ZValue[Index:Integer]:TChartValue read GetZValue write SetZValue;

    { to be published }
    property TimesZOrder:Integer read FTimesZOrder write SetTimesZOrder default 3;
    property ZValues:TChartValueList read FZValues write SetZValues;
  end;

  TGridPalette=packed record
    UpToValue : TChartValue;
    Color     : TColor;
  end;

  TCustom3DPalette=Array of TGridPalette;

  TTeePaletteStyle=(psPale,psStrong,psGrayScale);

  TCustom3DPaletteSeries=class(TCustom3DSeries)
  private
    FEndColor     : TColor;
    FMidColor     : TColor;

    FPalette      : TCustom3DPalette;
    FLegendEvery  : Integer;
    FPaletteMin   : Double;    // overrides automatic palette generation
    FPaletteStep  : Double;    // overrides automatic palette generation
    FPaletteSteps : Integer;
    FPaletteStyle : TTeePaletteStyle;

    FStartColor   : TColor;
    FUseColorRange: Boolean;
    FUsePalette   : Boolean;
    FUsePaletteMin: Boolean;   // overrides automatic palette generation

    FOnGetColor   : TChartSurfaceGetColor;

    { internal }
    IRangeRed    : Integer;
    IEndRed      : Integer;
    IMidRed      : Integer;
    IRangeMidRed : Integer;
    IRangeGreen  : Integer;
    IEndGreen    : Integer;
    IMidGreen    : Integer;
    IRangeMidGreen: Integer;
    IRangeBlue   : Integer;
    IEndBlue     : Integer;
    IMidBlue     : Integer;
    IRangeMidBlue: Integer;
    IValueRangeInv: Double;

    Procedure CalcColorRange;
    Procedure CheckPaletteEmpty;
    Function LegendPaletteIndex(LegendIndex:Integer):Integer;
    Function RangePercent(Const Percent:Double):TColor;
    Procedure SetEndColor(Const Value:TColor);
    Procedure SetMidColor(Const Value:TColor);
    Procedure SetPaletteSteps(Const Value:Integer);
    procedure SetPaletteStyle(const Value: TTeePaletteStyle);
    Procedure SetStartColor(Const Value:TColor);
    Procedure SetUseColorRange(Const Value:Boolean);
    Procedure SetUsePalette(Const Value:Boolean);
    procedure SetPaletteMin(const Value: Double);
    procedure SetPaletteStep(const Value: Double);
    procedure SetUsePaletteMin(const Value: Boolean);
    procedure SetLegendEvery(const Value: Integer);
  protected
    PaletteRange : Double;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DoBeforeDrawChart; override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    Function GetValueColor(ValueIndex:Integer):TColor; override;
    Function GetValueColorValue(Const AValue:TChartValue):TColor;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    RedFactor    : Double;
    GreenFactor  : Double;
    BlueFactor   : Double;

    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Function AddPalette(Const AValue:TChartValue; AColor:TColor):Integer;
    Procedure Assign(Source:TPersistent); override;
    Procedure Clear; override;
    Procedure ClearPalette;
    Function CountLegendItems:Integer; override;
    Procedure CreateDefaultPalette(NumSteps:Integer);
    Procedure CreateRangePalette;
    Function GetSurfacePaletteColor(Const Y:TChartValue):TColor;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;

    property EndColor:TColor read FEndColor write SetEndColor default clWhite;
    property MidColor:TColor read FMidColor write SetMidColor default clNone;
    property LegendEvery:Integer read FLegendEvery write SetLegendEvery default 1;
    property Palette:TCustom3DPalette read FPalette;
    property PaletteMin:Double read FPaletteMin write SetPaletteMin; // 5.03
    property PaletteStep:Double read FPaletteStep write SetPaletteStep; // 5.03
    property PaletteSteps:Integer read FPaletteSteps write SetPaletteSteps default 32;
    property PaletteStyle:TTeePaletteStyle read FPaletteStyle write SetPaletteStyle default psPale;
    property StartColor:TColor read FStartColor write SetStartColor default clNavy;
    property UseColorRange:Boolean read FUseColorRange write SetUseColorRange default True;
    property UsePalette:Boolean read FUsePalette write SetUsePalette default False;
    property UsePaletteMin:Boolean read FUsePaletteMin write SetUsePaletteMin default False; // 5.03
    { events }
    property OnGetColor:TChartSurfaceGetColor read FOnGetColor write FOnGetColor;
  end;

  { Grid 3D series }
  TChartSurfaceGetY=Function(Sender:TChartSeries; X,Z:Integer):Double of object;

  TCustom3DGridSeries=class(TCustom3DPaletteSeries)
  private
    FIrregularGrid : Boolean;
    FNumXValues    : Integer;
    FNumZValues    : Integer;
    FOnGetYValue   : TChartSurfaceGetY;

    { internal }
    ValueIndex0    : Integer;
    ValueIndex1    : Integer;
    ValueIndex2    : Integer;
    ValueIndex3    : Integer;

    INextXCell : Integer;
    INextZCell : Integer;

    //Procedure ClearGridIndex;
    Function ExistFourGridIndex(X,Z:Integer):Boolean;
    //Function GetGridIndex(X,Z:Integer):Integer;
    //Procedure InternalSetGridIndex(X,Z,Value:Integer);
    //Procedure SetGridIndex(X,Z,Value:Integer);
    Procedure InitGridIndex(XCount,ZCount:Integer);
    Procedure SetIrregularGrid(Const Value:Boolean);
    Procedure SetNumXValues(Value:Integer);
    Procedure SetNumZValues(Value:Integer);
    function GetValue(X, Z: Integer): TChartValue;
    procedure SetValue(X, Z: Integer; const Value: TChartValue);
  protected
    IInGallery : Boolean;
    Procedure AddSampleValues(NumValues:Integer); override;
    Procedure AddValues(Source:TChartSeries); override;
    Function CanCreateValues:Boolean;
    Procedure DoBeforeDrawChart; override;
  public
    GridIndex: packed Array of Array of Integer; //TTeeCellsRow;

    Constructor Create(AOwner: TComponent); override;

    Procedure Assign(Source:TPersistent); override;
    Procedure Clear; override;
    Procedure CreateValues(NumX,NumZ:Integer); virtual;
    Procedure FillGridIndex;
    Function GetXZValue(X,Z:Integer):TChartValue; virtual;
    Function IsValidSeriesSource(Value:TChartSeries):Boolean; override;
    Function NumSampleValues:Integer; override;
    Procedure ReCreateValues;

    //property GridIndex[X,Z:Integer]:Integer read GetGridIndex write SetGridIndex;
    property IrregularGrid:Boolean read FIrregularGrid write SetIrregularGrid default False;

    property NumXValues:Integer read FNumXValues write SetNumXValues default 10;
    property NumZValues:Integer read FNumZValues write SetNumZValues default 10;
    property Value[X,Z:Integer]:TChartValue read GetValue write SetValue;

    { events }
    property OnGetYValue:TChartSurfaceGetY read FOnGetYValue write FOnGetYValue;
  end;

  TSurfaceSeries=class(TCustom3DGridSeries)
  private
    { Private declarations }
    FDotFrame       : Boolean;
    FSideBrush      : TChartBrush;
    FSideLines      : TChartHiddenPen;
    FSmoothPalette  : Boolean;
    FTransparency   : TTeeTransparency; // 5.03
    FWaterFall      : Boolean;
    FWaterLines     : TChartPen;
    FWireFrame      : Boolean;

    { internal }
    FSameBrush      : Boolean;
    IBlender        : TTeeBlend;
    Function FourGridIndex(x,z:Integer):Boolean;
    Procedure SetDotFrame(Value:Boolean);
    Procedure SetSideBrush(Value:TChartBrush);
    Procedure SetSideLines(Value:TChartHiddenPen);
    Procedure SetSmoothPalette(Value:Boolean);
    procedure SetTransparency(const Value: TTeeTransparency);
    Procedure SetWaterFall(Value:Boolean);
    Procedure SetWireFrame(Value:Boolean);
    procedure SetWaterLines(const Value: TChartPen);
  protected
    { Protected declarations }
    Points : TFourPoints;
    Function CalcPointPos(Index:Integer):TPoint;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawAllValues; override;
    Procedure DrawCell(x,z:Integer); virtual;
    Function FastCalcPoints( x,z:Integer;
                             Var P0,P1:TPoint3D;
                             Var Color0,Color1:TColor):Boolean;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function Clicked(x,y:Integer):Integer; override;
    property WaterFall:Boolean read FWaterFall write SetWaterFall default False;
    property WaterLines:TChartPen read FWaterLines write SetWaterLines;
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

    property Brush;
    property DotFrame:Boolean read FDotFrame write SetDotFrame default False;
    property EndColor;
    property IrregularGrid;
    property MidColor;
    property NumXValues;
    property NumZValues;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property SideBrush:TChartBrush read FSideBrush write SetSideBrush;
    property SideLines:TChartHiddenPen read FSideLines write SetSideLines;
    property SmoothPalette:Boolean read FSmoothPalette write SetSmoothPalette default False;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property WireFrame:Boolean read FWireFrame write SetWireFrame default False;
    property TimesZOrder;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property XValues;
    property YValues;
    property ZValues;
    { events }
    property OnGetYValue;
    property OnGetColor;
  end;

  TContourSeries=class;

  TOnBeforeDrawLevelEvent=procedure( Sender:TContourSeries;
                                     LevelIndex:Integer) of object;

  TOnGetLevelEvent=procedure( Sender:TContourSeries; LevelIndex:Integer;
                            Var Value:Double; Var Color:TColor) of object;

  {$IFDEF LEVELSEGMENTS}
  TLevelPoint=packed record
     X,Y: TChartValue;
  end;

  TLevelSegment=packed record
    Points : Array of TLevelPoint;
  end;

  TLevelSegments=Array of TLevelSegment;
  {$ENDIF}

  TContourLevel=class(TCollectionItem)
  private
    FColor  : TColor;
    FPen    : TChartPen;
    FUpTo   : Double;

    ISeries : TContourSeries;

    {$IFDEF LEVELSEGMENTS}
    FSegments : TLevelSegments;
    {$ENDIF}

    Procedure CheckAuto;
    procedure SetColor(const Value: TColor);
    procedure SetUpTo(const Value: Double);
    function GetPen: TChartPen;
    function IsPenStored: Boolean;
    procedure SetPen(const Value: TChartPen);
  protected
    {$IFDEF LEVELSEGMENTS}
    Function GetSegmentPoints(SegmentIndex:Integer):TPointArray;
    {$ENDIF}
    function InternalPen:TChartPen;
  public
    Constructor Create(Collection:TCollection); override;
    Destructor Destroy; override;
    Procedure Assign(Source:TPersistent); override; { 5.01 }
    {$IFDEF LEVELSEGMENTS}
    Procedure ClearSegments;
    Function Clicked(x,y:Integer; Var SegmentIndex,PointIndex:Integer):Boolean;
    Function ClickedSegment(x,y,SegmentIndex:Integer; Var PointIndex:Integer):Boolean;
    {$ENDIF}

    Function DefaultPen:Boolean;

    {$IFDEF LEVELSEGMENTS}
    Function SegmentCount:Integer;
    property Segments:TLevelSegments read FSegments;
    {$ENDIF}
  published
    property Color:TColor read FColor write SetColor;
    property Pen:TChartPen read GetPen write SetPen stored IsPenStored; // 5.03
    property UpToValue:Double read FUpTo write SetUpTo;
  end;

  TContourLevels=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TContourLevel;
    Procedure Put(Index:Integer; Const Value:TContourLevel);
  public
    {$IFDEF LEVELSEGMENTS}
    Function Clicked(x,y:Integer; Var SegmentIndex,PointIndex:Integer):Integer;
    {$ENDIF}
    property Items[Index:Integer]:TContourLevel read Get write Put; default;
  end;

  TSmoothPoints=class(TPersistent)
  private
    FActive : Boolean;
    ISeries : TChartSeries;
    FInterpolate: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetInterpolate(const Value: Boolean);
  public
    Factor : Integer;
    Constructor Create(Parent:TChartSeries);
    Procedure Assign(Source:TPersistent); override;
    Function Calculate(Const P:Array of TPoint):TPointArray;
  published
    property Active:Boolean read FActive write SetActive default False;
    property Interpolate:Boolean read FInterpolate write SetInterpolate default False;
  end;

  TContourSeries=class(TCustom3DGridSeries)
  private
    FAutomaticLevels: Boolean;
    FLevels         : TContourLevels;
    FNumLevels      : Integer;
    FSmoothing      : TSmoothPoints;
    FYPosition      : Double;
    FYPositionLevel : Boolean;
    FOnBeforeDrawLevel : TOnBeforeDrawLevelEvent;
    FOnGetLevel     : TOnGetLevelEvent;

    IModifyingLevels : Boolean;
    function GetNumLevels: Integer;
    function GetZAxis:TChartAxis;
    function IsLevelsStored: Boolean;
    procedure SetAutomaticLevels(const Value: Boolean);
    procedure SetLevels(const Value: TContourLevels);
    Procedure SetNumLevels(Value:Integer);
    Procedure SetYPosition(Const Value:Double);
    Procedure SetYPositionLevel(Value:Boolean);
    procedure SetSmoothing(const Value: TSmoothPoints);
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure AddSampleValues(NumValues:Integer); override;
    Procedure DoBeforeDrawChart; override;
    procedure DrawAllValues; override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    {$IFDEF LEVELSEGMENTS}
    Function Clicked(x,y:Integer):Integer; override;
    {$ENDIF}
    Function CountLegendItems:Integer; override;
    Procedure CreateAutoLevels; { calc Level values and colors }
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property Active;
    property AutomaticLevels:Boolean read FAutomaticLevels write SetAutomaticLevels default True;
    property ColorEachPoint default True;
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

    property EndColor;
    property LegendEvery;
    property Levels:TContourLevels read FLevels write SetLevels stored IsLevelsStored;
    property MidColor;
    property NumLevels:Integer read GetNumLevels write SetNumLevels default 10;
    property NumXValues;
    property NumZValues;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property Pen;
    property Smoothing:TSmoothPoints read FSmoothing write SetSmoothing;
    property StartColor;
    property TimesZOrder;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property XValues;
    property YPosition:Double read FYPosition write SetYPosition;
    property YPositionLevel:Boolean read FYPositionLevel write SetYPositionLevel default False;
    property YValues;
    property ZValues;

    { events }
    property OnBeforeDrawLevel:TOnBeforeDrawLevelEvent read FOnBeforeDrawLevel
                                                       write FOnBeforeDrawLevel;
    property OnGetYValue;
    property OnGetLevel:TOnGetLevelEvent read FOnGetLevel write FOnGetLevel;
  end;

  TWaterFallSeries=class(TSurfaceSeries)
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
  published
    property WaterFall default True;
    property WaterLines;
  end;

  TColorGridSeries=class(TCustom3DGridSeries)
  private
    FBitmap : TBitmap;
    FCentered: Boolean;

    procedure SetCentered(const Value: Boolean);
    procedure SetBitmap(const Value: TBitmap);
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure DrawAllValues; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Function Clicked(X,Y:Integer):Integer; override; { 5.01 }
    Function MinXValue:Double; override;
    Function MaxXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function MinZValue:Double; override;
    Function MaxZValue:Double; override;

    property Bitmap:TBitmap read FBitmap write SetBitmap;
  published
    { Published declarations }
    property Active;
    property CenteredPoints:Boolean read FCentered write SetCentered default False;
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

    property Brush;
    property EndColor;
    property IrregularGrid;
    property MidColor;
    property NumXValues;
    property NumZValues;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;
    { events }
    property OnGetYValue;
    property OnGetColor;
  end;

  TVector3DSeries=class(TCustom3DPaletteSeries)
  private
    FArrowHeight : Integer;
    FArrowWidth  : Integer;
    FStartArrow  : TChartHiddenPen;
    FEndArrow    : TChartPen;
    FEndXValues  : TChartValueList; { <-- Vector end X values }
    FEndYValues  : TChartValueList; { <-- Vector end Y values }
    FEndZValues  : TChartValueList;

    procedure SetArrowHeight(const Value: Integer);
    procedure SetArrowWidth(const Value: Integer);
    Procedure SetEndXValues(Value:TChartValueList);
    Procedure SetEndYValues(Value:TChartValueList);
    Procedure SetEndZValues(Value:TChartValueList);
    procedure SetEndArrow(const Value: TChartPen);
    procedure SetStartArrow(const Value: TChartHiddenPen);
  protected
    Procedure AddSampleValues(NumValues:Integer); override;
    procedure DrawValue(ValueIndex:Integer); override; { <-- main draw method }
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;

    Function AddVector(Const X0,Y0,Z0,X1,Y1,Z1:Double; Const ALabel:String='';
                     AColor:TColor=clTeeColor):Integer; overload;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function MaxZValue:Double; override;
    Function MinZValue:Double; override;
    Function NumSampleValues:Integer; override;
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

    property Brush;
    property EndColor;
    property MidColor;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;
    { events }
    property OnGetColor;

    property ArrowHeight:Integer read FArrowHeight write SetArrowHeight default 4;
    property ArrowWidth:Integer read FArrowWidth write SetArrowWidth default 4;
    property EndArrow:TChartPen read FEndArrow write SetEndArrow;
    property EndXValues:TChartValueList read FEndXValues write SetEndXValues;
    property EndYValues:TChartValueList read FEndYValues write SetEndYValues;
    property EndZValues:TChartValueList read FEndZValues write SetEndZValues;
    property StartArrow:TChartHiddenPen read FStartArrow write SetStartArrow;
  end;

  TTowerStyle=(tsCube,tsRectangle,tsCover,tsCylinder,tsArrow,tsCone,tsPyramid);

  TTowerSeries=class(TCustom3DGridSeries)
  private
    FDark3D       : Boolean;
    FOrigin       : Double;
    FPercDepth    : Integer;
    FPercWidth    : Integer;
    FTowerStyle   : TTowerStyle;
    FTransparency : TTeeTransparency;
    FUseOrigin    : Boolean;

    IOffW  : Double;
    IOffD  : Double;
    Function CalcCell(var AIndex,ATop,ABottom,Z0,Z1:Integer):TRect;
    procedure SetDark3D(const Value: Boolean);
    Procedure SetOrigin(Const Value:Double);
    procedure SetPercDepth(const Value: Integer);
    procedure SetPercWidth(const Value: Integer);
    procedure SetTransparency(const Value: TTeeTransparency);
    Procedure SetUseOrigin(Value:Boolean);
    procedure SetTowerStyle(const Value: TTowerStyle);
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    procedure DrawAllValues; override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;

    Function Clicked(X,Y:Integer):Integer; override; { 5.01 }
    Function MinXValue:Double; override;
    Function MaxXValue:Double; override;
    Function MinZValue:Double; override;
    Function MaxZValue:Double; override;
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

    property Dark3D:Boolean read FDark3D write SetDark3D default True;
    property PercentDepth:Integer read FPercDepth write SetPercDepth default 100;
    property Origin:Double read FOrigin write SetOrigin;
    property TowerStyle:TTowerStyle read FTowerStyle write SetTowerStyle default tsCube;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property PercentWidth:Integer read FPercWidth write SetPercWidth default 100;
    property UseOrigin:Boolean read FUseOrigin write SetUseOrigin default False;

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

    property Brush;
    property EndColor;
    property IrregularGrid;
    property MidColor;
    property NumXValues;
    property NumZValues;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;

    { events }
    property OnGetYValue;
    property OnGetColor;
  end;

implementation

Uses {$IFDEF CLX}
     Qt,
     {$ELSE}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$ENDIF}
     Math, TeeSpline, TeeProCo, TeeConst;

{ TCustom3DSeries }
Constructor TCustom3DSeries.Create(AOwner: TComponent);
Begin
  inherited;
  HasZValues:=True;
  CalcVisiblePoints:=False;
  FZValues:=TChartValueList.Create(Self,'Z'); { <-- dont translate ! }
  XValues.Order:=loNone;
  FTimesZOrder:=3;
end;

Procedure TCustom3DSeries.SetZValues(Const Value:TChartValueList);
Begin
  SetChartValueList(FZValues,Value); { standard method }
End;

Procedure TCustom3DSeries.CalcZOrder;
Begin
  inherited;
  ParentChart.MaxZOrder:=FTimesZOrder;
end;

Procedure TCustom3DSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                    APosition:TSeriesMarkPosition);
begin
  Marks.ZPosition:=CalcZPos(ValueIndex);
  inherited;
end;

Procedure TCustom3DSeries.AddArray(Const Values:TArrayGrid);
var x : Integer;
    z : Integer;
begin
  BeginUpdate;
  try
    for x:=Low(Values) to High(Values) do
        for z:=Low(Values[x]) to High(Values[x]) do
            AddXYZ(x,Values[x,z],z);
  finally
    EndUpdate;
  end;
end;

Function TCustom3DSeries.AddXYZ(Const AX,AY,AZ:TChartValue):Integer;
begin
  ZValues.TempValue:=AZ;
  result:=AddXY(AX,AY);
end;

Function TCustom3DSeries.AddXYZ(Const AX,AY,AZ:TChartValue;
                                Const AXLabel:String; AColor:TColor):Integer;
Begin
  ZValues.TempValue:=AZ;
  result:=AddXY(AX,AY,AXLabel,AColor);
end;

Function TCustom3DSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TCustom3DSeries;
end;

Procedure TCustom3DSeries.SetTimesZOrder(Const Value:Integer);
Begin
  SetIntegerProperty(FTimesZOrder,Value);
End;

Function TCustom3DSeries.MaxZValue:Double;
begin
  result:=FZValues.MaxValue;
end;

Function TCustom3DSeries.MinZValue:Double;
begin
  result:=FZValues.MinValue;
end;

Procedure TCustom3DSeries.Assign(Source:TPersistent);
begin
  if Source is TCustom3DSeries then
  With TCustom3DSeries(Source) do
  begin
    Self.FZValues.Assign(FZValues);
    Self.FTimesZOrder  :=FTimesZOrder;
  end;
  inherited;
end;

Procedure TCustom3DSeries.SetZValue(Index:Integer; Const Value:TChartValue);
Begin
  ZValues.Value[Index]:=Value;
End;

Function TCustom3DSeries.GetZValue(Index:Integer):TChartValue;
Begin
  result:=ZValues.Value[Index];
End;

function TCustom3DSeries.CalcZPos(ValueIndex: Integer): Integer;
begin
  result:=ParentChart.DepthAxis.CalcYPosValue(ZValues.Value[ValueIndex]);
end;

procedure TCustom3DSeries.PrepareLegendCanvas(ValueIndex: Integer;
  var BackColor: TColor; var BrushStyle: TBrushStyle);
begin
  inherited;
  if TCustomChart(ParentChart).Legend.Symbol.Continuous then
     ParentChart.Canvas.Pen.Style:=psClear;
end;

{ TCustom3DPaletteSeries }
Constructor TCustom3DPaletteSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FUseColorRange:=True;
  FPaletteSteps:=32;
  FLegendEvery:=1;
  FStartColor:=clNavy;
  FEndColor:=clWhite;
  FMidColor:=clNone;
  { Palette Modifiers }
  RedFactor:=2.0;
  GreenFactor:=1;
  BlueFactor:=1;
  CalcColorRange;
End;

Destructor TCustom3DPaletteSeries.Destroy;
begin
  ClearPalette;
  inherited;
end;

Procedure TCustom3DPaletteSeries.CalcColorRange;
Begin
  IEndRed    :=GetRValue(EndColor);
  IEndGreen  :=GetGValue(EndColor);
  IEndBlue   :=GetBValue(EndColor);
  if MidColor<>clNone then
  begin
    IMidRed    :=GetRValue(MidColor);
    IMidGreen  :=GetGValue(MidColor);
    IMidBlue   :=GetBValue(MidColor);
    IRangeMidRed  :=Integer(GetRValue(StartColor))-IMidRed;
    IRangeMidGreen:=Integer(GetGValue(StartColor))-IMidGreen;
    IRangeMidBlue :=Integer(GetBValue(StartColor))-IMidBlue;
    IRangeRed  :=IMidRed-IEndRed;
    IRangeGreen:=IMidGreen-IEndGreen;
    IRangeBlue :=IMidBlue-IEndBlue;
  end
  else
  begin
    IRangeRed  :=Integer(GetRValue(StartColor))-IEndRed;
    IRangeGreen:=Integer(GetGValue(StartColor))-IEndGreen;
    IRangeBlue :=Integer(GetBValue(StartColor))-IEndBlue;
  end;
end;

Procedure TCustom3DPaletteSeries.SetStartColor(Const Value:TColor);
Begin
  SetColorProperty(FStartColor,Value);
  CalcColorRange;
End;

Procedure TCustom3DPaletteSeries.SetMidColor(Const Value:TColor);
Begin
  SetColorProperty(FMidColor,Value);
  CalcColorRange;
End;

Procedure TCustom3DPaletteSeries.SetEndColor(Const Value:TColor);
Begin
  SetColorProperty(FEndColor,Value);
  CalcColorRange;
End;

Function TCustom3DPaletteSeries.AddPalette(Const AValue:TChartValue; AColor:TColor):Integer;
var t   : Integer;
    tt  : Integer;
Begin
  for t:=0 to Length(FPalette)-1 do
  begin
    if AValue<FPalette[t].UpToValue then
    begin
      SetLength(FPalette,Length(FPalette)+1);
      for tt:=Length(FPalette)-1 downto t+1 do
          FPalette[tt]:=FPalette[tt-1];
      With FPalette[t] do
      begin
        UpToValue:=AValue;
        Color:=AColor;
      end;
      result:=t;
      exit;
    end;
  end;

  result:=Length(FPalette);
  SetLength(FPalette,result+1);
  With FPalette[result] do
  begin
    UpToValue:=AValue;
    Color:=AColor;
  end;
End;

Procedure TCustom3DPaletteSeries.ClearPalette;
Begin
  FPalette:=nil;
end;

Procedure TCustom3DPaletteSeries.CreateDefaultPalette(NumSteps:Integer);
Const Delta=127.0;
var t          : Integer;
    tmp        : Double;
    tmpMin     : Double;
    tmpColor   : TColor;
    Scale      : Double;
    ScaleValue : Double;
Begin
  ClearPalette;

  case PaletteStyle of
      psPale: Scale:=Pi/NumSteps;
    psStrong: Scale:=2.0*Pi/NumSteps;
  else
    Scale:=255.0/NumSteps;
  end;

  if PaletteStep=0 then // 5.03
  begin
    if PaletteRange=0 then
       ScaleValue:=MandatoryValueList.Range/Math.Max(1,NumSteps-1)
    else
       ScaleValue:=PaletteRange/NumSteps;
  end
  else ScaleValue:=PaletteStep;

  // 5.03
  if UsePaletteMin then tmpMin:=PaletteMin
                   else tmpMin:=MandatoryValueList.MinValue;

  for t:=0 to NumSteps-1 do
  begin
    tmp:=Scale*t;

    case PaletteStyle of
      psGrayScale: begin
                     tmpColor:=Round(tmp);
                     tmpColor:=RGB(tmpColor,tmpColor,tmpColor);
                   end;
    else
      tmpColor:=RGB( Trunc(Delta * (Sin(tmp/RedFactor)+1)) ,
                     Trunc(Delta * (Sin(tmp/GreenFactor)+1)),
                     Trunc(Delta * (Cos(tmp/BlueFactor)+1)));
    end;

    AddPalette(tmpMin+ScaleValue*t,tmpColor);
  end;

  Repaint;
end;

Procedure TCustom3DPaletteSeries.SetUseColorRange(Const Value:Boolean);
Begin
  SetBooleanProperty(FUseColorRange,Value);
  if Value then ColorEachPoint:=False;
End;

Procedure TCustom3DPaletteSeries.SetUsePalette(Const Value:Boolean);
Begin
  SetBooleanProperty(FUsePalette,Value);
  if Value then
  begin
    ColorEachPoint:=False;
    CheckPaletteEmpty;
  end;
end;

Function TCustom3DPaletteSeries.GetSurfacePaletteColor(Const Y:TChartValue):TColor;
Var t        : Integer;
    tmpCount : Integer;
Begin
  tmpCount:=Length(FPalette)-1;
  for t:=0 to tmpCount do
  With FPalette[t] do
  if UpToValue>Y then
  begin
    result:=Color;
    exit;
  end;
  result:=FPalette[tmpCount].Color; { return max }
End;

Function TCustom3DPaletteSeries.RangePercent(Const Percent:Double):TColor;
begin
  if MidColor=clNone then
     result:=RGB( IEndRed  +Round(Percent*IRangeRed),
                  IEndGreen+Round(Percent*IRangeGreen),
                  IEndBlue +Round(Percent*IRangeBlue))
  else
  if Percent<0.5 then
     result:=RGB( IEndRed  +Round((2.0*Percent)*IRangeRed),
                  IEndGreen+Round((2.0*Percent)*IRangeGreen),
                  IEndBlue +Round((2.0*Percent)*IRangeBlue))
  else
     result:=RGB( IMidRed  +Round(2.0*(Percent-0.5)*IRangeMidRed),
                  IMidGreen+Round(2.0*(Percent-0.5)*IRangeMidGreen),
                  IMidBlue +Round(2.0*(Percent-0.5)*IRangeMidBlue))
end;

Function TCustom3DPaletteSeries.GetValueColorValue(Const AValue:TChartValue):TColor;
var tmp : Double;
begin
  if UseColorRange then
  begin
    if IValueRangeInv=0 then
       result:=EndColor
    else
    begin
      tmp:=AValue-MandatoryValueList.MinValue;
      if tmp<0 then result:=EndColor
      else
      if AValue>MandatoryValueList.MaxValue then
         result:=StartColor
      else
         result:=RangePercent(tmp*IValueRangeInv);
    end;
  end
  else
  if UsePalette and (Length(FPalette)>0) then
     result:=GetSurfacePaletteColor(AValue)
  else
     result:=SeriesColor;
end;

Function TCustom3DPaletteSeries.GetValueColor(ValueIndex:Integer):TColor;
Begin
  result:=InternalColor(ValueIndex);
  if result=clTeeColor then
  begin
    if FUseColorRange or FUsePalette then
       result:=GetValueColorValue(MandatoryValueList.Value[ValueIndex])
    else
       result:=inherited GetValueColor(ValueIndex);
  end;
  {
  result:=inherited GetValueColor(ValueIndex);
  if (result<>clNone) and (not ColorEachPoint) then
     if (FUseColorRange or FUsePalette) and (result=clTeeColor) then
        result:=GetValueColorValue(MandatoryValueList.Value[ValueIndex])
     else
     if result=clTeeColor then result:=SeriesColor;
  }
  if Assigned(FOnGetColor) then FOnGetColor(Self,ValueIndex,result);
End;

Function TCustom3DPaletteSeries.CountLegendItems:Integer;
begin
  if (Count>0) and (UseColorRange or UsePalette) then
  begin
    result:=Length(FPalette);
    if FLegendEvery>1 then result:=(result div FLegendEvery)+1;
  end
  else
     result:=inherited CountLegendItems;
end;

Function TCustom3DPaletteSeries.LegendString( LegendIndex:Integer;
                                              LegendTextStyle:TLegendTextStyle
                                              ):String;
var tmp : TChartValue;
begin
  if UseColorRange or UsePalette then
  begin
    if CountLegendItems>LegendIndex then
    begin
      tmp:=FPalette[LegendPaletteIndex(LegendIndex)].UpToValue;
      result:=FormatFloat(ValueFormat,tmp);
    end
    else
       result:='';
  end
  else result:=inherited LegendString(LegendIndex,LegendTextStyle);
end;

Function TCustom3DPaletteSeries.LegendPaletteIndex(LegendIndex:Integer):Integer;
begin
  result:=Length(FPalette)-(FLegendEvery*LegendIndex)-1;
end;

Function TCustom3DPaletteSeries.LegendItemColor(LegendIndex:Integer):TColor;
begin
  if UseColorRange or UsePalette then
     result:=GetValueColorValue(FPalette[LegendPaletteIndex(LegendIndex)].UpToValue)
  else
     result:=inherited LegendItemColor(LegendIndex);
end;

Procedure TCustom3DPaletteSeries.SetPaletteSteps(Const Value:Integer);
Begin
  FPaletteSteps:=Value;
  CreateDefaultPalette(FPaletteSteps);
End;

Procedure TCustom3DPaletteSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  UseColorRange:=False;
  if IsEnabled then Pen.Color:=clBlack
               else Pen.Color:=clGray;
  UsePalette:=IsEnabled;
end;

Procedure TCustom3DPaletteSeries.Assign(Source:TPersistent);
begin
  if Source is TCustom3DPaletteSeries then
  With TCustom3DPaletteSeries(Source) do
  begin
    Self.FUsePalette   :=FUsePalette;
    Self.FUseColorRange:=FUseColorRange;
    Self.FStartColor   :=FStartColor;
    Self.FEndColor     :=FEndColor;
    Self.FMidColor     :=FMidColor;
    Self.FLegendEvery  :=FLegendEvery;
    Self.FPaletteSteps :=FPaletteSteps;
    Self.FPalette      :=FPalette;
    Self.FUsePaletteMin:=FUsePaletteMin;
    Self.FPaletteStep  :=FPaletteStep;
    Self.FPaletteMin   :=FPaletteMin;
  end;
  inherited;
end;

Procedure TCustom3DPaletteSeries.CheckPaletteEmpty;
begin
  if (Count>0) and (Length(FPalette)=0) then
     CreateDefaultPalette(FPaletteSteps);
end;

Procedure TCustom3DPaletteSeries.DoBeforeDrawChart;
begin
  inherited;
  CheckPaletteEmpty;

  { internal }
  IValueRangeInv:=MandatoryValueList.Range;
  if IValueRangeInv<>0 then IValueRangeInv:=1/IValueRangeInv;
end;

Procedure TCustom3DPaletteSeries.DrawLegendShape(ValueIndex:Integer;
                                                 Const Rect:TRect);
var R : TRect;
begin
  if (ValueIndex=-1) and UseColorRange then
  begin
    ParentChart.Canvas.Brush.Style:=bsClear;
    ParentChart.Canvas.Rectangle(Rect);  { <-- rectangle }
    with TChartGradient.Create(nil) do
    try
      // set inverted colors
      StartColor:=Self.EndColor;
      MidColor:=Self.MidColor;
      EndColor:=Self.StartColor;
      // draw
      R:=Rect;
      InflateRect(R,-1,-1);
      Draw(ParentChart.Canvas,R);
    finally
      Free;
    end;
  end
  else inherited;
end;

class Function TCustom3DPaletteSeries.GetEditorClass:String;
Begin
  result:='TGrid3DSeriesEditor'; { <-- dont translate ! }
end;

Procedure TCustom3DPaletteSeries.Clear;
begin
  inherited;
  if FUsePalette then ClearPalette;
end;

class procedure TCustom3DPaletteSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_ColorRange);
end;

class procedure TCustom3DPaletteSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TCustom3DPaletteSeries(ASeries) do
  Case Index of
    1: begin UseColorRange:=True; UsePalette:=False; end;
  else inherited;
  end;
end;

procedure TCustom3DPaletteSeries.CreateRangePalette;
var tmp     : Double;
    Delta   : Double;
    t       : Integer;
begin
  Delta:=MandatoryValueList.Range;
  ClearPalette;
  tmp:=Delta/PaletteSteps;
  for t:=1 to PaletteSteps do
    if Delta>0 then
      AddPalette(MandatoryValueList.MinValue+tmp*t,RangePercent(tmp*t/Delta))
    else
      AddPalette(MandatoryValueList.MinValue,RGB(IEndRed,IEndGreen,IEndBlue));
end;

Procedure TCustom3DPaletteSeries.GalleryChanged3D(Is3D:Boolean);
Const Rots:Array[Boolean] of Integer=(0,335);
      Elev:Array[Boolean] of Integer=(270,340);
      Pers:Array[Boolean] of Integer=(0,60);
begin
  ParentChart.View3D:=True;
  With ParentChart.View3DOptions do
  begin
    Zoom:=60;
    VertOffset:=-2;
    Rotation:=Rots[Is3D];
    Elevation:=Elev[Is3D];
    Perspective:=Pers[Is3D];
  end;
end;

procedure TCustom3DPaletteSeries.SetPaletteStyle(
  const Value: TTeePaletteStyle);
begin
  if FPaletteStyle<>Value then
  begin
    FPaletteStyle:=Value;
    ClearPalette;
    Repaint;
  end;
end;

procedure TCustom3DPaletteSeries.SetPaletteMin(const Value: Double);
begin
  FPaletteMin:=Value;
  CreateDefaultPalette(FPaletteSteps);
end;

procedure TCustom3DPaletteSeries.SetPaletteStep(const Value: Double);
begin
  FPaletteStep:=Value;
  CreateDefaultPalette(FPaletteSteps);
end;

procedure TCustom3DPaletteSeries.SetUsePaletteMin(const Value: Boolean);
begin
  FUsePaletteMin:=Value;
  CreateDefaultPalette(FPaletteSteps);
end;

procedure TCustom3DPaletteSeries.SetLegendEvery(const Value: Integer);
begin
  SetIntegerProperty(FLegendEvery,Value);
end;

{ TCustom3DGridSeries }
Constructor TCustom3DGridSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FNumXValues:=10;
  FNumZValues:=10;
  Clear;
End;

(*
Procedure TCustom3DGridSeries.ClearGridIndex;
//var t : Integer;
begin
  SetLength(FGridIndex,0,0);
//  for t:=0 to Length(FGridIndex)-1 do FGridIndex[t]:=nil; // 6.0
//  FGridIndex:=nil;

{  for t:=1 to MaxAllowedCells do
  if Assigned(FGridIndex[t]) then
  begin
    Dispose(FGridIndex[t]);
    FGridIndex[t]:=nil;
  end;}
end;
*)

Procedure TCustom3DGridSeries.Clear;
begin
  inherited;
  XValues.Order:=loNone;
  InitGridIndex(NumXValues,NumZValues);
  //ClearGridIndex;
end;

(*
Function TCustom3DGridSeries.GetGridIndex(X,Z:Integer):Integer;
begin
  if (Length(FGridIndex)>=x) and (Length(FGridIndex[x])>=z) then
     result:=FGridIndex[x,z]
  else
     result:=-1;
end;

Procedure TCustom3DGridSeries.SetGridIndex(X,Z,Value:Integer);
begin
  if X>(Length(FGridIndex)-1) then
     SetLength(FGridIndex,X+1);
  if Z>(Length(FGridIndex[x])-1) then SetLength(FGridIndex[x],Z+1);

  FGridIndex[x,z]:=Value;

  {if (X>=1) and (X<=MaxAllowedCells) and
     (Z>=1) and (Z<=MaxAllowedCells) then
  InternalSetGridIndex(x,z,value);
  }
end;
*)

(*
Procedure TCustom3DGridSeries.InternalSetGridIndex(X,Z,Value:Integer);
//var t : Integer;
begin

{  if not Assigned(FGridIndex[x]) then
  begin
    New(FGridIndex[x]); 6.0
    for t:=1 to MaxAllowedCells do FGridIndex[x]^[t]:=-1;
  end;
  }
  FGridIndex[x][z]:=Value;
end;
*)

Procedure TCustom3DGridSeries.InitGridIndex(XCount,ZCount:Integer);
var x : Integer;
    z : Integer;
begin
  SetLength(GridIndex,XCount+1,ZCount+1);
  for x:=0 to XCount do
      for z:=0 to ZCount do GridIndex[x,z]:=-1;
end;

Procedure TCustom3DGridSeries.FillGridIndex;
Var MinX   : TChartValue;
    MinZ   : TChartValue;
    XCount : Integer;
    ZCount : Integer;

  Procedure FillIrregularGrid;
  Const MaxAllowedCells=2000; { max 2000 x 2000 cells }
  type TIrregValues=packed Array[0..MaxAllowedCells-1] of TChartValue;

    Procedure SearchValue(Var ACount:Integer; Var Values:TIrregValues; Const AValue:TChartValue);
    var t : Integer;
    begin
      t:=0;
      while t<ACount do
      begin
        if Values[t]=AValue then Break
        else
        begin
          Inc(t);
          if t=ACount then
          begin
            Values[t]:=AValue;
            Inc(ACount);
          end;
        end;
      end;
    end;

    Procedure SortValues(ACount:Integer; Var Values:TIrregValues);
    var t        : Integer;
        tt       : Integer;
        tmpMin   : TChartValue;
        tmpIndex : Integer;
    begin
      for t:=1 to ACount-2 do {min already at 0}
      begin
        tmpMin:=Values[t];
        tmpIndex:=t;
        for tt:=t+1 to ACount-1 do  {get minimum }
        begin
          if Values[tt]<tmpMin then
          begin
            tmpMin:=Values[tt];
            tmpIndex:=tt;
          end;
          if tmpIndex<>t then
          begin
            Values[tmpIndex]:=Values[t];
            Values[t]:=tmpMin;
          end;
        end;
      end;
     end;

    Function ValuePosition(ACount:Integer; Const Values:TIrregValues;
                                           Const AValue:TChartValue):Integer;
    begin
      result:=0;
      while (AValue<>Values[result]) and (result<ACount) do Inc(result);
      Inc(result);
    end;

  Var XVals : TIrregValues;
      ZVals : TIrregValues;
      t     : Integer;
  begin
    XCount:=1;
    XVals[0]:=MinX;
    ZCount:=1;
    ZVals[0]:=MinZ;

    for t:=0 to Count-1 do
    begin
      SearchValue(XCount,XVals,XValues.Value[t]);
      SearchValue(ZCount,ZVals,ZValues.Value[t]);
    end;

    SortValues(XCount,XVals);
    SortValues(ZCount,ZVals);

    InitGridIndex(XCount,ZCount);

    { use sorted xvals and zvals to index Mandatory ValueList in grid }
    for t:=0 to Count-1 do
        GridIndex[ ValuePosition(XCount,XVals,XValues.Value[t]),
                   ValuePosition(ZCount,ZVals,ZValues.Value[t])  ]:=t;
  end;

  Procedure FillRegularGrid;
  var t : Integer;
  begin
    XCount:=1+Round(XValues.MaxValue-MinX);
    ZCount:=1+Round(ZValues.MaxValue-MinZ);

    InitGridIndex(XCount,ZCount);

    for t:=0 to Count-1 do
        GridIndex[ 1+Round(XValues.Value[t]-MinX),
                   1+Round(ZValues.Value[t]-MinZ)  ]:=t;

      //InternalSetGridIndex(1+Round(XValues.Value[t]-MinX),1+Round(ZValues.Value[t]-MinZ),t);
  end;

begin
  MinX:=XValues.MinValue;
  MinZ:=ZValues.MinValue;
  if FIrregularGrid then FillIrregularGrid
                    else FillRegularGrid;
  if XCount<>FNumXValues then FNumXValues:=XCount;  { 5.01 }
  if ZCount<>FNumZValues then FNumZValues:=ZCount;  { 5.01 }
end;

Function TCustom3DGridSeries.GetXZValue(X,Z:Integer):TChartValue;
Begin
  if Assigned(FOnGetYValue) then result:=FOnGetYValue(Self,X,Z)
  else  { default sample random surface value formula }
  if (csDesigning in ComponentState) or
     (IInGallery) then
     result:=0.5*Sqr(Cos(x/(FNumXValues*0.2)))+
                 Sqr(Cos(z/(FNumZValues*0.2)))-
                 Cos(z/(FNumZValues*0.5))
  else
     result:=0;
end;

Function TCustom3DGridSeries.NumSampleValues:Integer;
begin
  result:=FNumXValues;
end;

Procedure TCustom3DGridSeries.ReCreateValues;
Begin
  CreateValues(FNumXValues,FNumZValues);
end;

Procedure TCustom3DGridSeries.SetNumXValues(Value:Integer);
Begin
  if Value<>FNumXValues then
  begin
    FNumXValues:=Value;
    Clear;
    ReCreateValues;
  end;
End;

Procedure TCustom3DGridSeries.SetNumZValues(Value:Integer);
Begin
  if Value<>FNumZValues then
  begin
    FNumZValues:=Value;
    Clear;
    ReCreateValues;
  end;
End;

Procedure TCustom3DGridSeries.AddValues(Source:TChartSeries);
Begin
  if Source is TCustom3DGridSeries then
  With TCustom3DGridSeries(Source) do
  begin
    Self.FNumXValues:=FNumXValues;
    Self.FNumZValues:=FNumZValues;
  end;

  inherited;
  
  FillGridIndex;
  Repaint;
end;

Procedure TCustom3DGridSeries.Assign(Source:TPersistent);
begin
  if Source is TCustom3DGridSeries then
  With TCustom3DGridSeries(Source) do
  begin
    Self.FNumXValues   :=FNumXValues;
    Self.FNumZValues   :=FNumZValues;
    Self.FIrregularGrid:=FIrregularGrid;
  end;
  inherited;
end;

Procedure TCustom3DGridSeries.SetIrregularGrid(Const Value:Boolean);
begin
  SetBooleanProperty(FIrregularGrid,Value);
end;

Function TCustom3DGridSeries.CanCreateValues:Boolean;
begin
  result:= Assigned(FOnGetYValue) or (csDesigning in ComponentState)
           or IInGallery;
end;

Procedure TCustom3DGridSeries.CreateValues(NumX,NumZ:Integer);
var x           : Integer;
    z           : Integer;
    OldCapacity : Integer;
Begin
  if CanCreateValues then
  begin
    FNumXValues:=NumX;
    FNumZValues:=NumZ;

    OldCapacity:=TeeDefaultCapacity;
    TeeDefaultCapacity:=NumX*NumZ;
    try
      Clear;
      BeginUpdate;
      for z:=1 to NumZ do
          for x:=1 to NumX do AddXYZ(X,GetXZValue(X,Z),Z);
      EndUpdate;
    finally
      TeeDefaultCapacity:=OldCapacity;
    end;

    CreateDefaultPalette(FPaletteSteps);
  end;
End;

Procedure TCustom3DGridSeries.AddSampleValues(NumValues:Integer);
var OldGallery : Boolean;
Begin
  if NumValues>0 then
  begin
    OldGallery:=IInGallery;
    IInGallery:=True;
    try
      CreateValues(NumValues,NumValues);
    finally
      IInGallery:=OldGallery;
    end;
  end;
End;

Procedure TCustom3DGridSeries.DoBeforeDrawChart;
begin
  inherited;
  if Count>0 then FillGridIndex;
end;

Function TCustom3DGridSeries.ExistFourGridIndex(X,Z:Integer):Boolean;
begin
//  if (Length(GridIndex)>(x+InextXCell)) then
//  begin
//    if Length(GridIndex[x+INextXCell])>(z+INextZCell) then
//    begin
      //if Assigned(FGridIndex[x]) and Assigned(FGridIndex[x+INextXCell]) then
//      begin

        ValueIndex0:=GridIndex[x,z];
        if ValueIndex0>-1 then
        begin
          ValueIndex1:=GridIndex[x+INextXCell,z];
          if ValueIndex1>-1 then
          begin
            ValueIndex2:=GridIndex[x+INextXCell,z+INextZCell];
            if ValueIndex2>-1 then
            begin
              ValueIndex3:=GridIndex[x,z+INextZCell];
              result:=ValueIndex3>-1;
              exit;
            end;
          end;
        end;

//      end;
//    end
//    else result:=False;
//  end
//  else result:=False;

  result:=False;
end;

function TCustom3DGridSeries.IsValidSeriesSource(Value:TChartSeries):Boolean;
begin
  result:=Value is TCustom3DGridSeries;
end;

function TCustom3DGridSeries.GetValue(X, Z: Integer): TChartValue;
var tmp : Integer;
begin
  tmp:=GridIndex[x,z];
  if tmp<>-1 then result:=YValues.Value[tmp]
             else Raise Exception.CreateFmt('No value found at XZ: %d %d',[x,z]);
end;

procedure TCustom3DGridSeries.SetValue(X, Z: Integer;
  const Value: TChartValue);
var tmp : Integer;
begin
  tmp:=GridIndex[x,z];
  if tmp<>-1 then YValues.Value[tmp]:=Value
             else GridIndex[x,z]:=AddXYZ(x,Value,z);
end;

{ TSurfaceSeries }
Constructor TSurfaceSeries.Create(AOwner: TComponent);
Begin
  inherited;
  INextXCell:=-1;
  INextZCell:=-1;
  FSideBrush:=TChartBrush.Create(CanvasChanged);
  FSideBrush.Style:=bsClear;
  FSideLines:=TChartHiddenPen.Create(CanvasChanged);
  FWaterLines:=CreateChartPen;
End;

Destructor TSurfaceSeries.Destroy;
Begin
  FSideLines.Free;
  FSideBrush.Free;
  FWaterLines.Free;
  inherited;
End;

class Function TSurfaceSeries.GetEditorClass:String;
Begin
  result:='TSurfaceSeriesEditor'; { <-- dont translate ! }
end;

Procedure TSurfaceSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  IInGallery:=True;
  CreateValues(10,10);
end;

Function TSurfaceSeries.CalcPointPos(Index:Integer):TPoint;
begin
  result.x:=GetHorizAxis.CalcXPosValue(XValues.Value[Index]);
  result.y:=GetVertAxis.CalcYPosValue(YValues.Value[Index]);
end;

Function TSurfaceSeries.FourGridIndex(x,z:Integer):Boolean;
begin
  result:=ExistFourGridIndex(x,z);
  if result then
  begin
    Points[0]:=CalcPointPos(ValueIndex0);
    Points[1]:=CalcPointPos(ValueIndex1);
    Points[2]:=CalcPointPos(ValueIndex2);
    Points[3]:=CalcPointPos(ValueIndex3);
  end;
end;

Function TSurfaceSeries.Clicked(x,y:Integer):Integer;
var tmpX : Integer;
    tmpZ : Integer;
begin
  if Count>0 then
  begin
    INextXCell:=-1;
    INextZCell:=-1;
    for tmpX:=2 to FNumXValues do
      for tmpZ:=2 to FNumZValues do { front to back... }
        if FourGridIndex(tmpX,tmpZ) and
           PointInPolygon(TeePoint(x,y),Points) then
        begin
          result:=ValueIndex0;
          exit;
        end;
  end;
  result:=TeeNoPointClicked;
end;

procedure TSurfaceSeries.SetSideBrush(Value:TChartBrush);
begin
  FSideBrush.Assign(Value);
end;

procedure TSurfaceSeries.SetSideLines(Value:TChartHiddenPen);
begin
  FSideLines.Assign(Value);
end;

type TChartAccess=class(TCustomChart);

Procedure TSurfaceSeries.DrawAllValues;

  Procedure DrawCells;
  var x   : Integer;
      z   : Integer;
      tmp : Integer;
  begin
    if FWaterFall then tmp:=0 else tmp:=1;

    if ParentChart.DepthAxis.Inverted then
    begin
      INextZCell:=1;
      if not DrawValuesForward then
      begin
        INextXCell:=1;
        for x:=FNumXValues-1 downto 1 do
            for z:=1 to FNumZValues-tmp do DrawCell(x,z)
      end
      else
      begin
        INextXCell:=-1;
        for x:=2 to FNumXValues do
            for z:=1 to FNumZValues-tmp do DrawCell(x,z);
      end;
    end
    else
    begin
      INextZCell:=-1;
      if not DrawValuesForward then
      begin
        INextXCell:=1;
        for x:=FNumXValues-1 downto 1 do
            for z:=FNumZValues downto 1+tmp do DrawCell(x,z)
      end
      else
      begin
        INextXCell:=-1;
        for x:=2 to FNumXValues do
            for z:=FNumZValues downto 1+tmp do DrawCell(x,z);
      end;
    end;
  end;

  Procedure FastDraw;
  var tmpStyle : TTeeCanvasSurfaceStyle;
  begin
    if FWireFrame then tmpStyle:=tcsWire else
    if FDotFrame then tmpStyle:=tcsDot else tmpStyle:=tcsSolid;

    if Transparency>0 then
       IBlender:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),Transparency);

    ParentChart.Canvas.Surface3D(tmpStyle,FSameBrush,FNumXValues,
                                 FNumZValues,FastCalcPoints);

    if Transparency>0 then
       ParentChart.Canvas.EndBlending(IBlender);
  end;

  Procedure DrawSides(BeforeCells:Boolean);
  Var tmpYOrigin : Integer;

    Function DrawFrontSideFirst:Boolean;
    var P : TFourPoints;
        tmpBottom : Integer;
    begin
      With TChartAccess(ParentChart),ChartRect do
      begin
        P[0]:=Canvas.Calculate3DPosition(Right,Top,0);
        tmpBottom:=Bottom+CalcWallSize(BottomAxis);
        P[1]:=Canvas.Calculate3DPosition(Right,tmpBottom,0);
        P[2]:=Canvas.Calculate3DPosition(Left,tmpBottom,0);
      end;
      result:=not TeeCull(P);
    end;

    Function CalcOnePoint(tmpRow,t:Integer; Var P0,P1:TPoint):Integer;
    Var tmpIndex : Integer;
    begin
      tmpIndex:=GridIndex[tmpRow,t];
      if tmpIndex<>-1 then
      begin
        P0:=CalcPointPos(tmpIndex);
        P1.x:=P0.x;
        P1.y:=tmpYOrigin;
        result:=CalcZPos(tmpIndex);
      end
      else result:=0;
    end;

  var tmpPoints  : TFourPoints;
      t          : Integer;
      z0         : Integer;
      z1         : Integer;
      tmpRow     : Integer;
      tmpP       : TPoint;
      tmpLeft    : Boolean;
      tmpFront   : Boolean;
      tmpRight   : Boolean;
  begin
    With ParentChart.Canvas do
    begin
      AssignBrush(FSideBrush,FSideBrush.Color);
      AssignVisiblePen(FSideLines);
    end;

    With GetVertAxis do
    if Inverted then tmpYOrigin:=CalcYPosValue(YValues.MaxValue)
                else tmpYOrigin:=CalcYPosValue(YValues.MinValue);

    with TChartAccess(ParentChart) do
    begin
      tmpLeft:=DrawLeftWallFirst;
      tmpRight:=DrawRightWallAfter;
    end;

    if (tmpLeft and (not BeforeCells)) or
       ((not tmpLeft) and BeforeCells) then
    begin
      if GetHorizAxis.Inverted then tmpRow:=FNumXValues
                               else tmpRow:=1;
      for t:=FNumZValues downto 2 do
      begin
        Z0:=CalcOnePoint(tmpRow,t,tmpPoints[0],tmpPoints[1]);
        Z1:=CalcOnePoint(tmpRow,t-1,tmpPoints[3],tmpPoints[2]);
        ParentChart.Canvas.PlaneFour3D(tmpPoints,Z0,Z1);
      end;
    end;

    if (tmpRight and (not BeforeCells)) or
       ((not tmpRight) and BeforeCells) then
    begin
      if GetHorizAxis.Inverted then tmpRow:=1
                               else tmpRow:=FNumXValues;
      for t:=FNumZValues downto 2 do
      begin
        Z0:=CalcOnePoint(tmpRow,t,tmpPoints[0],tmpPoints[1]);
        Z1:=CalcOnePoint(tmpRow,t-1,tmpPoints[3],tmpPoints[2]);
        ParentChart.Canvas.PlaneFour3D(tmpPoints,Z0,Z1);
      end;
    end;

    tmpFront:=not DrawFrontSideFirst;

    if (tmpFront and (not BeforeCells)) or
       ((not tmpFront) and BeforeCells) then
    begin
      if ParentChart.DepthAxis.Inverted then tmpRow:=FNumZValues
                                        else tmpRow:=1;
      z0:=0;
      for t:=2 to FNumXValues do
      begin
        Z0:=CalcOnePoint(t,tmpRow,tmpPoints[0],tmpPoints[1]);
        Z1:=CalcOnePoint(t-1,tmpRow,tmpPoints[3],tmpPoints[2]);
        if t=FNumXValues then tmpP:=tmpPoints[0];
        ParentChart.Canvas.PlaneFour3D(tmpPoints,Z0,Z1);
      end;

      with ParentChart.Canvas do
      begin
        Pen.Style:=psSolid;
        VertLine3D(tmpP.X,tmpP.Y,tmpYOrigin,Z0);
      end;
    end;
  end;

  Procedure PrepareCanvas;
  begin
    With ParentChart.Canvas do
    begin
      if (not Self.Pen.Visible) and
         (not FWireFrame)   and
         (not FDotFrame) then Pen.Style:=psClear
                         else AssignVisiblePen(Self.Pen);
      AssignBrush(Self.Brush,SeriesColor);
      FSameBrush:=((not FUseColorRange) and (not FUsePalette)) or
                  Assigned(Self.Brush.Image.Graphic);
      if FWireFrame or FDotFrame then Brush.Style:=bsClear;
    end;
  end;

var tmpSides : Boolean;
begin
  if Count>0 then
  begin
    PrepareCanvas;

    tmpSides:=(FSideBrush.Style<>bsClear) or FSideLines.Visible;

    if ParentChart.Canvas.SupportsFullRotation then
       FastDraw
    else
    begin
      if tmpSides then DrawSides(True);

      if Transparency>0 then
         IBlender:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),Transparency);

      DrawCells;

      if Transparency>0 then
         if ParentChart.Canvas.SupportsFullRotation then
            ParentChart.Canvas.EndBlending(IBlender)
         else
            IBlender.Free;
    end;

    if tmpSides then DrawSides(False);
  end;
end;

Function TSurfaceSeries.FastCalcPoints( x,z:Integer;
                                        Var P0,P1:TPoint3D;
                                        Var Color0,Color1:TColor):Boolean;
var tmp0 : TChartValue;
    tmp1 : TChartValue;
begin
  result:=False;

  ValueIndex0:=GridIndex[x-1,z];
  if ValueIndex0<>-1 then
  begin
    ValueIndex1:=GridIndex[x,z];
    if ValueIndex1<>-1 then
    begin
      With GetHorizAxis do
      begin
        P0.x:=CalcXPosValue(XValues.Value[ValueIndex0]);
        P1.x:=CalcXPosValue(XValues.Value[ValueIndex1]);
      end;

      P0.z:=CalcZPos(ValueIndex0);
      P1.z:=CalcZPos(ValueIndex1);
      tmp0:=YValues.Value[ValueIndex0];
      tmp1:=YValues.Value[ValueIndex1];

      With GetVertAxis do
      begin
        P0.y:=CalcYPosValue(tmp0);
        P1.y:=CalcYPosValue(tmp1);
      end;

      if not FSameBrush then
      begin
        Color0:=GetValueColorValue(tmp0);
        Color1:=GetValueColorValue(tmp1);
      end;

      result:=True;
    end;
  end;
end;

Procedure TSurfaceSeries.DrawCell(X,Z:Integer);
var tmpColor : TColor;
    Z0       : Integer;
    Z1       : Integer;

  Procedure DrawTheCell;
  var tmp      : Integer;
      IPoints  : TFourPoints;
  begin
    With ParentChart.Canvas do
    begin
      if FWaterFall then
      begin
        tmp:=GetVertAxis.IEndPos;
        if not FWireFrame then
        begin
          Pen.Style:=psClear;

          if Transparency>0 then
          begin
            IPoints[0]:=Calculate3DPosition(Points[0],Z0);
            IPoints[1]:=Calculate3DPosition(Points[1],Z0);
            IPoints[2]:=Calculate3DPosition(TeePoint(Points[1].X,tmp),Z0);
            IPoints[3]:=Calculate3DPosition(TeePoint(Points[0].X,tmp),Z0);

            if not SupportsFullRotation then
               IBlender.SetRectangle(RectFromPolygon(IPoints,4));

            Polygon(IPoints);

            if not SupportsFullRotation then
               IBlender.DoBlend(Transparency); // 5.03
          end
          else
            PlaneWithZ(Points[0],Points[1],
                       TeePoint(Points[1].X,tmp),
                       TeePoint(Points[0].X,tmp),
                       Z0);
        end;

        AssignVisiblePen(Self.Pen);
        LineWithZ(Points[0],Points[1],Z0);

        if WaterLines.Visible then
        begin
          AssignVisiblePen(WaterLines);
          VertLine3D(Points[0].X,Points[0].Y,tmp,Z0);
          VertLine3D(Points[1].X,Points[1].Y,tmp,Z0);
        end;
      end
      else
      if FDotFrame then
      begin
        With Points[0] do Pixels3D[X,Y,Z0]:=ValueColor[ValueIndex0];
        With Points[1] do Pixels3D[X,Y,Z0]:=ValueColor[ValueIndex1];
        With Points[2] do Pixels3D[X,Y,Z1]:=ValueColor[ValueIndex2];
        With Points[3] do Pixels3D[X,Y,Z1]:=ValueColor[ValueIndex3];
      end
      else
      begin
        if Transparency>0 then
        begin
          IPoints[0]:=Calculate3DPosition(Points[0],Z0);
          IPoints[1]:=Calculate3DPosition(Points[1],Z0);
          IPoints[2]:=Calculate3DPosition(Points[2],Z1);
          IPoints[3]:=Calculate3DPosition(Points[3],Z1);

          if not SupportsFullRotation then
             IBlender.SetRectangle(RectFromPolygon(IPoints,4));

          Polygon(IPoints);

          if not SupportsFullRotation then
             IBlender.DoBlend(Transparency); // 5.03
        end
        else
          PlaneFour3D(Points,Z0,Z1);
      end;
    end;
  end;

var tmp : Boolean;
Begin
  tmp:=False;
  if FWaterFall then
  begin
    ValueIndex0:=GridIndex[x,z];
    if ValueIndex0>-1 then
    begin
      ValueIndex1:=GridIndex[x+INextXCell,z];
      if ValueIndex1>-1 then
      begin
        Points[0]:=CalcPointPos(ValueIndex0);
        Points[1]:=CalcPointPos(ValueIndex1);
        tmp:=True;
      end;
    end;
  end
  else
  if FourGridIndex(X,Z) then
  begin
    Z1:=CalcZPos(ValueIndex2);
    tmp:=True;
  end;

  if tmp then
  begin
    if INextXCell=1 then tmpColor:=ValueColor[ValueIndex0]
                    else tmpColor:=ValueColor[ValueIndex1];

    if tmpColor<>clNone then
    begin
      Z0:=CalcZPos(ValueIndex0);

      if not FSameBrush then
      begin
        if FSmoothPalette then
           with YValues do
           tmpColor:=GetValueColorValue(( Value[ValueIndex0]+
                                          Value[ValueIndex1]+
                                          Value[ValueIndex2]+
                                          Value[ValueIndex3])*0.25);

        if FWireFrame then ParentChart.Canvas.Pen.Color:=tmpColor
                      else ParentChart.Canvas.Brush.Color:=tmpColor;
      end;

      DrawTheCell;
    end;
  end;
end;

Procedure TSurfaceSeries.SetDotFrame(Value:Boolean);
Begin
  if Value then
  begin
    Pen.Visible:=True;
    FWireFrame:=False;
  end;
  SetBooleanProperty(FDotFrame,Value);
End;

Procedure TSurfaceSeries.SetWaterFall(Value:Boolean);
Begin
  SetBooleanProperty(FWaterFall,Value);
End;

Procedure TSurfaceSeries.SetWireFrame(Value:Boolean);
Begin
  if Value then
  begin
    Pen.Visible:=True;
    FDotFrame:=False;
  end;
  SetBooleanProperty(FWireFrame,Value);
End;

Procedure TSurfaceSeries.SetSmoothPalette(Value:Boolean);
begin
  SetBooleanProperty(FSmoothPalette,Value);
end;

Procedure TSurfaceSeries.Assign(Source:TPersistent);
begin
  if Source is TSurfaceSeries then
  With TSurfaceSeries(Source) do
  begin
    Self.FDotFrame     := FDotFrame;
    Self.SideBrush     := FSideBrush;
    Self.SideLines     := FSideLines;
    Self.FSmoothPalette:= FSmoothPalette;
    Self.FTransparency := FTransparency;
    Self.FWaterFall    := FWaterFall;
    Self.WaterLines    := WaterLines;
    Self.FWireFrame    := FWireFrame;
  end;
  inherited;
end;

class procedure TSurfaceSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_WireFrame);
  AddSubChart(TeeMsg_DotFrame);
  AddSubChart(TeeMsg_Sides);
  AddSubChart(TeeMsg_NoBorder);
end;

class procedure TSurfaceSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TSurfaceSeries(ASeries) do
  Case Index of
    2: WireFrame:=True;
    3: DotFrame:=True;
    4: SideBrush.Style:=bsSolid;
    5: Pen.Visible:=False;
  else inherited;
  end;
end;

procedure TSurfaceSeries.SetWaterLines(const Value: TChartPen);
begin
  FWaterLines.Assign(Value);
end;

procedure TSurfaceSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

{ TContourSeries }
Constructor TContourSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FLevels:=TContourLevels.Create(Self,TContourLevel);
  FSmoothing:=TSmoothPoints.Create(Self);
  FAutomaticLevels:=True;
  ColorEachPoint:=True;
  FNumLevels:=10;
End;

Destructor TContourSeries.Destroy;
begin
  FSmoothing.Free;
  IModifyingLevels:=True;
  FLevels.Free;
  IModifyingLevels:=False;
  inherited;
end;

Procedure TContourSeries.Assign(Source:TPersistent);
begin
  if Source is TContourSeries then
  With TContourSeries(Source) do
  begin
    Self.FAutomaticLevels:=FAutomaticLevels;
    Self.Levels          :=FLevels;
    Self.FNumLevels      :=FNumLevels;
    Self.FYPosition      :=FYPosition;
    Self.FYPositionLevel :=FYPositionLevel;
  end;
  inherited;
end;

Procedure TContourSeries.SetNumLevels(Value:Integer);
begin
  SetIntegerProperty(FNumLevels,Value);
  if AutomaticLevels then
  begin
    Levels.Clear;
    AutomaticLevels:=True;
  end;
end;

Procedure TContourSeries.SetYPosition(Const Value:Double);
begin
  SetDoubleProperty(FYPosition,Value);
end;

Procedure TContourSeries.SetYPositionLevel(Value:Boolean);
begin
  SetBooleanProperty(FYPositionLevel,Value);
end;

procedure TContourSeries.DrawAllValues;
type
  TLevelLineXY={$IFDEF LEVELSEGMENTS}TChartValue{$ELSE}Integer{$ENDIF};

  TLevelLine=packed record
    x1,z1,x2,z2 : TLevelLineXY;
  end;

  TTempLevel=packed record { temporary cache of level properties }
    UpToValue : TChartValue;
    Color     : TColor;
    {$IFNDEF LEVELSEGMENTS}
    Count     : Integer;
    Allocated : Integer;
    Line      : Array of TLevelLine;
    {$ENDIF}
    Pen       : TChartPen;
  end;

Var DifY     : Array[0..4] of TChartValue;
    CellX    : Array[0..4] of TLevelLineXY;
    CellZ    : Array[0..4] of TLevelLineXY;
    ILevels  : Array of TTempLevel;
    tmpZAxis : TChartAxis;

  Procedure CalcLevel(TheLevel:Integer);
  var m1 : Integer;
      m3 : Integer;

    Procedure CalcLinePoints(Side:Integer);

      Procedure PointSect(p1,p2:Integer; Var Ax,Az:TLevelLineXY);
      var tmp : TChartValue;
      begin
        { calculate crossing XY point, return pixel coordinates }
        tmp:=DifY[p2]-DifY[p1];
        if tmp<>0 then
        begin
          tmp:=1/tmp;
          {$IFDEF LEVELSEGMENTS}
          Ax:=(DifY[p2]*CellX[p1]-DifY[p1]*CellX[p2])*tmp;
          Az:=(DifY[p2]*CellZ[p1]-DifY[p1]*CellZ[p2])*tmp;
          {$ELSE}
          Ax:=Round((DifY[p2]*CellX[p1]-DifY[p1]*CellX[p2])*tmp);
          Az:=Round((DifY[p2]*CellZ[p1]-DifY[p1]*CellZ[p2])*tmp);
          {$ENDIF}
        end
        else
        begin
          {$IFDEF LEVELSEGMENTS}
          Ax:=CellX[p2]-CellX[p1];
          Az:=CellZ[p2]-CellZ[p1];
          {$ELSE}
          Ax:=Round(CellX[p2]-CellX[p1]);
          Az:=Round(CellZ[p2]-CellZ[p1]);
          {$ENDIF}
        end;
      end;

      {$IFDEF LEVELSEGMENTS}
      // For each calculated line (x1z1->x2z2) in level,
      // try to merge it with other lines to define "segments".
      // For each segment, try to merge it with other segments to
      // construct a longer (and if possible, unique) segment.
      Procedure AddSegmentLine(const x1,z1,x2,z2:TLevelLineXY);

        // Creates a new segment, initializes it with two points (x1z1 and x2z2)
        Procedure AddNewSegment(const x1,z1,x2,z2:TLevelLineXY);
        var tmp : Integer;
        begin
          with Levels[TheLevel] do
          begin
            SetLength(FSegments,Length(FSegments)+1);
            tmp:=Length(FSegments)-1;
            SetLength(FSegments[tmp].Points,2);
            FSegments[tmp].Points[0].x:=x1;
            FSegments[tmp].Points[0].y:=z1;
            FSegments[tmp].Points[1].x:=x2;
            FSegments[tmp].Points[1].y:=z2;
          end;
        end;

        // Add a new empty point to a segment
        Procedure InsertPoint(NumSegment:Integer; AtPos:Integer);
        var t : Integer;
        begin
          with Levels[TheLevel].FSegments[NumSegment] do
          begin
            SetLength(Points,Length(Points)+1);
            for t:=Length(Points)-1 downto AtPos+1 do
                Points[t]:=Points[t-1];
          end;
        end;

        // Remove "Num" segment
        Procedure DeleteSegment(Num:Integer);
        var t : Integer;
        begin
          with Levels[TheLevel] do
          begin
            FSegments[Num].Points:=nil; // deallocate memory
            for t:=Num to Length(FSegments)-2 do
                FSegments[t]:=FSegments[t+1];
            SetLength(FSegments,Length(FSegments)-1);
          end;
        end;

        Function CloserPoint(const P1,P2:TLevelPoint):Integer;
        const Tolerance=0.001;
        var dist1Start,
            dist2Start,
            dist1End,
            dist2End   : TLevelLineXY;
        begin
           result:=-1;

           dist1start:=Abs(x1-P1.x)+Abs(z1-P1.y);
           dist2start:=Abs(x2-P1.x)+Abs(z2-P1.y);
           dist1end:=Abs(x1-P2.x)+Abs(z1-P2.y);
           dist2end:=Abs(x2-P2.x)+Abs(z2-P2.y);

           if dist1Start<=Tolerance then
           begin
             if (dist1Start<=dist2Start) and
                (dist1Start<=dist1End) and
                (dist1Start<=dist2End) then result:=0
           end;

           if dist2Start<=Tolerance then
           begin
             if (dist2Start<=dist1Start) and
                (dist2Start<=dist1End) and
                (dist2Start<=dist2End) then result:=2
           end;

           if dist1End<=Tolerance then
           begin
             if (dist1End<=dist1Start) and
                (dist1End<=dist2Start) and
                (dist1End<=dist2End) then result:=1
           end;

           if dist2End<=Tolerance then
           begin
             if (dist2End<=dist1Start) and
                (dist2End<=dist2Start) and
                (dist2End<=dist1End) then result:=3
           end;
        end;

        // After adding a new point to a segment, check if this segment
        // should be "connected" to another existing segment.
        procedure CheckOtherSegments(NumSegment:Integer; AtPos:Integer);

          // Returns true if point P is "close" to xy position
          Function PointClose(const x,y:TLevelLineXY; const P:TLevelPoint):Boolean;
          Const Tolerance=0.001;
          begin
            result:=(Abs(x-P.x)<=Tolerance) and (Abs(y-P.y)<=Tolerance);
          end;

        var t  : Integer;
            tt : Integer;
            P  : TLevelPoint;
            tmpNumPoints : Integer;
            tmpLength    : Integer;
        begin
          with Levels[TheLevel] do
          if Length(FSegments)>1 then
          begin
            P:=FSegments[NumSegment].Points[AtPos];
            tmpLength:=Length(FSegments[NumSegment].Points);

            for t:=0 to Length(FSegments)-1 do
            if t<>NumSegment then
            begin
              tmpNumPoints:=Length(FSegments[t].Points);

              if PointClose(P.X,P.Y,FSegments[t].Points[0]) then
              begin
                SetLength(FSegments[NumSegment].Points,tmpLength+tmpNumPoints-1);
                if AtPos<>0 then
                begin
                  for tt:=1 to tmpNumPoints-1 do
                      FSegments[NumSegment].Points[tmpLength+tt-1]:=FSegments[t].Points[tt];
                end
                else
                begin
                  for tt:=tmpLength-1 downto 0 do
                      FSegments[NumSegment].Points[tt+tmpNumPoints-1]:=FSegments[NumSegment].Points[tt];

                  for tt:=0 to tmpNumPoints-2 do
                      FSegments[NumSegment].Points[tt]:=FSegments[t].Points[tmpNumPoints-1-tt];
                end;

                DeleteSegment(t);
                break;
              end
              else
              if PointClose(P.X,P.Y,FSegments[t].Points[tmpNumPoints-1]) then
              begin
                SetLength(FSegments[NumSegment].Points,tmpLength+tmpNumPoints-1);
                if AtPos<>0 then
                begin
                  for tt:=0 to tmpNumPoints-2 do
                      FSegments[NumSegment].Points[tmpLength+tt]:=FSegments[t].Points[tmpNumPoints-2-tt];
                end
                else
                begin
                  for tt:=tmpLength-1 downto 0 do
                      FSegments[NumSegment].Points[tt+tmpNumPoints-1]:=FSegments[NumSegment].Points[tt];

                  for tt:=0 to tmpNumPoints-2 do
                      FSegments[NumSegment].Points[tt]:=FSegments[t].Points[tt];
                end;

                DeleteSegment(t);
                break;
              end;
            end;
          end;
        end;

      var tmpNumSegments : Integer;
          tmpNumPoints   : Integer;
          t              : Integer;
          Added          : Boolean;
      begin
        with Levels[TheLevel] do
        begin
          tmpNumSegments:=Length(FSegments);

          if tmpNumSegments=0 then // first point? Add new segment
             AddNewSegment(x1,z1,x2,z2)
          else
          begin
            Added:=False;

            // Find appropiate segment for point
            for t:=0 to tmpNumSegments-1 do
            begin
              tmpNumPoints:=Length(FSegments[t].Points);

              Case CloserPoint(FSegments[t].Points[0],FSegments[t].Points[tmpNumPoints-1]) of
                 0:

              //if PointClose(x1,z1,FSegments[t].Points[0]) then
              begin
                InsertPoint(t,0);
                with FSegments[t].Points[0] do
                begin
                  x:=x2;
                  y:=z2;
                end;
                CheckOtherSegments(t,0);
                Added:=True;
                break;
              end;

              1: //if PointClose(x1,z1,FSegments[t].Points[tmpNumPoints-1]) then
              begin
                SetLength(FSegments[t].Points,tmpNumPoints+1);
                with FSegments[t].Points[tmpNumPoints] do
                begin
                  x:=x2;
                  y:=z2;
                end;
                CheckOtherSegments(t,tmpNumPoints);
                Added:=True;
                break;
              end;

              2: //if PointClose(x2,z2,FSegments[t].Points[0]) then
              begin
                InsertPoint(t,0);
                with FSegments[t].Points[0] do
                begin
                  x:=x1;
                  y:=z1;
                end;
                CheckOtherSegments(t,0);
                Added:=True;
                break;
              end;

              3: //if PointClose(x2,z2,FSegments[t].Points[tmpNumPoints-1]) then
              begin
                SetLength(FSegments[t].Points,tmpNumPoints+1);
                with FSegments[t].Points[tmpNumPoints] do
                begin
                  x:=x1;
                  y:=z1;
                end;
                CheckOtherSegments(t,tmpNumPoints);
                Added:=True;
                break;
              end;
              end;
            end;

            if not Added then AddNewSegment(x1,z1,x2,z2);
          end;
        end;
      end;
      {$ENDIF}

    {$IFDEF LEVELSEGMENTS}
    var x1,z1,x2,z2 : TChartValue;
    {$ENDIF}
    begin
      with ILevels[TheLevel] do
      begin
        {$IFNDEF LEVELSEGMENTS}
        if Count>=Allocated then
        begin
          Inc(Allocated,1000);
          SetLength(Line,Allocated);
        end;

        with Line[Count] do
        {$ENDIF}
        begin
          case Side of
             1: begin
                  x1:=CellX[m1]; z1:=CellZ[m1];
                  x2:=CellX[0];  z2:=CellZ[0];
                end;
             2: begin
                  x1:=CellX[0];  z1:=CellZ[0];
                  x2:=CellX[m3]; z2:=CellZ[m3];
                end;
             3: begin
                  x1:=CellX[m3]; z1:=CellZ[m3];
                  x2:=CellX[m1]; z2:=CellZ[m1];
                end;
             4: begin
                  x1:=CellX[m1]; z1:=CellZ[m1];
                  PointSect(0,m3,x2,z2);
                end;
             5: begin
                  x1:=CellX[0];  z1:=CellZ[0];
                  PointSect(m3,m1,x2,z2);
                end;
             6: begin
                  x1:=CellX[m3]; z1:=CellZ[m3];
                  PointSect(m1,0,x2,z2);
                end;
             7: begin PointSect(m1, 0,x1,z1); PointSect(0, m3,x2,z2); end;
             8: begin PointSect( 0,m3,x1,z1); PointSect(m3,m1,x2,z2); end;
             9: begin PointSect(m3,m1,x1,z1); PointSect(m1, 0,x2,z2); end;
          end;

          {$IFDEF LEVELSEGMENTS}
          AddSegmentLine(x1,z1,x2,z2);
          {$ENDIF}
        end;

        {$IFNDEF LEVELSEGMENTS}
        Inc(Count); { new line }
        {$ENDIF}
      end;
    end;

  const Sides : Array[-1..1,-1..1,-1..1] of Byte=
                   ( ( (0,0,8),(0,2,5),(7,6,9) ),
                     ( (0,3,4),(1,3,1),(4,3,0) ),
                     ( (9,6,7),(5,2,0),(8,0,0) )  );
  var Corner      : Integer;
      SignHeights : Array[0..4] of Integer;
      Side        : Integer;
      SignZero    : Integer;
  Begin
    { calculate signs for each corner Y value and Y average }
    for Corner:=0 to 4 do
    begin
      if DifY[Corner]>0 then SignHeights[Corner]:= 1 else
      if DifY[Corner]<0 then SignHeights[Corner]:=-1 else
                             SignHeights[Corner]:= 0;
    end;

    SignZero:=SignHeights[0]; { average Y sign }

    for Corner:=1 to 4 do
    begin
      { m1 = current corner }
      m1:=Corner;
      { m3 = next corner }
      if Corner=4 then m3:=1 else m3:=Succ(Corner);

      { find "Side" between one corner and next corner }
      Side:=Sides[SignHeights[m1],SignZero,SignHeights[m3]];

      { if valid side, calculate crossing points and add a new level line }
      if Side<>0 then CalcLinePoints(Side);
    end;
  end;

var tmpNumLevels : Integer; { speed opt. }

  Procedure DrawLevelLines;
  var tmpY     : Integer;
      TheLevel : Integer;
      t        : Integer;
      {$IFDEF LEVELSEGMENTS}
      tmp,
      tt,
      tmp2     : Integer;
      P        : TeCanvas.TPointArray;
      {$ENDIF}
  begin
    {$IFDEF LEVELSEGMENTS}
    P:=nil;
    {$ENDIF}

    tmpY:=GetVertAxis.CalcYPosValue(FYPosition);

    { for each level, draw lines }
    for TheLevel:=0 to tmpNumLevels-1 do
    with ILevels[TheLevel] do
    begin
      ParentChart.Canvas.AssignVisiblePenColor(Pen,Color);

      { calculate Y position of the Level Up value }
      if FYPositionLevel then
         tmpY:=GetVertAxis.CalcYPosValue(UpToValue);

      { call event just before drawing, allow changing pen }
      if Assigned(FOnBeforeDrawLevel) then
         FOnBeforeDrawLevel(Self,TheLevel);

      {$IFDEF LEVELSEGMENTS}
      tmp:=Levels[TheLevel].SegmentCount-1;
      {$ENDIF}

      if ParentChart.View3D then
      begin
        {$IFDEF LEVELSEGMENTS}
        for t:=0 to tmp do
        with Levels[TheLevel].FSegments[t] do
        begin
          ParentChart.Canvas.MoveTo3D(GetHorizAxis.CalcXPosValue(Points[0].x),tmpY,tmpZAxis.CalcPosValue(Points[0].y));

          tmp2:=Length(Points)-1;
          for tt:=1 to tmp2 do
            ParentChart.Canvas.LineTo3D( GetHorizAxis.CalcXPosValue(Points[tt].x),tmpY,
                                         tmpZAxis.CalcPosValue(Points[tt].y));
        end;
        {$ELSE}
        { for all lines in level }
        for t:=0 to Count-1 do
        with Line[t] do  { draw the line }
        with ParentChart.Canvas do
        begin
          MoveTo3D(x1,tmpY,z1);
          LineTo3D(x2,tmpY,z2);
        end;
        {$ENDIF}
      end
      else
        {$IFDEF LEVELSEGMENTS}
        for t:=0 to tmp do
        begin
          P:=Levels[TheLevel].GetSegmentPoints(t);
          if Smoothing.Active then P:=Smoothing.Calculate(P);
          ParentChart.Canvas.Polyline(P);
          P:=nil;
        end;
        {$ELSE}
        for t:=0 to Count-1 do
        with Line[t] do  { draw the line }
             ParentChart.Canvas.Line(x1,z1,x2,z2);
        {$ENDIF}
    end;
  end;

Var x,z      : Integer;
    DiffMin  : TChartValue;
    DiffMax  : TChartValue;
    TheLevel : Integer;
    tmp1     : TChartValue;
    tmp2     : TChartValue;
    tmp3     : TChartValue;
    tmp4     : TChartValue;
    tmpAvg   : TChartValue;
begin
  if Count>0 then
  begin
    { prepare default params }
    ParentChart.Canvas.BackMode:=cbmTransparent;
    INextXCell:=1;
    INextZCell:=1;

    tmpZAxis:=GetZAxis;

    { cache number of levels (speed opt.) }
    tmpNumLevels:=NumLevels;

    SetLength(ILevels,tmpNumLevels);

    { store cache of levels }
    for TheLevel:=0 to tmpNumLevels-1 do
    with Levels[TheLevel] do
    begin
      ILevels[TheLevel].UpToValue:=UpToValue;
      ILevels[TheLevel].Color:=Color;
      {$IFDEF LEVELSEGMENTS}
      ClearSegments;
      {$ELSE}
      ILevels[TheLevel].Count:=0;
      ILevels[TheLevel].Allocated:=0;
      {$ENDIF}
      ILevels[TheLevel].Pen:=InternalPen;
    end;

    for z:=1 to FNumZValues-1 do { for each cell }
      for x:=1 to FNumXValues-1 do
      if ExistFourGridIndex(x,z) then  { if xz values exist }
      begin
        { calc cell screen coordinates for Z }
        {$IFDEF LEVELSEGMENTS}
        CellZ[1]:=ZValues.Value[ValueIndex0];
        CellZ[2]:=CellZ[1];
        CellZ[3]:=ZValues.Value[ValueIndex3];
        CellZ[4]:=CellZ[3];
        CellZ[0]:=(CellZ[1]+CellZ[3]) * 0.5;  { mid Z pos }
        {$ELSE}
        CellZ[1]:=tmpZAxis.CalcYPosValue(ZValues.Value[ValueIndex0]);
        CellZ[2]:=CellZ[1];
        CellZ[3]:=tmpZAxis.CalcYPosValue(ZValues.Value[ValueIndex3]);
        CellZ[4]:=CellZ[3];
        CellZ[0]:=(CellZ[1]+CellZ[3]) div 2;  { mid Z pos }
        {$ENDIF}

        { calc cell screen coordinates for X }
        {$IFDEF LEVELSEGMENTS}
        CellX[1]:=XValues.Value[ValueIndex0];
        CellX[2]:=XValues.Value[ValueIndex1];
        CellX[3]:=CellX[2];
        CellX[4]:=CellX[1];
        CellX[0]:=(CellX[1]+CellX[2]) * 0.5;  { mid X pos }
        {$ELSE}
        with GetHorizAxis do
        begin
          CellX[1]:=CalcXPosValue(XValues.Value[ValueIndex0]);
          CellX[2]:=CalcXPosValue(XValues.Value[ValueIndex1]);
        end;
        CellX[3]:=CellX[2];
        CellX[4]:=CellX[1];
        CellX[0]:=(CellX[1]+CellX[2]) div 2;  { mid X pos }
        {$ENDIF}

        { get Y value for each grid cell corner }
        With YValues do
        begin
          tmp1:=Value[ValueIndex0];
          tmp2:=Value[ValueIndex3];
          tmp3:=Value[ValueIndex1];
          tmp4:=Value[ValueIndex2];
        end;

        { calc min and max Y value of the 4 cell corners }
        DiffMin:=tmp1;
        if tmp2<DiffMin then DiffMin:=tmp2;
        if tmp3<DiffMin then DiffMin:=tmp3;
        if tmp4<DiffMin then DiffMin:=tmp4;

        if DiffMin<=ILevels[tmpNumLevels-1].UpToValue then { if Min inside all levels }
        begin
          DiffMax:=tmp1;
          if tmp2>DiffMax then DiffMax:=tmp2;
          if tmp3>DiffMax then DiffMax:=tmp3;
          if tmp4>DiffMax then DiffMax:=tmp4;

          if DiffMax>=ILevels[0].UpToValue then { if Max inside all levels }
          for TheLevel:=0 to tmpNumLevels-1 do { for each level }
          With ILevels[TheLevel] do
          if (UpToValue>=DiffMin) and (UpToValue<=DiffMax) then { if inside one level }
          begin
            { calc corners dif Y to level Up value }
            DifY[1]:=tmp1-UpToValue;
            DifY[2]:=tmp3-UpToValue;
            DifY[3]:=tmp4-UpToValue;
            DifY[4]:=tmp2-UpToValue;

            { set dif[0] to Y average }
            tmpAvg:=0.25*(tmp1+tmp2+tmp3+tmp4); { average Y value }
            DifY[0]:=tmpAvg-UpToValue;

            { calculate all lines for one level in this XZ cell }
            CalcLevel(TheLevel);
          end;
        end;
      end;

    DrawLevelLines;

    {$IFNDEF LEVELSEGMENTS}
    { release array memory }
    for TheLevel:=0 to tmpNumLevels-1 do
        ILevels[TheLevel].Line:=nil;
    ILevels:=nil;
    {$ENDIF}
  end;
end;

procedure TContourSeries.AddSampleValues(NumValues:Integer);
begin
  inherited;
  FYPosition:=0.5*(YValues.MaxValue+YValues.MinValue); { mid vertical pos }
end;

Procedure TContourSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  if not IsEnabled then SeriesColor:=clGray;
end;

class Function TContourSeries.GetEditorClass:String;
Begin
  result:='TContourSeriesEditor'; { <-- dont translate ! }
end;

Function TContourSeries.CountLegendItems:Integer;
begin
  result:=FLevels.Count;
end;

Function TContourSeries.LegendItemColor(LegendIndex:Integer):TColor;
begin  { inverted legend }
  result:=FLevels[NumLevels-LegendIndex-1].Color;
end;

Function TContourSeries.LegendString( LegendIndex:Integer;
                                      LegendTextStyle:TLegendTextStyle ):String;
begin { inverted legend }
  result:=FormatFloat(ValueFormat,FLevels[NumLevels-LegendIndex-1].UpToValue);
end;

Function TContourSeries.MaxYValue:Double;
begin
  if ParentChart.View3D then result:=inherited MaxYValue
                        else result:=ZValues.MaxValue;
end;

Function TContourSeries.MinYValue:Double;
begin
  if ParentChart.View3D then result:=inherited MinYValue
                        else result:=ZValues.MinValue;
end;

Procedure TContourSeries.CreateAutoLevels; { calc Level values and colors }
Var t   : Integer;
    tmp : Double;
begin
  if AutomaticLevels and (NumLevels>0) then { 5.01 }
  begin
    IModifyingLevels:=True;
    ParentChart.AutoRepaint:=False;
    tmp:=YValues.Range/NumLevels;
    FLevels.Clear;
    for t:=0 to NumLevels-1 do
    With TContourLevel(FLevels.Add) do
    begin
      FUpTo:=YValues.MinValue+tmp*t;
      if ColorEachPoint then FColor:=ValueColor[t]
                        else FColor:=GetValueColorValue(FUpTo);
      if Assigned(FOnGetLevel) then FOnGetLevel(Self,t,FUpTo,FColor);
    end;
    IModifyingLevels:=False;
    ParentChart.AutoRepaint:=True;
  end;
end;

Procedure TContourSeries.DoBeforeDrawChart;
begin
  inherited;
  CreateAutoLevels;
end;

function TContourSeries.IsLevelsStored: Boolean;
begin
  result:=not AutomaticLevels;
end;

procedure TContourSeries.SetLevels(const Value: TContourLevels);
begin
  FLevels.Assign(Value);
end;

procedure TContourSeries.SetAutomaticLevels(const Value: Boolean);
begin
  SetBooleanProperty(FAutomaticLevels,Value);
end;

function TContourSeries.GetNumLevels: Integer;
begin
  if AutomaticLevels then result:=FNumLevels else result:=Levels.Count;
end;

class procedure TContourSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Colors);
  AddSubChart(TeeMsg_Positions);
end;

class procedure TContourSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TContourSeries(ASeries) do
  Case Index of
    2: ColorEachPoint:=True;
    3: YPositionLevel:=True;
  else inherited;
  end
end;

{$IFDEF LEVELSEGMENTS}
function TContourSeries.Clicked(x, y: Integer): Integer;
var SegmentIndex : Integer;
    PointIndex   : Integer;
begin
  result:=Levels.Clicked(x,y,SegmentIndex,PointIndex);
end;
{$ENDIF}

{ returns "Z" axis, depending on 2D or 3D }
function TContourSeries.GetZAxis: TChartAxis;
begin
  if ParentChart.View3D then result:=ParentChart.DepthAxis
                        else result:=GetVertAxis;
end;

procedure TContourSeries.SetSmoothing(const Value: TSmoothPoints);
begin
  FSmoothing.Assign(Value);
end;

{ TContourLevel }
type TOwnedCollectionAccess=class(TOwnedCollection);

Constructor TContourLevel.Create(Collection: TCollection);
begin
  inherited;
  ISeries:=TContourSeries(TOwnedCollectionAccess(Collection).GetOwner);
  CheckAuto;
end;

Destructor TContourLevel.Destroy;
begin
  CheckAuto;
  With ISeries do if not AutomaticLevels then Repaint;
  FPen.Free;
  {$IFDEF LEVELSEGMENTS}
  ClearSegments;
  {$ENDIF}
  inherited;
end;

{$IFDEF LEVELSEGMENTS}
Procedure TContourLevel.ClearSegments;
var t : Integer;
begin
  for t:=0 to Length(FSegments)-1 do
      FSegments[t].Points:=nil;
  FSegments:=nil;
end;
{$ENDIF}

Procedure TContourLevel.CheckAuto;
begin
  With ISeries do
  if not IModifyingLevels then FAutomaticLevels:=False;
end;

procedure TContourLevel.SetColor(const Value: TColor);
begin
  ISeries.SetColorProperty(FColor,Value);
  if Assigned(FPen) then FPen.Color:=Color;
  CheckAuto;
end;

procedure TContourLevel.SetUpTo(const Value: Double);
begin
  ISeries.SetDoubleProperty(FUpTo,Value);
  CheckAuto;
end;

procedure TContourLevel.Assign(Source: TPersistent); { 5.01 }
begin
  if Source is TContourLevel then
  With TContourLevel(Source) do
  Begin
    Self.FColor  :=FColor;
    Self.FUpTo   :=FUpTo;
    if Assigned(FPen) then Pen.Assign(FPen)
                      else FreeAndNil(FPen);
  end
  else inherited;
end;

function TContourLevel.GetPen: TChartPen;
begin
  if not Assigned(FPen) then
  begin
    FPen:=ISeries.CreateChartPen;
    FPen.Color:=Color;
    CheckAuto;
  end;
  result:=FPen;
end;

function TContourLevel.IsPenStored: Boolean;
begin
  result:=not DefaultPen;
end;

function TContourLevel.DefaultPen: Boolean;
begin
  result:=not Assigned(FPen);
end;

procedure TContourLevel.SetPen(const Value: TChartPen);
begin
  if Assigned(Value) then Pen.Assign(Value)
  else
  begin
    FreeAndNil(FPen);
    ISeries.Repaint;
  end;
end;

function TContourLevel.InternalPen: TChartPen;
begin
  if Assigned(FPen) then result:=FPen
                    else result:=ISeries.Pen;
end;

{$IFDEF LEVELSEGMENTS}
function TContourLevel.Clicked(x, y: Integer; var SegmentIndex,
  PointIndex: Integer): Boolean;
var t : Integer;
begin
  for t:=0 to SegmentCount-1 do
  if ClickedSegment(x,y,t,PointIndex) then
  begin
    SegmentIndex:=t;
    result:=True;
    exit;
  end;
  result:=False;
end;

function TContourLevel.SegmentCount: Integer;
begin
  result:=Length(FSegments);
end;

function TContourLevel.ClickedSegment(x, y, SegmentIndex: Integer;
  var PointIndex: Integer): Boolean;
var P        : TeCanvas.TPointArray;
    tmp      : TPoint;
    t        : Integer;
    tmpCount : Integer;
begin
  result:=False;

  if Assigned(ISeries.ParentChart) then
     ISeries.ParentChart.Canvas.Calculate2DPosition(X,Y,ISeries.MiddleZ);

  P:=GetSegmentPoints(SegmentIndex);
  tmp:=TeePoint(x,y);
  tmpCount:=Length(P);

  for t:=0 to tmpCount-2 do
  if PointInLine(tmp,P[t],P[t+1],0) then
  begin
    PointIndex:=t;
    result:=True;
    break;
  end;

  P:=nil;
end;

Function TContourLevel.GetSegmentPoints(SegmentIndex: Integer):TeCanvas.TPointArray;
var tmp : Integer;
    t   : Integer;
    tmpHAxis : TChartAxis;
    tmpZAxis : TChartAxis;
begin
  tmp:=Length(FSegments[SegmentIndex].Points);
  SetLength(result,tmp);
  tmpZAxis:=ISeries.GetZAxis;
  tmpHAxis:=ISeries.GetHorizAxis;
  with FSegments[SegmentIndex] do
  for t:=0 to tmp-1 do
  begin
    result[t].x:=tmpHAxis.CalcXPosValue(Points[t].x);
    result[t].y:=tmpZAxis.CalcPosValue(Points[t].Y);
  end;
end;
{$ENDIF}

{ TContourLevels }
{$IFDEF LEVELSEGMENTS}
function TContourLevels.Clicked(x, y: Integer; var SegmentIndex,
  PointIndex: Integer): Integer;
var t : Integer;
begin
  for t:=0 to Count-1 do
  if Items[t].Clicked(x,y,SegmentIndex,PointIndex) then
  begin
    result:=t;
    exit;
  end;
  result:=-1;
end;
{$ENDIF}

function TContourLevels.Get(Index: Integer): TContourLevel;
begin
  result:=TContourLevel(inherited Items[Index]);
end;

procedure TContourLevels.Put(Index: Integer; Const Value: TContourLevel);
begin
  Items[Index].Assign(Value);
end;

{ TWaterFallSeries }
Constructor TWaterFallSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FWaterFall:=True;
end;

procedure TWaterFallSeries.GalleryChanged3D(Is3D: Boolean);
begin
  inherited;
  ParentChart.View3D:=Is3D;
end;

class function TWaterFallSeries.GetEditorClass: String;
begin
  result:='TWaterFallEditor';
end;

class procedure TWaterFallSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TWaterFallSeries(ASeries) do
  Case Index of
    6: WaterLines.Visible:=False;
  else inherited;
  end;
end;

class procedure TWaterFallSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoLines);
end;

{ TColorGridSeries }
Constructor TColorGridSeries.Create(AOwner:TComponent);
begin
  inherited;
  FBitmap:=TBitmap.Create;
  {$IFNDEF CLX}
  FBitmap.IgnorePalette:=True;
  FBitmap.PixelFormat:=TeePixelFormat;
  {$ENDIF}
  Marks.Callout.Length:=0;
end;

Destructor TColorGridSeries.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TColorGridSeries.DrawAllValues; { 5.01 - reviewed 12.03.2001 }
var tmpDec : Integer;

  Procedure FillBitmap;
  type TColors=packed Array[0..0] of {$IFDEF CLX}TeCanvas.{$ENDIF}TRGBTriple;
  var z        : Integer;
      x        : Integer;
      P        : ^TColors;
      tmpIndex : Integer;
      tmp      : TColor;
  begin
    for z:=1 to NumZValues-tmpDec do // 6.0
    begin
      P:=FBitmap.ScanLine[z-1];
      for x:=1 to NumXValues-tmpDec do // 6.0
      begin
        tmpIndex:=GridIndex[x,z];
        if tmpIndex<>-1 then
        {$R-}
        With P^[x-1] do
        begin
          tmp:=ValueColor[tmpIndex];
          {$IFDEF CLX}
          {Alpha:=0;}
          rgbtRed  := tmp and $FF;
          rgbtGreen:=(tmp shr 8) and $FF;
          rgbtBlue :=(tmp shr 16) and $FF;
          {$ELSE}
          rgbtRed  :=Byte(tmp);
          rgbtGreen:=Byte(tmp shr 8);
          rgbtBlue :=Byte(tmp shr 16);
          {$ENDIF}
        end;
      end;
    end;
  end;

Var R : TRect;

  Procedure DrawBitmap;
  begin
    With GetHorizAxis do
    begin
      R.Left:=CalcPosValue(MinXValue);
      R.Right:=CalcPosValue(MaxXValue){$IFDEF CLX}+1{$ENDIF};
    end;

    With GetVertAxis do
    begin
      R.Top:=CalcPosValue(MinZValue);
      R.Bottom:=CalcPosValue(MaxZValue){$IFDEF CLX}+1{$ENDIF};
    end;

    With ParentChart.Canvas do
    if ParentChart.View3D and (not ParentChart.View3DOptions.Orthogonal) then
       StretchDraw(R,FBitmap,MiddleZ)
    else
       StretchDraw(CalcRect3D(R,MiddleZ),FBitmap)
  end;

  Procedure DrawGrid;
  var z   : Integer;
      x   : Integer;
      tmp : Integer;
      tmpDecAmount : Double;
  begin
    With ParentChart.Canvas do
    begin
      BackMode:=cbmTransparent;
      AssignVisiblePen(Self.Pen);

      if CenteredPoints then tmpDecAmount:=0.5
                        else tmpDecAmount:=0;

      for z:=2 to NumZValues-tmpDec do // 6.0
      begin
        tmp:=GetVertAxis.CalcPosValue(ZValues.Value[GridIndex[1,z]]-tmpDecAmount);
        if ParentChart.View3D then HorizLine3D(R.Left,R.Right,tmp,MiddleZ) { 5.01 }
                              else DoHorizLine(R.Left,R.Right,tmp);
      end;

      for x:=2 to NumXValues-tmpDec do // 6.0
      begin
        tmp:=GetHorizAxis.CalcPosValue(XValues.Value[GridIndex[x,1]]-tmpDecAmount);
        if ParentChart.View3D then VertLine3D(tmp,R.Top,R.Bottom,MiddleZ)
                              else DoVertLine(tmp,R.Top,R.Bottom);
      end;
    end;
  end;

begin
  if Count>0 then
  begin
    { In non-centered mode, size of grid is one less (x-1, z-1) }
    if CenteredPoints or (not IrregularGrid) then
       tmpDec:=0
    else
       tmpDec:=1;

    FBitmap.FreeImage;
    FBitmap.Width :=NumXValues{$IFNDEF CLX}-tmpDec{$ENDIF}; { 5.01 }
    FBitmap.Height:=NumZValues{$IFNDEF CLX}-tmpDec{$ENDIF}; { 5.01 }
    FillBitmap;

    DrawBitmap;
    if Pen.Visible then DrawGrid;
  end;
end;

Function TColorGridSeries.MaxXValue:Double;
begin
  result:=XValues.MaxValue;
  if CenteredPoints then result:=result+0.5 // 6.0
  else
  if not IrregularGrid then result:=result+1;
end;

function TColorGridSeries.MinXValue: Double;
begin
  result:=XValues.MinValue;
  if CenteredPoints then result:=result-0.5; // 6.0
end;

Function TColorGridSeries.MaxZValue:Double;
begin
  result:=ZValues.MaxValue;
  if CenteredPoints then result:=result+0.5 // 6.0
  else
  if not IrregularGrid then result:=result+1;
end;

Function TColorGridSeries.MaxYValue:Double;
begin
  result:=MaxZValue;
end;

Function TColorGridSeries.MinZValue:Double;
begin
  result:=ZValues.MinValue;
  if CenteredPoints then result:=result-0.5; // 6.0
end;

Function TColorGridSeries.MinYValue:Double;
begin
  result:=MinZValue;
end;

Procedure TColorGridSeries.GalleryChanged3D(Is3D:Boolean);
begin
  inherited;
  ParentChart.View3D:=Is3D;
  ParentChart.ClipPoints:=True;
end;

class function TColorGridSeries.GetEditorClass: String;
begin
  result:='TColorGridEditor';
end;

procedure TColorGridSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  IInGallery:=True;
  CreateValues(8,4);
end;

class procedure TColorGridSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoGrid);
end;

class procedure TColorGridSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  Case Index of
    2: ASeries.Pen.Visible:=False;
  else inherited
  end;
end;

function TColorGridSeries.Clicked(X, Y: Integer): Integer; { 5.01 - reviewed 12.03.2001 }
var i      : Integer;
    XPos   : Double;
    YPos   : Double;
    ZIndex : Integer;
    YDif   : Double;
    XDif   : Double; { 5.01 }
begin
  result:=TeeNoPointClicked;

  ZIndex:=-1;
  XPos:=GetHorizAxis.CalcPosPoint(X);
  YPos:=GetVertAxis.CalcPosPoint(Y);

  if IrregularGrid then { irregular grid - slower algorithm }
  begin
    for i := 0 to NumZValues-1 do
    if (ZValues.Value[i] <= YPos) and
       (ZValues.Value[(i+1)] > YPos) then
    begin
      ZIndex := i;
      break;
    end;
    if ZIndex <> -1 then { search further only if it makes sense }
    begin
      for i := 0 to NumXValues-1 do
      if (XValues.Value[i*NumZValues] <= XPos) and
         (XValues.Value[(i+1)*NumZValues] > XPos) then
      begin
        Result := ZIndex +i*NumZValues;
        Exit;
      end;
    end;
  end
  else { indexed grid - faster algorithm }
  begin
    YDif := (YPos - ZValues.MinValue); { 5.01 }
    if YDif >=0 then i := Trunc(YDif) else i := -1;

    if (i >= 0) and (i < NumZValues -1) then ZIndex := i;
    if ZIndex <> -1 then { search further only if it makes sense }
    begin
      XDif := (XPos - XValues.MinValue); { 5.01 }
      if XDif >=0 then i := Trunc(XDif) else i := -1;
      if (i >= 0) and (i < NumXValues-1) then
      begin
        result := GridIndex[i+1,ZIndex+1]; { 5.01 - 13.03 fix }
        Exit;
      end;
    end;
  end;
end;

procedure TColorGridSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
var tmp : Double;
begin
  with APosition do
  begin
    if CenteredPoints or IrregularGrid then tmp:=0
                                       else tmp:=0.5;
    LeftTop.Y:=GetVertAxis.CalcPosValue(ZValues.Value[ValueIndex]+tmp)-(Height div 2);
    LeftTop.X:=GetHorizAxis.CalcPosValue(XValues.Value[ValueIndex]+tmp)-(Width div 2);
  end;
  inherited;
end;

procedure TColorGridSeries.SetCentered(const Value: Boolean);
begin
  SetBooleanProperty(FCentered,Value);
end;

procedure TColorGridSeries.SetBitmap(const Value: TBitmap);
var x : Integer;
    z : Integer;
    tmp : TColor;
begin
  FBitmap.Assign(Value);
  BeginUpdate;
  Clear;
  CenteredPoints:=True;
  NumXValues:=FBitmap.Width;
  NumZValues:=FBitmap.Height;
  for x:=0 to FBitmap.Width-1 do
      for z:=0 to FBitmap.Height-1 do
      begin
        {$IFDEF D7}
        tmp:=FBitmap.Canvas.Pixels[x,z];
        {$ELSE}
        {$IFNDEF CLX}
        tmp:=FBitmap.Canvas.Pixels[x,z];
        {$ELSE}
        {$IFDEF MSWINDOWS}
        tmp:=Windows.GetPixel(QPainter_handle(FBitmap.Canvas.Handle), x, z);
        {$ELSE}
        tmp:=0; // Linux, not implemented
        {$ENDIF}
        {$ENDIF}
        {$ENDIF}
        AddXYZ(x,tmp,z,'',tmp);
      end;
  EndUpdate;
end;

{ TSmoothPoints function }
constructor TSmoothPoints.Create(Parent: TChartSeries);
begin
  ISeries:=Parent;
  Factor:=4;
end;

type TSeriesAccess=class(TChartSeries);

procedure TSmoothPoints.Assign(Source: TPersistent);
begin
  if Source is TSmoothPoints then
  begin
    FActive:=TSmoothPoints(Source).FActive;
  end
  else inherited;
end;

function TSmoothPoints.Calculate(const P: array of TPoint): TeCanvas.TPointArray;
var Spline   : TBSpline;
    t        : Integer;
    tmpCount : Integer;
begin
  Spline:=TBSpline.Create;
  tmpCount:=Length(P);
  for t:=0 to tmpCount-1 do
  begin
    Spline.AddPoint(P[t].X,P[t].Y);
    Spline.Knuckle[t]:=False;
  end;
  Spline.Interpolated:=Interpolate;
  Spline.Fragments:=tmpCount*Factor;

  SetLength(result,Spline.Fragments+1);
  with Spline do
  for t:=0 to Fragments do
      with Value(t/Fragments) do
      begin
        result[t].X:=Round(X);
        result[t].Y:=Round(Y);
      end;

  Spline.Free;
end;

procedure TSmoothPoints.SetActive(const Value: Boolean);
begin
  TSeriesAccess(ISeries).SetBooleanProperty(FActive,Value);
end;

procedure TSmoothPoints.SetInterpolate(const Value: Boolean);
begin
  TSeriesAccess(ISeries).SetBooleanProperty(FInterpolate,Value);
end;

type TValueListAccess=class(TChartValueList);

{ TVector3DSeries }
Constructor TVector3DSeries.Create(AOwner: TComponent);
begin
  inherited;
  CalcVisiblePoints:=False;
  TValueListAccess(XValues).InitDateTime(False);
  FEndXValues:=TChartValueList.Create(Self,TeeMsg_ValuesArrowEndX);
  FEndYValues:=TChartValueList.Create(Self,TeeMsg_ValuesArrowEndY);
  FEndZValues:=TChartValueList.Create(Self,TeeMsg_ValuesVectorEndZ);
  FArrowWidth:=4;
  FArrowHeight:=4;
  FStartArrow:=TChartHiddenPen.Create(CanvasChanged);
  FStartArrow.Color:=clTeeColor;
  FEndArrow:=CreateChartPen;
  FEndArrow.Color:=clTeeColor;
end;

function TVector3DSeries.AddVector(const X0, Y0, Z0, X1, Y1, Z1: Double;
  const ALabel: String; AColor: TColor): Integer;
begin
  EndXValues.TempValue:=X1;
  EndYValues.TempValue:=Y1;
  EndZValues.TempValue:=Z1;
  result:=AddXYZ(X0,Y0,Z0,ALabel,AColor);
end;

function TVector3DSeries.IsValidSourceOf(Value: TChartSeries): Boolean;
begin
  result:=Value is TVector3DSeries;
end;

function TVector3DSeries.MaxZValue: Double;
begin
  result:=Math.Max(inherited MaxZValue,FEndZValues.MaxValue);
end;

function TVector3DSeries.MinZValue: Double;
begin
  result:=Math.Min(inherited MinZValue,FEndZValues.MinValue);
end;

procedure TVector3DSeries.SetEndXValues(Value: TChartValueList);
begin
  SetChartValueList(FEndXValues,Value);
end;

procedure TVector3DSeries.SetEndYValues(Value: TChartValueList);
begin
  SetChartValueList(FEndYValues,Value);
end;

procedure TVector3DSeries.SetEndZValues(Value: TChartValueList);
begin
  SetChartValueList(FEndZValues,Value);
end;

procedure TVector3DSeries.DrawValue(ValueIndex: Integer);
var tmpColor : TColor;
    tmpSin   : Extended;
    tmpCos   : Extended;

  Procedure DrawArrow(APen:TChartPen; P:TPoint; Z:Integer);
  begin
    with ParentChart.Canvas do
    begin
      if APen.Color=clTeeColor then
         AssignVisiblePenColor(APen,tmpColor)
      else
         AssignVisiblePen(APen);

      MoveTo(P.X + Round(-FArrowWidth*tmpCos - FArrowHeight*tmpSin),
             P.Y + Round(+FArrowWidth*tmpSin - FArrowHeight*tmpCos));
      LineTo(P.X,P.Y);
      LineTo(P.X + Round(-FArrowWidth*tmpCos + FArrowHeight*tmpSin),
             P.Y + Round(+FArrowWidth*tmpSin + FArrowHeight*tmpCos));
    end;
  end;

var StartZ     : Integer;
    EndZ       : Integer;
    StartPoint : TPoint;
    EndPoint   : TPoint;
    tmpAngle   : Double;
begin
  with ParentChart.Canvas do
  begin
    BackMode:=cbmTransparent;
    tmpColor:=ValueColor[ValueIndex];
    AssignVisiblePenColor(Self.Pen,tmpColor);

    StartPoint.X:=CalcXPos(ValueIndex);
    StartPoint.Y:=CalcYPos(ValueIndex);
    StartZ:=CalcZPos(ValueIndex);

    MoveTo3D( StartPoint.X,StartPoint.Y,StartZ );

    EndPoint.X:=CalcXPosValue(EndXValues.Value[ValueIndex]);
    EndPoint.Y:=CalcYPosValue(EndYValues.Value[ValueIndex]);
    EndZ:=ParentChart.DepthAxis.CalcYPosValue(EndZValues.Value[ValueIndex]);

    LineTo3D( EndPoint.X,EndPoint.Y,EndZ );

    if StartArrow.Visible or EndArrow.Visible then
    begin
      StartPoint:=Calculate3DPosition(StartPoint,StartZ);
      EndPoint:=Calculate3DPosition(EndPoint,EndZ);

      tmpAngle:=ArcTan2(StartPoint.Y-EndPoint.Y,EndPoint.X-StartPoint.X);
      SinCos(tmpAngle,tmpSin,tmpCos);

      if StartArrow.Visible then DrawArrow(StartArrow,StartPoint,StartZ);
      if EndArrow.Visible then DrawArrow(EndArrow,EndPoint,EndZ);
    end;
  end;
end;

Procedure TVector3DSeries.AddSampleValues(NumValues:Integer);
var t:Integer;
    x0,y0,z0,x1,y1,z1:Double;
    tmpPi,tmp,u,v:Double;
begin
  u:=0;
  v:=0;
  tmp:=NumValues*0.6;
  tmpPi:=8*Pi/NumValues;

  for t:=1 to NumValues do
  begin
    x0:=u+sin(v);
    y0:=u;
    z0:=cos(v);

    x1:=x0+sin(v);
    y1:=y0+tmp*cos(v)*sin(v);
    z1:=z0+cos(v)*u;

    AddVector(x0,y0,z0,x1,y1,z1);

    u:=u+1;
    v:=v+tmpPi;
  end;
end;

function TVector3DSeries.MaxXValue: Double;
begin
  result:=Math.Max(inherited MaxXValue,FEndXValues.MaxValue);
end;

function TVector3DSeries.MaxYValue: Double;
begin
  result:=Math.Max(inherited MaxYValue,FEndYValues.MaxValue);
end;

function TVector3DSeries.MinXValue: Double;
begin
  result:=Math.Min(inherited MinXValue,FEndXValues.MinValue);
end;

function TVector3DSeries.MinYValue: Double;
begin
  result:=Math.Min(inherited MinYValue,FEndYValues.MinValue);
end;

function TVector3DSeries.NumSampleValues: Integer;
begin
  result:=250;
end;

procedure TVector3DSeries.Assign(Source: TPersistent);
begin
  if Source is TVector3DSeries then
  with TVector3DSeries(Source) do
  begin
    Self.FArrowHeight :=FArrowHeight;
    Self.FArrowWidth  :=FArrowWidth;
    Self.EndArrow     :=EndArrow;
    Self.StartArrow   :=StartArrow;
  end;
  inherited;
end;

procedure TVector3DSeries.SetArrowHeight(const Value: Integer);
begin
  SetIntegerProperty(FArrowHeight,Value);
end;

procedure TVector3DSeries.SetArrowWidth(const Value: Integer);
begin
  SetIntegerProperty(FArrowWidth,Value);
end;

procedure TVector3DSeries.SetEndArrow(const Value: TChartPen);
begin
  FEndArrow.Assign(Value);
end;

procedure TVector3DSeries.SetStartArrow(const Value: TChartHiddenPen);
begin
  FStartArrow.Assign(Value);
end;

destructor TVector3DSeries.Destroy;
begin
  FStartArrow.Free;
  FEndArrow.Free;
  inherited;
end;

class function TVector3DSeries.GetEditorClass: String;
begin
  result:='TVectorSeriesEditor';
end;

{ TTowerSeries }
constructor TTowerSeries.Create(AOwner: TComponent);
begin
  inherited;
  FPercDepth:=100;
  FPercWidth:=100;
  FDark3D:=True;
end;

function TTowerSeries.Clicked(X, Y: Integer): Integer;
var tmpX : Integer;
    tmpZ : Integer;
    tmp  : Integer;
    z0   : Integer;
    z1   : Integer;
    tmpTop    : Integer;
    tmpBottom : Integer;
    tmpR      : TRect;
    tmpP      : TFourPoints;
    P         : TPoint;
begin
  if Count>0 then
  begin
    IOffW:=FPercWidth*0.005;
    IOffD:=FPercDepth*0.005;
    P:=TeePoint(x,y);

    for tmpX:=1 to NumXValues do
      for tmpZ:=1 to NumZValues do
      begin
        tmp:=GridIndex[tmpX,tmpZ];

        if (tmp<>-1) and (ValueColor[tmp]<>clNone) then
        begin
          tmpR:=CalcCell(tmp,tmpTop,tmpBottom,z0,z1);

          if TowerStyle=tsCover then
          begin
            tmpP[0]:=ParentChart.Canvas.Calculate3DPosition(tmpR.Left,tmpTop,z0);
            tmpP[1]:=ParentChart.Canvas.Calculate3DPosition(tmpR.Right,tmpTop,z0);
            tmpP[2]:=ParentChart.Canvas.Calculate3DPosition(tmpR.Right,tmpTop,z1);
            tmpP[3]:=ParentChart.Canvas.Calculate3DPosition(tmpR.Left,tmpTop,z1);

            if PointInPolygon(P,tmpP) then
            begin
              result:=tmp;
              exit;
            end
          end;
        end;
      end;
  end;

  result:=TeeNoPointClicked;
end;

class procedure TTowerSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_SingleColor);
  AddSubChart(TeeMsg_Marks);
  AddSubChart(TeeMsg_Hollow);
  AddSubChart(TeeMsg_Rectangle);
  AddSubChart(TeeMsg_Cover);
  AddSubChart(TeeMsg_Circle);
  AddSubChart(TeeMsg_GalleryArrow);
  AddSubChart(TeeMsg_Cone);
  AddSubChart(TeeMsg_Pyramid);
end;

procedure TTowerSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  Marks.ApplyArrowLength(APosition);
  inherited;
end;

class function TTowerSeries.GetEditorClass: String;
begin
  result:='TTowerSeriesEditor';
end;

function TTowerSeries.MaxXValue: Double;
begin
  result:=XValues.MaxValue+0.5;
end;

function TTowerSeries.MaxZValue: Double;
begin
  result:=ZValues.MaxValue+0.5;
end;

function TTowerSeries.MinXValue: Double;
begin
  result:=XValues.MinValue-0.5;
end;

function TTowerSeries.MinZValue: Double;
begin
  result:=ZValues.MinValue-0.5;
end;

procedure TTowerSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  IInGallery:=True;
  CreateValues(5,5);
end;

class procedure TTowerSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  case Index of
    2: ASeries.Pen.Visible:=False;
    3: TTowerSeries(ASeries).UsePalette:=False;
    4: ASeries.Marks.Visible:=True;
    5: ASeries.Brush.Style:=bsClear;
    6: TTowerSeries(ASeries).TowerStyle:=tsRectangle;
    7: TTowerSeries(ASeries).TowerStyle:=tsCover;
    8: TTowerSeries(ASeries).TowerStyle:=tsCylinder;
    9: TTowerSeries(ASeries).TowerStyle:=tsArrow;
   10: TTowerSeries(ASeries).TowerStyle:=tsCone;
   11: TTowerSeries(ASeries).TowerStyle:=tsPyramid;
  else inherited;
  end;
end;

Function TTowerSeries.CalcCell(var AIndex,ATop,ABottom,Z0,Z1:Integer):TRect;
var tmpValue : TChartValue;
begin
  tmpValue:=XValues.Value[AIndex];
  result.Left:=CalcXPosValue(tmpValue-IOffW);
  result.Right:=CalcXPosValue(tmpValue+IOffW);

  ATop:=CalcYPos(AIndex);
  result.Top:=ATop;

  if UseOrigin then
     ABottom:=CalcYPosValue(Origin)
  else
     ABottom:=CalcYPosValue(YValues.MinValue);

  result.Bottom:=ABottom;

  if result.Top>result.Bottom then SwapInteger(result.Top,result.Bottom);

  tmpValue:=ZValues.Value[AIndex];
  z0:=ParentChart.DepthAxis.CalcYPosValue(tmpValue-IOffD);
  z1:=ParentChart.DepthAxis.CalcYPosValue(tmpValue+IOffD);
end;

procedure TTowerSeries.DrawAllValues;
var tmpBlend : TTeeBlend;
    tmpChangeBrush : Boolean;

  Procedure DrawCell(x,z:Integer);
  var R : TRect;
      tmpR1,
      tmpR2,
      tmpR3 : TRect;
      tmp : Integer;
      z0  : Integer;
      z1  : Integer;
      tmpBottom: Integer;
      tmpTop   : Integer;
      tmpColor : TColor;
      tmpMidX  : Integer;
      tmpFour  : TFourPoints;
  begin
    tmp:=GridIndex[x,z];
    if tmp<>-1 then
    begin
      tmpColor:=ValueColor[tmp];

      if tmpColor<>clNone then
      begin
        if tmpChangeBrush then
           ParentChart.Canvas.AssignBrush(Self.Brush,tmpColor);

        R:=CalcCell(tmp,tmpTop,tmpBottom,z0,z1);

        if Transparency>0 then
        begin
          if TowerStyle=tsCover then
          begin
            tmpFour[0]:=ParentChart.Canvas.Calculate3DPosition(R.Left,tmpTop,z0);
            tmpFour[1]:=ParentChart.Canvas.Calculate3DPosition(R.Right,tmpTop,z0);
            tmpFour[2]:=ParentChart.Canvas.Calculate3DPosition(R.Right,tmpTop,z1);
            tmpFour[3]:=ParentChart.Canvas.Calculate3DPosition(R.Left,tmpTop,z1);
            tmpR3:=RectFromPolygon(tmpFour,4);
          end
          else
          begin
            tmpR1:=ParentChart.Canvas.RectFromRectZ(R,Z0);
            tmpR2:=ParentChart.Canvas.RectFromRectZ(R,Z1);
            UnionRect(tmpR3,tmpR1,tmpR2);
          end;

          if not ParentChart.Canvas.SupportsFullRotation then
             tmpBlend.SetRectangle(tmpR3);
        end;

        with R,ParentChart.Canvas do
        case TowerStyle of
          tsCube     : Cube(R,z0,z1,Dark3D);
          tsRectangle: RectangleWithZ(R,(z0+z1) div 2);
          tsCover    : RectangleY(Left,tmpTop,Right,z0,z1);
          tsCylinder : Cylinder(True,Left,Top,Right,Bottom,z0,z1,Dark3D);
          tsArrow    : begin
                         tmpMidX:=(Left+Right) div 2;
                         Arrow(True, TeePoint(tmpMidX,tmpBottom),
                                     TeePoint(tmpMidX,tmpTop),
                                     Right-Left,(Right-Left) div 2,(z0+z1) div 2);
                       end;
          tsCone     : Cone(True,Left,tmpTop,Right,tmpBottom,z0,z1,Dark3D,0);
          tsPyramid  : Pyramid(True,Left,tmpTop,Right,tmpBottom,z0,z1,Dark3D);
        end;

        if not ParentChart.Canvas.SupportsFullRotation then
           if Transparency>0 then
              tmpBlend.DoBlend(Transparency);
      end;
    end;
  end;

  Procedure DrawCells;
  var x : Integer;
      z : Integer;
  begin
    IOffW:=FPercWidth*0.005;
    IOffD:=FPercDepth*0.005;

    if Transparency>0 then
       tmpBlend:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),Transparency);

    if ParentChart.DepthAxis.Inverted then
      if not DrawValuesForward then
        for x:=NumXValues downto 1 do
            for z:=1 to NumZValues do DrawCell(x,z)
      else
        for x:=1 to NumXValues do
            for z:=1 to NumZValues do DrawCell(x,z)
    else
      if not DrawValuesForward then
        for x:=NumXValues downto 1 do
            for z:=NumZValues downto 1 do DrawCell(x,z)
      else
        for x:=1 to NumXValues do
            for z:=NumZValues downto 1 do DrawCell(x,z);

    if Transparency>0 then
       if ParentChart.Canvas.SupportsFullRotation then
          ParentChart.Canvas.EndBlending(tmpBlend)
       else
          tmpBlend.Free;
  end;

begin
  tmpChangeBrush:=Brush.Style<>bsClear;
  with ParentChart.Canvas do
  begin
    AssignVisiblePen(Self.Pen);
    AssignBrush(Self.Brush,SeriesColor);
    DrawCells;
  end;
end;

procedure TTowerSeries.SetPercDepth(const Value: Integer);
begin
  SetIntegerProperty(FPercDepth,Value);
end;

procedure TTowerSeries.SetPercWidth(const Value: Integer);
begin
  SetIntegerProperty(FPercWidth,Value);
end;

procedure TTowerSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TTowerSeries.SetOrigin(const Value: Double);
begin
  SetDoubleProperty(FOrigin,Value);
end;

procedure TTowerSeries.SetUseOrigin(Value: Boolean);
begin
  SetBooleanProperty(FUseOrigin,Value);
end;

procedure TTowerSeries.SetTowerStyle(const Value: TTowerStyle);
begin
  if FTowerStyle<>Value then
  begin
    FTowerStyle:=Value;
    Repaint;
  end;
end;

procedure TTowerSeries.SetDark3D(const Value: Boolean);
begin
  SetBooleanProperty(FDark3D,Value);
end;

initialization
  RegisterTeeSeries( TSurfaceSeries, @TeeMsg_GallerySurface, @TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TContourSeries, @TeeMsg_GalleryContour, @TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TWaterFallSeries,@TeeMsg_GalleryWaterFall, @TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TColorGridSeries,@TeeMsg_GalleryColorGrid, @TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TVector3DSeries,@TeeMsg_GalleryVector3D,@TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TTowerSeries,   @TeeMsg_GalleryTower, @TeeMsg_Gallery3D,1);
finalization
  UnRegisterTeeSeries([TSurfaceSeries,TContourSeries,TWaterFallSeries,
                       TColorGridSeries,TVector3DSeries,TTowerSeries]);
end.
