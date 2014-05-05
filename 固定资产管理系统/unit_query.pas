unit unit_query;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, Buttons,
  jpeg;

type
  Tfrm_query = class(TForm)
    GroupBox1: TGroupBox;
    cmb_search: TComboBox;
    cmb_bijiao: TComboBox;
    edt_search: TEdit;

    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;

    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    sbtn_query: TSpeedButton;
    sbtn_exit: TSpeedButton;
    Image1: TImage;


    procedure cmb_searchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_searchKeyPress(Sender: TObject; var Key: Char);
    procedure sbtn_queryClick(Sender: TObject);
    procedure sbtn_exitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_query: Tfrm_query;

implementation

uses unit_main;



{$R *.dfm}



procedure Tfrm_query.cmb_searchChange(Sender: TObject);
begin
case cmb_search.ItemIndex of
0,1,2,3,5:
begin
cmb_bijiao.Style:=cssimple;
cmb_bijiao.Text:='=';
cmb_bijiao.Enabled:=false;
end;
 4,6,7:
begin
cmb_bijiao.Style:=csownerdrawfixed;
cmb_bijiao.Enabled:=true;
end;
end;
end;

procedure Tfrm_query.FormShow(Sender: TObject);
begin
cmb_search.ItemIndex:=0;
cmb_bijiao.Text:='=';
end;

procedure Tfrm_query.edt_searchKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
sbtn_query.Click;
end;

procedure Tfrm_query.sbtn_queryClick(Sender: TObject);
var
str,temp:string;
begin
case cmb_search.ItemIndex of
0,1,2,3:
begin

temp:='%'+trim(edt_search.Text)+'%';
temp:=''''+temp+'''';
str:='select * from capital';
str:=str+' where '+trim(cmb_search.Text);
str:=str+' like '+temp;
ADODataSet1.Active:=false;
ADODataSet1.CommandText:=str;
ADODataSet1.Active:=true;
end;
5:
begin

temp:=trim(edt_search.Text);
temp:=formatdatetime('yy-m-d',strtodatetime(temp));
str:='select * from capital';
str:=str+' where '+trim(cmb_search.Text);
str:=str+cmb_bijiao.Text+''''+temp+'''';
//str:=str+' order by '+temp+' desc';
ADODataSet1.Active:=false;
ADODataSet1.CommandText:=str;
ADODataSet1.Active:=true;
end;
4,6,7:
begin
temp:=trim(edt_search.Text);
str:='select * from capital';
str:=str+' where '+trim(cmb_search.Text);
str:=str+cmb_bijiao.Text+temp;
//str:=str+' order by '+temp+' desc';
ADODataSet1.Active:=false;
ADODataSet1.CommandText:=str;
ADODataSet1.Active:=true;
end;
end;
end;

procedure Tfrm_query.sbtn_exitClick(Sender: TObject);
begin
close;
end;

end.
