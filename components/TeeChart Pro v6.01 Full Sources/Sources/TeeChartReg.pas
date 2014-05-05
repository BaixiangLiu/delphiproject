{*****************************************}
{ TeeChart Standard version               }
{                                         }
{ Component Registration Unit             }
{                                         }
{ Comps:   TChart                         }
{          TDBChart (not for Std/Open)    }
{                                         }
{ Series:  TLineSeries                    }
{          TAreaSeries                    }
{          TPointSeries                   }
{          TBarSeries                     }
{          THorizBarSeries                }
{          TPieSeries                     }
{          TBubbleSeries                  }
{          TGanttSeries                   }
{          TChartShape                    }
{          TArrowSeries                   }
{          TFastLineSeries                }
{          THorizLineSeries               }
{          THorizAreaSeries               }
{                                         }
{ Other:                                  }
{          TButtonColor                   }
{          TButtonPen                     }
{          TComboFlat                     }
{                                         }
{          Multi-Language selector        }
{                                         }
{          TTeeDBCrossTab                 }
{                                         }
{ Copyright (c) 1995-2003 David Berneda   }
{ All Rights Reserved                     }
{                                         }
{*****************************************}
unit TeeChartReg;
{$I TeeDefs.inc}

interface

Uses {$IFDEF D6DESIGNER}
     DesignIntf, DesignEditors, PropertyCategories,
     {$ELSE}
     DsgnIntf,
     {$ENDIF}
     TeEngine, Chart, TeCanvas;

{$R TeeChart.res}

{$IFNDEF BCB}
{$IFNDEF CLX}
{$IFNDEF TEENOSERIESDESIGN}
{$DEFINE TEESHOWCUSTOMAXES}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$IFNDEF NOUSE_BDE}
{$DEFINE TEEDBREG}
{$ENDIF}

{$IFDEF KYLIXOPEN}
{$UNDEF TEEDBREG}
{$ENDIF}


Type
  TTeeClassProperty=class(TClassProperty)
  public
    function GetValue: string; override;
  end;

  TChartClassProperty=class(TTeeClassProperty)
  protected
    procedure InternalEditPage(AChart:TCustomChart; APage:Integer);
  public
    function GetAttributes : TPropertyAttributes; override;
  end;

  TChartCompEditor=class(TComponentEditor)
  protected
    Function Chart:TCustomChart; virtual;
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  {$IFDEF TEEDBREG}
  TDBChartCompEditor=class(TChartCompEditor)
  public
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;
  {$ENDIF}

  TChartSeriesEditor=class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  TChartPenProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartBrushProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  { Property Categories }
  {$IFNDEF D6}
  {$IFNDEF CLX}
  {$IFDEF D5}
  TChartAxesCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;

  TChartWallsCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;

  TChartTitlesCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;

  TChart3DCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

  TTeeDesigner={$IFDEF D6DESIGNER}
               IDesigner
               {$ELSE}
               IFormDesigner
               {$ENDIF};

  TTeeEditSeriesProc=procedure(ASeries:TChartSeries; ADesigner:TTeeDesigner);
  TTeeChartEditorHook=procedure(ADesigner: TTeeDesigner; AChart: TCustomChart;
                                EditSeriesProc: TTeeEditSeriesProc);

  TTeeChartLanguageHook=procedure;

Var
  TeeChartEditorHook   : TTeeChartEditorHook=nil;
  TeeChartLanguageHook : TTeeChartLanguageHook=nil;

{ for QrTeeReg.pas }
procedure EditChartDesign(AChart:TCustomChart);

procedure EditSeriesProc(ASeries:TChartSeries; ADesigner:TTeeDesigner);

procedure Register;

implementation

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}

     TypInfo, Classes, SysUtils,

     {$IFDEF TEEDBREG}
     DB, 
     {$IFNDEF CLX}
     DBTables,
     {$ENDIF}
     {$ENDIF}

     {$IFDEF CLX}
     QClipbrd, QGraphics, QForms, QControls, QDialogs, QMenus,
     {$ELSE}
     Clipbrd, Graphics, Forms, Controls, Dialogs, Menus,
     {$ENDIF}

     TeeGalleryPanel, EditChar, TeeProcs, TeeConst, TeeAbout,
     TeeEditCha, TeeEdiSeri, TeeEdiGene, TeeEdiGrad, TeeShadowEditor,

     {$IFDEF TEEDBREG}
     DBChart, DBEditCh, TeeDBEdit, TeeData, TeeDBCrossTab,
     {$ENDIF}
    
     TeeCustEdit, Series, TeeSourceEdit,
     TeePieEdit, TeeAreaEdit, TeeBarEdit, TeeFLineEdi, TeePenDlg,
     TeeBrushDlg, GanttCh, TeeShape, BubbleCh, ArrowCha, TeeArrowEdi,
     TeeGanttEdi, TeeShapeEdi, TeeCustomFuncEditor, TeeAvgFuncEditor,
     TeePrevi, TeExport

     {$IFNDEF CLX}
     , TeeExpForm
     {$ENDIF}
     {$IFNDEF TEENOSERIESDESIGN}
     , ColnEdit
     {$ENDIF}
     ;

type
  TChartLegendProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartAxisProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartAxisTitleProperty=class(TTeeClassProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
  end;

  TChartSeriesListProperty=class(TTeeClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

  TSeriesPointerProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartTitleProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartWallProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartGradientProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TTeeShadowProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TBarSeriesGradientProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TSeriesMarksProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TView3DOptionsProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

{$IFDEF TEEDBREG}
type TDesignSources=class
	FAddCurrent   : Boolean;
	FItems        : TStrings;
	FFormDesigner : TTeeDesigner;
	FProc         : TAddComponentDataSource;
	Procedure AddDataSource(Const St:String);
     end;

Procedure TDesignSources.AddDataSource(Const St:String);
Var tmpComp : TComponent;
begin
  if St<>'' then
  begin
    tmpComp:=FFormDesigner.GetComponent(St);
    if Assigned(tmpComp) and Assigned(FProc) then
       FProc(tmpComp,FItems,FAddCurrent);
  end;
end;

Procedure DesignTimeOnGetDesignerNames( AProc      : TAddComponentDataSource;
					ASeries    : TChartSeries;
					AItems     : TStrings;
					AddCurrent : Boolean );
Var tmpForm : TCustomForm;
begin
  tmpForm:=GetParentForm(ASeries.ParentChart);
  if Assigned(tmpForm) and Assigned(tmpForm.{$IFDEF CLX}DesignerHook{$ELSE}Designer{$ENDIF}) then
  With TDesignSources.Create do
  try
    FProc:=AProc;
    FItems:=AItems;
    FAddCurrent:=AddCurrent;
    {$IFDEF D6DESIGNER}
    tmpForm.{$IFDEF CLX}DesignerHook{$ELSE}Designer{$ENDIF}.QueryInterface(IDesigner,FFormDesigner);
    {$ELSE}
    FFormDesigner:=tmpForm.Designer as TTeeDesigner;
    {$ENDIF}

    {$IFDEF TEEDBREG}
    FFormDesigner.GetComponentNames(GetTypeData(TDataSource.ClassInfo),AddDataSource);
    FFormDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo),AddDataSource);
    {$ENDIF}
    FFormDesigner.GetComponentNames(GetTypeData(TChartSeries.ClassInfo),AddDataSource);
    FFormDesigner.GetComponentNames(GetTypeData(TTeeSeriesSource.ClassInfo),AddDataSource);
  finally
    Free;
  end;
end;
{$ENDIF}

{ TTeeClassProperty }
function TTeeClassProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ Chart Editor }
procedure EditChartDesign(AChart:TCustomChart);
var Part : TChartClickedPart;
begin
  With AChart do CalcClickedPart(GetCursorPos,Part);
  EditChartPart(nil,AChart,Part);
end;

{ EditSeriesProc }
procedure EditSeriesProc(ASeries:TChartSeries; ADesigner:TTeeDesigner);
begin
  EditSeries(nil,ASeries);
  if Assigned(ADesigner) then ADesigner.Modified; { 5.01 }
end;

{ TChartCompEditor }
Function TChartCompEditor.Chart:TCustomChart;
begin
  result:=TCustomChart(Component);
end;

procedure TChartCompEditor.Edit;
begin
  EditChartDesign(Chart);
  Designer.Modified;
end;

procedure TChartCompEditor.ExecuteVerb( Index : Integer );
begin
  Case Index of
    0..3: TeeShowAboutBox;
    4: Edit;
    5: ChartPreview(nil,Chart);
    6: TeeExport(Application,Chart);
   {$IFDEF TEESHOWCUSTOMAXES}
    7: ShowCollectionEditor(Designer,Chart,Chart.CustomAxes,'CustomAxes');
   {$ENDIF}
   {$IFNDEF CLX}
      {$IFDEF BCB}
        7: if Assigned(TeeChartLanguageHook) then TeeChartLanguageHook;
      {$ELSE}
        8: TeeChartEditorHook(Designer,Chart,EditSeriesProc);
      {$ENDIF}
     {$ELSE}
      8: if Assigned(TeeChartLanguageHook) then TeeChartLanguageHook;
   {$ENDIF}
   {$IFDEF CLX}7{$ELSE}9{$ENDIF}:
      if Assigned(TeeChartLanguageHook) then TeeChartLanguageHook;
  else
    inherited;
  end;
end;

function TChartCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+{$IFDEF TEESHOWCUSTOMAXES}8{$ELSE}7{$ENDIF};
  if Assigned(TeeChartEditorHook) then Inc(result);
  if Assigned(TeeChartLanguageHook) then Inc(result);
end;

function TChartCompEditor.GetVerb( Index : Integer ) : string;
begin
  result:='';
  Case Index of
    0: begin  
         result:=TeeMsg_Version;
         if TeeIsTrial then result:=result+' TRIAL';
       end;

    1: result:=TeeMsg_Copyright;
    2: result:={$IFDEF D5}cLineCaption{$ELSE}'-'{$ENDIF};
    3: result:=TeeMsg_About;
    4: result:=TeeMsg_EditChart;
    5: result:=TeeMsg_PrintPreview;
    6: result:=TeeMsg_ExportChart;
   {$IFDEF TEESHOWCUSTOMAXES}
    7: result:=TeeMsg_CustomAxes;
   {$ENDIF}
   {$IFDEF CLX}
    7: result:=TeeMsg_AskLanguage;
   {$ELSE}
     {$IFDEF BCB}
     7: result:=TeeMsg_AskLanguage;
     {$ELSE}
     8: result:=TeeMsg_SeriesList;
     9: result:=TeeMsg_AskLanguage;
     {$ENDIF}
    {$ELSE}
    8: result:=TeeMsg_AskLanguage;
   {$ENDIF}
  end;
end;

procedure TChartSeriesEditor.Edit;
begin
  {$IFNDEF CLX}
  EditSeriesProc(TChartSeries(Component),Designer);
  {$ENDIF}
end;

procedure TChartSeriesEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then Edit else inherited;
end;

function TChartSeriesEditor.GetVerbCount : Integer;
begin
  result:=inherited GetVerbCount+1;
end;

function TChartSeriesEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;

{ Generic Chart Class Editor (for chart sub-components) }

{ TChartClassProperty }
function TChartClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties,paDialog];
end;

procedure TChartClassProperty.InternalEditPage( AChart:TCustomChart;
						APage:Integer);
begin
  EditChartPage(nil,AChart,APage);
  Designer.Modified;
end;

{ Chart Legend Editor }
procedure TChartLegendProperty.Edit;
begin
  EditChartLegend(nil,TCustomChart(TChartLegend(GetOrdValue).ParentChart));
  Designer.Modified;
end;

{ Axis Chart Editor }
procedure TChartAxisProperty.Edit;
begin
  EditChartAxis(nil,TChartAxis(GetOrdValue));
  Designer.Modified;
end;

{ Chart Series Editor }
function TChartSeriesListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TChartSeriesListProperty.Edit;
Var AChart : TCustomChart;
begin
  AChart:=TCustomChart(TChartSeriesList(GetOrdValue).Owner);
  if Assigned(TeeChartEditorHook) then
     TeeChartEditorHook(Designer,AChart,EditSeriesProc)
  else
  begin
    EditChart(nil,AChart);
    Designer.Modified;
  end;
end;

{ Chart Axis Title Editor }
function TChartAxisTitleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties];
end;

{ Chart Title Editor }
procedure TChartTitleProperty.Edit;
begin
  EditChartTitle(nil,TChartTitle(GetOrdValue));
  Designer.Modified;
end;

{ Chart Wall Editor }
procedure TChartWallProperty.Edit;
begin
  EditChartWall(nil,TChartWall(GetOrdValue));
  Designer.Modified;
end;

{ Series Pointer Editor }
procedure TSeriesPointerProperty.Edit;
begin
  {$IFNDEF CLX}
  EditSeriesProc(TSeriesPointer(GetOrdValue).ParentSeries,Designer);
  {$ENDIF}
end;

{ ChartPen Editor }
procedure TChartPenProperty.Edit;
begin
  if EditChartPen(nil,TChartPen(GetOrdValue)) then
     Designer.Modified;
end;

{ ChartBrush Editor }
procedure TChartBrushProperty.Edit;
begin
  if EditChartBrush(nil,TChartBrush(GetOrdValue)) then
     Designer.Modified;
end;

{ Chart Series Marks Editor }
procedure TSeriesMarksProperty.Edit;
var ASeriesMarks : TSeriesMarks;
begin
  ASeriesMarks:=TSeriesMarks(GetOrdValue);
  if Assigned(ASeriesMarks) then
  With ASeriesMarks do
  if Assigned(ParentSeries) then
  begin
    EditSeriesMarks(nil,ParentSeries);
    Designer.Modified;
  end;
end;

{ Gradient Editor }
procedure TChartGradientProperty.Edit;
begin
  if EditTeeGradient(nil,TCustomTeeGradient(GetOrdValue)) then
     Designer.Modified;
end;

{ TTeeShadowProperty }
procedure TTeeShadowProperty.Edit;
begin
  if EditTeeShadow(nil,TTeeShadow(GetOrdValue)) then Designer.Modified;
end;

{ Bar Series Gradient Editor }
procedure TBarSeriesGradientProperty.Edit;
begin
  EditTeeGradient(nil,TBarSeriesGradient(GetOrdValue),True,True);
end;

{ TSeriesDataSource Property }
type
  TSeriesDataSourceProperty = class(TComponentProperty)
  private
    FAddDataSetProc:TGetStrProc;
    procedure AddDataSource(Const S:String);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TSeriesDataSourceProperty.AddDataSource(Const S:String);
Var tmpSeries : TChartSeries;
    tmpComp   : TComponent;
begin
  if S<>'' then
  begin
    tmpComp:=Designer.GetComponent(S);
    if Assigned(tmpComp) then
    begin
      tmpSeries:=TChartSeries(GetComponent(0));
      if tmpSeries.ParentChart.IsValidDataSource(tmpSeries,tmpComp) then
	       FAddDataSetProc(S);
    end;
  end;
end;

procedure TSeriesDataSourceProperty.GetValues(Proc: TGetStrProc);
begin
  if Assigned(TChartSeries(GetComponent(0)).ParentChart) then
  Begin
    FAddDataSetProc:=Proc;
    {$IFDEF TEEDBREG}
    Designer.GetComponentNames(GetTypeData(TDataSource.ClassInfo),AddDataSource);
    Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo),AddDataSource);
    {$ENDIF}
    Designer.GetComponentNames(GetTypeData(TChartSeries.ClassInfo),AddDataSource);
    Designer.GetComponentNames(GetTypeData(TTeeSeriesSource.ClassInfo),AddDataSource);
  end;
end;

{$IFDEF TEEDBREG}
{ TCrosstabField Property }
type
  TCrosstabFieldProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TCrosstabFieldProperty.GetAttributes : TPropertyAttributes;
Begin
  result:=inherited GetAttributes+[paValueList];
end;

procedure TCrosstabFieldProperty.GetValues(Proc: TGetStrProc);
var Crosstab : TDBCrossTabSource;
begin
  Crosstab:=TDBCrossTabSource(GetComponent(0));
  if Assigned(Crosstab.DataSet) then FillDataSetFields(Crosstab.DataSet,Proc);
end;
{$ENDIF}

{ TValueSource Property }
type
  TValueSourceProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TValueSourceProperty.GetAttributes : TPropertyAttributes;
Begin
  result:=inherited GetAttributes+[paValueList];
end;

procedure TValueSourceProperty.GetValues(Proc: TGetStrProc);
Var AValueList : TChartValueList;
begin
  AValueList:=TChartValueList(GetComponent(0));
  With AValueList.Owner do
  if Assigned(ParentChart) then
      TCustomChart(ParentChart).FillValueSourceItems(AValueList,Proc);
end;

{ TSeriesSource Property }
type
  TSeriesSourceProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TSeriesSourceProperty.GetValues(Proc: TGetStrProc);
Var ASeries : TChartSeries;
begin
  ASeries:=TChartSeries(GetComponent(0));
  With ASeries do
  if Assigned(ParentChart) then
     TCustomChart(ParentChart).FillSeriesSourceItems(ASeries,Proc);
end;

function TSeriesSourceProperty.GetAttributes : TPropertyAttributes;
Begin
  result:=inherited GetAttributes+[paValueList];
end;

{$IFDEF TEEDBREG}

{ DBChart Editor }
procedure TDBChartCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index+1=GetVerbCount then TCustomDBChart(Component).RefreshData
                          else inherited;
end;

function TDBChartCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+1;
end;

function TDBChartCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index+1=GetVerbCount then result:=TeeMsg_RefreshData
                          else result:=inherited GetVerb(Index);
end;

{$ENDIF}

{ View3DOptions Editor }
procedure TView3DOptionsProperty.Edit;
begin
  InternalEditPage(TCustomChart(TView3DOptions(GetOrdValue).Parent),teeEdit3DPage);
end;

{$IFDEF D6}
Const TChartAxesCategory   ='Axes';
      TChartWallsCategory  ='Walls';
      TChartTitlesCategory ='Titles';
      TChart3DCategory     ='3D';
{$ELSE}
{$IFDEF CLX}
Const TChartAxesCategory   ='Axes';
      TChartWallsCategory  ='Walls';
      TChartTitlesCategory ='Titles';
      TChart3DCategory     ='3D';
{$ELSE}
{$IFDEF D5}
{ TChartAxesCategory }
class function TChartAxesCategory.Name: string;
begin
  Result:=TeeMsg_ChartAxesCategoryName;
end;

class function TChartAxesCategory.Description: string;
begin
  Result:=TeeMsg_ChartAxesCategoryDesc;
end;

{ TChartWallsCategory }
class function TChartWallsCategory.Name: string;
begin
  Result:=TeeMsg_ChartWallsCategoryName;
end;

class function TChartWallsCategory.Description: string;
begin
  Result:=TeeMsg_ChartWallsCategoryDesc;
end;

{ TChartTitlesCategory }
class function TChartTitlesCategory.Name: string;
begin
  Result:=TeeMsg_ChartTitlesCategoryName;
end;

class function TChartTitlesCategory.Description: string;
begin
  Result:=TeeMsg_ChartTitlesCategoryDesc;
end;

{ TChart3DCategory }
class function TChart3DCategory.Name: string;
begin
  Result:=TeeMsg_Chart3DCategoryName;
end;

class function TChart3DCategory.Description: string;
begin
  Result:=TeeMsg_Chart3DCategoryDesc;
end;
{$ENDIF}
{$ENDIF}
{$ENDIF}

procedure Register;
begin
  RegisterNoIcon([ TCustomChartElement, TTeeFunction ]);

  RegisterComponents( tcAdditional, [TChart] );
  RegisterComponentEditor(TCustomChart,TChartCompEditor);

  {$IFDEF TEEDBREG}
  RegisterComponents( tcDControls, [TDBChart] );
  RegisterComponentEditor(TCustomDBChart,TDBChartCompEditor);
  RegisterComponents( TeeMsg_TeeChartPalette,
                              [ TSeriesDataSet, TDBCrossTabSource ] );
  {$ENDIF}

  {$IFDEF D6}
  RegisterComponentEditor(TChartSeries,TChartSeriesEditor);
  {$ENDIF}

  RegisterComponents(TeeMsg_TeeChartPalette,[ TButtonColor,
                                              TButtonPen,
                                              TComboFlat
                                            ]);

  {$IFDEF CLX}
  RegisterComponents(TeeMsg_TeeChartPalette,[TUpDown]);
  {$ENDIF}

  {$IFNDEF CLX}
  RegisterNonActiveX( [ TCustomTeePanel,
			TCustomAxisPanel,
			TCustomChart,TChart
                        {$IFDEF TEEDBREG}
			,TCustomDBChart,TDBChart
                        {$ENDIF}
                      ] , axrIncludeDescendants );
  {$ENDIF}

  RegisterPropertyEditor(TypeInfo(TSeriesMarks),TChartSeries,
				  'Marks', TSeriesMarksProperty);
  RegisterPropertyEditor(TypeInfo(TSeriesPointer), TCustomSeries, 'Pointer',
						   TSeriesPointerProperty);

  RegisterPropertyEditor(TypeInfo(TChartWall),nil,'',TChartWallProperty);

  RegisterPropertyEditor(TypeInfo(TChartTitle),TCustomChart,
				  '', TChartTitleProperty);

  RegisterPropertyEditor(TypeInfo(TCustomChartLegend),TCustomChart,
				  'Legend', TChartLegendProperty);

  RegisterPropertyEditor(TypeInfo(TChartAxis),TCustomChart,
				  '', TChartAxisProperty);

  RegisterPropertyEditor(TypeInfo(TChartSeriesList), TCustomChart, 'SeriesList',
						     TChartSeriesListProperty);

  RegisterPropertyEditor(TypeInfo(TChartAxisTitle), TChartAxis, 'Title',
						    TChartAxisTitleProperty);
  RegisterPropertyEditor(TypeInfo(TCustomTeeGradient),nil,
				  '', TChartGradientProperty);

  RegisterPropertyEditor(TypeInfo(TTeeShadow),nil,'', TTeeShadowProperty);

  RegisterPropertyEditor(TypeInfo(TBarSeriesGradient),TCustomBarSeries,
				  '', TBarSeriesGradientProperty);

  RegisterPropertyEditor( TypeInfo(TComponent),
			  TChartSeries,'DataSource',TSeriesDataSourceProperty);

  RegisterPropertyEditor( TypeInfo(String),
			  TChartValueList,'ValueSource',TValueSourceProperty);

  {$IFDEF TEEDBREG}
  RegisterPropertyEditor( TypeInfo(String),
			  TDBCrossTabSource,'GroupField',TCrosstabFieldProperty);
  RegisterPropertyEditor( TypeInfo(String),
			  TDBCrossTabSource,'LabelField',TCrosstabFieldProperty);
  RegisterPropertyEditor( TypeInfo(String),
			  TDBCrossTabSource,'ValueField',TCrosstabFieldProperty);
  {$ENDIF}

  RegisterPropertyEditor( TypeInfo(String),
			  TChartSeries,'ColorSource',TSeriesSourceProperty);
  RegisterPropertyEditor( TypeInfo(String),
			  TChartSeries,'XLabelsSource',TSeriesSourceProperty);

  RegisterPropertyEditor(TypeInfo(TChartPen), nil, '',TChartPenProperty);
  RegisterPropertyEditor(TypeInfo(TChartBrush), nil, '',TChartBrushProperty);
  RegisterPropertyEditor(TypeInfo(TView3DOptions),TCustomChart,
				  'View3DOptions', TView3DOptionsProperty);

  {$IFDEF D5}
  RegisterPropertyInCategory(TChartAxesCategory, TypeInfo(TChartAxis));
  RegisterPropertyInCategory(TChartAxesCategory, TCustomAxisPanel, 'AxisBehind');
  RegisterPropertyInCategory(TChartAxesCategory, TCustomAxisPanel, 'AxisVisible');
  RegisterPropertyInCategory(TChartAxesCategory, TypeInfo(TChartCustomAxes));
  RegisterPropertyInCategory(TChartWallsCategory, TypeInfo(TCustomChartWall));
  RegisterPropertyInCategory(TChartWallsCategory, TCustomAxisPanel, 'View3DWalls');
  RegisterPropertyInCategory(TChartTitlesCategory, TypeInfo(TChartTitle));
  RegisterPropertyInCategory(TChart3DCategory, TypeInfo(TView3DOptions));
  RegisterPropertyInCategory(TChart3DCategory, TCustomTeePanel, 'View3D');
  RegisterPropertyInCategory(TChart3DCategory, TCustomTeePanel, 'Chart3DPercent');
  {$ENDIF}
end;

{$IFDEF TEEDBREG}
initialization
 OnGetDesignerNames:=DesignTimeOnGetDesignerNames;
finalization
 OnGetDesignerNames:=nil;
{$ENDIF}
end.
