{**********************************************}
{   TWindRoseSeries Editor dialog              }
{   Copyright (c) 2000-2003 by David Berneda   }
{**********************************************}
unit TeeWindRoseEditor;
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
     TeePolarEditor, TeCanvas, TeePenDlg;

type
  TWindRoseEditor = class(TPolarSeriesEditor)
    procedure FormCreate(Sender: TObject);
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

procedure TWindRoseEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CBClockWise.Hide; // Visible:=False;
end;

initialization
  RegisterClass(TWindRoseEditor);
end.
