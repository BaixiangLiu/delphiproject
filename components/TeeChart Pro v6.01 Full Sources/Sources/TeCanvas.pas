{**********************************************}
{   TeeChart and TeeTree TCanvas3D component   }
{   Copyright (c) 1999-2003 by David Berneda   }
{        All Rights Reserved                   }
{**********************************************}
unit TeCanvas;
{$I TeeDefs.inc}

interface

{.$DEFINE TEEBITMAPSPEED}  // By-pass VCL Canvas bitmap

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     Classes, SysUtils,
     {$IFDEF CLX}
     Qt, QGraphics, QStdCtrls, QControls, QComCtrls, Types,
     {$ELSE}
     Controls, Graphics, StdCtrls,
     {$ENDIF}
     TypInfo;

Const TeePiStep:Double      = Pi/180.0;

      {$NODEFINE TeePiStep}  { for C++ Builder }

      TeeDefaultPerspective = 15;
      TeeMinAngle           = 270;

      {$IFNDEF D6}
      clMoneyGreen = TColor($C0DCC0);
      clSkyBlue    = TColor($F0CAA6);
      clCream      = TColor($F0FBFF);
      clMedGray    = TColor($A4A0A0);
      {$ENDIF}

      {$IFDEF CLX}
      clMoneyGreen = TColor($C0DCC0);
      clSkyBlue    = TColor($F0CAA6);
      clCream      = TColor($F0FBFF);
      clMedGray    = TColor($A4A0A0);

      TA_LEFT = 0;
      TA_RIGHT = 2;
      TA_CENTER = 6;
      TA_TOP = 0;
      TA_BOTTOM = 8;

      PATCOPY      = 0;
      {$ENDIF}

var
      TeeDefaultConePercent : Integer=0;

type
     {$IFDEF CLX}

     // Fake class to support TUpDown in CLX
     // Inherits from CLX TSpinEdit control.
       
     TUDBtnType=(btNext, btPrev);
     TUDOrientation=(udHorizontal, udVertical);

     TUpDown=class(TSpinEdit)
     private
       FAssociate   : TComponent;
       FOrientation : TUDOrientation;
       FThousands   : Boolean;

       IChangingText : Boolean;
       OldChanged    : TNotifyEvent;
       Procedure DoChangeEdit;
       Procedure ChangedEdit(Sender:TObject);
       Procedure GetOldChanged;
       function GetPosition: Integer;
       procedure SetPosition(const AValue: Integer);
       procedure SetAssociate(const AValue: TComponent);
     protected
       procedure Change(AValue: Integer); override;
       Procedure Loaded; override;
     public
       Constructor Create(AOwner:TComponent); override;
     published
       property Associate:TComponent read FAssociate write SetAssociate;
       property Orientation: TUDOrientation read FOrientation write FOrientation default udVertical;
       property Position:Integer read GetPosition write SetPosition default 0;
       property Thousands: Boolean read FThousands write FThousands default True;
     end;
     {$ENDIF}

     TPenEndStyle=(esRound,esSquare,esFlat);

     TChartPen=class(TPen)
     private
       FEndStyle  : TPenEndStyle;
       FSmallDots : Boolean;
       FVisible   : Boolean;
       Function IsEndStored:Boolean;
       Function IsVisibleStored:Boolean;
       procedure SetEndStyle(const Value: TPenEndStyle);
       Procedure SetSmallDots(Value:Boolean);
       Procedure SetVisible(Value:Boolean);
     protected
       DefaultEnd : TPenEndStyle;
       DefaultVisible : Boolean;
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
       Procedure Assign(Source:TPersistent); override;
     published
       property EndStyle:TPenEndStyle read FEndStyle write SetEndStyle stored IsEndStored;
       property SmallDots:Boolean read FSmallDots write SetSmallDots default False;
       property Visible:Boolean read FVisible write SetVisible stored IsVisibleStored;
     end;

     TChartHiddenPen=class(TChartPen)
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
     published
       property Visible default False;
     end;

     TDottedGrayPen=class(TChartPen)
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
     published
       property Color default clGray;
       property Style default psDot;
     end;

     TDarkGrayPen=class(TChartPen)
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
     published
       property Color default clDkGray;
     end;

     TWhitePen=class(TChartPen)
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
     published
       property Color default clWhite;
     end;

     TChartAxisPen=class(TChartPen)
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
     published
       property Width default 2;
     end;

     TChartBrush=class(TBrush)
     private
       FImage : TPicture;
       Function GetImage:TPicture;
       procedure SetImage(Value:TPicture);
     public
       Constructor Create(OnChangeEvent:TNotifyEvent);
       Destructor Destroy; override;
       Procedure Assign(Source:TPersistent); override;
     published
       property Color default clDefault;
       property Image:TPicture read GetImage write SetImage;
     end;

     TTeeView3DScrolled=procedure(IsHoriz:Boolean) of object;
     TTeeView3DChangedZoom=procedure(NewZoom:Integer) of object;

     TView3DOptions = class(TPersistent)
     private
       FElevation   : Integer;
       FHorizOffset : Integer;
       FOrthogonal  : Boolean;
       FOrthoAngle  : Integer;
       FPerspective : Integer;
       FRotation    : Integer;
       FTilt        : Integer;
       FVertOffset  : Integer;
       FZoom        : Integer;
       FZoomText    : Boolean;
       FOnScrolled  : TTeeView3DScrolled;
       FOnChangedZoom:TTeeView3DChangedZoom;

       FParent      : TWinControl;
       Procedure SetElevation(Value:Integer);
       Procedure SetPerspective(Value:Integer);
       Procedure SetRotation(Value:Integer);
       Procedure SetTilt(Value:Integer);
       Procedure SetHorizOffset(Value:Integer);
       Procedure SetVertOffset(Value:Integer);
       Procedure SetOrthoAngle(Value:Integer);
       Procedure SetOrthogonal(Value:Boolean);
       Procedure SetZoom(Value:Integer);
       Procedure SetZoomText(Value:Boolean);
       Procedure SetBooleanProperty(Var Variable:Boolean; Value:Boolean);
       Procedure SetIntegerProperty(Var Variable:Integer; Value:Integer);
     protected
       function CalcOrthoRatio:Double;
     public
       Constructor Create(AParent:TWinControl);
       Procedure Repaint;
       Procedure Assign(Source:TPersistent); override;
       property Parent:TWinControl read FParent write FParent;
       property OnChangedZoom:TTeeView3DChangedZoom read FOnChangedZoom
                                                    write FOnChangedZoom;
       property OnScrolled:TTeeView3DScrolled read FOnScrolled write FOnScrolled;
     published
       property Elevation:Integer read FElevation write SetElevation default 345;
       property HorizOffset:Integer read FHorizOffset write SetHorizOffset default 0;
       property OrthoAngle:Integer read FOrthoAngle write SetOrthoAngle default 45;
       property Orthogonal:Boolean read FOrthogonal write SetOrthogonal default True;
       property Perspective:Integer read FPerspective
                                    write SetPerspective default TeeDefaultPerspective;
       property Rotation:Integer read FRotation write SetRotation default 345;
       property Tilt:Integer read FTilt write SetTilt default 0;
       property VertOffset:Integer read FVertOffset write SetVertOffset default 0;
       property Zoom:Integer read FZoom write SetZoom default 100;
       property ZoomText:Boolean read FZoomText write SetZoomText default True;
     end;

     TTeeCanvas=class;
     TCanvas3D=class;

     TTeeTransparency=0..100;

     TTeeBlend=class
     private
       FBitmap : TBitmap;
       FCanvas : TTeeCanvas;
       FRect   : TRect;

       IValidSize : Boolean;
     public
       Constructor Create(ACanvas:TTeeCanvas; Const R:TRect);
       Destructor Destroy; override;

       Procedure DoBlend(Transparency:TTeeTransparency);
       Procedure SetRectangle(Const R:TRect);
     end;

     TTeeShadow=class(TPersistent)
     private
       FColor        : TColor;
       FHorizSize    : Integer;
       FTransparency : TTeeTransparency;
       FVertSize     : Integer;

       IOnChange     : TNotifyEvent;
       IBlend        : TTeeBlend;

       procedure FinishBlending(ACanvas:TTeeCanvas);
       function GetSize: Integer;
       function IsColorStored: Boolean;
       function IsHorizStored: Boolean;
       function IsVertStored: Boolean;
       Function PrepareCanvas(ACanvas:TCanvas3D; const R:TRect;
                              Z:Integer=0):Boolean;
       Procedure SetColor(Value:TColor);
       Procedure SetHorizSize(Value:Integer);
       Procedure SetIntegerProperty(Var Variable:Integer; Const Value:Integer);
       procedure SetSize(const Value: Integer);
       procedure SetTransparency(Value: TTeeTransparency);
       Procedure SetVertSize(Value:Integer);
     protected
       DefaultColor : TColor;
       DefaultSize  : Integer;
     public
       Constructor Create(AOnChange:TNotifyEvent);
       Procedure Assign(Source:TPersistent); override;
       procedure Draw(ACanvas:TCanvas3D; Const Rect:TRect);
       procedure DrawEllipse(ACanvas:TCanvas3D; Const Rect:TRect; Z:Integer=0);
       property Size:Integer read GetSize write SetSize;
     published
       property Color:TColor read FColor write SetColor stored IsColorStored;
       property HorizSize:Integer read FHorizSize write SetHorizSize stored IsHorizStored;
       property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
       property VertSize:Integer read FVertSize write SetVertSize stored IsVertStored;
     end;

     TFourPoints=Array[0..3] of TPoint;

     TGradientDirection = (gdTopBottom, gdBottomTop,
                           gdLeftRight, gdRightLeft,
                           gdFromCenter, gdFromTopLeft,
                           gdFromBottomLeft, gdRadial );

     TCustomTeeGradient=class(TPersistent)
     private
       FBalance    : Integer;
       FDirection  : TGradientDirection;
       FEndColor   : TColor;
       FMidColor   : TColor;
       FRadialX    : Integer;
       FRadialY    : Integer;
       FStartColor : TColor;
       FVisible    : Boolean;

       IChanged   : TNotifyEvent;
       IHasMiddle : Boolean;
       Procedure DrawRadial(Canvas:TTeeCanvas; Rect:TRect);
       Function GetMidColor:TColor;
       Procedure SetBalance(Value:Integer);
       Procedure SetDirection(Value:TGradientDirection);
       Procedure SetEndColor(Value:TColor);
       Procedure SetIntegerProperty(Var Variable:Integer; Value:Integer);
       Procedure SetMidColor(Value:TColor);
       procedure SetRadialX(const Value: Integer);
       procedure SetRadialY(const Value: Integer);
       Procedure SetStartColor(Value:TColor);
       Procedure SetVisible(Value:Boolean);
     public
       Constructor Create(ChangedEvent:TNotifyEvent); virtual;
       Procedure Assign(Source:TPersistent); override;
       Procedure Draw(Canvas:TTeeCanvas; Const Rect:TRect; RoundRectSize:Integer=0); overload;
       Procedure Draw(Canvas:TTeeCanvas; var P:TFourPoints); overload;
       Procedure Draw(Canvas:TCanvas3D; var P:TFourPoints; Z:Integer); overload;
       property Changed:TNotifyEvent read IChanged write IChanged;
       Procedure UseMiddleColor;

       { to be published }
       property Balance:Integer read FBalance write SetBalance default 50;
       property Direction:TGradientDirection read FDirection write SetDirection default gdTopBottom;
       property EndColor:TColor read FEndColor write SetEndColor default clYellow;
       property MidColor:TColor read GetMidColor write SetMidColor default clNone;
       property RadialX:Integer read FRadialX write SetRadialX default 0;
       property RadialY:Integer read FRadialY write SetRadialY default 0;
       property StartColor:TColor read FStartColor write SetStartColor default clWhite;
       property Visible:Boolean read FVisible write SetVisible default False;
     end;

     TTeeGradient=class(TCustomTeeGradient)
     published
       property Balance;
       property Direction;
       property EndColor;
       property MidColor;
       property RadialX;
       property RadialY;
       property StartColor;
       property Visible;
     end;

     TTeeFontGradient=class(TTeeGradient)
     private
       FOutline : Boolean;

       Procedure SetBooleanProperty( Var Variable:Boolean;
                                     Const Value:Boolean);
       procedure SetOutline(const Value: Boolean);
     published
       property Outline:Boolean read FOutline write SetOutline default False;
     end;

     TTeeFont=class(TFont)
     private
       FGradient      : TTeeFontGradient;
       FInterCharSize : Integer;
       FOutLine       : TChartHiddenPen;
       FShadow        : TTeeShadow;

       ICanvas        : TTeeCanvas;
       function GetGradient: TTeeFontGradient;
       function GetOutLine: TChartHiddenPen;
       Function GetShadow: TTeeShadow;
       Function IsColorStored:Boolean;
       Function IsHeightStored:Boolean;
       Function IsNameStored:Boolean;
       Function IsStyleStored:Boolean;
       Procedure SetInterCharSize(Value:Integer);
       Procedure SetOutLine(Value:TChartHiddenPen);
       Procedure SetShadow(Value:TTeeShadow);
       procedure SetGradient(const Value: TTeeFontGradient);
     protected
       IDefColor : TColor;
       IDefStyle : TFontStyles;
     public
       Constructor Create(ChangedEvent:TNotifyEvent);
       Destructor Destroy; override;
       Procedure Assign(Source:TPersistent); override;
     published
       {$IFNDEF CLX}
       property Charset default DEFAULT_CHARSET;
       {$ENDIF}
       property Color stored IsColorStored;
       property Gradient:TTeeFontGradient read GetGradient write SetGradient;
       property Height stored IsHeightStored;
       property InterCharSize:Integer read FInterCharSize
                                      write SetInterCharSize default 0;
       property Name stored IsNameStored;
       property OutLine:TChartHiddenPen read GetOutLine write SetOutLine;
       {$IFDEF CLX}
       property Pitch default fpVariable;
       {$ENDIF}
       property Shadow:TTeeShadow read GetShadow write SetShadow;
       property Style stored IsStyleStored;
       {$IFDEF CLX}
       property Weight default 40;
       {$ENDIF}
     end;

     TPointArray      =Array of TPoint;

     TCanvasBackMode  = ( cbmNone,cbmTransparent,cbmOpaque );
     TCanvasTextAlign = Integer;

     TTeeCanvasHandle={$IFDEF CLX}QPainterH{$ELSE}HDC{$ENDIF};

     TTeeCanvas=class
     private
       FCanvas     : TCanvas;
       FFont       : TFont;
       FPen        : TPen;
       FBrush      : TBrush;
       FMetafiling : Boolean;

       ITransp       : Integer;
       Procedure InternalDark(Const AColor:TColor; Quantity:Byte);
     protected
       IFont        : TTeeFont;
       Procedure SetCanvas(ACanvas:TCanvas);

       function GetBackColor:TColor; virtual;
       Function GetBackMode:TCanvasBackMode; virtual;
       Function GetHandle:TTeeCanvasHandle; virtual; abstract;
       Function GetMonochrome:Boolean; virtual; abstract;
       Function GetPixel(x,y:Integer):TColor; virtual; abstract;
       Function GetTextAlign:TCanvasTextAlign; virtual; abstract;
       Function GetUseBuffer:Boolean; virtual; abstract;
       Procedure SetBackColor(Color:TColor); virtual;
       Procedure SetBackMode(Mode:TCanvasBackMode); virtual;
       Procedure SetMonochrome(Value:Boolean); virtual; abstract;
       procedure SetPixel(X, Y: Integer; Value: TColor); virtual; abstract;
       procedure SetTextAlign(Align:TCanvasTextAlign); virtual; abstract;
       Procedure SetUseBuffer(Value:Boolean); virtual; abstract;
     public
       FontZoom : Double; // % of zoom of all font sizes

       Procedure AssignBrush(ABrush:TChartBrush; ABackColor:TColor);
       Procedure AssignBrushColor(ABrush:TChartBrush; AColor,ABackColor:TColor);
       procedure AssignVisiblePen(APen:TPen);
       procedure AssignVisiblePenColor(APen:TPen; AColor:TColor);
       procedure AssignFont(AFont:TTeeFont);
       Procedure ResetState;

       Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; virtual;
       procedure EndBlending(Blend:TTeeBlend); virtual;

       { 2d }
       procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual; abstract;
       procedure Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                        Const StartAngle,EndAngle,HolePercent:Double); virtual; abstract;
       procedure Draw(X, Y: Integer; Graphic: TGraphic); virtual; abstract;
       procedure Ellipse(const R:TRect); overload;
       procedure Ellipse(X1, Y1, X2, Y2: Integer); overload; virtual; abstract;
       procedure FillRect(const Rect: TRect); virtual; abstract;
       procedure Frame3D( var Rect: TRect; TopColor,BottomColor: TColor;
                          Width: Integer); virtual; abstract;
       procedure LineTo(X,Y:Integer); virtual; abstract;
       procedure MoveTo(X,Y:Integer); virtual; abstract;
       procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); virtual; abstract;
       procedure Rectangle(const R:TRect); overload;
       procedure Rectangle(X0,Y0,X1,Y1:Integer); overload; virtual; abstract;
       procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); overload; virtual; abstract;
       procedure RoundRect(Const R:TRect; X,Y:Integer); overload;
       procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); overload; virtual; abstract;
       Procedure TextOut(X,Y:Integer; const Text:String); virtual; abstract;
       Function TextWidth(Const St:String):Integer; virtual;
       Function TextHeight(Const St:String):Integer; virtual;
       Function FontHeight:Integer;

       { 2d extra }
       procedure ClipRectangle(Const Rect:TRect); virtual; abstract;
       Procedure DoHorizLine(X0,X1,Y:Integer); virtual; abstract;
       Procedure DoRectangle(Const Rect:TRect); // obsolete
       Procedure DoVertLine(X,Y0,Y1:Integer); virtual; abstract;
       procedure EraseBackground(const Rect: TRect); virtual; abstract;
       Procedure GradientFill( Const Rect:TRect;
                               StartColor,EndColor:TColor;
                               Direction:TGradientDirection;
                               Balance:Integer=50); virtual; abstract;
       Procedure Invalidate; virtual; abstract;
       Procedure Line(X0,Y0,X1,Y1:Integer);  overload; virtual; abstract;
       Procedure Line(const FromPoint,ToPoint:TPoint); overload;
       {$IFDEF D5}
       Procedure Polyline(const Points:Array of TPoint); overload; virtual; abstract;
       {$ELSE}
       Procedure Polyline(const Points:TPointArray); overload; virtual; abstract;
       {$ENDIF}
       Procedure Polygon(const Points: Array of TPoint); virtual; abstract;
       procedure RotateLabel( x,y:Integer; Const St:String;
                              RotDegree:Integer); virtual; abstract;
       procedure UnClipRectangle; virtual; abstract;

     { properties }
       property BackColor:TColor read GetBackColor write SetBackColor;
       property BackMode:TCanvasBackMode read GetBackMode write SetBackMode;
       property Brush:TBrush read FBrush;
       property Font:TFont read FFont;
       property Handle:TTeeCanvasHandle read GetHandle;
       property Metafiling:Boolean read FMetafiling write FMetafiling;
       property Monochrome:Boolean read GetMonochrome write SetMonochrome;
       property Pen:TPen read FPen;
       property Pixels[X, Y: Integer]: TColor read GetPixel write SetPixel;
       property ReferenceCanvas:TCanvas read FCanvas write SetCanvas;
       property TextAlign:TCanvasTextAlign read GetTextAlign write SetTextAlign;
       property UseBuffer:Boolean read GetUseBuffer write SetUseBuffer;
     end;

     { 3d }
     TPoint3DFloat=packed record
       X : Double;
       Y : Double;
       Z : Double;
     end;

     TPoint3D         =Packed Record x,y,z:Integer; end;
     TTrianglePoints  =Array[0..2] of TPoint;
     TTrianglePoints3D=Array[0..2] of TPoint3D;
     TTriangleColors3D=Array[0..2] of TColor;

     TTeeCanvasCalcPoints=Function( x,z:Integer; Var P0,P1:TPoint3D;
                                    Var Color0,Color1:TColor):Boolean of object;

     TTeeCanvasSurfaceStyle=(tcsSolid,tcsWire,tcsDot);

     TCanvas3D=class(TTeeCanvas)
     private
       F3DOptions    : TView3DOptions;
     protected
       FIsOrthogonal : Boolean;  // 6.01, moved from private due to RotateTool
       Function GetPixel3D(X,Y,Z:Integer):TColor; virtual; abstract;
       Function GetSupportsFullRotation:Boolean; virtual; abstract;
       Function GetSupports3DText:Boolean; virtual; abstract;
       procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); virtual; abstract;
     public
       RotationCenter : TPoint3DFloat;

       { 3d }
       Function CalcRect3D(Const R:TRect; Z:Integer):TRect;
       Procedure Calculate2DPosition(Var x,y:Integer; z:Integer); virtual; abstract;
       Function Calculate3DPosition(P:TPoint; z:Integer):TPoint; overload;
       Function Calculate3DPosition(x,y,z:Integer):TPoint; overload; virtual; abstract;

       Function FourPointsFromRect(Const R:TRect; Z:Integer):TFourPoints;
       Function RectFromRectZ(Const R:TRect; Z:Integer):TRect;

       Function InitWindow( DestCanvas:TCanvas; A3DOptions:TView3DOptions;
                            ABackColor:TColor;
                            Is3D:Boolean;
                            Const UserRect:TRect):TRect; virtual; abstract;

       Procedure Assign(Source:TCanvas3D); virtual;

       Procedure Projection(MaxDepth:Integer; const Bounds,Rect:TRect); virtual; abstract;
       Procedure ShowImage( DestCanvas,DefaultCanvas:TCanvas;
                            Const UserRect:TRect); virtual; abstract;
       Function ReDrawBitmap:Boolean; virtual; abstract;

       Procedure Arrow( Filled:Boolean; Const FromPoint,ToPoint:TPoint;
                        ArrowWidth,ArrowHeight,Z:Integer); virtual; abstract;
       procedure ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer); virtual; abstract;
       procedure Cone( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                       Dark3D:Boolean; ConePercent:Integer); virtual; abstract;
       Procedure Cube( Left,Right,Top,Bottom,Z0,Z1:Integer;
                       DarkSides:Boolean); overload; virtual; abstract;
       Procedure Cube( const R:TRect; Z0,Z1:Integer;
                       DarkSides:Boolean); overload;

       procedure Cylinder( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                           Dark3D:Boolean); virtual; abstract;
       Procedure HorizLine3D(Left,Right,Y,Z:Integer); virtual; abstract;
       Procedure VertLine3D(X,Top,Bottom,Z:Integer); virtual; abstract;
       Procedure ZLine3D(X,Y,Z0,Z1:Integer); virtual; abstract;
       procedure EllipseWithZ(X1, Y1, X2, Y2, Z: Integer); virtual; abstract;
       procedure FrontPlaneBegin; virtual; abstract;
       procedure FrontPlaneEnd; virtual; abstract;
       Procedure LineWithZ(X0,Y0,X1,Y1,Z:Integer);  overload; virtual; abstract;
       Procedure LineWithZ(const FromPoint,ToPoint:TPoint; Z:Integer); overload;
       procedure MoveTo3D(X,Y,Z:Integer); virtual; abstract;
       procedure LineTo3D(X,Y,Z:Integer); virtual; abstract;
       procedure Pie3D( XCenter,YCenter,XRadius,YRadius,Z0,Z1:Integer;
                        Const StartAngle,EndAngle:Double;
                        DarkSides,DrawSides:Boolean;
                        DonutPercent:Integer=0); virtual; abstract;
       procedure Plane3D(Const A,B:TPoint; Z0,Z1:Integer); virtual; abstract;
       procedure PlaneWithZ(const P:TFourPoints; Z:Integer); overload;
       procedure PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer); overload; virtual; abstract;
       procedure PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer); virtual; abstract;
       procedure PolygonWithZ(Points: Array of TPoint; Z:Integer); virtual; abstract;
       procedure Polyline(const Points: Array of TPoint; Z:Integer); overload; virtual; abstract;
       procedure Pyramid( Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer;
                          DarkSides:Boolean); virtual; abstract;
       Procedure PyramidTrunc(Const R:TRect; StartZ,EndZ:Integer;
                              TruncX,TruncZ:Integer); virtual; abstract;
       Procedure RectangleWithZ(Const Rect:TRect; Z:Integer); virtual; abstract;
       Procedure RectangleY(Left,Top,Right,Z0,Z1:Integer); virtual; abstract;
       Procedure RectangleZ(Left,Top,Bottom,Z0,Z1:Integer); virtual; abstract;
       procedure RotatedEllipse(Left,Top,Right,Bottom,Z:Integer; Const Angle:Double); 
       procedure RotateLabel3D( x,y,z:Integer; Const St:String;
                                RotDegree:Integer); virtual; abstract;
       procedure Sphere(x,y,z:Integer; Const Radius:Double); virtual; abstract;
       procedure StretchDraw(const Rect: TRect; Graphic: TGraphic; Z:Integer); overload;
       Procedure Surface3D( Style:TTeeCanvasSurfaceStyle;
                            SameBrush:Boolean; NumXValues,NumZValues:Integer;
                            CalcPoints:TTeeCanvasCalcPoints ); virtual; abstract;
       Procedure TextOut3D(x,y,z:Integer; const Text:String); virtual; abstract;
       procedure Triangle3D( Const Points:TTrianglePoints3D;
                             Const Colors:TTriangleColors3D); virtual; abstract;
       procedure TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer); virtual; abstract;

       property Pixels3D[X,Y,Z:Integer]:TColor read GetPixel3D write SetPixel3D;
       property Supports3DText:Boolean read GetSupports3DText;
       property SupportsFullRotation:Boolean read GetSupportsFullRotation;
       property View3DOptions:TView3DOptions read F3DOptions write F3DOptions;
     end;

{.$DEFINE NEWXYZ}

     TTeeCanvas3D=class(TCanvas3D)
     private
       FXCenter        : Integer;
       FYCenter        : Integer;
       FZCenter        : Integer;
       FXCenterOffset  : Integer;
       FYCenterOffset  : Integer;

       s1              : Extended;
       s2              : Extended;
       s3              : Extended;
       c1              : Extended;
       c2              : Extended;
       c3              : Extended;

       {$IFNDEF NEWXYZ}
       c2s1            : Double;
       c2c1            : Double;
       {$ENDIF}

       c2s3            : Double;
       c2c3            : Double;
       tempXX          : Double;
       tempYX          : Double;
       tempXZ          : Double;
       tempYZ          : Double;

       FWas3D          : Boolean;

       FBitmap         : TBitmap;
       {$IFDEF TEEBITMAPSPEED}
       IBitmapCanvas   : TTeeCanvasHandle;
       {$ENDIF}

       FDirty          : Boolean;
       FMonochrome     : Boolean;
       FTextAlign      : TCanvasTextAlign;

       FBounds         : TRect;

       IHasPerspec     : Boolean;
       IOrthoX         : Double;
       IOrthoY         : Double;
       IZoomPerspec    : Double;
       IZoomFactor     : Double;
       IZoomText       : Boolean;

       procedure InternalCylinder(Vertical:Boolean; Left,Top,Right,Bottom,
                            Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
     protected
       FBufferedDisplay : Boolean;
       FIs3D            : Boolean;
       IPoints          : TFourPoints;

       { 2d }
       Function GetHandle:TTeeCanvasHandle; override;
       Function GetMonochrome:Boolean; override;
       Function GetPixel(X, Y: Integer):TColor; override;
       Function GetPixel3D(X,Y,Z:Integer):TColor; override;
       Function GetSupports3DText:Boolean; override;
       Function GetSupportsFullRotation:Boolean; override;
       Function GetTextAlign:TCanvasTextAlign; override;
       Function GetUseBuffer:Boolean; override;

       Procedure PolygonFour; virtual;

       Procedure SetMonochrome(Value:Boolean); override;
       procedure SetPixel(X, Y: Integer; Value: TColor); override;
       procedure SetTextAlign(Align:TCanvasTextAlign); override;
       Procedure SetUseBuffer(Value:Boolean); override;

       Procedure DeleteBitmap; virtual;
       Procedure TransferBitmap(ALeft,ATop:Integer; ACanvas:TCanvas); virtual;

       { 3d private }
       Procedure Calc3DTPoint(Var P:TPoint; z:Integer);
       Function Calc3DTPoint3D(Const P:TPoint3D):TPoint;
       Procedure Calc3DPoint(Var P:TPoint; x,y,z:Integer);

       { 3d }
       procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
       Procedure Calc3DPos(var x,y:Integer; z:Integer); overload;

       Procedure CalcPerspective(const Rect:TRect);
       Procedure CalcTrigValues;
     public
       { almost public... }
       Procedure Calculate2DPosition(Var x,y:Integer; z:Integer); override;
       Function Calculate3DPosition(x,y,z:Integer):TPoint; override;

       { public }
       Constructor Create;
       Destructor Destroy; override;

       Function InitWindow( DestCanvas:TCanvas;
                            A3DOptions:TView3DOptions;
                            ABackColor:TColor;
                            Is3D:Boolean;
                            Const UserRect:TRect):TRect; override;
       Function ReDrawBitmap:Boolean; override;
       Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;

       procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
       procedure Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                        Const StartAngle,EndAngle,HolePercent:Double); override;
       procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
       procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
       procedure EraseBackground(const Rect: TRect); override;
       procedure FillRect(const Rect: TRect); override;
       procedure Frame3D( var Rect: TRect; TopColor,BottomColor: TColor;
                          Width: Integer); override;
       procedure LineTo(X,Y:Integer); override;
       procedure MoveTo(X,Y:Integer); override;
       procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
       procedure Rectangle(X0,Y0,X1,Y1:Integer); override;
       procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
       procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
       Procedure TextOut(X,Y:Integer; const Text:String); override;

       { 2d extra }
       procedure ClipRectangle(Const Rect:TRect); override;
       procedure ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer); override;
       Procedure DoHorizLine(X0,X1,Y:Integer); override;
       Procedure DoVertLine(X,Y0,Y1:Integer); override;
       Procedure GradientFill( Const Rect:TRect;
                               StartColor,EndColor:TColor;
                               Direction:TGradientDirection;
                               Balance:Integer=50); override;
       Procedure Invalidate; override;
       Procedure Line(X0,Y0,X1,Y1:Integer); override;
       {$IFDEF D5}
       Procedure Polyline(const Points:Array of TPoint); override;
       {$ELSE}
       Procedure Polyline(const Points:TPointArray); override;
       {$ENDIF}
       Procedure Polygon(const Points: Array of TPoint); override;
       procedure RotateLabel(x,y:Integer; Const St:String; RotDegree:Integer); override;
       procedure RotateLabel3D( x,y,z:Integer;
                                Const St:String; RotDegree:Integer); override;
       procedure UnClipRectangle; override;

       property XCenter:Integer read FXCenter write FXCenter;
       property YCenter:Integer read FYCenter write FYCenter;
       property ZCenter:Integer read FZCenter write FZCenter;

       { 3d }
       Procedure Projection(MaxDepth:Integer; const Bounds,Rect:TRect); override;

       Procedure Arrow( Filled:Boolean; Const FromPoint,ToPoint:TPoint;
                        ArrowWidth,ArrowHeight,Z:Integer); override;
       procedure Cone( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                       Dark3D:Boolean; ConePercent:Integer); override;
       Procedure Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean); override;
       procedure Cylinder( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                           Dark3D:Boolean); override;
       procedure EllipseWithZ(X1, Y1, X2, Y2, Z: Integer); override;
       Procedure RectangleZ(Left,Top,Bottom,Z0,Z1:Integer); override;
       Procedure RectangleY(Left,Top,Right,Z0,Z1:Integer); override;
       procedure FrontPlaneBegin; override;
       procedure FrontPlaneEnd; override;
       Procedure HorizLine3D(Left,Right,Y,Z:Integer); override;
       procedure LineTo3D(X,Y,Z:Integer); override;
       Procedure LineWithZ(X0,Y0,X1,Y1,Z:Integer); override;
       procedure MoveTo3D(X,Y,Z:Integer); override;
       procedure Pie3D( XCenter,YCenter,XRadius,YRadius,Z0,Z1:Integer;
                        Const StartAngle,EndAngle:Double;
                        DarkSides,DrawSides:Boolean; DonutPercent:Integer=0); override;
       procedure Plane3D(Const A,B:TPoint; Z0,Z1:Integer); override;
       procedure PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer); override;
       procedure PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer); override;
       procedure PolygonWithZ(Points: Array of TPoint; Z:Integer); override;
       procedure Polyline(const Points: Array of TPoint; Z:Integer); override;
       procedure Pyramid( Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer;
                          DarkSides:Boolean); override;
       Procedure PyramidTrunc(Const R:TRect; StartZ,EndZ:Integer;
                              TruncX,TruncZ:Integer); override;
       Procedure RectangleWithZ(Const Rect:TRect; Z:Integer); override;
       procedure Sphere(x,y,z:Integer; Const Radius:Double); override;
       Procedure Surface3D( Style:TTeeCanvasSurfaceStyle;
                            SameBrush:Boolean;
                            NumXValues,NumZValues:Integer;
                            CalcPoints:TTeeCanvasCalcPoints ); override;
       Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
       procedure Triangle3D( Const Points:TTrianglePoints3D;
                             Const Colors:TTriangleColors3D); override;
       procedure TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer); override;
       Procedure VertLine3D(X,Top,Bottom,Z:Integer); override;
       Procedure ZLine3D(X,Y,Z0,Z1:Integer); override;

       property Bitmap:TBitmap read FBitmap;
       property Bounds:TRect read FBounds;
     end;

Function ApplyDark(Color:TColor; HowMuch:Byte):TColor;
Function ApplyBright(Color:TColor; HowMuch:Byte):TColor;

Function Point3D(x,y,z:Integer):TPoint3D;

Procedure SwapDouble(Var a,b:Double);    { exchanges a and b }
Procedure SwapInteger(Var a,b:Integer);  { exchanges a and b }

Procedure RectSize(Const R:TRect; Var RectWidth,RectHeight:Integer);
Procedure RectCenter(Const R:TRect; Var X,Y:Integer);
Function RectFromPolygon(Const Points:Array of TPoint; NumPoints:Integer):TRect;
Procedure ClipCanvas(ACanvas:TCanvas; Const Rect:TRect);
Procedure UnClipCanvas(ACanvas:TCanvas);

Procedure ClipEllipse(ACanvas:TTeeCanvas; Const Rect:TRect);
Procedure ClipRoundRectangle(ACanvas:TTeeCanvas; Const Rect:TRect; RoundSize:Integer);
Procedure ClipPolygon(ACanvas:TTeeCanvas; Var Points:Array of TPoint; NumPoints:Integer);

Const TeeCharForHeight     = 'W';  { <-- this is used to calculate Text Height }
      DarkerColorQuantity  : Byte=128; { <-- for dark 3D sides }
      DarkColorQuantity    : Byte=64;

type
  TButtonGetColorProc=function:TColor of object;

  TTeeButton = class(TButton)
  private
    {$IFNDEF CLX}
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    {$ENDIF}
  protected
    Instance : TObject;
    Info     : PPropInfo;
    Procedure DrawSymbol(ACanvas:TTeeCanvas); virtual; abstract;
    {$IFNDEF CLX}
    procedure PaintWindow(DC: HDC); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    {$ELSE}
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
    {$ENDIF}
  public
    Procedure LinkProperty(AInstance:TObject; Const PropName:String);
  published
    { Published declarations }
    property Height default 25;
    property Width default 75;
  end;

  TButtonColor = class(TTeeButton)
  private
    Function GetTeeColor : TColor;
  protected
    procedure DrawSymbol(ACanvas:TTeeCanvas); override;
  public
    GetColorProc : TButtonGetColorProc;
    procedure Click; override;
    property SymbolColor:TColor read GetTeeColor;
  end;

  TComboFlat=class(TComboBox)
  private
    {$IFNDEF CLX}
    Inside: Boolean;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    {$ENDIF}
  public
    Constructor Create(AOwner:TComponent); override;
  published
    property Style default csDropDownList;
    property Height default 21;
    property ItemHeight default 13;
  end;

{$IFNDEF D5}
procedure FreeAndNil(var Obj);
{$ENDIF}

var IsWindowsNT:Boolean=False;
    GetDefaultFontSize:Integer=0;
    GetDefaultFontName:String='';

{$IFDEF LINUX}
Function GetRValue(Color:Integer):Byte;
Function GetGValue(Color:Integer):Byte;
Function GetBValue(Color:Integer):Byte;
Function RGB(r,g,b:Integer):TColor;
{$ENDIF}

{$IFDEF CLX}
Function TeeCreatePenSmallDots(AColor:TColor):QPenH;
{$ELSE}
Function TeeCreatePenSmallDots(AColor:TColor):HPen;
{$ENDIF}

Procedure TeeSetTeePen(FPen:TPen; APen:TChartPen; AColor:TColor);

// Converts ABitmap pixels into Gray Scale (levels of gray)
Procedure TeeGrayScale(ABitmap:TBitmap; Inverted:Boolean; AMethod:Integer); { 5.02 }

Function TeePoint(aX,aY:Integer):TPoint; { compatibility with D6 CLX }
function PointInRect(Const Rect:TRect; x,y:Integer):Boolean; { compatibility with D6 CLX }
function TeeRect(Left,Top,Right,Bottom:Integer):TRect; { compatibility with D6 CLX }
Function OrientRectangle(Const R:TRect):TRect;

// Default color depth 
Const TeePixelFormat={$IFDEF CLX}pf32Bit{$ELSE}pf24Bit{$ENDIF};

{$IFDEF CLX}
type
  TRGBTriple=packed record
    rgbtBlue   : Byte;
    rgbtGreen  : Byte;
    rgbtRed    : Byte;
    rgbtAlpha  : Byte;  // Linux ?
  end;
{$ENDIF}

Function RGBValue(Color:TColor):TRGBTriple;

{ Show the TColorDialog, return new color if changed }
Function EditColor(AOwner:TComponent; AColor:TColor):TColor;

{ Show the TColorDialog, return True if color changed }
Function EditColorDialog(AOwner:TComponent; var AColor:TColor):Boolean;

// Returns point "ATo" minus ADist pixels from AFrom point.
Function PointAtDistance(AFrom,ATo:TPoint; ADist:Integer):TPoint;

// Returns True when 3 first points in P are "face-viewing".
Function TeeCull(const P:TFourPoints):Boolean; overload;
Function TeeCull(const P0,P1,P2:TPoint):Boolean; overload;

// Returns Sqrt( Sqr(x)+Sqr(y) )
Function TeeDistance(x,y:Integer):Double;

{ Used at EditColor function, for the Color Editor dialog }
var TeeCustomEditColors:TStrings=nil;

    {$IFNDEF CLX}
    TeeFontAntiAlias:Integer=ANTIALIASED_QUALITY;
    {$ENDIF}

implementation

Uses {$IFDEF CLX}
     QForms, QDialogs,
     {$ELSE}
     Forms, Dialogs,
     {$ENDIF}
     Math,
     {$IFNDEF CLX}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$ENDIF}
     TeeConst;

type PPoints = ^TPoints;
     TPoints = Array[0..0] of TPoint;

{$IFNDEF CLX}
var WasOldRegion : Boolean=False;
    OldRegion    : HRgn=0;
{$ENDIF}

Function TeeCull(const P:TFourPoints):Boolean;
begin
  result:=TeeCull(P[0],P[1],P[2]);
end;

Function TeeCull(const P0,P1,P2:TPoint):Boolean;
begin
  result:=( ((P0.x-P1.x) * (P2.y-P1.y)) -
            ((P2.x-P1.x) * (P0.y-P1.y))
          ) < 0;
end;

Function TeePoint(aX,aY:Integer):TPoint;
begin
  with result do
  begin
    X:=aX;
    Y:=aY;
  end;
end;

function PointInRect(Const Rect:TRect; x,y:Integer):Boolean;
begin
  result:=(x>=Rect.Left) and (y>=Rect.Top) and (x<Rect.Right) and (y<Rect.Bottom);
end;

function TeeRect(Left,Top,Right,Bottom:Integer):TRect;
begin
  result.Left  :=Left;
  result.Top   :=Top;
  result.Bottom:=Bottom;
  result.Right :=Right;
end;

// Makes sure the R rectangle Left is smaller than Right and
// Top is smaller than Bottom. Returns corrected rectangle.
Function OrientRectangle(Const R:TRect):TRect;
begin
  result:=R;
  with result do
  begin
    if Left>Right then SwapInteger(Left,Right);
    if Top>Bottom then SwapInteger(Top,Bottom);
  end;
end;

Function Point3D(x,y,z:Integer):TPoint3D;
begin
  result.x:=x;
  result.y:=y;
  result.z:=z;
end;

Procedure RectSize(Const R:TRect; Var RectWidth,RectHeight:Integer);
begin
  With R do
  begin
    RectWidth :=Right-Left;
    RectHeight:=Bottom-Top;
  end;
end;

Procedure RectCenter(Const R:TRect; Var X,Y:Integer);
begin
  With R do
  begin
    X:=(Left+Right) div 2;
    Y:=(Top+Bottom) div 2;
  end;
end;

{ TChartPen }
Constructor TChartPen.Create(OnChangeEvent:TNotifyEvent);
begin
  inherited Create;
  FVisible:=True;
  DefaultVisible:=True;

  DefaultEnd:=esRound;
  OnChange:=OnChangeEvent;
  {$IFDEF CLX}
  ReleaseHandle;
  Width:=1;
  {$ENDIF}
end;

Procedure TChartPen.Assign(Source:TPersistent);
begin
  if Source is TChartPen then
  begin
    FVisible  :=TChartPen(Source).Visible;
    FSmallDots:=TChartPen(Source).SmallDots;
    FEndStyle :=TChartPen(Source).EndStyle;  { 5.01 }
  end;
  {$IFDEF CLX}
  if not Assigned(Handle) then ReleaseHandle;
  {$ENDIF}
  inherited;
end;

Function TChartPen.IsEndStored:Boolean;
begin
  result:=FEndStyle<>DefaultEnd;
end;

Function TChartPen.IsVisibleStored:Boolean;
begin
  result:=FVisible<>DefaultVisible;
end;

procedure TChartPen.SetEndStyle(const Value: TPenEndStyle);
begin
  if FEndStyle<>Value then
  begin
    FEndStyle:=Value;
    Changed;
  end;
end;

Procedure TChartPen.SetSmallDots(Value:Boolean);
begin
  if FSmallDots<>Value then
  begin
    FSmallDots:=Value;
    Changed;
  end;
end;

Procedure TChartPen.SetVisible(Value:Boolean);
Begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    Changed;
  end;
end;

{ TChartHiddenPen }
Constructor TChartHiddenPen.Create(OnChangeEvent:TNotifyEvent);
Begin
  inherited;
  FVisible:=False;
  DefaultVisible:=False;
end;

{ TDottedGrayPen }
Constructor TDottedGrayPen.Create(OnChangeEvent:TNotifyEvent);
Begin
  inherited;
  Color:=clGray;
  Style:=psDot;
end;

{ TDarkGrayPen }
Constructor TDarkGrayPen.Create(OnChangeEvent:TNotifyEvent);
Begin
  inherited;
  Color:=clDkGray;
end;

{ TChartAxisPen }
Constructor TChartAxisPen.Create(OnChangeEvent:TNotifyEvent);
Begin
  inherited;
  Width:=2;
end;

{ TChartBrush }
Constructor TChartBrush.Create(OnChangeEvent:TNotifyEvent);
Begin
  inherited Create;
  Color:=clDefault;
  OnChange:=OnChangeEvent;
end;

Destructor TChartBrush.Destroy;
begin
  FImage.Free;
  inherited;
end;

Procedure TChartBrush.Assign(Source:TPersistent);
begin
  if Source is TChartBrush then
     Image.Assign(TChartBrush(Source).FImage);
  inherited;
end;

procedure TChartBrush.SetImage(Value: TPicture);
begin
  if Assigned(Value) then Image.Assign(Value)
                     else FreeAndNil(FImage);
end;

Function TChartBrush.GetImage:TPicture;
begin
  if not Assigned(FImage) then
  begin
    FImage:=TPicture.Create;
    FImage.OnChange:=OnChange;
  end;
  result:=FImage;
end;

{ TView3DOptions }
Constructor TView3DOptions.Create(AParent:TWinControl);
begin
  inherited Create;
  FParent      :=AParent;
  FOrthogonal  :=True;
  FOrthoAngle  :=45;
  FZoom        :=100; { % }
  FZoomText    :=True;
  FRotation    :=345;
  FElevation   :=345;
  FPerspective :=TeeDefaultPerspective; { % }
end;

Procedure TView3DOptions.Repaint;
begin
  FParent.Invalidate;
end;

Procedure TView3DOptions.SetIntegerProperty(Var Variable:Integer; Value:Integer);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    Repaint;
  end;
end;

Procedure TView3DOptions.SetBooleanProperty(Var Variable:Boolean; Value:Boolean);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    Repaint;
  end;
end;

Procedure TView3DOptions.SetElevation(Value:Integer);
begin
  SetIntegerProperty(FElevation,Value);
end;

Procedure TView3DOptions.SetPerspective(Value:Integer);
begin
  SetIntegerProperty(FPerspective,Value);
end;

Procedure TView3DOptions.SetRotation(Value:Integer);
begin
  SetIntegerProperty(FRotation,Value);
end;

Procedure TView3DOptions.SetTilt(Value:Integer);
begin
  SetIntegerProperty(FTilt,Value);
end;

Procedure TView3DOptions.SetHorizOffset(Value:Integer);
begin
  if FHorizOffset<>Value then
  begin
    FHorizOffset:=Value;
    Repaint;
    if Assigned(FOnScrolled) then FOnScrolled(True);
  end;
end;

Procedure TView3DOptions.SetVertOffset(Value:Integer);
begin
  if FVertOffset<>Value then
  begin
    FVertOffset:=Value;
    Repaint;
    if Assigned(FOnScrolled) then FOnScrolled(False);
  end;
end;

Procedure TView3DOptions.SetOrthoAngle(Value:Integer);
begin
  SetIntegerProperty(FOrthoAngle,Value);
end;

Procedure TView3DOptions.SetOrthogonal(Value:Boolean);
begin
  SetBooleanProperty(FOrthogonal,Value);
end;

Procedure TView3DOptions.SetZoom(Value:Integer);
begin
  if FZoom<>Value then
  begin
    if Assigned(FOnChangedZoom) then FOnChangedZoom(Value);
    FZoom:=Value;
    Repaint;
  end;
end;

Procedure TView3DOptions.SetZoomText(Value:Boolean);
begin
  SetBooleanProperty(FZoomText,Value);
end;

Procedure TView3DOptions.Assign(Source:TPersistent);
begin
  if Source is TView3DOptions then
  With TView3DOptions(Source) do
  begin
    Self.FElevation   :=FElevation;
    Self.FHorizOffset :=FHorizOffset;
    Self.FOrthoAngle  :=FOrthoAngle;
    Self.FOrthogonal  :=FOrthogonal;
    Self.FPerspective :=FPerspective;
    Self.FRotation    :=FRotation;
    Self.FTilt        :=FTilt;
    Self.FVertOffset  :=FVertOffset;
    Self.FZoom        :=FZoom;
    Self.FZoomText    :=FZoomText;
  end;
end;

function TView3DOptions.CalcOrthoRatio: Double;
var tmpSin   : Extended;
    tmpCos   : Extended;
    tmpAngle : Extended;
begin
  if Orthogonal then
  begin
    tmpAngle:=OrthoAngle;
    if tmpAngle>90 then tmpAngle:=180-tmpAngle;
    SinCos(tmpAngle*TeePiStep,tmpSin,tmpCos);
    result:=tmpSin/tmpCos;
  end
  else result:=1;
end;

{ TTeeCanvas }
Procedure TTeeCanvas.InternalDark(Const AColor:TColor; Quantity:Byte);
var tmpColor : TColor;
begin
  tmpColor:=ApplyDark(AColor,Quantity);
  if FBrush.Style=bsSolid then FBrush.Color:=tmpColor
                          else BackColor:=tmpColor;
end;

Procedure TTeeCanvas.SetCanvas(ACanvas:TCanvas);
begin
  FCanvas:=ACanvas;
  FPen   :=FCanvas.Pen;
  FFont  :=FCanvas.Font;
  FBrush :=FCanvas.Brush;
end;

Function TTeeCanvas.GetBackMode:TCanvasBackMode;
begin
  {$IFDEF CLX}
  if QPainter_BackgroundMode(Handle)=BGMode_TransparentMode then
     result:=cbmTransparent
  else
     result:=cbmOpaque;
  {$ELSE}
  result:=TCanvasBackMode(GetBkMode(FCanvas.Handle));
  {$ENDIF}
end;

Procedure TTeeCanvas.SetBackMode(Mode:TCanvasBackMode); { Opaque, Transparent }
begin
  {$IFDEF CLX}
  if Mode<>GetBackMode then
  begin
    FCanvas.Start;
    if Mode=cbmTransparent then QPainter_setBackgroundMode(Handle,BGMode_TransparentMode)
    else
    if Mode=cbmOpaque then QPainter_setBackGroundMode(Handle,BGMode_OpaqueMode);
    FCanvas.Stop;
  end;
  {$ELSE}
  SetBkMode(FCanvas.Handle,Ord(Mode));
  {$ENDIF}
end;

Procedure TTeeCanvas.SetBackColor(Color:TColor);
{$IFDEF CLX}
Var QC : QColorH;
{$ENDIF}
begin
  {$IFDEF CLX}
  if Color<>GetBackColor then
  begin
    QC:=QColor(Color);
    FCanvas.Start;
    QPainter_setBackgroundColor(Handle,QC);
    FCanvas.Stop;
    QColor_destroy(QC);
  end;
  {$ELSE}
  SetBkColor(FCanvas.Handle,TColorRef(ColorToRGB(Color)));
  {$ENDIF}
end;

function TTeeCanvas.GetBackColor:TColor;
begin
  {$IFDEF CLX}
  result:=QColorColor(QPainter_backgroundColor(Handle));
  {$ELSE}
  result:=TColor(GetBkColor(FCanvas.Handle));
  {$ENDIF}
end;

Procedure TTeeCanvas.ResetState;
begin
  With FPen do
  begin
    Color:=clBlack;
    Width:=1;
    Style:=psSolid;
  end;

  With FBrush do
  begin
    Color:=clWhite;
    Style:=bsSolid;
  end;

  With FFont do
  begin
    Color:=clBlack;
    Size:=10;
  end;

  BackColor:=clWhite;
  BackMode:=cbmTransparent;
  TextAlign:=TA_LEFT; { 5.01 }
end;

Procedure TTeeCanvas.AssignBrush(ABrush:TChartBrush; ABackColor:TColor);
begin
  AssignBrushColor(ABrush,ABackColor,ABrush.Color);
end;

{$IFDEF CLX}
Procedure SetTextColor(Handle:QPainterH; Color:Integer);
var QC : QColorH;
begin
  QC:=QColor(Color);
  try
    QPen_setColor(QPainter_pen(Handle), QC);
  finally
    QColor_destroy(QC);
  end;
end;
{$ENDIF}

Procedure TTeeCanvas.AssignBrushColor(ABrush:TChartBrush; AColor,ABackColor:TColor);
begin
  if Monochrome then AColor:=clWhite;
  if Assigned(ABrush.FImage) and Assigned(ABrush.FImage.Graphic) then
  begin
    Brush.Style:=bsClear;
    Brush.Bitmap:=ABrush.Image.Bitmap;
    SetTextColor(Handle,ColorToRGB(AColor));
    BackMode:=cbmOpaque;
    BackColor:=ABackColor;
  end
  else
  begin
    {$IFDEF CLX}
    Brush.Bitmap:=nil;
    {$ENDIF}

    if AColor<>Brush.Color then { 5.02 }
       Brush.Color:=AColor;

    if ABrush.Style<>Brush.Style then { 5.02 }
       Brush.Style:=ABrush.Style;

    if ABackColor=clNone then BackMode:=cbmTransparent { 5.02 }
    else
    begin
      BackMode:=cbmOpaque;
      BackColor:=ABackColor;
    end;
  end;
end;

procedure TTeeCanvas.AssignVisiblePen(APen:TPen);
begin
  AssignVisiblePenColor(APen,APen.Color);
end;

Procedure TTeeCanvas.Rectangle(Const R:TRect);
begin
  With R do Rectangle(Left,Top,Right,Bottom);
end;

Procedure TTeeCanvas.DoRectangle(Const Rect:TRect); // obsolete
begin
  Rectangle(Rect);
end;

Function RGBValue(Color:TColor):TRGBTriple;
begin
  with result do
  begin
    rgbtRed:=Byte(Color);
    rgbtGreen:=Byte(Color shr 8);
    rgbtBlue:=Byte(Color shr 16);
  end;
end;

Function TeeCreatePenSmallDots(AColor:TColor):{$IFDEF CLX}QPenH{$ELSE}HPen{$ENDIF};
{$IFNDEF CLX}
Var LBrush   : TLogBrush;
{$ENDIF}
begin
  {$IFDEF CLX}
  result:=QPen_create(QColor(AColor),1,PenStyle_DotLine);
  {$ELSE}
  LBrush.lbStyle:=bs_Solid;
  LBrush.lbColor:=ColorToRGB(AColor);
  result:=ExtCreatePen( PS_COSMETIC or PS_ALTERNATE,1,LBrush,0,nil );
  {$ENDIF}
end;

Procedure TeeSetTeePen(FPen:TPen; APen:TChartPen; AColor:TColor);
{$IFNDEF CLX}
const
  PenStyles: array[TPenStyle] of Word =
    (PS_SOLID, PS_DASH, PS_DOT, PS_DASHDOT, PS_DASHDOTDOT, PS_NULL,
     PS_INSIDEFRAME);

Var LBrush   : TLogBrush;
{$ENDIF}
{$IFNDEF CLX}
Var tmpEnd : Integer;
{$ENDIF}
begin
  if APen.SmallDots then
     FPen.Handle:=TeeCreatePenSmallDots(AColor)
  else
  {$IFNDEF CLX}
  if APen.Width>1 then
  begin
    LBrush.lbStyle:=bs_Solid;
    LBrush.lbColor:=ColorToRGB(AColor);
    Case APen.EndStyle of  { 5.01 }
      esRound : tmpEnd:=PS_ENDCAP_ROUND or PS_JOIN_ROUND;
      esSquare: tmpEnd:=PS_ENDCAP_SQUARE or PS_JOIN_BEVEL;
    else tmpEnd:=PS_ENDCAP_FLAT or PS_JOIN_MITER;
    end;

    FPen.Handle:=ExtCreatePen( PS_GEOMETRIC or
            PenStyles[APen.Style] or tmpEnd,APen.Width,LBrush,0,nil);
    FPen.Mode:=APen.Mode;
  end
  else
  {$ENDIF}
  begin
    FPen.Assign(APen);

    //if APen.Style<>FPen.Style then FPen.Style:=APen.Style;
    //if APen.Width<>FPen.Width then FPen.Width:=APen.Width;
    //if APen.Mode<>FPen.Mode then FPen.Mode:=APen.Mode;

    if FPen.Color<>AColor then FPen.Color:=AColor;
  end;
end;

procedure TTeeCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  if MonoChrome then AColor:=clBlack;
  if not (APen is TChartPen) then
  begin
    FPen.Assign(APen);
    FPen.Color:=AColor;
  end
  else
  if TChartPen(APen).Visible then
  begin
    {$IFNDEF CLX}
    if IsWindowsNT then TeeSetTeePen(FPen,TChartPen(APen),AColor) { only valid in Windows-NT }
    else
    {$ENDIF}
    begin
      FPen.Assign(APen);

      //if APen.Style<>FPen.Style then FPen.Style:=APen.Style;
      //if APen.Width<>FPen.Width then FPen.Width:=APen.Width;
      //if APen.Mode<>FPen.Mode then FPen.Mode:=APen.Mode;

      FPen.Color:=AColor;

      {$IFDEF CLX}
      if FPen.Style<>psSolid then BackMode:=cbmTransparent;
      {$ENDIF}
    end;
  end
  else FPen.Style:=psClear;
end;

Procedure TTeeCanvas.AssignFont(AFont:TTeeFont);
{$IFNDEF CLX}
var tmp : TTeeCanvasHandle;
{$ENDIF}
Begin
  With FFont do
  begin
    AFont.PixelsPerInch:=PixelsPerInch;
    Assign(AFont);
    if FontZoom<>100 then  // 6.01
       Size:=Round(Size*FontZoom*0.01);
  end;

  if MonoChrome then FFont.Color:=clBlack;

  {$IFNDEF CLX}
  tmp:=Handle;
  if GetTextCharacterExtra(tmp)<>AFont.InterCharSize then
     SetTextCharacterExtra(tmp,AFont.InterCharSize);
  {$ENDIF}

  IFont:=AFont;
  AFont.ICanvas:=Self;
End;

Function TTeeCanvas.TextWidth(Const St:String):Integer;
begin
  {$IFNDEF CLX}
//  ReferenceCanvas.Font.Assign(FFont);  6.01
  result:=FCanvas.TextExtent(St).cx;
  {$ELSE}
  result:=FCanvas.TextWidth(St);
  {$ENDIF}
  if Assigned(IFont) and Assigned(IFont.FShadow) then
     Inc(result,Abs(IFont.FShadow.HorizSize));
end;

Function TTeeCanvas.TextHeight(Const St:String):Integer;
Begin
  {$IFNDEF CLX}
//  ReferenceCanvas.Font.Assign(FFont);  6.01
  result:=FCanvas.TextExtent(St).cy;
  {$ELSE}
  result:=FCanvas.TextHeight(St);
  {$ENDIF}
  if Assigned(IFont) and Assigned(IFont.FShadow) then
     Inc(result,Abs(IFont.FShadow.VertSize));
end;

Function TTeeCanvas.FontHeight:Integer;
begin
  result:=TextHeight(TeeCharForHeight);
end;

procedure TTeeCanvas.Ellipse(const R:TRect);
begin
  with R do Ellipse(Left,Top,Right,Bottom);
end;

procedure TTeeCanvas.RoundRect(const R: TRect; X,Y:Integer);
begin
  with R do RoundRect(Left,Top,Right,Bottom,X,Y);
end;

procedure TTeeCanvas.Line(const FromPoint, ToPoint: TPoint);
begin
  Line(FromPoint.X,FromPoint.Y,ToPoint.X,ToPoint.Y)
end;

Function TTeeCanvas.BeginBlending(const R: TRect;
  Transparency: TTeeTransparency):TTeeBlend;
begin
  ITransp:=Transparency;
  result:=TTeeBlend.Create(Self,R);
end;

procedure TTeeCanvas.EndBlending(Blend:TTeeBlend);
begin
  Blend.DoBlend(ITransp);
  Blend.Free;
end;

{ TCanvas3D }
Procedure TCanvas3D.Assign(Source:TCanvas3D);
begin
  Monochrome:=Source.Monochrome;
end;

function TCanvas3D.CalcRect3D(const R: TRect; Z: Integer): TRect;
begin
  result.TopLeft:=Calculate3DPosition(R.TopLeft,Z);
  result.BottomRight:=Calculate3DPosition(R.BottomRight,Z);
end;

Function TCanvas3D.Calculate3DPosition(P:TPoint; z:Integer):TPoint;
begin
  result:=Calculate3DPosition(P.X,P.Y,z)
end;

procedure TCanvas3D.Cube(const R: TRect; Z0, Z1: Integer;
  DarkSides: Boolean);
begin
  with R do Cube(Left,Right,Top,Bottom,Z0,Z1,DarkSides);
end;

function TCanvas3D.FourPointsFromRect(const R: TRect;
  Z: Integer): TFourPoints;
begin
  With R do
  begin
    result[0]:=Calculate3DPosition(TopLeft,Z);
    result[1]:=Calculate3DPosition(Right,Top,Z);
    result[2]:=Calculate3DPosition(BottomRight,Z);
    result[3]:=Calculate3DPosition(Left,Bottom,Z);
  end;
end;

procedure TCanvas3D.LineWithZ(const FromPoint, ToPoint: TPoint;
  Z: Integer);
begin
  LineWithZ(FromPoint.X,FromPoint.Y,ToPoint.X,ToPoint.Y,Z)
end;

procedure TCanvas3D.PlaneWithZ(const P: TFourPoints; Z: Integer);
begin
  PlaneWithZ(P[0],P[1],P[2],P[3],Z);
end;

function TCanvas3D.RectFromRectZ(const R: TRect; Z: Integer): TRect;
var P : TFourPoints;
begin
  P:=FourPointsFromRect(R,Z);
  result:=RectFromPolygon(P,4);
end;

procedure TCanvas3D.RotatedEllipse(Left, Top, Right, Bottom, Z: Integer;
  const Angle: Double);
const NumCirclePoints=64;
Var P       : Array[0..NumCirclePoints-1] of TPoint;
    Points  : TTrianglePoints;
    PiStep  : Double;
    t       : Integer;
    tmpX    : Double;
    tmpY    : Double;
    XCenter : Double;
    YCenter : Double;
    XRadius : Double;
    YRadius : Double;
    tmpSin  : Extended;
    tmpCos  : Extended;
    tmpSinAngle  : Extended;
    tmpCosAngle  : Extended;
    Old     : TPenStyle;
begin
  XCenter:=(Right+Left)*0.5;
  YCenter:=(Bottom+Top)*0.5;
  XRadius:=XCenter-Left;
  YRadius:=YCenter-Top;

  piStep:=2*pi/(NumCirclePoints-1);

  SinCos(Angle*TeePiStep,tmpSinAngle,tmpCosAngle);

  for t:=0 to NumCirclePoints-1 do
  begin
    SinCos(t*piStep,tmpSin,tmpCos);
    tmpX:=XRadius*tmpSin;
    tmpY:=YRadius*tmpCos;

    P[t].X:=Round(XCenter+(tmpX*tmpCosAngle+tmpY*tmpSinAngle));
    P[t].Y:=Round(YCenter+(-tmpX*tmpSinAngle+tmpY*tmpCosAngle));
  end;

  if Brush.Style<>bsClear then
  begin
    Old:=Pen.Style;
    Pen.Style:=psClear;

    Points[0].X:=Round(XCenter);
    Points[0].Y:=Round(YCenter);
    Points[1]:=P[0];
    Points[2]:=P[1];
    PolygonWithZ(Points,Z);

    Points[1]:=P[1];
    for t:=2 to NumCirclePoints-1 do
    begin
      Points[2]:=P[t];
      PolygonWithZ(Points,Z);
      Points[1]:=P[t];
    end;

    Pen.Style:=Old;
  end;

  if Pen.Style<>psClear then Polyline(P,Z);
end;

procedure TCanvas3D.StretchDraw(const Rect: TRect; Graphic: TGraphic;
  Z: Integer);
{$IFNDEF CLX}
Const BytesPerPixel=3;
{$ENDIF}
var x,y,
    tmpW,
    tmpH  : Integer;
    DestW,
    DestH : Double;
    R     : TRect;
    Bitmap : TBitmap;
    {$IFNDEF CLX}
    tmpScan : PByteArray;
    Line    : PByteArray;
    Dif     : Integer;
    P       : PChar;
    {$ELSE}
    tmpCanvas : TCanvas;
    {$ENDIF}
begin
  Pen.Style:=psClear;

  if Graphic is TBitmap then
  begin
    Bitmap:=TBitmap(Graphic);
    Bitmap.PixelFormat:=TeePixelFormat;
  end
  else
  begin
    Bitmap:=TBitmap.Create;
    Bitmap.PixelFormat:=TeePixelFormat;
    {$IFNDEF CLX}
    Bitmap.IgnorePalette:=True;
    {$ENDIF}
    Bitmap.Assign(Graphic);
  end;

  tmpW:=Bitmap.Width;
  tmpH:=Bitmap.Height;
  DestH:=(Rect.Bottom-Rect.Top)/tmpH;
  DestW:=(Rect.Right-Rect.Left)/tmpW;

  {$IFNDEF CLX}
  Line:=Bitmap.ScanLine[0];
  Dif:=Integer(Bitmap.ScanLine[1])-Integer(Line);
  {$ELSE}
  tmpCanvas:=Bitmap.Canvas;
  {$ENDIF}

  R.Top:=Rect.Top;

  for y:=0 to tmpH-1 do
  begin
    {$IFNDEF CLX}
    tmpScan:=PByteArray(Integer(Line)+Dif*y);
    {$ENDIF}

    R.Bottom:=Rect.Top+Round(DestH*(y+1));

    R.Left:=Rect.Left;
    for x:=0 to tmpW-1 do
    begin
      R.Right:=Rect.Left+Round(DestW*(x+1));

      {$IFDEF CLX}
       {$IFDEF D7}
       Brush.Color:=tmpCanvas.Pixels[x,y];
       {$ELSE}
        {$IFDEF MSWINDOWS}
        Brush.Color:=Windows.GetPixel(QPainter_handle(tmpCanvas.Handle), X, Y);
        {$ELSE}
        Brush.Color:=0; // Not implemented.
        {$ENDIF}
       {$ENDIF}
      {$ELSE}
      p:=@tmpScan[X*BytesPerPixel];
      Brush.Color:= Byte((p+2)^) or (Byte((p+1)^) shl 8) or (Byte((p)^) shl 16);
      {$ENDIF}

      RectangleWithZ(R,Z);
      R.Left:=R.Right;
    end;

    R.Top:=R.Bottom;
  end;

  if not (Graphic is TBitmap) then Bitmap.Free;
end;

{ TTeeCanvas3D }
Constructor TTeeCanvas3D.Create;
begin
  inherited;
  FontZoom:=100;
  IZoomText:=True;
  FBufferedDisplay:=True;
  FDirty:=True;
  FTextAlign:=TA_LEFT;
end;

Procedure TTeeCanvas3D.DeleteBitmap;
begin
  {$IFDEF CLX}
  if Assigned(FBitmap) and QPainter_isActive(FBitmap.Canvas.Handle) then
     QPainter_end(FBitmap.Canvas.Handle);
  {$ENDIF}
  FreeAndNil(FBitmap);
end;

Destructor TTeeCanvas3D.Destroy;
begin
  DeleteBitmap;
  inherited;
end;

Procedure TTeeCanvas3D.TextOut(X,Y:Integer; const Text:String);
{$IFNDEF CLX}
var tmpDC  : TTeeCanvasHandle;
{$ENDIF}

  {$IFDEF CLX}
  Procedure InternalTextOut(AX,AY:Integer);
  var tmp : Integer;
  begin
    tmp:=TextAlign;
    if tmp>=TA_BOTTOM then
    begin
      Dec(AY,TextHeight(Text));
      Dec(tmp,TA_BOTTOM);
    end;

    if tmp=TA_RIGHT then
       Dec(AX,TextWidth(Text))
    else
    if tmp=TA_CENTER then
       Dec(AX,TextWidth(Text) div 2);

    FCanvas.TextOut(AX,AY,Text);
  end;

  {$ELSE}

  Function IsTrueTypeFont:Boolean;
  var tmpMet : TTextMetric;
  begin
    GetTextMetrics(tmpDC,tmpMet);
    result:=(tmpMet.tmPitchAndFamily and TMPF_TRUETYPE)=TMPF_TRUETYPE;
  end;
  {$ENDIF}

  Function RectText(tmpX,tmpY:Integer):TRect;
  var tmpW : Integer;
      tmpH : Integer;
      tmp  : Integer;
  begin
    tmpW:=TextWidth(Text);
    tmpH:=TextHeight(Text);

    tmp:=TextAlign;
    if tmp>=TA_BOTTOM then Dec(tmp,TA_BOTTOM);

    if tmp=TA_RIGHT then
       result:=TeeRect(tmpX-tmpW,tmpY,tmpX,tmpY+tmpH)
    else
    if tmp=TA_CENTER then
       result:=TeeRect(tmpX-(tmpW div 2),tmpY,tmpX+(tmpW div 2),tmpY+tmpH)
    else
       result:=TeeRect(tmpX,tmpY,tmpX+tmpW,tmpY+tmpH);
  end;

  {$IFNDEF CLX}
  Procedure CreateFontPath;
  begin
    BeginPath(tmpDC);
    Windows.TextOut(tmpDC,X, Y, PChar(Text),Length(Text));
    EndPath(tmpDC);
  end;
  {$ENDIF}

Var tmpX     : Integer;
    tmpY     : Integer;
    {$IFDEF CLX}
    tmpColor : TColor;
    {$ELSE}
    tmpFontGradient : Boolean;
    tmpFontOutLine  : Boolean;
    {$ENDIF}
    tmpBlend : TTeeBlend;
begin
  {$IFNDEF CLX}
  tmpDC:=FCanvas.Handle;
  {$ENDIF}

  if Assigned(IFont) and Assigned(IFont.FShadow) then
  With IFont.FShadow do
  if (HorizSize<>0) or (VertSize<>0) then
  begin
    if HorizSize<0 then
    begin
      tmpX:=X;
      Dec(X,HorizSize);
    end
    else tmpX:=X+HorizSize;

    if VertSize<0 then
    begin
      tmpY:=Y;
      Dec(Y,VertSize);
    end
    else tmpY:=Y+VertSize;

    if Transparency>0 then
       tmpBlend:=BeginBlending(RectText(tmpX,tmpY),Transparency)
    else
       tmpBlend:=nil;

    {$IFNDEF CLX}
    SetTextColor(tmpDC, ColorToRGB(IFont.Shadow.Color));
    Windows.TextOut(tmpDC,tmpX, tmpY, PChar(Text),Length(Text));
    {$ELSE}
    tmpColor:=FCanvas.Font.Color;
    FCanvas.Font.Color:=ColorToRGB(IFont.Shadow.Color);
    InternalTextOut(tmpX,tmpY);
    FCanvas.Font.Color:=tmpColor;
    {$ENDIF}

    if Transparency>0 then EndBlending(tmpBlend);
  end;

  {$IFDEF CLX}
  FCanvas.Font.Color:=ColorToRGB(FFont.Color);
  {$ELSE}
  SetTextColor(tmpDC, ColorToRGB(FFont.Color));
  {$ENDIF}

  {$IFNDEF CLX}
  if Assigned(IFont) then // and IsTrueTypeFont then 5.03 (slow)
  begin
    with IFont do
    begin
      tmpFontOutLine:=Assigned(FOutline) and (FOutLine.Visible);
      tmpFontGradient:=Assigned(FGradient) and (FGradient.Visible);
    end;

    if tmpFontOutLine or tmpFontGradient then
    begin
      if tmpFontOutLine then AssignVisiblePen(IFont.FOutLine)
                        else Pen.Style:=psClear;

      Brush.Color:=FFont.Color;
      Brush.Style:=bsSolid;

      tmpDC:=FCanvas.Handle;
      BackMode:=cbmTransparent;

      CreateFontPath;

      if tmpFontGradient then
      begin
        if IFont.FGradient.Outline then WidenPath(tmpDC);

        SelectClipPath(tmpDC,RGN_AND);

        IFont.FGradient.Draw(Self,RectText(x,y));
        UnClipRectangle;

        if IFont.FGradient.Outline then exit;

        // Create path again...
        if tmpFontOutLine then
        begin
          CreateFontPath;
          Brush.Style:=bsClear;
        end;
      end;

      if tmpFontOutLine then
         if IFont.Color=clNone then StrokePath(tmpDC)
                               else StrokeAndFillPath(tmpDC);
    end
    else Windows.TextOut(tmpDC,X, Y, PChar(Text),Length(Text));
  end
  else Windows.TextOut(tmpDC,X, Y, PChar(Text),Length(Text));
  {$ELSE}
  InternalTextOut(x,y);
  {$ENDIF}
end;

procedure TTeeCanvas3D.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  {$IFNDEF CLX}
  Windows.Rectangle(FCanvas.Handle,X0,Y0,X1,Y1);
  {$ELSE}
  FCanvas.Rectangle(X0,Y0,X1,Y1);
  {$ENDIF}
end;

procedure TTeeCanvas3D.RoundRect(X1,Y1,X2,Y2,X3,Y3:Integer);
begin
  {$IFNDEF CLX}
  Windows.RoundRect(FCanvas.Handle,X1,Y1,X2,Y2,X3,Y3);
  {$ELSE}
  FCanvas.RoundRect(X1,Y1,X2,Y2,X3,Y3);
  {$ENDIF}
end;

procedure TTeeCanvas3D.SetTextAlign(Align:TCanvasTextAlign);
begin
  {$IFDEF CLX}
  FTextAlign:=Align;
  {$ELSE}
  Windows.SetTextAlign(FCanvas.Handle,Ord(Align));
  {$ENDIF}
end;

procedure TTeeCanvas3D.MoveTo(X,Y:Integer);
begin
  {$IFNDEF CLX}
  Windows.MoveToEx(FCanvas.Handle, X, Y, nil);
  {$ELSE}
  FCanvas.MoveTo(X,Y);
  {$ENDIF}
end;

procedure TTeeCanvas3D.LineTo(X,Y:Integer);
begin
  {$IFNDEF CLX}
  Windows.LineTo(FCanvas.Handle, X, Y);
  {$ELSE}
  FCanvas.LineTo(X,Y);
  {$ENDIF}
end;

{ 3D Canvas }
Procedure TTeeCanvas3D.PolygonFour;
begin
  {$IFNDEF CLX}
  Windows.Polygon(FCanvas.Handle, PPoints(@IPoints)^, 4);
  {$ELSE}
  FCanvas.Polygon(IPoints);
  {$ENDIF}
end;

procedure TTeeCanvas3D.PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer);
begin
  Calc3DTPoint(P1,Z);
  Calc3DTPoint(P2,Z);
  Calc3DTPoint(P3,Z);
  Calc3DTPoint(P4,Z);
  IPoints[0]:=P1;
  IPoints[1]:=P2;
  IPoints[2]:=P3;
  IPoints[3]:=P4;
  PolygonFour;
end;

Procedure TTeeCanvas3D.Calc3DTPoint(Var P:TPoint; z:Integer);
begin
  Calc3DPos(P.X,P.Y,Z);
end;

Function TTeeCanvas3D.Calc3DTPoint3D(Const P:TPoint3D):TPoint;
begin
  Calc3DPoint(result,P.X,P.Y,P.Z);
end;

Function TTeeCanvas3D.Calculate3DPosition(x,y,z:Integer):TPoint;
begin
  Calc3DPos(x,y,z);
  result.x:=x;
  result.y:=y;
end;

Procedure TTeeCanvas3D.Calc3DPoint( Var P:TPoint; x,y,z:Integer);
begin
  Calc3DPos(x,y,z);
  P.x:=x;
  P.y:=y;
end;

Procedure TTeeCanvas3D.Calculate2DPosition(Var x,y:Integer; z:Integer);
var x1  : Integer;
    tmp : Double;
begin
  if IZoomFactor<>0 then
  begin
    tmp:=1.0/IZoomFactor;
    if FIsOrthogonal then
    begin
      x:=Round(((x-FXCenterOffset)*tmp)-(IOrthoX*z))+FXCenter;
      y:=Round(((y-FYCenterOffset)*tmp)+(IOrthoY*z))+FYCenter;
    end
    else
    if FIs3D and (tempXX<>0) and (c2c3<>0)  then
    begin
      x1:=x;
      z:=z-FZCenter;
      x:=Round((((x1-FXCenterOffset)*tmp)-(z*tempXZ)-
                 (y -FYCenter)*c2s3)   / tempXX) + FXCenter;
      y:=Round((((y -FYCenterOffset)*tmp)-(z*tempYZ)-
                 (x1-FXCenter)*tempYX) / c2c3)   + FYCenter;
    end;
  end;
end;

Procedure TTeeCanvas3D.Calc3DPos(Var x,y:Integer; z:Integer);
var tmp : Double;
    {$IFDEF NEWXYZ}
    xx,yy,zz :  Double;
    {$ELSE}
    x1 : Integer;
    {$ENDIF}
begin
  if FIsOrthogonal then
  begin
    x:=Round( IZoomFactor*(x-FXCenter+(IOrthoX*z)) )+FXCenterOffset;
    y:=Round( IZoomFactor*(y-FYCenter-(IOrthoY*z)) )+FYCenterOffset;
  end
  else
  if FIs3D then
  begin
    Dec(z,FZCenter);
    Dec(x,FXCenter);
    Dec(y,FYCenter);

    {$IFDEF NEWXYZ}
    zz:=z*c2 - x*s2;

    if IHasPerspec then
       tmp:=IZoomFactor-((zz*c1 + y*s1)*IZoomPerspec)
    else
       tmp:=IZoomFactor;

    xx:=x*c2 + z*s2;
    yy:=y*c1 - zz*s1;

    x:=Round((xx*c3 - yy*s3)*tmp)+FXCenterOffset;
    y:=Round((yy*c3 + xx*s3)*tmp)+FYCenterOffset;

    {$ELSE}

    if IHasPerspec then
       tmp:=IZoomFactor-((x*c2s1 -y*s2 + z*c2c1)*IZoomPerspec)
    else
       tmp:=IZoomFactor;

    x1:=x;
    x:=Round((x*tempXX  + y*c2s3 + z*tempXZ)*tmp)+FXCenterOffset;
    y:=Round((x1*tempYX + y*c2c3 + z*tempYZ)*tmp)+FYCenterOffset;

    // z:= ?
    {$ENDIF}
  end;
end;

Function TTeeCanvas3D.GetHandle:TTeeCanvasHandle;
begin
  result:=FCanvas.Handle;
end;

procedure TTeeCanvas3D.Cone(Vertical:Boolean; Left,Top,Right,Bottom,
                          Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
begin
  InternalCylinder(Vertical,Left,Top,Right,Bottom,Z0,Z1,Dark3D,ConePercent);
end;

procedure TTeeCanvas3D.Sphere(x,y,z:Integer; Const Radius:Double);
var tmp : Integer;
begin
  tmp:=Round(Radius);
  EllipseWithZ(x-tmp,y-tmp,x+tmp,y+tmp,z);
end;

Procedure TTeeCanvas3D.Surface3D( Style:TTeeCanvasSurfaceStyle;
                                  SameBrush:Boolean;
                                  NumXValues,NumZValues:Integer;
                                  CalcPoints:TTeeCanvasCalcPoints );
begin
  { not implemented in GDI mode. (Use TeeOpenGL) }
end;

Procedure TTeeCanvas3D.TextOut3D(x,y,z:Integer; const Text:String);
var {$IFNDEF CLX}
    tmpSizeChanged : Boolean;
    FDC            : HDC;
    LogRec         : TLogFont;
    NewFont        : HFont;
    OldFont        : HFont;
    {$ENDIF}
    tmp            : Integer;
    OldSize        : Integer;
begin
  Calc3DPos(x,y,z);
  if IZoomText then
  begin
    {$IFNDEF CLX}
    tmpSizeChanged:=False;
    FDC:=0;
    OldFont:=0;
    {$ENDIF}
    if IZoomFactor<>1 then
    With FFont do
    begin
      OldSize:=Size;
      tmp:=Math.Max(1,Round(IZoomFactor*OldSize));
      if OldSize<>tmp then
      begin
        {$IFDEF CLX}
        FFont.Size:=tmp;
        {$ELSE}
        FDC:=FCanvas.Handle;
        GetObject(FFont.Handle, SizeOf(LogRec), @LogRec);
        LogRec.lfHeight:= -MulDiv( tmp,FFont.PixelsPerInch,72);
        NewFont:=CreateFontIndirect(LogRec);
        OldFont:=SelectObject(FDC,NewFont);
        tmpSizeChanged:=True;
        {$ENDIF}
      end;
    end;
    TextOut(X,Y,Text);
    {$IFNDEF CLX}
    if tmpSizeChanged then DeleteObject(SelectObject(FDC,OldFont));
    {$ENDIF}
  end
  else TextOut(X,Y,Text);
end;

procedure TTeeCanvas3D.MoveTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  {$IFNDEF CLX}
  Windows.MoveToEx(FCanvas.Handle, X, Y, nil);
  {$ELSE}
  FCanvas.MoveTo(X,Y);
  {$ENDIF}
end;

procedure TTeeCanvas3D.LineTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  {$IFNDEF CLX}
  Windows.LineTo(FCanvas.Handle, X, Y);
  {$ELSE}
  FCanvas.LineTo(X,Y);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.RectangleWithZ(Const Rect:TRect; Z:Integer);
begin
  With Rect do
  begin
    Calc3DPoint(IPoints[0],Left,Top,Z);
    Calc3DPoint(IPoints[1],Right,Top,Z);
    Calc3DPoint(IPoints[2],Right,Bottom,Z);
    Calc3DPoint(IPoints[3],Left,Bottom,Z);
  end;
  PolygonFour;
end;

Procedure TTeeCanvas3D.DoHorizLine(X0,X1,Y:Integer);
{$IFNDEF CLX}
var FDC : HDC;
{$ENDIF}
begin
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,X0,Y,nil);
  Windows.LineTo(FDC,X1,Y);
  {$ELSE}
  FCanvas.MoveTo(x0,y);
  FCanvas.LineTo(x1,y);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.DoVertLine(X,Y0,Y1:Integer);
{$IFNDEF CLX}
var FDC : HDC;
{$ENDIF}
begin
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,X,Y0,nil);
  Windows.LineTo(FDC,X,Y1);
  {$ELSE}
  FCanvas.MoveTo(x,y0);
  FCanvas.LineTo(x,y1);
  {$ENDIF}
end;

{$IFNDEF CLX}
Procedure SetCanvasRegion(DC:TTeeCanvasHandle; Region:HRgn);
begin
  if Region<>0 then
  begin
    WasOldRegion:=GetClipRgn(DC,OldRegion)=1;
    ExtSelectClipRgn(DC,Region,RGN_AND);
    DeleteObject(Region);
  end;
end;
{$ENDIF}

Procedure ClipCanvas(ACanvas:TCanvas; Const Rect:TRect);
var tmpDC  : TTeeCanvasHandle;
    {$IFNDEF CLX}
    P      : Array[0..1] of TPoint;
    Region : HRgn;
    {$ENDIF}
begin
  {$IFNDEF CLX}
  with Rect do
  begin
    p[0]:=TopLeft;
    p[1]:=BottomRight;
  end;
  tmpDC:=ACanvas.Handle;
  LPToDP(tmpDC,P,2);
  Region:=CreateRectRgn(P[0].X,P[0].Y,P[1].X,P[1].Y);
  SetCanvasRegion(tmpDC,Region);
  {$ELSE}
  ACanvas.Start;
  tmpDC:=ACanvas.Handle;
  QPainter_setClipping(tmpDC,True);
  QPainter_setClipRect(tmpDC,@Rect);
  {$ENDIF}
end;

procedure TTeeCanvas3D.ClipRectangle(Const Rect:TRect);
begin
  ClipCanvas(FCanvas,Rect);
end;

Procedure ClipEllipse(ACanvas:TTeeCanvas; Const Rect:TRect);
var DC : TTeeCanvasHandle;
{$IFNDEF CLX}
    R  : TRect;
{$ELSE}
    tmpRegion : QRegionH;
{$ENDIF}
begin
  {$IFNDEF CLX}
  DC:=ACanvas.Handle;
  R:=Rect;
  LPToDP(DC,R,2);
  SetCanvasRegion(DC,CreateEllipticRgnIndirect(R));
  {$ELSE}
  ACanvas.ReferenceCanvas.Start;
  DC:=ACanvas.Handle;
  QPainter_setClipping(DC,True);
  tmpRegion:=QRegion_create(@Rect, QRegionRegionType_Ellipse);
  QPainter_setClipRegion(DC,tmpRegion);
  QRegion_destroy(tmpRegion);
  {$ENDIF}
end;

Procedure ClipRoundRectangle(ACanvas:TTeeCanvas; Const Rect:TRect; RoundSize:Integer);
{$IFNDEF CLX}
var R      : TRect;
    Region : HRgn;
    DC     : HDC;
{$ENDIF}
begin
  {$IFNDEF CLX}
  DC:=ACanvas.Handle;
  R:=Rect;
  LPToDP(DC,R,2);
  With R do Region:=CreateRoundRectRgn(Left,Top,Right,Bottom,RoundSize,RoundSize);
  SetCanvasRegion(DC,Region);
  {$ELSE}
  ACanvas.ClipRectangle(Rect);
  {$ENDIF}
end;

Procedure ClipPolygon(ACanvas:TTeeCanvas; Var Points:Array of TPoint; NumPoints:Integer);

  {$IFDEF CLX}
  { From QGraphics.pas }
  function PointArrayOf(const Points: array of TPoint; var TempPoints: TPointArray): PPointArray;
  var t:Integer;
  begin
    SetLength(TempPoints, NumPoints);
    for t:=0 to NumPoints-1 do TempPoints[t]:=Points[t];
    Result := @TempPoints[0];
  end;
  {$ENDIF}

var {$IFDEF CLX}
    Region : QRegionH;
    P      : TPointArray;
    {$ELSE}
    Region : HRgn;
    {$ENDIF}
    tmpDC  : TTeeCanvasHandle;
begin
  {$IFDEF CLX}
  ACanvas.ReferenceCanvas.Start;
  tmpDC:=ACanvas.ReferenceCanvas.Handle;
  QPainter_setClipping(tmpDC,True);
  Region:=QRegion_create(PointArrayOf(Points,P),False);
  QPainter_setClipRegion(tmpDC,Region);
  QRegion_Destroy(Region);
  {$ELSE}
  tmpDC:=ACanvas.Handle;
  LPToDP(tmpDC,Points,NumPoints);
  Region:=CreatePolygonRgn(Points,NumPoints,ALTERNATE);
  SetCanvasRegion(tmpDC,Region);
  {$ENDIF}
end;

Function RectFromPolygon(Const Points:Array of TPoint; NumPoints:Integer):TRect;
var t : Integer;
begin
  result.TopLeft:=Points[0];
  result.BottomRight:=result.TopLeft;

  for t:=1 to NumPoints-1 do
  With Points[t] do
  begin
    if X<result.Left then result.Left:=X else
       if X>result.Right then result.Right:=X;
    if Y<result.Top then result.Top:=Y else
       if Y>result.Bottom then result.Bottom:=Y;
  end;

  Inc(result.Right);
  Inc(result.Bottom);
end;

procedure TTeeCanvas3D.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);

  Procedure ClipToRight;
  var pa : TPoint;
      pb : TPoint;
      P  : Array[0..5] of TPoint;
  begin
    with Rect do
    begin
      Calc3DPoint(p[0],Left,Bottom,MinZ);
      Calc3DPoint(p[1],Left,Top,MinZ);

      Calc3DPoint(pa,Left,Top,MaxZ);
      Calc3DPoint(pb,Right,Top,MinZ);

      if pb.Y<pa.Y then p[2]:=pb else p[2]:=pa;

      Calc3DPoint(p[3],Right,Top,MaxZ);

      Calc3DPoint(pa,Right,Bottom,MaxZ);
      Calc3DPoint(pb,Right,Top,MinZ);

      if pb.x>pa.x then p[4]:=pb else p[4]:=pa;

      Calc3DPoint(p[5],Right,Bottom,MinZ);
      if p[5].x<p[0].x then
      begin
        p[0].x:=p[5].x;
        if pb.y<p[0].y then p[0].y:=pb.y;
      end;
    end;

    ClipPolygon(Self,P,6);
  end;

  Procedure ClipToLeft;
  var P : Array[0..5] of TPoint;
  begin
    with Rect do
    begin
      Calc3DPoint(p[0],Left,Bottom,MinZ);
      Calc3DPoint(p[1],Left,Bottom,MaxZ);
      Calc3DPoint(p[2],Left,Top,MaxZ);
      Calc3DPoint(p[3],Right,Top,MaxZ);
      Calc3DPoint(p[4],Right,Top,MinZ);
      Calc3DPoint(p[5],Right,Bottom,MinZ);
    end;
    ClipPolygon(Self,P,6);
  end;

var tmpR : TRect;
begin
  if FIs3D then
  begin
    With View3DOptions do
    if Elevation=270 then
    begin
      if (Rotation=270) or (Rotation=360) then
      With Rect do
      begin
        Calc3DPoint(tmpR.TopLeft,Left,Top,MinZ);
        Calc3DPoint(tmpR.BottomRight,Right,Top,MaxZ);
        ClipRectangle(tmpR);
        Exit;
      end;
    end;

    With View3DOptions do
    if Orthogonal then
    begin
      if OrthoAngle>90 then ClipToLeft
                       else ClipToRight;
    end
    else
    if Rotation>=270 then ClipToRight;
  end
  else
  begin
    tmpR:=Rect;
    Inc(tmpR.Left);
    Inc(tmpR.Top);
    Dec(tmpR.Bottom);
    ClipRectangle(tmpR);
  end;
end;

Procedure UnClipCanvas(ACanvas:TCanvas);
begin
  {$IFNDEF CLX}
  if WasOldRegion then SelectClipRgn(ACanvas.Handle,OldRegion)
                  else SelectClipRgn(ACanvas.Handle,0);
  WasOldRegion:=False;
  {$ELSE}
  QPainter_setClipping(ACanvas.Handle,False);
  ACanvas.Stop;
  {$ENDIF}
end;

procedure TTeeCanvas3D.UnClipRectangle;
begin
  UnClipCanvas(FCanvas);
end;

Const PerspecFactor=1.0/150.0;

Procedure TTeeCanvas3D.Projection(MaxDepth:Integer; const Bounds,Rect:TRect);
begin
  RectCenter(Rect,FXCenter,FYCenter);
  Inc(FXCenter,Round(RotationCenter.X));
  Inc(FYCenter,Round(RotationCenter.Y));
  FZCenter:=Round( (MaxDepth*0.5) + RotationCenter.Z );
  FXCenterOffset:=FXCenter;
  FYCenterOffset:=FYCenter;

  if Assigned(F3DOptions) then
  With F3DOptions do
  begin
    Inc(FXCenterOffset,HorizOffset);
    Inc(FYCenterOffset,VertOffset);
    CalcPerspective(Rect);
  end;
end;

Procedure TTeeCanvas3D.CalcPerspective(const Rect:TRect);
begin
  IHasPerspec:=F3DOptions.Perspective>0;
  if IHasPerspec then
     IZoomPerspec:=IZoomFactor*F3DOptions.Perspective*PerspecFactor/(Rect.Right-Rect.Left);
end;

Procedure TTeeCanvas3D.CalcTrigValues;
Var rx : Double;
    ry : Double;
    rz : Double;
begin
  if not FIsOrthogonal then
  begin
    if Assigned(F3DOptions) then
    With F3DOptions do
    begin
      {$IFDEF NEWXYZ}
      rx:=-Elevation;
      ry:=-Rotation;
      {$ELSE}
      rx:=Rotation;
      ry:=Elevation;
      {$ENDIF}
      rz:=Tilt;
    end
    else
    begin
      rx:=0;
      ry:=0;
      rz:=0;
    end;

    IHasPerspec:=False;
    IZoomPerspec:=0;

    SinCos(rx*TeePiStep,s1,c1);
    SinCos(ry*TeePiStep,s2,c2);
    SinCos(rz*TeePiStep,s3,c3);

    c2s3:=c2*s3;
    c2c3:=Math.Max(1E-5,c2*c3);

    tempXX:=Math.Max(1E-5, s1*s2*s3 + c1*c3 );
    tempYX:=( c3*s1*s2 - c1*s3 );

    tempXZ:=( c1*s2*s3 - c3*s1 );
    tempYZ:=( c1*c3*s2 + s1*s3 );

    {$IFNDEF NEWXYZ}
    c2s1:=c2*s1;
    c2c1:=c1*c2;
    {$ENDIF}
  end;
end;

Function TTeeCanvas3D.InitWindow( DestCanvas:TCanvas;
                                  A3DOptions:TView3DOptions;
                                  ABackColor:TColor;
                                  Is3D:Boolean;
                                  Const UserRect:TRect):TRect;
var tmpH      : Integer;
    tmpW      : Integer;
    tmpCanvas : TCanvas;
    tmpSin    : Extended;
    tmpCos    : Extended;
    tmpAngle  : Extended;
begin
  FBounds:=UserRect;
  F3DOptions:=A3DOptions;

  FIs3D:=Is3D;
  FIsOrthogonal:=False;
  IZoomFactor:=1;
  if FIs3D then
  begin
    if Assigned(F3DOptions) then
    begin
      FIsOrthogonal:=F3DOptions.Orthogonal;
      if FIsOrthogonal then
      begin
        tmpAngle:=F3DOptions.OrthoAngle;
        if tmpAngle>90 then
        begin
          IOrthoX:=-1;
          tmpAngle:=180-tmpAngle;
        end
        else IOrthoX:=1;

        SinCos(tmpAngle*TeePiStep,tmpSin,tmpCos);
        if tmpCos<0.01 then IOrthoY:=1
                       else IOrthoY:=tmpSin/tmpCos;
      end;

      IZoomFactor:=0.01*F3DOptions.Zoom;

      IZoomText:=F3DOptions.ZoomText;
    end;

    CalcTrigValues;
  end;

  if FBufferedDisplay then
  begin
    RectSize(UserRect,tmpW,tmpH);

    if not Assigned(FBitmap) then
    begin
      FBitmap:=TBitMap.Create;
      {$IFNDEF CLX}
      FBitmap.IgnorePalette:=True;
      {$ENDIF}
    end;

    FBitmap.Width:=tmpW;
    FBitmap.Height:=tmpH;

    tmpCanvas:=FBitmap.Canvas;
    tmpCanvas.OnChange:=nil;
    tmpCanvas.OnChanging:=nil;
    SetCanvas(tmpCanvas);
    result:=TeeRect(0,0,tmpW,tmpH);
  end
  else
  begin
    SetCanvas(DestCanvas);
    result:=UserRect;
  end;
end;

{.$DEFINE MONITOR_REPAINTS}

{$IFDEF MONITOR_REPAINTS}
var TeeMonitor:Integer=0;
{$ENDIF}

Procedure TTeeCanvas3D.TransferBitmap(ALeft,ATop:Integer; ACanvas:TCanvas);
begin
  {$IFNDEF CLX}

    {$IFDEF MONITOR_REPAINTS}
    Inc(TeeMonitor);
    FBitmap.Canvas.TextOut(0,0,IntToStr(TeeMonitor));
    {$ENDIF}

  {$IFDEF TEEBITMAPSPEED}
  if IBitmapCanvas=0 then
  begin
    IBitmapCanvas:=CreateCompatibleDC(0);
    SelectObject(IBitmapCanvas, FBitmap.Handle);
  end;

  BitBlt( ACanvas.Handle,ALeft,ATop,
          FBitmap.Width,
          FBitmap.Height,
          IBitmapCanvas,0,0,SRCCOPY);
  {$ELSE}
  BitBlt( ACanvas.Handle,ALeft,ATop,
          FBitmap.Width,
          FBitmap.Height,
          FBitmap.Canvas.Handle,0,0,SRCCOPY);
  {$ENDIF}

  {$ELSE}
  QPainter_drawPixmap(ACanvas.Handle, ALeft, ATop, FBitmap.Handle, 0, 0,
    FBitmap.Width, FBitmap.Height);
  {$ENDIF}
end;

Function TTeeCanvas3D.ReDrawBitmap:Boolean;
begin
  result:=not FDirty;
  if result then
     TransferBitmap(0,0,FCanvas)
  {$IFDEF TEEBITMAPSPEED}
  else
  begin
    DeleteDC(IBitmapCanvas);
    IBitmapCanvas:=0;
  end;
  {$ENDIF}
end;

Procedure TTeeCanvas3D.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  if FBufferedDisplay then
  begin
    With UserRect do TransferBitmap(Left,Top,DestCanvas);
    FDirty:=False;
  end;
  SetCanvas(DefaultCanvas);
end;

// type TGraphicAccess=class(TGraphic);

procedure TTeeCanvas3D.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  {$IFNDEF CLX}
  if Assigned(Graphic) then
  {$ENDIF}
     FCanvas.StretchDraw(Rect,Graphic);
//  TGraphicAccess(Graphic).Draw(FCanvas,Rect);
end;

procedure TTeeCanvas3D.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  {$IFNDEF CLX}
  if Assigned(Graphic) and (not Graphic.Empty) then
  {$ENDIF}
     FCanvas.Draw(x,y,Graphic);
//  TGraphicAccess(Graphic).Draw(FCanvas,TeeRect(x,y,x+Graphic.Width,y+Graphic.Height));
end;

{$IFDEF LINUX}
Function GetRValue(Color:Integer):Byte;
var QC : QColorH;
begin
  QC:=QColor(Color);
  try    result:=QColor_red(QC);  finally    QColor_destroy(QC);  end;
end;

Function GetGValue(Color:Integer):Byte;
var QC : QColorH;
begin
  QC:=QColor(Color);
  try    result:=QColor_green(QC);  finally    QColor_destroy(QC);  end;
end;

Function GetBValue(Color:Integer):Byte;
var QC : QColorH;
begin
  QC:=QColor(Color);
  try    result:=QColor_blue(QC);  finally    QColor_destroy(QC);  end;
end;

Function QRGB(r,g,b:Integer):QColorH;
begin
  result:=QColor_create(r,g,b);
end;

Function RGB(r,g,b:Integer):TColor;
begin
  result:=QColorColor(QRGB(r,g,b))
end;
{$ENDIF}

// For gradient balance
Function TeeSigmoid(const Index,Balance,Total:Double):Double;
const Divisor:Double=1/(200/3);
begin
  result:=Exp((0.5+(Balance*Divisor))*Ln((1+Index)/(1+Total)));
end;

// Optional STOCKBRUSH define to accelerate drawing gradients.
// Warning: Do not define if creating metafiles or printing. (not supported).
{.$DEFINE STOCKBRUSH}

Procedure TTeeCanvas3D.GradientFill( Const Rect : TRect;
                                     StartColor : TColor;
                                     EndColor   : TColor;
                                     Direction  : TGradientDirection;
                                     Balance    : Integer=50);
Var T0,T1,T2 : Integer;
    D0,D1,D2 : Integer;
    Range    : Integer;
    FDC      : TTeeCanvasHandle;
    {$IFDEF CLX}
    tmpBrush : QBrushH;
    {$ELSE}
    tmpBrush : HBRUSH;
    OldColor : TColor;
    {$ENDIF}

  Procedure CalcBrushColor(Index:Integer);
  var {$IFDEF CLX}
      tmpC : QColorH;
      {$ELSE}
      tmp  : TColor;
      {$ENDIF}
      tmpD : Double;
  begin
    {$IFDEF CLX}
    if Balance=50 then
      tmpC:=QColor_create( (T0 + MulDiv(Index,D0,Range)),
                           (T1 + MulDiv(Index,D1,Range)),
                           (T2 + MulDiv(Index,D2,Range)) )
    else
    begin
      tmpD:=TeeSigmoid(Index,Balance,Range);

      tmpC:=QColor_create( T0 + Round(tmpD*D0),
                           T1 + Round(tmpD*D1),
                           T2 + Round(tmpD*D2) );
    end;

    QBrush_setColor(tmpBrush,tmpC);
    QColor_destroy(tmpC);

    {$ELSE}

    if Balance=50 then
       tmp:=(( T0 + ((Index*D0) div Range) ) or
            (( T1 + ((Index*D1) div Range) ) shl 8) or
            (( T2 + ((Index*D2) div Range) ) shl 16))
    else
    begin
      tmpD:=TeeSigmoid(Index,Balance,Range);

      tmp:=(( T0 + Round(tmpD*D0) ) or
           (( T1 + Round(tmpD*D1) ) shl 8) or
           (( T2 + Round(tmpD*D2) ) shl 16));
    end;

    if tmp<>OldColor then
    begin
      {$IFDEF STOCKBRUSH}
      if tmpBrush=0 then
         tmpBrush:=SelectObject(FDC,GetStockObject(DC_BRUSH));
      SetDCBrushColor(FDC,tmp);
      {$ELSE}
      if tmpBrush<>0 then
         DeleteObject(SelectObject(FDC,tmpBrush)); // <-- Win API is very slow here !
      tmpBrush:=SelectObject(FDC,CreateSolidBrush(tmp));
      {$ENDIF}
      OldColor:=tmp;
    end;
    {$ENDIF}
  end;

Var tmpRect : TRect;

  {$IFDEF CLX}
  Procedure PatBlt(AHandle:TTeeCanvasHandle; A,B,C,D,Mode:Integer);
  begin
    QPainter_fillRect(AHandle, A,B,C,D, tmpBrush);
  end;
  {$ENDIF}

  Procedure RectGradient(Horizontal:Boolean);
  var t,
      P1,
      P2,
      P3    : Integer;
      Size  : Integer;
      Steps : Integer;
  begin
    FDC:=FCanvas.Handle;
    With tmpRect do
    begin
      if Horizontal then
      begin
        P3:=Bottom-Top;
        Size:=Right-Left;
      end
      else
      begin
        P3:=Right-Left;
        Size:=Bottom-Top;
      end;

      Steps:=Size;
      if Steps>256 then Steps:=256;
      P1:=0;
      {$IFNDEF CLX}
      OldColor:=-1;
      {$ENDIF}
      Range:=Pred(Steps);

      if Range>0 then
      for t:=0 to Steps-1 do
      Begin
        CalcBrushColor(t);
        P2:=(t+1)*Size div Steps;
        if Horizontal then PatBlt(FDC,Right-P1,Top,P1-P2,P3,PATCOPY)
                      else PatBlt(FDC,Left,Bottom-P1,P3,P1-P2,PATCOPY);
        P1:=P2;
      end;
    end;
  end;

  Procedure FromCorner;
  var FromTop : Boolean;
      SizeX,
      SizeY,
      tmp1,
      tmp2,
      P0,
      P1      : Integer;
  begin
    FromTop:=Direction=gdFromTopLeft;
    With tmpRect do if FromTop then P1:=Top else P1:=Bottom;
    P0:=P1;
    RectSize(tmpRect,SizeX,SizeY);
    Range:=SizeX+SizeY;
    FDC:=FCanvas.Handle;
    tmp1:=0;
    tmp2:=0;
    Repeat
      CalcBrushColor(tmp1+tmp2);
      PatBlt(FDC,tmpRect.Left+tmp2,P0,1,P1-P0,PATCOPY);

      if tmp1<SizeY then
      begin
        Inc(tmp1);
        if FromTop then
        begin
          PatBlt(FDC,tmpRect.Left,P0,tmp2+1,1,PATCOPY);
          if P0<tmpRect.Bottom then Inc(P0)
        end
        else
        begin
          PatBlt(FDC,tmpRect.Left,P0-1,tmp2+1,1,PATCOPY);
          if P0>tmpRect.Top then Dec(P0);
        end;
      end;
      if tmp2<SizeX then Inc(tmp2);
    Until (tmp1>=SizeY) and (tmp2>=SizeX);
  end;

  Procedure FromCenter;
  Const TeeGradientPrecision : Integer = 1;   { how many pixels precision, ( 1=best) }
  var tmpXCenter,
      tmpYCenter,
      SizeX,
      SizeY,
      P0,
      P1,
      tmpLeft,
      tmpTop,
      tmp1,
      tmp2        : Integer;
  begin
    RectSize(tmpRect,SizeX,SizeY);
    tmpXCenter:=SizeX shr 1;
    tmpYCenter:=SizeY shr 1;
    tmp1:=0;
    tmp2:=0;
    Range:=tmpXCenter+tmpYCenter;
    FDC:=FCanvas.Handle;
    Repeat
      CalcBrushColor(tmp1+tmp2);
      P0:=SizeY-(2*tmp1);
      P1:=SizeX-(2*tmp2);
      tmpLeft:=tmpRect.Left+tmp2;
      tmpTop:=tmpRect.Top+tmp1;
      PatBlt(FDC,tmpLeft,tmpTop,TeeGradientPrecision,P0,PATCOPY);
      PatBlt(FDC,tmpRect.Right-tmp2-1,tmpTop,TeeGradientPrecision,P0,PATCOPY);
      PatBlt(FDC,tmpLeft,tmpTop,P1,TeeGradientPrecision,PATCOPY);
      PatBlt(FDC,tmpLeft,tmpRect.Bottom-tmp1-TeeGradientPrecision,
                P1,TeeGradientPrecision,PATCOPY);
      if tmp1<tmpYCenter then Inc(tmp1,TeeGradientPrecision);
      if tmp2<tmpXCenter then Inc(tmp2,TeeGradientPrecision);
    Until (tmp1>=tmpYCenter) and (tmp2>=tmpXCenter);
  end;

  Procedure DoDrawRadial;
  var tmp : TCustomTeeGradient;
  begin
    tmp:=TCustomTeeGradient.Create(nil);
    try
      tmp.Direction:=gdRadial;
      tmp.StartColor:=StartColor;
      tmp.EndColor:=EndColor;
      tmp.Draw(Self,tmpRect);
    finally
      tmp.Free;
    end;
  end;

begin
  tmpRect:=OrientRectangle(Rect);

  // deprecated. Use TTeeGradient.Draw method.
  if Direction=gdRadial then
  begin
    DoDrawRadial;
    exit;
  end;

  if (Direction<>gdTopBottom) and (Direction<>gdLeftRight) then
     SwapInteger(Integer(StartColor),Integer(EndColor));

  StartColor:=ColorToRGB(StartColor);
  EndColor:=ColorToRGB(EndColor);

  T0:=GetRValue(StartColor);
  T1:=GetGValue(StartColor);
  T2:=GetBValue(StartColor);
  D0:=GetRValue(EndColor)-T0;
  D1:=GetGValue(EndColor)-T1;
  D2:=GetBValue(EndColor)-T2;

  {$IFDEF CLX}
  FCanvas.Start;
  tmpBrush:=FCanvas.Brush.Handle;
  {$ELSE}
  tmpBrush:=0;
  OldColor:=-1;
  {$ENDIF}

  Case Direction of
    gdLeftRight,
    gdRightLeft      : RectGradient(True);
    gdTopBottom,
    gdBottomTop      : RectGradient(False);
    gdFromTopLeft,
    gdFromBottomLeft : FromCorner;
    gdFromCenter     : FromCenter;
  end;

  {$IFDEF CLX}
  FCanvas.Stop;
  {$ELSE}
  if tmpBrush<>0 then DeleteObject(SelectObject(FDC,tmpBrush));
  {$ENDIF}
end;

procedure TTeeCanvas3D.EraseBackground(const Rect: TRect);
begin
  FillRect(Rect);
end;

procedure TTeeCanvas3D.FillRect(const Rect: TRect);
begin
  {$IFNDEF CLX}
  Windows.FillRect(FCanvas.Handle, Rect, FBrush.Handle);
  {$ELSE}
  FCanvas.FillRect(Rect);
  {$ENDIF}
end;

procedure TTeeCanvas3D.Frame3D( var Rect: TRect; TopColor,BottomColor: TColor;
                                Width: Integer);
var TopRight   : TPoint;
    BottomLeft : TPoint;
    {$IFNDEF D5}
    P          : TTrianglePoints;
    {$ENDIF}
begin
  FPen.Width:=1;
  FPen.Style:=psSolid;

  Dec(Rect.Bottom);
  Dec(Rect.Right);

  while Width > 0 do
  begin
    Dec(Width);
    with Rect do
    begin
      TopRight.X := Right;
      TopRight.Y := Top;
      BottomLeft.X := Left;
      BottomLeft.Y := Bottom;
      FPen.Color := TopColor;

      {$IFDEF D5}
      Polyline([BottomLeft,TopLeft,TopRight]);
      {$ELSE}
        P[0]:=BottomLeft;
        P[1]:=TopLeft;
        P[2]:=TopRight;

        // this is due to a D4 bug...
        {$IFNDEF CLX}
        Windows.Polyline(FCanvas.Handle, PPoints(@P)^, High(P) + 1);
        {$ELSE}
        FCanvas.Polyline(Points);
        {$ENDIF}
      {$ENDIF}

      FPen.Color := BottomColor;
      Dec(BottomLeft.X);

      {$IFDEF D5}
      Polyline([TopRight,BottomRight,BottomLeft]);
      {$ELSE}
        P[0]:=TopRight;
        P[1]:=BottomRight;
        P[2]:=BottomLeft;

        // this is due to a D4 bug...
        {$IFNDEF CLX}
        Windows.Polyline(FCanvas.Handle, PPoints(@P)^, High(P) + 1);
        {$ELSE}
        FCanvas.Polyline(Points);
        {$ENDIF}
      {$ENDIF}
    end;

    InflateRect(Rect, -1, -1);
  end;

  Inc(Rect.Bottom);
  Inc(Rect.Right);
end;

Function ApplyDark(Color:TColor; HowMuch:Byte):TColor;
Var r : Byte;
    g : Byte;
    b : Byte;
Begin
  Color:=ColorToRGB(Color);
  r:=Byte(Color);
  g:=Byte(Color shr 8);
  b:=Byte(Color shr 16);
  if r>HowMuch then Dec(r,HowMuch) else r:=0;
  if g>HowMuch then Dec(g,HowMuch) else g:=0;
  if b>HowMuch then Dec(b,HowMuch) else b:=0;
  result := (r or (g shl 8) or (b shl 16));
end;

Function ApplyBright(Color:TColor; HowMuch:Byte):TColor;
Var r : Byte;
    g : Byte;
    b : Byte;
Begin
  Color:=ColorToRGB(Color);
  r:=Byte(Color);
  g:=Byte(Color shr 8);
  b:=Byte(Color shr 16);
  if (r+HowMuch)<256 then Inc(r,HowMuch) else r:=255;
  if (g+HowMuch)<256 then Inc(g,HowMuch) else g:=255;
  if (b+HowMuch)<256 then Inc(b,HowMuch) else b:=255;
  result := (r or (g shl 8) or (b shl 16));
end;

Procedure TTeeCanvas3D.Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean);

  Function Culling:Double;
  begin
    result:=((IPoints[3].x-IPoints[2].x) * (IPoints[1].y-IPoints[2].y)) -
            ((IPoints[1].x-IPoints[2].x) * (IPoints[3].y-IPoints[2].y));
  end;

Var OldColor : TColor;
    P0,P1,
    P2,P3    : TPoint;
    tmp      : Double;
begin
  Calc3DPoint(P0,Left,Top,z0);
  Calc3DPoint(P1,Right,Top,z0);
  Calc3DPoint(P2,Right,Bottom,z0);
  Calc3DPoint(P3,Right,Top,z1);

  if FBrush.Style=bsSolid then OldColor:=FBrush.Color
                          else OldColor:=BackColor;

  IPoints[0]:=P0;
  IPoints[1]:=P1;
  IPoints[2]:=P2;
  Calc3DPoint(IPoints[3],Left,Bottom,z0);

  if Culling>0 then
     PolygonFour // front-side
  else
  begin
    Calc3DPoint(IPoints[0],Left,Top,z1);
    Calc3DPoint(IPoints[1],Right,Top,z1);
    Calc3DPoint(IPoints[2],Right,Bottom,z1);
    Calc3DPoint(IPoints[3],Left,Bottom,z1);
    PolygonFour // back-side
  end;

  Calc3DPoint(IPoints[2],Right,Bottom,z1);

  IPoints[0]:=P1;
  IPoints[1]:=P3;
  IPoints[3]:=P2;

  if Culling>0 then
  begin
    if DarkSides then InternalDark(OldColor,DarkerColorQuantity);
    PolygonFour;  // left-side
  end;

  IPoints[0]:=P0;
  Calc3DPoint(IPoints[1],Left,Top,z1);
  Calc3DPoint(IPoints[2],Left,Bottom,z1);
  Calc3DPoint(IPoints[3],Left,Bottom,z0);

  tmp:=(IPoints[3].x-IPoints[0].x) * (IPoints[1].y-IPoints[0].y) -
       (IPoints[1].x-IPoints[0].x) * (IPoints[3].y-IPoints[0].y);

  if tmp>0 then
  begin
    if DarkSides then InternalDark(OldColor,DarkerColorQuantity);
    PolygonFour;  // right-side
  end;

  Calc3DPoint(IPoints[3],Left,Top,z1);

  // culling
  tmp:=(P0.x-P1.x) * (P3.y-P1.y) - (P3.x-P1.x) * (P0.y-P1.y);

  if tmp>0 then
  begin
    IPoints[0]:=P0;
    IPoints[1]:=P1;
    IPoints[2]:=P3;
    if DarkSides then InternalDark(OldColor,DarkColorQuantity);
    PolygonFour; // top-side
  end;

  Calc3DPoint(IPoints[0],Left,Bottom,z0);
  Calc3DPoint(IPoints[2],Right,Bottom,z1);
  Calc3DPoint(IPoints[1],Left,Bottom,z1);
  IPoints[3]:=P2;

  if Culling<0 then
  begin
    if DarkSides then InternalDark(OldColor,DarkColorQuantity);
    PolygonFour;
  end;
end;

Procedure TTeeCanvas3D.RectangleZ(Left,Top,Bottom,Z0,Z1:Integer);
begin
  Calc3DPoint(IPoints[0],Left,Top,Z0);
  Calc3DPoint(IPoints[1],Left,Top,Z1);
  Calc3DPoint(IPoints[2],Left,Bottom,Z1);
  Calc3DPoint(IPoints[3],Left,Bottom,Z0);
  PolygonFour;
end;

Procedure TTeeCanvas3D.RectangleY(Left,Top,Right,Z0,Z1:Integer);
begin
  Calc3DPoint(IPoints[0],Left,Top,Z0);
  Calc3DPoint(IPoints[1],Right,Top,Z0);
  Calc3DPoint(IPoints[2],Right,Top,Z1);
  Calc3DPoint(IPoints[3],Left,Top,Z1);
  PolygonFour;
end;

procedure TTeeCanvas3D.FrontPlaneBegin;
begin
  FWas3D:=FIs3D;
  FIs3D:=False;
end;

procedure TTeeCanvas3D.FrontPlaneEnd;
begin
  FIs3D:=FWas3D;
end;

Procedure TTeeCanvas3D.Invalidate;
begin
  FDirty:=True;
end;

procedure TTeeCanvas3D.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Integer);
begin
  Calc3DPos(x,y,z);
  RotateLabel(x,y,St,RotDegree);
end;

procedure TTeeCanvas3D.RotateLabel(x,y:Integer; Const St:String; RotDegree:Integer);
{$IFNDEF CLX}
var OldFont: HFONT;
    NewFont: HFONT;
    LogRec : TLOGFONT;
    FDC    : HDC;
{$ELSE}
var tmpSt : WideString;
    tmpW  : Integer;
    tmpH  : Integer;
    tmp   : Integer;
{$ENDIF}
begin
  if RotDegree>360 then RotDegree:=RotDegree-360;

  {$IFNDEF CLX}
  FBrush.Style := bsClear;
  FDC:=FCanvas.Handle;
  GetObject(FFont.Handle, SizeOf(LogRec), @LogRec);
  LogRec.lfEscapement   := RotDegree*10;
  LogRec.lfOrientation  := RotDegree*10; { <-- fix, was zero }
  LogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;
  if IZoomText then
  if IZoomFactor<>1 then
     LogRec.lfHeight:= -MulDiv( Math.Max(1,Round(IZoomFactor*FFont.Size)),
                                FFont.PixelsPerInch, 72);

  LogRec.lfQuality:=TeeFontAntiAlias;

  NewFont := CreateFontIndirect(LogRec);
  OldFont := SelectObject(FDC,NewFont);

  TextOut(x,y,St);
  DeleteObject(SelectObject(FDC,OldFont));

  {$ELSE}

  if RotDegree=0 then TextOut(x,y,St)
  else
  begin
    RotDegree:=360-RotDegree;

    tmp:=TextAlign;
    tmpH:=FCanvas.TextHeight(St);
    if tmp>=TA_BOTTOM then
    begin
      tmpH:=tmpH div 2;
      Dec(tmp,TA_BOTTOM);
    end;

    if tmp=TA_CENTER then
       tmpW:=FCanvas.TextWidth(St) div 2
    else
    if tmp=TA_RIGHT then 
       tmpW:=FCanvas.TextWidth(St)
    else
       tmpW:=0;

    FCanvas.Start;
    QPainter_translate(Handle,x,y);
    QPainter_rotate(FCanvas.Handle,RotDegree);
    QPainter_translate(Handle,-x-tmpW,-y+tmpH-2);   // 2 ?

    if IZoomText then
       if IZoomFactor<>1 then
          FFont.Size:=Math.Max(1,Round(IZoomFactor*FFont.Size));

    QPainter_setFont(FCanvas.Handle,FFont.Handle);
    tmpSt:=St;
    QPainter_drawText(FCanvas.Handle,x,y,PWideString(@tmpSt),-1);
    FCanvas.Stop;
  end;
  {$ENDIF}
end;

Procedure TTeeCanvas3D.Line(X0,Y0,X1,Y1:Integer);
{$IFNDEF CLX}
var FDC : HDC;
{$ENDIF}
begin
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,X0,Y0,nil);
  Windows.LineTo(FDC,X1,Y1);
  {$ELSE}
  FCanvas.MoveTo(X0,Y0);
  FCanvas.LineTo(X1,Y1);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
{$IFNDEF CLX}
var FDC : HDC;
{$ENDIF}
begin
  Calc3DPos(x0,y0,z);
  Calc3DPos(x1,y1,z);
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,X0,Y0,nil);
  Windows.LineTo(FDC,X1,Y1);
  {$ELSE}
  Line(X0,Y0,X1,Y1);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF});
Begin
  {$IFNDEF CLX}
  Windows.Polyline(FCanvas.Handle, PPoints(@Points)^, High(Points) + 1);
  {$ELSE}
  FCanvas.Polyline(Points);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.Polygon(const Points:Array of TPoint);
Begin
  {$IFNDEF CLX}
  Windows.Polygon(FCanvas.Handle, PPoints(@Points)^, High(Points) + 1);
  {$ELSE}
  FCanvas.Polygon(Points);
  {$ENDIF}
end;

procedure TTeeCanvas3D.PolygonWithZ(Points: Array of TPoint; Z:Integer);
var t : Integer;
begin
  for t:=0 to Length(Points)-1 do
      Calc3DPoint(Points[t],Points[t].X,Points[t].Y,z);
  Polygon(Points);
end;

procedure TTeeCanvas3D.Polyline(const Points: Array of TPoint; Z:Integer);
var t : Integer;
    L : Integer;
    P : Array of TPoint;
begin
  L:=Length(Points);
  SetLength(P,L);
  for t:=0 to L-1 do
      P[t]:=Calculate3DPosition(Points[t],z);

  {$IFDEF D5}
  Polyline(P);
  {$ELSE}
    // this is due to a D4 bug...
    {$IFNDEF CLX}
    Windows.Polyline(FCanvas.Handle, PPoints(@Points)^, High(Points) + 1);
    {$ELSE}
    FCanvas.Polyline(Points);
    {$ENDIF}
  {$ENDIF}
  P:=nil;
end;

procedure TTeeCanvas3D.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  {$IFNDEF CLX}
  Windows.Ellipse(FCanvas.Handle, X1, Y1, X2, Y2);
  {$ELSE}
  FCanvas.Ellipse(X1,Y1,X2,Y2);
  {$ENDIF}
end;

procedure TTeeCanvas3D.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
Const PiStep=Pi*0.05;
      NumCirclePoints=64;
Var P       : Array[0..NumCirclePoints-1] of TPoint;
    Points  : TTrianglePoints;
    PCenter : TPoint;
    t       : Integer;
    XRadius : Integer;
    YRadius : Integer;
    tmpSin  : Extended;
    tmpCos  : Extended;
    Old     : TPenStyle;
    {$IFNDEF CLX}
    FDC     : HDC;
    {$ENDIF}
begin
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  {$ENDIF}
  if FIsOrthogonal then
  begin
    Calc3DPos(X1,Y1,Z);
    Calc3DPos(X2,Y2,Z);
    {$IFNDEF CLX}
    Windows.Ellipse(FDC, X1, Y1, X2, Y2);
    {$ELSE}
    FCanvas.Ellipse(X1,Y1,X2,Y2);
    {$ENDIF}
  end
  else
  if FIs3D then
  begin
    PCenter.X:=(X2+X1) div 2;
    PCenter.Y:=(Y2+Y1) div 2;
    XRadius:=(X2-X1) div 2;
    YRadius:=(Y2-Y1) div 2;
    Calc3DPoint(P[0],PCenter.X,Y2,Z);

    for t:=1 to NumCirclePoints-1 do
    begin
      SinCos(t*piStep,tmpSin,tmpCos);
      Calc3DPoint(P[t],PCenter.X+Trunc(XRadius*tmpSin),PCenter.Y+Trunc(YRadius*tmpCos),Z);
    end;

    if FBrush.Style<>bsClear then
    begin
      Old:=FPen.Style;
      FPen.Style:=psClear;
      {$IFNDEF CLX}
      FDC:=FCanvas.Handle;
      {$ENDIF}
      Calc3DTPoint(PCenter,Z);
      Points[0]:=PCenter;
      Points[1]:=P[0];
      Points[2]:=P[1];
      {$IFNDEF CLX}
      Windows.Polygon(FDC, PPoints(@Points)^, 3);
      {$ELSE}
      FCanvas.Polygon(Points);
      {$ENDIF}
      Points[1]:=P[1];

      for t:=2 to NumCirclePoints-1 do
      begin
        Points[2]:=P[t];
        {$IFNDEF CLX}
        Windows.Polygon(FDC, PPoints(@Points)^, 3);
        {$ELSE}
        FCanvas.Polygon(Points);
        {$ENDIF}
        Points[1]:=P[t];
      end;
      FPen.Style:=Old;
    end;

    if FPen.Style<>psClear then
       {$IFNDEF CLX}
       Windows.Polyline(FCanvas.Handle, PPoints(@P)^, High(P) + 1);
       {$ELSE}
       FCanvas.PolyLine(P);
       {$ENDIF}
  end
  else
    {$IFNDEF CLX}
    Windows.Ellipse(FCanvas.Handle, X1, Y1, X2+1, Y2+1);
    {$ELSE}
    FCanvas.Ellipse(X1,Y1,X2+1,Y2+1);
    {$ENDIF}
end;

Function TTeeCanvas3D.GetPixel(X, Y: Integer):TColor;
begin
  {$IFDEF D7}
  result:=FCanvas.Pixels[x,y];
  {$ELSE}
   {$IFDEF CLX}
     {$IFDEF MSWINDOWS}
     result:=Windows.GetPixel(QPainter_handle(Handle), X, Y);
     {$ELSE}
     result:=0; // Not implemented.
     {$ENDIF}
   {$ELSE}
    result:=FCanvas.Pixels[x,y];
   {$ENDIF}
  {$ENDIF}
end;

procedure TTeeCanvas3D.SetPixel(X, Y: Integer; Value: TColor);
begin
  {$IFNDEF CLX}
  Windows.SetPixel(FCanvas.Handle, X, Y, ColorToRGB(Value));
  {$ELSE}
  QPainter_drawPoint(Handle,x,y);
  {$ENDIF}
end;

procedure TTeeCanvas3D.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  {$IFNDEF CLX}
  Windows.Arc(FCanvas.Handle, X1, Y1, X2, Y2, X3, Y3, X4, Y4);
  {$ELSE}
  FCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
  {$ENDIF}
end;

// Donut 2D
procedure TTeeCanvas3D.Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                              Const StartAngle,EndAngle,HolePercent:Double);

var tmpXRadius,
    tmpYRadius  : Double;
    tmpSin,
    tmpCos      : Extended;

  Procedure CalcPoint(const Angle:Double; var x,y:Integer);
  begin
    SinCos(Angle,tmpSin,tmpCos);
    x:=XCenter+Round(XRadius*tmpCos);
    y:=YCenter-Round(YRadius*tmpSin);
  end;

  Procedure CalcPoint2(const Angle:Double; var x,y:Integer);
  begin
    SinCos(Angle,tmpSin,tmpCos);
    X:=XCenter+Round(tmpXRadius*tmpCos);
    Y:=YCenter-Round(tmpYRadius*tmpSin);
  end;

{$IFNDEF CLX}
var x3,y3,
    x4,y4       : Integer;
    tmpDC       : TTeeCanvasHandle;
    px,py       : Integer;
{$ELSE}
Const MaxCircleSteps=128;
var Points      : Array[0..2*MaxCircleSteps-1] of TPoint;
    t,
    CircleSteps,
    tmp         : Integer;
    Step        : Double;
    tmpAngle    : Extended;
{$ENDIF}
begin
  tmpXRadius:=HolePercent*XRadius*0.01;
  tmpYRadius:=HolePercent*YRadius*0.01;

  {$IFNDEF CLX}
  CalcPoint(StartAngle,x3,y3);
  CalcPoint(EndAngle,x4,y4);

  tmpDC:=Handle;
  BeginPath(tmpDC);

  px:=x3;
  py:=y3;

  Windows.MoveToEx(tmpDC,x3,y3,nil);
  Windows.ArcTo(tmpDC,XCenter-XRadius,YCenter-YRadius,XCenter+XRadius,YCenter+YRadius,
    x3,y3,x4,y4);

  CalcPoint2(StartAngle,x3,y3);
  CalcPoint2(EndAngle,x4,y4);

  Windows.LineTo(tmpDC,x4,y4);

  if (x4<>x3) or (y4<>y3) then
  begin
    SetArcDirection(tmpDC,AD_CLOCKWISE);

    Windows.ArcTo(tmpDC,XCenter-Round(tmpXRadius),YCenter-Round(tmpYRadius),
                        XCenter+Round(tmpXRadius),YCenter+Round(tmpYRadius),
                        x4,y4,x3,y3);

    SetArcDirection(tmpDC,AD_COUNTERCLOCKWISE);
  end;

  Windows.LineTo(tmpDC,px,py);
  EndPath(tmpDC);
  StrokeAndFillPath(tmpDC);

  {$ELSE}

  CircleSteps:=Round(MaxCircleSteps*(EndAngle-StartAngle)/Pi);
  if CircleSteps<2 then CircleSteps:=2
  else
  if CircleSteps>MaxCircleSteps then CircleSteps:=MaxCircleSteps;

  Step:=(EndAngle-StartAngle)/Pred(CircleSteps);

  tmpAngle:=StartAngle;

  for t:=1 to CircleSteps do
  begin
    SinCos(tmpAngle,tmpSin,tmpCos);
    Points[t].X:=XCenter+Round(XRadius*tmpCos);
    Points[t].Y:=YCenter-Round(YRadius*tmpSin);

    if t=1 then tmp:=0
           else tmp:=2*CircleSteps-t+1;

    Points[tmp].X:=XCenter+Round(tmpXRadius*tmpCos);
    Points[tmp].Y:=YCenter-Round(tmpYRadius*tmpSin);
    tmpAngle:=tmpAngle+Step;
  end;

  Polygon(Slice(Points,2*CircleSteps)); { 5.02 }
  {$ENDIF}
end;

procedure TTeeCanvas3D.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
{$IFDEF CLX}
const HalfDivPi=180/Pi;
var
  Width, Height: Integer;
  CenterX, CenterY: Integer;
  Theta: Extended;
  Theta2: Extended;
{$ENDIF}
begin
  {$IFNDEF CLX}
  Windows.Pie(FCanvas.Handle, X1, Y1, X2, Y2, X3, Y3, X4, Y4);
  {$ELSE}

  { bug in CLX, needs this code: }
  Width := X2 - X1;
  Height := Y2 - Y1;
  CenterX := X1 + (Width div 2);
  CenterY := Y1 + (Height div 2);

  Theta:=ArcTan2(CenterY-Y3, X3 - CenterX);
  if Theta<0 then Theta:=2.0*Pi+Theta;
  Theta := Theta*HalfDivPi;

  Theta2:=ArcTan2(CenterY-Y4, X4 - CenterX);
  if Theta2<0 then Theta2:=2.0*Pi+Theta2;
  Theta2 :=Theta2*HalfDivPi;
  if Theta2=0 then
     Theta2:=361;

  FCanvas.Pie(X1, Y1, Width, Height, Round(Theta) shl 4, Round(Theta2 - Theta) shl 4);
  {$ENDIF}
end;

procedure TTeeCanvas3D.Pie3D( XCenter,YCenter,XRadius,YRadius,Z0,Z1:Integer;
                              Const StartAngle,EndAngle:Double;
                              DarkSides,DrawSides:Boolean; DonutPercent:Integer=0);
Const MaxCircleSteps=32;
var Points      : Array[0..2*MaxCircleSteps+1] of TPoint;
    Points3D2,
    Points3D    : Array[1..2*MaxCircleSteps] of TPoint;
    Start3D,
    End3D,
    CircleSteps : Integer;
    OldColor    : TColor;

  Procedure Draw3DPie;
  var t,tt : Integer;
  begin
    if DarkSides then InternalDark(OldColor,32);

    if (Start3D=1) and (End3D=CircleSteps) then
    begin
      for t:=1 to CircleSteps do Points3D[t]:=Points[t];
      tt:=CircleSteps;
    end
    else
    begin
      tt:=0;
      for t:=Start3D to End3D do
      begin
        Inc(tt);
        Points3D[tt]:=Points[t];
        Points3D[End3D-Start3D+1+tt]:=Points3D[2*CircleSteps-End3D+tt];
      end;
    end;

    Polygon(Slice(Points3D,2*tt)); { 5.02 }
  end;

var tmpSin,
    tmpCos   : Extended;
    tmpXRadius,
    tmpYRadius : Double;

  Procedure CalcCenter(Var P:TPoint; const Angle:Double; Z:Integer);
  var tmpX,tmpY  : Integer;
  begin
    if DonutPercent>0 then
    begin
      SinCos(Angle,tmpSin,tmpCos);
      tmpX:=XCenter+Round(tmpXRadius*tmpCos);
      tmpY:=YCenter-Round(tmpYRadius*tmpSin);
      Calc3DPoint(P,tmpX,tmpY,Z);
    end
    else
       Calc3DPoint(P,XCenter,YCenter,Z);
  end;

  Procedure FinishSide(const Angle:Double);
  begin
    CalcCenter(IPoints[3],Angle,Z0);
    if DarkSides then InternalDark(OldColor,32);
    PolygonFour;
  end;

Var tmpAngle : Extended;
    Step     : Double;
    Started,
    Ended    : Boolean;
    t,
    tt,
    tmpX,
    tmpY     : Integer;
begin
  CircleSteps:=2+Math.Min(MaxCircleSteps-2,Round(180.0*Abs(EndAngle-StartAngle)/Pi/10.0));

  //  CircleSteps:=MaxCircleSteps; { to draw better rounded }

  if DonutPercent>0 then
  begin
    tmpXRadius:=DonutPercent*XRadius*0.01;
    tmpYRadius:=DonutPercent*YRadius*0.01;
  end;

  CalcCenter(Points[0],StartAngle,Z1);

  Step:=(EndAngle-StartAngle)/(CircleSteps-1);
  tmpAngle:=StartAngle;

  for t:=1 to CircleSteps do
  begin
    SinCos(tmpAngle,tmpSin,tmpCos);
    tmpX:=XCenter+Round(XRadius*tmpCos);
    tmpY:=YCenter-Round(YRadius*tmpSin);
    Calc3DPoint(Points[t],tmpX,tmpY,Z1);
    Calc3DPoint(Points3D[2*CircleSteps+1-t],tmpX,tmpY,Z0);
    tmpAngle:=tmpAngle+Step;
  end;

  if FBrush.Style=bsSolid then OldColor:=FBrush.Color
                          else OldColor:=BackColor;

  if DonutPercent>0 then
  begin
    CalcCenter(Points[2*CircleSteps+1],EndAngle,Z1);
    Points3D2[1]:=Points[0];

    tmpAngle:=EndAngle;
    for t:=1 to CircleSteps do
    begin
      CalcCenter(Points[CircleSteps+t],tmpAngle,Z1);
      Points3D2[t]:=Points[CircleSteps+t];
      CalcCenter(Points3D2[2*CircleSteps+1-t],tmpAngle,Z0);

      tmpAngle:=tmpAngle-Step;
    end;

    if DarkSides then InternalDark(OldColor,32);
    Polygon(Slice(Points3D2,2*CircleSteps)); { 5.02 }
  end;

  { side }
  if DrawSides then
  begin
    if Points[CircleSteps].X < FXCenterOffset then
    begin
      if DonutPercent>0 then IPoints[0]:=Points[2*CircleSteps+1]
                        else IPoints[0]:=Points[0];
      IPoints[1]:=Points[CircleSteps];
      IPoints[2]:=Points3D[CircleSteps+1];
      FinishSide(EndAngle);
    end;

    { side }
    if Points[1].X > FXCenterOffset then
    begin
      IPoints[0]:=Points[0];
      IPoints[1]:=Points[1];
      IPoints[2]:=Points3D[2*CircleSteps];
      FinishSide(StartAngle);
    end;
  end;

  { 2d pie }
  if FBrush.Style=bsSolid then FBrush.Color:=OldColor
                          else BackColor:=OldColor;

  if DonutPercent>0 then
     Polygon(Slice(Points,2*CircleSteps+1))
  else
     Polygon(Slice(Points,CircleSteps+1)); { 5.02 }

  { 3d pie }
  Ended:=False;
  Start3D:=0;
  End3D:=0;

  for t:=2 to CircleSteps do
  begin
    if Points[t].X>Points[t-1].X then
    begin
      Start3D:=t-1;
      Started:=True;

      for tt:=t+1 to CircleSteps-1 do
      if Points[tt+1].X<Points[tt].X then
      begin
        End3D:=tt;
        Ended:=True;
        Break;
      end;

      if (not Ended) and (Points[CircleSteps].X>=Points[CircleSteps-1].X) then
      begin
        End3D:=CircleSteps;
        Ended:=True;
      end;

      if Started and Ended then Draw3DPie;

      if End3D<>CircleSteps then
      if Points[CircleSteps].X>Points[CircleSteps-1].X then
      begin
        End3D:=CircleSteps;
        tt:=CircleSteps-1;

        While (Points[tt].X>Points[tt-1].X) do
        begin
          Dec(tt);
          if tt=1 then break;
        end;

        if tt>1 then
        begin
          Start3D:=tt;
          Draw3DPie;
        end;

      end;

      break;
    end;
  end;
end;

procedure TTeeCanvas3D.Plane3D(Const A,B:TPoint; Z0,Z1:Integer);
begin
  Calc3DPoint(IPoints[0],A.X,A.Y,Z0);
  Calc3DPoint(IPoints[1],B.X,B.Y,Z0);
  Calc3DPoint(IPoints[2],B.X,B.Y,Z1);
  Calc3DPoint(IPoints[3],A.X,A.Y,Z1);
  PolygonFour;
end;

procedure TTeeCanvas3D.InternalCylinder(Vertical:Boolean; Left,Top,Right,Bottom,
                            Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
Const NumCylinderSides=16;
      Step=2.0*Pi/NumCylinderSides;
      StepColor=256 div NumCylinderSides;

var Poly    : Array[1..NumCylinderSides] of TPoint3D;
    tmpPoly : Array[1..NumCylinderSides] of TPoint;
    Radius,
    ZRadius,
    tmpMid,
    tmpMidZ,
    tmpSize : Integer;

  Procedure CalcPointZ(Index:Integer; var X,Z:Integer);
  var tmpSin : Extended;
      tmpCos : Extended;
  begin
    SinCos(Index*Step,tmpSin,tmpCos);
    X:=tmpMid+Round(tmpSin*Radius);
    Z:=tmpMidZ-Round(tmpCos*ZRadius);
  end;

  Procedure CalcPointV(a,b:Integer);
  begin
    With Poly[a] do
    begin
      Calc3DPoint(tmpPoly[b],x,y+tmpSize,z);
      CalcPointZ(a-4,X,Z);
    end;
  end;

  Procedure CalcPointH(a,b:Integer);
  begin
    With Poly[a] do
    begin
      Calc3DPoint(tmpPoly[b],x-tmpSize,y,z);
      CalcPointZ(a-5,Y,Z);
    end;
  end;

  Function CoverAtLeft:Boolean;
  begin
    Calc3DPoint(tmpPoly[1],0,0,0);
    Calc3DPoint(tmpPoly[2],0,10,0);
    Calc3DPoint(tmpPoly[3],0,10,10);
    result:=TeeCull(tmpPoly[1],tmpPoly[2],tmpPoly[3]);
  end;

Var OldColor : TColor;
    t        : Integer;
    NumSide  : Integer;
    tmp      : Integer;
begin
  if ConePercent=0 then ConePercent:=TeeDefaultConePercent;
  if FBrush.Style=bsSolid then OldColor:=FBrush.Color
                          else OldColor:=BackColor;
  ZRadius:=(Z1-Z0) div 2;
  tmpMidZ:=(Z1+Z0) div 2;

  if Vertical then
  begin
    Radius:=(Right-Left) div 2;
    tmpMid:=(Right+Left) div 2;
    tmpSize:=Abs(Bottom-Top);

    if Top<Bottom then tmp:=Top
                  else tmp:=Bottom;

    for t:=1 to NumCylinderSides do
    begin
      Poly[t].Y:=tmp;
      CalcPointZ(t-4,Poly[t].X,Poly[t].Z);
    end;
  end
  else
  begin
    Radius:=(Bottom-Top) div 2;
    tmpMid:=(Bottom+Top) div 2;
    tmpSize:=Abs(Right-Left);

    if Left<Right then tmp:=Right
                  else tmp:=Left;

    for t:=1 to NumCylinderSides do
    begin
      Poly[t].X:=tmp;
      CalcPointZ(t-5,Poly[t].Y,Poly[t].Z);
    end;
  end;

  Radius:=Round(Radius*ConePercent*0.01);
  ZRadius:=Round(ZRadius*ConePercent*0.01);

  if Vertical then CalcPointV(1,2)
              else CalcPointH(1,2);

  tmpPoly[1]:=Calc3DTPoint3D(Poly[1]);
  NumSide:=0;

  for t:=2 to NumCylinderSides do
  begin
    if Vertical then CalcPointV(t,3)
                else CalcPointH(t,3);

    tmpPoly[4]:=Calc3DTPoint3D(Poly[t]);

    if not TeeCull(tmpPoly[1],tmpPoly[2],tmpPoly[3]) then
    begin
      if Dark3D and (NumSide<=8) then
         InternalDark(OldColor,StepColor*NumSide);
         
      Polygon(Slice(tmpPoly,4));
    end;

    tmpPoly[1]:=tmpPoly[4];
    tmpPoly[2]:=tmpPoly[3];
    Inc(NumSide);
  end;

  if ConePercent=100 then
  begin
    if Vertical then CalcPointV(1,3)
                else CalcPointH(1,3);

    tmpPoly[4]:=Calc3DTPoint3D(Poly[1]);

    if not TeeCull(tmpPoly[1],tmpPoly[2],tmpPoly[3]) then
       Polygon(Slice(tmpPoly,4));
  end;

  // Cover
  if (not Vertical) and CoverAtLeft then
      for t:=1 to NumCylinderSides do
          tmpPoly[t]:=Calculate3DPosition(Left,Poly[t].Y,Poly[t].Z)
  else
  for t:=1 to NumCylinderSides do
      tmpPoly[t]:=Calc3DTPoint3D(Poly[t]);

  if Dark3D then InternalDark(OldColor,DarkColorQuantity);
  Polygon(tmpPoly);
end;

procedure TTeeCanvas3D.Cylinder(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; Dark3D:Boolean);
Begin
  InternalCylinder(Vertical,Left,Top,Right,Bottom,Z0,Z1,Dark3D,100);
end;

procedure TTeeCanvas3D.Pyramid(Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer; DarkSides:Boolean);
Var OldColor : TColor;
    P0,P1,
    P2,P3,
    PTop     : TPoint;
    tmpC     : Boolean;
begin
  if FBrush.Style=bsSolid then OldColor:=FBrush.Color
                          else OldColor:=BackColor;
  if Vertical then
  begin
    if Top<>Bottom then
    Begin
      Calc3DPoint(P0,Left,Bottom,Z0);
      Calc3DPoint(P1,Right,Bottom,Z0);
      Calc3DPoint(PTop,(Left+Right) div 2,Top,(Z0+Z1) div Integer(2));
      Calc3DPoint(P2,Left,Bottom,Z1);
      Calc3DPoint(P3,Right,Bottom,Z1);

      Polygon([P0,PTop,P1]);

      tmpC:=TeeCull(P0,PTop,P2);
      if Top<Bottom then tmpC:=not tmpC;
      if tmpC then Polygon([ P0,PTop,P2] );

      if DarkSides then InternalDark(OldColor,DarkerColorQuantity);

      tmpC:=TeeCull(P1,PTop,P3);
      if Top>=Bottom then tmpC:=not tmpC;
      if tmpC then Polygon([ P1,PTop,P3 ] );

      if Top<Bottom then
      begin
        Calc3DPoint(P2,Left,Bottom,Z1);
        if TeeCull(PTop,P2,P3) then Polygon([ PTop,P2,P3 ] );
      end;
    end;

    Calc3DPoint(P0,Left,Bottom,Z0);
    Calc3DPoint(P1,Right,Bottom,Z0);
    Calc3DPoint(P2,Left,Bottom,Z1);

    tmpC:=TeeCull(P0,P1,P2);
    if Top>=Bottom then tmpC:=not tmpC;
    if tmpC then
    begin
      if DarkSides then InternalDark(OldColor,DarkColorQuantity);
      RectangleY(Left,Bottom,Right,Z0,Z1);
    end;
  end
  else
  begin
    if Left<>Right then
    Begin
      Calc3DPoint(P0,Left,Top,Z0);
      Calc3DPoint(P1,Left,Bottom,Z0);
      Calc3DPoint(PTop,Right,(Top+Bottom) div 2,(Z0+Z1) div 2);
      Calc3DPoint(P2,Left,Top,Z1);
      Calc3DPoint(P3,Left,Bottom,Z1);

      Polygon([P0,PTop,P1]);

      tmpC:=TeeCull(P2,PTop,P3);
      if Left<Right then tmpC:=not tmpC;
      if tmpC then Polygon([ P2,PTop,P3] );

      if DarkSides then InternalDark(OldColor,DarkColorQuantity);

      tmpC:=TeeCull(P0,PTop,P2);
      if Left<Right then tmpC:=not tmpC;
      if tmpC then Polygon([ P0,PTop,P2 ] );

      tmpC:=TeeCull(P3,PTop,P1);
      if Left<Right then tmpC:=not tmpC;
      if tmpC then Polygon([ P3,PTop,P1 ] );
    end;

    Calc3DPoint(P0,Left,Top,Z0);
    Calc3DPoint(P1,Left,Bottom,Z0);
    Calc3DPoint(P2,Left,Top,Z1);

    tmpC:=TeeCull(P0,P1,P2);
    if Left>=Right then tmpC:=not tmpC;
    if tmpC then
    begin
      if DarkSides then InternalDark(OldColor,DarkerColorQuantity);
      RectangleZ(Left,Top,Bottom,Z0,Z1);
    end;
  end;
end;

Procedure TTeeCanvas3D.PyramidTrunc(Const R:TRect; StartZ,EndZ:Integer;
                                    TruncX,TruncZ:Integer);
var MidX : Integer;
    MidZ : Integer;

  Procedure PyramidFrontWall(StartZ,EndZ:Integer);
  var P : TFourPoints;
  begin
    P[0].X:=MidX-TruncX;
    P[0].Y:=R.Top;
    P[1].X:=MidX+TruncX;
    P[1].Y:=R.Top;
    P[2].X:=R.Right;
    P[2].Y:=R.Bottom;
    P[3].X:=R.Left;
    P[3].Y:=R.Bottom;
    PlaneFour3D(P,StartZ,EndZ);
  end;

  Procedure PyramidSideWall(HorizPos1,HorizPos2:Integer; IsLeft:Boolean);
  var tmp : Double;
  begin
    IPoints[0]:=Calculate3DPosition(HorizPos2,R.Top,MidZ-TruncZ);
    IPoints[1]:=Calculate3DPosition(HorizPos2,R.Top,MidZ+TruncZ);
    IPoints[2]:=Calculate3DPosition(HorizPos1,R.Bottom,EndZ);
    IPoints[3]:=Calculate3DPosition(HorizPos1,R.Bottom,StartZ);

    tmp:=((IPoints[3].x-IPoints[2].x) * (IPoints[1].y-IPoints[2].y)) -
         ((IPoints[1].x-IPoints[2].x) * (IPoints[3].y-IPoints[2].y));

    if IsLeft then
    begin
      if tmp<0 then PolygonFour;
    end
    else
      if tmp>0 then PolygonFour;
  end;

  Procedure BottomCover;
  begin
    RectangleY(R.Left,R.Bottom,R.Right,StartZ,EndZ)
  end;

  Procedure TopCover;
  begin
    if TruncX<>0 then
       RectangleY(MidX-TruncX,R.Top,MidX+TruncX,MidZ-TruncZ,MidZ+TruncZ);
  end;

begin
  MidX:=(R.Left+R.Right) div 2;
  MidZ:=(StartZ+EndZ) div 2;
  if R.Bottom>R.Top then BottomCover else TopCover;
  PyramidFrontWall(MidZ+TruncZ,EndZ);
  PyramidSideWall(R.Left,MidX-TruncX,True);
  PyramidFrontWall(MidZ-TruncZ,StartZ);
  PyramidSideWall(R.Right,MidX+TruncX,False);
  if R.Bottom>R.Top then TopCover else BottomCover;
end;

procedure TTeeCanvas3D.PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer);
begin
  IPoints:=Points;
  Calc3DPos(IPoints[0].X,IPoints[0].Y,Z0);
  Calc3DPos(IPoints[1].X,IPoints[1].Y,Z0);
  Calc3DPos(IPoints[2].X,IPoints[2].Y,Z1);
  Calc3DPos(IPoints[3].X,IPoints[3].Y,Z1);
  PolygonFour;
end;

Function TTeeCanvas3D.GetPixel3D(X,Y,Z: Integer):TColor;
begin
  Calc3DPos(X,Y,Z);
  result:=GetPixel(x,y);
end;

procedure TTeeCanvas3D.SetPixel3D(X,Y,Z:Integer; Value: TColor);
{$IFNDEF CLX}
var FDC : HDC;
{$ENDIF}
begin
  Calc3DPos(X,Y,Z);
  if FPen.Width=1 then SetPixel(X,Y,Value)
  else
  begin { simulate a big dot pixel }
    {$IFNDEF CLX}
    FDC:=FCanvas.Handle;
    Windows.MoveToEx(FDC,X,Y,nil);
    Windows.LineTo(FDC,X,Y);
    {$ELSE}
    Pixels[X,Y]:=Value;
    {$ENDIF}
  end;
end;

Function TTeeCanvas3D.GetSupports3DText:Boolean;
begin
  result:=False;
end;

Function TTeeCanvas3D.GetSupportsFullRotation:Boolean;
begin
  result:=False;
end;

Function TTeeCanvas3D.GetTextAlign:TCanvasTextAlign;
begin
  {$IFNDEF CLX}
  result:=Windows.GetTextAlign(FCanvas.Handle);
  {$ELSE}
  result:=FTextAlign;
  {$ENDIF}
end;

Function TTeeCanvas3D.GetUseBuffer:Boolean;
begin
  result:=FBufferedDisplay;
end;

Procedure TTeeCanvas3D.SetUseBuffer(Value:Boolean);
begin
  if FBufferedDisplay<>Value then
  begin
    FBufferedDisplay:=Value;
    if (not FBufferedDisplay) and Assigned(FBitmap) then
    begin
      DeleteBitmap;
      FDirty:=True;
    end
    else
    if FBufferedDisplay and Assigned(FBitmap) then
       SetCanvas(FBitmap.Canvas);
  end;
end;

Function TTeeCanvas3D.GetMonochrome:Boolean;
begin
  result:=FMonochrome;
end;

Procedure TTeeCanvas3D.SetMonochrome(Value:Boolean);
begin
  if FMonochrome<>Value then
  begin
    FMonochrome:=Value;
    FDirty:=True;
    if Assigned(F3DOptions) then F3DOptions.Repaint;
  end;
end;

Procedure TTeeCanvas3D.HorizLine3D(Left,Right,Y,Z:Integer);
var {$IFNDEF CLX}
    FDC  : HDC;
    {$ENDIF}
    tmpY : Integer;
begin
  tmpY:=Y;
  Calc3DPos(Left,tmpY,Z);
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,Left,tmpY,nil);
  {$ELSE}
  FCanvas.MoveTo(Left,tmpY);
  {$ENDIF}
  tmpY:=Y;
  Calc3DPos(Right,tmpY,Z);
  {$IFNDEF CLX}
  Windows.LineTo(FDC,Right,tmpY);
  {$ELSE}
  FCanvas.LineTo(Right,tmpY);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.VertLine3D(X,Top,Bottom,Z:Integer);
var {$IFNDEF CLX}
    FDC  : HDC;
    {$ENDIF}
    tmpX : Integer;
begin
  tmpX:=X;
  Calc3DPos(tmpX,Top,Z);
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,tmpX,Top,nil);
  {$ELSE}
  FCanvas.MoveTo(tmpX,Top);
  {$ENDIF}
  tmpX:=X;
  Calc3DPos(tmpX,Bottom,Z);
  {$IFNDEF CLX}
  Windows.LineTo(FDC,tmpX,Bottom);
  {$ELSE}
  FCanvas.LineTo(tmpX,Bottom);
  {$ENDIF}
end;

Procedure TTeeCanvas3D.ZLine3D(X,Y,Z0,Z1:Integer);
var {$IFNDEF CLX}
    FDC  : HDC;
    {$ENDIF}
    tmpX : Integer;
    tmpY : Integer;
begin
  tmpX:=X;
  tmpY:=Y;
  Calc3DPos(tmpX,tmpY,Z0);
  {$IFNDEF CLX}
  FDC:=FCanvas.Handle;
  Windows.MoveToEx(FDC,tmpX,tmpY,nil);
  {$ELSE}
  FCanvas.MoveTo(tmpX,tmpY);
  {$ENDIF}
  tmpX:=X;
  tmpY:=Y;
  Calc3DPos(tmpX,tmpY,Z1);
  {$IFNDEF CLX}
  Windows.LineTo(FDC,tmpX,tmpY);
  {$ELSE}
  FCanvas.LineTo(tmpX,tmpY);
  {$ENDIF}
end;

procedure TTeeCanvas3D.Triangle3D( Const Points:TTrianglePoints3D;
                                   Const Colors:TTriangleColors3D);
var P : TTrianglePoints;
begin
  P[0]:=Calc3DTPoint3D(Points[0]);
  P[1]:=Calc3DTPoint3D(Points[1]);
  P[2]:=Calc3DTPoint3D(Points[2]);
  if Brush.Style<>bsClear then Brush.Color:=Colors[0];
  Polygon(P);
end;

procedure TTeeCanvas3D.TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer);
var Points : TTrianglePoints;
begin
  Calc3DPoint(Points[0],P1.X,P1.Y,Z);
  Calc3DPoint(Points[1],P2.X,P2.Y,Z);
  Calc3DPoint(Points[2],P3.X,P3.Y,Z);
  Polygon(Points);
end;

Procedure TTeeCanvas3D.Arrow( Filled:Boolean;
                              Const FromPoint,ToPoint:TPoint;
                              ArrowWidth,ArrowHeight,Z:Integer);
Var x    : Double;
    y    : Double;
    SinA : Double;
    CosA : Double;

    Function CalcArrowPoint:TPoint;
    Begin
      result.X:=Round( x*CosA + y*SinA);
      result.Y:=Round(-x*SinA + y*CosA);
      Calc3DTPoint(result,Z);
    end;

Var tmpHoriz  : Integer;
    tmpVert   : Integer;
    dx        : Integer;
    dy        : Integer;
    tmpHoriz4 : Double;
    xb        : Double;
    yb        : Double;
    l         : Double;

   { These are the Arrows points coordinates }
    To3D,pc,pd,pe,pf,pg,ph:TPoint;

    (*           pc
                   |\
    ph           pf| \
      |------------   \ ToPoint
 From |------------   /
    pg           pe| /
                   |/
                 pd
    *)
begin
  dx := ToPoint.x-FromPoint.x;
  dy := FromPoint.y-ToPoint.y;
  l  := TeeDistance(dx,dy);

  if l>0 then  { if at least one pixel... }
  Begin
    tmpHoriz:=ArrowWidth;
    tmpVert :=Math.Min(Round(l),ArrowHeight);
    SinA:= dy / l;
    CosA:= dx / l;
    xb:= ToPoint.x*CosA - ToPoint.y*SinA;
    yb:= ToPoint.x*SinA + ToPoint.y*CosA;
    x := xb - tmpVert;
    y := yb - tmpHoriz*0.5;
    pc:=CalcArrowPoint;
    y := yb + tmpHoriz*0.5;
    pd:=CalcArrowPoint;

    if Filled then
    Begin
      tmpHoriz4:=tmpHoriz*0.25;
      y := yb - tmpHoriz4;
      pe:=CalcArrowPoint;
      y := yb + tmpHoriz4;
      pf:=CalcArrowPoint;
      x := FromPoint.x*cosa - FromPoint.y*sina;
      y := yb - tmpHoriz4;
      pg:=CalcArrowPoint;
      y := yb + tmpHoriz4;
      ph:=CalcArrowPoint;
      To3D:=ToPoint;
      Calc3DTPoint(To3D,Z);
      Polygon([ ph,pg,pe,pc,To3D,pd,pf ]);
    end
    else
    begin
      MoveTo3D(FromPoint.x,FromPoint.y,z);
      LineTo3D(ToPoint.x,ToPoint.y,z);
      LineTo3D(pd.x,pd.y,z);
      MoveTo3D(ToPoint.x,ToPoint.y,z);
      LineTo3D(pc.x,pc.y,z);
    end;
  end;
end;

{ TTeeShadow }
Constructor TTeeShadow.Create(AOnChange:TNotifyEvent);
begin
  inherited Create;
  IOnChange:=AOnChange;
  FColor   :=clSilver;
  DefaultColor:=FColor;
end;

Procedure TTeeShadow.Assign(Source:TPersistent);
begin
  if Source is TTeeShadow then
  With TTeeShadow(Source) do
  begin
    Self.FColor        :=Color;
    Self.FHorizSize    :=HorizSize;
    Self.FTransparency :=Transparency;
    Self.FVertSize     :=VertSize;
  end
  else inherited;
end;

Procedure TTeeShadow.SetIntegerProperty(Var Variable:Integer; Const Value:Integer);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    if Assigned(IOnChange) then IOnChange(Self);
  end;
end;

Procedure TTeeShadow.SetColor(Value:TColor);
begin
  SetIntegerProperty(Integer(FColor),Value);
end;

Procedure TTeeShadow.SetHorizSize(Value:Integer);
begin
  SetIntegerProperty(FHorizSize,Value);
end;

Procedure TTeeShadow.SetVertSize(Value:Integer);
begin
  SetIntegerProperty(FVertSize,Value);
end;

function TTeeShadow.GetSize: Integer;
begin
  result:=Math.Max(HorizSize,VertSize)
end;

procedure TTeeShadow.SetSize(const Value: Integer);
begin
  HorizSize:=Value;
  VertSize:=Value;
end;

procedure TTeeShadow.SetTransparency(Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    if Assigned(IOnChange) then IOnChange(Self);
  end;
end;

Function TTeeShadow.PrepareCanvas(ACanvas:TCanvas3D; const R:TRect;
                                  Z:Integer=0):Boolean;
begin
  result:=(Color<>clNone) and ((HorizSize<>0) or (VertSize<>0));
  if result then
  begin
    With ACanvas do
    begin
      Brush.Color:=Self.Color;
      Brush.Style:=bsSolid;
      Pen.Style:=psClear;
    end;

    if Transparency>0 then
       IBlend:=ACanvas.BeginBlending(ACanvas.RectFromRectZ(TeeRect(R.Left+HorizSize,
                                R.Top+VertSize,R.Right+HorizSize,R.Bottom+VertSize),Z),
                                Transparency);
  end;
end;

procedure TTeeShadow.FinishBlending(ACanvas:TTeeCanvas);
begin
  if Transparency>0 then
     ACanvas.EndBlending(IBlend);
end;

procedure TTeeShadow.Draw(ACanvas: TCanvas3D; const Rect: TRect);
begin
  if PrepareCanvas(ACanvas,Rect) then
  begin
    With Rect do
    begin
      ACanvas.FillRect(TeeRect(Left+HorizSize,Bottom,Right+HorizSize,Bottom+VertSize));
      ACanvas.FillRect(TeeRect(Right,Top+VertSize,Right+HorizSize,Bottom+VertSize));
    end;
    FinishBlending(ACanvas);
  end;
end;

procedure TTeeShadow.DrawEllipse(ACanvas: TCanvas3D; const Rect: TRect;
                                 Z:Integer=0);
begin
  if PrepareCanvas(ACanvas,Rect,Z) then
  begin
    With Rect do
       ACanvas.EllipseWithZ(Left+HorizSize,Top+VertSize,
                            Right+HorizSize,Bottom+VertSize,Z);

    FinishBlending(ACanvas);
  end;
end;

function TTeeShadow.IsColorStored: Boolean;
begin
  result:=FColor<>DefaultColor;
end;

function TTeeShadow.IsHorizStored: Boolean;
begin
  result:=FHorizSize<>DefaultSize;
end;

function TTeeShadow.IsVertStored: Boolean;
begin
  result:=FVertSize<>DefaultSize;
end;

{ TCustomTeeGradient }
Constructor TCustomTeeGradient.Create(ChangedEvent:TNotifyEvent);
Begin
  inherited Create;
  IChanged    :=ChangedEvent;
  FDirection  :=gdTopBottom;
  FStartColor :=clWhite;
  FEndColor   :=clYellow;
  FMidColor   :=clNone;
  FBalance    :=50;
End;

Procedure TCustomTeeGradient.UseMiddleColor;
begin
  if not IHasMiddle then
  begin
    IHasMiddle:=True;
    IChanged(Self);
  end;
end;

Function TCustomTeeGradient.GetMidColor:TColor;
begin
  if IHasMiddle then result:=FMidColor
                else result:=clNone;
end;

Procedure TCustomTeeGradient.SetVisible(Value:Boolean);
Begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    if Assigned(IChanged) then IChanged(Self);
  end;
End;

Procedure TCustomTeeGradient.SetBalance(Value:Integer);
begin
  SetIntegerProperty(FBalance,Value);
end;

Procedure TCustomTeeGradient.SetDirection(Value:TGradientDirection);
Begin
  if FDirection<>Value then
  Begin
    FDirection:=Value;
    if Assigned(IChanged) then IChanged(Self);
  end;
End;

Procedure TCustomTeeGradient.SetIntegerProperty(Var Variable:Integer; Value:Integer);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    if Assigned(IChanged) then IChanged(Self);
  end;
end;

Procedure TCustomTeeGradient.SetStartColor(Value:TColor);
Begin
  SetIntegerProperty(Integer(FStartColor),Value);
End;

Procedure TCustomTeeGradient.SetEndColor(Value:TColor);
Begin
  SetIntegerProperty(Integer(FEndColor),Value);
End;

Procedure TCustomTeeGradient.SetMidColor(Value:TColor);
Begin
  if IHasMiddle then { 5.02 }
  begin
    if Value=clNone then
    begin
      IHasMiddle:=False;
      IChanged(Self);
    end
    else
      SetIntegerProperty(Integer(FMidColor),Value);
  end
  else
  if Value<>clNone then
  begin
    IHasMiddle:=True;
    FMidColor:=Value;
    if Assigned(IChanged) then IChanged(Self);
  end;
End;

Procedure TCustomTeeGradient.Assign(Source:TPersistent);
Begin
  if Source is TCustomTeeGradient then
  With TCustomTeeGradient(Source) do
  Begin
    Self.FBalance   :=FBalance;
    Self.FDirection :=FDirection;
    Self.FEndColor  :=FEndColor;
    Self.FMidColor  :=FMidColor;
    Self.FRadialX   :=FRadialX;
    Self.FRadialY   :=FRadialY;
    Self.FStartColor:=FStartColor;
    Self.FVisible   :=FVisible;
    Self.IHasMiddle :=IHasMiddle;
  end
  else inherited;
end;

Procedure TCustomTeeGradient.DrawRadial(Canvas:TTeeCanvas; Rect:TRect);
var tmpRect : TRect;

  Procedure DoRadialGradient;
  var Step,
      SizeX,
      SizeY,
      t,
      e0,e1,e2 : Integer;
      xc,yc,
      InvStep,
      tmpD,
      tmpX,
      tmpY,
      sx,
      sy : Double;
      dr,
      dg,
      db : Double;
      OldBrushColor : TColor;
      OldPenStyle   : TPenStyle;
  begin
    RectSize(tmpRect,SizeX,SizeY);

    Step:=Math.Min(255,Math.Max(SizeX,SizeY));
    InvStep:=1/Step;

    sx:=0.5*SizeX*InvStep;
    sy:=0.5*SizeY*InvStep;

    e0:=GetRValue(StartColor);
    e1:=GetGValue(StartColor);
    e2:=GetBValue(StartColor);

    if Balance=50 then
    begin
      dr:=(GetRValue(EndColor)-e0)*InvStep;
      dg:=(GetGValue(EndColor)-e1)*InvStep;
      db:=(GetBValue(EndColor)-e2)*InvStep;
    end
    else
    begin
      dr:=(GetRValue(EndColor)-e0);
      dg:=(GetGValue(EndColor)-e1);
      db:=(GetBValue(EndColor)-e2);
    end;

    OldPenStyle:=Canvas.Pen.Style;
    Canvas.Pen.Style:=psClear;

    OldBrushColor:=Canvas.Brush.Color;
    try
      Canvas.Brush.Color:=EndColor;
      Canvas.FillRect(tmpRect);

      if ((SizeX mod 2)=1) or ((SizeY mod 2)=1) then Dec(Step);

      xc:=1+RadialX+((tmpRect.Left+tmpRect.Right)*0.5);
      yc:=1+RadialY+((tmpRect.Top+tmpRect.Bottom)*0.5);

      for t:=Step downto 0 do
      begin
        if Balance=50 then
           Canvas.Brush.Color:=RGB(e0+Round(dr*t),e1+Round(dg*t),e2+Round(db*t))
        else
        begin
          tmpD:=TeeSigmoid(t,Balance,Step);
          Canvas.Brush.Color:=(( e0 + Round(tmpD*dr) ) or
                              (( e1 + Round(tmpD*dg) ) shl 8) or
                              (( e2 + Round(tmpD*db) ) shl 16));
        end;

        tmpX:=t*sx;
        tmpY:=t*sy;
        Canvas.Ellipse(Round(xc-tmpX),Round(yc-tmpY),Round(xc+tmpX),Round(yc+tmpY));
      end;

    finally
      Canvas.Brush.Color:=OldBrushColor;
      Canvas.Pen.Style:=OldPenStyle;
    end;
  end;

begin
  tmpRect:=OrientRectangle(Rect);

  {$IFDEF CLX}
  Canvas.FCanvas.Start;
  {$ELSE}
  Canvas.ClipRectangle(tmpRect);
  {$ENDIF}

  DoRadialGradient;

  {$IFDEF CLX}
  Canvas.FCanvas.Stop;
  {$ELSE}
  Canvas.UnClipRectangle;
  {$ENDIF}
end;

Procedure TCustomTeeGradient.Draw( Canvas:TTeeCanvas; Const Rect:TRect;
                                   RoundRectSize:Integer=0);
var R : TRect;

  Procedure DoVert(C0,C1,C2,C3:TColor);
  begin
    R.Bottom:=(Rect.Bottom+Rect.Top) div 2;
    Canvas.GradientFill(R,C0,C1,Direction);
    R.Top:=R.Bottom;
    R.Bottom:=Rect.Bottom;
    Canvas.GradientFill(R,C2,C3,Direction);
  end;

  Procedure DoHoriz(C0,C1,C2,C3:TColor);
  begin
    R.Right:=(Rect.Left+Rect.Right) div 2;
    Canvas.GradientFill(R,C0,C1,Direction);
    R.Left:=R.Right;
    R.Right:=Rect.Right;
    Canvas.GradientFill(R,C2,C3,Direction);
  end;

  Function TryGrayColor(Const AColor:TColor):TColor;
  var tmpRGB : TRGBTriple;
      tmp    : Byte;
  begin
    if Canvas.Monochrome then
    begin
      tmpRGB:=RGBValue(ColorToRGB(AColor));
      with tmpRGB do
        tmp:=(rgbtBlue+rgbtGreen+rgbtRed) div 3;
      result:=RGB(tmp,tmp,tmp);
    end
    else result:=AColor;
  end;

var tmpMid   : TColor;
    tmpStart : TColor;
    tmpEnd   : TColor;
begin
  tmpMid:=TryGrayColor(MidColor);
  tmpStart:=TryGrayColor(StartColor);
  tmpEnd:=TryGrayColor(EndColor);

  if RoundRectSize>0 then
     ClipRoundRectangle(Canvas,Rect,RoundRectSize);

  if Direction=gdRadial then DrawRadial(Canvas,Rect)
  else
  if IHasMiddle then
  begin
    R:=Rect;

    Case Direction of
    gdTopBottom: DoVert(tmpMid,tmpEnd,tmpStart,tmpMid);
    gdBottomTop: DoVert(tmpStart,tmpMid,tmpMid,tmpEnd);
    gdLeftRight: DoHoriz(tmpMid,tmpEnd,tmpStart,tmpMid);
    gdRightLeft: DoHoriz(tmpStart,tmpMid,tmpMid,tmpEnd);
    else
       Canvas.GradientFill(Rect,tmpStart,tmpEnd,Direction)
    end;
  end
  else
     Canvas.GradientFill(Rect,tmpStart,tmpEnd,Direction,Balance);

  if RoundRectSize>0 then Canvas.UnClipRectangle;
end;

procedure TCustomTeeGradient.SetRadialX(const Value: Integer);
begin
  SetIntegerProperty(FRadialX,Value);
end;

procedure TCustomTeeGradient.SetRadialY(const Value: Integer);
begin
  SetIntegerProperty(FRadialY,Value);
end;

procedure TCustomTeeGradient.Draw(Canvas: TTeeCanvas; var P: TFourPoints);
begin
  ClipPolygon(Canvas,P,4);
  Draw(Canvas,RectFromPolygon(P,4));
  Canvas.UnClipRectangle;
end;

Procedure TCustomTeeGradient.Draw(Canvas:TCanvas3D; var P:TFourPoints; Z:Integer);
var P2 : TFourPoints;
begin
  P2[0]:=Canvas.Calculate3DPosition(P[0],Z);
  P2[1]:=Canvas.Calculate3DPosition(P[1],Z);
  P2[2]:=Canvas.Calculate3DPosition(P[2],Z);
  P2[3]:=Canvas.Calculate3DPosition(P[3],Z);
  Draw(Canvas,P2);
end;

{ TTeeFont }
Constructor TTeeFont.Create(ChangedEvent:TNotifyEvent);
begin
  inherited Create;
  Color:=clBlack;
  IDefColor:=clBlack;
  {$IFNDEF CLX}
  CharSet:=DEFAULT_CHARSET;
  {$ENDIF}
  Name:=GetDefaultFontName;
  if Size<>GetDefaultFontSize then // 6.01
     Size:=GetDefaultFontSize;
  OnChange:=ChangedEvent; { at the create end... 5.02 }
end;

Destructor TTeeFont.Destroy;
begin
  FOutLine.Free;
  FShadow.Free;
  FGradient.Free;
{ 5.01 removed, ICanvas might be corrupt in some circumstances }
{  if Assigned(ICanvas) and (ICanvas.IFont=Self) then ICanvas.IFont:=nil; }
  inherited;
end;

Procedure TTeeFont.Assign(Source:TPersistent);
begin
  if Source is TTeeFont then
  With TTeeFont(Source) do
  begin
    Self.Gradient      :=FGradient;
    Self.FInterCharSize:=FInterCharSize;
    Self.OutLine       :=FOutLine;
    Self.Shadow        :=FShadow;
  end;
  inherited;
end;

Procedure TTeeFont.SetInterCharSize(Value:Integer);
begin
  if Value<>FInterCharSize then
  begin
    FInterCharSize:=Value;
    if Assigned(OnChange) then OnChange(Self);
  end;
end;

function TTeeFont.GetOutLine: TChartHiddenPen;
begin
  if not Assigned(FOutLine) then
     FOutLine:=TChartHiddenPen.Create(OnChange);
  result:=FOutLine;
end;

Procedure TTeeFont.SetOutLine(Value:TChartHiddenPen);
begin
  if Assigned(Value) then OutLine.Assign(Value)
                     else FreeAndNil(FOutLine);
end;

Function TTeeFont.GetShadow:TTeeShadow;
begin
  if not Assigned(FShadow) then
     FShadow:=TTeeShadow.Create(OnChange);
  result:=FShadow;
end;

Procedure TTeeFont.SetShadow(Value:TTeeShadow);
begin
  if Assigned(Value) then Shadow.Assign(Value)
                     else FreeAndNil(FShadow);
end;

function TTeeFont.IsHeightStored: Boolean;
begin
  result:=Size<>GetDefaultFontSize;
end;

function TTeeFont.IsNameStored: Boolean;
begin
  result:=Name<>GetDefaultFontName;
end;

function TTeeFont.IsStyleStored: Boolean;
begin
  result:=Style<>IDefStyle;
end;

Function TTeeFont.IsColorStored:Boolean;
begin
  result:=Color<>IDefColor;
end;

function TTeeFont.GetGradient: TTeeFontGradient;
begin
  if not Assigned(FGradient) then
     FGradient:=TTeeFontGradient.Create(OnChange);
  result:=FGradient;
end;

procedure TTeeFont.SetGradient(const Value: TTeeFontGradient);
begin
  if Assigned(Value) then Gradient.Assign(Value)
                     else FreeAndNil(FGradient);
end;

{ Util functions }
Procedure SwapDouble(Var a,b:Double);
var tmp : Double;
begin
  tmp:=a; a:=b; b:=tmp;
end;

Procedure SwapInteger(Var a,b:Integer);
var tmp : Integer;
Begin
  tmp:=a; a:=b; b:=tmp;
end;

{ TTeeButton }
{$IFNDEF CLX}
procedure TTeeButton.WMPaint(var Message: TWMPaint);
begin
  ControlState:=ControlState+[csCustomPaint];
  inherited;
  ControlState:=ControlState-[csCustomPaint];
end;

procedure TTeeButton.PaintWindow(DC: HDC);
var tmp : TTeeCanvas;
begin
  inherited;
  if Assigned(Instance) then
  begin
    tmp:=TTeeCanvas3D.Create;
    with tmp do
    try
      ReferenceCanvas:=TCanvas.Create;
      try
        ReferenceCanvas.Handle:=DC;
        DrawSymbol(tmp);
      finally
        ReferenceCanvas.Free;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TTeeButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Repaint;
end;
{$ELSE}
procedure TTeeButton.Painting(Sender: QObjectH; EventRegion: QRegionH);
var tmp : TTeeCanvas3D;
begin
  inherited;
  if Assigned(Instance) then
  begin
    tmp:=TTeeCanvas3D.Create;
    with tmp do
    try
      ReferenceCanvas:=TQtCanvas.Create;
      try
        ReferenceCanvas.Handle:=Handle;
        {$IFNDEF LINUX}  // Kylix bug
        DrawSymbol(tmp);
        {$ENDIF}
      finally
        ReferenceCanvas.Free;
      end;
    finally
      Free;
    end;
  end;
end;
{$ENDIF}

procedure TTeeButton.LinkProperty(AInstance: TObject;
  const PropName: String);
begin
  Instance:=AInstance;
  if Assigned(Instance) then
  begin
    if PropName='' then
       Info:=nil
    else
       Info:=GetPropInfo(Instance{$IFNDEF D5}.ClassInfo{$ENDIF},PropName);
    Invalidate;  // 5.02
  end;
end;

{$IFNDEF D5}
procedure FreeAndNil(var Obj);
var P : TObject;
begin
  P:=TObject(Obj);
  TObject(Obj):=nil;
  P.Free;
end;
{$ENDIF}

Procedure TeeDefaultFont;
Begin
  GetDefaultFontSize:=StrToInt(TeeMsg_DefaultFontSize);

  {$IFNDEF CLX}
  if (GetDefaultFontSize=8) and (SysLocale.PriLangID=LANG_JAPANESE) then
      GetDefaultFontSize:=-MulDiv(DefFontData.Height,72,Screen.PixelsPerInch);
  {$ENDIF}

  GetDefaultFontName:=TeeMsg_DefaultFontName;

  {$IFNDEF CLX}
  if (GetDefaultFontName='Arial') and (SysLocale.PriLangID=LANG_JAPANESE) then  { <-- do not translate }
      GetDefaultFontName:=DefFontData.Name;
  {$ENDIF}
end;

type
  TRGBTripleArray=packed array[0..0] of TRGBTriple;

procedure TeeBlendBitmaps(Const Percent: Double; ABitmap,BBitmap:TBitmap; BOrigin:TPoint);
Const BytesPerPixel={$IFDEF CLX}4{$ELSE}3{$ENDIF};

{$IFNDEF D5}
type PColor = ^TColor;
{$ENDIF}

var tmpX     : Integer;
    tmpY     : Integer;
    tmpW     : Integer;
    tmpH     : Integer;
    {$IFDEF CLX}
    tmpScanA : ^TRGBTripleArray;
    tmpScanB : ^TRGBTripleArray;
    {$ELSE}
    tmpScanA : PByteArray;
    tmpScanB : PByteArray;
    Line0A   : PByteArray;
    Line0B   : PByteArray;
    DifA     : Integer;
    DifB     : Integer;
    {$ENDIF}
    tmpXB3   : Integer;
    p        : PChar;
    pc       : PChar;
    Percent1 : Integer;
begin
  ABitmap.PixelFormat:=TeePixelFormat;
  BBitmap.PixelFormat:=TeePixelFormat;

  if BOrigin.Y<0 then BOrigin.Y:=0;
  if BOrigin.X<0 then BOrigin.X:=0;

  tmpW:=Math.Min(ABitmap.Width,BBitmap.Width-BOrigin.X);
  tmpH:=Math.Min(ABitmap.Height,BBitmap.Height-BOrigin.Y);

  if (tmpW>1) and (tmpH>1) then
  begin
    Percent1:=100-Round(Percent);

    {$IFNDEF CLX}
    Line0A:=ABitmap.ScanLine[0];
    Line0B:=BBitmap.ScanLine[BOrigin.Y];
    DifA:=Integer(ABitmap.ScanLine[1])-Integer(Line0A);
    DifB:=Integer(BBitmap.ScanLine[BOrigin.Y+1])-Integer(Line0B);
    {$ENDIF}

    for tmpY:=0 to tmpH-1 do
    begin
      {$IFNDEF CLX}
      // faster version
      tmpScanA:=PByteArray(Integer(Line0A)+DifA*tmpY);
      tmpScanB:=PByteArray(Integer(Line0B)+DifB*tmpY);
      {$ELSE}
      // slower (safer?) version
      tmpScanA:=ABitmap.ScanLine[tmpY];
      tmpScanB:=BBitmap.ScanLine[tmpY+BOrigin.Y];
      {$ENDIF}

      for tmpX:=0 to tmpW-1 do
      begin
        tmpXB3:=(tmpX+BOrigin.X){$IFNDEF CLX}*BytesPerPixel{$ENDIF};
        pc:=@tmpScanB[tmpXB3];

        if PColor(pc)^=$FFFFFF then  // Already white color
           {$IFDEF CLX}
           tmpScanB[tmpXB3].rgbtBlue:=$FF-1;
           {$ELSE}
           tmpScanB[tmpXB3+2]:=$FF-1;
           {$ENDIF}

        {$IFDEF CLX}
        p:=@tmpScanA[tmpX];
        {$ELSE}
        p:=@tmpScanA[tmpX*BytesPerPixel];
        {$ENDIF}

        PByte(pc)^:=Byte(pc^)+((Percent1*(Byte(p^)-Byte(pc^))) div 100);
        Inc(pc);
        PByte(pc)^:=Byte(pc^)+((Percent1*(Byte((p+1)^)-Byte(pc^))) div 100);
        Inc(pc);
        PByte(pc)^:=Byte(pc^)+((Percent1*(Byte((p+2)^)-Byte(pc^))) div 100);
      end;
    end;

  end;
end;

type TCanvasAccess=class(TTeeCanvas3D);

{ TTeeBlend }
Constructor TTeeBlend.Create(ACanvas: TTeeCanvas; const R: TRect);
begin
  inherited Create;
  FCanvas:=ACanvas;
  SetRectangle(R);
end;

Destructor TTeeBlend.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

Procedure TTeeBlend.SetRectangle(Const R:TRect);
var tmp  : TCanvas;
    tmpW : Integer;
    tmpH : Integer;
begin
  FRect:=OrientRectangle(R);
  with FRect do
  begin
    if Left<0 then Left:=0;
    if Top<0 then Top:=0;
    if Right<0 then Right:=0;
    if Bottom<0 then Bottom:=0;
    tmpW:=Right-Left;
    tmpH:=Bottom-Top;
  end;

  IValidSize:=(tmpW>0) and (tmpH>0);

  if IValidSize then
  begin
    FBitmap.Free;
    FBitmap:=TBitmap.Create;

    With FBitmap do
    begin
      {$IFNDEF CLX}
      IgnorePalette:=True;
      {$ENDIF}
      PixelFormat:=TeePixelFormat;
      Width:=tmpW;
      Height:=tmpH;
      if Assigned(TCanvasAccess(FCanvas).Bitmap) then
         tmp:=TCanvasAccess(FCanvas).Bitmap.Canvas
      else
         tmp:=FCanvas.ReferenceCanvas;

      Canvas.CopyRect( TeeRect(0,0,tmpW,tmpH), tmp, FRect );
    end;
  end;
end;

procedure TTeeBlend.DoBlend(Transparency: TTeeTransparency);
var tmp       : TBitmap;
    tmpNew    : Boolean;
    tmpPoint  : TPoint;
    {$IFNDEF CLX}
    tmpAlign  : TCanvasTextAlign;
    {$ENDIF}
begin
  if IValidSize then
  begin
    tmp:=TCanvasAccess(FCanvas).Bitmap;

    tmpNew:=not Assigned(tmp);

    if tmpNew then
    begin
      tmp:=TBitmap.Create;
      {$IFNDEF CLX}
      tmp.IgnorePalette:=True;
      {$ENDIF}
      tmp.Width:=FRect.Right-FRect.Left;
      tmp.Height:=FRect.Bottom-FRect.Top;
      { 5.03 fixed. (Blend inverted rect params) }
      tmp.Canvas.CopyRect(TeeRect(0,0,tmp.Width,tmp.Height),FCanvas.ReferenceCanvas,FRect);
      tmpPoint:=TeePoint(0,0);
    end
    else tmpPoint:=FRect.TopLeft;

    {$IFDEF CLX}
    FCanvas.ReferenceCanvas.Stop;
    {$ELSE}
    tmpAlign:=FCanvas.TextAlign;
    {$ENDIF}

    TeeBlendBitmaps(100-Transparency,FBitmap,tmp,tmpPoint);

    {$IFNDEF CLX}
    if FCanvas.TextAlign<>tmpAlign then
    begin
      if Assigned(FCanvas.IFont) then
         FCanvas.AssignFont(FCanvas.IFont);
      FCanvas.TextAlign:=tmpAlign;
    end;
    {$ENDIF}

    if tmpNew then
    begin
      FCanvas.Draw(FRect.Left,FRect.Top,tmp);
      tmp.Free;
    end;
  end;
end;

{$IFDEF CLX}
{ TUpDown }

Constructor TUpDown.Create(AOwner:TComponent);
begin
  inherited;
  Height:=22;
end;

procedure TUpDown.Change(AValue: Integer);
begin
  inherited;
  if (not IChangingText) and
     Assigned(FAssociate) and
     (not (csDesigning in FAssociate.ComponentState)) and
     (FAssociate is TCustomEdit) then
  begin
    DoChangeEdit;
    if Assigned(OldChanged) then OldChanged(FAssociate);
  end;
end;

procedure TUpDown.ChangedEdit(Sender: TObject);
begin
  if not IChangingText then
  begin
    if TCustomEdit(Sender).Text='' then
       Value:=Min
    else
    begin
      IChangingText:=True;
      Value:=StrToIntDef(TCustomEdit(Sender).Text,Value);
      IChangingText:=False;
    end;
  end;
  if Assigned(OldChanged) then OldChanged(FAssociate);
end;

function TUpDown.GetPosition: Integer;
begin
  result:=Value;
end;

type TCustomEditAccess=class(TCustomEdit);

procedure TUpDown.Loaded;
begin
  inherited;
  Height:=23;
  Width:=18;
  GetOldChanged;
end;

Procedure TUpDown.GetOldChanged;
begin
  if Assigned(FAssociate) and
     (FAssociate is TCustomEdit) and
     (not (csDesigning in FAssociate.ComponentState)) then
  begin
    ChangedEdit(TCustomEdit(FAssociate));     
    if @OldChanged=nil then
    begin
      OldChanged:=TCustomEditAccess(FAssociate).OnChange;
      TCustomEditAccess(FAssociate).OnChange:=ChangedEdit;
    end;
  end;
end;

procedure TUpDown.SetAssociate(const AValue: TComponent);
begin
  if Assigned(FAssociate) and
     (FAssociate is TCustomEdit) and
     (not (csDesigning in FAssociate.ComponentState)) and
     (not Assigned(AValue)) then
       TCustomEditAccess(FAssociate).OnChange:=OldChanged;

  FAssociate:=AValue;
//  GetOldChanged;
end;

procedure TUpDown.SetPosition(const AValue: Integer);
begin
  Value:=AValue;
  if Assigned(Associate) and (Associate is TCustomEdit) then
     DoChangeEdit;
end;

Procedure TUpDown.DoChangeEdit;
begin
  IChangingText:=True;
  try
    TCustomEdit(Associate).Text:=IntToStr(Value);
  finally
    IChangingText:=False;
  end;
end;
{$ENDIF}

{ This procedure will convert all pixels in ABitmap to
  levels of gray }
Procedure TeeGrayScale(ABitmap:TBitmap; Inverted:Boolean; AMethod:Integer);
Var RGB : ^TRGBTripleArray;
    x   : Integer;
    y   : Integer;
    tmp : Integer;
begin
  With ABitmap do
  begin
    PixelFormat:=TeePixelFormat;
    for y:=Height-1 downto 0 do
    begin
      RGB:=ScanLine[y];
      for x:=0 to Width-1 do
      {$R-}
      With RGB[x] do
      begin

        if AMethod=0 then
           tmp:=(rgbtBlue+rgbtGreen+rgbtRed) div 3
        else
           tmp:=Round( (0.30*rgbtRed) +
                       (0.59*rgbtGreen) +
                       (0.11*rgbtBlue));

        // tmp:=(11*rgbtRed+16*rgbtGreen+5*rgbtBlue) div 32  // faster ?

        if Inverted then tmp:=255-tmp;
        rgbtBlue:=tmp;
        rgbtGreen:=tmp;
        rgbtRed:=tmp;
      end;
    end;
    {$IFNDEF CLX}
    PixelFormat:=pfDevice; { for non-24bit color displays }
    {$ENDIF}
  end;
end;

{ EditColor }
Function EditColor(AOwner:TComponent; AColor:TColor):TColor;
Begin
  With TColorDialog.Create(AOwner) do
  try
    Color:=AColor;
    if not Assigned(TeeCustomEditColors) then
       TeeCustomEditColors:=TStringList.Create
    else
       CustomColors:=TeeCustomEditColors;
    if Execute then
    begin
      TeeCustomEditColors.Assign(CustomColors);
      result:=Color;
    end
    else result:=AColor;
  finally
    Free;
  end;
end;

{ Show the TColorDialog, return True if color changed }
Function EditColorDialog(AOwner:TComponent; var AColor:TColor):Boolean;
var tmpNew : TColor;
begin
  tmpNew:=EditColor(AOwner,AColor);
  result:=tmpNew<>AColor;
  if result then AColor:=tmpNew;
end;

{ TButtonColor }
procedure TButtonColor.Click;
var tmp : TColor;
begin
  if Assigned(Instance) then
  begin
    tmp:=GetTeeColor;
    if EditColorDialog(Self,tmp) then
    begin
      SetOrdProp(Instance,Info,tmp);
      Repaint;
      inherited;
    end;
  end
  else inherited;
end;

Function TButtonColor.GetTeeColor:TColor;
begin
  if Assigned(GetColorProc) then
     result:=GetColorProc
  else
  if Assigned(Info) then result:=ColorToRGB(GetOrdProp(Instance,Info)) { 5.03 }
                    else result:=clNone;
end;

procedure TButtonColor.DrawSymbol(ACanvas:TTeeCanvas);
Const tmpWidth={$IFDEF CLX}15{$ELSE}19{$ENDIF};
var  tmp : Integer;
begin
  With ACanvas do
  begin
    Brush.Color:=GetTeeColor;
    if Brush.Color<>clNone then
    begin
      if not Enabled then Pen.Style:=psClear;
      tmp:=Height div 4;
      Rectangle(Width-tmpWidth,Height-3*tmp,Width-6,Height-tmp);
    end;
  end;
end;

{ TComboFlat }
{$IFNDEF CLX}
procedure TComboFlat.WMPaint(var Message: TWMPaint);
var R: TRect;
begin
  inherited;
  if (not Inside) and (not Focused) then
  begin
    with TControlCanvas.Create do
    try
      Control:=Self;
      Pen.Color:=clBtnFace;
      Brush.Style:=bsClear;
      R:=ClientRect;

      {$IFNDEF D5}
      with R do Rectangle(Left,Top,Right,Bottom);
      {$ELSE}
      Rectangle(R);
      {$ENDIF}

      InflateRect(R,-1,-1);

      {$IFNDEF D5} 
      with R do Rectangle(Left,Top,Right,Bottom);
      {$ELSE}
      Rectangle(R);
      {$ENDIF}

      R.Left:=R.Right-GetSystemMetrics(SM_CXSIZE)-2;

      Inc(R.Top);
      Dec(R.Bottom);
      Pen.Color:=clWindow;

      {$IFNDEF D5}
      with R do Rectangle(Left,Top,Right,Bottom);
      {$ELSE}
      Rectangle(R);
      {$ENDIF}

      MoveTo(R.Right-2,R.Top);
      LineTo(R.Right-2,R.Bottom);
    finally
      Free;
    end;
  end;
end;

procedure TComboFlat.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Inside:=True;
  Repaint;
end;

procedure TComboFlat.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Inside:=False;
  Repaint;
end;

procedure TComboFlat.CMFocusChanged(var Message: TCMFocusChanged);
begin
  inherited;
  Inside:=False;
  Repaint;
end;
{$ENDIF}

{ TTeeFontGradient }

procedure TTeeFontGradient.SetOutline(const Value: Boolean);
begin
  SetBooleanProperty(FOutline,Value);
end;

Procedure TTeeFontGradient.SetBooleanProperty( Var Variable:Boolean;
                                               Const Value:Boolean);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    if Assigned(IChanged) then IChanged(Self);
  end;
end;

{ TWhitePen }
constructor TWhitePen.Create(OnChangeEvent: TNotifyEvent);
begin
  inherited;
  Color:=clWhite;
end;

constructor TComboFlat.Create(AOwner: TComponent);
begin
  inherited;
  Height:=21;
  ItemHeight:=13;
  Style:=csDropDownList;
end;

// Returns point "ATo" minus ADist pixels from AFrom point.
Function PointAtDistance(AFrom,ATo:TPoint; ADist:Integer):TPoint;
var tmpSin : Extended;
    tmpCos : Extended;
begin
  result:=ATo;
  if ATo.X<>AFrom.X then
  begin
    SinCos(Math.ArcTan2((ATo.Y-AFrom.Y),(ATo.X-AFrom.X)),tmpSin,tmpCos);
    Dec(result.X,Round(ADist*tmpCos));
    Dec(result.Y,Round(ADist*tmpSin));
  end
  else
  begin
    if ATo.Y<AFrom.Y then Inc(result.Y,ADist)
                     else Dec(result.Y,ADist);
  end;
end;

Function TeeDistance(x,y:Integer):Double;
begin
  result:=Sqrt(Sqr(x)+Sqr(y));
end;

initialization
  {$IFNDEF CLX}
  IsWindowsNT:=Win32Platform=VER_PLATFORM_WIN32_NT;
  OldRegion:=CreateRectRgn(0,0,0,0);
  {$ELSE}
//  OldRegion:=QRegion_create(0,0,0,0,QRegionRegionType_Rectangle);
  {$ENDIF}
  TeeDefaultFont;
  {$IFDEF D6}
  ActivateClassGroup(TControl);
  {$ENDIF}
finalization
  {$IFDEF CLX}
//  if Assigned(OldRegion) then QRegion_destroy(OldRegion);
  {$ELSE}
  if OldRegion>0 then DeleteObject(OldRegion);
  {$ENDIF}
  TeeCustomEditColors.Free;
end.
