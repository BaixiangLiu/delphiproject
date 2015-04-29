unit Thubar39;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TBarHStyle=(bheight1,bheight2,bheight3,bheight4,bheight5);
  TPRate=(PR1,PR2,PR3,PR4,PR5);
  THeadStrHeight=1..5;
  BarStrg = array [0..43] of string[22];
  ChkWord = array [0..42] of Char;

  THUBarcode39 = class(TGraphicControl)
  private
    { Private declarations }
    FPicture:TPicture;
    FHeadStr :String;
    FHeadStrHeight:THeadStrHeight;
    FBarcodeStr :String;
    FBarcodeHeight:TBarHStyle;
    FBarColor:TColor;
    FShowBarStr:Boolean;
    FCheckWord:Boolean;
    FAutoSize:Boolean;
    FPrintRate:TPRate;
    FTransparent:Boolean;
    procedure SetHeadStr(Value:String);
    procedure SetHeadStrHeight(Value:THeadStrHeight);
    procedure SetBarcodeStr(Value:String);
    procedure SetBarColor(Value:TColor);
    procedure SetShowBarStr(Value:Boolean);
    procedure SetBarcodeHeight(Value:TBarHStyle);
    procedure SetAutoSize(Value:Boolean);
    procedure SetCheckWord(Value:Boolean);
    procedure SetPicture(Value:TPicture);
    Procedure SetPrintRate(Value:TPRate);
    Procedure SetTransparent(Value:Boolean);
    procedure DrawBarCode(TargetCanvas : TCanvas; Barstr : String; PX,PY,PH,PFact,wordh,wordhf :integer);
    function  GetBarString(Value:String):String;
    function  GetCheckWord(Value:String):Char;
    function  GetCanvas:TCanvas;

    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);override;
    destructor  Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  published
    { Published declarations }
    property HeadStr:String read FHeadStr write SetHeadStr;
    property HeadStrHeight:THeadStrHeight read FHeadStrHeight Write SetHeadStrHeight default 1;
    property BarStr:String read FBarcodeStr write SetBarcodeStr;
    property BarcodeColor:TColor read FBarColor write SetBarColor default clBlack;
    property BarcodeHeight:TBarHStyle read FBarcodeHeight write SetBarcodeHeight default bheight3;
    property ShowBarStr:boolean read FShowBarStr Write SetShowBarStr Default True;
    property CheckWord:Boolean read FCheckWord write SetCheckWord Default False;
    property AutoSize:boolean read FAutosize write SetAutoSize Default True;
    property Picture:Tpicture read Fpicture write SetPicture;
    property PrintRate:TPRate read FPrintRate write SetPrintRate default PR3;
    property Transparent:Boolean read FTransparent write SetTransparent default False;

    property Height default 54;
    property Width default 120;
    Property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation
uses Consts;

 const
 BarWord : BarStrg =
('100100001111001111001',  (* 0 *)
 '111100100001001001111',  (* 1 *)
 '100111100001001001111',  (* 2 *)
 '111100111100001001001',  (* 3 *)
 '100100001111001001111',  (* 4 *)
 '111100100001111001001',  (* 5 *)
 '100111100001111001001',  (* 6 *)
 '100100001001111001111',  (* 7 *)
 '111100100001001111001',  (* 8 *)
 '100111100001001111001',  (* 9 *)
 '111100100100001001111',  (* A *)
 '100111100100001001111',  (* B *)
 '111100111100100001001',  (* C *)
 '100100111100001001111',  (* D *)
 '111100100111100001001',  (* E *)
 '100111100111100001001',  (* F *)
 '100100100001111001111',  (* G *)
 '111100100100001111001',  (* H *)
 '100111100100001111001',  (* I *)
 '100100111100001111001',  (* J *)
 '111100100100100001111',  (* K *)
 '100111100100100001111',  (* L *)
 '111100111100100100001',  (* M *)
 '100100111100100001111',  (* N *)
 '111100100111100100001',  (* O *)
 '100111100111100100001',  (* P *)
 '100100100111100001111',  (* Q *)
 '111100100100111100001',  (* R *)
 '100111100100111100001',  (* S *)
 '100100111100111100001',  (* T *)
 '111100001001001001111',  (* U *)
 '100001111001001001111',  (* V *)
 '111100001111001001001',  (* W *)
 '100001001111001001111',  (* X *)
 '111100001001111001001',  (* y *)
 '100001111001111001001',  (* Z *)
 '100001001001111001111',  (* - *)
 '111100001001001111001',  (* . *)
 '100001111001001111001',  (*   *)
 '1000010000100001001',    (* _ *)
 '1000010000100100001',    (* / *)
 '1000010010000100001',    (* + *)
 '1001000010000100001',    (* % *)
 '100001001111001111001'   (* * *)
 );
 CheckBWord : Chkword =
 ( '0','1','2','3','4','5','6','7','8','9','A',
   'B','C','D','E','F','G','H','I','J','K','L',
   'M','N','O','P','Q','R','S','T','U','V','W',
   'X','Y','Z','-','.',' ','$','/','+','%'
 );
constructor THUBarcode39.Create(AOwner : TComponent);
begin
 inherited Create(AOwner);
 FPicture:=TPicture.Create;
 FHeadStrHeight:=1;
 FBarcodeHeight:=bheight3;
 FBarColor:=clBlack;
 FShowBarStr:=True;
 FAutoSize:=True;
 Height := 54;
 Width := 120;
 FTransparent:=False;
 FPrintRate:=PR3;
 FCheckWord:=False;
end;

destructor  THUBarcode39.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

procedure THUBarcode39.DrawBarCode(TargetCanvas : TCanvas; Barstr : String; PX,PY,PH,PFact,wordh,wordhf :integer);
Var
 wordcont,linecont,lop,lop1,BarInd,barna : Integer;
 ch : Char;
 barcode : String[22];
 Flags:Word;
 Rect: TRect;
Begin
 Flags:=DT_CENTER or DT_WORDBREAK;
 Rect.Left:=PX;
 Rect.Top:=PY;
 Rect.Right:=(Width-5)*PFact;
// Rect.Bottom:=Rect.Top+wordh*2+wordhf;
 Rect.Bottom:=Rect.Top+wordh*FHeadstrHeight+wordhf*(FHeadStrHeight-1)+2*PFact;
 if FShowBarStr and (Length(FHeadStr)>0) then
   DrawText(TargetCanvas.Handle, PChar(FHeadStr), Length(FHeadStr), Rect, Flags);
 wordcont:=Length(Barstr);
 barna:=0;
 for lop:=1 to wordcont do begin
    ch:=Barstr[lop];
   BarInd := 0;    
   case ch of
   '0': BarInd:=0;
   '1': BarInd:=1;
   '2': BarInd:=2;
   '3': BarInd:=3;
   '4': BarInd:=4;
   '5': BarInd:=5;
   '6': BarInd:=6;
   '7': BarInd:=7;
   '8': BarInd:=8;
   '9': BarInd:=9;
   'A': BarInd:=10;
   'B': BarInd:=11;
   'C': BarInd:=12;
   'D': BarInd:=13;
   'E': BarInd:=14;
   'F': BarInd:=15;
   'G': BarInd:=16;
   'H': BarInd:=17;
   'I': BarInd:=18;
   'J': BarInd:=19;
   'K': BarInd:=20;
   'L': BarInd:=21;
   'M': BarInd:=22;
   'N': BarInd:=23;
   'O': BarInd:=24;
   'P': BarInd:=25;
   'Q': BarInd:=26;
   'R': BarInd:=27;
   'S': BarInd:=28;
   'T': BarInd:=29;
   'U': BarInd:=30;
   'V': BarInd:=31;
   'W': BarInd:=32;
   'X': BarInd:=33;
   'Y': BarInd:=34;
   'Z': BarInd:=35;
   '-': BarInd:=36;
   '.': BarInd:=37;
   ' ': BarInd:=38;
   '_': BarInd:=39;
   '/': BarInd:=40;
   '+': BarInd:=41;
   '%': BarInd:=42;
   '*': BarInd:=43;
   end;
  barcode:=BarWord[BarInd];
  linecont:=Length(barcode);
  TargetCanvas.Pen.Width := PFact;
  TargetCanvas.Pen.Color:=FBarColor;
  for lop1:=1 to linecont do begin
   if barcode[lop1]='1' then begin
     if FShowBarStr and (Length(FHeadStr)>0) then begin
//      TargetCanvas.MoveTo(PX+barna*PFact,PY+wordh*2+2*PFact+wordhf);
//      TargetCanvas.LineTo(PX+barna*PFact,PY+PH*PFact+wordh*2+2*PFact+wordhf);
      TargetCanvas.MoveTo(PX+barna*PFact,PY+wordh*FHeadStrHeight+2*PFact+wordhf*(FHeadStrHeight-1));
      TargetCanvas.LineTo(PX+barna*PFact,PY+PH*PFact+wordh*FHeadStrHeight+2*PFact+wordhf*(FHeadStrHeight-1));
     end
     else
     begin
      TargetCanvas.MoveTo(PX+barna*PFact,PY);
      TargetCanvas.LineTo(PX+barna*PFact,PY+PH*PFact);
     end;
   end;
   barna:=barna+1;
  end;
  barna:=barna+2;
 end;

 Rect.Left:=PX;
 Rect.Right:=(Width-5)*PFact;
 if FShowBarStr and (Length(FHeadStr)>0) then
 begin
//  Rect.Top:=PY+PH*PFact+wordh*FHeadStrHeight+4*PFact+wordhf;
  Rect.Top:=PY+PH*PFact+wordh*FHeadStrHeight+4*PFact+wordhf*(FheadStrHeight-1);
  Rect.Bottom:=Rect.Top+wordh;
 end
 else
 begin
  Rect.Top:=PY+PH*PFact+2*PFact;
  Rect.Bottom:=Rect.Top+wordh;
 end;
 if FShowBarStr  then
   DrawText(TargetCanvas.Handle, PChar(Barstr), Length(Barstr), Rect, Flags);
End;

function THUBarcode39.GetBarString(Value:String):String;
 var
     TempStr:String;
     lop,wordcont:integer;
     ch:Char;
begin
 wordcont:=Length(Value);
 Result:='';
 for lop:=1 to wordcont do begin
    ch:=value[lop];
   case ch of
    '0','1','2','3','4','5','6','7','8','9','A','B',
    'C','D','E','F','G','H','I','J','K','L','M','N',
    'O','P','Q','R','S','T','U','V','W','X','Y','Z','-',
    '.',' ','_','/','+','%','*'
     : begin
        TempStr:=ch;
        Result:=Result+TempStr;
       end;
   end;
 end;
end;

function THUBarcode39.GetCheckWord(Value:String):Char;
 var
     lop,wordcont,barval:integer;
     ch:Char;
begin
 wordcont:=Length(Value);
 if wordcont=0 then
   Result:=#0
 else
 begin
   barval:=0;
   for lop:=1 to wordcont do begin
      ch:=value[lop];
      barval:=barval+integer(ch);
   end;
   barval:=barval mod 43;
   Result:=CheckBWord[barval];
 end;
end;

function THUBarcode39.GetCanvas: TCanvas;
var
  Bitmap: TBitmap;
begin
  if Picture.Graphic = nil then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      Picture.Graphic := Bitmap;
    finally
      Bitmap.Free;
    end;
  end;
  if Picture.Graphic is TBitmap then
    Result := TBitmap(Picture.Graphic).Canvas;
//  else
//    raise EInvalidOperation.CreateRes(SImageCanvasNeedsBitmap);
end;


procedure THUBarcode39.SetHeadStr(Value:String);
begin
  if Value <> FHeadStr then
  begin
    FHeadStr:=Value;
    Invalidate;
  end;
end;

procedure THUBarcode39.SetBarcodeStr(Value:String);
begin
  if Value <> FBarcodeStr then
  begin
    FBarcodeStr:=Value;
    Invalidate;
  end;
end;

procedure THUBarcode39.SetBarcodeHeight(Value:TBarHStyle);
begin
  if Value <> FBarcodeHeight then
  begin
   FBarcodeHeight:=Value;
   Invalidate;
  end;
end;

procedure THUBarcode39.SetBarColor(Value:TColor);
begin
  if Value <> FBarColor then
  begin
    FBarColor:=Value;
    Invalidate;
  end;
end;

procedure THUBarcode39.SetHeadStrHeight(Value:THeadStrHeight);
begin
  if Value <> FHeadStrHeight then
  begin
   FHeadStrHeight:=Value;
   Invalidate;
  end;
end;


procedure THUBarcode39.SetShowBarStr(Value:Boolean);
begin
  if Value <> FShowBarStr then
  begin
    FShowBarStr:= Value;
    invalidate;
  end;
end;

procedure THUBarcode39.SetCheckWord(Value:Boolean);
begin
  if Value <> FCheckWord then
  begin
    FCheckWord:= Value;
    invalidate;
  end;
end;

procedure THUBarcode39.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    invalidate;
  end;
end;

procedure THUBarcode39.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

Procedure THUBarcode39.SetPrintRate(Value:TPRate);
begin
  if FPrintRate <> Value then
  begin
    FPrintRate := Value;
    invalidate;
  end;
end;

Procedure THUBarcode39.SetTransparent(Value:Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    invalidate;
  end;
end;

procedure THUBarcode39.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure THUBarcode39.CMFontChanged(var Message: TMessage);
begin
  inherited;
end;

procedure THUBarcode39.Paint;
 var PX,PY,PH,PFact,barLength,i,wordh,wordhf,wordth:integer;
     Barcode:String;
     PCanvasRect:TRect;
begin
PH:=12;
  case FBarcodeHeight of
    bheight1:  PH:=12;
    bheight2:  PH:=24;
    bheight3:  PH:=36;
    bheight4:  PH:=48;
    bheight5:  PH:=60;
  end;
  PX:=5;
  PY:=5;
  PFact:=1;
  if Length(BarStr) > 0 then
  begin
   Barcode:=BarStr;
   for i := 1 to Length(Barcode) do
     Barcode[i] := UpCase(Barcode[i]);
   Barcode:=GetBarString(Barcode);
   if FCheckWord=True then
    Barcode:=Barcode+GetCheckWord(Barcode);
   Barcode:='*'+Barcode+'*';
  end
  else
   Barcode:='';

  BarLength:=Length(Barcode);

  wordh:= abs(Font.Height); // 字高
  wordhf:= wordh div 2;     // 字列间格
  wordth:=0;
  if ShowBarStr then
  begin
    if Length(FHeadStr)>0 then
     wordth:=wordth+wordh*FHeadStrHeight+2+wordhf*(FHeadStrHeight-1);
 //    wordth:=wordth+wordh*2+2+wordhf;
    if Length(FBarcodeStr)>0 then
     wordth:=wordth+wordh+2;
  end;
  if FAutoSize then
  begin
    Height:=PH+10+wordth; // 10 为上下预留高度各 5
    Width:=Barlength*23+7;
  end;

// 画于 component Canvas
  with inherited Canvas do
  begin
    Font := self.Font;
    Brush.Style := bsClear;
    if FTransparent then
     Brush.Color := Self.Color
    else
     Brush.Color := clWhite;
    FillRect(ClientRect);
  end;
  DrawBarCode( inherited Canvas, Barcode, PX,PY,PH,PFact,wordh,wordhf);


 // 画于 picture Canvas
  PFact:=integer(FPrintRate);
  Canvas.Font := self.Font;
  Canvas.Brush.Style := bsClear;
  if FTransparent then
    Canvas.Brush.Color := Self.Color
  else
  begin
    Canvas.Brush.Color := clWhite;
  end;
  PCanvasRect:=ClientRect;
  PCanvasRect.Right:=PCanvasRect.Right*PFact;
  PCanvasRect.Bottom:=PCanvasRect.Bottom*PFact;
  Canvas.FillRect(PCanvasRect);
  FPicture.Graphic.Height:=Height*PFact;
  FPicture.Graphic.Width:=Width*PFact;

  Canvas.Font.Size:=Canvas.Font.Size*PFact;
  wordh:= abs(Canvas.Font.Height);
  wordhf:= wordh div 2 ;
  wordth:=0;
  if ShowBarStr then
  begin
    if Length(FHeadStr)>0 then
//     wordth:=wordth+wordh*2+2*PFact+wordhf;
     wordth:=wordth+wordh*FHeadStrHeight+2*PFact+wordhf*(FHeadStrHeight-1);
    if Length(FBarcodeStr)>0 then
     wordth:=wordth+wordh+2*PFact;
  end;
  PX:=PX*PFact;
  PY:=PY*PFact;

  DrawBarCode( Canvas, Barcode, PX,PY,PH,PFact,wordh,wordhf);
end;

procedure Register;
begin
  RegisterComponents('J_STD', [THUBarcode39]);
end;

end.
