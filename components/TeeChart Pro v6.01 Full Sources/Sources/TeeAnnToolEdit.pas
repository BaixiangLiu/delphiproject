{**********************************************}
{   TeeChart Annotation Tool Editor            }
{   Copyright (c) 2000-2003 by David Berneda   }
{**********************************************}
unit TeeAnnToolEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
     {$ENDIF}
     TeeProcs, TeeTools, TeCanvas, TeeCustomShapeEditor, TeePenDlg;

type
  TAnnotationToolEdit = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    MemoText: TMemo;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    CBPos: TComboFlat;
    CBCustPos: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    ECustTop: TEdit;
    UDTop: TUpDown;
    Label3: TLabel;
    CBTextAlign: TComboFlat;
    TabSheet3: TTabSheet;
    BCalloutPen: TButtonPen;
    BCalloutPointer: TButton;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    EX: TEdit;
    Label7: TLabel;
    EY: TEdit;
    Label8: TLabel;
    EZ: TEdit;
    CBCursor: TComboFlat;
    Label9: TLabel;
    Label10: TLabel;
    EArrowDist: TEdit;
    UDArrowDist: TUpDown;
    Label11: TLabel;
    CBHead: TComboFlat;
    Label12: TLabel;
    Edit1: TEdit;
    UDHeadSize: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure EFormatChange(Sender: TObject);
    procedure CBPosChange(Sender: TObject);
    procedure ECustLeftChange(Sender: TObject);
    procedure CBCustPosClick(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBTextAlignChange(Sender: TObject);
    procedure BCalloutPointerClick(Sender: TObject);
    procedure EXChange(Sender: TObject);
    procedure EYChange(Sender: TObject);
    procedure EZChange(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure EArrowDistChange(Sender: TObject);
    procedure CBHeadChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    ShapeForm    : TFormTeeShape;
    Tool         : TAnnotationTool;
    Function CanChangePos:Boolean;
    Procedure EnableCustomPosition;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeEngine, TeePoEdi;

procedure TAnnotationToolEdit.FormShow(Sender: TObject);
begin
  Tool:=TAnnotationTool(Tag);
  if Assigned(Tool) then
  begin
    ShapeForm.RefreshControls(Tool.Shape);

    With Tool do
    begin
      MemoText.Lines.Text:=Text;
      CBPos.ItemIndex:=Ord(Position);
      CBTextAlign.ItemIndex:=Ord(TextAlignment);

      With Shape do
      begin
        CBCustPos.Checked      :=CustomPosition;
        UDLeft.Position        :=Left;
        ECustLeft.Text         :=IntToStr(Left);
        UDTop.Position         :=Top;
        ECustTop.Text          :=IntToStr(Top);
      end;

      with Callout do
      begin
        BCalloutPen.LinkPen(Arrow);
        EX.Text:=IntToStr(XPosition);
        EY.Text:=IntToStr(YPosition);
        EZ.Text:=IntToStr(ZPosition);
        UDArrowDist.Position:=Distance;
        CBHead.ItemIndex:=Ord(ArrowHead);
        UDHeadSize.Position:=ArrowHeadSize;
      end;

      TeeFillCursors(CBCursor,Cursor);
    end;

    EnableCustomPosition;
  end;

  TeeTranslateControl(Self);
  CreatingForm:=False;
end;

procedure TAnnotationToolEdit.EFormatChange(Sender: TObject);

  Function RemoveLineFeeds(Const S:String):String;
  var i : Integer;
  begin
    result:=S;
    Repeat
      i:=Pos(#10,result);
      if i>0 then Delete(result,i,1);
    Until i=0;
  end;

begin
  if not CreatingForm then
     Tool.Text:=ReplaceChar(MemoText.Lines.Text,#10);
end;

procedure TAnnotationToolEdit.CBPosChange(Sender: TObject);
begin
  Tool.Position:=TAnnotationPosition(CBPos.ItemIndex);
  Tool.Shape.CustomPosition:=False;
  EnableCustomPosition;
end;

procedure TAnnotationToolEdit.ECustLeftChange(Sender: TObject);
begin
  if CanChangePos then Tool.Shape.Left:=UDLeft.Position
end;

procedure TAnnotationToolEdit.CBCustPosClick(Sender: TObject);
begin
  Tool.Shape.CustomPosition:=CBCustPos.Checked;
  EnableCustomPosition;
end;

procedure TAnnotationToolEdit.ECustTopChange(Sender: TObject);
begin
  if CanChangePos then Tool.Shape.Top:=UDTop.Position
end;

Function TAnnotationToolEdit.CanChangePos:Boolean;
begin
  result:=(not CreatingForm) and (Tool.Shape.CustomPosition);
end;

procedure TAnnotationToolEdit.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  Align:=alClient; { 5.02 }
  ShapeForm:=InsertTeeObjectForm(PageControl1,nil);
  PageControl1.ActivePage:=TabSheet1;
end;

Procedure TAnnotationToolEdit.EnableCustomPosition;
var tmp : Boolean;
    Old : Boolean;
begin
  Old:=CreatingForm;
  CreatingForm:=True;

  tmp:=Tool.Shape.CustomPosition;

  ECustLeft.Enabled :=tmp;
  ECustTop.Enabled  :=tmp;
  UDLeft.Enabled    :=tmp;
  UDTop.Enabled     :=tmp;
  CBCustPos.Checked :=tmp;

  if tmp then
  begin
    UDLeft.Position :=Tool.Shape.Left;
    UDTop.Position  :=Tool.Shape.Top;
  end;

  CreatingForm:=Old;
end;

procedure TAnnotationToolEdit.CBTextAlignChange(Sender: TObject);
begin
  case CBTextAlign.ItemIndex of
    0: Tool.TextAlignment:=taLeftJustify;
    1: Tool.TextAlignment:=taCenter;
  else
    Tool.TextAlignment:=taRightJustify;
  end;
end;

procedure TAnnotationToolEdit.BCalloutPointerClick(Sender: TObject);
begin
  EditSeriesPointer(Self,Tool.Callout);
end;

procedure TAnnotationToolEdit.EXChange(Sender: TObject);
begin
  if Showing then
     with Tool.Callout do
          XPosition:=StrToIntDef(EX.Text,XPosition);
end;

procedure TAnnotationToolEdit.EYChange(Sender: TObject);
begin
  if Showing then
     with Tool.Callout do
          YPosition:=StrToIntDef(EY.Text,YPosition);
end;

procedure TAnnotationToolEdit.EZChange(Sender: TObject);
begin
  if Showing then
     with Tool.Callout do
          ZPosition:=StrToIntDef(EZ.Text,ZPosition);
end;

procedure TAnnotationToolEdit.CBCursorChange(Sender: TObject);
begin
  with Tool do
       Cursor:=TeeSetCursor(Cursor,CBCursor.Items[CBCursor.ItemIndex]);
end;

procedure TAnnotationToolEdit.EArrowDistChange(Sender: TObject);
begin
  if Showing then
     Tool.Callout.Distance:=UDArrowDist.Position;
end;

procedure TAnnotationToolEdit.CBHeadChange(Sender: TObject);
begin
  if Showing then
     Tool.Callout.ArrowHead:=TArrowHeadStyle(CBHead.ItemIndex);
end;

procedure TAnnotationToolEdit.Edit1Change(Sender: TObject);
begin
  if Showing then
     Tool.Callout.ArrowHeadSize:=UDHeadSize.Position;
end;

initialization
  RegisterClass(TAnnotationToolEdit);
end.
