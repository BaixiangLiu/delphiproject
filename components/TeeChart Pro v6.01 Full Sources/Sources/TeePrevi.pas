{********************************************}
{   PrintPreview Form                        }
{   Copyright (c) 1996-2003 by David Berneda }
{********************************************}
unit TeePrevi;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
     QPrinters, TeePenDlg,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Printers,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeeProcs, TeCanvas, TeePreviewPanel, TeeNavigator;

type
  TChartPreview = class(TForm)
    Panel1: TPanel;
    CBPrinters: TComboFlat;
    Label1: TLabel;
    BSetupPrinter: TButton;
    Panel2: TPanel;
    Orientation: TRadioGroup;
    GBMargins: TGroupBox;
    SETopMa: TEdit;
    SELeftMa: TEdit;
    SEBotMa: TEdit;
    SERightMa: TEdit;
    ChangeDetailGroup: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    BClose: TButton;
    BPrint: TButton;
    UDLeftMa: TUpDown;
    UDTopMa: TUpDown;
    UDRightMa: TUpDown;
    UDBotMa: TUpDown;
    TeePreviewPanel1: TTeePreviewPanel;
    Resolution: TTrackBar;
    PanelMargins: TPanel;
    BReset: TButton;
    ShowMargins: TCheckBox;
    Panel4: TPanel;
    CBProp: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BSetupPrinterClick(Sender: TObject);
    procedure CBPrintersChange(Sender: TObject);
    procedure OrientationClick(Sender: TObject);
    procedure SETopMaChange(Sender: TObject);
    procedure SERightMaChange(Sender: TObject);
    procedure SEBotMaChange(Sender: TObject);
    procedure SELeftMaChange(Sender: TObject);
    procedure ShowMarginsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BResetClick(Sender: TObject);
    procedure BPrintClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure CBPropClick(Sender: TObject);
    procedure TeePreviewPanel1ChangeMargins(Sender: TObject;
      DisableProportional: Boolean; const NewMargins: TRect);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ChangingMargins : Boolean;
    ChangingProp    : Boolean;
    OldMargins      : TRect;
    PageNavigator1  : TCustomTeeNavigator;

    procedure Navigator1ButtonClicked(Index: TTeeNavigateBtn);
    Procedure ResetMargins;
    Procedure CheckOrientation;
    procedure ChangeMargin(UpDown:TUpDown; Var APos:Integer; OtherSide:Integer);
  public
    PageNavigatorClass    : TTeePageNavigatorClass; 
    PrinterSetupDialog1   : TPrinterSetupDialog;
    Function PreviewPanel : TTeePreviewPanel;
  end;

Var TeeChangePaperOrientation:Boolean=True;

Procedure TeePreview(AOwner:TComponent; APanel:TCustomTeePanel);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Procedure TeePreview(AOwner:TComponent; APanel:TCustomTeePanel);
begin
  with TChartPreview.Create(AOwner) do
  try
    TeePreviewPanel1.Panel:=APanel;
    ShowModal;
  finally
    Free;
    APanel.Repaint;
  end;
end;

{ TChartPreview }
Procedure TChartPreview.ResetMargins;
begin
  With TeePreviewPanel1 do
  if Assigned(Panel) then
  begin
    if Panel.PrintProportional and (Printer.Printers.Count>0) then
    begin
      OldMargins:=Panel.CalcProportionalMargins;
      Panel.PrintMargins:=OldMargins;
    end;
    TeePreviewPanel1ChangeMargins(Self,False,Panel.PrintMargins);
    Invalidate;
  end;
end;

procedure TChartPreview.FormShow(Sender: TObject);
var tmpClass: TTeePageNavigatorClass;
begin
  tmpClass:=PageNavigatorClass;
  if Assigned(tmpClass) then
  begin
    PageNavigator1:=tmpClass.Create(Self);
    PageNavigator1.Parent:=Panel2;
    PageNavigator1.Align:=alBottom;
    PageNavigator1.HelpContext:=1488;
    PageNavigator1.OnButtonClicked:=Navigator1ButtonClicked;
  end;

  Screen.Cursor:=crDefault;

  if Tag<>0 then TeePreviewPanel1.Panel:=TCustomTeePanel(Tag);

  CBPrinters.Items:=Printer.Printers;
  if Printer.Printers.Count>0 then
  begin
    {$IFDEF CLX}
    CBPrinters.ItemIndex:=0;
    {$ELSE}
    CBPrinters.ItemIndex:=Printer.PrinterIndex;
    {$ENDIF}

    {$IFNDEF TEEOCX}
    if TeeChangePaperOrientation then
       Printer.Orientation:=poLandscape;
    {$ENDIF}

    CheckOrientation;
  end
  else
  begin
    EnableControls(False,[BPrint,BSetupPrinter,Orientation]);
  end;

  With TeePreviewPanel1 do
  if Assigned(Panel) then
  begin
    CBProp.Checked:=Panel.PrintProportional;
    Resolution.Position:=Panel.PrintResolution+100;
    OldMargins:=Panel.PrintMargins;
    ResetMargins;

    if Assigned(PageNavigator1) then
       PageNavigator1.Panel:=Panel;  { 5.03 }
  end
  else
  begin
    CBProp.Enabled:=False;
    Resolution.Enabled:=False;
    GBMargins.Enabled:=False;
    BPrint.Enabled:=False;
  end;

  TeeTranslateControl(Self);
end;

procedure TChartPreview.BSetupPrinterClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
  CBPrinters.Items:=Printer.Printers;
  {$IFNDEF CLX}
  CBPrinters.ItemIndex:=Printer.PrinterIndex;
  {$ENDIF}
  CheckOrientation;
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.CBPrintersChange(Sender: TObject);
begin
  {$IFNDEF CLX}
  Printer.PrinterIndex:=CBPrinters.ItemIndex;
  {$ENDIF}
  CheckOrientation;
  OrientationClick(Self);
end;

procedure TChartPreview.OrientationClick(Sender: TObject);
begin
  Printer.Orientation:=TPrinterOrientation(Orientation.ItemIndex);
  ResetMargins;
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.ChangeMargin(UpDown:TUpDown; Var APos:Integer; OtherSide:Integer);
begin
  if Showing then
  begin
    if UpDown.Position+OtherSide<100 then
    begin
      APos:=UpDown.Position;
      if not ChangingMargins then
      With TeePreviewPanel1 do
      Begin
        Invalidate;
        BReset.Enabled:=not EqualRect(Panel.PrintMargins,OldMargins);
        CBProp.Checked:=False;
      end;
    end
    else UpDown.Position:=APos;
  end;
end;

procedure TChartPreview.SETopMaChange(Sender: TObject);
begin
  if Showing then with TeePreviewPanel1.Panel.PrintMargins do ChangeMargin(UDTopMa,Top,Bottom);
end;

procedure TChartPreview.SERightMaChange(Sender: TObject);
begin
  if Showing then with TeePreviewPanel1.Panel.PrintMargins do ChangeMargin(UDRightMa,Right,Left);
end;

procedure TChartPreview.SEBotMaChange(Sender: TObject);
begin
  if Showing then with TeePreviewPanel1.Panel.PrintMargins do ChangeMargin(UDBotMa,Bottom,Top);
end;

procedure TChartPreview.SELeftMaChange(Sender: TObject);
begin
  if Showing then with TeePreviewPanel1.Panel.PrintMargins do ChangeMargin(UDLeftMa,Left,Right);
end;

procedure TChartPreview.ShowMarginsClick(Sender: TObject);
begin
  TeePreviewPanel1.Margins.Visible:=ShowMargins.Checked;
end;

procedure TChartPreview.FormCreate(Sender: TObject);
begin
  ChangingMargins:=True;
  ChangingProp:=False;
  PrinterSetupDialog1:=TPrinterSetupDialog.Create(Self);
end;

procedure TChartPreview.BResetClick(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Begin
    Panel.PrintMargins:=OldMargins;
    TeePreviewPanel1ChangeMargins(Self,False,Panel.PrintMargins);
    Invalidate;
  end;
  BReset.Enabled:=False;
end;

Procedure TChartPreview.CheckOrientation;
Begin
  Orientation.ItemIndex:=Ord(Printer.Orientation);
End;

procedure TChartPreview.BPrintClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    if Assigned(PageNavigator1) and (PageNavigator1.PageCount>1) then
       PageNavigator1.Print
    else
       TeePreviewPanel1.Print;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TChartPreview.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TChartPreview.CBPropClick(Sender: TObject);
begin
  if not ChangingProp then
  begin
    TeePreviewPanel1.Panel.PrintProportional:=CBProp.Checked;
    ResetMargins;
  end;
end;

procedure TChartPreview.TeePreviewPanel1ChangeMargins(Sender: TObject;
  DisableProportional: Boolean; const NewMargins: TRect);
begin
  ChangingMargins:=True;
  try
    UDLeftMa.Position :=NewMargins.Left;
    UDRightMa.Position:=NewMargins.Right;
    UDTopMa.Position  :=NewMargins.Top;
    UDBotMa.Position  :=NewMargins.Bottom;
    if DisableProportional then
    begin
      TeePreviewPanel1.Panel.PrintProportional:=False;
      ChangingProp:=True;
      CBProp.Checked:=False;
      ChangingProp:=False;
    end;
  finally
    ChangingMargins:=False;
  end;
end;

procedure TChartPreview.Navigator1ButtonClicked(Index: TTeeNavigateBtn);
begin
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.TrackBar1Change(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Begin
    Panel.PrintResolution:=Resolution.Position-100;
    Invalidate;
  end;
end;

function TChartPreview.PreviewPanel: TTeePreviewPanel;
begin
  result:=TeePreviewPanel1;
end;

procedure TChartPreview.FormDestroy(Sender: TObject);
begin
  PrinterSetupDialog1.Free;
  PageNavigator1.Free; { 5.02 }
end;

end.
