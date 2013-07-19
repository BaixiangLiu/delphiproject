{**********************************************}
{   TTriSurfaceSeries Editor Dialog            }
{   Copyright (c) 1996-2003 by David Berneda   }
{**********************************************}
unit TeeTriSurfEdit;
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
     Chart, TeeSurfa, TeeTriSurface, TeCanvas, TeePenDlg, TeeProcs;

type
  TTriSurfaceSeriesEditor = class(TForm)
    Button2: TButtonPen;
    Button3: TButton;
    Button1: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Surface : TTriSurfaceSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeGriEd;

procedure TTriSurfaceSeriesEditor.FormShow(Sender: TObject);
begin
  Surface:=TTriSurfaceSeries(Tag);
  if Assigned(Surface) then
  begin
    Button2.LinkPen(Surface.Pen);
    Button1.LinkPen(Surface.Border);
    TeeInsertGrid3DForm(Parent,Surface);
  end;
end;

procedure TTriSurfaceSeriesEditor.Button3Click(Sender: TObject);
begin
  EditChartBrush(Self,Surface.Brush);
end;

procedure TTriSurfaceSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

initialization
  RegisterClass(TTriSurfaceSeriesEditor);
end.
