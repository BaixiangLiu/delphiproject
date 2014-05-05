{******************************************}
{ TGanttSeries Editor Dialog               }
{ Copyright (c) 1996-2003 by David Berneda }
{******************************************}
unit TeeGanttEdi;
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
     Chart, GanttCh, TeCanvas, TeePenDlg, TeeProcs;

type
  TGanttSeriesEditor = class(TForm)
    Label2: TLabel;
    SEPointVertSize: TEdit;
    BConnLines: TButtonPen;
    UDPointVertSize: TUpDown;
    GPLine: TGroupBox;
    BColor: TButtonColor;
    CBColorEach: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SEPointVertSizeChange(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure BColorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TheSeries    : TGanttSeries;
    procedure RefreshShape;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeEngine, Series, TeePoEdi, TeeConst;

procedure TGanttSeriesEditor.RefreshShape;
begin
  BColor.Enabled:=not TheSeries.ColorEachPoint;
end;

procedure TGanttSeriesEditor.FormShow(Sender: TObject);
begin
  TheSeries:=TGanttSeries(Tag);
  if Assigned(TheSeries) then
  begin
    With TheSeries do
    begin
      UDPointVertSize.Position := Pointer.VertSize;
      CBColorEach.Checked      := ColorEachPoint;
      BConnLines.LinkPen(ConnectingPen);
    end;
    BColor.LinkProperty(TheSeries,'SeriesColor');
    RefreshShape;

    with TeeInsertPointerForm(Parent,TheSeries.Pointer,TeeMsg_GalleryGantt) as
         TSeriesPointerEditor do
            HideSizeOptions;
  end;
end;

procedure TGanttSeriesEditor.SEPointVertSizeChange(Sender: TObject);
begin
  if Showing then TheSeries.Pointer.VertSize:=UDPointVertSize.Position;
end;

procedure TGanttSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  TheSeries.ColorEachPoint:=CBColorEach.Checked;
  RefreshShape;
end;

procedure TGanttSeriesEditor.BColorClick(Sender: TObject);
begin
  TheSeries.ColorEachPoint:=False;
end;

procedure TGanttSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

initialization
  RegisterClass(TGanttSeriesEditor);
end.
