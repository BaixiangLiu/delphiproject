unit paixi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,eseatclasses,ADODB, dxExEdtr, dxTL, dxDBCtrl,
  dxDBGrid, dxCntner, Buttons, OleServer, Excel2000;

type
  Tfrmpaixi = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Column1: TdxDBGridMaskColumn;
    dxDBGrid1Column2: TdxDBGridMaskColumn;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    dxDBGrid2: TdxDBGrid;
    dxDBGrid2Column1: TdxDBGridMaskColumn;
    dxDBGrid2Column2: TdxDBGridMaskColumn;
    dxDBGrid1Column3: TdxDBGridMaskColumn;
    dxDBGrid2Column3: TdxDBGridMaskColumn;
    Panel7: TPanel;
    Panel8: TPanel;
    BitBtn1: TBitBtn;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    ExcelWorksheet1: TExcelWorksheet;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure myleaderdragdrop(Sender, Source: TObject; X, Y: Integer);
    procedure myleaderDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure myDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure myDragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
    procedure CreateTable(mytabnum:integer;adoquery:Tadoquery;groupbox:Tgroupbox);
    function CreateSeat(myseatnum:integer;adoquery:tadoquery;groupbox:Tgroupbox):boolean;
    function CreateLeaderSeat(myseatnum:integer;adoquery:tadoquery;groupbox:Tgroupbox):boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxDBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);

  private

    { Private declarations }

  public
    { Public declarations }
    meetingid:integer;
  end;

  TESeatleaderPanel = Class(TPanel)
  private
    FTableID : String;
    FSeatID : String;
    FMeetingID : String;
    procedure SetTableID(Value: String);
    procedure SetSeatID(Value: String);
    procedure SetMeetingID(Value: String);
  public
  protected
    property TableID : String read FTableID write SetTableID;
    property SeatID : String read FSeatID write SetSeatID;
    property MeetingID : String read FMeetingID write SetMeetingID;
  end;
  TESeatPanel = Class(TPanel)
  private
    FTableID : String;
    FSeatID : String;
    FMeetingID : String;
    procedure SetTableID(Value: String);
    procedure SetSeatID(Value: String);
    procedure SetMeetingID(Value: String);
  public
  protected
    property TableID : String read FTableID write SetTableID;
    property SeatID : String read FSeatID write SetSeatID;
    property MeetingID : String read FMeetingID write SetMeetingID;
  end;


var
  frmpaixi: Tfrmpaixi;
  seatpeople:Tseat_people;

implementation

uses dm_seat,prtseat;

{$R *.dfm}

procedure TESeatPanel.SetTableID(Value: String);
begin
  FTableID := Value;
end;

procedure TESeatPanel.SetSeatID(Value: String);
begin
  FSeatID := Value;
end;

procedure TESeatPanel.SetMeetingID(Value: String);
begin
  FMeetingID := Value;

end;

procedure TESeatleaderPanel.SetTableID(Value: String);
begin
  FTableID := Value;
end;

procedure TESeatleaderPanel.SetSeatID(Value: String);
begin
  FSeatID := Value;
end;

procedure TESeatleaderPanel.SetMeetingID(Value: String);
begin
  FMeetingID := Value;

end;

function Tfrmpaixi.CreateSeat(myseatnum: integer; adoquery: tadoquery;groupbox:tgroupbox):boolean;
var i:integer;
    seatpnl:TESeatPanel;
begin
//  for i:=0 to groupbox.ControlCount-1 do
//  begin
//    showmessage(groupbox.Controls[i].ClassName);
//  end;
  for i:=0 to groupbox.ControlCount-1 do
  begin
    result:=false;
    if ((groupbox.Controls[i] as tpanel).caption='tabpnl'+inttostr(adoquery.fieldbyname('table_id').AsInteger)) then
    begin
      result:=true;
      seatpnl:=TESeatPanel.Create(self);
      seatpnl.Parent:= groupbox.Controls[i] as tpanel;
      seatpnl.Width:=30;
      seatpnl.Height:=30;
      seatpnl.Caption:=adoquery.fieldbyname('displayname').asstring;
 //     seatpnl.Left:=(groupbox.Controls[i] as tpanel).Left+1+myseatnum*31;
 //     seatpnl.top:=(groupbox.Controls[i] as tpanel).Top+1;

      seatpnl.Left:=myseatnum*31;
      seatpnl.top:=5;

      seatpnl.TableID:=inttostr(adoquery.fieldbyname('table_id').asinteger);
      seatpnl.SeatID:=inttostr(adoquery.fieldbyname('seat_id').asinteger);
      seatpnl.MeetingID:=inttostr(meetingid);
      seatpnl.OnDragDrop := mydragdrop;
      seatpnl.OnDragOver:=mydragover;
      seatpnl.DragMode:=dmAutomatic;
      break;
    end;
  end;
end;

procedure Tfrmpaixi.CreateTable(mytabnum: integer; adoquery: Tadoquery;groupbox:Tgroupbox);
var tabpnl:Tpanel;
begin
  tabpnl := tpanel.Create(Self);
  tabpnl.Width:=adoquery.fieldbyname('peoplecount').AsInteger*31+1;
  tabpnl.Height:=50;
  tabpnl.Parent := groupbox;
  tabpnl.Caption:='tabpnl'+inttostr(adoquery.fieldbyname('table_id').AsInteger);
//  tabpnl.Left:=groupbox.Left+2;
//  tabpnl.Top:=groupbox.Top+2+mytabnum*31;

   tabpnl.Left:=5;
  tabpnl.Top:=10+mytabnum*31;
end;

procedure Tfrmpaixi.FormCreate(Sender: TObject);
begin
  seatpeople:=Tseat_people.Create(nil);
end;

procedure Tfrmpaixi.FormShow(Sender: TObject);
var
        seatnum,tabnum : integer;
        findtab:boolean;
begin
  seatpeople.getdata('huiyiid='''+inttostr(meetingid)+''' and area=''领导区''',dmseat.aq_seat_people);
  dmseat.aq_seat_people.First;

  if not dmseat.aq_seat_people.eof then
  begin
  //-----------------创建第一张桌子
  tabnum:=0;
  createtable(tabnum,dmseat.aq_seat_people,groupbox1);
  //----------------------------

  seatnum:=0  ;

  while not dmseat.aq_seat_people.Eof do
  begin
    //判断位置对应的桌子是否已存在,已存在把位置放上去,不存在就创建桌子,并将位置放在刚创建的桌子中
    if not createleaderseat(seatnum,dmseat.aq_seat_people,groupbox1) then
    begin
      tabnum:=tabnum+1;
      createtable(tabnum,dmseat.aq_seat_people,groupbox1);
      seatnum:=0;
      createseat(seatnum,dmseat.aq_seat_people,groupbox1);
    end;
    seatnum:=seatnum+1;
    //--------------------------------------------------
    dmseat.aq_seat_people.next;
  end;
  end;
  seatpeople.getdata('huiyiid='''+inttostr(meetingid)+''' and area=''普通区''',dmseat.aq_seat_people);
  dmseat.aq_seat_people.First;

  if not dmseat.aq_seat_people.eof then
  begin
  //-----------------创建第一张桌子
  tabnum:=0;
  createtable(tabnum,dmseat.aq_seat_people,groupbox2);
  //----------------------------

  seatnum:=0  ;

  while not dmseat.aq_seat_people.Eof do
  begin
    //判断位置对应的桌子是否已存在,已存在把位置放上去,不存在就创建桌子,并将位置放在刚创建的桌子中
    if not createseat(seatnum,dmseat.aq_seat_people,groupbox2) then
    begin
      tabnum:=tabnum+1;
      createtable(tabnum,dmseat.aq_seat_people,groupbox2);
      seatnum:=0;
      createseat(seatnum,dmseat.aq_seat_people,groupbox2);
    end;
    seatnum:=seatnum+1;
    //--------------------------------------------------
    dmseat.aq_seat_people.next;
  end;
  end;
  seatpeople.getcancelpeople(meetingid,dmseat.aq_cancelpeople,'普通区');
  seatpeople.getcancelpeople(meetingid,dmseat.aq_leaderpeople,'领导区');

end;

procedure Tfrmpaixi.myleaderdragdrop(Sender, Source: TObject; X, Y: Integer);
var
    cancelpeople,cancelpeopletab,cancelpeopleseat:string;
    movedpeople,movedpeopletab,movedpeopleseat:string;
    peopleid:integer;
begin
  if (source is TESeatleaderPanel) then
  begin
    movedpeople:=(source as TESeatleaderPanel).Caption;
    movedpeopletab:=(source as TESeatleaderPanel).TableID;
    movedpeopleseat:=(source as TESeatleaderPanel).SeatID;
    if movedpeople='' then exit;
    seatpeople.search('table_id='''+movedpeopletab+''' and seat_id='''+movedpeopleseat+''' and huiyiid='''+inttostr(meetingid)+'''');
    peopleid:=seatpeople.peopleid;
    seatpeople.peopleid:=0;
    seatpeople.applymodify;
    (source as TESeatleaderPanel).Caption:='';

  end;
  if (source = dxdbgrid1) then
  begin
    movedpeople:=dxdbgrid1.ColumnByFieldName('displayname').Field.AsString;
    peopleid:=dxdbgrid1.ColumnByFieldName('peopleid').Field.Asinteger;
  end;
  cancelpeople:=(sender as TESeatleaderPanel).Caption;
  cancelpeopletab:=(sender as TESeatleaderPanel).TableID;
  cancelpeopleseat:=(sender as TESeatleaderPanel).SeatID;
  seatpeople.search('table_id='''+cancelpeopletab+''' and seat_id='''+cancelpeopleseat+''' and huiyiid='''+inttostr(meetingid)+'''');
  seatpeople.peopleid:=peopleid;
  seatpeople.applymodify;

  (sender as TESeatleaderPanel).Caption:=movedpeople;
//  seatpeople.getcancelpeople(meetingid,dmseat.aq_cancelpeople,'普通区');
  seatpeople.getcancelpeople(meetingid,dmseat.aq_leaderpeople,'领导区');
end;

procedure Tfrmpaixi.mydragdrop(Sender, Source: TObject; X, Y: Integer);
var
    cancelpeople,cancelpeopletab,cancelpeopleseat:string;
    movedpeople,movedpeopletab,movedpeopleseat:string;
    peopleid:integer;
begin
  if (source is TESeatPanel) then
  begin
    movedpeople:=(source as TESeatPanel).Caption;
    movedpeopletab:=(source as TESeatPanel).TableID;
    movedpeopleseat:=(source as TESeatPanel).SeatID;
    if movedpeople='' then exit;
    seatpeople.search('table_id='''+movedpeopletab+''' and seat_id='''+movedpeopleseat+''' and huiyiid='''+inttostr(meetingid)+'''');
    peopleid:=seatpeople.peopleid;
    seatpeople.peopleid:=0;
    seatpeople.applymodify;
    (source as TESeatPanel).Caption:='';
  end;

  if (source = dxdbgrid2) then
  begin
    movedpeople:=dxdbgrid2.ColumnByFieldName('displayname').Field.AsString;
    peopleid:=dxdbgrid2.ColumnByFieldName('peopleid').Field.Asinteger;
  end;
  cancelpeople:=(sender as TESeatPanel).Caption;
  cancelpeopletab:=(sender as TESeatPanel).TableID;
  cancelpeopleseat:=(sender as TESeatPanel).SeatID;
  seatpeople.search('table_id='''+cancelpeopletab+''' and seat_id='''+cancelpeopleseat+''' and huiyiid='''+inttostr(meetingid)+'''');
  seatpeople.peopleid:=peopleid;
  seatpeople.applymodify;

  (sender as TESeatPanel).Caption:=movedpeople;
  seatpeople.getcancelpeople(meetingid,dmseat.aq_cancelpeople,'普通区');
end;

procedure Tfrmpaixi.myDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=(source is TESeatPanel) or (source=dxdbgrid2) ;
  // and (state=dsDragEnter) ;

end;

procedure Tfrmpaixi.myleaderDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept:=(source is TESeatleaderPanel) or (source=dxdbgrid1) ;
  // and (state=dsDragEnter) ;

end;

procedure Tfrmpaixi.FormClose(Sender: TObject; var Action: TCloseAction);
var i,j:integer;
begin
  for i:=0 to groupbox1.ControlCount-1 do
  begin
    for j:=(groupbox1.Controls[i] as tpanel).ControlCount-1 downto 0 do
      ((groupbox1.Controls[i] as tpanel).controls[j] as TESeatleaderPanel).Destroy;
    (groupbox1.Controls[i] as tpanel).Destroy;
  end;
  for i:=0 to groupbox2.ControlCount-1 do
  begin
    for j:=(groupbox2.Controls[i] as tpanel).ControlCount-1 downto 0 do
      ((groupbox2.Controls[i] as tpanel).controls[j] as TESeatPanel).Destroy;
    (groupbox2.Controls[i] as tpanel).Destroy;
  end;
{
 for i:=0 to frmpaixi.ComponentCount-1 do
    if (frmpaixi.Components[i] is tpanel) and ((frmpaixi.Components[i] as tpanel).Parent = groupbox1) then
    begin
    (frmpaixi.Components[i] as tpanel).Destroy;
    end;
 }
end;

procedure Tfrmpaixi.dxDBGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (sender is TESeatPanel) and (source is Tdxdbgrid) then
   accept:=true
   else accept:=false;
end;

function Tfrmpaixi.CreateLeaderSeat(myseatnum: integer;
  adoquery: tadoquery; groupbox: Tgroupbox): boolean;
var i:integer;
    leaderseatpnl:TESeatleaderPanel;
begin
  for i:=0 to groupbox.ControlCount-1 do
  begin
    result:=false;
    if ((groupbox.Controls[i] as tpanel).caption='tabpnl'+inttostr(adoquery.fieldbyname('table_id').AsInteger)) then
    begin
      result:=true;
      leaderseatpnl:=TESeatleaderPanel.Create(self);
      leaderseatpnl.Parent:= groupbox.Controls[i] as tpanel;
      leaderseatpnl.Width:=30;
      leaderseatpnl.Height:=30;
      leaderseatpnl.Caption:=adoquery.fieldbyname('displayname').asstring;
      leaderseatpnl.Left:=5+myseatnum*31;
      leaderseatpnl.top:=10;
      leaderseatpnl.TableID:=inttostr(adoquery.fieldbyname('table_id').asinteger);
      leaderseatpnl.SeatID:=inttostr(adoquery.fieldbyname('seat_id').asinteger);
      leaderseatpnl.MeetingID:=inttostr(meetingid);
      leaderseatpnl.OnDragDrop := myleaderdragdrop;
      leaderseatpnl.OnDragOver:=myleaderdragover;
      leaderseatpnl.DragMode:=dmAutomatic;
      break;
    end;
  end;
end;

procedure Tfrmpaixi.BitBtn1Click(Sender: TObject);
var j:integer;
    row,col:integer;
    excelfilename:string;
    tableid:integer;
begin
//  seatpeople.getseattable(meetingid,dmseat.aq_seat,'领导区');
  try
    excelapplication1.Connect;
  except
    application.MessageBox('没有安装EXCEL','错误',MB_OK+MB_ICONERROR);
    abort;
  end;
  excelapplication1.Visible[0]:=true;
  excelapplication1.Caption:='打印席位';
  excelapplication1.Workbooks.Add(null,0);
  excelworkbook1.ConnectTo(excelapplication1.Workbooks[1]);
  excelworksheet1.ConnectTo(excelworkbook1.Worksheets[1] as _worksheet);
  seatpeople.getseattable(meetingid,dmseat.aq_seat,'领导区');
  if dmseat.aq_seat.RecordCount<>0 then
  begin
    excelworksheet1.Cells.item[1,1]:='领导区';
    row:=2;
    col:=1;
    dmseat.aq_seat.First;
    tableid:=dmseat.aq_seat.fieldbyname('table_id').asinteger;
    excelworksheet1.cells.item[row,col]:=tableid;
    while not dmseat.aq_seat.Eof do
    begin
      if dmseat.aq_seat.fieldbyname('table_id').asinteger<>tableid then
      begin
      inc(row);
      col:=1;
      excelworksheet1.cells.item[row,col]:=tableid;
      end;
    //  inc(col);
      excelworksheet1.cells.item[row,col+dmseat.aq_seat.FieldByName('seatid').asinteger]:=dmseat.aq_seat.fieldbyname('displayname').asstring;
   {
      for j:=0 to dmseat.aq_seat.FieldCount-1 do
        excelworksheet1.Cells.Item[row,j+1]:=dmseat.aq_seat.Fields[j].Value;
      inc(row);
      }
      dmseat.aq_seat.Next;
    end;
  end;

  inc(row);
  col:=1;
  seatpeople.getseattable(meetingid,dmseat.aq_seat,'普通区');
  if dmseat.aq_seat.RecordCount<>0 then
  begin
    excelworksheet1.Cells.item[row,col]:='普通区';
    inc(row);

    dmseat.aq_seat.First;
    tableid:=dmseat.aq_seat.fieldbyname('table_id').asinteger;
    excelworksheet1.cells.item[row,col]:=tableid;
    while not dmseat.aq_seat.Eof do
    begin
      if dmseat.aq_seat.fieldbyname('table_id').asinteger<>tableid then
      begin
      inc(row);
      col:=1;
      excelworksheet1.cells.item[row,col]:=tableid;
      end;
    //  inc(col);
      excelworksheet1.cells.item[row,col+dmseat.aq_seat.FieldByName('seatid').asinteger]:=dmseat.aq_seat.fieldbyname('displayname').asstring;
   {
      for j:=0 to dmseat.aq_seat.FieldCount-1 do
        excelworksheet1.Cells.Item[row,j+1]:=dmseat.aq_seat.Fields[j].Value;
      inc(row);
      }
      dmseat.aq_seat.Next;
    end;
   end;
end;

procedure Tfrmpaixi.BitBtn2Click(Sender: TObject);
var i,j:integer;
begin
  for i:=0 to groupbox2.ControlCount-1 do
  begin
   if (groupbox2.Controls[i] is tpanel) then
   begin
   showmessage('tb '+(groupbox2.Controls[i] as tpanel).Caption+inttostr((groupbox2.Controls[i] as tpanel).left)+' '+inttostr((groupbox2.Controls[i] as tpanel).top));
   for j:=0 to (groupbox2.controls[i] as tpanel).controlcount-1 do
   begin
     showmessage((((groupbox2.controls[i] as tpanel).Controls[j]) as tpanel).caption+inttostr((((groupbox2.controls[i] as tpanel).Controls[j]) as tpanel).left)+' '+inttostr((((groupbox2.controls[i] as tpanel).Controls[j]) as tpanel).top));
   end;
   end;
  end;
end;

end.
