{******************************************}
{    TeeChart Pro OpenGL Canvas            }
{ Copyright (c) 1998-2003 by David Berneda }
{       All Rights Reserved                }
{******************************************}
unit TeeGLCanvas;
{$I TeeDefs.inc}

{$IFOPT D-}
{$C-}  { Turn off assertions }
{$ENDIF}

interface

uses
   {$IFNDEF LINUX}
   Windows, Messages,
   {$ENDIF}
   SysUtils, Classes,
   {$IFDEF CLX}
   Qt, QGraphics, QControls, Types,
   {$ELSE}
   Graphics, Controls,
   {$ENDIF}
   {$IFDEF LINUX}
   OpenGLLinux,
   {$ELSE}
   OpenGL2,
   {$ENDIF}
   TeeConst, TeCanvas;

type  GLMat=Array[0..3] of GLFloat;

      {$IFDEF LINUX}
      PGLUQuadricObj=GLUQuadricObj;
      {$ENDIF}

var   TeeOpenGLFontExtrusion : Integer=0;

      TeeOpenGLFontName      : PChar=TeeMsg_DefaultEngFontName; //'Microsoft Sans Serif';

      TeeMaterialAmbient     : Double=1;
      TeeMaterialDiffuse     : Double=1;
      TeeMaterialSpecular    : Double=1;

      TeeFullLightModel :GLENum= GL_FALSE;
      TeeLightLocal     :GLENum= GL_FALSE;
      TeeColorPlanes    :GLENum= GL_FRONT_AND_BACK;

      TeeTextAngleY  : Integer=0;
      TeeTextAngleZ  : Integer=0;

      TeeDefaultLightSpot:Integer=180;

      TeeSphereSlices:Integer = 16;
      TeeSphereStacks:Integer = 16;

      TeeSmooth : Boolean = False;
      TeeSmoothQuality : GLEnum = GL_FASTEST;

      TeePerspectiveQuality : GLEnum = GL_NICEST;

const TeeFontListRange  = 128-32+1;

type
    TGLCanvas = class(TCanvas3D)
    private
      { Private declarations }
      FBackColor     : TColor;
      FBackMode      : TCanvasBackMode;

      FDepth         : Integer;
      FTextAlign     : Integer;

      FWidth         : Integer;
      FHeight        : Integer;
      FXCenter       : Integer;
      FYCenter       : Integer;

      FOnInit        : TNotifyEvent;

      { internal }
      FDC            : TTeeCanvasHandle;

      HRC            : HGLRC;
      FX             : Integer;
      FY             : Integer;
      FZ             : Integer;
      FIs3D          : Boolean;

      { fonts }
      TheFontHandle  : Integer;
      FontOffset     : Integer;
      IFontCreated   : Boolean;

      FUseBuffer     : Boolean;
      IDestCanvas    : TCanvas;
      IDrawToBitmap  : Boolean;
      FSavedError    : GLEnum;
      FQuadric       : PGLUQuadricObj;

      Function CalcPerspective:Double;
      Function CalcZoom:Double;
      Procedure DeleteTextures;
      Procedure DestroyGLContext;
      Procedure DoProjection;
      Procedure EndBrushBitmap;
      Function FindTexture(ABitmap:TBitmap):{$IFDEF LINUX}GLBoolean{$ELSE}GLUInt{$ENDIF};
      {$IFNDEF LINUX}
      Function GetDCHandle:HDC;
      {$ENDIF}
      Procedure InitMatrix;
      procedure SetBrushBitmap;
      Procedure SetColor(AColor:TColor);
      Procedure SetPen;
      Procedure TeeVertex2D(x,y:Integer);
      Procedure TeeVertex3D(x,y,z:Integer);
      Procedure TeeNormal(x,y,z:Integer);
      procedure InternalCylinder(Vertical:Boolean; Left,Top,Right,Bottom,
                          Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
    protected
      { Protected declarations }
      {$IFNDEF LINUX}
      Procedure CreateFontOutlines;
      {$ENDIF}
      Procedure InitOpenGLFont;
      Procedure InitAmbientLight(AmbientLight:Integer);
      Procedure InitLight(Num:Integer; Const AColor:GLMat; Const X,Y,Z:Double);
      Procedure SetShininess(Const Value:Double);
      procedure SetDrawStyle(Value:TTeeCanvasSurfaceStyle);
    public
      FontOutlines   : Boolean;
      ShadeQuality   : Boolean;
      DrawStyle      : TTeeCanvasSurfaceStyle;

      { Public declarations }
      Constructor Create;
      Destructor Destroy; override;

      Function CheckGLError:Boolean;
      Procedure DeleteFont;
      Procedure Repaint;

      { 2d }
      Function GetSupports3DText:Boolean; override;
      Function GetSupportsFullRotation:Boolean; override;
      Function GetTextAlign:TCanvasTextAlign; override;
      Function GetUseBuffer:Boolean; override;
      Procedure SetUseBuffer(Value:Boolean); override;
      Function GetHandle:TTeeCanvasHandle; override;
      procedure SetPixel(X, Y: Integer; Value: TColor); override;

      { 3d }
      Procedure EnableRotation;
      Procedure DisableRotation;
      Procedure SetMaterialColor;

      procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;

      Procedure SetBackMode(Mode:TCanvasBackMode); override;
      Function GetMonochrome:Boolean; override;
      Function GetPixel(x,y:Integer):TColor; override;
      Procedure SetMonochrome(Value:Boolean); override;
      Procedure SetBackColor(Color:TColor); override;
      Function GetBackMode:TCanvasBackMode; override;
      Function GetBackColor:TColor; override;
      Procedure SetTextAlign(Align:TCanvasTextAlign); override;

      Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
      procedure EndBlending(Blend:TTeeBlend); override;

      procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
      procedure Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                       Const StartAngle,EndAngle,HolePercent:Double); override;
      procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
      procedure EraseBackground(const Rect: TRect); override;
      procedure FillRect(const Rect: TRect); override;
      procedure Frame3D( var Rect: TRect; TopColor,BottomColor: TColor;
                         Width: Integer); override;
      procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
      procedure LineTo(X,Y:Integer); override;
      procedure MoveTo(X,Y:Integer); override;
      procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
      procedure Rectangle(X0,Y0,X1,Y1:Integer); override;
      procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
      procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
      Procedure TextOut(X,Y:Integer; const Text:String); override;
      Procedure DoHorizLine(X0,X1,Y:Integer); override;
      Procedure DoVertLine(X,Y0,Y1:Integer); override;
      procedure ClipRectangle(Const Rect:TRect); override;
      procedure ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer); override;
      procedure UnClipRectangle; override;
      Procedure GradientFill( Const Rect:TRect;
                              StartColor,EndColor:TColor;
                              Direction:TGradientDirection;
                              Balance:Integer=50); override;
      procedure RotateLabel(x,y:Integer; Const St:String; RotDegree:Integer); override;
      procedure RotateLabel3D(x,y,z:Integer;
                              Const St:String; RotDegree:Integer); override;
      Procedure Invalidate; override;
      Procedure Line(X0,Y0,X1,Y1:Integer); override;
      Procedure Polygon(const Points: array of TPoint); override;
      { 3d }
      Procedure Calculate2DPosition(Var x,y:Integer; z:Integer); override;
      Function Calculate3DPosition(x,y,z:Integer):TPoint; override;
      Procedure Projection(MaxDepth:Integer; const Bounds,Rect:TRect); override;
      Function InitWindow( DestCanvas:TCanvas;
                           A3DOptions:TView3DOptions;
                           ABackColor:TColor;
                           Is3D:Boolean;
                           Const UserRect:TRect):TRect; override;
      Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
      Function ReDrawBitmap:Boolean; override;
      Procedure Arrow( Filled:Boolean;
                       Const FromPoint,ToPoint:TPoint;
                       ArrowWidth,ArrowHeight,Z:Integer); override;
      Procedure Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean); override;
      procedure Cylinder(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; DarkCover:Boolean); override;
      procedure EllipseWithZ(X1, Y1, X2, Y2, Z:Integer); override;
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
                       DarkSides,DrawSides:Boolean;
                       DonutPercent:Integer=0); override;
      procedure Plane3D(Const A,B:TPoint; Z0,Z1:Integer); override;
      procedure PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer); override;
      procedure PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer); override;
      procedure PolygonWithZ(Points: array of TPoint; Z:Integer); override;
      procedure Polyline(const Points:{$IFDEF D5}array of TPoint{$ELSE}TPointArray{$ENDIF}); override; // 6.0
      procedure Pyramid(Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer; DarkSides:Boolean); override;
      Procedure PyramidTrunc(Const R:TRect; StartZ,EndZ:Integer;
                             TruncX,TruncZ:Integer); override;
      Procedure RectangleWithZ(Const Rect:TRect; Z:Integer); override;
      Procedure Surface3D( Style:TTeeCanvasSurfaceStyle;
                           SameBrush:Boolean;
                           NumXValues,NumZValues:Integer;
                           CalcPoints:TTeeCanvasCalcPoints ); override;
      Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
      procedure Triangle3D(Const Points:TTrianglePoints3D; Const Colors:TTriangleColors3D); override;
      procedure TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer); override;
      Procedure VertLine3D(X,Top,Bottom,Z:Integer); override;
      Procedure ZLine3D(X,Y,Z0,Z1:Integer); override;

      procedure Sphere(x,y,z:Integer; Const Radius:Double); override;
      procedure Cone(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer); override;

      { events }
      property OnInit:TNotifyEvent read FOnInit write FOnInit;
    published
    end;

Procedure ColorToGL(AColor:TColor; Var C:GLMat);

implementation

Uses Math;

Const TeeZoomScale     = -80000;
      TeeSolidCubeList =   8888;
      TeeWireCubeList  = TeeSolidCubeList+1;

var ITransp:Single=1;

Function MinInteger(a,b:Integer):Integer;
begin
  if a>b then result:=b else result:=a;
end;

Procedure ColorToGL(AColor:TColor; Var C:GLMat);
begin
  AColor:=ColorToRGB(AColor);
  C[0]:=Byte(AColor)/255;
  C[1]:=Byte(AColor shr 8)/255;
  C[2]:=Byte(AColor shr 16)/255;
  C[3]:=ITransp;
end;

{ TGLCanvas }
Constructor TGLCanvas.Create;
begin
  inherited Create;
  FSavedError:=GL_NO_ERROR;

(*
  // not necessary
  FUseBuffer:=False;
  IDestCanvas:=nil;
  IFontCreated:=False;
  FontOutlines:=False;
  Wireframe:=tcsSolid;
  FX:=0;
  FY:=0;
  FZ:=0;
  FIs3D:=False;
  HRC:=0;
  FQuadric:=nil;
*)

  FontZoom:=100;
  TheFontHandle:=-1;
  FTextAlign:=TA_LEFT;
end;

Procedure TGLCanvas.DestroyGLContext;
begin
  DeleteFont;

  if HRC<>0 then
  begin

    {$IFNDEF LINUX}
    DeactivateRenderingContext;
    DestroyRenderingContext(HRC);
    {$ENDIF}

    HRC:=0;
//    Assert(CheckGLError,'DestroyGLContext');
  end;
end;

Destructor TGLCanvas.Destroy;
begin
  if Assigned(FQuadric) then gluDeleteQuadric(FQuadric);
  DestroyGLContext;
  DeleteTextures;
  inherited;
end;

Function TGLCanvas.CheckGLError:Boolean;
begin
  FSavedError:=glGetError;
  result:=FSavedError=GL_NO_ERROR;
  if not result then
     FSavedError:=FSavedError+1-1;
end;

Procedure TGLCanvas.Calculate2DPosition(Var x,y:Integer; z:Integer);
begin { nothing yet }
end;

Function TGLCanvas.Calculate3DPosition(x,y,z:Integer):TPoint;
begin
  result:=TeePoint(x,y);
end;

Procedure TGLCanvas.DoProjection;
Var tmp  : Double;
    FarZ : Integer;
begin
  FarZ:=400*(FDepth+1);

  glViewport(0, 0, FWidth, FHeight);
  Assert(CheckGLError,'ViewPort'+IntToStr(FSavedError));

  glMatrixMode(GL_PROJECTION);
  Assert(CheckGLError,'Projection');
  glLoadIdentity;
  Assert(CheckGLError,'ProjectionInit');

  tmp:=100.0/CalcZoom;

  if (not FIs3D) or View3DOptions.Orthogonal then
  begin
    glOrtho(-FXCenter*tmp,FXCenter*tmp,-FYCenter*tmp,FYCenter*tmp,0.1,tmp*FarZ);
    Assert(CheckGLError,'Orthogonal');
  end
  else
  begin
    if tmp<1 then tmp:=1;
    gluPerspective(Math.Max(10,View3DOptions.Perspective),    // Field-of-view angle
                   FWidth/FHeight,  // Aspect ratio of viewing volume
                   0.1,             // Distance to near clipping plane
                   tmp*FarZ);       // Distance to far clipping plane
    Assert(CheckGLError,'Perspective');
  end;

  SetDrawStyle(DrawStyle);
end;

Procedure TGLCanvas.Projection(MaxDepth:Integer; const Bounds,Rect:TRect);
begin
  RectSize(Bounds,FWidth,FHeight);
  RectCenter(Rect,FXCenter,FYCenter);
  FDepth:=MaxDepth;
  DoProjection;
  InitMatrix;
end;

Function TGLCanvas.CalcPerspective:Double;
begin
  if FIs3D and (not View3DOptions.Orthogonal) then
     result:=Math.Max(10,View3DOptions.Perspective)*0.04
  else
     result:=1;
end;

Function TGLCanvas.CalcZoom:Double;
begin
  result:=Math.Max(1,View3DOptions.Zoom)*CalcPerspective;
end;

Procedure TGLCanvas.InitMatrix;
const tmpInv=1/255.0;
var AColor : TColor;
begin
  AColor:=ColorToRGB(FBackColor);
  glClearColor( GetRValue(AColor)*tmpInv,
                GetGValue(AColor)*tmpInv,
                GetBValue(AColor)*tmpInv,
                1);
  Assert(CheckGLError,'ClearColor');

  glDisable(GL_DITHER);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Assert(CheckGLError,'Clear');

  glEnable(GL_DITHER);

  glMatrixMode(GL_MODELVIEW);
  Assert(CheckGLError,'ModelView');
  glLoadIdentity;
  Assert(CheckGLError,'ModelInit');

  With View3DOptions do glTranslatef(HorizOffset,-VertOffset,TeeZoomScale/CalcZoom);

  if ShadeQuality then glShadeModel(GL_SMOOTH)
                  else glShadeModel(GL_FLAT);

  Assert(CheckGLError,'ShadeModel');

  if Assigned(FOnInit) then FOnInit(Self);

  Assert(CheckGLError,'Init');

  With View3DOptions do
  if FIs3D then
  begin
    glRotatef(Tilt, 0, 0, 1);
    if not Orthogonal then glRotatef(-Elevation, 1, 0, 0);
    glRotatef(Rotation, 0, 1, 0);
  end;

  glTranslatef( -FXCenter+RotationCenter.X,
                FYCenter+RotationCenter.Y,
                RotationCenter.Z+(0.5*FDepth));

  Assert(CheckGLError,'Rotations');

  if not Assigned(FQuadric) then FQuadric:=gluNewQuadric;
  if ShadeQuality then gluQuadricNormals(FQuadric,GL_SMOOTH)
                  else gluQuadricNormals(FQuadric,GL_FLAT);
  Assert(CheckGLError,'QuadricNormals');
end;

Procedure TGLCanvas.TeeVertex2D(x,y:Integer);
begin
  glVertex2i(x,-y);
end;

Procedure TGLCanvas.TeeVertex3D(x,y,z:Integer);
begin
  glVertex3i(x,-y,-z);
end;

Procedure TGLCanvas.TeeNormal(x,y,z:Integer);
begin
  glNormal3i(x,y,-z);
end;

Const MaxTextures=10;
Type TTeeTextureBits=Array[0..800*600,0..3] of GLUByte;
     PTeeTextureBits=^TTeeTextureBits;
     TTeeTexture=record
       Bits      : PTeeTextureBits;
       Bitmap    : Pointer;
       GLTexture : {$IFDEF LINUX}GLBoolean{$ELSE}GLUInt{$ENDIF};
     end;

Var ITextures:Array[0..MaxTextures-1] of TTeeTexture;
    NumTextures:Integer=0;

Procedure TGLCanvas.DeleteTextures;
var t:Integer;
begin
  for t:=0 to NumTextures-1 do Dispose(ITextures[t].Bits);
  NumTextures:=0;
end;

Function TGLCanvas.FindTexture(ABitmap:TBitmap):{$IFDEF LINUX}GLBoolean{$ELSE}GLUInt{$ENDIF};
var t,
    tt,
    tmpPos,
    tmpPos2 : Integer;
    tmp     : TColor;
    tmpLine : PByteArray;
begin
  for t:=0 to NumTextures-1 do
  if ITextures[t].Bitmap=ABitmap then
  begin
    result:=ITextures[t].GLTexture;
    exit;
  end;

  if NumTextures<MaxTextures then
  begin
    Inc(NumTextures);
    ITextures[NumTextures-1].Bitmap:=ABitmap;

    New(ITextures[NumTextures-1].Bits);

    With ABitmap do
    begin
      PixelFormat:=TeePixelFormat;

      for t:=0 to Height-1 do
      begin
        tmpLine:=PByteArray(ScanLine[t]);

        for tt:=0 to Width-1 do
        begin
          tmpPos:=t*Height+tt;
          {$IFDEF CLX}
          tmpPos2:=tt*4;
          {$ELSE}
          tmpPos2:=tt*3;
          {$ENDIF}

          With ITextures[NumTextures-1] do
          begin
            bits^[tmpPos,0]:=tmpLine[tmpPos2+2];
            bits^[tmpPos,1]:=tmpLine[tmpPos2+1];
            bits^[tmpPos,2]:=tmpLine[tmpPos2+0];
            bits^[tmpPos,3]:=255;
          end;
        end;
      end;
    end;

    glPixelStorei(GL_UNPACK_ALIGNMENT, 4);

    {$IFNDEF LINUX}
    glGenTextures(1, @ITextures[NumTextures-1].GLTexture);
    glBindTexture(GL_TEXTURE_2D, ITextures[NumTextures-1].GLTexture);
    {$ENDIF}

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

    tmp:=GL_NEAREST;
    //tmp:=GL_LINEAR;
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, tmp);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, tmp);

    glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE);

    With ABitmap do
      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Width, Height, 0,
                   GL_RGBA, GL_UNSIGNED_BYTE, ITextures[NumTextures-1].Bits);

    result:=ITextures[NumTextures-1].GLTexture;
  end
  else result:={$IFDEF LINUX}False{$ELSE}0{$ENDIF};
end;

procedure TGLCanvas.SetBrushBitmap;
begin
  if Brush.Bitmap<>nil then
  begin
    glEnable(GL_TEXTURE_2D);
    {$IFNDEF LINUX}
    glBindTexture(GL_TEXTURE_2D, FindTexture(Brush.Bitmap));
    {$ENDIF}
    gluQuadricTexture(FQuadric,{$IFDEF LINUX}True{$ELSE}GL_TRUE{$ENDIF});
  end;
end;

Procedure TGLCanvas.EndBrushBitmap;
begin
  if Brush.Bitmap<>nil then
  begin
    gluQuadricTexture(FQuadric,{$IFDEF LINUX}False{$ELSE}GL_FALSE{$ENDIF});
    glDisable(GL_TEXTURE_2D);
  end;
end;

Procedure TGLCanvas.Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean);
begin
  glEnable(GL_CULL_FACE);

  if Left>Right then SwapInteger(Left,Right);
  if Top>Bottom then SwapInteger(Top,Bottom);
  if z0>z1 then SwapInteger(z0,z1);

  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;

    glBegin(GL_QUADS);
    TeeNormal( 0, 0, -1);
     glTexCoord2f(1,0);
     TeeVertex3D( Left,  Bottom, z0);
     glTexCoord2f(1,1);
     TeeVertex3D( Right, Bottom, z0);
     glTexCoord2f(0,1);
     TeeVertex3D( Right, Top,    z0);
     glTexCoord2f(0,0);
     TeeVertex3D( Left,  Top,    z0);

    TeeNormal(-1,  0,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Left, Top,    z1);
     glTexCoord2f(0,1);
     TeeVertex3D( Left, Bottom, z1);
     glTexCoord2f(1,1);
     TeeVertex3D( Left, Bottom, z0);
     glTexCoord2f(1,0);
     TeeVertex3D( Left, Top,    z0);

    TeeNormal( 0, 0, 1);
     glTexCoord2f(0,0);
     TeeVertex3D( Right, Top,    z1);
     glTexCoord2f(0,1);
     TeeVertex3D( Right, Bottom, z1);
     glTexCoord2f(1,1);
     TeeVertex3D( Left,  Bottom, z1);
     glTexCoord2f(1,0);
     TeeVertex3D( Left,  Top,    z1);

    TeeNormal( 1,  0,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Right, Bottom, z0);
     glTexCoord2f(0,1);
     TeeVertex3D( Right, Bottom, z1);
     glTexCoord2f(1,1);
     TeeVertex3D( Right, Top,    z1);
     glTexCoord2f(1,0);
     TeeVertex3D( Right, Top,    z0);

    TeeNormal( 0, 1,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Left,  Top, z1);
     glTexCoord2f(0,1);
     TeeVertex3D( Left,  Top, z0);
     glTexCoord2f(1,1);
     TeeVertex3D( Right, Top, z0);
     glTexCoord2f(1,0);
     TeeVertex3D( Right, Top, z1);

    TeeNormal( 0, -1,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Right, Bottom, z0);
     glTexCoord2f(0,1);
     TeeVertex3D( Left,  Bottom, z0);
     glTexCoord2f(1,1);
     TeeVertex3D( Left,  Bottom, z1);
     glTexCoord2f(1,0);
     TeeVertex3D( Right, Bottom, z1);
    glEnd;
    EndBrushBitmap;
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Left,  Bottom, z0);
      TeeVertex3D( Right, Bottom, z0);
      TeeVertex3D( Right, Top,    z0);
      TeeVertex3D( Left,  Top,    z0);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Left,  Top,    z1);
      TeeVertex3D( Left,  Bottom, z1);
      TeeVertex3D( Right, Bottom, z1);
      TeeVertex3D( Right, Top,    z1);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Right, Top,    z0);
      TeeVertex3D( Right, Top,    z1);
      TeeVertex3D( Right, Bottom, z1);
      TeeVertex3D( Right, Bottom, z0);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Left, Top,    z0);
      TeeVertex3D( Left, Bottom, z0);
      TeeVertex3D( Left, Bottom, z1);
      TeeVertex3D( Left, Top,    z1);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Right, Top, z1);
      TeeVertex3D( Right, Top, z0);
      TeeVertex3D( Left,  Top, z0);
      TeeVertex3D( Left,  Top, z1);
    glEnd;
  end;

  glDisable(GL_CULL_FACE);
  Assert(CheckGLError,'Cube');
end;

Procedure TGLCanvas.SetMaterialColor;

  Function GLColor(Const Value:Double):GLMat;
  begin
    result[0]:=Value;
    result[1]:=Value;
    result[2]:=Value;
    result[3]:=1;
  end;

var tmp:GLMat;
begin
  tmp:=GLColor(TeeMaterialDiffuse);
  glMaterialfv(TeeColorPlanes,GL_DIFFUSE,@tmp);
  tmp:=GLColor(TeeMaterialSpecular);
  glMaterialfv(TeeColorPlanes,GL_SPECULAR,@tmp);
  tmp:=GLColor(TeeMaterialAmbient);
  glMaterialfv(TeeColorPlanes,GL_AMBIENT,@tmp);
  Assert(CheckGLError,'Material '+IntToStr(FSavedError));
end;

{$IFNDEF LINUX}
Function TGLCanvas.GetDCHandle:HDC;
begin
  {$IFDEF CLX}
  result:=GetDC(GetActiveWindow);
  {$ELSE}
  result:=FDC;
  {$ENDIF}
end;
{$ENDIF}

Function TGLCanvas.InitWindow( DestCanvas:TCanvas;
                               A3DOptions:TView3DOptions;
                               ABackColor:TColor;
                               Is3D:Boolean;
                               Const UserRect:TRect):TRect;

begin
  if (IDestCanvas<>DestCanvas) or (View3DOptions<>A3DOptions) then
  begin
    IDestCanvas:=DestCanvas;
    View3DOptions:=A3DOptions;

    {$IFNDEF LINUX}
    InitOpenGL;
    {$ENDIF}

    DestroyGLContext;

    FDC:=DestCanvas.Handle;

    {$IFNDEF LINUX}

    {$IFDEF CLX}
    IDrawToBitmap:=False;
    {$ELSE}
    IDrawToBitmap:=GetObjectType(FDC) = OBJ_MEMDC;
    {$ENDIF}

    HRC:=CreateRenderingContext(GetDCHandle,[opDoubleBuffered],24,0);

    ActivateRenderingContext(GetDCHandle,HRC);
    Assert(CheckGLError,'ActivateContext');
    {$ENDIF}

    glEnable(GL_NORMALIZE);
    Assert(CheckGLError,'EnableNormalize');

    glEnable(GL_DEPTH_TEST);
    Assert(CheckGLError,'EnableDepth');
    glDepthFunc(GL_LESS);
    Assert(CheckGLError,'DepthFunc');

    glEnable(GL_LINE_STIPPLE);
    Assert(CheckGLError,'EnableLineStipple');

    glEnable(GL_COLOR_MATERIAL);
    Assert(CheckGLError,'EnableColorMaterial');

    glColorMaterial(TeeColorPlanes,GL_AMBIENT_AND_DIFFUSE);
    Assert(CheckGLError,'ColorMaterial');

    SetMaterialColor;

    {$IFNDEF LINUX}
    //glEnable(GL_POLYGON_OFFSET_LINE);
    glEnable(GL_POLYGON_OFFSET_FILL);
    glPolygonOffset(0.5,1);

    Assert(CheckGLError,'PolygonOffset');
    {$ENDIF}

    // Enable / Disable antialias smoothing:
    if TeeSmooth then
    begin
      glEnable(GL_POLYGON_SMOOTH);
      glEnable(GL_POINT_SMOOTH);
      glEnable(GL_LINE_SMOOTH);
    end
    else
    begin
      glDisable(GL_POLYGON_SMOOTH);
      glDisable(GL_POINT_SMOOTH);
      glDisable(GL_LINE_SMOOTH);
    end;

    glDisable(GL_CULL_FACE);

    glEnable(GL_DITHER);
    Assert(CheckGLError,'Dither');

    glHint(GL_PERSPECTIVE_CORRECTION_HINT, TeePerspectiveQuality);
    glHint(GL_LINE_SMOOTH_HINT, TeeSmoothQuality);
    glHint(GL_POINT_SMOOTH_HINT, TeeSmoothQuality);
    glHint(GL_POLYGON_SMOOTH_HINT, TeeSmoothQuality);

    glLightModelf(GL_LIGHT_MODEL_TWO_SIDE,TeeFullLightModel);
    glLightModelf(GL_LIGHT_MODEL_LOCAL_VIEWER,TeeLightLocal);

    Assert(CheckGLError,'LightModel');
  end;

  FX:=0;
  FY:=0;
  FIs3D:=Is3D;

  {$IFNDEF LINUX}
  if GetObjectType(GetDCHandle) <> OBJ_MEMDC then
  begin
    FDC:=DestCanvas.Handle;

    ActivateRenderingContext(GetDCHandle,HRC);
  end;
  {$ENDIF}

  SetCanvas(DestCanvas);
  FBackColor:=ABackColor;
  result:=UserRect;
end;

Procedure TGLCanvas.InitAmbientLight(AmbientLight:Integer);
var tmp:GLMat;
    tmpNum:Double;
begin
  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
  glDisable(GL_LIGHT1);
  glDisable(GL_LIGHT2);
  Assert(CheckGLError,'DisableLight');

  if AmbientLight>0 then
  begin
    glEnable(GL_LIGHTING);
    Assert(CheckGLError,'EnableLight');
    tmpNum:=AmbientLight*0.01;
    tmp[0]:=tmpNum;
    tmp[1]:=tmpNum;
    tmp[2]:=tmpNum;
    tmp[3]:=1;
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT,  @tmp);
//    glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,  1);
    Assert(CheckGLError,'LightModel');
  end
  else
  begin
    tmp[0]:=0;
    tmp[1]:=0;
    tmp[2]:=0;
    tmp[3]:=1;
    glEnable(GL_LIGHTING);
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT,  @tmp);
    Assert(CheckGLError,'LightModel');
    glDisable(GL_LIGHTING);
    Assert(CheckGLError,'DisableLightModel');
  end;
end;

Procedure TGLCanvas.SetShininess(Const Value:Double);
begin
  glMateriali(TeeColorPlanes, GL_SHININESS, Round(128.0*Value));
  Assert(CheckGLError,'Shininess');
end;

Procedure TGLCanvas.InitLight(Num:Integer; Const AColor:GLMat; Const X,Y,Z:Double);
Const tmpSpec=0.9;
      tmpDif =0.9;
      tmpAmb =0.2;
var tmp : GLMat;
begin
  glEnable(GL_LIGHTING);
  glEnable(Num);
  Assert(CheckGLError,'EnableLight '+IntToStr(Num));

  tmp[0]:=tmpAmb;
  tmp[1]:=tmpAmb;
  tmp[2]:=tmpAmb;
  tmp[3]:=1;
  tmp:=AColor;
  glLightfv(Num,GL_AMBIENT, @tmp);
  Assert(CheckGLError,'LightAmbient '+IntToStr(Num));

  tmp[0]:=tmpDif;
  tmp[1]:=tmpDif;
  tmp[2]:=tmpDif;
  tmp[3]:=1;
  glLightfv(Num,GL_DIFFUSE, @tmp);
  Assert(CheckGLError,'LightDiffuse '+IntToStr(Num));

  tmp[0]:=tmpSpec;
  tmp[1]:=tmpSpec;
  tmp[2]:=tmpSpec;
  tmp[3]:=1;
  glLightfv(Num,GL_SPECULAR, @tmp);
  Assert(CheckGLError,'LightSpecular '+IntToStr(Num));

  tmp[0]:=  X;
  tmp[1]:= -Y;
  tmp[2]:= -Z;
  tmp[3]:=1;
  glLightfv(Num,GL_POSITION, @tmp);
  Assert(CheckGLError,'LightPosition '+IntToStr(Num));

  glLighti(Num,GL_SPOT_CUTOFF,TeeDefaultLightSpot);
  Assert(CheckGLError,'LightSpot '+IntToStr(Num));

//  glLighti(Num,GL_SPOT_EXPONENT,2);
//  glLightf(Num,GL_CONSTANT_ATTENUATION,1.2);
//  glLightf(Num,GL_QUADRATIC_ATTENUATION,0.00001);
end;

Procedure TGLCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  glFlush;
  Assert(CheckGLError,'Flush');

  {$IFNDEF LINUX}
  SwapBuffers(GetDCHandle);
  {$ENDIF}

  SetCanvas(DefaultCanvas);
  Assert(CheckGLError,'ShowImage');
end;

Function TGLCanvas.ReDrawBitmap:Boolean;
begin
  result:=False;
end;

procedure TGLCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  if Brush.Style<>bsClear then FillRect(TeeRect(X0,Y0,X1,Y1));
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex2D(X0,Y0);
    TeeVertex2D(X1,Y0);
    TeeVertex2D(X1,Y1);
    TeeVertex2D(X0,Y1);
    glEnd;
  end;
  Assert(CheckGLError,'Rectangle');
end;

procedure TGLCanvas.SetTextAlign(Align:Integer);
begin
  FTextAlign:=Align;
end;

procedure TGLCanvas.MoveTo(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TGLCanvas.Pyramid(Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer; DarkSides:Boolean);
var AWidth,
    AHeight,
    ADepth:Integer;
begin
  glPushMatrix;

  glEnable(GL_CULL_FACE);

  if Vertical then
  begin
    if Left>Right then SwapInteger(Left,Right);
    if Top>Bottom then glDisable(GL_CULL_FACE);
  end
  else
  begin
    if Top>Bottom then SwapInteger(Top,Bottom);
    if Left>Right then glDisable(GL_CULL_FACE);
  end;

  if z0>z1 then SwapInteger(z0,z1);

  glTranslatef(Left,-Bottom,-z0);

  if Vertical then
  begin
    AWidth:=Right-Left;
    AHeight:=Top-Bottom;
  end
  else
  begin
    AWidth:=Bottom-Top;
    AHeight:=Right-Left;
    glRotatef(90,0,0,1);
  end;

  ADepth:=z1-z0;

  if Brush.Style<>bsClear then
  begin
    glBegin(GL_TRIANGLE_FAN);
    SetColor(Brush.Color);
    SetBrushBitmap;

    //TeeNormal(0,0,-1);
    TeeNormal(AWidth div 2,-AHeight,ADepth div 2);
    TeeVertex3D(AWidth div 2,AHeight,ADepth div 2);
    TeeNormal(0,0,-1);
    TeeVertex2D(0,0);
    TeeNormal(1,0,-1);
    TeeVertex2D(AWidth,0);
    TeeNormal(1,0,1);
    TeeVertex3D(AWidth,0,ADepth);
    TeeNormal(0,0,1);
    TeeVertex3D(0,0,ADepth);
    TeeNormal(0,0,-1);
    TeeVertex2D(0,0);
    glEnd;

    RectangleY(0,0,AWidth,0,ADepth);

    EndBrushBitmap;
  end;

  glDisable(GL_CULL_FACE);

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex2D(0,0);
    TeeVertex2D(AWidth,0);
    TeeVertex3D(AWidth,0,ADepth);
    TeeVertex3D(0,0,ADepth);
    glEnd;
    glBegin(GL_LINE_STRIP);
    TeeVertex2D(0,0);
    TeeVertex3D(AWidth div 2,AHeight,ADepth div 2);
    TeeVertex3D(0,0,ADepth);
    glEnd;
    glBegin(GL_LINE_STRIP);
    TeeVertex2D(AWidth,0);
    TeeVertex3D(AWidth div 2,AHeight,ADepth div 2);
    TeeVertex3D(AWidth,0,ADepth);
    glEnd;
  end;

  glPopMatrix;
  Assert(CheckGLError,'Pyramid');
end;

procedure TGLCanvas.InternalCylinder(Vertical:Boolean;
                     Left,Top,Right,Bottom,Z0,Z1:Integer; Dark3D:Boolean;
                     ConePercent:Integer);
Var tmpSize,
    tmp,
    tmp2,
    Radius:Integer;
begin
  glPushMatrix;
  Radius:=Abs(Z1-Z0) div 2;

  if Left>Right then SwapInteger(Left,Right);
  if Top>Bottom then SwapInteger(Top,Bottom);
  if z0>z1 then SwapInteger(z0,z1);

  if Vertical then
  begin
    Radius:=MinInteger((Right-Left) div 2,Radius);
    glTranslatef((Left+Right) div 2,-Top,-(z0+z1) div 2);
    glRotatef(90,1,0,0);
    tmpSize:=Bottom-Top;
  end
  else
  begin
    Radius:=MinInteger((Bottom-Top) div 2,Radius);
    glTranslatef(Left,-(Top+Bottom) div 2,-(z0+z1) div 2);
    glRotatef(90,0,1,0);
    tmpSize:=Right-Left;
  end;

  if ConePercent=100 then tmp:=Radius
                     else tmp:=Round(0.01*ConePercent*Radius);

  tmp2:=Math.Min(18,6*Radius);

  if Brush.Style<>bsClear then
  begin
    glEnable(GL_CULL_FACE);
    SetColor(Brush.Color);
    SetBrushBitmap;
    gluCylinder(FQuadric,tmp,Radius,tmpSize,tmp2,6);
    EndBrushBitmap;

    if ConePercent=100 then
    begin
      gluQuadricOrientation(FQuadric, GLU_INSIDE);
      gluDisk(FQuadric,0,tmp,tmp2,6);
      gluQuadricOrientation(FQuadric, GLU_OUTSIDE);
      glPushMatrix;
      glTranslated(0,0,tmpSize);
      gluDisk(FQuadric,0,tmp,tmp2,6);
      glPopMatrix;
    end;
    glDisable(GL_CULL_FACE);
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    gluQuadricDrawStyle(FQuadric, GLU_LINE);
    gluCylinder(FQuadric,tmp+0.5,Radius+0.5,tmpSize+0.5,tmp2,6);
    gluQuadricDrawStyle(FQuadric, GLU_FILL);
  end;

  glPopMatrix;
end;

procedure TGLCanvas.Cylinder(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; DarkCover:Boolean);
begin
  InternalCylinder(Vertical,Left,Top,Right,Bottom,Z0,Z1,DarkCover,100);
  Assert(CheckGLError,'Cylinder');
end;

procedure TGLCanvas.Cone(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
begin
  InternalCylinder(Vertical,Left,Top,Right,Bottom,Z0,Z1,Dark3D,ConePercent);
  Assert(CheckGLError,'Cone');
end;

procedure TGLCanvas.Sphere(x,y,z:Integer; Const Radius:Double);
begin
  glPushMatrix;
  glTranslatef(x,-y,-z);

  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    glEnable(GL_CULL_FACE);
    SetBrushBitmap;
    gluSphere(FQuadric,Radius,TeeSphereSlices,TeeSphereStacks);
    EndBrushBitmap;
    glDisable(GL_CULL_FACE);
  end;

  if Pen.Style<>psClear then // 6.0
  begin
    SetPen;
    gluQuadricDrawStyle(FQuadric, GLU_LINE);
    gluSphere(FQuadric,Radius,TeeSphereSlices,TeeSphereStacks);
    gluQuadricDrawStyle(FQuadric, GLU_FILL);
  end;

  glPopMatrix;
  Assert(CheckGLError,'Sphere');
end;

Procedure TGLCanvas.SetColor(AColor:TColor);
var tmp : GLMat;
begin
  ColorToGL(AColor,tmp);
  glColor4fv(@tmp);
end;

procedure TGLCanvas.SetPen;
begin
  With Pen do
  begin
    if Style=psSolid then glDisable(GL_LINE_STIPPLE)
    else
    begin
      glEnable(GL_LINE_STIPPLE);
      Case Style of
       psSolid   : glLineStipple(1,$FFFF);
       psDot     : glLineStipple(1,$5555);
       psDash    : glLineStipple(1,$00FF);
       psDashDot : glLineStipple(1,$55FF);
      else
       glLineStipple(1,$1C47);
      end;
    end;

    if not IDrawToBitmap then
       glLineWidth(Width);

    SetColor(Color);
  end;
  Assert(CheckGLError,'SetPen');
end;

procedure TGLCanvas.LineTo(X, Y: Integer);
begin
  SetPen;
  glBegin(GL_LINES);
    TeeVertex2D(FX,FY);
    TeeVertex2D(X,Y);
  glEnd;
  FX:=X;
  FY:=Y;
  Assert(CheckGLError,'LineTo');
end;

procedure TGLCanvas.ClipRectangle(Const Rect:TRect);
begin
end;

procedure TGLCanvas.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);
begin
//  glEnable(GL_CLIP_PLANE0);
end;

procedure TGLCanvas.UnClipRectangle;
begin
//  glDisable(GL_CLIP_PLANE0);
end;

function TGLCanvas.GetBackColor:TColor;
begin
  result:=clWhite;
end;

procedure TGLCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TGLCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TGLCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

Function TGLCanvas.GetPixel(x,y:Integer):TColor;
begin
  result:=clWhite; // 6.0 How to do this in OpenGL ?
end;

Procedure TGLCanvas.SetMonochrome(Value:Boolean);
begin
end;

procedure TGLCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
end;

procedure TGLCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
end;

Procedure TGLCanvas.GradientFill( Const Rect:TRect;
                                  StartColor,EndColor:TColor;
                                  Direction:TGradientDirection;
                                  Balance:Integer=50);

  Procedure DoVertical(AStartColor,AEndColor:TColor);
  begin
    With Rect do
    begin
      SetColor(AEndColor);
      TeeVertex3D(Right,Bottom,FDepth);
      SetColor(AStartColor);
      TeeVertex3D(Right,Top,FDepth);
      TeeVertex3D(Left, Top,FDepth);
      SetColor(AEndColor);
      TeeVertex3D(Left, Bottom,FDepth);
    end;
  end;

  Procedure DoHorizontal(AStartColor,AEndColor:TColor);
  begin
    With Rect do
    begin
      SetColor(AEndColor);
      TeeVertex3D(Right,Bottom,FDepth);
      TeeVertex3D(Right,Top,FDepth);
      SetColor(AStartColor);
      TeeVertex3D(Left, Top,FDepth);
      TeeVertex3D(Left, Bottom,FDepth);
    end;
  end;

begin
  Assert(CheckGLError,'Before GradientFill');
  glBegin(GL_QUADS);
  TeeNormal(0,0,-1);
  Case Direction of
     gdTopBottom  : DoVertical(StartColor,EndColor);
     gdBottomTop  : DoVertical(EndColor,StartColor);
     gdLeftRight  : DoHorizontal(StartColor,EndColor);
     gdRightLeft  : DoHorizontal(EndColor,StartColor);
     gdFromCenter : ;
     gdFromTopLeft: ;
  else
{     gdFromBottomLeft }
  end;
  glEnd;
  Assert(CheckGLError,'GradientFill');
end;

Procedure TGLCanvas.RectangleY(Left,Top,Right,Z0,Z1:Integer);
begin
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    TeeNormal(0,1,0);
    SetColor(Brush.Color);
    SetBrushBitmap;
    TeeVertex3D(Left, Top,Z1);
    TeeVertex3D(Right,Top,Z1);
    TeeVertex3D(Right,Top,Z0);
    TeeVertex3D(Left, Top,Z0);
    glEnd;
    EndBrushBitmap;
  end;
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(Left, Top,Z0);
    TeeVertex3D(Right,Top,Z0);
    TeeVertex3D(Right,Top,Z1);
    TeeVertex3D(Left, Top,Z1);
    glEnd;
  end;
  Assert(CheckGLError,'RectangleY');
end;

Procedure TGLCanvas.RectangleWithZ(Const Rect:TRect; Z:Integer);
begin
  With Rect do
  begin
    if Pen.Style<>psClear then
    begin
      SetPen;
      glBegin(GL_LINE_LOOP);
      TeeVertex3D(Left, Top,   Z);
      TeeVertex3D(Right,Top,   Z);
      TeeVertex3D(Right,Bottom,Z);
      TeeVertex3D(Left, Bottom,Z);
      glEnd;
    end;

    if Brush.Style<>bsClear then
    begin
      SetColor(Brush.Color);
      SetBrushBitmap;
      glBegin(GL_QUADS);
      TeeNormal(0,0,-1);
      glTexCoord2f(0,1);
      TeeVertex3D(Left, Top,   Z);
      glTexCoord2f(1,1);
      TeeVertex3D(Left, Bottom,Z);
      glTexCoord2f(1,0);
      TeeVertex3D(Right,Bottom,Z);
      glTexCoord2f(0,0);
      TeeVertex3D(Right,Top,   Z);
      glEnd;
      EndBrushBitmap;
    end;
  end;

  Assert(CheckGLError,'RectangleWithZ');
end;

Procedure TGLCanvas.RectangleZ(Left,Top,Bottom,Z0,Z1:Integer);
begin
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(Left,Top,   Z0);
    TeeVertex3D(Left,Bottom,Z0);
    TeeVertex3D(Left,Bottom,Z1);
    TeeVertex3D(Left,Top,   Z1);
    glEnd;
  end;
  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;
    glBegin(GL_QUADS);
    TeeNormal(1,0,0);
    glTexCoord2f(0,1);
    TeeVertex3D(Left, Top,   Z0);
    glTexCoord2f(1,1);
    TeeVertex3D(Left, Bottom,Z0);
    glTexCoord2f(1,0);
    TeeVertex3D(Left,Bottom,Z1);
    glTexCoord2f(0,0);
    TeeVertex3D(Left,Top,   Z1);
    glEnd;
    EndBrushBitmap;
  end;
  Assert(CheckGLError,'RectangleZ');
end;

procedure TGLCanvas.FillRect(const Rect: TRect);
begin
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    TeeNormal(0,0,-1);
    SetColor(Brush.Color);

    With Rect do
    begin
      TeeVertex2D(Left, Top);
      TeeVertex2D(Left, Bottom);
      TeeVertex2D(Right,Bottom);
      TeeVertex2D(Right,Top);
    end;

    glEnd;
  end;
  Assert(CheckGLError,'FillRect '+IntToStr(FSavedError));
end;

procedure TGLCanvas.Frame3D( var Rect: TRect; TopColor, BottomColor: TColor;
                                 Width: Integer);
begin
//  Brush.Style:=bsClear;
//  Rectangle(Rect);
//  FillRect(Rect);
end;

procedure TGLCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
  Assert(CheckGLError,'Ellipse');
end;

procedure TGLCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
Const PiStep=Pi/10.0;
var t,XC,YC,XR,YR:Integer;
    tmpSin,tmpCos:Extended;
begin
  XR:=(X2-X1) div 2;
  YR:=(Y2-Y1) div 2;
  XC:=(X1+X2) div 2;
  YC:=(Y1+Y2) div 2;
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    for t:=0 to 18 do
    begin
      SinCos(t*piStep,tmpSin,tmpCos);
      TeeVertex3D(XC+Trunc(XR*tmpSin),YC-Trunc(YR*tmpCos),Z);
    end;
    glEnd;
  end;
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_TRIANGLE_FAN);
    SetColor(Brush.Color);
    TeeNormal(0,0,-1);
    TeeVertex3D(XC,YC,Z);
    for t:=0 to 20 do
    begin
      SinCos(t*piStep,tmpSin,tmpCos);
      TeeVertex3D(XC+Trunc(XR*tmpSin),YC-Trunc(YR*tmpCos),Z);
    end;
    glEnd;
  end;
  Assert(CheckGLError,'EllipseWithZ');
end;

procedure TGLCanvas.FrontPlaneBegin;  { for titles and legend only... }
begin
  DisableRotation;
  With View3DOptions do
    glTranslatef(-FXCenter+HorizOffset,FYCenter-VertOffset,TeeZoomScale/CalcPerspective);
end;

procedure TGLCanvas.FrontPlaneEnd;
begin
  EnableRotation;
end;

Procedure TGLCanvas.EnableRotation;
begin
  glPopMatrix;
  Assert(CheckGLError,'FrontPlaneEnd');
end;

Procedure TGLCanvas.DisableRotation;
begin
  glPushMatrix;
  glLoadIdentity;
  Assert(CheckGLError,'FrontPlaneBegin');
end;

procedure TGLCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    glBegin(GL_POINT);
    SetColor(Value);
    TeeVertex3D(X,Y,Z);
    glEnd;
    Assert(CheckGLError,'Pixel3D');
  end;
end;

procedure TGLCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    glBegin(GL_POINT);
    SetColor(Value);
    TeeVertex2D(X,Y);
    glEnd;
    Assert(CheckGLError,'Pixel');
  end;
end;

procedure TGLCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  Assert(CheckGLError,'Arc');
//  gluPartialDisk
end;

Function TGLCanvas.BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend;
begin
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
  ITransp:=(100-Transparency)*0.01;
  result:=nil;
end;

procedure TGLCanvas.EndBlending(Blend:TTeeBlend);
begin
  ITransp:=1;
  glDisable(GL_BLEND);
end;

procedure TGLCanvas.Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                           Const StartAngle,EndAngle,HolePercent:Double);
begin
  Assert(CheckGLError,'Donut');
end;

procedure TGLCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  Assert(CheckGLError,'Pie');
//  gluPartialDisk
end;

procedure TGLCanvas.Pie3D( XCenter,YCenter,XRadius,YRadius,Z0,Z1:Integer;
                           Const StartAngle,EndAngle:Double;
                           DarkSides,DrawSides:Boolean;
                           DonutPercent:Integer=0);

Const NumSliceParts=16;

Var piStep:Double;
    tmpSin,
    tmpCos     : Extended;
    tmpXRadius : Double;
    tmpYRadius : Double;

  Function ToDegree(Const Value:Double):Double;
  begin
    result:=Value*180.0/Pi;
  end;

  Procedure DrawPieSlice(z,ANormal:Integer);

    Procedure DrawSlice;
    var t:Integer;

      Procedure DrawSliceStep;
      begin
        SinCos(StartAngle+(t*piStep),tmpSin,tmpCos);
        TeeVertex3D(Trunc(XRadius*tmpSin),Trunc(YRadius*tmpCos),z);
      end;

    begin
      TeeVertex3D(0,0,z);
      if z=z0 then for t:=0 to NumSliceParts do DrawSliceStep
              else for t:=NumSliceParts downto 0 do DrawSliceStep;
    end;

  begin
    if Pen.Style<>psClear then
    begin
      SetPen;
      glBegin(GL_LINE_LOOP);
      DrawSlice;
      glEnd;
    end;
    if Brush.Style<>bsClear then
    begin
      glBegin(GL_TRIANGLE_FAN);
      SetColor(Brush.Color);
      TeeNormal(0,0,ANormal);
      DrawSlice;
      glEnd;
    end;
  end;

  Procedure DrawCover;
  var t,x,y:Integer;
  begin
    glBegin(GL_QUAD_STRIP);
    SetColor(Brush.Color);
    TeeNormal(0,1,0);
    for t:=0 to NumSliceParts do
    begin
      SinCos(StartAngle+(t*piStep),tmpSin,tmpCos);
      X:=Trunc(XRadius*tmpSin);
      Y:=Trunc(YRadius*tmpCos);
      TeeVertex2D(X,Y);
      TeeVertex3D(X,Y,z1-z0);
    end;
    glEnd;
  end;

  Procedure DrawSide(Const AAngle:Double);
  begin
    SinCos(AAngle,tmpSin,tmpCos);
    Plane3D(TeePoint(0,0),TeePoint(Round(tmpXRadius*tmpSin),Round(tmpYRadius*tmpCos)),Z0,Z1);
  end;

begin
  glPushMatrix;
  glTranslatef(XCenter,-YCenter,0);
  piStep:=(EndAngle-StartAngle)/NumSliceParts;

  if DonutPercent>0 then
  begin
    tmpXRadius:=DonutPercent*XRadius*0.01;
    tmpYRadius:=DonutPercent*YRadius*0.01;
  end
  else
  begin
    tmpXRadius:=XRadius;
    tmpYRadius:=YRadius;
  end;

  if DrawSides then
  begin
    DrawSide(StartAngle);
    DrawSide(EndAngle);
  end;

  glEnable(GL_CULL_FACE);
  DrawCover;
  DrawPieSlice(z0,-1);
  DrawPieSlice(z1,1);
  glDisable(GL_CULL_FACE);
  glPopMatrix;
  Assert(CheckGLError,'Pie3D');
end;

procedure TGLCanvas.Polyline(const Points:{$IFDEF D5}array of TPoint{$ELSE}TPointArray{$ENDIF}); // 6.0
var Count : Integer;
    t     : Integer;
begin
  Count:=Length(Points);
  if Count>0 then
  begin
    SetPen;
    glBegin(GL_LINES);
    for t:=0 to Count-1 do TeeVertex2D(Points[t].X,Points[t].Y);
    glEnd;
    FX:=Points[0].X;
    FY:=Points[0].Y;
    Assert(CheckGLError,'Polyline');
  end;
end;

procedure TGLCanvas.Polygon(const Points: array of TPoint);
begin
  PolygonWithZ(Points,0);
  Assert(CheckGLError,'Polygon');
end;

procedure TGLCanvas.PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer);
var tmpNormal:GLMat;

  Procedure CalcNormalPlaneFour;
  var Qx,Qy,Qz,Px,Py,Pz:Double;
  begin
    Qx:= Points[3].x-Points[2].x;
    Qy:= Points[3].y-Points[2].y;
    Qz:= z1-z1;
    Px:= Points[0].x-Points[2].x;
    Py:= Points[0].y-Points[2].y;
    Pz:= z0-z1;
    tmpNormal[0]:= (Py*Qz - Pz*Qy);
    tmpNormal[1]:= (Pz*Qx - Px*Qz);
    tmpNormal[2]:= -(Px*Qy - Py*Qx);
  end;

  Procedure AddPoints;
  begin
    With Points[0] do TeeVertex3D(x,y,z0);
    With Points[1] do TeeVertex3D(x,y,z0);
    With Points[2] do TeeVertex3D(x,y,z1);
    With Points[3] do TeeVertex3D(x,y,z1);
  end;

begin
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    AddPoints;
    glEnd;
  end;
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    CalcNormalPlaneFour;
    glNormal3fv(@tmpNormal);
    SetColor(Brush.Color);
    AddPoints;
    glEnd;
  end;
  Assert(CheckGLError,'PlaneFour3D');
end;

procedure TGLCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  Rectangle(X1,Y1,X2,Y2);
  Assert(CheckGLError,'RoundRect');
end;

Procedure TGLCanvas.Repaint;
begin
  if Assigned(View3DOptions) then View3DOptions.Repaint;
end;

Procedure TGLCanvas.Invalidate;
begin
end;

{$IFNDEF LINUX}
Procedure TGLCanvas.CreateFontOutlines;
var FontMode : Integer;
begin
  if FontOutlines then FontMode:=WGL_FONT_LINES
                  else FontMode:=WGL_FONT_POLYGONS;
  wglUseFontOutlines(GetDCHandle,32,TeeFontListRange,FontOffset,0,
                     TeeOpenGLFontExtrusion,FontMode,nil);

  Assert(CheckGLError,'InitFont');
end;
{$ENDIF}

Procedure TGLCanvas.InitOpenGLFont;
{$IFNDEF LINUX}
var Old,
    HFont    : THandle;
{$ENDIF}
begin
  {$IFNDEF LINUX}
  HFont := CreateFont(-12, 0, 0, 0, FW_BOLD,
		      0, 0, 0, {$IFDEF CLX}Cardinal{$ENDIF}(ANSI_CHARSET),
		      OUT_DEFAULT_PRECIS,
                      CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY{DRAFT_QUALITY},
		      DEFAULT_PITCH or FF_DONTCARE{FIXED_PITCH or FF_MODERN},
                      TeeOpenGLFontName);

  Old:=SelectObject(GetDCHandle, HFont);
  FontOffset:=1000;

  DeleteFont;

  CreateFontOutlines;

  DeleteObject(SelectObject(GetDCHandle,Old));
  IFontCreated:=True;

  {$ENDIF}
end;

Procedure TGLCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);
var tmp       : TSize;
    tmpLength : Integer;
    tmpSize   : Double;
    tmpAlign  : Integer;
begin
  if not IFontCreated then InitOpenGLFont;
  tmpLength:=Length(Text);

  ReferenceCanvas.Font.Assign(Font);
  tmp:=ReferenceCanvas.TextExtent(Text);

  tmpAlign:=FTextAlign;
  if tmpAlign>=TA_BOTTOM then
     Dec(tmpAlign,TA_BOTTOM)
  else
     Inc(y,Round(0.7*tmp.Cy));

  if tmpAlign=TA_CENTER then
     Dec(x,Round(0.55*tmp.Cx))
  else
  if tmpAlign=TA_RIGHT then
     Dec(x,tmp.Cx+(tmpLength div 2));               {-Round(Sqr(tmp.Cx)/19.0)}

  if TeeOpenGLFontExtrusion>0 then glEnable(GL_CULL_FACE);

  glPushMatrix;

  glTranslatef(x,-y,-z+2);

{  if FTextToViewer
  With View3DOptions do
  begin
    glRotatef(360-Tilt, 0, 0, 1);
    glRotatef(360-Rotation, 0, 1, 0);
    if not Orthogonal then glRotatef(360+Elevation, 1, 0, 0);
  end; }

  if TeeTextAngleY<>0 then glRotatef(TeeTextAngleY,1,0,0);
  if TeeTextAngleZ<>0 then glRotatef(TeeTextAngleZ,0,1,0);

//  other font rotations: glRotatef(270,1,0,0);
  tmpSize:=Font.Size*1.5;
  glScalef(tmpSize,tmpSize,1);
  TeeNormal(0,0,1);
  SetColor(Font.Color);

  glListBase(FontOffset-32);
  glCallLists(tmpLength, GL_UNSIGNED_BYTE, PChar(Text));
  glPopMatrix;
  Assert(CheckGLError,'TextOut3D');

  if TeeOpenGLFontExtrusion>0 then
  begin
    glDisable(GL_CULL_FACE);
    glFrontFace(GL_CCW);
    Assert(CheckGLError,'FrontFace');
  end;
end;

Procedure TGLCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(x,y,0,Text);
end;

procedure TGLCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  FX:=X;
  FY:=Y;
  FZ:=Z;
end;

procedure TGLCanvas.LineTo3D(X,Y,Z:Integer);
begin
  SetPen;
  glBegin(GL_LINES);
  TeeVertex3D(FX,FY,FZ);
  TeeVertex3D(x,y,z);
  glEnd;
  FX:=X;
  FY:=Y;
  FZ:=Z;
  Assert(CheckGLError,'LineTo3D');
end;

procedure TGLCanvas.PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer);
begin
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(P1.X,P1.Y,Z);
    TeeVertex3D(P2.X,P2.Y,Z);
    TeeVertex3D(P3.X,P3.Y,Z);
    TeeVertex3D(P4.X,P4.Y,Z);
    glEnd;
  end;
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    SetColor(Brush.Color);
    TeeNormal(0,0,-1);
    TeeVertex3D(P1.X,P1.Y,Z);
    TeeVertex3D(P2.X,P2.Y,Z);
    TeeVertex3D(P3.X,P3.Y,Z);
    TeeVertex3D(P4.X,P4.Y,Z);
    glEnd;
  end;
  Assert(CheckGLError,'PlaneWithZ');
end;

procedure TGLCanvas.Plane3D(Const A,B:TPoint; Z0,Z1:Integer);
begin
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    TeeNormal(0,1,0);  { <-- CalcNormal }
    SetColor(Brush.Color);
    TeeVertex3D(A.X,A.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z1);
    TeeVertex3D(A.X,A.Y,Z1);
    glEnd;
  end;
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(A.X,A.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z1);
    TeeVertex3D(A.X,A.Y,Z1);
    glEnd;
  end;
  Assert(CheckGLError,'Plane3D');
end;

procedure TGLCanvas.SetDrawStyle(Value:TTeeCanvasSurfaceStyle);
begin
  if Value=tcsWire then
     glPolygonMode(GL_FRONT_AND_BACK,GL_LINE)
  else
  if Value=tcsDot then
     glPolygonMode(GL_FRONT_AND_BACK,GL_POINT)
  else
     glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
end;

Function TGLCanvas.GetSupports3DText:Boolean;
begin
  result:=True;
end;

Function TGLCanvas.GetSupportsFullRotation:Boolean;
begin
  result:=True;
end;

Function TGLCanvas.GetTextAlign:TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

Function TGLCanvas.GetUseBuffer:Boolean;
begin
  result:=FUseBuffer;
end;

Procedure TGLCanvas.SetUseBuffer(Value:Boolean);
begin
  FUseBuffer:=Value;
  IDestCanvas:=nil;
  DeleteFont;
end;

Procedure TGLCanvas.DeleteFont;
begin
  if IFontCreated then
  begin
    glDeleteLists(FontOffset,TeeFontListRange);
    IFontCreated:=False;
  end;
//  Assert(CheckGLError,'DeleteFont '+IntToStr(FSavedError));
end;

Function TGLCanvas.GetHandle:TTeeCanvasHandle;
begin
  result:=FDC;
end;

Procedure TGLCanvas.DoHorizLine(X0,X1,Y:Integer);
begin
  MoveTo(X0,Y);
  LineTo(X1,Y);
end;

Procedure TGLCanvas.DoVertLine(X,Y0,Y1:Integer);
begin
  MoveTo(X,Y0);
  LineTo(X,Y1);
end;

procedure TGLCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Integer);
begin
  glPushMatrix;
  glTranslatef(x,-y,0);
  glRotatef(RotDegree,0,0,1);
  glTranslatef(-x,y,z);
  TextOut(X,Y,St);
  glPopMatrix;
  Assert(CheckGLError,'RotateLabel3D');
end;

procedure TGLCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Integer);
begin
  RotateLabel3D(x,y,0,St,RotDegree);
end;

Procedure TGLCanvas.Line(X0,Y0,X1,Y1:Integer);
begin
  MoveTo(X0,Y0);
  LineTo(X1,Y1);
end;

procedure TGLCanvas.EraseBackground(const Rect: TRect);
begin { nothing ! OpenGL already clears... }
end;

Procedure TGLCanvas.HorizLine3D(Left,Right,Y,Z:Integer);
begin
  MoveTo3D(Left,Y,Z);
  LineTo3D(Right,Y,Z);
end;

Procedure TGLCanvas.VertLine3D(X,Top,Bottom,Z:Integer);
begin
  MoveTo3D(X,Top,Z);
  LineTo3D(X,Bottom,Z);
end;

Procedure TGLCanvas.ZLine3D(X,Y,Z0,Z1:Integer);
begin
  MoveTo3D(X,Y,Z0);
  LineTo3D(X,Y,Z1);
end;

Procedure TGLCanvas.Arrow( Filled:Boolean;
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
  Assert(CheckGLError,'BeforeArrow');
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
    y := yb - tmpHoriz/2;
    pc:=CalcArrowPoint;
    y := yb + tmpHoriz/2;
    pd:=CalcArrowPoint;
    if Filled then
    Begin
      tmpHoriz4:=tmpHoriz/4;
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
      PolygonWithZ([ph,pg,pe,pf],Z);
      PolygonWithZ([pc,To3D,pd],Z);
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
  Assert(CheckGLError,'Arrow');
end;

Procedure TGLCanvas.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
begin
  MoveTo3D(X0,Y0,Z);
  LineTo3D(X1,Y1,Z);
end;

procedure TGLCanvas.PolygonWithZ(Points: array of TPoint; Z:Integer);

  Procedure AddPoints;
  var t : Integer;
  begin
    for t:=Low(Points) to High(Points) do
        With Points[t] do TeeVertex3D(x,y,z);
  end;

begin
  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;
    glBegin(GL_POLYGON);
    TeeNormal(0,0,-1);
    AddPoints;
    glEnd;
    EndBrushBitmap;
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    AddPoints;
    glEnd;
  end;

  Assert(CheckGLError,'PolygonWithZ');
end;

procedure TGLCanvas.Triangle3D( Const Points:TTrianglePoints3D;
                                Const Colors:TTriangleColors3D);
var t:Integer;
begin
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_POLYGON);
    TeeNormal(0,0,-1);  { <-- calc Normal }
    SetColor(Colors[0]);
    With Points[0] do TeeVertex3D(x,y,z);
    SetColor(Colors[1]);
    With Points[1] do TeeVertex3D(x,y,z);
    SetColor(Colors[2]);
    With Points[2] do TeeVertex3D(x,y,z);
    glEnd;
  end;
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    for t:=0 to 2 do With Points[t] do TeeVertex3D(x,y,z);
    glEnd;
  end;
  Assert(CheckGLError,'Triangle3D');
end;

procedure TGLCanvas.TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer);
begin
  PolygonWithZ([P1,P2,P3],Z);
end;

Function TGLCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Procedure TGLCanvas.Surface3D( Style:TTeeCanvasSurfaceStyle;
                               SameBrush:Boolean;
                               NumXValues,NumZValues:Integer;
                               CalcPoints:TTeeCanvasCalcPoints);

  Procedure DrawCells;
  var tmpX,
      tmpZ : Integer;

    Procedure AddVertexs;
    Var tmpColor0,
        tmpColor1 : TColor;
        P0        : TPoint3D;
        P1        : TPoint3D;
    begin 
      if CalcPoints(tmpX,tmpZ+1,P0,P1,tmpColor0,tmpColor1) then
      begin
        if SameBrush then
        begin
          With P0 do TeeVertex3D(x,y,z);
          With P1 do TeeVertex3D(x,y,z);
        end
        else
        begin
          if tmpColor0<>clNone then SetColor(tmpColor0);
          With P0 do TeeVertex3D(x,y,z);
          if tmpColor1<>clNone then SetColor(tmpColor1);
          With P1 do TeeVertex3D(x,y,z);
        end;
      end
      else
      begin
        glEnd;
        glBegin(GL_QUAD_STRIP);
        TeeNormal(0,-1,0);
      end;
    end;

  begin
    for tmpX:=2 to NumXValues do
    begin
      glBegin(GL_QUAD_STRIP);
      TeeNormal(0,1,0);
      for tmpZ:=NumZValues-1 downto 0 do AddVertexs;
      glEnd;
    end;
  end;

begin
  SetPen;
  if (Style=tcsSolid) or (not SameBrush) then SetColor(Brush.Color);

  if DrawStyle=tcsSolid then SetDrawStyle(Style);

  DrawCells;

  if (Pen.Style<>psClear) and (Style=tcsSolid) then
  begin
    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    SetColor(Pen.Color);
    SameBrush:=True;
    DrawCells;
  end;

  SetDrawStyle(DrawStyle);
  Assert(CheckGLError,'Surface3D');
end;

procedure TGLCanvas.PyramidTrunc(Const R: TRect; StartZ, EndZ: Integer;
                                 TruncX,TruncZ:Integer);
begin
  Pyramid(True,R.Left,R.Top,R.Right,R.Bottom,StartZ,EndZ,True);
end;

end.

