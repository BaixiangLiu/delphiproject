{********************************************}
{ TeeChart Pro - Map Series Editor           }
{ Copyright (c) 1995-2003 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit TeeMapSeriesEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QGrids, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Grids, Buttons,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeMapSeries, TeePenDlg, TeeChartGrid, TeeLisB,
     TeeNavigator;

type
  TMapSeriesEditor = class(TForm)
    PageControl2: TPageControl;
    TabGlobal: TTabSheet;
    BMapBrush: TButton;
    TabShapes: TTabSheet;
    PageControl1: TPageControl;
    TabFormat: TTabSheet;
    Label2: TLabel;
    CBGlobalPen: TCheckBox;
    BBrush: TButton;
    CBGlobalBrush: TCheckBox;
    BGradient: TButton;
    EText: TEdit;
    TabData: TTabSheet;
    Splitter1: TSplitter;
    Label1: TLabel;
    EditZ: TEdit;
    ButtonPen1: TButtonPen;
    ButtonPen2: TButtonPen;
    Panel1: TPanel;
    ButtonColor1: TButtonColor;
    ChartGrid1: TChartGrid;
    ChartGridNavigator1: TChartGridNavigator;
    ChartListBox1: TChartListBox;
    Panel2: TPanel;
    SBDelete: TSpeedButton;
    SBAdd: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure BMapBrushClick(Sender: TObject);
    procedure ETextChange(Sender: TObject);
    procedure ChartListBox1Click(Sender: TObject);
    procedure CBGlobalPenClick(Sender: TObject);
    procedure CBGlobalBrushClick(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure EditZChange(Sender: TObject);
    procedure ButtonPen2Click(Sender: TObject);
    procedure ButtonColor1Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure SBAddClick(Sender: TObject);
    procedure ChartGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
  private
    { Private declarations }
    Map : TMapSeries;
    ChangingText : Boolean;
    procedure EnableTabs;
    Procedure FillShapes;
    Function SelectedShape:TTeePolygon;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeEdiGrad, TeeGriEd;

procedure TMapSeriesEditor.FormShow(Sender: TObject);
begin
  ChangingText:=False;
  Align:=alClient;
  Map:=TMapSeries(Tag);
  if Assigned(Map) then
  begin
    ButtonPen1.LinkPen(Map.Pen);
    TeeInsertGrid3DForm(Parent,Map);
  end;
  PageControl2.ActivePage:=TabGlobal;
  ChartGrid1.ShowFields:=False;
  EnableTabs;
  if Assigned(Map) and (Map.Shapes.Count>0) then
  begin
    ChartListBox1.ItemIndex:=0;
    ChartListBox1Click(Self);
  end;
end;

procedure TMapSeriesEditor.EnableTabs;
var t   : Integer;
    tmp : Boolean;
begin
  tmp:=Assigned(Map) and (Map.Shapes.Count>0); { 5.02 }
  with TabFormat do
  for t:=0 to ControlCount-1 do Controls[t].Enabled:=tmp;
  with TabData do
  for t:=0 to ControlCount-1 do Controls[t].Enabled:=tmp;
end;

procedure TMapSeriesEditor.BMapBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Map.Brush);
end;

procedure TMapSeriesEditor.ETextChange(Sender: TObject);
begin
  if not ChangingText then
  With SelectedShape do
  if Text<>EText.Text then
  begin
    Text:=EText.Text;
    With ChartListBox1 do Items[ItemIndex]:=Text;
  end;
end;

procedure TMapSeriesEditor.ChartListBox1Click(Sender: TObject);
begin
  EnableTabs;

  if SelectedShape<>nil then
  begin
    With SelectedShape do
    begin
      ButtonPen2.LinkPen(Pen);
      ButtonColor1.LinkProperty(SelectedShape,'Color');
      ButtonColor1.Repaint;
      CBGlobalPen.Checked:=ParentPen;
      CBGlobalBrush.Checked:=ParentBrush;
      ChangingText:=True;
      EText.Text:=Text;
      EditZ.Text:=FloatToStr(Z);
      ChangingText:=False;
      ChartGrid1.Series:=Points;
    end;
    SBDelete.Enabled:=True;
  end
  else
  begin
    ButtonPen2.LinkPen(nil);
    ButtonColor1.LinkProperty(nil,'');
    ChangingText:=True;
    EText.Text:='';
    EditZ.Text:='0';
    ChangingText:=False;
  end;
end;

procedure TMapSeriesEditor.CBGlobalPenClick(Sender: TObject);
begin
  SelectedShape.ParentPen:=CBGlobalPen.Checked;
end;

procedure TMapSeriesEditor.CBGlobalBrushClick(Sender: TObject);
begin
  SelectedShape.ParentBrush:=CBGlobalBrush.Checked;
end;

procedure TMapSeriesEditor.BGradientClick(Sender: TObject);
begin
  if EditTeeGradient(Self,SelectedShape.Gradient) then
     ChartListBox1.Repaint;
end;

procedure TMapSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,SelectedShape.Brush);
  CBGlobalBrush.Checked:=False;
  Map.Repaint;
end;

function TMapSeriesEditor.SelectedShape: TTeePolygon;
begin
  if ChartListBox1.ItemIndex>=0 then
     result:=Map.Shapes[ChartListBox1.ItemIndex]
  else
     result:=nil;
end;

procedure TMapSeriesEditor.EditZChange(Sender: TObject);
var tmp : Double;
begin
  if not ChangingText then
  begin
    tmp:=StrToFloat(EditZ.Text);
    if SelectedShape.Z<>tmp then
    begin
      SelectedShape.Z:=tmp;
      Map.Repaint;
    end;
  end;
end;

procedure TMapSeriesEditor.ButtonPen2Click(Sender: TObject);
begin
  CBGlobalPen.Checked:=False;
  Map.Repaint;
end;

procedure TMapSeriesEditor.ButtonColor1Click(Sender: TObject);
begin
  ChartListBox1.Repaint;
end;

procedure TMapSeriesEditor.PageControl2Change(Sender: TObject);
begin
  if ChartListBox1.Items.Count<>Map.Shapes.Count then FillShapes;
end;

Procedure TMapSeriesEditor.FillShapes;
var t : Integer;
begin
  With ChartListBox1 do
  begin
    ClearItems;
    for t:=0 to Map.Shapes.Count-1 do
        Items.AddObject(Map.Labels[t],Map.Shapes[t].Points);
  end;
end;

procedure TMapSeriesEditor.SBDeleteClick(Sender: TObject);
var tmpLast : Boolean;
    tmp     : Integer;
begin
  tmp:=ChartListBox1.ItemIndex;
  tmpLast:=ChartListBox1.ItemIndex=ChartListBox1.Items.Count-1;
  Map.Delete(ChartListBox1.ItemIndex);
  SBDelete.Enabled:=Map.Shapes.Count>0;

  FillShapes;

  if Map.Shapes.Count>0 then
  begin
    if tmpLast then tmp:=ChartListBox1.Items.Count-1;
  end
  else tmp:=-1;

  with ChartListBox1 do
  begin
    ItemIndex:=tmp;
    if tmp>=0 then
       Selected[tmp]:=True;
  end;
  ChartListBox1Click(Self);
  EnableTabs;
end;

procedure TMapSeriesEditor.SBAddClick(Sender: TObject);
begin
  with Map.Shapes.Add do { 5.02 }
       Text:=IntToStr(Map.Count);
  FillShapes;
  with ChartListBox1 do
  begin
    ItemIndex:=Items.Count-1;
    Selected[ItemIndex]:=True;
    SetFocus;
  end;
  ChartListBox1Click(Self);
  EnableTabs;
end;

procedure TMapSeriesEditor.ChartGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  Map.Repaint;
end;

initialization
  RegisterClass(TMapSeriesEditor);
end.
