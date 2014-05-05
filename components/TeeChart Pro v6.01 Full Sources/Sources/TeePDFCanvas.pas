{********************************************}
{ TeeChart Pro PDF Canvas and Exporting      }
{ Copyright (c) 2002-2003 by Marjan Slatinek }
{   and David Berneda                        }
{       All Rights Reserved                  }
{                                            }
{       Some features taken from             }
{   Nishita's PDF Creation VCL (TNPDF)       }
{         ( with permission )                }
{                                            }
{********************************************}
unit TeePDFCanvas;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QForms, Types,
     {$ELSE}
     Graphics, Forms,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeExport, Math;

type
  {$IFDEF LINUX}
  TOutlineTextMetric=packed record
  end;
  {$ENDIF}

  PFontEntry = ^TFontEntry;
  TFontEntry = record
    UniqueName: String;
    Name: String;
    ObjPos: Integer;
    FontData: TOutlineTextMetric;
    Font: TFont;
    end;

type
  TPDFCanvas = class(TTeeCanvas3D)
  private
    { Private declarations }
     FBackColor : TColor;
     FBackMode : TCanvasBackMode;
     IWidth, IHeight: Integer;
     IObjCount: Integer;
     ObjectOffset : Integer;
     IStartSize,IEndSize: Integer;
     tStream, sStream, PDF: TMemoryStream;
     fStream: TMemoryStream;
     ObjectOffsetList: TStringList;
     FontList: TList;
     FontEntry: PFontEntry;
     FX,FY: double;
     IParentNum, ICatalogNum,
     IResourceNum, IOutlineNum: Integer;
     IClipCalled: boolean;
     tmpSt: String;
     procedure InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; MoveTo0: boolean; DrawPie: boolean);
     Function InternalBezCurve(ax1,ay1,ax2,ay2,ax3,ay3: double): String;
     Procedure AddString(var Stream: TMemoryStream; S:String);
     Procedure AddToOffset(Offset: Integer);
     Procedure InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
     Function PointToStr(X, Y: double):String;
     Function TheBounds:String;
     Function SetPenStyle(PenStyle: TPenStyle): String;
     Procedure TranslateVertCoord(var Y: double);
     Function PenProperties(Pen: TPen): String;
     Function BrushProperties(Brush: TBrush): String;
     Function FontProperties(Font: TTeeFont; var FontIndex: Integer): String;
     Procedure DefineArray;
     Procedure DefineHeader;
     Procedure DefineCatalog;
     Procedure DefineXRef;
     Procedure DefineOutline;
     Procedure DefinePages;
     Procedure DefinePage;
     Procedure StartStream;
     Procedure EndStream;
     function SelectFont(Font: TFont): Integer;
     procedure WriteTrueTypeFonts;
     function ConstructFontName(Font: TFont): String;
     function TextToPDFText(AText: String): String;
  protected
    { Protected declarations }
     Procedure PolygonFour; override;
  public

    { Public declarations }
    Constructor Create(APDF: TMemoryStream);
    Destructor Destroy; override;

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;
    { 2d }
    Function TextWidth(Const St:String):Integer; override;
    Function TextHeight(Const St:String):Integer; override;
    procedure SetPixel(X, Y: Integer; Value: TColor); override;

    { 3d }
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    Function GetMonochrome:Boolean; override;
    Procedure SetMonochrome(Value:Boolean); override;
    Procedure SetBackColor(Color:TColor); override;
    Function GetBackMode:TCanvasBackMode; override;
    Function GetBackColor:TColor; override;
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
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
    Procedure Line(X0,Y0,X1,Y1:Integer); override;
    Procedure Polygon(const Points: array of TPoint); override;

    { 3d }
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    procedure EllipseWithZ(X1, Y1, X2, Y2, Z:Integer); override;
    Procedure HorizLine3D(Left,Right,Y,Z:Integer); override;
    procedure LineTo3D(X,Y,Z:Integer); override;
    Procedure LineWithZ(X0,Y0,X1,Y1,Z:Integer); override;
    procedure MoveTo3D(X,Y,Z:Integer); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
    Procedure VertLine3D(X,Top,Bottom,Z:Integer); override;
    Procedure ZLine3D(X,Y,Z0,Z1:Integer); override;
  end;

  TPDFExportFormat=class(TTeeExportFormat)
  private
  protected
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function PDFList:TMemoryStream;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;


procedure TeeSaveToPDFFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);




implementation

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst, SysUtils;

{ Convert , to . }
procedure FixSeparator(var St: String);
begin
  while Pos(',', St) > 0 do
    St[Pos(',', St)] := '.';
end;

Function PDFColor(AColor:TColor):String;
begin
  AColor:=ColorToRGB(AColor);
  Result:= FormatFloat('0.00',GetRVAlue(AColor)/255) + ' ' +
           FormatFloat('0.00',GetGVAlue(AColor)/255) + ' ' +
           FormatFloat('0.00',GetBVAlue(AColor)/255);
  FixSeparator(Result);
end;

{ TPDFCanvas }
Constructor TPDFCanvas.Create(APDF:TMemoryStream);
begin
  inherited Create;
  FBackMode := cbmTransparent;
  UseBuffer:=False;
  tStream:=TMemoryStream.Create;
  sStream:=TMemoryStream.Create;
  fStream:=TMemoryStream.Create;
  PDF := APDF;
  ObjectOffsetList := TStringList.Create;
  FontList := TList.Create;
end;

Function TPDFCanvas.InternalBezCurve(ax1,ay1,ax2,ay2,ax3,ay3: double): String;
begin
  Result := FormatFloat('0.000',ax1)+ ' ' + FormatFloat('0.000',ay1) + ' ' +
            FormatFloat('0.000',ax2)+ ' ' + FormatFloat('0.000',ay2) + ' ' +
            FormatFloat('0.000',ax3)+ ' ' + FormatFloat('0.000',ay3) + ' c';
end;


Procedure TPDFCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  EndStream;
  WriteTrueTypeFonts;
  DefineOutline;
  DefinePages;
  DefineArray;
  DefinePage;
  DefineCatalog;
  DefineXRef;
  { ... that's about it }
  AddString(PDF,'%%EOF');
end;

Procedure TPDFCanvas.AddString(var Stream: TMemoryStream; S:String);
begin
  S := S+ #13 + #10;
  Stream.Write(S[1],Length(S));
end;


procedure TPDFCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  InternalRect(TeeRect(X0,Y0,X1,Y1),True,False);
end;

procedure TPDFCanvas.MoveTo(X, Y: Integer);
begin
  FX := X;
  FY := Y;
end;

procedure TPDFCanvas.LineTo(X, Y: Integer);
begin
  AddString(sStream,PenProperties(Pen));
  AddString(sStream,PointToStr(FX,FY)+' m');
  AddString(sStream,PointToStr(X,Y)+' l S');
  FX := X;
  FY := Y;
end;

procedure TPDFCanvas.ClipRectangle(Const Rect:TRect);
var tmpB, tmpT: double;
    st: String;
begin
  IClipCalled := True;
  AddString(sStream,'q');
  tmpB := Rect.Bottom;
  tmpT := Rect.Top;
  TranslateVertCoord(tmpB);
  TranslateVertCoord(tmpT);
  st := FormatFloat('0.00',Rect.Left)+' '+ FormatFloat('0.00',tmpB)+ ' ' +
          FormatFloat('0.00',Rect.Right-Rect.Left)+' ' + FormatFloat('0.00',tmpT-tmpB)+' re W n';
  FixSeparator(st);
  AddString(sStream,st);
end;

procedure TPDFCanvas.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);
begin
  { Not implemented }
end;

procedure TPDFCanvas.UnClipRectangle;
begin
  if IClipCalled then
  begin
    AddString(sStream,'Q');
    IClipCalled := false;
  end;
end;

function TPDFCanvas.GetBackColor:TColor;
begin
  result:=FBackColor;
end;

procedure TPDFCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TPDFCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TPDFCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

Procedure TPDFCanvas.SetMonochrome(Value:Boolean);
begin
  { Not implemented }
end;

procedure TPDFCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  { Not implemented }
end;

procedure TPDFCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  { Not implemented }
end;

Function TPDFCanvas.TheBounds:String;
begin
  IWidth := Bounds.Right - Bounds.Left;
  IHeight := Bounds.Bottom - Bounds.Top;
end;

Function TPDFCanvas.PointToStr(X,Y:double):String;
begin
  TranslateVertCoord(Y);
  tmpSt := FormatFloat('0.000',X)+' '+FormatFloat('0.000',Y);
  FixSeparator(tmpSt);
  Result := tmpSt;
end;

Procedure TPDFCanvas.GradientFill( Const Rect:TRect;
                                  StartColor,EndColor:TColor;
                                  Direction:TGradientDirection;
                                  Balance:Integer=50);
begin
  { Not implemented }
end;

procedure TPDFCanvas.FillRect(const Rect: TRect);
begin
  InternalRect(Rect,False,False);
end;

Procedure TPDFCanvas.InternalRect(Const Rect:TRect; UsePen, IsRound:Boolean);
var tmpB,tmpT: double;
begin
  if (Brush.Style<>bsClear) or (UsePen and (Pen.Style<>psClear)) then
  begin
    AddString(sStream,PenProperties(Pen));
    AddString(sStream,BrushProperties(Brush));
    tmpB := Rect.Bottom;
    tmpT := Rect.Top;
    TranslateVertCoord(tmpB);
    TranslateVertCoord(tmpT);
    tmpSt := FormatFloat('0.000',Rect.Left)+' '+ FormatFloat('0.000',tmpB)+ ' ' +
            FormatFloat('0.000',Rect.Right-Rect.Left)+' ' + FormatFloat('0.000',tmpT-tmpB)+' re';
    FixSeparator(tmpSt);
    AddString(sStream,tmpSt);

    if (Brush.Style<>bsClear) then
    begin
      if (Pen.Style<>psClear) then AddString(sStream,'B')
      else AddString(sStream,'f');
    end else AddString(sStream,'S');
  end;
end;

procedure TPDFCanvas.Frame3D( var Rect: TRect; TopColor, BottomColor: TColor;
                             Width: Integer);
begin
  Brush.Style:=bsClear;
  {$IFDEF D5}
  Rectangle(Rect);
  {$ELSE}
  with Rect do Rectangle(Left,Top,Right,Bottom);
  {$ENDIF}
  InflateRect(Rect,-Width,-Width);
end;

procedure TPDFCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
end;

procedure TPDFCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
var ra,rb,xc,yc: double;
    St: String;
const Bez = 0.552;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    AddString(sStream,BrushProperties(Brush));
    AddString(sStream,PenProperties(Pen));
    Calc3DPos(X1,Y1,Z);
    Calc3DPos(X2,Y2,Z);
    ra := (X2 - X1)*0.5;
    rb := (Y2 - Y1)*0.5;
    xc := (X2 + X1)*0.5;
    yc := (Y2 + Y1)*0.5;
    TranslateVertCoord(yc);
    St := FormatFloat('0.000',xc+ra)+ ' ' + FormatFloat('0.000',yc)+ ' m'+#13+#10;
    { 4-arc version of drawing circle/ellipse }
    { Q1, Q2, Q3 and Q4 cp}
    St := St + InternalBezCurve(xc+ra, yc+Bez*rb, xc+Bez*ra, yc+rb, xc, yc+rb)+#13+#10;
    St := St + InternalBezCurve(xc-Bez*ra, yc+rb, xc-ra, yc+Bez*rb, xc-ra, yc)+#13+#10;
    St := St + InternalBezCurve(xc-ra, yc-Bez*rb, xc-Bez*ra, yc-rb, xc, yc-rb)+#13+#10;
    St := St + InternalBezCurve(xc+Bez*ra, yc-rb, xc+ra, yc-Bez*rb, xc+ra, yc)+#13+#10;
    FixSeparator(St);
    AddString(sStream,St);
    if (Brush.Style<>bsClear) then
    begin
      if (Pen.Style<>psClear) then AddString(sStream,'B')
      else AddString(sStream,'f');
    end else AddString(sStream,'S');
  end;
end;

procedure TPDFCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Calc3DPos(x,y,z);
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TPDFCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TPDFCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4, True,False);
end;

procedure TPDFCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4, False, True);
end;

procedure TPDFCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  InternalRect(TeeRect(X1,Y1,X2,Y2),True,True);
end;

Procedure TPDFCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);
begin
  RotateLabel3D(X,Y,Z,Text,0);
end;

Procedure TPDFCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(X,Y,0,Text);
end;

procedure TPDFCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  MoveTo(x,y);
end;

procedure TPDFCanvas.LineTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  LineTo(x,y);
end;

Procedure TPDFCanvas.DoHorizLine(X0,X1,Y:Integer);
begin
  MoveTo(X0,Y);
  LineTo(X1,Y);
end;

Procedure TPDFCanvas.DoVertLine(X,Y0,Y1:Integer);
begin
  MoveTo(X,Y0);
  LineTo(X,Y1);
end;

procedure TPDFCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Integer);

  Procedure DoText(AX,AY: double; RotRad: double);
  var tw,th: double;
      vcos, vsin : double;
      xc,yc: double;
      FontIndex: Integer;
  begin
    AddString(sStream,PDFColor(Font.Color)+' rg');
    AddString(sStream,'BT');
    if Assigned(IFont) then AddString(sStream,FontProperties(IFont,FontIndex))
    else AddString(sStream,FontProperties(TTeeFont(Font),FontIndex));

    { Get text width and height }
    th := TextHeight(St);
    if (TextAlign and TA_CENTER)=TA_CENTER then tw := TextWidth(St)*0.5
    else if (TextAlign and TA_RIGHT)=TA_RIGHT then tw := TextWidth(St)
    else tw := 0 ;

    {$IFNDEF LINUX}
    { FIX :
      the system uses 72 Pixelsperinch as a base line figure, most systems are
      96 DPI or if your in large Font Mode then 120 DPI
      So when using the TextWidth/TextHeight of the currently selected font, you get the wrong answer
    }
    tw := tw*72/PFontEntry(FontList.Items[FontIndex]).FontData.otmTextMetrics.tmDigitizedAspectX;
    th := th*72/PFontEntry(FontList.Items[FontIndex]).FontData.otmTextMetrics.tmDigitizedAspectY;
    {$ENDIF}

    TranslateVertCoord(AY);
    { rotation elements }
    vcos := Cos(RotRad);
    vsin := Sin(RotRad);

    { rotated values }
    xc := AX - (tw*vcos-th*vsin);
    yc := AY - (tw*vsin+th*vcos);
    tmpSt := FormatFloat('0.000',vcos)+ ' ' + FormatFloat('0.000',vsin)+ ' '+
                    FormatFloat('0.000',-vsin)+ ' ' + FormatFloat('0.000',vcos)+ ' '+
                    FormatFloat('0.000',xc)+ ' ' + FormatFloat('0.000',yc)+ ' Tm';

    FixSeparator(tmpSt);
    AddString(sStream,tmpSt);
    AddString(sStream,'('+TextToPDFText(St)+') Tj');
    AddString(sStream,'ET');
  end;

var tmpX : Integer;
    tmpY : Integer;
begin

  Calc3DPos(X,Y,Z);
  if Assigned(IFont) then
  With IFont.Shadow do
  if (HorizSize<>0) or (VertSize<>0) then
  begin
    if HorizSize<0 then
    begin
      tmpX:=X;
      X:=X-HorizSize;
    end
    else tmpX:=X+HorizSize;
    if VertSize<0 then
    begin
      tmpY:=Y;
      Y:=Y-VertSize;
    end
    else tmpY:=Y+VertSize;
    DoText(tmpX,tmpY, RotDegree*0.01745329);
  end;

  DoText(X,Y, RotDegree*0.01745329);
end;

procedure TPDFCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Integer);
begin
  RotateLabel3D(x,y,0,St,RotDegree);
end;

Procedure TPDFCanvas.Line(X0,Y0,X1,Y1:Integer);
begin
  MoveTo(X0,Y0);
  LineTo(X1,Y1);
end;

Procedure TPDFCanvas.HorizLine3D(Left,Right,Y,Z:Integer);
begin
  MoveTo3D(Left,Y,Z);
  LineTo3D(Right,Y,Z);
end;

Procedure TPDFCanvas.VertLine3D(X,Top,Bottom,Z:Integer);
begin
  MoveTo3D(X,Top,Z);
  LineTo3D(X,Bottom,Z);
end;

Procedure TPDFCanvas.ZLine3D(X,Y,Z0,Z1:Integer);
begin
  MoveTo3D(X,Y,Z0);
  LineTo3D(X,Y,Z1);
end;

Procedure TPDFCanvas.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
begin
  MoveTo3D(X0,Y0,Z);
  LineTo3D(X1,Y1,Z);
end;

Function TPDFCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Procedure TPDFCanvas.PolygonFour;
begin
  Polygon(IPoints);
end;

Procedure TPDFCanvas.Polygon(const Points: Array of TPoint);
var t: Integer;

begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin

    if (Pen.Style<>psClear) then
      AddString(sStream,PenProperties(Pen));

    AddString(sStream,PointToStr(Points[0].X,Points[0].Y)+' m');
    for t:=1 to High(Points) do
      AddString(sStream,PointToStr(Points[t].X,Points[t].Y)+' l');
    AddString(sStream,'h');

    if (Brush.Style<>bsClear) then
    begin
      AddString(sStream,BrushProperties(Brush));
      if (Pen.Style<>psClear) then AddString(sStream,'B')
      else AddString(sStream,'f');
    end else AddString(sStream,'S');
  end;
end;

function TPDFCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;
var i: Integer;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);
  IClipCalled := False;
  TheBounds;
  IObjCount := 0;
  ObjectOffset := 0;
  ObjectOffsetList.Clear;
  for i := 0 to FontList.Count -1 do
  begin
    FontEntry := FontList.Items[i];
    Dispose(FontEntry);
  end;
  FontList.Clear;
  { clear all streams }
  PDF.Clear;
  tStream.Clear;
  sStream.Clear;

  DefineHeader;
  StartStream;
end;

function TPDFCanvas.SelectFont(Font: TFont): Integer;
var i: Integer;
  FName : String;
  {$IFNDEF CLX}
  FontInfo: ^TOutlineTextMetric;
  {$ENDIF}
begin
  {$IFDEF CLX}
  result:=-1;
  {$ENDIF}

  FName := ConstructFontName(Font);
  for i := 0 to FontList.Count -1 do
    { Font already in the font list ? }
    if FName = PFontEntry(FontList.Items[i]).UniqueName then
    begin
      Result := i;
      Exit;
    end;

  {$IFNDEF CLX}
  { New font ? Generate entry for it }
  New(FontInfo);
  try
    GetOutlineTextMetrics(Handle,SizeOf(TOutlineTextMetric),FontInfo);
    New(FontEntry);
    FontEntry^.UniqueName := FName;
    FontEntry^.FontData := FontInfo^;
    FontEntry^.Font := Font;
    FontEntry^.Name := 'F'+IntToStr(FontList.Count +1);
    FontList.Add(FontEntry);
    Result := FontList.Count-1;
  finally
    Dispose(FontInfo);
  end;
  {$ENDIF}
end;

procedure TPDFCanvas.WriteTrueTypeFonts;
var
  First, Last: Integer;
  Flags: Integer;
  i,j: Integer;
  MulFactor: double;
  FData : TOutlineTextMetric;
  CharWidths: Array[0..255] of Integer;
begin
  fStream.Clear;
  for i := 0 to FontList.Count -1 do
  begin
    FData := PFontEntry(FontList.Items[i]).FontData;
    ReferenceCanvas.Font.Assign(PFontEntry(FontList.Items[i]).Font);
    {$IFNDEF CLX}
    { TODO : Verify the MulFactor calculation with large/small fonts }
    { Especially why it seems 0.6 is correct factor in both cases ? }
    MulFactor :=FData.otmEMSquare/FData.otmTextMetrics.tmHeight*0.6;
    {$ELSE}
    MulFactor := 1;
    {$ENDIF}
    {$IFNDEF CLX}
    GetCharWidth32(Handle,0,255,CharWidths);
    {$ENDIF}

    {$IFDEF LINUX}
    First := 0;
    Last := 255;
    {$ELSE}
    First := Ord(FData.otmTextMetrics.tmFirstChar);
    Last := Ord(FData.otmTextMetrics.tmLastChar);
    {$ENDIF}

    Flags := 32; { TODO : Missing correct flag calculation }
    { Font header }
    Inc(IObjCount);
    PFontEntry(FontList.Items[i]).ObjPos := IObjCount;
    tStream.Clear;
    AddString(tStream,IntToStr(IObjCount)+' 0 obj');
    AddString(tStream,'<< /Type /Font');
    AddString(tStream,'/Subtype /TrueType');
    AddString(tStream,'/BaseFont /'+PFontEntry(FontList.Items[i]).UniqueName);
    AddString(tStream,'/FirstChar '+IntToStr(First));
    AddString(tStream,'/LastChar '+IntToStr(Last));
    AddString(tStream,'/FontDescriptor '+IntToStr(IObjCount+1)+' 0 R');
    AddString(tStream,'/Widths '+IntToStr(IObjCount+2)+' 0 R');
    AddString(tStream,'/Encoding /WinAnsiEncoding');
    AddString(tStream,'>>');
    AddString(tStream,'endobj');
    AddToOffset(tStream.Size);
    fStream.Seek(0, soFromEnd);
    tStream.SaveToStream(fStream);

    { add font descriptor }
    Inc(IObjCount);
    tStream.Clear;
    AddString(tStream,IntToStr(IObjCount)+' 0 obj');
    AddString(tStream,'<< /Type /FontDescriptor');
    AddString(tStream,'/FontName /'+PFontEntry(FontList.Items[i]).UniqueName);
    AddString(tStream,'/Flags '+IntToStr(Flags));

    {$IFNDEF LINUX}
    AddString(tStream,'/FontBBox ['+
        IntToStr(Round(FData.otmrcFontBox.Left*MulFactor))+' ' +
        IntToStr(Round(FData.otmrcFontBox.Bottom*MulFactor))+' ' +
        IntToStr(Round((FData.otmrcFontBox.right - FData.otmrcFontBox.Left)*MulFactor))+' ' +
        IntToStr(Round((FData.otmrcFontBox.Top - FData.otmrcFontBox.Bottom)*MulFactor))+']');
    AddString(tStream,'/CapHeight '+IntToStr(Round(FData.otmTextMetrics.tmHeight*MulFactor)));
    AddString(tStream,'/Ascent '+IntToStr(Round(FData.otmAscent*MulFactor)));
    AddString(tStream,'/Descent '+IntToStr(-Round(FData.otmDescent*MulFactor)));
    AddString(tStream,'/Leading '+IntToStr(Round(FData.otmTextMetrics.tmInternalLeading*MulFactor)));
    AddString(tStream,'/MaxWidth '+IntToStr(Round(FData.otmTextMetrics.tmMaxCharWidth*MulFactor)));
    AddString(tStream,'/AvgWidth '+IntToStr(Round(FData.otmTextMetrics.tmAveCharWidth*MulFactor)));
    AddString(tStream,'/ItalicAngle '+IntToStr(FData.otmItalicAngle));
    {$ENDIF}

    AddString(tStream,'>>');
    AddString(tStream,'endobj');
    AddToOffset(tStream.Size);
    fStream.Seek(0, soFromEnd);
    tStream.SaveToStream(fStream);

    { write widths }
    Inc(IObjCount);
    tStream.Clear;
    AddString(tStream,IntToStr(IObjCount)+' 0 obj');
    AddString(tStream,'[');
    tmpSt := '';
    for j := First to Last do
      if (j mod 15 = 14) then tmpSt := tmpSt + IntToStr(Round(CharWidths[j]*MulFactor))+' '+#13+#10
      else tmpSt := tmpSt + IntToStr(Round(CharWidths[j]*MulFactor))+' ';
    AddString(tStream,tmpSt);
    AddString(tStream,']');
    AddString(tStream,'endobj');
    AddToOffset(tStream.Size);
    fStream.Seek(0, soFromEnd);
    tStream.SaveToStream(fStream);
  end;
  PDF.Seek(0, soFromEnd);
  fStream.SaveToStream(PDF);
end;

function TPDFCanvas.ConstructFontName(Font: TFont): String;
begin
  tmpSt := Font.Name;
  if (fsBold in Font.Style) then tmpSt := tmpSt+',Bold';
  if (fsItalic in Font.Style) then tmpSt := tmpSt+',Italic';
  Result := StringReplace(tmpSt,' ','#20',[rfReplaceAll]);
end;

procedure TPDFCanvas.DefineCatalog;
begin
  { Catalog part }
  Inc(IObjCount);
  ICatalogNum := IObjCount;
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<< /Type /Catalog');
  AddString(tStream,'/Pages '+IntToStr(IParentNum)+' 0 R');
  AddString(tStream,'/Outlines '+IntToStr(IOutlineNum)+' 0 R');
  AddString(tStream,'>>');
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.DefineOutline;
begin
  { Outline part }
  Inc(IObjCount);
  IOutLineNum := IObjCount;
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<< /Type /Outlines');
  AddString(tStream,'/Count 0');
  AddString(tStream,'>>');
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.DefinePages;
begin
  { Pages part }
  Inc(IObjCount);
  IParentNum := IObjCount;
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<< /Type /Pages');
  { in between comes only one object i.e. Resource }
  AddString(tStream,'/Kids ['+IntToStr(IObjCount+2)+' 0 R]');
  AddString(tStream,'/Count 1');
  AddString(tStream,'>>');
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.DefineXRef;
var i: Integer;
begin
  { finally, XRef part }
  Inc(IObjCount);
  tStream.Clear;
  AddString(tStream,'xref');
  AddString(tStream,'0 '+IntToStr(IObjCount));
  AddString(tStream,'0000000000 65535 f');
  { leave the x ref itself }
  for i:=0 to IObjCount-2 do
    AddString(tStream,ObjectOffsetList.Strings[i]+' 00000 n');
  AddString(tStream,'trailer');
  AddString(tStream,'<< /Size '+IntToStr(IObjCount));
  AddString(tStream,'/Root '+IntToStr(ICatalogNum)+' 0 R');
  AddString(tStream,'/Info 1 0 R');
  AddString(tStream,'>>');
  AddString(tStream,'startxref');
  AddString(tStream,Trim(ObjectOffsetList.Strings[IObjCount-1]));
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.DefineArray;
var i: Integer;
begin
  { Array part }
  Inc(IObjCount);
  IResourceNum := IObjCount;
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<< /ProcSet [/PDF /Text /ImageC]');
  AddString(tStream,'/Font << ');
  for i:=0 to FontList.Count-1 do
    AddString(tStream,'/'+PFontEntry(FontList.Items[i]).Name+ ' '+ IntToStr(PFontEntry(FontList.Items[i]).ObjPos)+' 0 R ');
  AddString(tStream,'>>');
  AddString(tStream,'>>');
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.DefinePage;
begin
  { Single page part }
  Inc(IObjCount);
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<< /Type /Page');
  AddString(tStream,'/Parent '+IntToStr(IParentNum)+' 0 R');
  AddString(tStream,'/MediaBox [ 0 0 '+IntToStr(IWidth)+' '+IntToStr(IHeight)+']');
  AddString(tStream,'/Contents 2 0 R');
  AddString(tStream,'/Resources '+IntToStr(IResourceNum)+' 0 R');
  AddString(tStream,'>>');
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; MoveTo0: boolean; DrawPie: boolean);

var fccwc: double;

    procedure Rotate(var ax,ay: double; Angle: double);
    var tx,ty: double;
        vcos, vsin: double;
    begin
      vcos := Cos(Angle);
      vsin := Sin(Angle);
      tx := ax;
      ty := ay;
      ax := vcos*tx - vsin*ty;
      ay := vsin*tx + vcos*ty;
    end;

    procedure ArcSegment(ax, ay, ra, rb, midtheta, hangle: double; amt0: Integer);
    var ax1,ay1,ax2,ay2,ax3,ay3: double;
        ax0,ay0: double;
        hTheta: double;
        vcos, vsin: double;
    begin
      { TODO : missing the b<>a case }
      htheta := Abs(hangle);
      vcos := Cos(htheta);
      vsin := Sin(htheta);

      ax0 := ra*vcos;
      ay0 := -fccwc*ra*vsin;
      Rotate(ax0,ay0,midtheta);

      if (amt0 = 1) then tmpSt := FormatFloat('0.000',ax+ax0)+ ' ' + FormatFloat('0.000',ay+ay0) + ' m'+#13+#10
      else if (amt0 = 0) then tmpSt := FormatFloat('0.000',ax+ax0)+ ' ' + FormatFloat('0.000',ay+ay0) + ' l'+#13+#10
      else tmpSt := '';

      ax1 := ra*(4.0 - vcos)/3.0;
      ax2 := ax1;
      ay1 := ra*fccwc *(1.0 - vcos) * (vcos - 3.0) / (3.0*vsin);
      ay2 := -ay1;
      ax3 := ra*vcos;
      ay3 := fccwc*ra*vsin;
      Rotate(ax1, ay1, midtheta);
      Rotate(ax2, ay2, midtheta);
      Rotate(ax3, ay3, midtheta);
      tmpSt := tmpSt+InternalBezCurve(ax+ax1,ay+ay1,ax+ax2,ay+ay2,ax+ax3,ay+ay3);
      FixSeparator(tmpSt);
      AddString(sStream,tmpSt);
  end;

var SegCount,i: Integer;
    CurrAngle, Span : double;
    AngleBump, hBump: double;
    x,y,a,b,StartAngle,EndAngle: double;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    AddString(sStream,PenProperties(Pen));
    if (Brush.Style<>bsClear) and (DrawPie) then
      AddString(sStream,BrushProperties(Brush));
    { center pos + radius }
    x := (X1 + X2)*0.5;
    y := (Y1 + Y2)*0.5;
    a := (X2 - X1)*0.5;
    b := (Y2 - Y1)*0.5;
    { StartAngle }
    CurrAngle := Math.ArcTan2(Y-Y3, X3 - X);
    if CurrAngle<0 then CurrAngle:=2.0*Pi+CurrAngle;
    StartAngle := CurrAngle;
    { EndAngle }
    Currangle := Math.ArcTan2(Y-Y4, X4 - X);
    if CurrAngle<=0 then CurrAngle:=2.0*Pi+CurrAngle;
    EndAngle := CurrAngle;


    If DrawPie then AddString(sStream,PointToStr(x,y)+' m');
    TranslateVertCoord(y);
    fccwc := 1.0;
    SegCount := 1;
    Span := EndAngle - StartAngle;
    if EndAngle < StartAngle then fccwc := -1.0;
    while (Abs(Span)/SegCount > Pi*0.5) do Inc(SegCount);

    AngleBump := Span/SegCount;
    hBump := 0.5*AngleBump;
    CurrAngle := StartAngle + hBump;
    for i := 0 to SegCount -1 do
    begin
      if i = 0 then ArcSegment(x,y,a,b,CurrAngle,hBump,Integer(MoveTo0))
      else ArcSegment(x,y,a,b,CurrAngle,hBump,-1);
      CurrAngle := CurrAngle + AngleBump;
    end;

    if (Brush.Style<>bsClear) and (DrawPie) then
      if (Pen.Style<>psClear) then AddString(sStream,'h B') else AddString(sStream,'h f')
    else if DrawPie then AddString(sStream,'s')
    else if Not(DrawPie) then AddString(sStream,'S');
  end;
end;

{ Transform ( , ) and \ characters}
function TPDFCanvas.TextToPDFText(AText: String): String;
begin
  AText := StringReplace(AText,'\','\\',[rfReplaceAll,rfIgnoreCase]);
  AText := StringReplace(AText,'(','\(',[rfReplaceAll,rfIgnoreCase]);
  AText := StringReplace(AText,')','\)',[rfReplaceAll,rfIgnoreCase]);
  Result := AText;
end;

function TPDFCanvas.TextHeight(const St: String): Integer;
begin
  Result := inherited TextHeight(St);
end;

function TPDFCanvas.TextWidth(const St: String): Integer;
begin
  Result := inherited TextWidth(St);
end;

{ TPDFExportFormat }
function TPDFExportFormat.Description: String;
begin
  result:=TeeMsg_AsPDF;
end;

function TPDFExportFormat.FileExtension: String;
begin
  result:='pdf';
end;

function TPDFExportFormat.FileFilter: String;
begin
  result:=TeeMsg_PDFFilter;
end;

procedure TPDFExportFormat.DoCopyToClipboard;
var
  buf: PChar;
  buflen : Integer;
begin
  With PDFList do
  try
    bufLen := Size;
    Position := 0;
    buf := AllocMem(buflen+1);
    try
      Read(buf^,buflen+1);
      ClipBoard.AsText:=buf; // SetTextBuf(buf);
    finally
      FreeMem(buf);
    end;
  finally
    Free;
  end;
end;

function TPDFExportFormat.Options(Check:Boolean): TForm;
begin
  result:=nil;
end;

procedure TPDFExportFormat.SaveToStream(Stream: TStream);
begin
  with PDFList do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

type TTeePanelAccess=class(TCustomTeePanel);

function TPDFExportFormat.PDFList: TMemoryStream;
var tmp : TCanvas3D;
begin { return a panel or chart in PDF format into a StringList }
  CheckSize;
  result:=TMemoryStream.Create;
  Panel.AutoRepaint:=False;
  try
    tmp:=TTeePanelAccess(Panel).InternalCanvas;
    TTeePanelAccess(Panel).InternalCanvas:=nil;
    Panel.Canvas:=TPDFCanvas.Create(Result);
    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
    finally
      Panel.Canvas:=tmp;
    end;
  finally
    Panel.AutoRepaint:=True;
  end;
end;

procedure TeeSaveToPDFFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);
begin { save panel or chart to filename in VML (html) format }
  with TPDFExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TPDFCanvas.TranslateVertCoord(var Y: double);
begin
  { vertical coordinate is reversed in PDF !! }
  Y := IHeight - Y;
end;

function TPDFCanvas.SetPenStyle(PenStyle: TPenStyle): String;
begin
  case PenStyle of
    psSolid : Result := '[ ] 0 d';
    psDash : Result := '[3 3] 0 d';
    psDot : Result := '[2] 1 d';
    psDashDot	: Result := '[3 2] 2 d';
    else Result := '[ ] 0 d';
  end;
end;

function TPDFCanvas.PenProperties(Pen: TPen): String;
begin
  Result := PDFColor(Pen.Color)+ ' RG ' +
            IntToStr(Pen.Width)+' w ' +
            SetPenStyle(Pen.Style);
end;

function TPDFCanvas.BrushProperties(Brush: TBrush): String;
begin
  Result := PDFColor(Brush.Color)+' rg';
end;

destructor TPDFCanvas.Destroy;
var i: Integer;
begin
  tStream.Free;
  sStream.Free;
  fStream.Free;
  ObjectOffsetList.Free;
  for i := 0 to FontList.Count -1 do
  begin
    FontEntry := FontList.Items[i];
    Dispose(FontEntry);
  end;
  FontList.Free;
  inherited Destroy;
end;

procedure TPDFCanvas.DefineHeader;
begin
  PDF.Clear;
  AddString(PDF,'%PDF-1.4');
  AddToOffset(PDF.Size);
  { Document info }
  Inc(IObjCount);
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<<');
  AddString(tStream,'/Creator ('+TeeMsg_Version+')');
  AddString(tStream,'/Producer ('+TeeMsg_Version+')');
  AddString(tStream,'/CreationDate (D:'+FormatDateTime('YYYYMMDDHHmmSS',Now)+')');
  AddString(tStream,'/ModDate ()');
  AddString(tStream,'/Keywords ()');
  AddString(tStream,'/Title (TChart Export)');
  AddString(tStream,'>>');
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.EndStream;
var TotalSize: Integer;
begin
  sStream.SaveToStream(tStream);
  sStream.Clear;
  AddString(tStream,'endstream');
  AddString(tStream,'endobj');
  IEndSize := 6;
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);

  TOtalSize := tStream.Size-IStartSize-IEndSize-Length('stream')-Length('endstream')-6;
  Inc(IObjCount);
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,IntToStr(TotalSize));
  AddString(tStream,'endobj');
  AddToOffset(tStream.Size);
  PDF.Seek(0, soFromEnd);
  tStream.SaveToStream(PDF);
end;

procedure TPDFCanvas.StartStream;
begin
  Inc(IObjCount);
  tStream.Clear;
  AddString(tStream,IntToStr(IObjCount)+' 0 obj');
  AddString(tStream,'<< /Length '+IntToStr(IObjCount+1)+' 0 R >>');
  IStartSize:= tStream.Size;
  AddString(tStream,'stream');
  sStream.Clear;
end;

procedure TPDFCanvas.AddToOffset(Offset: Integer);
var i,j: Integer;
  Result: String;
begin
  ObjectOffset := ObjectOffset+Offset;
  tmpSt := IntToStr(ObjectOffset);
  i := Length(tmpSt);
  Result:='';
  for j:= 1 to 10-i do
    Result := Result+'0';
  Result := Result+tmpSt;
  ObjectOffsetList.Add(Trim(Result));
end;

function TPDFCanvas.FontProperties(Font: TTeeFont; var FontIndex: Integer): String;
begin
  FontIndex := SelectFont(Font);
  Result := '/'+PFontEntry(FontList.Items[FontIndex]).Name+ ' ' +
            IntToStr(Font.InterCharSize) + ' Tc '
            +IntToStr(Font.Size)+' Tf';
end;

initialization
  RegisterTeeExportFormat(TPDFExportFormat);
finalization
  UnRegisterTeeExportFormat(TPDFExportFormat);
end.

