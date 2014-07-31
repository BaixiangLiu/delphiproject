unit param;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ComCtrls,eseatclasses,
  StdCtrls, Buttons, ExtCtrls;

type
  Tfrm_param = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Column1: TdxDBGridMaskColumn;
    dxDBGrid1Column2: TdxDBGridMaskColumn;
    dxDBGrid2: TdxDBGrid;
    dxDBGridMaskColumn1: TdxDBGridMaskColumn;
    dxDBGridMaskColumn2: TdxDBGridMaskColumn;
    dxDBGrid3: TdxDBGrid;
    dxDBGridMaskColumn3: TdxDBGridMaskColumn;
    dxDBGridMaskColumn4: TdxDBGridMaskColumn;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    dxDBGrid1Column3: TdxDBGridMaskColumn;
    dxDBGrid2Column3: TdxDBGridMaskColumn;
    dxDBGrid3Column3: TdxDBGridMaskColumn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dxDBGrid1ChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);

  private
    { Private declarations }
    paramlist:Tparamlist;
  public
    { Public declarations }
    id:integer;
  end;

var
  frm_param: Tfrm_param;

implementation

{$R *.dfm}
uses dm_seat;

procedure Tfrm_param.BitBtn1Click(Sender: TObject);
var newid:integer;
begin
//add
  newid:=paramlist.newitem;
  paramlist.find(newid);
  if pagecontrol1.ActivePage=tabsheet1 then
    paramlist.class_id:='grade';
  if pagecontrol1.ActivePage=tabsheet2 then
    paramlist.class_id:='career';
  if pagecontrol1.ActivePage=tabsheet3 then
    paramlist.class_id:='tabletype';
  paramlist.applymodify;
  PageControl1Change(sender);
  dmseat.aq_param.Locate('id',newid,[]);
end;

procedure Tfrm_param.BitBtn3Click(Sender: TObject);
begin
//save
  paramlist.saveitem(dmseat.aq_param,id);
  PageControl1Change(sender);
  dmseat.aq_param.Locate('id',id,[]);
end;

procedure Tfrm_param.BitBtn2Click(Sender: TObject);
begin
//del
  paramlist.delrecord(id);
  PageControl1Change(sender);
end;

procedure Tfrm_param.PageControl1Change(Sender: TObject);
begin
  if pagecontrol1.ActivePage=tabsheet1 then
  begin
    paramlist.getdata('class_id=''grade''',dmseat.aq_param);
    dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
  end;
  if pagecontrol1.ActivePage=tabsheet2 then
  begin
    paramlist.getdata('class_id=''career''',dmseat.aq_param);
    dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
  end;
  if pagecontrol1.ActivePage=tabsheet3 then
  begin
    paramlist.getdata('class_id=''tabletype''',dmseat.aq_param);
    dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
  end;
end;

procedure Tfrm_param.FormCreate(Sender: TObject);
begin
  paramlist:=tparamlist.create(nil);
end;

procedure Tfrm_param.FormShow(Sender: TObject);
begin
  pagecontrol1.ActivePage:=tabsheet1;
  paramlist.getdata('class_id=''grade''',dmseat.aq_param);
  dxDBGrid1ChangeNode(sender,nil,dxdbgrid1.FocusedNode);
end;

procedure Tfrm_param.dxDBGrid1ChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if dmseat.aq_param.RecordCount=0 then exit;
  id:=dmseat.aq_param.fieldbyname('id').asinteger;
end;



end.
