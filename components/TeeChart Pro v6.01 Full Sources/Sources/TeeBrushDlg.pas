{******************************************}
{    TeeChart. TBrushDialog                }
{ Copyright (c) 1996-2003 by David Berneda }
{******************************************}
unit TeeBrushDlg;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, Types,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  TeCanvas, TeePenDlg;

type
  TBrushDialog = class(TForm)
    Button2: TButton;
    BColor: TButtonColor;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Image1: TImage;
    LStyle: TListBox;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure LStyleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    {$IFDEF CLX}
    procedure LStyleDrawItem(Sender: TObject; Index: Integer;
        Rect: TRect;  State: TOwnerDrawState; var Handled: Boolean);
    {$ELSE}
    procedure LStyleDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}
  private
    { Private declarations }
    BackupBrush : TChartBrush;
    Procedure CheckImageButton;
    procedure RedrawShape;
  public
    { Public declarations }
    TheBrush : TChartBrush;
  end;

Function EditChartBrush( AOwner:TComponent;
                          ChartBrush:TChartBrush):Boolean;

Function EditTeeFont(AOwner:TComponent; AFont:TTeeFont):Boolean;

Function TeeGetPictureFileName(AOwner:TComponent):String;

procedure TeeLoadClearImage(AOwner:TComponent; AImage:TPicture);

Procedure GetTeeBrush(Index:Integer; ABitmap:TBitmap);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$R TeeBrushes.res}

Uses {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     TeeConst, TeeProcs;

Function EditTeeFont(AOwner:TComponent; AFont:TTeeFont):Boolean;
Begin
  result:=False;
  With TFontDialog.Create(AOwner) do
  try
    Font.Assign(AFont);
    if Execute then
    begin
      AFont.Assign(Font);
      result:=True;
    end;
  finally
    Free;
  end;
end;

Function EditChartBrush( AOwner:TComponent;
                         ChartBrush:TChartBrush):Boolean;
var tmp : TBrushDialog;
Begin
  tmp:=TeeCreateForm(TBrushDialog,AOwner) as TBrushDialog;
  with tmp do
  try
    TheBrush:=ChartBrush;
    TeeTranslateControl(tmp);
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Function TeeGetPictureFileName(AOwner:TComponent):String;
begin
  result:='';
  With {$IFDEF CLX}TOpenDialog{$ELSE}TOpenPictureDialog{$ENDIF}.Create(AOwner) do
  try
    {$IFDEF CLX}
    DefaultExt:='bmp';
    Filter:='All (*.bmp; *.ico; *.png; *.xpm)|Bitmaps (*.bmp)|Icons (*.ico)|'+
            'Portable Network Graphics (*.png)|X Pixmaps (*.xpm)';
    Options:=[ofAllowMultiSelect];
    Title:='Add Images';
    {$ENDIF}
    if Execute then result:=FileName;
  finally
    Free;
  end;
end;

procedure TeeLoadClearImage(AOwner:TComponent; AImage:TPicture);
var tmp : String;
begin
  if Assigned(AImage.Graphic) then AImage.Assign(nil)
  else
  begin
    tmp:=TeeGetPictureFileName(AOwner);
    if tmp<>'' then AImage.LoadFromFile(tmp);
  end;
end;

{ TBrushDialog }
procedure TBrushDialog.RedrawShape;
begin
  BColor.Enabled:=TheBrush.Style<>bsClear;
end;

procedure TBrushDialog.FormShow(Sender: TObject);
begin
  BackupBrush:=TChartBrush.Create(nil);
  if Assigned(TheBrush) then
  begin
    BackupBrush.Assign(TheBrush);

    LStyle.ItemIndex:=Ord(TheBrush.Style);

    BColor.LinkProperty(TheBrush,'Color');

    CheckImageButton;
    RedrawShape;
  end;
end;

procedure TBrushDialog.Button3Click(Sender: TObject);
begin
  TheBrush.Assign(BackupBrush);
  ModalResult:=mrCancel;
end;

procedure TBrushDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BackupBrush.Free;
end;

procedure TBrushDialog.Button1Click(Sender: TObject);
var tmp       : String;
    tmpBitmap : TBitmap;
begin
  if LStyle.ItemIndex>7 then LStyle.ItemIndex:=Ord(TheBrush.Style);
  if Button1.Tag=1 then TheBrush.Image.Assign(nil)
  else
  begin
    tmp:=TeeGetPictureFileName(Self);
    if tmp<>'' then
    begin
      TheBrush.Image.LoadFromFile(tmp);
      if not (TheBrush.Image.Graphic is TBitmap) then
      begin
        tmpBitmap:=TBitmap.Create;
        with tmpBitmap do
        begin
          Width:=TheBrush.Image.Width;
          Height:=TheBrush.Image.Height;
          Canvas.Draw(0,0,TheBrush.Image.Graphic);
        end;

        TheBrush.Image.Bitmap:=tmpBitmap; // 5.03
      end;
    end;
  end;
  CheckImageButton;
end;

Procedure TBrushDialog.CheckImageButton;
begin
  if Assigned(TheBrush.Image.Graphic) then
  begin
    Button1.Tag:=1;
    Button1.Caption:=TeeMsg_ClearImage;
    Image1.Picture.Assign(TheBrush.Image);
  end
  else
  begin
    Button1.Tag:=0;
    Button1.Caption:=TeeMsg_BrowseImage;
    Image1.Picture:=nil;
  end;
end;

procedure TBrushDialog.FormCreate(Sender: TObject);
begin  
  BorderStyle:=TeeBorderStyle;
end;

{$IFDEF CLX}
procedure TBrushDialog.LStyleDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ELSE}
procedure TBrushDialog.LStyleDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ENDIF}
Var Old : TColor;
begin
  With TControlCanvas(LStyle.Canvas) do
  begin
    FillRect(Rect);
    if Index<>1 then
    begin
      if Index>7 then
      begin
        {$IFNDEF CLX}
        Brush.Bitmap.Free;
        Brush.Bitmap:=TBitmap.Create;
        {$ENDIF}
        GetTeeBrush(Index-8,Brush.Bitmap);
      end
      else
      begin
        Brush.Style:=TBrushStyle(Index);
        Brush.Color:=clBlack;
      end;
      {$IFDEF CLX}
      Old:=Font.Color;
      Font.Color:=clBlack;
      {$ELSE}
      SetBkColor(Handle,clWhite);
      SetBkMode(Handle,Transparent);
      Old:=GetTextColor(Handle);
      SetTextColor(Handle,clBlack);
      {$ENDIF}

      {$IFDEF CLX}
      if Index>7 then
         Draw(Rect.Left+2,Rect.Top+2,Brush.Bitmap)
      else
         With Rect do FillRect(Classes.Rect(Left+2,Top+2,Left+16,Bottom-2));
      {$ELSE}
      With Rect do FillRect(Classes.Rect(Left+2,Top+2,Left+16,Bottom-2));
      {$ENDIF}

      {$IFDEF CLX}
      Font.Color:=Old;
      {$ELSE}
      Brush.Bitmap.Free;
      SetTextColor(Handle,Old);
      {$ENDIF}
    end;
    Brush.Style:=bsClear;
    {$IFDEF CLX}
    Font.Color:=clBlack;
    {$ELSE}
    UpdateTextFlags;
    {$ENDIF}
    TextOut(Rect.Left+20,Rect.Top+1,LStyle.Items[Index]);
  end;
end;

procedure TBrushDialog.LStyleClick(Sender: TObject);
begin
  // TheBrush.Image.Assign(nil);
  if LStyle.ItemIndex>7 then
     GetTeeBrush(LStyle.ItemIndex-8,TheBrush.Image.Bitmap)
  else
  begin
    TheBrush.Style:=TBrushStyle(LStyle.ItemIndex);
    TheBrush.Image:=nil;
  end;
  CheckImageButton;
  RedrawShape;
end;

Procedure GetTeeBrush(Index:Integer; ABitmap:TBitmap);
begin
  ABitmap.LoadFromResourceName(HInstance,'TeeBrush'+TeeStr(1+Index));
  ABitmap.TransparentMode:=tmFixed;
  ABitmap.TransparentColor:=clWhite;
end;

end.
