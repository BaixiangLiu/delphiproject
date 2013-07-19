unit TeeMalaysian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeMalaysianLanguage:TStringList=nil;

Procedure TeeSetMalaysian;
Procedure TeeCreateMalaysian;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeMalaysianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2003 oleh David Berneda';
  TeeMsg_LegendFirstValue   :='Nilai Petunjuk Pertama mestilah > 0';
  TeeMsg_LegendColorWidth   :='Lebar Warna Petunjuk mestilah > 0%';
  TeeMsg_SeriesSetDataSource:='Tiada CartaUtama untuk disahkan Sumber Data';
  TeeMsg_SeriesInvDataSource:='Tiada Sumber Data yang sah: %s';
  TeeMsg_FillSample         :='ContohNilaiPenuh NomborNilai mestilah > 0';
  TeeMsg_AxisLogDateTime    :='Paksi TarikhMasa Tidak Boleh Logaritma';
  TeeMsg_AxisLogNotPositive :='Nilai Minima dan Maksima Paksi Logaritma haruslah >= 0';
  TeeMsg_AxisLabelSep       :='Label Pemisahan % mestilah lebih besar dari 0';
  TeeMsg_AxisIncrementNeg   :='Kenaikan Paksi mestilah >= 0';
  TeeMsg_AxisMinMax         :='Nilai Minima Paksi mestilah <= Maksima';
  TeeMsg_AxisMaxMin         :='Nilai Maksima Paksi mestilah >= Minima';
  TeeMsg_AxisLogBase        :='Asas Paksi Logaritma haruslah >= 2';
  TeeMsg_MaxPointsPerPage   :='MakTitikSeMukasurat mestilah >= 0';
  TeeMsg_3dPercent          :='Peratus kesan 3D mestilah di antara %d dan %d';
  TeeMsg_CircularSeries     :='Turutan Bulat Kebergantungan tidak dibenarkan';
  TeeMsg_WarningHiColor     :='Warna 16k atau lebih diperlukan untuk paparan lebih baik';

  TeeMsg_DefaultPercentOf   :='%s dari %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'dari %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tajuk Paksi';
  TeeMsg_AxisLabels         :='Label Paksi';
  TeeMsg_RefreshInterval    :='Selang Segar Semula mestilah di antara 0 dan 60';
  TeeMsg_SeriesParentNoSelf :='Turutan.CartaUtama bukan saya sendiri!';
  TeeMsg_GalleryLine        :='Garis';
  TeeMsg_GalleryPoint       :='Titik';
  TeeMsg_GalleryArea        :='Luas Terunjur';
  TeeMsg_GalleryBar         :='Palang';
  TeeMsg_GalleryHorizBar    :='Palang Mendatar';
  TeeMsg_Stack              :='Tindanan';
  TeeMsg_GalleryPie         :='Pai';
  TeeMsg_GalleryCircled     :='Bulatan';
  TeeMsg_GalleryFastLine    :='Garis Laju';
  TeeMsg_GalleryHorizLine   :='Garis Mendatar';

  TeeMsg_PieSample1         :='Kereta';
  TeeMsg_PieSample2         :='Talipon';
  TeeMsg_PieSample3         :='Jadual';
  TeeMsg_PieSample4         :='Peranti Paparan CRT';
  TeeMsg_PieSample5         :='Lampu';
  TeeMsg_PieSample6         :='Papan Kekunci';
  TeeMsg_PieSample7         :='Motosikal';
  TeeMsg_PieSample8         :='Kerusi';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Penyuntingan %s';

  TeeMsg_GalleryStandard    :='Piawai';  
  TeeMsg_GalleryExtended    :='Diperluas';  
  TeeMsg_GalleryFunctions   :='Fungsi';

  TeeMsg_EditChart          :='&Sunting Carta...';
  TeeMsg_PrintPreview       :='&Cetak Prapandang...'; 
  TeeMsg_ExportChart        :='E&ksport Carta...';
  TeeMsg_CustomAxes         :='Ubahsuai Paksi...';

  TeeMsg_InvalidEditorClass :='%s: Kelas Editor Tidak Sah: %s';
  TeeMsg_MissingEditorClass :='%s: Tiada Dialog Editor';

  TeeMsg_GalleryArrow       :='Anak Panah';

  TeeMsg_ExpFinish          :='Se&lesai';
  TeeMsg_ExpNext            :='Se&terusnya >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Rekaan';
  TeeMsg_GanttSample2       :='Pemprototaipan';
  TeeMsg_GanttSample3       :='Pembangunan';
  TeeMsg_GanttSample4       :='Jualan';
  TeeMsg_GanttSample5       :='Pasaran';
  TeeMsg_GanttSample6       :='Percubaan';
  TeeMsg_GanttSample7       :='Perkilangan';
  TeeMsg_GanttSample8       :='Penyahpepijatan';
  TeeMsg_GanttSample9       :='Versi Baru';
  TeeMsg_GanttSample10      :='Perbankan';

  TeeMsg_ChangeSeriesTitle  :='Tukar Tajuk Siri';
  TeeMsg_NewSeriesTitle     :='Tajuk Siri Baru:';
  TeeMsg_DateTime           :='TarikhMasa';
  TeeMsg_TopAxis            :='Paksi Atas';
  TeeMsg_BottomAxis         :='Paksi Bawah';
  TeeMsg_LeftAxis           :='Paksi Kiri';
  TeeMsg_RightAxis          :='Paksi Kanan';

  TeeMsg_SureToDelete       :='Padam %s ?';
  TeeMsg_DateTimeFormat     :='For&mat TarikhMasa:';
  TeeMsg_Default            :='Nilai Lalai: ';
  TeeMsg_ValuesFormat       :='Fo&rmat Nilai:';  
  TeeMsg_Maximum            :='Maksima';
  TeeMsg_Minimum            :='Minima';
  TeeMsg_DesiredIncrement   :='Memerlukan %s Tambahan';

  TeeMsg_IncorrectMaxMinValue:='Nilai Tidak Betul. Sebab: %s';
  TeeMsg_EnterDateTime      :='Masukkan [Jumlah Hari] [hh:mm:ss]';

  TeeMsg_SureToApply        :='Gunapakai Pertukaran ?';
  TeeMsg_SelectedSeries     :='(Turutan Pilihan)';
  TeeMsg_RefreshData        :='Se&gar Semula Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Tambah';
  TeeMsg_FunctionSubtract   :='Tolak';
  TeeMsg_FunctionMultiply   :='Darab';
  TeeMsg_FunctionDivide     :='Bahagi';
  TeeMsg_FunctionHigh       :='Tinggi';
  TeeMsg_FunctionLow        :='Rendah';
  TeeMsg_FunctionAverage    :='Purata';

  TeeMsg_GalleryShape       :='Bentuk';
  TeeMsg_GalleryBubble      :='Gelembung';
  TeeMsg_FunctionNone       :='Salin';

  TeeMsg_None               :='(tiada)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Saiz Penuding mestilah lebih besar dari kosong';
  TeeMsg_About              :='Me&ngenai TeeChart...';

  tcAdditional              :='Tambahan';
  tcDControls               :='Kawalan Data';
  tcQReport                 :='LaporanQ';

  TeeMsg_DataSet            :='Set Data';
  TeeMsg_AskDataSet         :='Set &Data';

  TeeMsg_SingleRecord       :='Satu Rekod';
  TeeMsg_AskDataSource      :='Sum&ber Data';

  TeeMsg_Summary            :='Ringkasan';

  TeeMsg_FunctionPeriod     :='Tempoh Fungsi seharusnya >= 0';

  TeeMsg_WizardTab          :='Perniagaan';
  TeeMsg_TeeChartWizard     :='TeeChart Bestari';

  TeeMsg_ClearImage         :='Leg&a';
  TeeMsg_BrowseImage        :='Semak Se&imbas...';

  TeeMsg_WizardSureToClose  :='Adakah anda pasti untuk menutup TeeChart bestari ?';
  TeeMsg_FieldNotFound      :='Medan %s tidak wujud';

  TeeMsg_DepthAxis          :='Ukur Dalam Paksi';
  TeeMsg_PieOther           :='Lain';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pai';
  TeeMsg_ValuesBar          :='Palang';
  TeeMsg_ValuesAngle        :='Sudut';
  TeeMsg_ValuesGanttStart   :='Mula';
  TeeMsg_ValuesGanttEnd     :='Akhir';
  TeeMsg_ValuesGanttNextTask:='TugasBerikut';
  TeeMsg_ValuesBubbleRadius :='Ukurlilit';
  TeeMsg_ValuesArrowEndX    :='AkhirX';
  TeeMsg_ValuesArrowEndY    :='AkhirY';
  TeeMsg_Legend             :='Petunjuk';
  TeeMsg_Title              :='Tajuk';
  TeeMsg_Foot               :='Catatan Kaki';
  TeeMsg_Period		    :='Tempoh';
  TeeMsg_PeriodRange        :='Julat Tempoh';
  TeeMsg_CalcPeriod         :='Kira %s setiap:';
  TeeMsg_SmallDotsPen       :='Titik Kecil';

  TeeMsg_InvalidTeeFile     :='Carta Tidak Sah dalam fail *.tee';
  TeeMsg_WrongTeeFileFormat :='Fail *.tee silap format';
  TeeMsg_EmptyTeeFile       :='Fail *.tee kosong';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Paksi Carta';
  TeeMsg_ChartAxesCategoryDesc   := 'Sifat dan Acara Paksi Carta';
  TeeMsg_ChartWallsCategoryName  := 'Dinding Carta';
  TeeMsg_ChartWallsCategoryDesc  := 'Sifat dan Acara Dinding Carta';
  TeeMsg_ChartTitlesCategoryName := 'Tajuk Carta';
  TeeMsg_ChartTitlesCategoryDesc := 'Sifat dan Acara Tajuk Carta';
  TeeMsg_Chart3DCategoryName     := 'Carta 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Sifat dan Acara Chart 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Ubahsuai';
  TeeMsg_Series                 :='Turutan';
  TeeMsg_SeriesList             :='Turutan...';

  TeeMsg_PageOfPages            :='Mukasurat %d dari %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Pertama';
  TeeMsg_Prior  :='Sebelum';
  TeeMsg_Next   :='Seterusnya';
  TeeMsg_Last   :='Akhir';
  TeeMsg_Insert :='Selit';
  TeeMsg_Delete :='Padam';
  TeeMsg_Edit   :='Sunting';
  TeeMsg_Post   :='Hantar';
  TeeMsg_Cancel :='Batal';

  TeeMsg_All    :='(semua)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Teks';

  TeeMsg_AsBMP        :='sebagai &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='sebagai &Metafile';
  TeeMsg_EMFFilter    :='Kenaikan Kualiti Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Sifat Panel tidak diset dalam format Eksport';

  TeeMsg_Normal    :='Biasa';
  TeeMsg_NoBorder  :='Tiada Sempadan';
  TeeMsg_Dotted    :='Garis terputus-putus';
  TeeMsg_Colors    :='Warna';
  TeeMsg_Filled    :='Penuh';
  TeeMsg_Marks     :='Tanda';
  TeeMsg_Stairs    :='Tangga';
  TeeMsg_Points    :='Titik';
  TeeMsg_Height    :='Tinggi';
  TeeMsg_Hollow    :='Lompang';
  TeeMsg_Point2D   :='Titik 2D';
  TeeMsg_Triangle  :='Tigasegi';
  TeeMsg_Star      :='Bintang';
  TeeMsg_Circle    :='Bulatan';
  TeeMsg_DownTri   :='Tigasegi Ke Bawah';
  TeeMsg_Cross     :='Campur';
  TeeMsg_Diamond   :='Berlian';
  TeeMsg_NoLines   :='Tiada Garisan';
  TeeMsg_Stack100  :='Tindanan 100%';
  TeeMsg_Pyramid   :='Piramid';
  TeeMsg_Ellipse   :='Elips';
  TeeMsg_InvPyramid:='Piramid Terbalik';
  TeeMsg_Sides     :='Sudut';
  TeeMsg_SideAll   :='Semua sudut';
  TeeMsg_Patterns  :='Corak';
  TeeMsg_Exploded  :='Terburai';
  TeeMsg_Shadow    :='Bayang';
  TeeMsg_SemiPie   :='Separuh Pai';
  TeeMsg_Rectangle :='Empatsegi';
  TeeMsg_VertLine  :='Garis Menegak';
  TeeMsg_HorizLine :='Garis Mendatar';
  TeeMsg_Line      :='Garis';
  TeeMsg_Cube      :='Empatsegi Sama';
  TeeMsg_DiagCross :='Pangkah';

  TeeMsg_CanNotFindTempPath    :='Tidak jumpa direktori sementara';
  TeeMsg_CanNotCreateTempChart :='Tidak boleh buat fail sementara';
  TeeMsg_CanNotEmailChart      :='Tidak boleh email TeeChart. Kesilapan MAPI: %d';

  TeeMsg_SeriesDelete :='Turutan Padam: Nilai Indeks %d di luar lingkungan (0 to %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='sebagai &JPEG';
  TeeMsg_JPEGFilter    :='Fail JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='sebagai &GIF';
  TeeMsg_GIFFilter     :='Fail GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='sebagai &PNG';
  TeeMsg_PNGFilter     :='Fail PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='sebagai PC&X';
  TeeMsg_PCXFilter     :='Fail PCX (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='sebagai &VML (HTM)';
  TeeMsg_VMLFilter     :='Fail VML (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='Ba&hasa...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Kutub';    
  TeeMsg_GalleryCandle      :='Lilin';
  TeeMsg_GalleryVolume      :='Muatan';
  TeeMsg_GallerySurface     :='Permukaan';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Titik 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='Palang 3D';
  TeeMsg_GalleryBigCandle   :='Lilin Besar';
  TeeMsg_GalleryLinePoint   :='Garis Titik';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Air Terjun';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Jam';
  TeeMsg_GalleryColorGrid   :='WarnaGrid';
  TeeMsg_GalleryBoxPlot     :='KotakPlot';
  TeeMsg_GalleryHorizBoxPlot:='KotakPlot Mendatar';
  TeeMsg_GalleryBarJoin     :='Palang Bercantum';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramid';
  TeeMsg_GalleryMap         :='Peta';

  TeeMsg_PolyDegreeRange     :='Darjah Polinomial mestilah di antara 1 dan 20';
  TeeMsg_AnswerVectorIndex   :='Jawapan Indeks Vektor mestilah di antara 1 dan %d';
  TeeMsg_FittingError        :='Tidak boleh proses kemasan';
  TeeMsg_PeriodRange         :='Tempoh mestilah >= 0';
  TeeMsg_ExpAverageWeight    :='Purata Eksponen Wajaran mestilah di antara 0 dan 1';
  TeeMsg_GalleryErrorBar     :='Ralat Palang';
  TeeMsg_GalleryError        :='Ralat';
  TeeMsg_GalleryHighLow      :='Tinggi-Rendah';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Pembahagian Momentum';
  TeeMsg_FunctionExpAverage  :='Purata Eksponen';
  TeeMsg_FunctionMovingAverage:='Purata Bergerak';
  TeeMsg_FunctionExpMovAve   :='Purata Bergerak Eksponen';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Keluk Kemasan';
  TeeMsg_FunctionTrend       :='Arah Aliran';
  TeeMsg_FunctionExpTrend    :='Arah Aliran Eksponen';
  TeeMsg_FunctionLogTrend    :='Pengelongan Arah Aliran';
  TeeMsg_FunctionCumulative  :='Kumulatif';
  TeeMsg_FunctionStdDeviation:='Sisihan Piawai';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Punca Min Kuasa Dua';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stokastik';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Bilang';
  TeeMsg_LoadChart           :='Buka TeeChart...';
  TeeMsg_SaveChart           :='Simpan TeeChart...';
  TeeMsg_TeeFiles            :='Fail TeeChart Pro';

  TeeMsg_GallerySamples      :='Lain-lain';
  TeeMsg_GalleryStats        :='Statistik';

  TeeMsg_CannotFindEditor    :='Tidak jumpa editor turutan: %s';


  TeeMsg_CannotLoadChartFromURL:='Kod Ralat: %d muat turun Carta dari URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod Ralat: %d muat turun data Turutan dari URL: %s';

  TeeMsg_Test                :='Cubaan...';

  TeeMsg_ValuesDate          :='Tarikh';
  TeeMsg_ValuesOpen          :='Buka';
  TeeMsg_ValuesHigh          :='Tinggi';
  TeeMsg_ValuesLow           :='Rendah';
  TeeMsg_ValuesClose         :='Tutup';
  TeeMsg_ValuesOffset        :='Ofset';
  TeeMsg_ValuesStdError      :='RalatPiawai';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Jumlah Titik Bezier mestilah > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Sunting';
  TeeCommanMsg_Print    :='Cetak';
  TeeCommanMsg_Copy     :='Salin';
  TeeCommanMsg_Save     :='Simpan';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Putaran: %d° Elevasi: %d°';
  TeeCommanMsg_Rotate   :='Putar';

  TeeCommanMsg_Moving   :='Ofset Mendatar: %d Ofset Menegak: %d';
  TeeCommanMsg_Move     :='Gerak';

  TeeCommanMsg_Zooming  :='Zum: %d %%';
  TeeCommanMsg_Zoom     :='Zum';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Ukur Dalam';

  TeeCommanMsg_Chart    :='Carta';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Seret %s untuk putar';
  TeeCommanMsg_MoveLabel  :='Seret %s untuk gerak';
  TeeCommanMsg_ZoomLabel  :='Seret %s untuk zum';
  TeeCommanMsg_DepthLabel :='Seret %s untuk ubah saiz 3D';

  TeeCommanMsg_NormalLabel:='Seret butang kiri untuk Zum, kanan untuk larikan';
  TeeCommanMsg_NormalPieLabel:='Seret Hirisan Pai Untuk Terburaikan';

  TeeCommanMsg_PieExploding :='Hiris: %d Terburai: %d %%';

  TeeMsg_TriSurfaceLess        :='Jumlah titik mestilah >= 4';
  TeeMsg_TriSurfaceAllColinear :='Semua titik data segaris';
  TeeMsg_TriSurfaceSimilar     :='Titik serupa - tidak boleh lakukan';
  TeeMsg_GalleryTriSurface     :='Permukaan Segitiga';

  TeeMsg_AllSeries :='Semua Turutan';
  TeeMsg_Edit      :='Sunting';

  TeeMsg_GalleryFinancial    :='Kewangan';

  TeeMsg_CursorTool    :='Aksara';
  TeeMsg_DragMarksTool :='Seret Tanda';
  TeeMsg_AxisArrowTool :='Anak Panah Paksi';
  TeeMsg_DrawLineTool  :='Lukis Garis';
  TeeMsg_NearestTool   :='Titik Terdekat';
  TeeMsg_ColorBandTool :='Warna Jalur';
  TeeMsg_ColorLineTool :='Warna Garis';
  TeeMsg_RotateTool    :='Putar';
  TeeMsg_ImageTool     :='Imej';
  TeeMsg_MarksTipTool  :='Tip Tanda';
  TeeMsg_AnnotationTool:='Anotasi';

  TeeMsg_CantDeleteAncestor  :='Tidak boleh padam leluhur';

  TeeMsg_Load	          :='Muat...';
  TeeMsg_DefaultDemoTee   :='http://www.steema.com/demo.tee';
  TeeMsg_NoSeriesSelected :='Tiada turutan dipilih';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Carta';
  TeeMsg_CategorySeriesActions :='Carta Turutan';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Tukar 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktif';
  TeeMsg_ActionSeriesActiveHint := 'Tunjuk / Sembunyi Turutan';
  TeeMsg_ActionEditHint         := 'Sunting Carta';
  TeeMsg_ActionEdit             := 'S&unting...';
  TeeMsg_ActionCopyHint         := 'Salin ke papan keratan';
  TeeMsg_ActionCopy             := 'Sa&lin';
  TeeMsg_ActionPrintHint        := 'Cetak Carta Pratonton';
  TeeMsg_ActionPrint            := '&Cetak...';
  TeeMsg_ActionAxesHint         := 'Tunjuk / Sembunyi Paksi';
  TeeMsg_ActionAxes             := 'Pa&ksi';
  TeeMsg_ActionGridsHint        := 'Tunjuk / Sembunyi Grid';
  TeeMsg_ActionGrids            := '&Grid';
  TeeMsg_ActionLegendHint       := 'Tunjuk / Sembunyi Petunjuk';
  TeeMsg_ActionLegend           := '&Petunjuk';
  TeeMsg_ActionSeriesEditHint   := 'Sunting Turutan';
  TeeMsg_ActionSeriesMarksHint  := 'Tunjuk / Sembunyi Tanda Turutan';
  TeeMsg_ActionSeriesMarks      := '&Tanda';
  TeeMsg_ActionSaveHint         := 'Simpan Carta';
  TeeMsg_ActionSave             := '&Simpan...';

  TeeMsg_CandleBar              := 'Palang';
  TeeMsg_CandleNoOpen           := 'Tidak Dibuka';
  TeeMsg_CandleNoClose          := 'Tidak Ditutup';
  TeeMsg_NoLines                := 'Tiada Garisan';
  TeeMsg_NoHigh                 := 'Tiada Tinggi';
  TeeMsg_NoLow                  := 'Tiada Rendah';
  TeeMsg_ColorRange             := 'Julat Warna';
  TeeMsg_WireFrame              := 'Garis Bingkau';
  TeeMsg_DotFrame               := 'Bingkau Titik ';
  TeeMsg_Positions              := 'Posisi';
  TeeMsg_NoGrid                 := 'Tiada Grid';
  TeeMsg_NoPoint                := 'Tiada Titik';
  TeeMsg_NoLine                 := 'Tiada Garis';
  TeeMsg_Labels                 := 'Label';
  TeeMsg_NoCircle               := 'Tiada Bulatan';
  TeeMsg_Lines                  := 'Garisan';
  TeeMsg_Border                 := 'Sempadan';

  TeeMsg_SmithResistance      := 'Rintangan';
  TeeMsg_SmithReactance       := 'Kesan Balas';

  TeeMsg_Column               := 'Lajur';

  { 5.01 }
  TeeMsg_Separator            := 'Pembahagi';
  TeeMsg_FunnelSegment        := 'Tembereng ';
  TeeMsg_FunnelSeries         := 'Corong';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Terlebih Kuota';
  TeeMsg_FunnelWithin         := ' dalam kuota';
  TeeMsg_FunnelBelow          := ' atau lebih dibawah kuota';
  TeeMsg_CalendarSeries       := 'Kalendar';
  TeeMsg_DeltaPointSeries     := 'TitikDelta';
  TeeMsg_ImagePointSeries     := 'TitikImej';
  TeeMsg_ImageBarSeries       := 'PalangImej';
  TeeMsg_SeriesTextFieldZero  := 'TeksTurutan: Medan indeks mestilah lebih besar dari kosong.';

  { 5.02 }
  TeeMsg_Origin               := 'Asal';
  TeeMsg_Transparency         := 'Kelutsinaran';
  TeeMsg_Box		      := 'Kotak';
  TeeMsg_ExtrOut	      := 'KeluarLebih';
  TeeMsg_MildOut	      := 'KeluarSederhana';
  TeeMsg_PageNumber	      := 'Mukasurat';
  TeeMsg_TextFile             := 'Fail Teks';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateMalaysian;
begin
  if not Assigned(TeeMalaysianLanguage) then
  begin
    TeeMalaysianLanguage:=TStringList.Create;
    TeeMalaysianLanguage.Text:=

'LABELS=Textos'+#13+
'DATASET=Tabla'+#13+
'ALL RIGHTS RESERVED.=Todos los Derechos Reservados.'+#13+
'APPLY=Aplicar'+#13+
'CLOSE=Cerrar'+#13+
'OK=Aceptar'+#13+
'ABOUT TEECHART PRO V6.01=Acerca de TeeChart Pro v6.01'+#13+
'OPTIONS=Opciones'+#13+
'FORMAT=Formato'+#13+
'TEXT=Texto'+#13+
'GRADIENT=Gradiente'+#13+
'SHADOW=Sombra'+#13+
'POSITION=Posición'+#13+
'LEFT=Izquierda'+#13+
'TOP=Arriba'+#13+
'CUSTOM=Person.'+#13+
'PEN=Lápiz'+#13+
'PATTERN=Trama'+#13+
'SIZE=Tamaño'+#13+
'BEVEL=Marco'+#13+
'INVERTED=Invertido'+#13+
'INVERTED SCROLL=Desplaz. Invertido'+#13+
'BORDER=Borde'+#13+
'ORIGIN=Origen'+#13+
'USE ORIGIN=Usar Origen'+#13+
'AREA LINES=Líneas Area'+#13+
'AREA=Area'+#13+
'COLOR=Color'+#13+
'SERIES=Series'+#13+
'SUM=Suma'+#13+
'DAY=Dia'+#13+
'QUARTER=Trimestre'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Visible'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Línea Horiz.'+#13+
'LABEL AND PERCENT=Etiqueta y Porcentaje'+#13+
'LABEL AND VALUE=Etiqueta y Valor'+#13+
'LABEL & PERCENT TOTAL=Etiqueta Porc. Total'+#13+
'PERCENT TOTAL=Total Porcentaje'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Restar'+#13+
'MULTIPLY=Multiplicar'+#13+
'DIVIDE=Dividir'+#13+
'STAIRS=Escaleras'+#13+
'MOMENTUM=Momento'+#13+
'AVERAGE=Media'+#13+
'XML=XML'+#13+
'HTML TABLE=Tabla HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Ninguno'+#13+
'(NONE)=Ninguna'#13+
'WIDTH=Ancho'+#13+
'HEIGHT=Alto'+#13+
'COLOR EACH=Colorea Cada'+#13+
'STACK=Apilar'+#13+
'STACKED=Apilado'+#13+
'STACKED 100%=Apilado 100%'+#13+
'AXIS=Eje'+#13+
'LENGTH=Longitud'+#13+
'CANCEL=Cancelar'+#13+
'SCROLL=Desplazamiento'+#13+
'INCREMENT=Incremento'+#13+
'VALUE=Valor'+#13+
'STYLE=Estilo'+#13+
'JOIN=Unión'+#13+
'AXIS INCREMENT=Incremento de Eje'+#13+
'AXIS MAXIMUM AND MINIMUM=Máximo y Mínimo de Eje'+#13+
'% BAR WIDTH=Ancho Barra %'+#13+
'% BAR OFFSET=Desplaz. Barra %'+#13+
'BAR SIDE MARGINS=Márgenes Laterales'+#13+
'AUTO MARK POSITION=Posición Marcas Auto.'+#13+
'DARK BAR 3D SIDES=Lados Barra Oscuros'+#13+
'MONOCHROME=Monocromo'+#13+
'COLORS=Colores'+#13+
'DEFAULT=Defecto'+#13+
'MEDIAN=Mediana'+#13+
'IMAGE=Imagen'+#13+
'DAYS=Dias'+#13+
'WEEKDAYS=Laborables'+#13+
'TODAY=Hoy'+#13+
'SUNDAY=Domingo'+#13+
'MONTHS=Meses'+#13+
'LINES=Líneas'+#13+
'UPPERCASE=Mayúsculas'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=Ancho Candle'+#13+
'BAR=Barra'+#13+
'OPEN CLOSE=Aper. Cierre'+#13+
'DRAW 3D=Dibujar 3D'+#13+
'DARK 3D=Oscuro 3D'+#13+
'SHOW OPEN=Ver Apertura'+#13+
'SHOW CLOSE=Ver Cierre'+#13+
'UP CLOSE=Cierre Arriba'+#13+
'DOWN CLOSE=Cierre Abajo'+#13+
'CIRCLED=Circular'+#13+
'CIRCLE=Círculo'+#13+
'3 DIMENSIONS=3 Dimensiones'+#13+
'ROTATION=Rotación'+#13+
'RADIUS=Radios'+#13+
'HOURS=Horas'+#13+
'HOUR=Hora'+#13+
'MINUTES=Minutos'+#13+
'SECONDS=Segundos'+#13+
'FONT=Fuente'+#13+
'INSIDE=Interior'+#13+
'ROTATED=Rotar'+#13+
'ROMAN=Romanos'+#13+
'TRANSPARENCY=Transparencia'+#13+
'DRAW BEHIND=Dibujar Detrás'+#13+
'RANGE=Rango'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Pasos'+#13+
'GRID=Rejilla'+#13+
'GRID SIZE=Tamaño Rejilla'+#13+
'ALLOW DRAG=Permite arrastrar'+#13+
'AUTOMATIC=Automático'+#13+
'LEVEL=Nivel'+#13+
'LEVELS POSITION=Posición Niveles'+#13+
'SNAP=Ajustar'+#13+
'FOLLOW MOUSE=Seguir Ratón'+#13+
'TRANSPARENT=Transparente'+#13+
'ROUND FRAME=Marco Redondo'+#13+
'FRAME=Marco'+#13+
'START=Inicio'+#13+
'END=Final'+#13+
'MIDDLE=Medio'+#13+
'NO MIDDLE=Sin Medio'+#13+
'DIRECTION=Dirección'+#13+
'DATASOURCE=Origen de Datos'+#13+
'AVAILABLE=Disponibles'+#13+
'SELECTED=Seleccionados'+#13+
'CALC=Calcular'+#13+
'GROUP BY=Agrupar por'+#13+
'OF=de'+#13+
'HOLE %=Agujero %'+#13+
'RESET POSITIONS=Posiciones defecto'+#13+
'MOUSE BUTTON=Botón Ratón'+#13+
'ENABLE DRAWING=Permite Dibujar'+#13+
'ENABLE SELECT=Permite Seleccionar'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Angulo'+#13+
'ZOOM TEXT=Amplia Textos'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=Ampliar'+#13+
'ELEVATION=Elevación'+#13+
'BEHIND=Detrás'+#13+
'AXES=Ejes'+#13+
'SCALES=Escalas'+#13+
'TITLE=Título'+#13+
'TICKS=Marcas'+#13+
'MINOR=Menores'+#13+
'CENTERED=Centrado'+#13+
'CENTER=Centro'+#13+
'PATTERN COLOR EDITOR=Editor de Trama'+#13+
'START VALUE=Valor Inicial'+#13+
'END VALUE=Valor Final'+#13+
'COLOR MODE=Modo de Color'+#13+
'LINE MODE=Modo de Línea'+#13+
'HEIGHT 3D=Alto 3D'+#13+
'OUTLINE=Borde'+#13+
'PRINT PREVIEW=Imprimir'+#13+
'ANIMATED=Animado'+#13+
'ALLOW=Permitir'+#13+
'DASH=Líneas'+#13+
'DOT=Puntos'+#13+
'DASH DOT DOT=Línea Punto Punto'+#13+
'PALE=Suave'+#13+
'STRONG=Fuerte'+#13+
'WIDTH UNITS=Unidades'+#13+
'FOOT=Pie'+#13+
'SUBFOOT=Sub Pie'+#13+
'SUBTITLE=Subtítulo'+#13+
'LEGEND=Leyenda'+#13+
'COLON=Dos puntos'+#13+
'AXIS ORIGIN=Origen Eje'+#13+
'UNITS=Unidades'+#13+
'PYRAMID=Pirámide'+#13+
'DIAMOND=Diamante'+#13+
'CUBE=Cubo'+#13+
'TRIANGLE=Triángulo'+#13+
'STAR=Estrella'+#13+
'SQUARE=Cuadrado'+#13+
'DOWN TRIANGLE=Triángulo Invert.'+#13+
'SMALL DOT=Puntito'+#13+
'LOAD=Cargar'+#13+
'FILE=Archivo'+#13+
'RECTANGLE=Rectángulo'+#13+
'HEADER=Cabecera'+#13+
'CLEAR=Borrar'+#13+
'ONE HOUR=Una Hora'+#13+
'ONE YEAR=Un Año'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=Cono'+#13+
'ARROW=Flecha'+#13+
'CYLLINDER=Cilindro'+#13+
'TIME=Hora'+#13+
'BRUSH=Trama'+#13+
'LINE=Línea'+#13+
'VERTICAL LINE=Línea Vertical'+#13+
'AXIS ARROWS=Flechas en Ejes'+#13+
'MARK TIPS=Sugerencias'+#13+
'DASH DOT=Línea Punto'+#13+
'COLOR BAND=Bandas de Color'+#13+
'COLOR LINE=Linea de Color'+#13+
'INVERT. TRIANGLE=Triángulo Invert.'+#13+
'INVERT. PYRAMID=Pirámide Invert.'+#13+
'INVERTED PYRAMID=Pirámide Invert.'+#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de Origen de Datos de Texto'+#13+
'SOLID=Sólido'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=Puntos'+#13+
'SIDE BRUSH=Trama Lateral'+#13+
'SIDE=Al lado'+#13+
'SIDE ALL=Lateral'+#13+
'ROTATE=Rotar'+#13+
'SMOOTH PALETTE=Paleta suavizada'+#13+
'CHART TOOLS GALLERY=Galería de Herramientas'+#13+
'ADD=Añadir'+#13+
'BORDER EDITOR=Editor de Borde'+#13+
'DRAWING MODE=Modo de Dibujo'+#13+
'CLOSE CIRCLE=Cerrar Círculo'+#13+
'PICTURE=Imagen'+#13+
'NATIVE=Nativo'+#13+
'DATA=Datos'+#13+
'KEEP ASPECT RATIO=Mantener proporción'+#13+
'COPY=Copiar'+#13+
'SAVE=Guardar'+#13+
'SEND=Enviar'+#13+
'INCLUDE SERIES DATA=Incluir Datos de Series'+#13+
'FILE SIZE=Tamaño del Archivo'+#13+
'INCLUDE=Incluir'+#13+
'POINT INDEX=Indice de Puntos'+#13+
'POINT LABELS=Etiquetas de Puntos'+#13+
'DELIMITER=Delimitador'+#13+
'DEPTH=Profund.'+#13+
'COMPRESSION LEVEL=Nivel Compresión'+#13+
'COMPRESSION=Compresión'+#13+
'PATTERNS=Tramas'+#13+
'LABEL=Etiqueta'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=Separar Porción'+#13+
'TOTAL ANGLE=Angulo Total'+#13+
'HORIZ. SIZE=Tamaño Horiz.'+#13+
'VERT. SIZE=Tamaño Vert.'+#13+
'SHAPES=Formas'+#13+
'INFLATE MARGINS=Ampliar Márgenes'+#13+
'QUALITY=Calidad'+#13+
'SPEED=Velocidad'+#13+
'% QUALITY=% Calidad'+#13+
'GRAY SCALE=Escala de Grises'+#13+
'PERFORMANCE=Mejor'+#13+
'BROWSE=Seleccionar'+#13+
'TILED=Mosaico'+#13+
'HIGH=Alto'+#13+
'LOW=Bajo'+#13+
'DATABASE CHART=Gráfico con Base de Datos'+#13+
'NON DATABASE CHART=Gráfico sin Base de Datos'+#13+
'HELP=Ayuda'+#13+
'NEXT >=Siguiente >'+#13+
'< BACK=< Anterior'+#13+
'TEECHART WIZARD=Asistente de TeeChart'+#13+
'PERCENT=Porcentual'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=Ancho Error'+#13+
'ENHANCED=Mejorado'+#13+
'VISIBLE WALLS=Ver Paredes'+#13+
'ACTIVE=Activo'+#13+
'DELETE=Borrar'+#13+
'ALIGNMENT=Alineación'+#13+
'ADJUST FRAME=Ajustar Marco'+#13+
'HORIZONTAL=Horizontal'+#13+
'VERTICAL=Vertical'+#13+
'VERTICAL POSITION=Posición Vertical'+#13+
'NUMBER=Número'+#13+
'LEVELS=Niveles'+#13+
'OVERLAP=Sobreponer'+#13+
'STACK 100%=Apilar 100%'+#13+
'MOVE=Mover'+#13+
'CLICK=Clic'+#13+
'DELAY=Retraso'+#13+
'DRAW LINE=Dibujar Línea'+#13+
'FUNCTIONS=Funciones'+#13+
'SOURCE SERIES=Series Origen'+#13+
'ABOVE=Arriba'+#13+
'BELOW=Abajo'+#13+
'Dif. Limit=Límite Dif.'+#13+
'WITHIN=Dentro'+#13+
'EXTENDED=Extendidas'+#13+
'STANDARD=Estandard'+#13+
'STATS=Estadística'+#13+
'FINANCIAL=Financieras'+#13+
'OTHER=Otras'+#13+
'TEECHART GALLERY=Galería de Gráficos TeeChart'+#13+
'CONNECTING LINES=Líneas de Conexión'+#13+
'REDUCTION=Reducción'+#13+
'LIGHT=Luz'+#13+
'INTENSITY=Intensidad'+#13+
'FONT OUTLINES=Borde Fuentes'+#13+
'SMOOTH SHADING=Sombras suaves'+#13+
'AMBIENT LIGHT=Luz Ambiente'+#13+
'MOUSE ACTION=Acción del Ratón'+#13+
'CLOCKWISE=Segun horario'+#13+
'ANGLE INCREMENT=Angulo Incremento'+#13+
'RADIUS INCREMENT=Incremento Radio'+#13+
'PRINTER=Impresora'+#13+
'SETUP=Opciones'+#13+
'ORIENTATION=Orientación'+#13+
'PORTRAIT=Vertical'+#13+
'LANDSCAPE=Horizontal'+#13+
'MARGINS (%)=Márgenes (%)'+#13+
'MARGINS=Márgenes'+#13+
'DETAIL=Detalle'+#13+
'MORE=Más'+#13+
'PROPORTIONAL=Proporcional'+#13+
'VIEW MARGINS=Ver Márgenes'+#13+
'RESET MARGINS=Márg. Defecto'+#13+
'PRINT=Imprimir'+#13+
'TEEPREVIEW EDITOR=Editor Impresión Preliminar'+#13+
'ALLOW MOVE=Permitir Mover'+#13+
'ALLOW RESIZE=Permitir Redimensionar'+#13+
'SHOW IMAGE=Ver Imagen'+#13+
'DRAG IMAGE=Arrastrar Imagen'+#13+
'AS BITMAP=Como mapa de bits'+#13+
'SIZE %=Tamaño %'+#13+
'FIELDS=Campos'+#13+
'SOURCE=Origen'+#13+
'SEPARATOR=Separador'+#13+
'NUMBER OF HEADER LINES=Líneas de cabecera'+#13+
'COMMA=Coma'+#13+
'EDITING=Editando'+#13+
'TAB=Tabulación'+#13+
'SPACE=Espacio'+#13+
'ROUND RECTANGLE=Rectáng. Redondeado'+#13+
'BOTTOM=Abajo'+#13+
'RIGHT=Derecha'+#13+
'C PEN=Lápiz C'+#13+
'R PEN=Lápiz R'+#13+
'C LABELS=Textos C'+#13+
'R LABELS=Textos R'+#13+
'MULTIPLE BAR=Barras Múltiples'+#13+
'MULTIPLE AREAS=Areas Múltiples'+#13+
'STACK GROUP=Grupo de Apilado'+#13+
'BOTH=Ambos'+#13+
'BACK DIAGONAL=Diagonal Invertida'+#13+
'B.DIAGONAL=Diagonal Invertida'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Cruz'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=Izquierda Derecha'+#13+
'RIGHT LEFT=Derecha Izquierda'+#13+
'FROM CENTER=Desde el centro'+#13+
'FROM TOP LEFT=Desde Izq. Arriba'+#13+
'FROM BOTTOM LEFT=Desde Izq. Abajo'+#13+
'SHOW WEEKDAYS=Ver Laborables'+#13+
'SHOW MONTHS=Ver Meses'+#13+
'SHOW PREVIOUS BUTTON=Ver Botón Anterior'#13+
'SHOW NEXT BUTTON=Ver Botón Siguiente'#13+
'TRAILING DAYS=Ver otros Días'+#13+
'SHOW TODAY=Ver Hoy'+#13+
'TRAILING=Otros Días'+#13+
'LOWERED=Hundido'+#13+
'RAISED=Elevado'+#13+
'HORIZ. OFFSET=Desplaz. Horiz.'+#13+
'VERT. OFFSET=Desplaz. Vert.'+#13+
'INNER=Dentro'+#13+
'LEN=Long.'+#13+
'AT LABELS ONLY=Sólo en etiquetas'+#13+
'MAXIMUM=Máximo'+#13+
'MINIMUM=Mínimo'+#13+
'CHANGE=Cambiar'+#13+
'LOGARITHMIC=Logarítmico'+#13+
'LOG BASE=Base Log.'+#13+
'DESIRED INCREMENT=Incremento'+#13+
'(INCREMENT)=(Incremento)'+#13+
'MULTI-LINE=Multi-Línea'+#13+
'MULTI LINE=Multilínea'+#13+
'RESIZE CHART=Redim. Gráfico'+#13+
'X AND PERCENT=X y Porcentaje'+#13+
'X AND VALUE=X y Valor'+#13+
'RIGHT PERCENT=Porcentaje derecha'+#13+
'LEFT PERCENT=Porcentaje izquierda'+#13+
'LEFT VALUE=Valor izquierda'+#13+
'RIGHT VALUE=Valor derecha'+#13+
'PLAIN=Texto'+#13+
'LAST VALUES=Ultimos Valores'+#13+
'SERIES VALUES=Valores de Series'+#13+
'SERIES NAMES=Nombres de Series'+#13+
'NEW=Nuevo'+#13+
'EDIT=Editar'+#13+
'PANEL COLOR=Color de fondo'+#13+
'TOP BOTTOM=Arriba Abajo'+#13+
'BOTTOM TOP=Abajo Arriba'+#13+
'DEFAULT ALIGNMENT=Alineación defecto'+#13+
'EXPONENTIAL=Exponencial'+#13+
'LABELS FORMAT=Formato Etiquetas'+#13+
'MIN. SEPARATION %=Min. Separación %'+#13+
'YEAR=Año'+#13+
'MONTH=Mes'+#13+
'WEEK=Semana'+#13+
'WEEKDAY=Dia Laborable'+#13+
'MARK=Marcas'+#13+
'ROUND FIRST=Redondear primera'+#13+
'LABEL ON AXIS=Etiqueta en eje'+#13+
'COUNT=Número'+#13+
'POSITION %=Posición %'+#13+
'START %=Empieza %'+#13+
'END %=Termina %'+#13+
'OTHER SIDE=Lado opuesto'+#13+
'INTER-CHAR SPACING=Espacio entre caracteres'+#13+
'VERT. SPACING=Espaciado Vertical'+#13+
'POSITION OFFSET %=Desplazamiento %'+#13+
'GENERAL=General'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=Editor de OpenGL'+#13+
'FONT 3D DEPTH=Profund. Fuentes'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Editor de Fuente'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Reduce'+#13+
'VERTICAL SMALL=Vertical Pequeño'+#13+
'HORIZ. SMALL=Horizontal Pequeño'+#13+
'DIAG. SMALL=Diagonal Pequeño'+#13+
'BACK DIAG. SMALL=Diagonal Invert. Peq.'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=Mínimos pixels'+#13+
'ALLOW SCROLL=Permitir Desplaz.'+#13+
'SWAP=Cambiar'+#13+
'GRADIENT EDITOR=Editor de Gradiente'+#13+
'TEXT STYLE=Estilo de textos'+#13+
'DIVIDING LINES=Líneas de División'+#13+
'SYMBOLS=Símbolos'+#13+
'CHECK BOXES=Casillas'+#13+
'FONT SERIES COLOR=Color de Series'+#13+
'LEGEND STYLE=Estilo de Leyenda'+#13+
'POINTS PER PAGE=Puntos por página'+#13+
'SCALE LAST PAGE=Escalar última página'+#13+
'CURRENT PAGE LEGEND=Leyenda con página actual'+#13+
'BACKGROUND=Fondo'+#13+
'BACK IMAGE=Imagen fondo'+#13+
'STRETCH=Ajustar'+#13+
'TILE=Mosaico'+#13+
'BORDERS=Bordes'+#13+
'CALCULATE EVERY=Calcular cada'+#13+
'NUMBER OF POINTS=Número de puntos'+#13+
'RANGE OF VALUES=Rango de valores'+#13+
'FIRST=Primero'+#13+
'LAST=Ultimo'+#13+
'ALL POINTS=Todos los puntos'+#13+
'DATA SOURCE=Origen de Datos'+#13+
'WALLS=Pared'+#13+
'PAGING=Página'+#13+
'CLONE=Duplicar'+#13+
'TITLES=Título'+#13+
'TOOLS=Herramientas'+#13+
'EXPORT=Exportar'+#13+
'CHART=Gráfico'+#13+
'BACK=Fondo'+#13+
'LEFT AND RIGHT=Izq. y Derecha'+#13+
'SELECT A CHART STYLE=Seleccione tipo de Gráfico'+#13+
'SELECT A DATABASE TABLE=Seleccione una Tabla'+#13+
'TABLE=Tabla'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleccione los campos a graficar'+#13+
'SELECT A TEXT LABELS FIELD=Campo de etiquetas'+#13+
'CHOOSE THE DESIRED CHART TYPE=Seleccione el tipo deseado'+#13+
'CHART PREVIEW=Visión Preliminar'+#13+
'SHOW LEGEND=Ver Leyenda'+#13+
'SHOW MARKS=Ver Marcas'+#13+
'FINISH=Terminar'+#13+
'RANDOM=Aleatorio'+#13+
'DRAW EVERY=Dibujar cada'+#13+
'ARROWS=Flechas'+#13+
'ASCENDING=Ascendiente'+#13+
'DESCENDING=Descendiente'+#13+
'VERTICAL AXIS=Eje Vertical'+#13+
'DATETIME=Fecha/Hora'+#13+
'TOP AND BOTTOM=Superior e Inferior'+#13+
'HORIZONTAL AXIS=Eje Horizontal'+#13+
'PERCENTS=Porcentajes'+#13+
'VALUES=Valores'+#13+
'FORMATS=Formatos'+#13+
'SHOW IN LEGEND=Ver en Leyenda'+#13+
'SORT=Orden'+#13+
'MARKS=Marcas'+#13+
'BEVEL INNER=Marco interior'+#13+
'BEVEL OUTER=Marco exterior'+#13+
'PANEL EDITOR=Editor de Panel'+#13+
'CONTINUOUS=Continuos'+#13+
'HORIZ. ALIGNMENT=Alineación Horiz.'+#13+
'EXPORT CHART=Exportar Gráfico'+#13+
'BELOW %=Inferior a %'+#13+
'BELOW VALUE=Inferior a Valor'+#13+
'NEAREST POINT=Punto cercano'+#13+
'DRAG MARKS=Mover Marcas'+#13+
'TEECHART PRINT PREVIEW=Impresión Preliminar'+#13+
'X VALUE=Valor X'+#13+
'X AND Y VALUES=Valores X Y'+#13+
'SHININESS=Brillo'+#13+
'ALL SERIES VISIBLE=Todas las Series Visible'+#13+
'MARGIN=Margen'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Izquierda Arriba'+#13+
'LEFT BOTTOM=Izquierda Abajo'+#13+
'RIGHT TOP=Derecha Arriba'+#13+
'RIGHT BOTTOM=Derecha Abajo'+#13+
'EXACT DATE TIME=Fecha/Hora Exacta'+#13+
'RECT. GRADIENT=Gradiente'+#13+
'CROSS SMALL=Cruz pequeña'+#13+
'AVG=Media'+#13+
'FUNCTION=Función'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Un milisegundo'+#13+
'ONE SECOND=Un segundo'+#13+
'FIVE SECONDS=Cinco segundos'+#13+
'TEN SECONDS=Diez segundos'+#13+
'FIFTEEN SECONDS=Quince segundos'+#13+
'THIRTY SECONDS=Trenta segundos'+#13+
'ONE MINUTE=Un minuto'+#13+
'FIVE MINUTES=Cinco minutos'+#13+
'TEN MINUTES=Diez minutos'+#13+
'FIFTEEN MINUTES=Quince minutos'+#13+
'THIRTY MINUTES=Trenta minutos'+#13+
'TWO HOURS=Dos horas'+#13+
'TWO HOURS=Dos horas'+#13+
'SIX HOURS=Seis horas'+#13+
'TWELVE HOURS=Doce horas'+#13+
'ONE DAY=Un dia'+#13+
'TWO DAYS=Dos dias'+#13+
'THREE DAYS=Tres dias'+#13+
'ONE WEEK=Una semana'+#13+
'HALF MONTH=Medio mes'+#13+
'ONE MONTH=Un mes'+#13+
'TWO MONTHS=Dos meses'+#13+
'THREE MONTHS=Tres meses'+#13+
'FOUR MONTHS=Cuatro meses'+#13+
'SIX MONTHS=Seis meses'+#13+
'IRREGULAR=Irregular'+#13+
'CLICKABLE=Clicable'+#13+
'ROUND=Redondo'+#13+
'FLAT=Plano'+#13+
'PIE=Pastel'+#13+
'HORIZ. BAR=Barra Horiz.'+#13+
'BUBBLE=Burbuja'+#13+
'SHAPE=Forma'+#13+
'POINT=Puntos'+#13+
'FAST LINE=Línea Rápida'+#13+
'CANDLE=Vela'+#13+
'VOLUME=Volumen'+#13+
'HORIZ LINE=Línea Horiz.'+#13+
'SURFACE=Superfície'+#13+
'LEFT AXIS=Eje Izquierdo'+#13+
'RIGHT AXIS=Eje Derecho'+#13+
'TOP AXIS=Eje Superior'+#13+
'BOTTOM AXIS=Eje Inferior'+#13+
'CHANGE SERIES TITLE=Cambiar Título de Series'+#13+
'DELETE %S ?=Eliminar %s ?'+#13+
'DESIRED %S INCREMENT=Incremento %s deseado'+#13+
'INCORRECT VALUE. REASON: %S=Valor incorrecto. Razón: %s'+#13+
'FillSampleValues NumValues must be > 0=FillSampleValues. Número de valores debe ser > 0.'#13+
'VISIT OUR WEB SITE !=Visite nuestra Web !'#13+
'SHOW PAGE NUMBER=Ver Número de Página'#13+
'PAGE NUMBER=Número de Página'#13+
'PAGE %D OF %D=Pág. %d de %d'#13+
'TEECHART LANGUAGES=Lenguajes de TeeChart'#13+
'CHOOSE A LANGUAGE=Escoja un idioma'+#13+
'SELECT ALL=Seleccionar Todas'#13+
'MOVE UP=Mover Arriba'#13+
'MOVE DOWN=Mover Abajo'#13+
'DRAW ALL=Dibujar todo'#13+
'TEXT FILE=Archivo de Texto'#13+
'IMAG. SYMBOL=Símbolo Imag.'#13+
'DRAG REPAINT=Repinta todo'#13+
'NO LIMIT DRAG=Sin límites arrastre'
;
  end;
end;

Procedure TeeSetMalaysian;
begin
  TeeCreateMalaysian;
  TeeLanguage:=TeeMalaysianLanguage;
  TeeMalaysianConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeMalaysianLanguage);
end.


