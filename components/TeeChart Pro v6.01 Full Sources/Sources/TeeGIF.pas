{**********************************************}
{   TeeChart GIF Export format                 }
{   Copyright (c) 2000-2003 by David Berneda   }
{**********************************************}
unit TeeGIF;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QForms, QStdCtrls, QExtCtrls, QControls,
     {$ELSE}
     Graphics, Forms, Controls, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$IFNDEF CLX}
     GIFImage,
     {$ENDIF}
     TeeProcs, TeeExport, TeCanvas;

type
  {$IFDEF CLX}
  TGIFImage=TBitmap;
  {$ENDIF}

  TTeeGIFOptions = class(TForm)
    RGCompression: TRadioGroup;
    Label1: TLabel;
    CBDither: TComboFlat;
    Label2: TLabel;
    CBReduction: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure RGCompressionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TGIFExportFormat=class(TTeeExportFormat)
  private
    Procedure CheckProperties;
  protected
    FProperties : TTeeGIFOptions;
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function GIF:TGIFImage;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     SysUtils, TeeConst;

function TGIFExportFormat.Description:String;
begin
  result:=TeeMsg_AsGIF;
end;

function TGIFExportFormat.FileFilter:String;
begin
  result:=TeeMsg_GIFFilter;
end;

function TGIFExportFormat.FileExtension:String;
begin
  result:='gif';
end;

Function TGIFExportFormat.GIF:TGIFImage;
var tmpBitmap : TBitmap;
    IGIFImage : TGIFImage;	
begin

  CheckProperties;
  CheckSize;
  IGIFImage:=TGIFImage.Create;
  With IGIFImage do
  begin
    {$IFNDEF CLX}
    // Compression:=TGIFCompression(FProperties.RGCompression.ItemIndex);
    //MM Pending Unisys decision
    Compression:=TGIFCompression(1); { 5.02 }
    DitherMode:=TDitherMode(FProperties.CBDither.ItemIndex);
    ColorReduction:=TColorReduction(FProperties.CBReduction.ItemIndex);
    {$ENDIF}

    tmpBitmap:=Panel.TeeCreateBitmap(Panel.Color,TeeRect(0,0,Self.Width,Self.Height));
    try
      Assign(tmpBitmap); { 5.01 }
    finally
      tmpBitmap.Free;
    end;
  end;
  result:=IGIFImage;
end;

Procedure TGIFExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties:=TTeeGIFOptions.Create(nil);
    FProperties.FormShow(Self);
  end;
end;

Function TGIFExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TGIFExportFormat.DoCopyToClipboard;
var tmp : TGIFImage;
begin
  tmp:=GIF;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TGIFExportFormat.SaveToStream(Stream:TStream);
begin
  With GIF do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

procedure TTeeGIFOptions.FormShow(Sender: TObject);
begin
  {$IFDEF CLX}
  CBDither.ItemIndex:=0;
  CBReduction.ItemIndex:=0;
  {$ELSE}
  CBDither.ItemIndex:=Ord(GIFImageDefaultDitherMode);
  CBReduction.ItemIndex:=Ord(rmNone);
  {$ENDIF}

  //RGCompression.ItemIndex:=Ord(GIFImageDefaultCompression);
  //MM Pending Unisys decision
  RGCompression.ItemIndex:=1;
end;

Procedure TTeeGIFOptions.RGCompressionClick(Sender: TObject);
begin
  {$IFNDEF TEEGIFCOMPRESSION}
  RGCompression.ItemIndex:=1; { 5.02 }
  {$ENDIF}
end;

procedure TTeeGIFOptions.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterTeeExportFormat(TGIFExportFormat);
finalization
  UnRegisterTeeExportFormat(TGIFExportFormat);
end.
