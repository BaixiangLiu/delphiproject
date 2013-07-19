{******************************************}
{    TPieSeries Editor Dialog              }
{ Copyright (c) 1996-2003 by David Berneda }
{******************************************}
unit TeePieEdit;
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
     Chart, Series, TeCanvas, TeePenDlg, TeeProcs;

type
  TPieSeriesEditor = class(TForm)
    CBDark3d: TCheckBox;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    CBOther: TComboFlat;
    Label6: TLabel;
    EOtherValue: TEdit;
    Label7: TLabel;
    EOtherLabel: TEdit;
    SEExpBig: TEdit;
    UDExpBig: TUpDown;
    CBPatterns: TCheckBox;
    BPen: TButtonPen;
    Label2: TLabel;
    Edit1: TEdit;
    UDAngleSize: TUpDown;
    BShadow: TButton;
    CBMarksAutoPosition: TCheckBox;
    Button2: TButton;
    CBDarkBorder: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBDark3dClick(Sender: TObject);
    procedure CBPatternsClick(Sender: TObject);
    procedure CBOtherChange(Sender: TObject);
    procedure EOtherValueChange(Sender: TObject);
    procedure EOtherLabelChange(Sender: TObject);
    procedure SEExpBigChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BShadowClick(Sender: TObject);
    procedure CBMarksAutoPositionClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBDarkBorderClick(Sender: TObject);
  private
    { Private declarations }
    Pie : TPieSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeEngine, TeeCircledEdit, TeeEdiSeri, TeeShadowEditor,
     TeeEdiLege;

procedure TPieSeriesEditor.FormShow(Sender: TObject);
var tmpCircled : TCircledSeriesEditor;
begin
  Pie:=TPieSeries(Tag);
  if Assigned(Pie) then
  begin
    With Pie do
    begin
      UDExpBig.Position  :=ExplodeBiggest;
      CBDark3D.Checked   :=Dark3D;
      CBDark3D.Enabled   :=ParentChart.View3D;
      CBPatterns.Checked :=UsePatterns;
      With OtherSlice do
      begin
        EOtherLabel.Text:=Text;
        EOtherValue.Text:=FloatToStr(Value);
        CBOther.ItemIndex:=Ord(Style);
        EnableControls(Style<>poNone,[EOtherLabel,EOtherValue]);
      end;
      UDAngleSize.Position:=AngleSize;
      CBMarksAutoPosition.Checked:=AutoMarkPosition;
      BPen.LinkPen(PiePen);
      CBDarkBorder.Checked:=DarkPen;
    end;

    tmpCircled:=TCircledSeriesEditor(
                   TFormTeeSeries(Parent.Owner).InsertSeriesForm(
                        TCircledSeriesEditor,1,TeeMsg_GalleryCircled,Pie));
    tmpCircled.BBack.Hide;
    tmpCircled.CBTransp.Hide;
    tmpCircled.BGradient.Hide;
  end;
end;

procedure TPieSeriesEditor.CBDark3DClick(Sender: TObject);
begin
  if Showing then Pie.Dark3D:=CBDark3D.Checked;
end;

procedure TPieSeriesEditor.CBPatternsClick(Sender: TObject);
begin
  Pie.UsePatterns:=CBPatterns.Checked;
end;

procedure TPieSeriesEditor.CBOtherChange(Sender: TObject);
begin
  With Pie.OtherSlice do
  begin
    Style:=TPieOtherStyle(CBOther.ItemIndex);
    EnableControls(Style<>poNone,[EOtherLabel,EOtherValue]);
  end;
end;

procedure TPieSeriesEditor.EOtherValueChange(Sender: TObject);
begin
  if EOtherValue.Text<>'' then
     Pie.OtherSlice.Value:=StrToFloat(EOtherValue.Text);
end;

procedure TPieSeriesEditor.EOtherLabelChange(Sender: TObject);
begin
  if Assigned(Pie) then // 5.02
     Pie.OtherSlice.Text:=EOtherLabel.Text;
end;

procedure TPieSeriesEditor.SEExpBigChange(Sender: TObject);
begin
  if Showing then Pie.ExplodeBiggest:=UDExpBig.Position;
end;

procedure TPieSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Pie.AngleSize:=UDAngleSize.Position;
end;

procedure TPieSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TPieSeriesEditor.BShadowClick(Sender: TObject);
begin
  EditTeeShadow(Self,Pie.Shadow);
end;

procedure TPieSeriesEditor.CBMarksAutoPositionClick(Sender: TObject);
begin
  Pie.AutoMarkPosition:=CBMarksAutoPosition.Checked;
end;

procedure TPieSeriesEditor.Button2Click(Sender: TObject);
begin
  with TFormTeeLegend.CreateLegend(Self,Pie.OtherSlice.Legend) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TPieSeriesEditor.CBDarkBorderClick(Sender: TObject);
begin
  Pie.DarkPen:=CBDarkBorder.Checked;
end;

initialization
  RegisterClass(TPieSeriesEditor);
end.
