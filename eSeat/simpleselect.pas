{*********************************
  选择模板一：  仅显示一列的信息。
  适用于简单对象，例如百分比类型、作业类型等等，也可以显示比较复杂的。
  用法示例：
    fwbs.GetData(d);
    with Fsimpleselect do                    //最好是动态create,在此我没有那么做
    begin
      tb_keyfield:=fwbs.getkeyfield;
      tb_parentfield:=fwbs.getparentfield;
      tb_displayfield:='wbs_id';
      query.recordset:=idispatch(d) as _recordset;
      showmodal;
    end;

    dxDBButtonEdit2.Text:=Fsimpleselect.resultstring;
  以上是以树状显示，也可改成：

    fwbs.GetData(d);
    with Fsimpleselect do
    begin
      tb_keyfield:='wbs_id';
      tb_parentfield:='wbs_id';
      tb_displayfield:='wbs_id';
      query.recordset:=idispatch(d) as _recordset;
      showmodal;
    end;
    dxDBButtonEdit2.Text:=Fsimpleselect.resultstring;


**********************************}
unit simpleselect;

interface

uses
  Windows,adodb,Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dxCntner, dxEditor, dxEdLib, ExtCtrls, DB,
  DBClient, ComCtrls, dxtree, dxdbtree, dxTL, dxDBCtrl, dxDBTL, dxExEdtr,
  ImgList,  jpeg, dxDBGrid;

type
  TFsimpleselect = class(TForm)
    query: Tadoquery;
    dsquery: TDataSource;
    p1: TPanel;
    p2: TPanel;
    p3: TPanel;
    p4: TPanel;
    BitBtn1: TBitBtn;
    btnok: TBitBtn;
    btnCancel: TBitBtn;
    edit: TdxEdit;
    BitBtn_refresh: TBitBtn;

    ptop: TPanel;
    psplit: TPanel;
    img_left: TImage;
    img_btn: TImage;
    btnclear: TBitBtn;
    list: TdxDBGrid;
    procedure editChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure listDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnokClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure p2Resize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnclearClick(Sender: TObject);
  private
    lastmatchcolum:integer;
    { Private declarations }
  public
    SelType:integer;           //0: 多选，没有清除   1: 单选，有清除    2：单选，没有清除
    tb_keyfield,tb_parentfield:string;
    tb_displayfield:Tstrings;
    tb_displayfieldcaption:Tstrings;
    resultstring:array of Tstrings;

    { Public declarations }
  end;

var
  Fsimpleselect: TFsimpleselect;

implementation

uses dm_seat;

{$R *.dfm}

procedure TFsimpleselect.editChange(Sender: TObject);
var i:integer;
    b:TBookmark;
    temp_lastmatchcolum:integer;
begin
 if not query.Active or (query.RecordCount=0) then exit;
 temp_lastmatchcolum:=lastmatchcolum;
 b:=query.getBookmark;
 list.ClearSelection;
 while not query.Eof do
 begin
   for i:=temp_lastmatchcolum+1 to list.VisibleColumnCount-1 do
   begin
     try
       if pos(AnsiUpperCase(edit.Text),AnsiUpperCase(vartostr(list.VisibleColumns[i].Field.Value)))>0 then
       begin
         lastmatchcolum:=i;
         list.FocusedColumn:=lastmatchcolum;
         list.FocusedNode.Selected:=true;
         exit;
       end;
     except
     end;
   end;
   temp_lastmatchcolum:=-1;
   query.Next;
 end;
 if query.Eof then
 begin
   query.GotoBookmark(b);
   list.FocusedColumn:=lastmatchcolum;
   list.FocusedNode.Selected:=true;
   query.FreeBookmark(b);
 end;
end;

procedure TFsimpleselect.btnCancelClick(Sender: TObject);
begin
  self.modalresult:=mrcancel;
end;

procedure TFsimpleselect.listDblClick(Sender: TObject);
var i:integer;
    s:string;

begin
  if list.FocusedNode=nil then
  begin
     modalresult:=2;
     exit;
  end;
  setlength(resultstring,1);
  resultstring[0]:=Tstringlist.Create;
  {
  s:=list.KeyField+'='+vartostr(query.FieldValues[list.KeyField]);
  resultstring[0].Add(s);
  for i:=0 to list.ColumnCount-1 do
  begin
    s:=list.Columns[i].FieldName+'='+vartostr(list.FocusedNode.values[i]);
    resultstring[0].Add(s);
  end;
  }
  //yang  advance to return all the fields value 2003-4-11
  for i:=0 to query.FieldCount-1 do
  begin
    s:=query.Fields.Fields[i].FieldName+'='+vartostr(query.Fields.Fields[i].Value);
    resultstring[0].Add(s);
  end;
  modalresult:=mrok;
end;

procedure TFsimpleselect.FormCreate(Sender: TObject);
begin

  tb_displayfield:=Tstringlist.Create;
  tb_displayfieldcaption:=Tstringlist.Create;
  SelType:=0;
  lastmatchcolum:=-1;
end;

procedure TFsimpleselect.btnokClick(Sender: TObject);
var i,j:integer;
    s:string;
begin
 if query.RecordCount=0 then
 begin
   modalresult:=2;
   exit;
 end;  
 if edgoMultiSelect in list.OptionsBehavior then
 begin
   if list.SelectedCount=0 then
   begin
     modalresult:=mrCancel;
     exit;
   end;
   setlength(resultstring,list.SelectedCount);
   for i:=0 to list.SelectedCount-1 do
   begin
     query.GotoBookmark(pointer(list.SelectedRows[i]));     //?????
     resultstring[i]:=Tstringlist.Create;
     {
     s:=list.KeyField+'='+vartostr(query.FieldValues[list.KeyField]);
     resultstring[i].Add(s);
     for j:=0 to list.ColumnCount-1 do
     begin
       s:=list.Columns[i].FieldName+'='+vartostr(list.SelectedNodes[i].Values[j]);
       resultstring[i].Add(s);
     end;
     }
    //yang advance to return all then fields value 2003-4-11
     for j:=0 to query.FieldCount-1 do
     begin
       if  query.Fields.Fields[j].Value=null then
         s:=query.Fields.Fields[j].FieldName+'='
       else
         s:=query.Fields.Fields[j].FieldName+'='+vartostr(query.Fields.Fields[j].Value);
       resultstring[i].Add(s);
     end;
   end;
 end;
 if not (edgoMultiSelect in list.OptionsBehavior) then
 begin
    setlength(resultstring,1);
    resultstring[0]:=Tstringlist.Create;
    {
    s:=list.KeyField+'='+vartostr(query.FieldValues[list.KeyField]);
    resultstring[0].Add(s);
    for i:=0 to list.ColumnCount-1 do
    begin
     s:=list.Columns[i].FieldName+'='+vartostr(list.FocusedNode.Values[i]);
     resultstring[0].Add(s);
    end;
    }
    //yang advance to return all then fields value 2003-4-11
    for i:=0 to query.FieldCount-1 do
    begin
      s:=query.Fields.Fields[i].FieldName+'='+vartostr(query.Fields.Fields[i].Value);
      resultstring[0].Add(s);
    end;
  end;
  self.modalresult:=1;
end;

procedure TFsimpleselect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if tb_displayfield<>nil then
    tb_displayfield.Clear;
  if tb_displayfieldcaption<>nil then
    tb_displayfieldcaption.Clear;
  // 2005-8-12
  // Modified by Chang
  if ModalResult <> mrOk then resultstring := nil;
end;

procedure TFsimpleselect.FormDestroy(Sender: TObject);
var i:integer;
begin
  for i:=0 to high(resultstring)-1 do
  begin
    resultstring[i].Free;
  end;
  resultstring:=nil;               //是否自动释放Tstring？
  tb_displayfield.Free;
  tb_displayfieldcaption.free;
end;

procedure TFsimpleselect.p2Resize(Sender: TObject);
begin
  edit.Width:=p2.Width-BitBtn1.Width-2;
end;



procedure TFsimpleselect.FormActivate(Sender: TObject);
var c:TdxDBgridColumn;
   i:integer;
begin
  if (query.RecordCount=0) then
  begin
    modalresult:=2;
    //showmessage('无列表信息.');
    exit;
  end;

  for i:=0 to high(resultstring) do
  begin
    resultstring[i].Free;
  end;
  resultstring:=nil;
   {
  if LIST.KeyField='' then                   //所以一定不要忘记设置keyfield.:)
  begin
    with list do
    begin
        destroycolumns;
        keyfield:='';
        for i:=0 to tb_displayfield.Count-1 do
        begin
          c:=CreateColumn(TdxDBgridColumn);
          c.FieldName:=tb_displayfield.Strings[i];
          if i<=tb_displayfieldcaption.Count-1 then
            c.Caption:=  tb_displayfieldcaption.strings[i];
        end;
        KeyField:=tb_keyfield;
        ParentField:=tb_parentfield;
    end;
  end;
  list.FullExpand;  }
end;

procedure TFsimpleselect.FormShow(Sender: TObject);
begin
  inherited;
  if seltype=0 then
  begin
    list.OptionsBehavior:=list.OptionsBehavior+[edgoMultiSelect];
    btnclear.Visible:=false;
  end else if seltype=1 then
  begin
    list.OptionsBehavior:=list.OptionsBehavior-[edgoMultiSelect];
    btnclear.Visible:=true;
  end else if seltype=1 then
  begin
    list.OptionsBehavior:=list.OptionsBehavior-[edgoMultiSelect];
    btnclear.Visible:=false;
  end;
end;

procedure TFsimpleselect.btnclearClick(Sender: TObject);
begin
  resultstring:=nil;
  modalresult:=mrok;
end;


end.
