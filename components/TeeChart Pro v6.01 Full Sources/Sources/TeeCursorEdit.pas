{******************************************}
{ TCursorTool Editor Dialog                }
{ Copyright (c) 1999-2003 by David Berneda }
{******************************************}
unit TeeCursorEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Buttons,
     {$ENDIF}
     Chart, TeeTools, TeCanvas, TeePenDlg, TeeToolSeriesEdit;

type
  TCursorToolEditor = class(TSeriesToolEditor)
    BPen: TButtonPen;
    Label2: TLabel;
    CBStyle: TComboFlat;
    CBSnap: TCheckBox;
    CBFollow: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBSnapClick(Sender: TObject);
    procedure CBFollowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    CursorTool : TCursorTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine, TeeConst, TeeProCo;

procedure TCursorToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  CursorTool:=TCursorTool(Tag);
  if Assigned(CursorTool) then
  With CursorTool do
  begin
    CBStyle.ItemIndex :=Ord(Style);
    CBSnap.Checked    :=Snap;
    CBSnap.Enabled    :=Assigned(Series);
    CBFollow.Checked  :=FollowMouse;
    BPen.LinkPen(Pen);
  end;
end;

procedure TCursorToolEditor.CBSeriesChange(Sender: TObject);
begin
  inherited;
  CBSnap.Enabled:=Assigned(CursorTool.Series);
end;

procedure TCursorToolEditor.CBStyleChange(Sender: TObject);
begin
  CursorTool.Style:=TCursorToolStyle(CBStyle.ItemIndex);
end;

procedure TCursorToolEditor.CBSnapClick(Sender: TObject);
begin
  CursorTool.Snap:=CBSnap.Checked
end;

procedure TCursorToolEditor.CBFollowClick(Sender: TObject);
begin
  CursorTool.FollowMouse:=CBFollow.Checked
end;

procedure TCursorToolEditor.FormCreate(Sender: TObject);
begin
  inherited;
  Align:=alClient;
end;

initialization
  RegisterClass(TCursorToolEditor);
end.
