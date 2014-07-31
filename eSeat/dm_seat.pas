unit dm_seat;

interface

uses
  SysUtils, Classes, DB, ADODB, DBXpress, SqlExpr,inifiles;

type
  Tdmseat = class(TDataModule)
    seatconn: TADOConnection;
    aq_meetingroom: TADOQuery;
    ds_meetingroom: TDataSource;
    aq_meeting: TADOQuery;
    ds_meeting: TDataSource;
    aq_meetingpeople: TADOQuery;
    ds_meetingpeople: TDataSource;
    aq_param: TADOQuery;
    ds_param: TDataSource;
    aq_meeting_people: TADOQuery;
    ds_meeting_people: TDataSource;
    aq_room_table: TADOQuery;
    ds_room_table: TDataSource;
    aq_seat_people: TADOQuery;
    ds_seat_people: TDataSource;
    aq_cancelpeople: TADOQuery;
    ds_cancelpeople: TDataSource;
    aq_leaderpeople: TADOQuery;
    ds_leaderpeople: TDataSource;
    aq_seat: TADOQuery;
    ds_seat: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function connectdb(conn:Tadoconnection):boolean;
  end;

var
  dmseat: Tdmseat;

implementation

{$R *.dfm}
uses global;

procedure Tdmseat.DataModuleCreate(Sender: TObject);
begin
    tempquery1 := tadoquery.Create(self);
  tempquery1.connection:=seatconn;

  tempquery2 := tadoquery.Create(self);
  tempquery2.connection:=seatconn;

  tempquery3 := tadoquery.Create(self);
  tempquery3.connection:=seatconn;
end;

function Tdmseat.connectdb(conn:Tadoconnection):boolean;
  function generalconnstr(servername,dbname,username,password: string):string;
  begin
    result:='Provider=SQLOLEDB.1;Password='+password
          +';Persist Security Info=True;User ID='+username
          +';Initial Catalog='+dbname
          +';Data Source='+servername+';Auto Translate=False';
  end;
  function generalconnstrByWindowsAuthor(servername,dbname: string):string;
  begin
    result:='Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=True'
          +';Initial Catalog='+dbname
          +';Data Source='+servername+';Auto Translate=False';
  end;
var
   lf_dbini:Tinifile;
   servername,dbname,username,password,filename: string;
   sqlautority:boolean;
begin     
  filename:=inipath+'conn.ini';
  lf_dbini:=Tinifile.Create(filename);
  servername:=lf_dbini.ReadString('db','servername','');
  dbname:=lf_dbini.ReadString('db','dbname','');
  username:=lf_dbini.ReadString('db','username','');
  password:=lf_dbini.ReadString('db','password','');
  sqlautority:=lf_dbini.Readbool('conn','sqlautority',true);

  result:=true;
  conn.connected:=false;
  conn.LoginPrompt:=false;
  if (trim(servername)='') or (trim(dbname)='') then
  begin
    result:=false;
    lf_dbini.Free;
    exit;
  end;
  if sqlautority then  //SQLªÏ∫œ»œ÷§
  begin
    try
      conn.ConnectionString:=generalconnstr(servername,dbname, username,password);
      conn.Connected:=true;
    except
      result:=false;
    end;
  end
  else
  begin
    try
      conn.ConnectionString:=generalconnstrBywindowsauthor(servername,dbname);
      conn.Connected:=true;
    except
      result:=false;
    end;
  end;
  lf_dbini.Free;
end;

end.
