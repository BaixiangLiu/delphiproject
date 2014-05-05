unit unit_register;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids,
  Buttons, jpeg;

type
  Tfrm_register = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edt_capitalname: TEdit;
    edt_capitaltype: TEdit;
    edt_producer: TEdit;
    edt_country: TEdit;
    edt_value: TEdit;
    edt_capitalnumber: TEdit;
    edt_usedbyorg: TEdit;
    edt_usedbyone: TEdit;
    edt_manager: TEdit;
    edt_place: TEdit;
    edt_usedyears: TEdit;
    edt_source: TEdit;
    edt_discardyears: TEdit;
    edt_buydate: TEdit;
    lbl_position: TLabel;
    Label2: TLabel;
    Image1: TImage;
    sbtn_adding: TSpeedButton;
    sbtn_refresh: TSpeedButton;
    sbtn_modify: TSpeedButton;
    sbtn_delete: TSpeedButton;
    sbtn_prior: TSpeedButton;
    sbtn_first: TSpeedButton;
    sbtn_next: TSpeedButton;
    sbtn_last: TSpeedButton;
    sbtn_exit: TSpeedButton;

    procedure FormShow(Sender: TObject);


   

  


    procedure edt_capitalnameKeyPress(Sender: TObject; var Key: Char);
    procedure edt_capitaltypeKeyPress(Sender: TObject; var Key: Char);
    procedure edt_producerKeyPress(Sender: TObject; var Key: Char);
    procedure edt_buydateKeyPress(Sender: TObject; var Key: Char);
    procedure edt_countryKeyPress(Sender: TObject; var Key: Char);
    procedure edt_valueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_capitalnumberKeyPress(Sender: TObject; var Key: Char);
    procedure edt_usedbyorgKeyPress(Sender: TObject; var Key: Char);
    procedure edt_usedbyoneKeyPress(Sender: TObject; var Key: Char);
    procedure edt_managerKeyPress(Sender: TObject; var Key: Char);
    procedure edt_placeKeyPress(Sender: TObject; var Key: Char);
    procedure edt_usedyearsKeyPress(Sender: TObject; var Key: Char);
    procedure edt_sourceKeyPress(Sender: TObject; var Key: Char);
    procedure edt_discardyearsKeyPress(Sender: TObject; var Key: Char);
    procedure sbtn_addingClick(Sender: TObject);
    procedure sbtn_refreshClick(Sender: TObject);
    procedure sbtn_modifyClick(Sender: TObject);
    procedure sbtn_priorClick(Sender: TObject);
    procedure sbtn_firstClick(Sender: TObject);
    procedure sbtn_nextClick(Sender: TObject);
    procedure sbtn_lastClick(Sender: TObject);

    procedure sbtn_exitClick(Sender: TObject);
      
  private
   { Private declarations }
  public
    procedure showdata; { Public declarations }
  end;
 
var
  frm_register: Tfrm_register;

implementation

uses  unit_main;

{$R *.dfm}

procedure Tfrm_register.FormShow(Sender: TObject);
 begin
edt_capitalname.SetFocus;
if frm_main.ADOTable1.Recordset.RecordCount<1 then exit;
lbl_position.Caption:=inttostr(frm_main.ADOTable1.Recordset.AbsolutePosition)+'/'+
                      inttostr(frm_main.ADOTable1.Recordset.RecordCount);
end;

procedure tfrm_register.showdata;
begin
with frm_main.adoTable1 do
begin

edt_capitalname.Text:=vartostr(fieldvalues['固定资产名称']);
edt_capitaltype.Text:=vartostr(fieldvalues['固定资产型号']);
edt_producer.Text:=vartostr(fieldvalues['制造商']);
edt_country.Text:=vartostr(fieldvalues['国家或地区']);
edt_buydate.Text:=vartostr(fieldvalues['购买时间']);
edt_value.Text:=vartostr(fieldvalues['单价']);
edt_capitalnumber.Text:=vartostr(fieldvalues['数量']);
edt_usedbyorg.Text:=vartostr(fieldvalues['使用单位']);
edt_usedbyone.Text:=vartostr(fieldvalues['使用人']);
edt_manager.Text:=vartostr(fieldvalues['管理员']);
edt_place.Text:=vartostr(fieldvalues['放置地点']);
edt_usedyears.Text:=vartostr(fieldvalues['已使用年限']);
edt_source.Text:=vartostr(fieldvalues['来源']);
edt_discardyears.Text:=vartostr(fieldvalues['报销年限']);

end;
end;















procedure Tfrm_register.edt_capitalnameKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_capitaltype.SetFocus;
end;

procedure Tfrm_register.edt_capitaltypeKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_producer.SetFocus;
end;

procedure Tfrm_register.edt_producerKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_country.SetFocus;
end;

procedure Tfrm_register.edt_buydateKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_value.SetFocus;
end;

procedure Tfrm_register.edt_countryKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_buydate.SetFocus;
end;

procedure Tfrm_register.edt_valueKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
edt_capitalnumber.SetFocus;
end;

procedure Tfrm_register.edt_capitalnumberKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_usedbyorg.SetFocus;
end;

procedure Tfrm_register.edt_usedbyorgKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_usedbyone.SetFocus;
end;

procedure Tfrm_register.edt_usedbyoneKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_manager.SetFocus;
end;

procedure Tfrm_register.edt_managerKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_place.SetFocus;
end;

procedure Tfrm_register.edt_placeKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
edt_usedyears.SetFocus;
end;

procedure Tfrm_register.edt_usedyearsKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
edt_source.SetFocus;
end;

procedure Tfrm_register.edt_sourceKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
edt_discardyears.SetFocus;
end;

procedure Tfrm_register.edt_discardyearsKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
sbtn_refresh.Click;
end;

procedure Tfrm_register.sbtn_addingClick(Sender: TObject);

var i:integer;
begin
for i:=0 to componentcount-1 do
begin
if components[i] is Tedit then
begin
(components[i] as Tedit).Enabled:=true;
end;
end;
sbtn_refresh.Enabled:=true;
sbtn_adding.Enabled:=true;
edt_capitalname.SetFocus;

edt_capitalname.Text:='';
edt_capitaltype.Text:='';
edt_producer.Text:='';
edt_buydate.Text:='';
edt_value.Text:='';
edt_capitalnumber.Text:='';
edt_country.Text:='';
edt_usedbyorg.Text:='';
edt_usedbyone.Text:='';
edt_manager.Text:='';
edt_place.Text:='';
edt_usedyears.Text:='';
edt_source.Text:='';
edt_discardyears.Text:='';

end;


procedure Tfrm_register.sbtn_refreshClick(Sender: TObject);
var
flag:boolean;
begin

flag:=true;
if edt_capitalname.Text='' then flag:=false;
if edt_capitaltype.Text='' then flag:=false;
if edt_producer.Text='' then flag:=false;
if edt_country.Text='' then flag:=false;
if edt_buydate.Text='' then flag:=false;
if edt_value.Text='' then flag:=false;
if edt_capitalnumber.Text='' then flag:=false;
if edt_usedbyorg.Text='' then flag:=false;
if edt_usedbyone.Text='' then flag:=false;
if edt_place.Text='' then flag:=false;
if edt_usedyears.Text='' then flag:=false;
if edt_source.Text='' then  flag:=false;
if edt_discardyears.Text='' then flag:=false;

if not flag then
begin
showmessage('请输入完整的信息');

sbtn_refresh.Enabled:=true;
//btn_adding.Enabled:=true;
end
else
begin
sbtn_refresh.Enabled:=false;
sbtn_adding.Enabled:=true;
edt_capitalname.SetFocus;
with frm_main.adoTable1 do
begin
append;

fieldvalues['固定资产名称']:=edt_capitalname.Text;
fieldvalues['固定资产型号']:=edt_capitaltype.Text;
fieldvalues['制造商']:=edt_producer.Text;
fieldvalues['国家或地区']:=edt_country.Text;
fieldvalues['购买时间']:=edt_buydate.Text;
fieldvalues['单价']:=edt_value.Text;
fieldvalues['数量']:=edt_capitalnumber.Text;
fieldvalues['使用单位']:=edt_usedbyorg.Text;
fieldvalues['使用人']:=edt_usedbyone.Text;
fieldvalues['管理员']:=edt_manager.Text;
fieldvalues['放置地点']:=edt_place.Text;
fieldvalues['已使用年限']:=edt_usedyears.Text;
fieldvalues['来源']:=edt_source.Text;
fieldvalues['报销年限']:=edt_discardyears.Text;
post;
refresh;
end;
showmessage('资料添加成功!');
sbtn_last.Click;
end;
end;
procedure Tfrm_register.sbtn_modifyClick(Sender: TObject);
begin
frm_main.adoTable1.Edit;
with frm_main.adoTable1 do
begin
fieldvalues['固定资产名称']:=edt_capitalname.Text;
fieldvalues['固定资产型号']:=edt_capitaltype.Text;
fieldvalues['制造商']:=edt_producer.Text;
fieldvalues['国家或地区']:=edt_country.Text;
fieldvalues['购买时间']:=edt_buydate.Text;
fieldvalues['单价']:=edt_value.Text;
fieldvalues['数量']:=edt_capitalnumber.Text;
fieldvalues['使用单位']:=edt_usedbyorg.Text;
fieldvalues['使用人']:=edt_usedbyone.Text;
fieldvalues['管理员']:=edt_manager.Text;
fieldvalues['放置地点']:=edt_place.Text;
fieldvalues['已使用年限']:=edt_usedyears.Text;
fieldvalues['来源']:=edt_source.Text;
fieldvalues['报销年限']:=edt_discardyears.Text;
end;
frm_main.adoTable1.Post;
frm_main.ADOTable1.Refresh;
showmessage('你已经修改成功!');
end;

procedure Tfrm_register.sbtn_priorClick(Sender: TObject);
begin
if frm_main.adotable1.Recordset.RecordCount<1 then exit;
if not frm_main.adoTable1.Bof then
begin
frm_main.adoTable1.Prior;
sbtn_next.Enabled:=true;
sbtn_last.Enabled:=true;
end
else
begin
frm_main.adoTable1.First;
sbtn_prior.Enabled:=false;
sbtn_first.Enabled:=false;
sbtn_next.Enabled:=true;
sbtn_last.Enabled:=true;
end;
if frm_main.adoTable1.Bof then
begin
frm_main.adoTable1.First;
sbtn_prior.Enabled:=false;
sbtn_first.Enabled:=false;
sbtn_next.Enabled:=true;
sbtn_last.Enabled:=true;
end;
showdata;
lbl_position.Caption:=inttostr(frm_main.ADOTable1.Recordset.AbsolutePosition)+'/'+
                      inttostr(frm_main.ADOTable1.Recordset.RecordCount);
end;

procedure Tfrm_register.sbtn_firstClick(Sender: TObject);
begin
sbtn_first.Enabled:=false;
sbtn_prior.Enabled:=false;
sbtn_next.Enabled:=true;
sbtn_last.Enabled:=true;
if frm_main.adotable1.Recordset.RecordCount<1 then exit;
frm_main.adoTable1.First;
showdata;
lbl_position.Caption:=inttostr(frm_main.ADOTable1.Recordset.AbsolutePosition)+'/'+
                      inttostr(frm_main.ADOTable1.Recordset.RecordCount);
end;

procedure Tfrm_register.sbtn_nextClick(Sender: TObject);
begin
if frm_main.adotable1.Recordset.RecordCount<1 then exit;
if not frm_main.ADOTable1.Eof then
begin
frm_main.adoTable1.Next;
sbtn_first.Enabled:=true;
sbtn_prior.Enabled:=true;
end
else
begin
frm_main.ADOTable1.Last;
sbtn_last.Enabled:=false;
sbtn_next.Enabled:=false;
sbtn_prior.Enabled:=true;
sbtn_first.Enabled:=true;
end;
if frm_main.ADOTable1.Eof then
begin
frm_main.ADOTable1.Last;
sbtn_last.Enabled:=false;
sbtn_next.Enabled:=false;
sbtn_prior.Enabled:=true;
sbtn_first.Enabled:=true;
end;
showdata;
lbl_position.Caption:=inttostr(frm_main.ADOTable1.Recordset.AbsolutePosition)+'/'+
                      inttostr(frm_main.ADOTable1.Recordset.RecordCount);
end;

procedure Tfrm_register.sbtn_lastClick(Sender: TObject);
begin
sbtn_prior.Enabled:=true;
sbtn_first.Enabled:=true;
sbtn_last.Enabled:=false;
sbtn_next.Enabled:=false;
if frm_main.adotable1.Recordset.RecordCount<1 then exit;
frm_main.adoTable1.Last;
showdata;
lbl_position.Caption:=inttostr(frm_main.ADOTable1.Recordset.AbsolutePosition)+'/'+
                      inttostr(frm_main.ADOTable1.Recordset.RecordCount);
end;


procedure Tfrm_register.sbtn_exitClick(Sender: TObject);
begin
close;
end;

end.
