unit huichang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ComCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  StdCtrls, Buttons, ExtCtrls, dxDBTLCl, dxGrClms, dxEditor, dxEdLib,
  dxDBELib, dxDBEdtr,eseatclasses;

type
  Tfrmhuichang = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PageControl1: TPageControl;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    dxDBGrid1: TdxDBGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    dxDBGrid1Column1: TdxDBGridMaskColumn;
    dxDBGrid1Column2: TdxDBGridMaskColumn;
    dxDBGrid1Column3: TdxDBGridMaskColumn;
    dxDBGrid1Column4: TdxDBGridMaskColumn;
    dxDBGrid1Column6: TdxDBGridMaskColumn;
    dxDBGrid1Column5: TdxDBGridMaskColumn;
    dxDBGrid2: TdxDBGrid;
    dxDBGrid2Column1: TdxDBGridMaskColumn;
    dxDBGrid2Column2: TdxDBGridMaskColumn;
    Label7: TLabel;
    dxEdit1: TdxEdit;
    Label8: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Panel5: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dxDBEdit1: TdxDBEdit;
    dxDBEdit2: TdxDBEdit;
    dxDBEdit3: TdxDBEdit;
    BitBtn7: TBitBtn;
    dxDBGrid2Column3: TdxDBGridDateColumn;
    dxDBImageEdit1: TdxDBImageEdit;
    TabSheet3: TTabSheet;
    dxDBGrid3: TdxDBGrid;
    Panel7: TPanel;
    dxDBGrid3Column1: TdxDBGridMaskColumn;
    BitBtn2: TBitBtn;
    BitBtn8: TBitBtn;
    dxImageEdit1: TdxImageEdit;
    BitBtn9: TBitBtn;
    dxDBGrid3Column4: TdxDBGridPickColumn;
    dxDBCheckEdit1: TdxDBCheckEdit;
    dxDBSpinEdit1: TdxDBSpinEdit;
    dxDBSpinEdit2: TdxDBSpinEdit;
    dxDBGrid3Column2: TdxDBGridImageColumn;
    dxDBGrid3Column3: TdxDBGridSpinColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dxDBGrid1ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure dxDBGrid3ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure BitBtn8Click(Sender: TObject);
    procedure dxDBCheckEdit1Click(Sender: TObject);
    procedure dxDBImageEdit1Change(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure dxDBGrid3Column2Change(Sender: TObject);
    procedure dxDBGrid3Column2CloseUp(Sender: TObject; var Value: String;
      var Accept: Boolean);
  private
    { Private declarations }
    meetingroom:Tmeetingroom;
    meeting:Tmeeting;
    room_table:Troomtable;
    newid:integer;
    newroomtableid:integer;
    id:integer;
    roomtableid:integer;
    procedure refreshdata;
  public
    { Public declarations }
  end;

var
  frmhuichang: Tfrmhuichang;

implementation
uses dm_seat,clientappfunction;

{$R *.dfm}

procedure Tfrmhuichang.FormCreate(Sender: TObject);
begin
  meetingroom:=Tmeetingroom.Create(nil);
  meeting:=Tmeeting.Create(nil);
  room_table:=Troomtable.create(nil);
end;

procedure Tfrmhuichang.FormShow(Sender: TObject);
begin
  getstatuslist('meetingroomstatus',dximageedit1);
  refreshdata;
  getstatuslist('meetingroomstatus',dxdbimageedit1);
  getparamlist('tabletype','tabletype',dxdbgrid3);
  dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
  pagecontrol1.ActivePage:=tabsheet1;
end;

procedure Tfrmhuichang.BitBtn1Click(Sender: TObject);
begin
  newid:=meetingroom.newitem;
  refreshdata;
  //meetingroom.getdata('',dmseat.aq_meetingroom);
  dmseat.aq_meetingroom.Locate('id',newid,[]);
end;

procedure Tfrmhuichang.dxDBGrid1ChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if dmseat.aq_meetingroom.RecordCount=0 then exit;
  id:=dmseat.aq_meetingroom.fieldbyname('id').asinteger;
  meetingroom.find(id);
  if pagecontrol1.ActivePage=tabsheet2 then
    meeting.getdata('meetingroomid='''+inttostr(id)+'''',dmseat.aq_meeting);
  if pagecontrol1.ActivePage=tabsheet3 then
  begin
    room_table.getdata('meetingroom_id='''+inttostr(id)+'''',dmseat.aq_room_table);
    dxDBGrid3ChangeNode(sender,nil,dxdbgrid3.FocusedNode);
  end;
end;

procedure Tfrmhuichang.PageControl1Change(Sender: TObject);
begin
 // if pagecontrol1.ActivePage=tabsheet1 then
    dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
 // if pagecontrol1.ActivePage=tabsheet3 then
 //   dxDBGrid3ChangeNode(sender,nil,dxdbgrid3.FocusedNode);
end;

procedure Tfrmhuichang.BitBtn7Click(Sender: TObject);
begin
  meetingroom.saveitem(dmseat.aq_meetingroom,id);
  //meetingroom.getdata('',dmseat.aq_meetingroom);
  refreshdata;
  dmseat.aq_meetingroom.Locate('id',id,[]);
end;

procedure Tfrmhuichang.BitBtn5Click(Sender: TObject);
begin
  refreshdata;
end;

procedure Tfrmhuichang.refreshdata;
var
  filterstr:string;
begin
  filterstr:='';
  if (dxedit1.Text='') and (dximageedit1.text='') then
    meetingroom.getdata('',dmseat.aq_meetingroom)
  else
  begin
    if dxedit1.text<>'' then filterstr:=filterstr+'name like ''%'+dxedit1.text+'%'' and ';
    if dximageedit1.text<>'' then filterstr:=filterstr+'status='''+dximageedit1.text+''' and ';

    filterstr:=copy(filterstr,1,length(filterstr)-5);
    meetingroom.getdata(filterstr,dmseat.aq_meetingroom);
  end

end;

procedure Tfrmhuichang.BitBtn2Click(Sender: TObject);
begin
  newroomtableid:=room_table.newitem;
  room_table.find(newroomtableid);
  room_table.meetingroom_id:=id;
  room_table.applymodify;
  room_table.getdata('meetingroom_id='''+inttostr(id)+'''',dmseat.aq_room_table);
  dmseat.aq_room_table.Locate('id',newroomtableid,[]);
  dxdbgrid3changenode(sender,nil,dxdbgrid3.FocusedNode);
end;

procedure Tfrmhuichang.BitBtn3Click(Sender: TObject);
begin
  meetingroom.find(id);
  meetingroom.status:='0';
  meetingroom.applymodify;
  refreshdata;
  dmseat.aq_meetingroom.Locate('id',id,[]);
end;

procedure Tfrmhuichang.BitBtn4Click(Sender: TObject);
begin
  meetingroom.find(id);
  meetingroom.status:='1';
  meetingroom.applymodify;
  refreshdata;
  dmseat.aq_meetingroom.Locate('id',id,[]);
end;

procedure Tfrmhuichang.BitBtn9Click(Sender: TObject);
begin
  room_table.saveitem(dmseat.aq_room_table,roomtableid);
  room_table.getdata('meetingroom_id='''+inttostr(id)+'''',dmseat.aq_room_table);
  dmseat.aq_room_table.Locate('id',roomtableid,[]);
end;

procedure Tfrmhuichang.dxDBGrid3ChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if dmseat.aq_room_table.RecordCount=0 then exit;
  roomtableid:=dmseat.aq_room_table.fieldbyname('id').asinteger;
  room_table.find(roomtableid);
end;

procedure Tfrmhuichang.BitBtn8Click(Sender: TObject);
begin
  if dmseat.aq_room_table.RecordCount=0 then exit;
  room_table.deleterecord(roomtableid);
  room_table.getdata('meetingroom_id='''+inttostr(id)+'''',dmseat.aq_room_table);
  dxdbgrid3changenode(sender,nil,dxdbgrid3.FocusedNode);
end;

procedure Tfrmhuichang.dxDBCheckEdit1Click(Sender: TObject);
begin
    meetingroom.iscomplete:=dxdbcheckedit1.Checked;
    meetingroom.applymodify;
    refreshdata;
    dmseat.aq_meetingroom.Locate('id',id,[]);
    dxdbgrid3column1.ReadOnly:=dxdbcheckedit1.Checked;
    dxdbgrid3column2.ReadOnly:=dxdbcheckedit1.Checked;
    dxdbgrid3column3.ReadOnly:=dxdbcheckedit1.Checked;
    dxdbgrid3column4.ReadOnly:=dxdbcheckedit1.Checked;
  if dxdbcheckedit1.Checked then
    meetingroom.generateseat(id)
  else
    meetingroom.cancelseat(id);
end;

procedure Tfrmhuichang.dxDBImageEdit1Change(Sender: TObject);
begin
  if dmseat.aq_meetingroom.RecordCount=0 then exit;
  dmseat.aq_meetingroom.Edit;
  dmseat.aq_meetingroom.FieldByName('status').AsInteger:=strtoint(dxdbimageedit1.Text);
end;

procedure Tfrmhuichang.BitBtn6Click(Sender: TObject);
begin
  dxedit1.Text:='';
  dximageedit1.Text:='';
end;

procedure Tfrmhuichang.dxDBGrid3Column2Change(Sender: TObject);
begin

//  dmseat.aq_room_table.Edit;
//  showmessage(inttostr(dxdbgrid3column2.GroupIndex));

 // dmseat.aq_room_table.FieldByName('table_type').Asstring:=dxdbgrid3column2.Values.Strings[dxdbgrid3column2.index-1];
 // dmseat.aq_room_table.FieldByName('table_type').Asstring:=trim(dxdbgrid3column2.Values.Strings[dxdbgrid3column2.RowIndex]);
 // dmseat.aq_room_table.FieldByName('tabletype').Asstring:=dxdbgrid3column2.Descriptions.Text;
end;

procedure Tfrmhuichang.dxDBGrid3Column2CloseUp(Sender: TObject;
  var Value: String; var Accept: Boolean);
begin
    dmseat.aq_room_table.Edit;
    //showmessage(dmseat.aq_room_table.FieldByName('table_type').Asstring);
   // showmessage(Value);
  dmseat.aq_room_table.FieldByName('table_type').Asstring:=Value;
 // dmseat.aq_room_table.FieldByName('table_type').Asstring:=trim(dxdbgrid3column2.Values.Strings[dxdbgrid3column2.RowIndex]);
 // dmseat.aq_room_table.FieldByName('tabletype').Asstring:=dxdbgrid3column2.Descriptions.Text;

end;

end.
