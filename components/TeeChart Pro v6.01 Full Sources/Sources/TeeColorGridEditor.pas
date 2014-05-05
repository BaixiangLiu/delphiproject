{**********************************************}
{   TColorGridSeries Editor dialog             }
{   Copyright (c) 2000-2003 by David Berneda   }
{**********************************************}
unit TeeColorGridEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     TeeGriEd, TeCanvas, TeePenDlg;

type
  TColorGridEditor = class(TGrid3DSeriesEditor)
    BGrid: TButtonPen;
    CBCentered: TCheckBox;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBCenteredClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeSurfa, TeeBrushDlg, TeEngine;

procedure TColorGridEditor.FormShow(Sender: TObject);
begin
  inherited;
  ShowControls(False,[LDepth,EDepth,UDDepth]);
  if Tag<>0 then
  with TColorGridSeries(Tag) do
  begin
    BGrid.LinkPen(Pen);
    CBCentered.Checked:=CenteredPoints;
  end;
end;

procedure TColorGridEditor.FormCreate(Sender: TObject);
begin
  inherited;
  Align:=alClient;
end;

procedure TColorGridEditor.CBCenteredClick(Sender: TObject);
begin
  TColorGridSeries(Tag).CenteredPoints:=CBCentered.Checked;
end;

procedure TColorGridEditor.Button2Click(Sender: TObject);
var tmpSt : String;
    tmp   : TPicture;
begin
  tmpSt:=TeeGetPictureFileName(Self);
  if tmpSt<>'' then
  begin
    tmp:=TPicture.Create;
    try
      tmp.LoadFromFile(tmpSt);
      TColorGridSeries(Tag).Bitmap:=tmp.Bitmap;
      BRemove.Enabled:=HasColors(TColorGridSeries(Tag));
    finally
      tmp.Free;
    end;
  end;
end;

initialization
  RegisterClass(TColorGridEditor);
end.
