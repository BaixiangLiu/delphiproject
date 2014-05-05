{******************************************}
{ TSeriesTool Editor Dialog                }
{ Copyright (c) 1999-2003 by David Berneda }
{******************************************}
unit TeeToolSeriesEdit;
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
     TeeProcs, TeEngine, TeCanvas;

type
  TSeriesToolEditor = class(TForm)
    Label1: TLabel;
    CBSeries: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    Tool : TTeeCustomToolSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeeProCo;

procedure TSeriesToolEditor.FormShow(Sender: TObject);
begin
  Tool:=TTeeCustomToolSeries(Tag);
  if Assigned(Tool) then
  With Tool,CBSeries do
  begin
    FillSeriesItems(Items,ParentChart);
    Enabled:=ParentChart.SeriesCount>0;
    Items.InsertObject(0,TeeMsg_None,nil);
    ItemIndex:=Items.IndexOfObject(Series);
  end;
end;

procedure TSeriesToolEditor.CBSeriesChange(Sender: TObject);
begin
  With CBSeries do Tool.Series:=TChartSeries(Items.Objects[ItemIndex]);
end;

procedure TSeriesToolEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TSeriesToolEditor);
end.
