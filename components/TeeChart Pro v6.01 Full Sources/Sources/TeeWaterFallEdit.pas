{**********************************************}
{   TWaterFallSeries Editor dialog             }
{   Copyright (c) 2000-2003 by David Berneda   }
{**********************************************}
unit TeeWaterFallEdit;
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
     TeeSurfEdit, TeCanvas, TeePenDlg;

type
  TWaterFallEditor = class(TSurfaceSeriesEditor)
    BLines: TButtonPen;
    procedure FormShow(Sender: TObject);
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

Uses TeeSurfa;

procedure TWaterFallEditor.FormShow(Sender: TObject);
begin
  inherited;
  if Tag<>0 then
     BLines.LinkPen(TWaterFallSeries(Tag).WaterLines);
end;

initialization
  RegisterClass(TWaterFallEditor);
end.
