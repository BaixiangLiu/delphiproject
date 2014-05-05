{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2003 by David Berneda    }
{**********************************************}
unit TeeEditCha;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QStdCtrls, QExtCtrls, QComCtrls, QButtons,
     QDialogs, QGrids, QMenus, QTypes,
     {$ELSE}
     Graphics, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     Dialogs, Grids, Menus,
     {$ENDIF}
     Chart, TeEngine, TeeProcs, TeeEdiSeri, TeeLisB, TeeChartGrid, TeePrevi,
     TeeNavigator;

Const teeEditMainPage    =0;
      teeEditGeneralPage =1;
      teeEditAxisPage    =2;
      teeEditTitlePage   =3;
      teeEditLegendPage  =4;
      teeEditPanelPage   =5;
      teeEditPagingPage  =6;
      teeEditWallsPage   =7;
      teeEdit3DPage      =8;

type
  TChartEditorOption=( ceAdd,
                       ceDelete,
                       ceChange,
                       ceClone,
                       ceDataSource,
                       ceTitle,
                       ceHelp );

Const eoAll=[Low(TChartEditorOption)..High(TChartEditorOption)];

type
  TChartEditorTab=( cetMain,
                    cetGeneral,
                    cetAxis,
                    cetTitles,
                    cetLegend,
                    cetPanel,
                    cetPaging,
                    cetWalls,
                    cet3D,
                    cetSeriesGeneral,
                    cetSeriesMarks,
                    cetAllSeries,
                    cetSeriesData,
                    cetExport,
                    cetTools,
                    cetPrintPreview
                    {$IFDEF TEEOCX}
                    ,cetOpenGL
                    {$ENDIF}
                   );

  TChartEditorOptions=set of TChartEditorOption;
  TChartEditorHiddenTabs=set of TChartEditorTab;

  TChartEditForm = class(TForm)
    MainPage: TPageControl;
    TabChart: TTabSheet;
    SubPage: TPageControl;
    TabSeriesList: TTabSheet;
    TabAxis: TTabSheet;
    TabGeneral: TTabSheet;
    TabTitle: TTabSheet;
    TabLegend: TTabSheet;
    TabPanel: TTabSheet;
    TabPaging: TTabSheet;
    TabWalls: TTabSheet;
    TabSeries: TTabSheet;
    Tab3D: TTabSheet;
    LBSeries: TChartListBox;
    TabData: TTabSheet;
    TabExport: TTabSheet;
    PanBottom: TPanel;
    LabelWWW: TLabel;
    ButtonHelp: TButton;
    TabTools: TTabSheet;
    TabPrint: TTabSheet;
    PanRight: TPanel;
    BMoveUP: TSpeedButton;
    BMoveDown: TSpeedButton;
    BAddSeries: TButton;
    BDeleteSeries: TButton;
    BRenameSeries: TButton;
    BCloneSeries: TButton;
    BChangeTypeSeries: TButton;
    PanTop: TPanel;
    PanBot: TPanel;
    PanLeft: TPanel;
    PanClose: TPanel;
    BClose: TButton;
    ChartGrid1: TChartGrid;
    Panel1: TPanel;
    ChartGridNavigator1: TChartGridNavigator;
    Panel2: TPanel;
    SBGridText: TSpeedButton;
    SBGridCol: TSpeedButton;
    SBGrid3D: TSpeedButton;
    SBGridX: TSpeedButton;
    PopupData: TPopupMenu;
    Deleterow1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SubPageChange(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BMoveUPClick(Sender: TObject);
    procedure BMoveDownClick(Sender: TObject);
    procedure BAddSeriesClick(Sender: TObject);
    procedure BDeleteSeriesClick(Sender: TObject);
    procedure BRenameSeriesClick(Sender: TObject);
    procedure BCloneSeriesClick(Sender: TObject);
    procedure MainPageChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LBSeriesEditSeries(Sender: TChartListBox; Index: Integer);
    procedure LBSeriesOtherItemsChange(Sender: TObject);
    procedure LBSeriesRefreshButtons(Sender: TObject);
    procedure BChangeTypeSeriesClick(Sender: TObject);
    procedure LabelWWWClick(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure MainPageChanging(Sender: TObject; var AllowChange: Boolean);
    procedure SubPageChanging(Sender: TObject; var AllowChange: Boolean);
    procedure SBGridTextClick(Sender: TObject);
    procedure SBGridColClick(Sender: TObject);
    procedure SBGrid3DClick(Sender: TObject);
    procedure SBGridXClick(Sender: TObject);
    procedure ChartGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Deleterow1Click(Sender: TObject);
  private
    { Private declarations }
    TheChart : TCustomChart;
    FPreview : TChartPreview;

    procedure AxisNotifyCustom(Sender: TObject);  // 6.01
    procedure SetChart(Value:TCustomChart);
    procedure GridMouseDown(Sender: TObject;
                           Button: TMouseButton; Shift: TShiftState;
                           X, Y: Integer);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    {$IFNDEF CLX}
    procedure WMHelp(var Message: TWMHelp); message WM_HELP;
    {$ENDIF}
  public
    { Public declarations }
    TheAxis            : TChartAxis;
    TheTitle           : TChartTitle;
    TheTool            : TTeeCustomTool;
    TheWall            : TChartWall;
    TheSeries          : TChartSeries;
    TheEditSeries      : TChartSeries;
    TheActivePageIndex : Integer;
    TheHiddenTabs      : TChartEditorHiddenTabs;

    EditorOptions      : TChartEditorOptions;
    IsDssGraph         : Boolean;
    TheFormSeries      : TFormTeeSeries;
    HighLightTabs      : Boolean;
    RememberPosition   : Boolean;

    Procedure CheckHelpFile;
    procedure SetTabSeries;
    property Chart : TCustomChart read TheChart write SetChart;
  end;

Function GetTeeChartHelpFile:String;

type TTeeOnShowEditor=Procedure(Editor:TChartEditForm);

var TeeOnShowEditor:TTeeOnShowEditor=nil;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFNDEF LINUX}
     Registry,
     {$ENDIF}
     TeePenDlg, TeeConst, Series, TeExport, TeeExport, TeeFunci,
     TeeEdiAxis, TeeEdiLege, TeeEdiPane, TeeEdiTitl, TeeEdiWall, TeeEdiGene,
     TeeEdiPage, TeeEdi3D, TeeEditTools, TeeAbout,
     Math, TeCanvas;

Function GetTeeChartHelpFile:String;
begin
  result:=GetRegistryHelpPath(
                   {$IFDEF TEEOCX}
                   'TeeChartX'+TeeChartVersion+'.hlp'
                   {$ELSE}
                   'TeeChart'+TeeChartVersion+'.hlp'
                   {$ENDIF}); // <- do not translate
end;

Function GetTeeChartUserHelpFile:String;
begin
  result:=GetRegistryHelpPath(
                   {$IFDEF TEEOCX}
                   'TeeUserX'+TeeChartVersion+'.hlp'
                   {$ELSE}
                   'TeeUser'+TeeChartVersion+'.hlp'
                   {$ENDIF}); // <- do not translate
end;

{ TChartEditForm }
Procedure TChartEditForm.CheckHelpFile;
begin
  if ceHelp in EditorOptions then
  begin
    if csDesigning in Chart.ComponentState then
       HelpFile:=GetTeeChartHelpFile
    else
       HelpFile:=GetTeeChartUserHelpFile;
    if HelpFile<>'' then BorderIcons:=BorderIcons+[biHelp];
  end
  else HelpFile:='';
  ButtonHelp.Visible:=ceHelp in EditorOptions;
end;

procedure TChartEditForm.FormShow(Sender: TObject);

  Procedure HideTabs;
  Const Margin=26;
        HorizMargin=10;
        HorizButtonMargin=5;
  begin
    if cetMain in TheHiddenTabs then TabSeriesList.TabVisible:=False;
    if cetGeneral in TheHiddenTabs then TabGeneral.TabVisible:=False;
    if cetAxis in TheHiddenTabs then TabAxis.TabVisible:=False;
    if cetTitles in TheHiddenTabs then TabTitle.TabVisible:=False;
    if cetLegend in TheHiddenTabs then TabLegend.TabVisible:=False;
    if cetPanel in TheHiddenTabs then TabPanel.TabVisible:=False;
    if cetPaging in TheHiddenTabs then TabPaging.TabVisible:=False;
    if cetWalls in TheHiddenTabs then TabWalls.TabVisible:=False;
    if cet3D in TheHiddenTabs then Tab3D.TabVisible:=False;
    if cetSeriesData in TheHiddenTabs then TabData.TabVisible:=False;
    if cetExport in TheHiddenTabs then TabExport.TabVisible:=False;
    if cetTools in TheHiddenTabs then TabTools.TabVisible:=False;
    if cetPrintPreview in TheHiddenTabs then TabPrint.TabVisible:=False;
    if cetAllSeries in TheHiddenTabs then
    begin
      SubPage.Parent:=Self;
      MainPage.Visible:=False;
      Height:=Height-Margin;
      Width:=Width-HorizMargin;
    end;
  end;

var t  : Integer;
    St : String;
    tmp : Boolean;
begin
  TeeLoadArrowBitmaps(BMoveUp.Glyph,BMoveDown.Glyph);


  if TeeIsTrial then 
     LabelWWW.Cursor:=crHandPoint
  else
     LabelWWW.Visible:=False;


  if TeeToolTypes.Count=0 then TabTools.TabVisible:=False;

  LBSeries.Chart:=Chart;

  if (Caption='') and Assigned(Chart) then
  begin
    FmtStr(St,TeeMsg_Editing,[Chart.Name]);
    Caption:=St;
  end;

  HideTabs;

  if TheActivePageIndex<>-1 then
  Case TChartEditorTab(TheActivePageIndex) of
    cetSeriesData   : begin MainPage.ActivePage:=TabData; MainPageChange(Self); end;
    cetExport       : begin MainPage.ActivePage:=TabExport; MainPageChange(Self); end;
    cetTools        : begin MainPage.ActivePage:=TabTools; MainPageChange(Self); end;
    cetPrintPreview : begin MainPage.ActivePage:=TabPrint; MainPageChange(Self); end;
  else
  begin
    if TheActivePageIndex<=teeEdit3DPage then // 5.01
    begin
      t:=TheActivePageIndex;
      While not SubPage.Pages[t].TabVisible do
      if t<(SubPage.PageCount-1) then // 5.03
         Inc(t)
      else
      begin
        t:=TheActivePageIndex;
        While not SubPage.Pages[t].TabVisible do
        if t>0 then
           Dec(t)
        else
           Break;
      end;
      TheActivePageIndex:=t;
      if SubPage.Pages[TheActivePageIndex].TabVisible then
      begin
        SubPage.ActivePage:=SubPage.Pages[TheActivePageIndex];
        SubPageChange(Self);
      end;
    end;
  end;
  end;

  if Assigned(TeeOnShowEditor) then TeeOnShowEditor(Self);

  if Assigned(TheEditSeries) then
  begin
    LBSeries.SelectedSeries:=TheEditSeries;
    LBSeriesEditSeries(LBSeries,0);
  end
  else
  if Assigned(TheTool) and TabTools.TabVisible then
  begin
    MainPage.ActivePage:=TabTools;
    MainPageChange(Self);
  end
  else
  if LBSeries.Items.Count>0 then
  begin
    if LBSeries.CanFocus then
       LBSeries.SetFocus;  // 5.03 CLX fix (unless fails to set ItemIndex)

    LBSeries.ItemIndex:=0;
    if LBSeries.MultiSelect then LBSeries.Selected[0]:=True; { 5.01 }
    LBSeriesRefreshButtons(LBSeries);
  end;

  Case TChartEditorTab(TheActivePageIndex) of
    cetSeriesGeneral,
    cetSeriesMarks : begin
                       LBSeriesEditSeries(LBSeries,LBSeries.ItemIndex);

                       with TheFormSeries do
                       begin
                         tmp:=True;
                         PageSeriesChanging(PageSeries,tmp);

                         if TChartEditorTab(TheActivePageIndex)=cetSeriesGeneral then
                            PageSeries.ActivePage:=TabGeneral
                         else
                            PageSeries.ActivePage:=TabMarks;

                         PageSeriesChange(PageSeries);
                       end;
                     end;
  end;
end;

procedure TChartEditForm.FormCreate(Sender: TObject);

  Function AdjustSize(const Value:String):Integer;
  Const PPI={$IFDEF LINUX}75{$ELSE}{$IFDEF CLX}92{$ELSE}96{$ENDIF}{$ENDIF};
  begin
    result:=StrToInt(Value)*Screen.PixelsPerInch div PPI; { 5.03 }
  end;

var tmpH : Integer;
begin
  Width:=AdjustSize(TeeMsg_DefaultEditorSize);

  tmpH:=AdjustSize(TeeMsg_DefaultEditorHeight);
  {$IFNDEF LINUX}
  Inc(tmpH,GetSystemMetrics(SM_CYSIZE)-18); // add big (XP) form caption size
  {$ENDIF}

  Height:=tmpH;

  RememberPosition:=False;

  Chart:=nil;
  Caption:='';
  TheActivePageIndex:=-1;
  EditorOptions:=eoAll;
  MainPage.ActivePage:=TabChart;
  SubPage.ActivePage:=TabSeriesList;
  TheHiddenTabs:=[{$IFDEF TEEOCX}cetOpenGL{$ENDIF}]; { 5.02 }
end;

procedure TChartEditForm.AxisNotifyCustom(Sender: TObject);  // 6.01
begin
  if Assigned(TheFormSeries) then
     TheFormSeries.FillAxes;
end;

procedure TChartEditForm.SubPageChange(Sender: TObject);
var tmpForm   : TForm;
    tmpSeries : TChartSeries;
begin
  {$IFDEF D5}
  if HighLightTabs then SubPage.ActivePage.Highlighted:=True;
  {$ENDIF}

  if Assigned(Chart) then
  With SubPage.ActivePage do
  if ControlCount=0 then
  begin
    Case {$IFNDEF CLX}PageIndex{$ELSE}TabIndex{$ENDIF} of
      teeEditGeneralPage: tmpForm:=TFormTeeGeneral.CreateChart(Self,Chart);
      teeEditAxisPage   : begin
                            if not Assigned(TheAxis) then TheAxis:=Chart.LeftAxis;
                            tmpForm:=TFormTeeAxis.CreateAxis(Self,TheAxis);
                            TFormTeeAxis(tmpForm).NotifyCustom:=AxisNotifyCustom;  // 6.01
                          end;
      teeEditTitlePage  : begin
                            if not Assigned(TheTitle) then TheTitle:=Chart.Title;
                            tmpForm:=TFormTeeTitle.CreateTitle(Self,Chart,TheTitle);
                          end;
      teeEditLegendPage : tmpForm:=TFormTeeLegend.CreateLegend(Self,Chart.Legend);
      teeEditPanelPage  : tmpForm:=TFormTeePanel.CreatePanel(Self,Chart);
      teeEditPagingPage : tmpForm:=TFormTeePage.CreateChart(Self,Chart);
      teeEditWallsPage  : begin
                            if not Assigned(TheWall) then TheWall:=Chart.LeftWall;
                            tmpForm:=TFormTeeWall.CreateWall(Self,TheWall);
                          end;
    else
       tmpForm:=TFormTee3D.CreateChart(Self,Chart);
    end;

    { show the form... }
    With tmpForm do
    begin
      BorderIcons:=[];
      BorderStyle:=TeeFormBorderStyle;
      Align:=alClient;
      Parent:=Self.SubPage.ActivePage;
      {$IFDEF CLX}
      TeeFixParentedForm(tmpForm);
      {$ENDIF}
      Show;
      Realign;  // 6.0 (fixes Axis tab align bug in VCL)
    end;

    // Translate the form
    TeeTranslateControl(tmpForm);
  end;

  if SubPage.ActivePage=Tab3D then
  begin
    tmpSeries:=Chart.GetASeries;
    With TFormTee3D(Tab3D.Controls[0]) do
    begin
      AllowRotation:=TheChart.Canvas.SupportsFullRotation or
                     (not Assigned(tmpSeries)) or
                     (not (tmpSeries is TPieSeries));
      CheckRotation;
    end;
  end;
end;

procedure TChartEditForm.BCloseClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TChartEditForm.BMoveUPClick(Sender: TObject);
begin
  LBSeries.MoveCurrentUp;
end;

procedure TChartEditForm.BMoveDownClick(Sender: TObject);
begin
  LBSeries.MoveCurrentDown;
end;

procedure TChartEditForm.BAddSeriesClick(Sender: TObject);
var tmpSeries : TChartSeries;
begin
  tmpSeries:=LBSeries.AddSeriesGallery;
  if Assigned(tmpSeries) and Assigned(tmpSeries.FunctionType) then
  begin
    TheSeries:=tmpSeries;
    MainPage.ActivePage:=TabSeries;
    SetTabSeries;
    With TheFormSeries do
    begin
      PageSeries.ActivePage:=TabDataSource;
      PageSeriesChange(Self);
      CBDataSourcestyleChange(Self);
    end;
  end;
end;

procedure TChartEditForm.BDeleteSeriesClick(Sender: TObject);
begin
  LBSeries.DeleteSeries;
  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.TheSeries:=nil;
    TheFormSeries.DestroySeriesForms;
    TheFormSeries.TheSeries:=Self.LBSeries.SelectedSeries;
  end;
end;

procedure TChartEditForm.BRenameSeriesClick(Sender: TObject);
begin
  LBSeries.RenameSeries;
  if (Parent=nil) and LBSeries.CanFocus then ActiveControl:=LBSeries; { 5.01 }
end;

procedure TChartEditForm.BCloneSeriesClick(Sender: TObject);
begin
  LBSeries.CloneSeries;
end;

procedure TChartEditForm.SetTabSeries;
begin
  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.TheSeries:=LBSeries.SelectedSeries;
  end
  else
  begin
    TheFormSeries:=TFormTeeSeries.Create(Self);
    With TheFormSeries do
    begin
      Self.LBSeries.OtherItems:=CBSeries.Items;
      TheListBox:=Self.LBSeries;
      BorderIcons:=[];
      BorderStyle:=TeeFormBorderStyle;
      Parent:=TabSeries;
      Align:=alClient;
      ShowTabDataSource:=ceDataSource in EditorOptions;
      ShowTabGeneral:=not (cetSeriesGeneral in TheHiddenTabs);
      ShowTabMarks:=not (cetSeriesMarks in TheHiddenTabs);
      IsDssGraph:=Self.IsDssGraph;
      TheSeries:=Self.LBSeries.SelectedSeries;
      Self.LBSeries.FillSeries(TheSeries);

      {$IFDEF CLX}
      TeeFixParentedForm(TheFormSeries);
      {$ENDIF}
      Show;
    end;

    TeeTranslateControl(TheFormSeries);
  end;
  TheFormSeries.SetCBSeries;
end;

procedure TChartEditForm.GridMouseDown(Sender: TObject;
                                Button: TMouseButton; Shift: TShiftState;
                                X, Y: Integer);
begin
  if (Button=mbRight) and (ssAlt in Shift) then
     if (Chart.SeriesCount>0) and Chart[0].HasZValues then
     with (Sender as TChartGrid) do
          Grid3DMode:=not Grid3DMode;
end;

procedure TChartEditForm.MainPageChange(Sender: TObject);

  Procedure SetTabPrint;
  begin
    if not Assigned(FPreview) then
    begin
      Screen.Cursor:=crHourGlass;
      try
        FPreview:=TChartPreview.Create(Self);
        with FPreview do
        begin
          GBMargins.Visible:=False;
          PanelMargins.Visible:=False;
          BClose.Visible:=False;
          Align:=alClient;
        end;
        AddFormTo(FPreview,TabPrint,Integer(Chart));
      finally
        Screen.Cursor:=crDefault;
      end;
    end
    else FPreview.TeePreviewPanel1.Invalidate; // 5.03
  end;

  Procedure SetTabTools;
  var tmp     : TFormTeeTools;
      tmpTool : Integer;
  begin
    if TabTools.ControlCount=0 then
    begin
      tmp:=TFormTeeTools.Create(Self);
      tmp.Align:=alClient;
      AddFormTo(tmp,TabTools,Integer(Chart));
      if Assigned(TheTool) then
      begin
        tmpTool:=tmp.LBTools.Items.IndexOfObject(TheTool);
        if tmpTool<>-1 then
        begin
          tmp.LBTools.ItemIndex:=tmpTool;
          tmp.LBToolsClick(Self);
        end;
        TheTool:=nil;
      end;
    end
    else  // Refresh the tool form, if any...
      TFormTeeTools(TabTools.Controls[0]).Reload;
  end;

  Procedure SetTabExport;
  var tmp : TTeeExportForm;
  begin
    if TabExport.ControlCount=0 then
    begin
      tmp:=TTeeExportForm.Create(Self);
      AddFormTo(tmp,TabExport,Integer(Chart));
      with tmp do
      begin
        Align:=alClient;
        BClose.Visible:=False;
      end;
    end
    else tmp:=TTeeExportForm(TabExport.Controls[0]);

    with tmp do
    begin
      CBFileSize.Checked:=False;
      EnableButtons;
    end;
  end;

  Procedure SetTabData;
  begin
    with ChartGrid1 do
    begin
      Chart:=Self.Chart;

      ShowColors:=(Chart.SeriesCount>0) and HasColors(Chart[0]);
      RecalcDimensions;

      SBGridCol.Down:=ShowColors;
      SBGridText.Down:=ShowLabels;
      SBGrid3D.Down:=Grid3DMode;
      SBGrid3D.Enabled:=(Chart.SeriesCount>0) and Chart[0].HasZValues;
      SBGridX.Down:=(Chart.SeriesCount>0) and HasNoMandatoryValues(Chart[0]);

      {$IFNDEF TEEOCX}
      SetFocus;
      {$ENDIF}
      OnMouseDown:=GridMouseDown;
    end;
  end;

begin
  {$IFDEF D5}
  if HighLightTabs then MainPage.ActivePage.HighLighted:=True;
  {$ENDIF}

  if MainPage.ActivePage=TabSeries then SetTabSeries
  else
  if MainPage.ActivePage=TabData then SetTabData
  else
  if MainPage.ActivePage=TabTools then SetTabTools
  else
  if MainPage.ActivePage=TabExport then SetTabExport
  else
  if MainPage.ActivePage=TabPrint then SetTabPrint
  {$IFDEF CLX}
  // Workaround for CLX ListBox MultiSelect + ItemIndex=-1 bug
  else
  if MainPage.ActivePage=TabChart then
    if (not LBSeries.Focused) and (LBSeries.CanFocus) then
    begin
      LBSeries.SetFocus;
      LBSeriesRefreshButtons(LBSeries);
    end;
  {$ENDIF}
end;

{$IFNDEF CLX}
procedure TChartEditForm.WMHelp(var Message: TWMHelp);
var Control : TWinControl;
begin
  if biHelp in BorderIcons then
  with Message.HelpInfo^ do
  begin
    if iContextType = HELPINFO_WINDOW then
    begin
      Control := FindControl(hItemHandle);
      while Assigned(Control) and (Control.HelpContext = 0) do
        Control := Control.Parent;
      if Assigned(Control) then
         Application.HelpContext(Control.HelpContext);
    end;
  end
  else inherited;
end;
{$ENDIF}

procedure TChartEditForm.SetChart(Value:TCustomChart);
begin
  TheChart:=Value;
  if Assigned(TheChart) then TheChart.FreeNotification(Self);
  LBSeries.Chart:=TheChart;
  MainPage.Enabled:=Assigned(TheChart);
  SubPage.Enabled:=Assigned(TheChart);

  {$IFNDEF LINUX}
  if Assigned(TheChart) then
  begin
    if not RememberPosition then
       RememberPosition:=(csDesigning in TheChart.ComponentState);

    if RememberPosition then
    begin
      with TRegistry.Create do
      try
        if OpenKeyReadOnly(TeeMsg_EditorKey) then
        if ValueExists('Left') then
        begin
          Self.Position:=poDesigned;
          Self.Left:=Math.Max(0,ReadInteger('Left'));
          Self.Top:=Math.Max(0,ReadInteger('Top'));
        end;
      finally
        Free;
      end;
    end;
  end;
  {$ENDIF}
end;

procedure TChartEditForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {$IFNDEF LINUX}
  if Assigned(Chart) and RememberPosition then
  begin
    with TRegistry.Create do
    try
      if OpenKey(TeeMsg_EditorKey,True) then
      begin
        WriteInteger('Left',Self.Left);
        WriteInteger('Top',Self.Top);
      end;
    finally
      Free;
    end;
  end;
  {$ENDIF}

  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.FormCloseQuery(Sender,CanClose);
    if CanClose then Close;
  end;
end;

procedure TChartEditForm.LBSeriesEditSeries(Sender: TChartListBox;
  Index: Integer);
begin
  if LBSeries.ItemIndex<>-1 then
  begin
    MainPage.ActivePage:=TabSeries;
    {$IFNDEF CLX}
    SetTabSeries;
    {$ENDIF}
  end;
end;

procedure TChartEditForm.LBSeriesOtherItemsChange(Sender: TObject);
begin
  if Assigned(TheFormSeries) then
     TheFormSeries.CBSeries.ItemIndex:=LBSeries.ItemIndex;
end;

procedure TChartEditForm.LBSeriesRefreshButtons(Sender: TObject);
var tmp          : Boolean;
    tmpInherited : Boolean;
    tmpSeries    : TChartSeries;
begin
  tmp:=(Chart.SeriesCount>0) and (LBSeries.ItemIndex<>-1);
  if tmp then tmpSeries:=Chart.Series[LBSeries.ItemIndex]
         else tmpSeries:=nil;
  tmpInherited:=tmp and (csAncestor in tmpSeries.ComponentState);
  BAddSeries.Enabled:=(ceAdd in EditorOptions);
  BDeleteSeries.Enabled:= tmp and
                          (not tmpInherited) and
                          (ceDelete in EditorOptions)
                          and
                          (not (tssIsTemplate in tmpSeries.Style)) and
                          (not (tssDenyDelete in tmpSeries.Style)) ;
  BRenameSeries.Enabled:=tmp and (LBSeries.SelCount<2) and (ceTitle in EditorOptions);
  BChangeTypeSeries.Enabled:= tmp and
                              (not tmpInherited) and
                              (ceChange in EditorOptions)
                              and
                              (not (tssDenyChangeType in tmpSeries.Style));
  BCloneSeries.Enabled:= tmp and
                         (LBSeries.SelCount<2) and
                         (ceClone in EditorOptions)
                         and
                         (not (tssIsTemplate in tmpSeries.Style)) and
                         (not (tssDenyClone in tmpSeries.Style));

  if tmp and (LBSeries.SelCount<=1) then
  begin
    BMoveDown.Enabled:=LBSeries.ItemIndex<LBSeries.Items.Count-1;
    BMoveUp.Enabled:=LBSeries.ItemIndex>0;
  end
  else
  begin
    BMoveDown.Enabled:=False;
    BMoveUp.Enabled:=False;
  end;
end;

procedure TChartEditForm.BChangeTypeSeriesClick(Sender: TObject);
begin
  LBSeries.ChangeTypeSeries(Self);
  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.DestroySeriesForms;
    TheFormSeries.TheSeries:=LBSeries.SelectedSeries; { 5.01 }
  end;
end;

procedure TChartEditForm.LabelWWWClick(Sender: TObject);
begin
  GotoURL(Handle,LabelWWW.Caption);
end;

procedure TChartEditForm.ButtonHelpClick(Sender: TObject);
begin
  {$IFNDEF CLX}
  Application.HelpCommand(HELP_CONTEXT, HelpContext);
  {$ENDIF}
end;

procedure TChartEditForm.MainPageChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if Assigned(TheFormSeries) then
     TheFormSeries.PageSeriesChanging(Self,AllowChange)
  else
     AllowChange:=True;

  {$IFDEF D5}
  if AllowChange and HighLightTabs then MainPage.ActivePage.HighLighted:=False;
  {$ENDIF}
end;

procedure TChartEditForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(TheChart) and (AComponent=TheChart) then
     TheChart:=nil;
end;

procedure TChartEditForm.SubPageChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  {$IFDEF D5}
  if HighLightTabs then SubPage.ActivePage.Highlighted:=False;
  {$ENDIF}
end;

procedure TChartEditForm.SBGridTextClick(Sender: TObject);
begin
  ChartGrid1.ShowLabels:=SBGridText.Down;
end;

procedure TChartEditForm.SBGridColClick(Sender: TObject);
begin
  ChartGrid1.ShowColors:=SBGridCol.Down;
end;

procedure TChartEditForm.SBGrid3DClick(Sender: TObject);
begin
  ChartGrid1.Grid3DMode:=SBGrid3D.Down;
end;

procedure TChartEditForm.SBGridXClick(Sender: TObject);
begin
  if SBGridX.Down then
     ChartGrid1.ShowXValues:=cgsYes
  else
     ChartGrid1.ShowXValues:=cgsNo
end;

procedure TChartEditForm.ChartGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if Assigned(ChartGrid1.Series) then
     ChartGrid1.Series.RefreshSeries;  // else ?
end;

procedure TChartEditForm.Deleterow1Click(Sender: TObject);
begin
  ChartGrid1.Delete
end;

initialization
  RegisterClass(TChartEditForm);
end.

