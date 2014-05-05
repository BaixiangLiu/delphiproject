{*******************************************}
{ TeeChart Pro Metafile exporting           }
{ Copyright (c) 1995-2003 by David Berneda  }
{         All Rights Reserved               }
{*******************************************}
unit TeeEmfOptions;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  TeeProcs, TeeExport;

type
  TEMFOptions = class(TForm)
    CBEnhanced: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TEMFExportFormat=class(TTeeExportFormat)
  private
    FProperties: TEMFOptions;
    Function Enhanced:Boolean;
  protected
    Procedure DoCopyToClipboard; override;
    function FileFilterIndex: Integer; override;
    procedure IncFileFilterIndex(var FilterIndex: Integer); override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function Metafile:TMetafile;
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
     TeCanvas, TeeConst;

function TEMFExportFormat.Description:String;
begin
  result:=TeeMsg_AsEMF;
end;

function TEMFExportFormat.FileFilter:String;
begin
  result:=TeeMsg_EMFFilter;
end;

function TEMFExportFormat.FileExtension:String;
begin
  if Enhanced then result:='emf' else result:='wmf';
end;

function TEMFExportFormat.FileFilterIndex: Integer;
begin
  if Enhanced then result:=FFilterIndex else result:=Succ(FFilterIndex);
end;

procedure TEMFExportFormat.IncFileFilterIndex(var FilterIndex: Integer);
begin
  inherited;
  Inc(FilterIndex);
end;

Function TEMFExportFormat.Metafile:TMetafile;
begin
  CheckSize;
  result:=Panel.TeeCreateMetafile(Enhanced,TeeRect(0,0,Width,Height));
end;

Function TEMFExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check and (not Assigned(FProperties)) then 
     FProperties:=TEMFOptions.Create(nil);
  result:=FProperties;
end;

Function TEMFExportFormat.Enhanced:Boolean;
begin
  if Assigned(FProperties) then result:=FProperties.CBEnhanced.Checked
                           else result:=True;
end;

procedure TEMFExportFormat.DoCopyToClipboard;
var tmp : TMetafile;
begin
  tmp:=Metafile;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TEMFExportFormat.SaveToStream(Stream:TStream);
begin
  With Metafile do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

initialization
  RegisterTeeExportFormat(TEMFExportFormat);
finalization
  UnRegisterTeeExportFormat(TEMFExportFormat);
end.
