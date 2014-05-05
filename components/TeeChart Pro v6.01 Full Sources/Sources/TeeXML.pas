{******************************************}
{   TeeChart XML DataSource                }
{ Copyright (c) 2001-2003 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeXML;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  {$ENDIF}
  TeEngine, TeeURL, Chart, Series, TeeSourceEdit, TeCanvas;

type
  TTeeXMLSource=class(TTeeSeriesSourceFile)
  private
    FChart       : TCustomChart;
    FSeriesNode  : String;
    FValueSource : String;
    FXML         : TStrings;
    FXMLDocument : OleVariant;

    Function CreateAndLoadXML:OleVariant;
    procedure CloseXML;
    Procedure FillSeries(AItems:TStrings);
    procedure LoadSeriesNode(ANode:OleVariant);
    procedure SetSeriesNode(const Value: String);
    procedure SetValueSource(const Value: String);
    procedure XMLError(Const Reason:String);
    procedure SetChart(const Value: TCustomChart);
    procedure SetXML(const Value: TStrings);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure SetActive(const Value: Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Close; override;
    class Function Description:String; override;
    class Function Editor:TComponentClass; override;
    Procedure Load; override;

    property XMLDocument:OleVariant read FXMLDocument;
  published
    property Active;
    property Chart:TCustomChart read FChart write SetChart;
    property FileName;
    property Series;
    property SeriesNode:String read FSeriesNode write SetSeriesNode;
    property ValueSource:String read FValueSource write SetValueSource;
    property XML:TStrings read FXML write SetXML;
  end;

  TXMLSourceEditor = class(TBaseSourceEditor)
    Label1: TLabel;
    EFile: TEdit;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    CBSeries: TComboFlat;
    Label3: TLabel;
    ESource: TEdit;
    CBActive: TCheckBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure EFileChange(Sender: TObject);
    procedure CBSeriesDropDown(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ESourceChange(Sender: TObject);
    procedure CBActiveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    DataSource : TTeeXMLSource;
    Procedure FillXMLSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFNDEF LINUX}
     ComObj,
     {$ENDIF}
     {$IFDEF D6}
     Variants,
     {$ENDIF}
     TeeProcs, TeeProCo;

{$IFNDEF D6}
function VarIsClear(const V: Variant): Boolean;
begin
  with TVarData(V) do
       result := (VType = varEmpty) or
                 (((VType = varDispatch) or (VType = varUnknown)) and
                  (VDispatch = nil))
end;
{$ENDIF}

{ TTeeXMLSource }

procedure TTeeXMLSource.CloseXML;
begin
  if not VarIsEmpty(FXMLDocument) then
     FXMLDocument:=UnAssigned;
end;

procedure TTeeXMLSource.Close;
begin
  CloseXML;
  inherited;
end;

class function TTeeXMLSource.Description: String;
begin
  result:=TeeMsg_XMLFile;
end;

class function TTeeXMLSource.Editor: TComponentClass;
begin
  result:=TXMLSourceEditor;
end;

procedure TTeeXMLSource.XMLError(Const Reason:String);
Const TeeMsg_WrongXMLFormat='TeeChart XML: %s';
begin
  raise ChartException.CreateFmt(TeeMsg_WrongXMLFormat,[Reason]);
end;

procedure TTeeXMLSource.LoadSeriesNode(ANode:OleVariant);

  Function HexToColor(S:String):TColor;
  begin
    S:=Trim(S);
    if Copy(s,1,1)='#' then
    begin
      result:=RGB(StrToInt('$'+Copy(s,2,2)),
                  StrToInt('$'+Copy(s,4,2)),
                  StrToInt('$'+Copy(s,6,2)));
    end
    else result:=clTeeColor;
  end;

var tmpPoints : OleVariant;
    tmpPoint  : OleVariant;
    t         : Integer;
    tt        : Integer;
    tmpValue  : OleVariant;
    tmpValueX : OleVariant;
    tmpText   : OleVariant;
    tmpItem   : OleVariant;
    tmpColor  : OleVariant;
    tmpName   : String;
    tmpX      : String;
    tmpTex    : String;
    tmpList   : String;
    tmpCol    : TColor;
    tmpSeries : TChartSeries;
    tmpClass  : TChartSeriesClass;
begin
  tmpSeries:=Series;

  if Assigned(tmpSeries) then tmpSeries.Clear
  else
  begin
    // Create a new Series...

    tmpClass:=nil;
    tmpItem:=ANode.Attributes.GetNamedItem('type');

    if not VarIsClear(tmpItem) then
    begin
      tmpName:=UpperCase(tmpItem.NodeValue);

      With TeeSeriesTypes do
      for t:=0 to Count-1 do
         if (Items[t].FunctionClass=nil) and
            (UpperCase(Items[t].Description^)=UpperCase(tmpName)) then
         begin
           tmpClass:=Items[t].SeriesClass;
           break;
         end;
    end;

    if not Assigned(tmpClass) then tmpClass:=TBarSeries;

    tmpSeries:=Chart.AddSeries(tmpClass.Create(Self.Owner));

    // Series Title
    tmpItem:=ANode.Attributes.GetNamedItem('title');
    if not VarIsClear(tmpItem) then
       tmpSeries.Title:=tmpItem.NodeValue;

    // Series Color
    tmpColor:=ANode.Attributes.GetNamedItem('color');
    if not VarIsClear(tmpColor) then
       tmpSeries.Color:=HexToColor(tmpColor.NodeValue);
  end;

  tmpPoints:=ANode.getElementsByTagName('points');
  if not VarIsClear(tmpPoints) then
  begin
    tmpPoint:=tmpPoints.Item[0].getElementsByTagName('point');

    if VarIsClear(tmpPoint) then XMLError('No <point> nodes.')
    else
    begin
      tmpName:=tmpSeries.MandatoryValueList.ValueSource;
      if tmpName='' then tmpName:=Self.ValueSource;
      if tmpName='' then tmpName:=tmpSeries.MandatoryValueList.Name;

      tmpX:=tmpSeries.NotMandatoryValueList.ValueSource;
      if tmpX='' then tmpX:=tmpSeries.NotMandatoryValueList.Name;

      for t:=0 to tmpPoint.Length-1 do
      begin
        tmpItem:=tmpPoint.Item[t].Attributes;
        if VarIsClear(tmpItem) then
        begin
          XMLError('<point> node has no data.');
          break;
        end
        else
        begin
          tmpText:=tmpItem.GetNamedItem('text');
          if VarIsClear(tmpText) then tmpTex:=''
                                 else tmpTex:=tmpText.NodeValue;

          tmpColor:=tmpItem.GetNamedItem('color');
          if VarIsClear(tmpColor) then tmpCol:=clTeeColor
                                  else tmpCol:=HexToColor(tmpColor.NodeValue);

          // Rest of values (if exist)
          for tt:=2 to tmpSeries.ValuesList.Count-1 do
          begin
            tmpList:=tmpSeries.ValuesList[tt].ValueSource;
            if tmpList='' then tmpList:=tmpSeries.ValuesList[tt].Name;
            tmpValue:=tmpItem.GetNamedItem(tmpList);
            if not VarIsClear(tmpValue) then
               tmpSeries.ValuesList[tt].TempValue:=tmpValue.NodeValue;
          end;

          // Get X and Y values
          tmpValue:=tmpItem.GetNamedItem(tmpName);
          tmpValueX:=tmpItem.GetNamedItem(tmpX);

          // Add point !

          if VarIsClear(tmpValue) then
             if VarIsClear(tmpValueX) then
                tmpSeries.AddNull(tmpTex)
             else
                tmpSeries.AddNullXY(tmpValueX.NodeValue,0,tmpTex)
          else
          if VarIsClear(tmpValueX) then
             tmpSeries.Add(tmpValue.NodeValue,tmpTex,tmpCol)
          else
             tmpSeries.AddXY(tmpValueX.NodeValue,tmpValue.NodeValue,tmpTex,tmpCol)
        end;
      end;
    end;
  end
  else XMLError('No <points> node.');
end;

Function TTeeXMLSource.CreateAndLoadXML:OleVariant;
begin
  {$IFDEF LINUX}
  result:=0;
  {$ELSE}
  result:=CreateOleObject('MSXML.DomDocument');
  result.Async:=False;
  if FXML.Count>0 then result.LoadXML(FXML.Text)
                  else result.Load(FileName);
  {$ENDIF}
end;

procedure TTeeXMLSource.Load;
var tmpSeries : OleVariant;
    t         : Integer;
    tmp       : String;
    tmpTitle  : OleVariant;
    tmpFound  : Boolean;
begin
  if not (csDesigning in ComponentState) then
  if Assigned(Series) or Assigned(Chart) then
  begin
    CloseXML;
    FXMLDocument:=CreateAndLoadXML;
    tmpSeries:=FXMLDocument.getElementsByTagName('series');

    if VarIsClear(tmpSeries) then XMLError('No <series> nodes.')
    else
    begin
      if not Assigned(Series) then Chart.FreeAllSeries;

      if SeriesNode='' then
      begin
        if tmpSeries.Length>0 then
        for t:=0 to tmpSeries.Length-1 do
        begin
          LoadSeriesNode(tmpSeries.Item[t]);
          if Assigned(Series) then break;
        end
        else
           XMLError('Empty <series> node.');
      end
      else
      begin
        tmpFound:=False;
        for t:=0 to tmpSeries.Length-1 do
        begin
          tmpTitle:=tmpSeries.Item[t].Attributes.GetNamedItem('title');
          if not VarIsClear(tmp) then
          begin
            tmp:=tmpTitle.NodeValue;
            if UpperCase(tmp)=UpperCase(SeriesNode) then
            begin
              LoadSeriesNode(tmpSeries.Item[t]);
              tmpFound:=True;
              break;
            end;
          end;
        end;

        if not tmpFound then XMLError('Series '+SeriesNode+' not found');
      end;
    end;
  end;
end;

Procedure TTeeXMLSource.FillSeries(AItems:TStrings);
var t         : Integer;
    tmpSeries : OleVariant;
    tmpXML    : OleVariant;
    tmpNode   : OleVariant;
begin
  tmpXML:=CreateAndLoadXML;
  try
    AItems.Clear;
    tmpSeries:=tmpXML.getElementsByTagName('series');
    if not VarIsClear(tmpSeries) then
       for t:=0 to tmpSeries.Length-1 do
       begin
         tmpNode:=tmpSeries.Item[t].Attributes.GetNamedItem('title');
         if not VarIsClear(tmpNode) then
            AItems.Add(tmpNode.NodeValue);
       end;
  finally
    tmpXML:=UnAssigned;
  end;
end;

procedure TTeeXMLSource.SetSeriesNode(const Value: String);
begin
  if FSeriesNode<>Value then
  begin
    Close;
    FSeriesNode:=Value;
  end;
end;

procedure TTeeXMLSource.SetValueSource(const Value: String);
begin
  if FValueSource<>Value then
  begin
    Close;
    FValueSource:=Value;
  end;
end;

procedure TTeeXMLSource.SetChart(const Value: TCustomChart);
begin
  if FChart<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FChart) then FChart.RemoveFreeNotification(Self);
    {$ENDIF}
    FChart:=Value;
    if Assigned(FChart) then FChart.FreeNotification(Self);
  end;
end;

procedure TTeeXMLSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FChart) and (AComponent=FChart) then
     Chart:=nil;
end;

constructor TTeeXMLSource.Create(AOwner: TComponent);
begin
  inherited;
  FXML:=TStringList.Create;
end;

destructor TTeeXMLSource.Destroy;
begin
  FXML.Free;
  inherited;
end;

procedure TTeeXMLSource.SetXML(const Value: TStrings);
begin
  FXML.Assign(Value);
end;

procedure TTeeXMLSource.SetActive(const Value: Boolean);
begin
  if Value<>Active then
  begin
    inherited;
    if Active and (not Assigned(Series)) and (FileName<>'') then
       if not (csLoading in ComponentState) then Load;
  end;
end;

{ TXMLSourceEditor }
procedure TXMLSourceEditor.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
     EFile.Text:=OpenDialog1.FileName;
end;

procedure TXMLSourceEditor.EFileChange(Sender: TObject);
begin
  CBSeries.Clear;
  BApply.Enabled:=True;
end;

procedure TXMLSourceEditor.CBSeriesDropDown(Sender: TObject);
begin
  if CBSeries.Items.Count=0 then
     FillXMLSeries;
end;

Procedure TXMLSourceEditor.FillXMLSeries;
begin
  Screen.Cursor:=crHourGlass;
  try
    if EFile.Text<>'' then
    with TTeeXMLSource.Create(nil) do
    try
      FileName:=EFile.Text;
      FillSeries(CBSeries.Items);
    finally
      Free;
    end
    else DataSource.FillSeries(CBSeries.Items);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TXMLSourceEditor.CBSeriesChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TXMLSourceEditor.BApplyClick(Sender: TObject);
begin
  inherited;

  CheckReplaceSource(DataSource);

  DataSource.FileName:=EFile.Text;

  with CBSeries do
  if ItemIndex=-1 then DataSource.SeriesNode:=''
                  else DataSource.SeriesNode:=Items[ItemIndex];

  DataSource.ValueSource:=ESource.Text;

  BApply.Enabled:=False;

  DataSource.Close;
  DataSource.Open; // 6.0
end;

procedure TXMLSourceEditor.FormShow(Sender: TObject);
begin
  inherited;

  LLabel.Visible:=False;
  CBSources.Visible:=False;

  if not Assigned(TheSeries) then exit;

  if TheSeries.DataSource is TTeeXMLSource then
     DataSource:=TTeeXMLSource(TheSeries.DataSource)
  else
  begin
    DataSource:=TTeeXMLSource.Create(TheSeries.Owner);
    DataSource.Name:=TeeGetUniqueName(DataSource.Owner,'TeeXMLSource');
  end;

  with DataSource do
  begin
    EFile.Text:=FileName;
    FillXMLSeries;

    if SeriesNode<>'' then
       with CBSeries do ItemIndex:=Items.IndexOf(SeriesNode);

    ESource.Text:=ValueSource;
    CBActive.Checked:=Active;
  end;

  BApply.Enabled:=Assigned(TheSeries) and (DataSource<>TheSeries.DataSource);
end;

procedure TXMLSourceEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(DataSource) and
     (not Assigned(DataSource.Series)) then DataSource.Free;
  inherited;
end;

procedure TXMLSourceEditor.ESourceChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TXMLSourceEditor.CBActiveClick(Sender: TObject);
begin
  DataSource.Active:=CBActive.Checked;
end;

procedure TXMLSourceEditor.FormCreate(Sender: TObject);
begin
  inherited;
  OpenDialog1.Filter:=TeeMsg_XMLFile+'|*.xml';
end;

initialization
  RegisterClass(TTeeXMLSource);
  TeeSources.Add(TTeeXMLSource);
finalization
  TeeSources.Remove(TTeeXMLSource);
end.
