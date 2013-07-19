{**********************************************}
{   TNearestToolEditor                         }
{   Copyright (c) 1999-2003 by David Berneda   }
{**********************************************}
unit TeeNearestToolEditor;
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
     TeeToolSeriesEdit, TeCanvas, TeePenDlg, TeeTools;

type
  TNearestToolEdit = class(TSeriesToolEditor)
    Button1: TButton;
    CBDrawLine: TCheckBox;
    Label2: TLabel;
    Edit1: TEdit;
    UDSize: TUpDown;
    Label3: TLabel;
    CBStyle: TComboFlat;
    BPen: TButtonPen;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBDrawLineClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
  private
    { Private declarations }
    Nearest : TNearestTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg;

procedure TNearestToolEdit.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Nearest.Brush);
end;

procedure TNearestToolEdit.FormShow(Sender: TObject);
begin
  inherited;
  Nearest:=TNearestTool(Tag);
  if Assigned(Nearest) then
  begin
    BPen.LinkPen(Nearest.Pen);
    CBDrawLine.Checked:=Nearest.DrawLine;
    CBStyle.ItemIndex:=Ord(Nearest.Style);
    UDSize.Position:=Nearest.Size;
  end;
end;

procedure TNearestToolEdit.CBDrawLineClick(Sender: TObject);
begin
  Nearest.DrawLine:=CBDrawLine.Checked;
end;

procedure TNearestToolEdit.Edit1Change(Sender: TObject);
begin
  if Showing then Nearest.Size:=UDSize.Position;
end;

procedure TNearestToolEdit.CBStyleChange(Sender: TObject);
begin
  Nearest.Style:=TNearestToolStyle(CBStyle.ItemIndex);
end;

initialization
  RegisterClass(TNearestToolEdit);
end.
