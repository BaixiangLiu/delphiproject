unit TeeGreek;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeGreekLanguage:TStringList=nil;

Procedure TeeSetGreek;
Procedure TeeCreateGreek;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeGreekConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2003 by David Berneda';

  TeeMsg_Test               :='Test...';
  TeeMsg_LegendFirstValue   :='First Legend Value must be > 0';
  TeeMsg_LegendColorWidth   :='Legend Color Width must be > 0%';
  TeeMsg_SeriesSetDataSource:='No ParentChart to validate DataSource';
  TeeMsg_SeriesInvDataSource:='No valid DataSource: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues must be > 0';
  TeeMsg_AxisLogDateTime    :='DateTime Axis cannot be Logarithmic';
  TeeMsg_AxisLogNotPositive :='Logarithmic Axis Min and Max values should be >= 0';
  TeeMsg_AxisLabelSep       :='Labels Separation % must be greater than 0';
  TeeMsg_AxisIncrementNeg   :='Axis increment must be >= 0';
  TeeMsg_AxisMinMax         :='Axis Minimum Value must be <= Maximum';
  TeeMsg_AxisMaxMin         :='Axis Maximum Value must be >= Minimum';
  TeeMsg_AxisLogBase        :='Axis Logarithmic Base should be >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage must be >= 0';
  TeeMsg_3dPercent          :='3D effect percent must be between %d and %d';
  TeeMsg_CircularSeries     :='Circular Series dependences are not allowed';
  TeeMsg_WarningHiColor     :='16k Color or greater required to get better look';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Axis Title';
  TeeMsg_AxisLabels         :='Axis Labels';
  TeeMsg_RefreshInterval    :='Refresh Interval must be between 0 and 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart is not myself!';
  TeeMsg_GalleryLine        :='Line';
  TeeMsg_GalleryPoint       :='Point';
  TeeMsg_GalleryArea        :='Area';
  TeeMsg_GalleryBar         :='Bar';
  TeeMsg_GalleryHorizBar    :='Horiz. Bar';
  TeeMsg_Stack              :='Stack';
  TeeMsg_GalleryPie         :='Pie';
  TeeMsg_GalleryCircled     :='Circled';
  TeeMsg_GalleryFastLine    :='Fast Line';
  TeeMsg_GalleryHorizLine   :='Horiz Line';

  TeeMsg_PieSample1         :='Cars';
  TeeMsg_PieSample2         :='Phones';
  TeeMsg_PieSample3         :='Tables';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Lamps';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Bikes';
  TeeMsg_PieSample8         :='Chairs';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editing %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Extended';
  TeeMsg_GalleryFunctions   :='Functions';

  TeeMsg_EditChart          :='E&dit Chart...';
  TeeMsg_PrintPreview       :='&Print Preview...';
  TeeMsg_ExportChart        :='E&xport Chart...';
  TeeMsg_CustomAxes         :='Custom Axes...';

  TeeMsg_InvalidEditorClass :='%s: Invalid Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: has no Editor Dialog';

  TeeMsg_GalleryArrow       :='Arrow';

  TeeMsg_ExpFinish          :='&Finish';
  TeeMsg_ExpNext            :='&Next >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Development';
  TeeMsg_GanttSample4       :='Sales';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='New Version';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Change Series Title';
  TeeMsg_NewSeriesTitle     :='New Series Title:';
  TeeMsg_DateTime           :='DateTime';
  TeeMsg_TopAxis            :='Top Axis';
  TeeMsg_BottomAxis         :='Bottom Axis';
  TeeMsg_LeftAxis           :='Left Axis';
  TeeMsg_RightAxis          :='Right Axis';

  TeeMsg_SureToDelete       :='Delete %s ?';
  TeeMsg_DateTimeFormat     :='DateTime For&mat:';
  TeeMsg_Default            :='Default: ';
  TeeMsg_ValuesFormat       :='Values For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Desired %s Increment';

  TeeMsg_IncorrectMaxMinValue:='Incorrect value. Reason: %s';
  TeeMsg_EnterDateTime      :='Enter [Number of Days] [hh:mm:ss]';

  TeeMsg_SureToApply        :='Apply Changes ?';
  TeeMsg_SelectedSeries     :='(Selected Series)';
  TeeMsg_RefreshData        :='&Refresh Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Add';
  TeeMsg_FunctionSubtract   :='Subtract';
  TeeMsg_FunctionMultiply   :='Multiply';
  TeeMsg_FunctionDivide     :='Divide';
  TeeMsg_FunctionHigh       :='High';
  TeeMsg_FunctionLow        :='Low';
  TeeMsg_FunctionAverage    :='Average';

  TeeMsg_GalleryShape       :='Shape';
  TeeMsg_GalleryBubble      :='Bubble';
  TeeMsg_FunctionNone       :='Copy';

  TeeMsg_None               :='(none)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Pointer size must be greater than zero';
  TeeMsg_About              :='Abo&ut TeeChart...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Single Record';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='Function Period should be >= 0';

  TeeMsg_WizardTab          :='Business';
  TeeMsg_TeeChartWizard     :='TeeChart Wizard';

  TeeMsg_ClearImage         :='Clea&r';
  TeeMsg_BrowseImage        :='B&rowse...';

  TeeMsg_WizardSureToClose  :='Are you sure that you want to close the TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Field %s does not exist';

  TeeMsg_DepthAxis          :='Depth Axis';
  TeeMsg_PieOther           :='Other';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pie';
  TeeMsg_ValuesBar          :='Bar';
  TeeMsg_ValuesAngle        :='Angle';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='End';
  TeeMsg_ValuesGanttNextTask:='NextTask';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='Legend';
  TeeMsg_Title              :='Title';
  TeeMsg_Foot               :='Footer';
  TeeMsg_Period		    :='Period';
  TeeMsg_PeriodRange        :='Period range';
  TeeMsg_CalcPeriod         :='Calculate %s every:';
  TeeMsg_SmallDotsPen       :='Small Dots';

  TeeMsg_InvalidTeeFile     :='Invalid Chart in *.tee file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.tee file format';
  TeeMsg_EmptyTeeFile       :='Empty *.tee file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Chart Axes';
  TeeMsg_ChartAxesCategoryDesc   := 'Chart Axes properties and events';
  TeeMsg_ChartWallsCategoryName  := 'Chart Walls';
  TeeMsg_ChartWallsCategoryDesc  := 'Chart Walls properties and events';
  TeeMsg_ChartTitlesCategoryName := 'Chart Titles';
  TeeMsg_ChartTitlesCategoryDesc := 'Chart Titles properties and events';
  TeeMsg_Chart3DCategoryName     := 'Chart 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Chart 3D properties and events';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Custom ';
  TeeMsg_Series                 :='Series';
  TeeMsg_SeriesList             :='Series...';

  TeeMsg_PageOfPages            :='Page %d of %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='First';
  TeeMsg_Prior  :='Prior';
  TeeMsg_Next   :='Next';
  TeeMsg_Last   :='Last';
  TeeMsg_Insert :='Insert';
  TeeMsg_Delete :='Delete';
  TeeMsg_Edit   :='Edit';
  TeeMsg_Post   :='Post';
  TeeMsg_Cancel :='Cancel';

  TeeMsg_All    :='(all)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='as &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='as &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Panel property is not set in Export format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='No Border';
  TeeMsg_Dotted    :='Dotted';
  TeeMsg_Colors    :='Colors';
  TeeMsg_Filled    :='Filled';
  TeeMsg_Marks     :='Marks';
  TeeMsg_Stairs    :='Stairs';
  TeeMsg_Points    :='Points';
  TeeMsg_Height    :='Height';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='Point 2D';
  TeeMsg_Triangle  :='Triangle';
  TeeMsg_Star      :='Star';
  TeeMsg_Circle    :='Circle';
  TeeMsg_DownTri   :='Down Tri.';
  TeeMsg_Cross     :='Cross';
  TeeMsg_Diamond   :='Diamond';
  TeeMsg_NoLines   :='No Lines';
  TeeMsg_Stack100  :='Stack 100%';
  TeeMsg_Pyramid   :='Pyramid';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Inv. Pyramid';
  TeeMsg_Sides     :='Sides';
  TeeMsg_SideAll   :='Side All';
  TeeMsg_Patterns  :='Patterns';
  TeeMsg_Exploded  :='Exploded';
  TeeMsg_Shadow    :='Shadow';
  TeeMsg_SemiPie   :='Semi Pie';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Vert.Line';
  TeeMsg_HorizLine :='Horiz.Line';
  TeeMsg_Line      :='Line';
  TeeMsg_Cube      :='Cube';
  TeeMsg_DiagCross :='Diag.Cross';

  TeeMsg_CanNotFindTempPath    :='Can not find Temp folder';
  TeeMsg_CanNotCreateTempChart :='Can not create Temp file';
  TeeMsg_CanNotEmailChart      :='Can not email TeeChart. Mapi Error: %d';

  TeeMsg_SeriesDelete :='Series Delete: ValueIndex %d out of bounds (0 to %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='as &JPEG';
  TeeMsg_JPEGFilter    :='JPEG files (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='as &GIF';
  TeeMsg_GIFFilter     :='GIF files (*.gif)|*.gif';
  TeeMsg_AsPNG         :='as &PNG';
  TeeMsg_PNGFilter     :='PNG files (*.png)|*.png';
  TeeMsg_AsPCX         :='as PC&X';
  TeeMsg_PCXFilter     :='PCX files (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='as &VML (HTM)';
  TeeMsg_VMLFilter     :='VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Language...';

  { 5.03 }
  TeeMsg_Gradient     :='Gradient';
  TeeMsg_WantToSave   :='Do you want to save %s?';
  TeeMsg_NativeFilter :='TeeChart files (*.tee)|*.tee';

  TeeMsg_Property     :='Property';	
  TeeMsg_Value        :='Value';
  TeeMsg_Yes          :='Yes';
  TeeMsg_No           :='No';
  TeeMsg_Image        :='(image)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Candle';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Surface';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Point 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Bar 3D';
  TeeMsg_GalleryBigCandle   :='Big Candle';
  TeeMsg_GalleryLinePoint   :='Line Point';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Water Fall';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Clock';
  TeeMsg_GalleryColorGrid   :='ColorGrid';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='Bar Join';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramid';
  TeeMsg_GalleryMap         :='Map';

  TeeMsg_PolyDegreeRange    :='Polynomial degree must be between 1 and 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index must be between 1 and %d';
  TeeMsg_FittingError        :='Cannot process fitting';
  TeeMsg_PeriodRange         :='Period must be >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight must be between 0 and 1';
  TeeMsg_GalleryErrorBar     :='Error Bar';
  TeeMsg_GalleryError        :='Error';
  TeeMsg_GalleryHighLow      :='High-Low';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Exp. Average';
  TeeMsg_FunctionMovingAverage:='Moving Avrg.';
  TeeMsg_FunctionExpMovAve   :='Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Cumulative';
  TeeMsg_FunctionStdDeviation:='Std.Deviation';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Count';
  TeeMsg_LoadChart           :='Open TeeChart...';
  TeeMsg_SaveChart           :='Save TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro files';

  TeeMsg_GallerySamples      :='Other';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Cannot find Series editor Form: %s';


  TeeMsg_CannotLoadChartFromURL:='Error code: %d downloading Chart from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Error code: %d downloading Series data from URL: %s';

  TeeMsg_ValuesDate          :='Date';
  TeeMsg_ValuesOpen          :='Open';
  TeeMsg_ValuesHigh          :='High';
  TeeMsg_ValuesLow           :='Low';
  TeeMsg_ValuesClose         :='Close';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Number of Bezier points should be > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Print';
  TeeCommanMsg_Copy     :='Copy';
  TeeCommanMsg_Save     :='Save';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d° Elevation: %d°';
  TeeCommanMsg_Rotate   :='Rotate';

  TeeCommanMsg_Moving   :='Horiz.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Move';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Depth';

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Drag %s to Rotate';
  TeeCommanMsg_MoveLabel  :='Drag %s to Move';
  TeeCommanMsg_ZoomLabel  :='Drag %s to Zoom';
  TeeCommanMsg_DepthLabel :='Drag %s to resize 3D';

  TeeCommanMsg_NormalLabel:='Drag Left button to Zoom, Right button to Scroll';
  TeeCommanMsg_NormalPieLabel:='Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='Number of points must be >= 4';
  TeeMsg_TriSurfaceAllColinear :='All colinear data points';
  TeeMsg_TriSurfaceSimilar     :='Similar points - cannot execute';
  TeeMsg_GalleryTriSurface     :='Triangle Surf.';

  TeeMsg_AllSeries :='All Series';
  TeeMsg_Edit      :='Edit';

  TeeMsg_GalleryFinancial    :='Financial';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Drag Marks';
  TeeMsg_AxisArrowTool :='Axis Arrows';
  TeeMsg_DrawLineTool  :='Draw Line';
  TeeMsg_NearestTool   :='Nearest Point';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='Color Line';
  TeeMsg_RotateTool    :='Rotate';
  TeeMsg_ImageTool     :='Image';
  TeeMsg_MarksTipTool  :='Mark Tips';
  TeeMsg_AnnotationTool:='Annotation';

  TeeMsg_CantDeleteAncestor  :='Can not delete ancestor';

  TeeMsg_Load	          :='Load...';
  TeeMsg_DefaultDemoTee   :='http://www.steema.com/demo.tee';
  TeeMsg_NoSeriesSelected :='No Series selected';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Series';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Switch 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Active';
  TeeMsg_ActionSeriesActiveHint := 'Show / Hide Series';
  TeeMsg_ActionEditHint         := 'Edit Chart';
  TeeMsg_ActionEdit             := '&Edit...';
  TeeMsg_ActionCopyHint         := 'Copy to Clipboard';
  TeeMsg_ActionCopy             := '&Copy';
  TeeMsg_ActionPrintHint        := 'Print preview Chart';
  TeeMsg_ActionPrint            := '&Print...';
  TeeMsg_ActionAxesHint         := 'Show / Hide Axes';
  TeeMsg_ActionAxes             := '&Axes';
  TeeMsg_ActionGridsHint        := 'Show / Hide Grids';
  TeeMsg_ActionGrids            := '&Grids';
  TeeMsg_ActionLegendHint       := 'Show / Hide Legend';
  TeeMsg_ActionLegend           := '&Legend';
  TeeMsg_ActionSeriesEditHint   := 'Edit Series';
  TeeMsg_ActionSeriesMarksHint  := 'Show / Hide Series Marks';
  TeeMsg_ActionSeriesMarks      := '&Marks';
  TeeMsg_ActionSaveHint         := 'Save Chart';
  TeeMsg_ActionSave             := '&Save...';

  TeeMsg_CandleBar              := 'Bar';
  TeeMsg_CandleNoOpen           := 'No Open';
  TeeMsg_CandleNoClose          := 'No Close';
  TeeMsg_NoHigh                 := 'No High';
  TeeMsg_NoLow                  := 'No Low';
  TeeMsg_ColorRange             := 'Color Range';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := 'Positions';
  TeeMsg_NoGrid                 := 'No Grid';
  TeeMsg_NoPoint                := 'No Point';
  TeeMsg_NoLine                 := 'No Line';
  TeeMsg_Labels                 := 'Labels';
  TeeMsg_NoCircle               := 'No Circle';
  TeeMsg_Lines                  := 'Lines';
  TeeMsg_Border                 := 'Border';

  TeeMsg_SmithResistance      := 'Resistance';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := 'Column';

  { 5.01 }
  TeeMsg_Separator            := 'Separator';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Funnel';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Exceeds quota';
  TeeMsg_FunnelWithin         := ' within quota';
  TeeMsg_FunnelBelow          := ' or more below quota';
  TeeMsg_CalendarSeries       := 'Calendar';
  TeeMsg_DeltaPointSeries     := 'DeltaPoint';
  TeeMsg_ImagePointSeries     := 'ImagePoint';
  TeeMsg_ImageBarSeries       := 'ImageBar';
  TeeMsg_SeriesTextFieldZero  := 'SeriesText: Field index should be greater than zero.';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Transparency';
  TeeMsg_Box		      := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Page Number';
  TeeMsg_TextFile             := 'Text File';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateGreek;
begin
  if not Assigned(TeeGreekLanguage) then
  begin
    TeeGreekLanguage:=TStringList.Create;
    TeeGreekLanguage.Text:=

'GRADIENT EDITOR=Editor Gradiente'#13+
'GRADIENT=Gradiente'#13+
'DIRECTION=Direzione'#13+
'VISIBLE=Visibile'#13+
'TOP BOTTOM=Dall''Alto al Basso'#13+
'BOTTOM TOP=Dal Basso al Alto'#13+
'LEFT RIGHT=Da Sinistra a Destra'#13+
'RIGHT LEFT=Da Destra a Sinistra'#13+
'FROM CENTER=Dal Centro'#13+
'FROM TOP LEFT=Dall''Alto a Sinistra'#13+
'FROM BOTTOM LEFT=Dal Basso a Destra'#13+
'OK=Ok'#13+
'CANCEL=Annulla'#13+
'COLORS=Colori'#13+
'START=Inizio'#13+
'MIDDLE=Centro'#13+
'END=Fine'#13+
'SWAP=Scambio'#13+
'NO MIDDLE=Senza centro'#13+
'TEEFONT EDITOR=Editor dei Caratteri'#13+
'INTER-CHAR SPACING=Spaziatura fra i Caratteri'#13+
'FONT=Carattere'#13+
'SHADOW=Ombra'#13+
'HORIZ. SIZE=Dimens. Orizz.'#13+
'VERT. SIZE=Dimens.   Vert.'#13+
'COLOR=Colore'#13+
'OUTLINE=Bordo'#13+
'OPTIONS=Opzioni'#13+
'FORMAT=Formato'#13+
'TEXT=Testo'#13+
'GRADIENT=Gradiente'#13+
'POSITION=Posizione'#13+
//'LEFT=Sinistra'#13+
'TOP=Alto'#13+
'AUTO=Auto'#13+
'CUSTOM=Personal'#13+
'LEFT TOP=Sinistra alto'#13+
'LEFT BOTTOM=Sinistra basso'#13+
'RIGHT TOP=Destra alto'#13+
'RIGHT BOTTOM=Destra basso'#13+
'MULTIPLE AREAS=Aree Multiple'#13+
'NONE=Nessuno'#13+
'STACKED=Impilato'#13+
'STACKED 100%=Impilato al 100%'#13+
'AREA=Area'#13+
'PATTERN=Motivo'#13+
'STAIRS=Gradini'#13+
'SOLID=Solido'#13+
'CLEAR=Chiaro'#13+
'HORIZONTAL=Orizzontale'#13+
'VERTICAL=Verticale'#13+
'DIAGONAL=Diagonale'#13+
'B.DIAGONAL=B.Diagonale'#13+
'CROSS=Croce'#13+
'DIAG.CROSS=Croce Diag.'#13+
'AREA LINES=Linee Area'#13+
'BORDER=Cornice'#13+
'INVERTED=Invertito'#13+
'INVERTED SCROLL=Spostam.&Invertito'#13+
'COLOR EACH=Colorare'#13+
'ORIGIN=Origine'#13+
'USE ORIGIN=Usare Origine'#13+
'WIDTH=Ampiezza'#13+
'HEIGHT=Altezza'#13+
'AXIS=Asse'#13+
'LENGTH=Lunghezza'#13+
'SCROLL=Spostamento'#13+
'START=Inizio'#13+
'END=Fine'#13+
'BOTH=Entrambi'#13+
'AXIS INCREMENT=Incremento Assi'#13+
'INCREMENT=Incremento'#13+
'INCREMENT=Ampiezza del passo'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Un Millisecondo'#13+
'ONE SECOND=Un Secondo'#13+
'FIVE SECONDS=Cinque Secondi'#13+
'TEN SECONDS=Dieci Secondi'#13+
'FIFTEEN SECONDS=Quindici Secondi'#13+
'THIRTY SECONDS=Trenta Secondi'#13+
'ONE MINUTE=Un Minuto'#13+
'FIVE MINUTES=Cinque Minuti'#13+
'TEN MINUTES=Dieci Minuti'#13+
'FIFTEEN MINUTES=Quindici Minuti'#13+
'THIRTY MINUTES=Trenta Minuti'#13+
'ONE HOUR=Una Ora'#13+
'TWO HOURS=Due Ore'#13+
'SIX HOURS=Sei Ore'#13+
'TWELVE HOURS=Dodici Ore'#13+
'ONE DAY=Un Giorno'#13+
'TWO DAYS=Due Giorni'#13+
'THREE DAYS=Tre Giorni'#13+
'ONE WEEK=Una Settimana'#13+
'HALF MONTH=Mezzo Mese'#13+
'ONE MONTH=Un Mese'#13+
'TWO MONTHS=Due Mesi'#13+
'THREE MONTHS=Tre Mesi'#13+
'FOUR MONTHS=Quattro Mesi'#13+
'SIX MONTHS=Sei Mesi'#13+
'ONE YEAR=Un Anno'#13+
'EXACT DATE TIME=Data Esatta'#13+
'AXIS MAXIMUM AND MINIMUM=Asse Massimo e Minimo'#13+
'VALUE=Valore'#13+
'TIME=Ora'#13+
'LEFT AXIS=Asse Sinistro'#13+
'RIGHT AXIS=Asse Destro'#13+
'TOP AXIS=Asse Superiore'#13+
'BOTTOM AXIS=Asse Inferiore'#13+
'% BAR WIDTH=Larghezza % Barre'#13+
'STYLE=Stile'#13+
'% BAR OFFSET=Spostamento % Barre'#13+
'RECTANGLE=Rettangolo'#13+
'PYRAMID=Piramide'#13+
'INVERT. PYRAMID=Piramide Rovesciata'#13+
'CYLINDER=Cilindro'#13+
'ELLIPSE=Ellisse'#13+
'ARROW=Freccia'#13+
'RECT. GRADIENT=Rett. Gradiente'#13+
'CONE=Cono'#13+
'DARK BAR 3D SIDES=Lati Scuri della Barra 3D'#13+
'BAR SIDE MARGINS=Margini Laterali Barra'#13+
'AUTO MARK POSITION=Posizione Contrass. Autom.'#13+
'BORDER=Cornice'#13+
'JOIN=Unione'#13+
'BAR SIDE MARGINS=Margini Laterali Barra'#13+
'DATASET=DataSet'#13+
'APPLY=Applica'#13+
'SOURCE=Origine'#13+
'MONOCHROME=Monocromatico'#13+
'DEFAULT=Default'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'LENGTH=Lunghezza'#13+
'MEDIAN=Mediana'#13+
'WHISKER=Filo'#13+
'PATTERN COLOR EDITOR=Editor di Motivi'#13+
'IMAGE=Immagine'#13+
'NONE=Nessuno'#13+
'BACK DIAGONAL=Diagonale Rovesciata'#13+
'CROSS=Croce'#13+
'DIAGONAL CROSS=Croce Diagonale'#13+
'FILL 80%=Riempimento 80%'#13+
'FILL 60%=Riempimento 60%'#13+
'FILL 40%=Riempimento 40%'#13+
'FILL 20%=Riempimento 20%'#13+
'FILL 10%=Riempimento 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Verticale Piccolo'#13+
'HORIZ. SMALL=Orizz. Piccolo'#13+
'DIAG. SMALL=Diag. Piccolo'#13+
'BACK DIAG. SMALL=Diag. Rovesc. Piccola'#13+
'CROSS SMALL=Croce Piccola'#13+
'DIAG. CROSS SMALL=Croce Diag. Piccola'#13+
'PATTERN COLOR EDITOR=Editor Motivi di Colori'#13+
'OPTIONS=Opzioni'#13+
'DAYS=Giorni'#13+
'WEEKDAYS=Giorni Settimana'#13+
'TODAY=Oggi'#13+
'SUNDAY=Domenica'#13+
'TRAILING=Altri Giorni'#13+
'MONTHS=Mesi'#13+
'LINES=Linee'#13+
'SHOW WEEKDAYS=Giorni Settimana'#13+
'UPPERCASE=Maiuscolo'#13+
'TRAILING DAYS=Vedi Altri Giorni'#13+
'SHOW TODAY=Mostra Giorno Attuale'#13+
'SHOW MONTHS=Mostra i Mesi'#13+
'SHOW PREVIOUS BUTTON=Mostra Tasto Precedente'#13+
'SHOW NEXT BUTTON=Mostra Tasto Prossimo'#13+
'CANDLE WIDTH=Ampiezza Candele'#13+
'STICK=Bastoncino'#13+
'BAR=Barra'#13+
'OPEN CLOSE=Apertura Chiusura'#13+
'UP CLOSE=Chiusura Superiore'#13+
'DOWN CLOSE=Chiusura Inferiore'#13+
'SHOW OPEN=Mostra Apertura'#13+
'SHOW CLOSE=Mostra Chiusura'#13+
'DRAW 3D=Disegnare 3D'#13+
'DARK 3D=Scuro 3D'#13+
'EDITING=Editing'#13+
'CHART=Grafico'#13+
'SERIES=Serie'#13+
'DATA=Dati'#13+
'TOOLS=Stumenti'#13+
'EXPORT=Esporta'#13+
'PRINT=Stampa'#13+
'GENERAL=Generale'#13+
'TITLES=Titoli'#13+
'LEGEND=Leggenda'#13+
'PANEL=Pannello'#13+
'PAGING=Pagina'#13+
'WALLS=Pareti'#13+
'3D=3D'#13+
'ADD=Aggiungi'#13+
'DELETE=Cancella'#13+
'TITLE=Titolo'#13+
'CLONE=Duplicare'#13+
'CHANGE=Cambia'#13+
'HELP=Aiuto'#13+
'CLOSE=Chiudi'#13+
'IMAGE=Immagine'#13+
'TEECHART PRINT PREVIEW=Anteprima di Stampa di TeeChart'#13+
'PRINTER=Stampante'#13+
'SETUP=Impostazioni'#13+
'ORIENTATION=Orientamento'#13+
'PORTRAIT=Ritratto'#13+
'LANDSCAPE=Panorama'#13+
'MARGINS (%)=Margini (%)'#13+
'DETAIL=Dettaglio'#13+
'MORE=Alto'#13+
'NORMAL=Normale'#13+
'RESET MARGINS=Ripristino Margini'#13+
'VIEW MARGINS=Vedi Margini'#13+
'PROPORTIONAL=Proporzionale'#13+
'RECTANGLE=Rettangolo'#13+
'CIRCLE=Cerchio'#13+
'VERTICAL LINE=Linea Verticale'#13+
'HORIZ. LINE=Linea Orizzontale'#13+
'TRIANGLE=Triangolo'#13+
'INVERT. TRIANGLE=Triangolo Rovesciato'#13+
'LINE=Linea'#13+
'DIAMOND=Diamante'#13+
'CUBE=Cubo'#13+
'DIAGONAL CROSS=Croce Diagonale'#13+
'STAR=Stella'#13+
'TRANSPARENT=Trasparente'#13+
'HORIZ. ALIGNMENT=Allineamento Orizzontale'#13+
'LEFT=Sinistro'#13+
'CENTER=Centro'#13+
'RIGHT=Destro'#13+
'ROUND RECTANGLE=Rettangolo Smussato'#13+
'ALIGNMENT=Allineamento'#13+
'TOP=Alto'#13+
'BOTTOM=Basso'#13+
'RIGHT=Destra'#13+
'BOTTOM=Basso'#13+
'UNITS=Unitá'#13+
'PIXELS=Pixels'#13+
'AXIS=Assi'#13+
'AXIS ORIGIN=Origine degli Assi'#13+
'ROTATION=Rotazione'#13+
'CIRCLED=Arrotondato'#13+
'3 DIMENSIONS=A 3 Dimensioni'#13+
'RADIUS=Raggio'#13+
'ANGLE INCREMENT=Incremen. Angolare'#13+
'RADIUS INCREMENT=Incremento Radiale'#13+
'CLOSE CIRCLE=Cerchio Chiuso'#13+
'PEN=Penna'#13+
'CIRCLE=Cerchio'#13+
'LABELS=Etichette'#13+
'VISIBLE=Visibile'#13+
'ROTATED=Ruotato'#13+
'CLOCKWISE=Senso Orario'#13+
'INSIDE=Interno'#13+
'ROMAN=Romano'#13+
'HOURS=Ore'#13+
'MINUTES=Minuti'#13+
'SECONDS=Secondi'#13+
'START VALUE=Valore Iniziale'#13+
'END VALUE=Valore Finale'#13+
'TRANSPARENCY=Trasparenza'#13+
'DRAW BEHIND=Disegna sfondo'#13+
'COLOR MODE=Modo Colore'#13+
'STEPS=Gradino'#13+
'RANGE=Intervallo'#13+
'PALETTE=Tavolozza'#13+
'PALE=Pallido'#13+
'STRONG=Scuro'#13+
'GRID SIZE=Dimensione della Griglia'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Profondità'#13+
'IRREGULAR=Irregolare'#13+
'GRID=Griglia'#13+
'VALUE=Valore'#13+
'ALLOW DRAG=Permetti trascinamento'#13+
'VERTICAL POSITION=Posizione Verticale'#13+
'PEN=Penna'#13+
'LEVELS POSITION=Posizione Livelli'#13+
'LEVELS=Livelli'#13+
'NUMBER=Numero'#13+
'LEVEL=Livello'#13+
'AUTOMATIC=Automatico'#13+
'BOTH=Entrambi'#13+
'SNAP=Aggiusta'#13+
'FOLLOW MOUSE=Segui il Mouse'#13+
'STACK=Pila'#13+
'HEIGHT 3D=Altezza 3D'#13+
'LINE MODE=Modo Linea'#13+
'STAIRS=Gradini'#13+
'NONE=Nessuno'#13+
'OVERLAP=Sovrapponi'#13+
'STACK=Pila'#13+
'STACK 100%=Pila 100%'#13+
'CLICKABLE=Cliccabile'#13+
'LABELS=Etichette'#13+
'AVAILABLE=Disponibile'#13+
'SELECTED=Selezionato'#13+
'DATASOURCE=Fonte Dati'#13+
'GROUP BY=Raggruppa con'#13+
'CALC=Calc'#13+
'OF=di'#13+
'SUM=Somma'#13+
'COUNT=Conto'#13+
'HIGH=Alto'#13+
'LOW=Basso'#13+
'AVG=Media'#13+
'HOUR=Ora'#13+
'DAY=Giorno'#13+
'WEEK=Settimana'#13+
'WEEKDAY=Giorno della settimana'#13+
'MONTH=Mese'#13+
'QUARTER=Quadrimestre'#13+
'YEAR=Anno'#13+
'HOLE %=Foro %'#13+
'RESET POSITIONS=Ripristina Posizioni'#13+
'MOUSE BUTTON=Tasto Mouse'#13+
'ENABLE DRAWING=Abilita Disegno'#13+
'ENABLE SELECT=Abilita Selezione'#13+
'ENHANCED=Migliorato'#13+
'ERROR WIDTH=Ampiezza Errore'#13+
'WIDTH UNITS=Unità Amp.'#13+
'PERCENT=Percentuale'#13+
'PIXELS=Pixel'#13+
'LEFT AND RIGHT=Sinistro e Destro'#13+
'TOP AND BOTTOM=Alto e Basso'#13+
'BORDER=Bordi'#13+
'BORDER EDITOR=Editor dei Tratti'#13+
'DASH=Linea'#13+
'DOT=Punto'#13+
'DASH DOT=Linea Punto'#13+
'DASH DOT DOT=Linea Punto Punto'#13+
'CALCULATE EVERY=Calcola Ciascuno'#13+
'ALL POINTS=Tutti i Punti'#13+
'NUMBER OF POINTS=Numero di Punti'#13+
'RANGE OF VALUES=Intervallo di Valori'#13+
'FIRST=Primo'#13+
'CENTER=Centro'#13+
'LAST=Ultimo'#13+
'TEEPREVIEW EDITOR=Editor TeeAnteprima'#13+
'ALLOW MOVE=Permetti Spostamen.'#13+
'ALLOW RESIZE=Permetti Ridimens.'#13+
'DRAG IMAGE=Trascina Immag.'#13+
'AS BITMAP=Come Bitmap'#13+
'SHOW IMAGE=Mostra Immagine'#13+
'MARGINS=Margini'#13+
'SIZE=Spess.'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ROTATION=Rotazione'#13+
'ELEVATION=Elevazione'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Spostam. Orizz.'#13+
'VERT. OFFSET=Spostam.   Vert.'#13+
'PERSPECTIVE=Prospettiva'#13+
'ANGLE=Angolo'#13+
'ORTHOGONAL=Ortogonale'#13+
'ZOOM TEXT=Zoom del Testo'#13+
'SCALES=Scale'#13+
'TITLE=Titolo'#13+
'TICKS=Tratto'#13+
'MINOR=Minori'#13+
'MAXIMUM=Massimo'#13+
'MINIMUM=Minimo'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Incremento'#13+
'(INCREMENT)=(incremento)'#13+
'LOG BASE=Base Log'#13+
'LOGARITHMIC=Logaritmico'#13+
'TITLE=Titolo'#13+
'MIN. SEPARATION %=Separazione Min. %'#13+
'MULTI-LINE=Multi-linee'#13+
'LABEL ON AXIS=Etichette su Assi'#13+
'ROUND FIRST=Arrotonda Prima'#13+
'MARK=Contrassegno'#13+
'LABELS FORMAT=Formato Etichette'#13+
'EXPONENTIAL=Esponenziale'#13+
'DEFAULT ALIGNMENT=Allineamento di Default'#13+
'LEN=Lung.'#13+
'AXIS=Assi'#13+
'INNER=Interno'#13+
'GRID=Griglia'#13+
'AT LABELS ONLY=Solo su Etichette'#13+
'CENTERED=Centrato'#13+
'COUNT=Conto'#13+
'POSITION %=Posizione %'#13+
'START %=Inizio %'#13+
'END %=Fine %'#13+
'OTHER SIDE=Parte Opposta'#13+
'AXES=Assi'#13+
'BEHIND=Sfondo'#13+
'CLIP POINTS=Nascondi'#13+
'PRINT PREVIEW=Anteprima Stampa'#13+
'MINIMUM PIXELS=Minimo Pixel'#13+
'MOUSE BUTTON=Clic del Mouse'#13+
'ALLOW=Permetti'#13+
'ANIMATED=Animato'#13+
'VERTICAL=Verticale'#13+
'RIGHT=Destro'#13+
'ALLOW SCROLL=Permetti Scorrimento'#13+
'TEEOPENGL EDITOR=Editor TeeOpenGL'#13+
'AMBIENT LIGHT=Luce Ambiente'#13+
'SHININESS=Brillantezza'#13+
'FONT 3D DEPTH=Profond.Caratt.3D'#13+
'ACTIVE=Attivo'#13+
'FONT OUTLINES=Contorno dei Caratteri'#13+
'SMOOTH SHADING=Ombreggiatura Leggera'#13+
'LIGHT=Luce'#13+
'Y=Y'#13+
'INTENSITY=Intensità'#13+
'BEVEL=Smusso'#13+
'FRAME=Cornice'#13+
'ROUND FRAME=Cornice Arrotondata'#13+
'LOWERED=Incavo'#13+
'RAISED=Rilievo'#13+
'POSITION=Posizione'#13+
'SYMBOLS=Simbolo'#13+
'TEXT STYLE=Stile Testo'#13+
'LEGEND STYLE=Stile Legenda'#13+
'VERT. SPACING=Spaziatura Vert.'#13+
'AUTOMATIC=Automatico'#13+
'SERIES NAMES=Nomi Serie'#13+
'SERIES VALUES=Valori Serie'#13+
'LAST VALUES=Ultimi Valori'#13+
'PLAIN=Testo'#13+
'LEFT VALUE=Valore Sinistro'#13+
'RIGHT VALUE=Valore Destro'#13+
'LEFT PERCENT=Percentuale Sinistra'#13+
'RIGHT PERCENT=Percentuale Destra'#13+
'X VALUE=Valore X'#13+
'VALUE=Valore'#13+
'PERCENT=Percento'#13+
'X AND VALUE=X e Valore'#13+
'X AND PERCENT=X e Percentuale'#13+
'CHECK BOXES=Casella Controllo'#13+
'DIVIDING LINES=Linee di Divisione'#13+
'FONT SERIES COLOR=Colore Caratteri delle Serie'#13+
'POSITION OFFSET %=Spostamento %'#13+
'MARGIN=Margine'#13+
'RESIZE CHART=Ridimensiona Grafico'#13+
'WIDTH UNITS=Ampiezza Unità'#13+
'CONTINUOUS=Continuo'#13+
'POINTS PER PAGE=Punti per Pagina'#13+
'SCALE LAST PAGE=Scalare Ultima Pagina'#13+
'CURRENT PAGE LEGEND=Legenda Pagina Corrente'#13+
'PANEL EDITOR=Editor di Pannello'#13+
'BACKGROUND=Sottofondo'#13+
'BORDERS=Bordi'#13+
'BACK IMAGE=Immagine sfondo'#13+
'STRETCH=Estendi'#13+
'TILE=Affianca'#13+
'CENTER=Centro'#13+
'BEVEL INNER=Smusso Interno'#13+
'LOWERED=Abbassato'#13+
'RAISED=Elevato'#13+
'BEVEL OUTER=Smusso esterno'#13+
'MARKS=Contrassegni'#13+
'DATA SOURCE=Fonte Dati'#13+
'SORT=Ordina'#13+
'CURSOR=Cursore'#13+
'SHOW IN LEGEND=Mostra nella Legenda'#13+
'FORMATS=Formati'#13+
'VALUES=Valori'#13+
'PERCENTS=Percentuali'#13+
'HORIZONTAL AXIS=Asse Orizzontale'#13+
'TOP AND BOTTOM=Alto e Basso'#13+
'DATETIME=Data/Ora'#13+
'VERTICAL AXIS=Asse Verticale'#13+
'LEFT=Sinistra'#13+
'RIGHT=Destra'#13+
'LEFT AND RIGHT=Sinistra e Destra'#13+
'ASCENDING=Ascendente'#13+
'DESCENDING=Discendente'#13+
'DRAW EVERY=Disegna Tutti'#13+
'CLIPPED=Nascosto'#13+
'ARROWS=Frecce'#13+
'MULTI LINE=Multi-linea'#13+
'ALL SERIES VISIBLE=Tutte le Serie Visibili'#13+
'LABEL=Etichetta'#13+
'LABEL AND PERCENT=Etichetta e percentuale'#13+
'LABEL AND VALUE=Etichetta e Valore'#13+
'PERCENT TOTAL=Percentuale Totale'#13+
'LABEL AND PERCENT TOTAL=Etichetta Percentuale Totale'#13+
'X VALUE=Valore X'#13+
'X AND Y VALUES=Valori X e Y'#13+
'MANUAL=Manuale'#13+
'RANDOM=Casuale'#13+
'FUNCTION=Funzione'#13+
'NEW=Nuovo'#13+
'EDIT=Edit'#13+
'DELETE=Cancella'#13+
'PERSISTENT=Persistente'#13+
'ADJUST FRAME=Aggiusta Cornice'#13+
'SUBTITLE=Sottotitolo'#13+
'SUBFOOT=Sub piè pag.'#13+
'FOOT=Pié Pagina'#13+
'DELETE=Cancella'#13+
'VISIBLE WALLS=Pareti Visibili'#13+
'BACK=Dietro'#13+
'DIF. LIMIT=Limite Dif.'#13+
'ABOVE=Sopra'#13+
'WITHIN=Dentro'#13+
'BELOW=Sotto'#13+
'CONNECTING LINES=Linee di Connessione'#13+
'SERIES=Serie'#13+
'PALE=Pallido'#13+
'STRONG=Forte'#13+
'HIGH=Alto'#13+
'LOW=Basso'#13+
'BROWSE=Scegli'#13+
'TILED=Affiancati'#13+
'INFLATE MARGINS=Ampliare i Margini'#13+
'ROUND=Arrotond.'#13+
'SQUARE=Quadrato'#13+
'FLAT=Piano'+#13+
'DOWN TRIANGLE=Triangolo in giù'#13+
'SMALL DOT=Piccoli Punto'#13+
'GLOBAL=Globale'#13+
'SHAPES=Forme'#13+
'BRUSH=Pennello'#13+
'BRUSH=Motivo'#13+
'BORDER=Bordi'#13+
'COLOR=Color'#13+
'DELAY=Ritardo'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Azione del Mouse'#13+
'MOVE=Sposta'#13+
'CLICK=Clic'#13+
'BRUSH=Pennello'#13+
'DRAW LINE=Disegna Linea'#13+
'BORDER EDITOR=Editor di Bordi'#13+
'DASH=Linea'#13+
'DOT=Punto'#13+
'DASH DOT=Linea Punto'#13+
'DASH DOT DOT=Linea Punto Punto'#13+
'EXPLODE BIGGEST=Separare le Parti'#13+
'TOTAL ANGLE=Angolo Totale'#13+
'GROUP SLICES=Raggruppare le parti'#13+
'BELOW %=Inferiore a %'#13+
'BELOW VALUE=Inferiore al Valore'#13+
'OTHER=Altri'#13+
'PATTERNS=Motivi'#13+
'CLOSE CIRCLE=Cerchio Chiuso'#13+
'VISIBLE=Visibile'#13+
'CLOCKWISE=In Senso Orario'#13+
'SIZE %=Dimen. %'#13+
'SERIES DATASOURCE TEXT EDITOR=Editor Fonte Dati di Testo delle Serie'#13+
'FIELDS=Campi'#13+
'NUMBER OF HEADER LINES=Numero Linee Intestazione'#13+
'SEPARATOR=Separatore'#13+
'COMMA=Virgola'#13+
'SPACE=Spazio'#13+
'TAB=Tabulatore'#13+
'FILE=File'#13+
'WEB URL=URL Web'#13+
'LOAD=Carica'#13+
'C LABELS=Etichette C'#13+
'R LABELS=Etichette R'#13+
'C PEN=Penna C'#13+
'R PEN=Penna R'#13+
'STACK GROUP=Gruppo Pila'#13+
'USE ORIGIN=Usa Origine'#13+
'MULTIPLE BAR=Barre Multiple'#13+
'SIDE=Lato'#13+
'STACKED 100%=Impilato 100%'#13+
'SIDE ALL=Tutto al Lato'#13+
'BRUSH=Modello'#13+
'DRAWING MODE=Modo di Disegnare'#13+
'SOLID=Solido'#13+
'WIREFRAME=Cornice a filo'#13+
'DOTFRAME=Cornice a Punti'#13+
'SMOOTH PALETTE=Tavolozza Mitigata'#13+
'SIDE BRUSH=Modello Laterale'#13+
'ABOUT TEECHART PRO V6.01=Info TeeChart Pro v6.01'#13+
'ALL RIGHTS RESERVED.=Tutti i Diritti Riservati'#13+
'VISIT OUR WEB SITE !=Visita il nostro sito Web!'#13+
'TEECHART WIZARD=Autocomposizione di TeeChart'#13+
'SELECT A CHART STYLE=Scegli uno Stile di Grafico'#13+
'DATABASE CHART=Grafico con Base di Dati'#13+
'NON DATABASE CHART=Grafico senza Base di Dati'#13+
'SELECT A DATABASE TABLE=Seleziona una Tavola di Base di Dati'#13+
'ALIAS=Alias'#13+
'TABLE=Tavola'#13+
'SOURCE=Fonte'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleziona i campi desiderati per il Grafico'#13+
'SELECT A TEXT LABELS FIELD=Seleziona un Campo testo-etichette'#13+
'CHOOSE THE DESIRED CHART TYPE=Scegli il tipo di grafico desiderato'#13+
'2D=2D'#13+
'CHART PREVIEW=Anteprima Grafico'#13+
'SHOW LEGEND=Visualizza Legenda'#13+
'SHOW MARKS=Visu. Contrassegni'#13+
'< BACK=< Indietro'#13+
'SELECT A CHART STYLE=Scegli uno Stile di Grafico'#13+
'NON DATABASE CHART=Grafico senza Base di Dati'#13+
'SELECT A DATABASE TABLE=Seleziona una Tavola di Base di Dati'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleziona i campi desiderati per il Grafico'#13+
'SELECT A TEXT LABELS FIELD=Seleziona un Campo testo-etichette'#13+
'EXPORT CHART=Esporta Grafico'#13+
'PICTURE=Imagine'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Mantieni le Proporzioni'#13+
'INCLUDE SERIES DATA=Includi i dati delle Serie'#13+
'FILE SIZE=Dimensione del File'#13+
'DELIMITER=Delimitatore'#13+
'XML=XML'#13+
'HTML TABLE=Tabella HTML'#13+
'EXCEL=Excel'#13+
'TAB=Tab'#13+
'COLON=Due punti'#13+
'INCLUDE=Includi'#13+
'POINT LABELS=Etichette dei Punti'#13+
'POINT INDEX=Indice dei Punti'#13+
'HEADER=Intestazione'#13+
'COPY=Copia'#13+
'SAVE=Salva'#13+
'SEND=Invia'#13+
'INCLUDE SERIES DATA=Includi i Dati delle Serie'#13+
'FUNCTIONS=Funzioni'#13+
'ADD=Somma'#13+
'ADX=ADX'#13+
'AVERAGE=Media'#13+
'BOLLINGER=Bollinger'#13+
'COPY=Copia'#13+
'DIVIDE=Dividi'#13+
'EXP. AVERAGE=Media Exp.'#13+
'EXP.MOV.AVRG.=Media Mobile Exp.'#13+
'HIGH=Alto'#13+
'LOW=Basso'#13+
'MACD=MACD'#13+
'MOMENTUM=Momento'#13+
'MOMENTUM DIV=Momento Div'#13+
'MOVING AVRG.=Media Mobile'#13+
'MULTIPLY=Moltiplica'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Radice Media Quadratica'#13+
'STD.DEVIATION=Deviazione Std.'#13+
'STOCHASTIC=Stocastico'#13+
'SUBTRACT=Sottrai'#13+
'APPLY=Applica'#13+
'SOURCE SERIES=Serie Fonte'#13+
'TEECHART GALLERY=Galleria TeeChart'#13+
'FUNCTIONS=Funzioni'#13+
'DITHER=Dither'#13+
'REDUCTION=Riduzione'#13+
'COMPRESSION=Compressione'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Piú vicino'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=Monocromatico'#13+
'GRAY SCALE=Scala di Grigi'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Qualitá'#13+
'GRAY SCALE=Scala di Grigi'#13+
'PERFORMANCE=Prestazioni'#13+
'QUALITY=Qualità'#13+
'SPEED=Velocità'#13+
'COMPRESSION LEVEL=Liv.Compressione'#13+
'CHART TOOLS GALLERY=Galleria di Strumenti Grafici'#13+
'ANNOTATION=Annotazione'#13+
'AXIS ARROWS=Frecce Assi'#13+
'COLOR BAND=Bande di Colore'#13+
'COLOR LINE=Linea di Colore'#13+
'CURSOR=Cursore'#13+
'DRAG MARKS=Trascina Contrassegni'#13+
'DRAW LINE=Disegna Linea'#13+
'IMAGE=Immagine'#13+
'MARK TIPS=Suggerimenti'#13+
'NEAREST POINT=Punto più vicino'#13+
'ROTATE=Ruota'#13+
'CHART TOOLS GALLERY=Galleria di Strumenti Grafici'#13+
'BRUSH=Modello'#13+
'DRAWING MODE=Modo di Disegnare'#13+
'WIREFRAME=Cornice a filo'#13+
'SMOOTH PALETTE=Tavolozza Mitigata'#13+
'SIDE BRUSH=Modello Laterale'#13+
'YES=Si'#13+
'VISIT OUR WEB SITE !=Visiti il nostro Web!'#13+
'SHOW PAGE NUMBER=Mostrare il numero di pagina'#13+
'PAGE NUMBER=Numero di pagina'#13+
'PAGE %D OF %D=Pag. %d di %d'#13+
'TEECHART LANGUAGES=Lingue di TeeChart'#13+
'CHOOSE A LANGUAGE=Scelglire una lingua'+#13+
'SELECT ALL=Selezionare Tutte'#13+
'DRAW ALL=Disegnare tutto'#13+
'TEXT FILE=Archivio di Testo'#13+
'IMAG. SYMBOL=Símbolo Imag.'#13+
'DRAG REPAINT=Ridipingi il trascinato'#13+
'NO LIMIT DRAG=Trascinam. senza limiti'
;
  end;
end;

Procedure TeeSetGreek;
begin
  TeeCreateGreek;
  TeeLanguage:=TeeGreekLanguage;
  TeeGreekConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;


initialization
finalization
  FreeAndNil(TeeGreekLanguage);
end.
