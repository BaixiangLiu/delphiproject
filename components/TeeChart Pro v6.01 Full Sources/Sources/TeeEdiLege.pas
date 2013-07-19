{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2003 by David Berneda    }
{**********************************************}
unit TeeEdiLege;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     Chart, TeeCustomShapeEditor, TeeProcs, TeCanvas, TeePenDlg;

type
  TFormTeeLegend = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    L12: TLabel;
    L7: TLabel;
    CBShow: TCheckBox;
    CBInverted: TCheckBox;
    CBLegendStyle: TComboFlat;
    CBLegStyle: TComboFlat;
    CBBoxes: TCheckBox;
    BDivLines: TButtonPen;
    TabSheet2: TTabSheet;
    L11: TLabel;
    SEColWi: TEdit;
    UDColWi: TUpDown;
    Label2: TLabel;
    CBColWUnits: TComboFlat;
    Label3: TLabel;
    CBSymbolPos: TComboFlat;
    TabSheet3: TTabSheet;
    CBResizeChart: TCheckBox;
    L10: TLabel;
    SETopPos: TEdit;
    UDTopPos: TUpDown;
    L1: TLabel;
    SEMargin: TEdit;
    UDMargin: TUpDown;
    RGPosition: TRadioGroup;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    Label5: TLabel;
    ECustTop: TEdit;
    UDTop: TUpDown;
    Label1: TLabel;
    EVertSpacing: TEdit;
    UDVertSpacing: TUpDown;
    CBCustPos: TCheckBox;
    CBFontColor: TCheckBox;
    CBContinuous: TCheckBox;
    CBVisible: TCheckBox;
    CBSymPen: TCheckBox;
    BSymPen: TButtonPen;
    CBSquared: TCheckBox;
    procedure SEMarginChange(Sender: TObject);
    procedure CBLegendStyleChange(Sender: TObject);
    procedure SEColWiChange(Sender: TObject);
    procedure SETopPosChange(Sender: TObject);
    procedure CBLegStyleChange(Sender: TObject);
    procedure CBShowClick(Sender: TObject);
    procedure CBResizeChartClick(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBBoxesClick(Sender: TObject);
    procedure EVertSpacingChange(Sender: TObject);
    procedure CBColWUnitsChange(Sender: TObject);
    procedure CBSymbolPosChange(Sender: TObject);
    procedure RGPositionClick(Sender: TObject);
    procedure ECustLeftChange(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure CBCustPosClick(Sender: TObject);
    procedure CBFontColorClick(Sender: TObject);
    procedure CBContinuousClick(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure CBSymPenClick(Sender: TObject);
    procedure CBSquaredClick(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    FLegend      : TChartLegend;
    ITeeObject   : TFormTeeShape;
    Function CanChangePos:Boolean;
    Procedure EnableCustomPosition;
    Procedure EnableMarginControls;
    Procedure EnableWidthControls;
    procedure SetLegend(Value:TChartLegend);
  public
    { Public declarations }
    Constructor Create(Owner:TComponent); override;
    Constructor CreateLegend(Owner:TComponent; ALegend:TChartLegend);
    property Legend:TChartLegend read FLegend write SetLegend;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine;

Constructor TFormTeeLegend.CreateLegend(Owner:TComponent; ALegend:TChartLegend);
begin
  Create(Owner);
  Legend:=ALegend;
end;

Constructor TFormTeeLegend.Create(Owner:TComponent);
begin
  inherited;
  CreatingForm:=True;
end;

procedure TFormTeeLegend.SetLegend(Value:TChartLegend);
begin
  FLegend:=Value;
  ITeeObject:=InsertTeeObjectForm(PageControl1,FLegend);
end;

procedure TFormTeeLegend.SEMarginChange(Sender: TObject);
begin
  if not CreatingForm then
  With FLegend do
  if Vertical then HorizMargin:=UDMargin.Position
              else VertMargin:=UDMargin.Position;
end;

procedure TFormTeeLegend.CBLegendStyleChange(Sender: TObject);
begin
  FLegend.LegendStyle:=TLegendStyle(CBLegendStyle.ItemIndex);
end;

procedure TFormTeeLegend.SEColWiChange(Sender: TObject);
begin
  if not CreatingForm then FLegend.Symbol.Width:=UDColWi.Position;
end;

procedure TFormTeeLegend.SETopPosChange(Sender: TObject);
begin
  if not CreatingForm then FLegend.TopPos:=UDTopPos.Position;
end;

procedure TFormTeeLegend.CBLegStyleChange(Sender: TObject);
begin
  FLegend.TextStyle:=TLegendTextStyle(CBLegStyle.ItemIndex);
end;

procedure TFormTeeLegend.CBShowClick(Sender: TObject);
begin
  FLegend.Visible:=CBShow.Checked;
end;

procedure TFormTeeLegend.CBResizeChartClick(Sender: TObject);
begin
  FLegend.ResizeChart:=CBResizeChart.Checked;
end;

procedure TFormTeeLegend.CBInvertedClick(Sender: TObject);
begin
  FLegend.Inverted:=CBInverted.Checked;
end;

procedure TFormTeeLegend.FormShow(Sender: TObject);
begin
  if Assigned(FLegend) then
  begin
    With FLegend do
    begin
      With Symbol do
      begin
        UDColWi.Position:=Width;
        if WidthUnits=lcsPercent then CBColWUnits.ItemIndex:=0
                                 else CBColWUnits.ItemIndex:=1;
        if Position=spLeft then CBSymbolPos.ItemIndex:=0
                           else CBSymbolPos.ItemIndex:=1;
        CBContinuous.Checked:=Continuous;
        CBSquared.Checked:=Squared;
        CBVisible.Checked:=Visible;
        CBSymPen.Checked:=DefaultPen;
        BSymPen.LinkPen(Pen);
        BSymPen.Enabled:=not DefaultPen;
      end;

      UDTopPos.Position      :=TopPos;

      CBCustPos.Checked      :=CustomPosition;
      UDLeft.Position        :=Left;
      ECustLeft.Text         :=IntToStr(Left);
      UDTop.Position         :=Top;
      ECustTop.Text          :=IntToStr(Top);

      CBFontColor.Checked    :=FontSeriesColor;
      CBResizeChart.Checked  :=ResizeChart;
      CBLegendStyle.ItemIndex:=Ord(LegendStyle);
      CBLegStyle.ItemIndex   :=Ord(TextStyle);
      CBShow.Checked         :=Visible;
      CBInverted.Checked     :=Inverted;
      CBBoxes.Checked        :=CheckBoxes;
      RGPosition.ItemIndex   :=Ord(Alignment);
      UDVertSpacing.Position :=VertSpacing;
      BDivLines.LinkPen(DividingLines);
      EnableMarginControls;
      EnableCustomPosition;
      EnableWidthControls;
    end;

    ITeeObject.RefreshControls(FLegend);
  end;
  CreatingForm:=False;
end;

Procedure TFormTeeLegend.EnableWidthControls;
begin
  EnableControls(not FLegend.Symbol.Squared,[UDColWi,SEColWi]);
end;

Procedure TFormTeeLegend.EnableCustomPosition;
var tmp : Boolean;
    Old : Boolean;
begin
  Old:=CreatingForm;
  CreatingForm:=True;
  tmp:=FLegend.CustomPosition;
  ECustLeft.Enabled :=tmp;
  ECustTop.Enabled  :=tmp;
  UDLeft.Enabled    :=tmp;
  UDTop.Enabled     :=tmp;
  if tmp then
  begin
    UDLeft.Position :=FLegend.Left;
    UDTop.Position  :=FLegend.Top;
  end;
  CBResizeChart.Enabled:=not tmp;
  UDMargin.Enabled:=not tmp;
  SEMargin.Enabled:=not tmp;
  SETopPos.Enabled:=not tmp;
  UDTopPos.Enabled:=not tmp;
  CreatingForm:=Old;
end;

Procedure TFormTeeLegend.EnableMarginControls;
begin
  With FLegend do
  if Vertical then UDMargin.Position:=HorizMargin
              else UDMargin.Position:=VertMargin;
end;

procedure TFormTeeLegend.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TFormTeeLegend.CBBoxesClick(Sender: TObject);
begin
  FLegend.CheckBoxes:=CBBoxes.Checked;
end;

procedure TFormTeeLegend.EVertSpacingChange(Sender: TObject);
begin
  if not CreatingForm then
     FLegend.VertSpacing:=UDVertSpacing.Position;
end;

procedure TFormTeeLegend.CBColWUnitsChange(Sender: TObject);
begin
  if CBColWUnits.ItemIndex=0 then
     FLegend.Symbol.WidthUnits:=lcsPercent
  else
     FLegend.Symbol.WidthUnits:=lcsPixels;
end;

procedure TFormTeeLegend.CBSymbolPosChange(Sender: TObject);
begin
  if CBSymbolPos.ItemIndex=0 then FLegend.Symbol.Position:=spLeft
                             else FLegend.Symbol.Position:=spRight;
end;

procedure TFormTeeLegend.RGPositionClick(Sender: TObject);
begin
  FLegend.Alignment:=TLegendAlignment(RGPosition.ItemIndex);
end;

Function TFormTeeLegend.CanChangePos:Boolean;
begin
  result:=(not CreatingForm) and (FLegend.CustomPosition);
end;

procedure TFormTeeLegend.ECustLeftChange(Sender: TObject);
begin
  if CanChangePos then FLegend.Left:=UDLeft.Position;
end;

procedure TFormTeeLegend.ECustTopChange(Sender: TObject);
begin
  if CanChangePos then FLegend.Top:=UDTop.Position;
end;

procedure TFormTeeLegend.CBCustPosClick(Sender: TObject);
begin
  FLegend.CustomPosition:=CBCustPos.Checked;
  EnableCustomPosition;
end;

procedure TFormTeeLegend.CBFontColorClick(Sender: TObject);
begin
  FLegend.FontSeriesColor:=CBFontColor.Checked
end;

procedure TFormTeeLegend.CBContinuousClick(Sender: TObject);
begin
  FLegend.Symbol.Continuous:=CBContinuous.Checked
end;

procedure TFormTeeLegend.CBVisibleClick(Sender: TObject);
begin
  FLegend.Symbol.Visible:=CBVisible.Checked
end;

procedure TFormTeeLegend.CBSymPenClick(Sender: TObject);
begin
  FLegend.Symbol.DefaultPen:=CBSymPen.Checked;
  BSymPen.Enabled:=not CBSymPen.Checked;
end;

procedure TFormTeeLegend.CBSquaredClick(Sender: TObject);
begin
  FLegend.Symbol.Squared:=CBSquared.Checked;
  EnableWidthControls;
end;

end.
