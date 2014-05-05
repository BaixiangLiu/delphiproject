unit unit_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids, ComCtrls,
  StdCtrls, ToolWin, Menus, ADODB;

type
  Tfrm_main = class(TForm)
    MainMenu1: TMainMenu;
    f1: TMenuItem;
    N1: TMenuItem;
    X1: TMenuItem;
    I1: TMenuItem;
    N2: TMenuItem;
    V1: TMenuItem;
    N3: TMenuItem;
    S1: TMenuItem;
    I2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    N9: TMenuItem;
    timer_update: TTimer;
    Timer1: TTimer;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    SaveDialog1: TSaveDialog;
    N10: TMenuItem;
    procedure X1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timer_updateTimer(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

uses unit_register,  unit_query, unit_reporter,
  unit_counter;

{$R *.dfm}

procedure Tfrm_main.X1Click(Sender: TObject);
begin
button6.Click;
end;

procedure Tfrm_main.N2Click(Sender: TObject);
begin
button1.Click;
end;

procedure Tfrm_main.N3Click(Sender: TObject);
begin
button2.Click;
end;

procedure Tfrm_main.N9Click(Sender: TObject);
begin
frm_register.sbtn_adding.Enabled:=false;
frm_register.sbtn_refresh.Enabled:=false;
frm_register.sbtn_prior.Enabled:=true;
frm_register.sbtn_first.Enabled:=true;
frm_register.sbtn_next.Enabled:=true;
frm_register.sbtn_last.Enabled:=true;
frm_register.sbtn_modify.Enabled:=true;
frm_register.sbtn_delete.Enabled:=true;
frm_register.showdata;
frm_register.ShowModal;
end;

procedure Tfrm_main.Button6Click(Sender: TObject);
begin
frm_main.ADOTable1.Close;

close;
end;

procedure Tfrm_main.Button1Click(Sender: TObject);
var i:integer;
begin

for i:=0 to componentcount-1 do
begin
if components[i] is Tedit then
begin
(components[i] as Tedit).Text:='';
end;
end;
frm_register.sbtn_modify.Enabled:=false;
frm_register.sbtn_delete.Enabled:=false;
frm_register.sbtn_prior.Enabled:=false;
frm_register.sbtn_first.Enabled:=false;
frm_register.sbtn_next.Enabled:=false;
frm_register.sbtn_last.Enabled:=false;
frm_register.sbtn_adding.Enabled:=true;
frm_register.sbtn_refresh.Enabled:=true;
frm_register.ShowModal;
end;

procedure Tfrm_main.Button2Click(Sender: TObject);
begin
 frm_register.sbtn_prior.Enabled:=true;
 frm_register.sbtn_first.Enabled:=true;
 frm_register.sbtn_next.Enabled:=true;
 frm_register.sbtn_last.Enabled:=true;
 frm_register.sbtn_adding.Enabled:=false;
 frm_register.sbtn_delete.Enabled:=false;
 frm_register.sbtn_refresh.Enabled:=false;
 frm_register.sbtn_modify.Enabled:=false;
 frm_register.showdata;
 frm_register.ShowModal;
end;

procedure Tfrm_main.N10Click(Sender: TObject);
var fromdb,desdb,frompx,despx:string;
begin
savedialog1.Title:='请输入数据库名,以..mdb结尾';
if savedialog1.Execute then
begin
if fileexists(savedialog1.FileName) then
begin
showmessage('数据库已存在!请从新设定文件名');
N10Click(sender);
end
else
begin
fromdb:=extractfilepath(paramstr(0))+'pp.mdb';
desdb:=savedialog1.FileName;
copyfile(pchar(fromdb),pchar(desdb),true);
end;

end;

end;

procedure Tfrm_main.N1Click(Sender: TObject);
begin
frm_main.ADOTable1.Edit;
frm_main.ADOTable1.Post;
frm_main.ADOTable1.Refresh;
showmessage('当前修改已经保存');
end;

procedure Tfrm_main.N6Click(Sender: TObject);
begin
button2.Click;
end;

procedure Tfrm_main.N5Click(Sender: TObject);
begin
button3.Click;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=\\A615\数据库文件\固定资产数据库\pp.mdb;Persist Security Info=False;jet oledb:database password=80513';
ADOConnection1.Connected:=true;
adotable1.TableName:='capital';

ADOTable1.Active:=true;
frm_counter.Visible:=false;
timer_update.Enabled:=true;
timer1.Enabled:=true;

end;

procedure Tfrm_main.timer_updateTimer(Sender: TObject);
var
strtmp:string;
begin
statusbar1.Panels[1].Text:='   总共有物品:'+inttostr(frm_main.ADOTable1.Recordset.RecordCount)+'件(个)';
Strtmp:=FormatDateTime('YYYY',Date)+'年'+FormatDateTime('MM',Date)+'月'+FormatDateTime('DD',Date)+'日';
case dayofweek(now) of
1:begin
                        Strtmp:=Strtmp+' 星期日';
                end;
                2:begin
                        Strtmp:=Strtmp+' 星期一';
                end;
                3:begin
                        Strtmp:=Strtmp+' 星期二';
                end;
                4:begin
                        Strtmp:=Strtmp+' 星期三';
                end;
                5:begin
                        Strtmp:=Strtmp+' 星期四';
                end;
                6:begin
                        Strtmp:=Strtmp+' 星期五';
                end;
                7:begin
                        Strtmp:=Strtmp+' 星期六';
                end;
        end;
        statusbar1.Panels[2].Text:='   '+strtmp;
        statusbar1.Panels[3].Text:='   '+formatdatetime('hh:mm:ss',now);
end;

procedure Tfrm_main.N8Click(Sender: TObject);
begin
button5.Click;
end;

procedure Tfrm_main.N7Click(Sender: TObject);
begin
button4.Click;
end;

procedure Tfrm_main.Button4Click(Sender: TObject);
begin
frm_counter.ADOTable1.Connection:=adoconnection1;
frm_counter.ADOTable1.TableName:='capital';
frm_counter.adotable1.Active:=true;
//frm_counter.ADOtable1.Refresh;
frm_counter.QuickRep1.Preview;
frm_counter.Visible:=false;
end;

procedure Tfrm_main.Button5Click(Sender: TObject);
begin

frm_reporter.QuickRep1.Preview;
end;

procedure Tfrm_main.Button3Click(Sender: TObject);
begin

frm_query.ShowModal;
end;

procedure Tfrm_main.Timer1Timer(Sender: TObject);
begin
if ADOTable1.Recordset.RecordCount<1 then
begin
timer1.Enabled:=false;
showmessage('数据库为空，请先登记！');

end;
end;

end.
