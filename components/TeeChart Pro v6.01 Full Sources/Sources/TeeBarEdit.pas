{**********************************************}
{   TBarSeries Component Editor Dialog         }
{   Copyright (c) 1996-2003 by David Berneda   }
{**********************************************}
unit TeeBarEdit;
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
     Chart, Series, TeeProcs, TeCanvas, TeePenDlg;

type
  TBarSeriesEditor = class(TForm)
    SEBarwidth: TEdit;
    Label1: TLabel;
    CBBarStyle: TComboFlat;
    LStyle: TLabel;
    BBarBrush: TButton;
    Label3: TLabel;
    SEBarOffset: TEdit;
    GroupBox1: TGroupBox;
    CBDarkBar: TCheckBox;
    CBBarSideMargins: TCheckBox;
    GroupBox2: TGroupBox;
    CBColorEach: TCheckBox;
    BBarColor: TButtonColor;
    CBMarksAutoPosition: TCheckBox;
    UDBarWidth: TUpDown;
    UDBarOffset: TUpDown;
    BGradient: TButton;
    BBarPen: TButtonPen;
    LBevel: TLabel;
    EBevel: TEdit;
    UDBevel: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure SEBarwidthChange(Sender: TObject);
    procedure CBBarStyleChange(Sender: TObject);
    procedure BBarBrushClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBDarkBarClick(Sender: TObject);
    procedure CBBarSideMarginsClick(Sender: TObject);
    procedure SEBarOffsetChange(Sender: TObject);
    procedure CBMarksAutoPositionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure EBevelChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Bar          : TCustomBarSeries;
    Procedure CheckControls;
    Procedure RefreshShape;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeEdiGrad, TeeStackBarEdit, TeeEdiSeri, TeeConst;

procedure TBarSeriesEditor.FormShow(Sender: TObject);
begin
  Bar:=TCustomBarSeries(Tag);
  if Assigned(Bar) then
  begin
    With Bar do
    begin
      CBBarStyle.ItemIndex :=Ord(BarStyle);
      UDBarWidth.Position  :=BarWidthPercent;
      UDBarOffset.Position :=OffsetPercent;
      CBColorEach.Checked  :=ColorEachPoint;
      CBMarksAutoPosition.Checked:=AutoMarkPosition;
      CBDarkBar.Checked    :=Dark3D;
      CBBarSideMargins.Checked:=SideMargins;
      BBarPen.LinkPen(BarPen);
      UDBevel.Position     :=BevelSize;
    end;

    CheckControls;

    BBarColor.LinkProperty(Bar,'SeriesColor');
    RefreshShape;
    if Assigned(Parent) and (Parent.Owner is TFormTeeSeries) then
    TFormTeeSeries(Parent.Owner).InsertSeriesForm(
          TStackBarSeriesEditor,1,TeeMsg_Stack,Bar);
  end;
  CreatingForm:=False;
end;

Procedure TBarSeriesEditor.RefreshShape;
Begin
  BBarColor.Enabled:=not Bar.ColorEachPoint;
  if BBarColor.Enabled then BBarColor.Repaint;
end;

procedure TBarSeriesEditor.SEBarWidthChange(Sender: TObject);
begin
  if not CreatingForm then 
     {$IFDEF CLX}
     if Assigned(Bar) then
     {$ENDIF}
	Bar.BarWidthPercent:=UDBarWidth.Position;
end;

Procedure TBarSeriesEditor.CheckControls;
begin
  BGradient.Enabled:=Bar.BarStyle=bsRectGradient;
  EnableControls(Bar.BarStyle=bsBevel,[LBevel,EBevel,UDBevel]);
end;

procedure TBarSeriesEditor.CBBarStyleChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Bar.BarStyle:=TBarStyle(CBBarStyle.ItemIndex);
    CheckControls;
  end;
end;

procedure TBarSeriesEditor.BBarBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Bar.BarBrush);
end;

procedure TBarSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Bar.ColorEachPoint:=CBColorEach.Checked;
    RefreshShape;
  end;
end;

procedure TBarSeriesEditor.CBDarkBarClick(Sender: TObject);
begin
  if not CreatingForm then Bar.Dark3D:=CBDarkBar.Checked;
end;

procedure TBarSeriesEditor.CBBarSideMarginsClick(Sender: TObject);
begin
  if not CreatingForm then Bar.SideMargins:=CBBarSideMargins.Checked;
end;

procedure TBarSeriesEditor.SEBarOffsetChange(Sender: TObject);
begin
  if not CreatingForm then
     {$IFDEF CLX}
     if Assigned(Bar) then
     {$ENDIF}
	Bar.OffsetPercent:=UDBarOffset.Position;
end;

procedure TBarSeriesEditor.CBMarksAutoPositionClick(Sender: TObject);
begin
  Bar.AutoMarkPosition:=CBMarksAutoPosition.Checked;
end;

procedure TBarSeriesEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  Align:=alClient;
end;

procedure TBarSeriesEditor.BGradientClick(Sender: TObject);
begin
  EditTeeGradient(Self,Bar.Gradient,True,True);
end;

procedure TBarSeriesEditor.EBevelChange(Sender: TObject);
begin
  if not CreatingForm then
     Bar.BevelSize:=UDBevel.Position;
end;

initialization
  RegisterClass(TBarSeriesEditor);
end.
