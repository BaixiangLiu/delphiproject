unit renyuan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid, dxEdLib, dxDBELib, dxEditor,
  dxDBEdtr, dxCntner, StdCtrls, ComCtrls, Buttons, ExtCtrls,eseatclasses;

type
  Tfrmrenyuan = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    dxDBGrid1: TdxDBGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    dxDBGrid1Column1: TdxDBGridMaskColumn;
    dxDBGrid1Column2: TdxDBGridMaskColumn;
    dxDBGrid1Column3: TdxDBGridMaskColumn;
    dxDBGrid1Column4: TdxDBGridMaskColumn;
    dxDBGrid1Column5: TdxDBGridMaskColumn;
    Label5: TLabel;
    Label6: TLabel;
    dxEdit1: TdxEdit;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel5: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    dxDBEdit1: TdxDBEdit;
    dxDBEdit2: TdxDBEdit;
    BitBtn2: TBitBtn;
    dxDBImageEdit1: TdxDBImageEdit;
    dxImageEdit1: TdxImageEdit;
    dxDBImageEdit2: TdxDBImageEdit;
    dxDBImageEdit3: TdxDBImageEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dxDBGrid1ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure BitBtn2Click(Sender: TObject);
    procedure dxDBImageEdit1Change(Sender: TObject);
    procedure dxDBImageEdit2Change(Sender: TObject);
    procedure dxDBImageEdit3Change(Sender: TObject);
  private
    { Private declarations }
    meetingpeople:Tmeetingpeople;
    newid,id:integer;
  public
    { Public declarations }
  end;

var
  frmrenyuan: Tfrmrenyuan;

implementation
uses dm_seat,clientappfunction;

{$R *.dfm}

procedure Tfrmrenyuan.FormShow(Sender: TObject);
begin
  getstatuslist('meetingpeoplestatus',dximageedit1);

  refreshdata;
  dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
  getstatuslist('meetingpeoplestatus',dxdbimageedit1);
   getstatuslist('career',dxdbimageedit2);
  getstatuslist('grade',dxdbimageedit3);
end;

procedure Tfrmrenyuan.FormCreate(Sender: TObject);
begin
  meetingpeople:=Tmeetingpeople.create(nil);
end;

procedure Tfrmrenyuan.refreshdata;
var
  filterstr:string;
begin
  filterstr:='';
  if (dxedit1.Text='') and (dximageedit1.text='') then
    meetingpeople.getdata('',dmseat.aq_meetingpeople)
  else
  begin
    if dxedit1.text<>'' then filterstr:=filterstr+'name like ''%'+dxedit1.text+'%'' and ';
    if dximageedit1.text<>'' then filterstr:=filterstr+'status='''+dximageedit1.text+''' and ';

    filterstr:=copy(filterstr,1,length(filterstr)-5);
    meetingpeople.getdata(filterstr,dmseat.aq_meetingpeople);
  end

end;

procedure Tfrmrenyuan.BitBtn3Click(Sender: TObject);
begin
  refreshdata;
  dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
end;

procedure Tfrmrenyuan.BitBtn4Click(Sender: TObject);
begin
  dxedit1.Text:='';
  dximageedit1.Text:='';
end;

procedure Tfrmrenyuan.BitBtn1Click(Sender: TObject);
begin
  newid:=meetingpeople.newitem;
  refreshdata;
  dmseat.aq_meetingpeople.Locate('id',newid,[]);
end;

procedure Tfrmrenyuan.dxDBGrid1ChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if dmseat.aq_meetingpeople.RecordCount=0 then exit;
  id:=dmseat.aq_meetingpeople.fieldbyname('id').asinteger;
  meetingpeople.find(id);
end;

procedure Tfrmrenyuan.BitBtn2Click(Sender: TObject);
begin
  meetingpeople.saveitem(dmseat.aq_meetingpeople,id);
  refreshdata;
  dmseat.aq_meetingpeople.Locate('id',id,[]);
end;

procedure Tfrmrenyuan.dxDBImageEdit1Change(Sender: TObject);
begin
  if dmseat.aq_meetingpeople.RecordCount=0 then exit;
  dmseat.aq_meetingpeople.Edit;
  dmseat.aq_meetingpeople.FieldByName('status').AsInteger:=strtoint(dxdbimageedit1.Text);
end;

procedure Tfrmrenyuan.dxDBImageEdit2Change(Sender: TObject);
begin
  if dmseat.aq_meetingpeople.RecordCount=0 then exit;
  dmseat.aq_meetingpeople.Edit;
  dmseat.aq_meetingpeople.FieldByName('career').Asstring:=trim(dxDBImageEdit2.Text);
end;

procedure Tfrmrenyuan.dxDBImageEdit3Change(Sender: TObject);
begin
  if dmseat.aq_meetingpeople.RecordCount=0 then exit;
  dmseat.aq_meetingpeople.Edit;
  dmseat.aq_meetingpeople.FieldByName('grade').Asstring:=trim(dxdbimageedit3.Text);
end;

end.
