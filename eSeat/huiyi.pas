unit huiyi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ComCtrls, dxTL, dxDBCtrl, dxDBGrid, dxCntner,
  StdCtrls, Buttons, ExtCtrls, dxEdLib, dxDBELib, dxDBTLCl, dxGrClms,eseatclasses,
  dxEditor, dxDBEdtr, RM_Common, RM_Class, RM_Dataset, DB, ADODB;

type
  Tfrmhuiyi = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Column1: TdxDBGridMaskColumn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    dxDBGrid1Column2: TdxDBGridMaskColumn;
    dxDBGrid1Column3: TdxDBGridMaskColumn;
    dxDBGrid1Column4: TdxDBGridMaskColumn;
    dxDBGrid1Column5: TdxDBGridMaskColumn;
    dxDBGrid1Column6: TdxDBGridMaskColumn;
    dxDBGrid2: TdxDBGrid;
    dxDBGrid2Column1: TdxDBGridMaskColumn;
    dxDBGrid2Column2: TdxDBGridMaskColumn;
    dxDBGrid1Column7: TdxDBGridDateColumn;
    dxDBGrid1Column8: TdxDBGridTimeColumn;
    Panel5: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Label9: TLabel;
    dxEdit1: TdxEdit;
    Label10: TLabel;
    dxDateEdit1: TdxDateEdit;
    Label11: TLabel;
    dxDateEdit2: TdxDateEdit;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Panel6: TPanel;
    BitBtn9: TBitBtn;
    Panel7: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dxDBEdit1: TdxDBEdit;
    dxDBEdit2: TdxDBEdit;
    dxDBDateEdit1: TdxDBDateEdit;
    dxDBButtonEdit1: TdxDBButtonEdit;
    dxDBImageEdit1: TdxDBImageEdit;
    dxImageEdit1: TdxImageEdit;
    Label12: TLabel;
    dxDBGrid2Column3: TdxDBGridPickColumn;
    dxDBGrid2Column4: TdxDBGridMaskColumn;
    BitBtn2: TBitBtn;
    BitBtn10: TBitBtn;
    dxDBMaskEdit1: TdxDBMaskEdit;
    RMReport1: TRMReport;
    RMDBDataSet1: TRMDBDataSet;
    dxDBSpinEdit1: TdxDBSpinEdit;
    dxDBSpinEdit2: TdxDBSpinEdit;
    procedure BitBtn4Click(Sender: TObject);
    procedure dxDBButtonEdit1ButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxDBGrid1ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure dxDBGrid2ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure dxDBImageEdit1Change(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    meeting:Tmeeting;
    meeting_people:Tmeeting_people;
    meetingid:integer;
    newid:integer;
    meetingpeopleid:integer;
    procedure refreshdata;
  public
    { Public declarations }
  end;

var
  frmhuiyi: Tfrmhuiyi;

implementation

uses sel_renyuan, sel_huichang,paixi,dm_seat,clientappfunction,seatcard;

{$R *.dfm}

procedure Tfrmhuiyi.BitBtn4Click(Sender: TObject);
var i:integer;

begin
  if Application.FindComponent('frm_sel_renyuan') = nil then
    Application.CreateForm(Tfrm_sel_renyuan,frm_sel_renyuan);
  if frm_sel_renyuan.showmodal=mrok then
  begin
    for i:=0 to high(frm_sel_renyuan.resultstring) do
    begin
      meetingpeopleid:=meeting_people.newitem;
      meeting_people.find(meetingpeopleid);
      meeting_people.peopleid:=strtoint(frm_sel_renyuan.resultstring[i].values['id']);
      meeting_people.meetingid:=meetingid;
      meeting_people.displayname:=frm_sel_renyuan.resultstring[i].values['name'];
      meeting_people.applymodify;
    end;
    meeting_people.getdata('meetingid='''+inttostr(meetingid)+'''',dmseat.aq_meeting_people);
    dmseat.aq_meeting_people.Locate('id',meetingpeopleid,[]);
  end;

end;

procedure Tfrmhuiyi.dxDBButtonEdit1ButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
   if Application.FindComponent('frm_sel_huichang') = nil then
    Application.CreateForm(Tfrm_sel_huichang,frm_sel_huichang);
   if frm_sel_huichang.showmodal=mrok then
   begin
     dmseat.aq_meeting.Edit;
     dmseat.aq_meeting.FieldByName('meetingroom').AsString:=frm_sel_huichang.resultstring[0].values['name'];
     dmseat.aq_meeting.fieldbyname('meetingroomid').asinteger:=strtoint(frm_sel_huichang.resultstring[0].values['id']);
   end;
end;

procedure Tfrmhuiyi.BitBtn6Click(Sender: TObject);
begin
  if not meeting.haspaixi(meetingid) then
  // add paixi info into database
    meeting.paixi(meetingid);
  if Application.FindComponent('frmpaixi') = nil then
    Application.CreateForm(Tfrmpaixi,frmpaixi);
  frmpaixi.meetingid:=meetingid;
  frmpaixi.showmodal;
end;

procedure Tfrmhuiyi.FormCreate(Sender: TObject);
begin
  meeting:=Tmeeting.Create(nil);
  meeting_people:=Tmeeting_people.create(nil);
end;

procedure Tfrmhuiyi.FormShow(Sender: TObject);
begin
  getstatuslist('meetingstatus',dximageedit1);
  refreshdata;
  getstatuslist('meetingstatus',dxdbimageedit1);
  pagecontrol1.ActivePage:=tabsheet1;
  dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
end;

procedure Tfrmhuiyi.dxDBGrid1ChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if dmseat.aq_meeting.RecordCount=0 then exit;
  meetingid:=dmseat.aq_meeting.fieldbyname('id').asinteger;
  meeting.find(meetingid);
  if pagecontrol1.ActivePage=tabsheet2 then
  begin
    meeting_people.getdata('meetingid='''+inttostr(meetingid)+'''',dmseat.aq_meeting_people);
    dxDBGrid2ChangeNode(sender,nil,dxdbgrid2.FocusedNode);
  end;
end;

procedure Tfrmhuiyi.PageControl1Change(Sender: TObject);
begin
  if pagecontrol1.ActivePage=tabsheet2 then
  begin
    meeting_people.getdata('meetingid='''+inttostr(meetingid)+'''',dmseat.aq_meeting_people);
    dxDBGrid2ChangeNode(sender,nil,dxdbgrid2.FocusedNode);
  end;
end;

procedure Tfrmhuiyi.BitBtn8Click(Sender: TObject);
begin
  dxedit1.Text:='';
  dxdateedit1.Text:='';
  dxdateedit2.Text:='';
end;

procedure Tfrmhuiyi.refreshdata;
var
  filterstr:string;
begin
  filterstr:='';
  if (dxedit1.Text='') and (dximageedit1.text='') and (dxdateedit1.text='') and (dxdateedit2.text='') then
    meeting.getdata('',dmseat.aq_meeting)
  else
  begin
    if dxedit1.text<>'' then filterstr:=filterstr+'name like ''%'+dxedit1.text+'%'' and ';
    if dximageedit1.text<>'' then filterstr:=filterstr+'status='''+dximageedit1.text+''' and ';
    if dxdateedit1.text<>'' then filterstr:=filterstr+'opendate>='''+dxdateedit1.text+''' and ';
    if dxdateedit2.text<>'' then filterstr:=filterstr+'opendate<'''+dxdateedit2.text+''' and ';
    filterstr:=copy(filterstr,1,length(filterstr)-5);
    meeting.getdata(filterstr,dmseat.aq_meeting);
  end
  {
    if (dxedit1.text<>'') and ((dxdateedit1.text<>'') or (dxdateedit2.text<>'')) then
      meetingpeople.getdata('name like ''%''+dxedit1.text+''%'' and status='''+dximageedit1.text+'''',dmseat.aq_meetingpeople)
      else if dxedit1.text<>'' then
             meetingpeople.getdata('name like ''%''+dxedit1.text+''%',dmseat.aq_meetingpeople)
               else  meetingpeople.getdata('status='''+dximageedit1.text+'''',dmseat.aq_meetingpeople);
               }
end;

procedure Tfrmhuiyi.BitBtn7Click(Sender: TObject);
begin
  refreshdata;
end;

procedure Tfrmhuiyi.BitBtn9Click(Sender: TObject);
begin
meeting.saveitem(dmseat.aq_meeting,meetingid);
refreshdata;
dmseat.aq_meeting.Locate('id',meetingid,[]);
end;

procedure Tfrmhuiyi.dxDBGrid2ChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if dmseat.aq_meeting_people.recordcount=0 then exit;
  meetingpeopleid:=dmseat.aq_meeting_people.fieldbyname('id').asinteger;
end;

procedure Tfrmhuiyi.BitBtn5Click(Sender: TObject);
begin
  if dmseat.aq_meeting_people.RecordCount=0 then exit;
  meeting_people.deleterecord(meetingpeopleid);
  meeting_people.getdata('meetingid='''+inttostr(meetingid)+'''',dmseat.aq_meeting_people);
end;

procedure Tfrmhuiyi.BitBtn2Click(Sender: TObject);
begin
  meeting_people.saveitem(dmseat.aq_meeting_people,meetingpeopleid);
  meeting_people.getdata('meetingid='''+inttostr(meetingid)+'''',dmseat.aq_meeting_people);
  dmseat.aq_meeting_people.Locate('id',meetingpeopleid,[]);
end;

procedure Tfrmhuiyi.dxDBImageEdit1Change(Sender: TObject);
begin
  if dmseat.aq_meeting.RecordCount=0 then exit;
  dmseat.aq_meeting.Edit;
  dmseat.aq_meeting.FieldByName('status').AsInteger:=strtoint(dxdbimageedit1.Text);
end;

procedure Tfrmhuiyi.BitBtn10Click(Sender: TObject);
begin
//print seatcard
  if Application.FindComponent('frmcard') = nil then
    Application.CreateForm(Tfrmcard,frmcard);
  if not dmseat.aq_meeting_people.Active then dmseat.aq_meeting_people.Open;
  RMReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'seatcard.rmf');
  RMDBDataSet1.Open;
  RMReport1.ShowReport;
end;

procedure Tfrmhuiyi.BitBtn1Click(Sender: TObject);
begin
  newid:=meeting.newitem;
  refreshdata;
  dmseat.aq_meeting.Locate('id',newid,[]);
end;

procedure Tfrmhuiyi.BitBtn3Click(Sender: TObject);
begin
  meeting.find(meetingid);
  meeting.status:='0';
  meeting.applymodify;
  refreshdata;
  dmseat.aq_meeting.Locate('id',meetingid,[]);
end;

end.
