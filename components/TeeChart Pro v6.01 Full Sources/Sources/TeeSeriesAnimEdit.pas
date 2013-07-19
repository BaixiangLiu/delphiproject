{******************************************}
{ TSeriesAnimationTool Editor Dialog       }
{ Copyright (c) 2002-2003 by David Berneda }
{******************************************}
unit TeeSeriesAnimEdit;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, TeCanvas,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  TeeToolSeriesEdit, TeeProcs, TeeTools;

type
  TSeriesAnimToolEditor = class(TSeriesToolEditor)
    Label2: TLabel;
    SBSteps: TScrollBar;
    Label3: TLabel;
    CBStartMin: TCheckBox;
    Label4: TLabel;
    EStart: TEdit;
    Button1: TButton;
    Label5: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBStartMinClick(Sender: TObject);
    procedure EStartChange(Sender: TObject);
    procedure SBStepsChange(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    AnimTool : TSeriesAnimationTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TSeriesAnimToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  AnimTool:=TSeriesAnimationTool(Tag);
  if Assigned(AnimTool) then
  With AnimTool do
  begin
    SBSteps.Position:=Steps;
    Label3.Caption:=IntToStr(Steps);
    CBStartMin.Checked:=StartAtMin;
    EStart.Text:=FloatToStr(StartValue);
    EStart.Enabled:=not CBStartMin.Checked;
    UpDown1.Position:=DrawEvery;
    Button1.Enabled:=Assigned(Series);
  end;
end;

procedure TSeriesAnimToolEditor.Button1Click(Sender: TObject);
begin
  Button1.Enabled:=False;
  try
    AnimTool.Execute;
  finally
    Button1.Enabled:=True;
  end;
end;

procedure TSeriesAnimToolEditor.CBStartMinClick(Sender: TObject);
begin
  AnimTool.StartAtMin:=CBStartMin.Checked;
  EStart.Enabled:=not CBStartMin.Checked;
end;

procedure TSeriesAnimToolEditor.EStartChange(Sender: TObject);
begin
  AnimTool.StartValue:=StrToFloatDef(EStart.Text,AnimTool.StartValue);
end;

procedure TSeriesAnimToolEditor.SBStepsChange(Sender: TObject);
begin
  AnimTool.Steps:=SBSteps.Position;
  Label3.Caption:=IntToStr(AnimTool.Steps);
end;

procedure TSeriesAnimToolEditor.CBSeriesChange(Sender: TObject);
begin
  inherited;
  Button1.Enabled:=Assigned(AnimTool.Series);
end;

procedure TSeriesAnimToolEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     AnimTool.DrawEvery:=UpDown1.Position;
end;

initialization
  RegisterClass(TSeriesAnimToolEditor);
end.
