{******************************************}
{ TTeeCustomToolAxis Editor Dialog         }
{ Copyright (c) 1999-2003 by David Berneda }
{******************************************}
unit TeeAxisToolEdit;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeePenDlg, TeCanvas, TeeProcs, TeEngine;

type
  TAxisToolEditor = class(TForm)
    BPen: TButtonPen;
    CBAxis: TComboFlat;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CBAxisChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    AxisTool : TTeeCustomToolAxis;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeEdiAxis;

procedure TAxisToolEditor.FormShow(Sender: TObject);
begin
  AxisTool:=TTeeCustomToolAxis(Tag);
  if Assigned(AxisTool) then
  begin
    TeeAddAxes(AxisTool.ParentChart,CBAxis.Items,False);
    With AxisTool do
    begin
      BPen.LinkPen(Pen);
      With ParentChart,CBAxis do
      if Axis=LeftAxis then ItemIndex:=0 else
      if Axis=RightAxis then ItemIndex:=1 else
      if Axis=TopAxis then ItemIndex:=2 else
      if Axis=BottomAxis then ItemIndex:=3 else
         ItemIndex:=Axes.IndexOf(Axis)-1;
    end;
  end;
end;

procedure TAxisToolEditor.CBAxisChange(Sender: TObject);
begin
  With AxisTool do
  Case CBAxis.ItemIndex of
    -1: Axis:=nil;
     0: Axis:=ParentChart.LeftAxis;
     1: Axis:=ParentChart.RightAxis;
     2: Axis:=ParentChart.TopAxis;
     3: Axis:=ParentChart.BottomAxis;
  else
    Axis:=ParentChart.Axes[CBAxis.ItemIndex+1];
  end;
end;

procedure TAxisToolEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

initialization
  RegisterClass(TAxisToolEditor);
end.           
