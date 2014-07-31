unit eseatclasses;

interface
uses Windows, Messages, SysUtils, Classes, Dialogs,ADOdb, db;

type
  Tmeetingroom=class(Tobject)
  private
    fid:integer;
    fname:string;
    fname_py:string;
    faddress:string;
    fcapacity:integer;
    fleader:integer;
    fstatus:string;
    fiscomplete:boolean;
    procedure clearf;
  public
    property id:integer read fid write fid;
    property name:string read fname write fname;
    property name_py:string read fname_py write fname_py;
    property address:string read faddress write faddress;
    property capacity:integer read fcapacity write fcapacity;
    property leader:integer read fleader write fleader;
    property status:string read fstatus write fstatus;
    property iscomplete:boolean read fiscomplete write fiscomplete;
    constructor Create(AOwner: TComponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem:integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
    procedure applymodify;
    procedure generateseat(meetingroomid:integer);
    procedure cancelseat(meetingroomid:integer);
  end;
  
  Tmeeting=class(Tobject)
  private
    fid:integer;
    fname:string;
    fname_py:string;
    fcapacity:integer;
    fleader:integer;
    fstatus:string;
    fmeetingroomid:integer;
    fopendate:Tdatetime;
    fopentime:string;
    procedure clearf;

  public
    property id:integer read fid write fid;
    property name:string read fname write fname;
    property name_py:string read fname_py write fname_py;
    property capacity:integer read fcapacity write fcapacity;
    property leader:integer read fleader write fleader;
    property status:string read fstatus write fstatus;
    property meetingroomid:integer read fmeetingroomid write fmeetingroomid;
    property opendate:Tdatetime read fopendate write fopendate;
    property opentime:string read fopentime write fopentime;
    constructor Create(AOwner: TComponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem: integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
    function haspaixi(id:integer):boolean;
    procedure paixi(meetingid:integer);
    procedure applymodify;
  end;

  Tmeetingpeople=class(Tobject)
  private
    fid:integer;
    fname:string;
    fname_py:string;
    fcareer:string;
    fgrade:string;
    fstatus:string;
    procedure clearf;

  public
    property id:integer read fid write fid;
    property name:string read fname write fname;
    property name_py:string read fname_py write fname_py;
    property status:string read fstatus write fstatus;
    property career:string read fcareer write fcareer;
    property grade:string read fgrade write fgrade;
    constructor Create(AOwner: TComponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem: integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
  end;
  Tmeeting_people=class(Tobject)
  private
    fid:integer;
    fmeetingid:integer;
    fpeopleid:integer;
    farea: string;
    fdisplayname:string;
    procedure clearf;
  public
    property id :integer read fid write fid;
    property meetingid:integer read fmeetingid write fmeetingid;
    property peopleid:integer read fpeopleid write fpeopleid;
    property area:string read farea write farea;
    property displayname:string read fdisplayname write fdisplayname;
    constructor create(AOwner:Tcomponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem:integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
    procedure applymodify;
    PROCEdure deleterecord(id:integer);
  end;
  Tparamlist=class(Tobject)
  private
    fid:integer;
    fclass_id:string;
    fparam_id:string;
    fparam_name:string;
    fdescript:string;
    fremarks:string;
    procedure clearf;
  public
    property id :integer read fid write fid;
    property class_id:string read fclass_id write fclass_id;
    property param_id:string read fparam_id write fparam_id;
    property param_name:string read fparam_name write fparam_name;
    property descript:string read fdescript write fdescript;
    property remarks:string read fremarks write fremarks;
    constructor create(AOwner:Tcomponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem:integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
    procedure delrecord(id:integer);
    procedure applymodify;
  end;
  Troomtable=class(Tobject)
  private
    fid:integer;
    fmeetingroom_id:integer;
    ftable_id:integer;
    ftable_type:string;
    fpeoplecount:integer;
    farea:string;
    procedure clearf;
  public
    property id:integer read fid write fid;
    property meetingroom_id:integer read fmeetingroom_id write fmeetingroom_id;
    property table_id:integer read ftable_id write ftable_id;
    property table_type:string read ftable_type write ftable_type;
    property peoplecount:integer read fpeoplecount write fpeoplecount;
    property area:string read farea write farea;
    constructor Create(AOwner: TComponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem:integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
    procedure deleterecord(id: integer);
    procedure applymodify;
    
  end;

  Tseat=class(Tobject)
  private
    fid:integer;
    fseatid:integer;
    ftableid:integer;
    procedure clearf;
  public
    property id:integer read fid write fid;
    property seatid:integer read fseatid write fseatid;
    property tableid:integer read ftableid write ftableid;
    constructor Create(AOwner: TComponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem:integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
  end;

  Tseat_people=class(Tobject)
  private
    fid:integer;
    fseat_id:integer;
    fpeopleid:integer;
    fhuiyiid:integer;
    procedure clearf;

  public
    property id:integer read fid write fid;
    property seat_id:integer read fseat_id write fseat_id;
    property peopleid:integer read fpeopleid write fpeopleid;
    property huiyiid:integer read fhuiyiid write fhuiyiid;
    constructor Create(AOwner: TComponent);
    procedure getdata(filterstr:string;resultdata:Tadoquery);
    function newitem:integer;
    procedure saveitem(query:Tadoquery;id:integer);
    function find(id:integer):boolean;
    function search(filterstr: string): boolean;
    procedure applymodify;
    procedure getseattable(meetingid:integer;resultdata:Tadoquery;area:string);
    procedure getcancelpeople(meetingid:integer;resultdata:Tadoquery;area:string);
  end;

implementation
uses global;

{ Tmeetingroom }

procedure Tmeetingroom.applymodify;
var
  lsqlstr:string;
begin
  if fiscomplete then
    lsqlstr:='update meetingroom set status='''+fstatus+''',iscomplete=''1'' where id='''+inttostr(fid)+''''
  else
    lsqlstr:='update meetingroom set status='''+fstatus+''',iscomplete=''0'' where id='''+inttostr(fid)+'''' ;
  queryexec(tempquery1,lsqlstr);
end;

procedure Tmeetingroom.cancelseat(meetingroomid: integer);
begin
  queryexec(tempquery1,'delete from seat where tableid in (select id from room_table where meetingroom_id='''+inttostr(meetingroomid)+''')');
end;

procedure Tmeetingroom.clearf;
begin
  fid:=0;
  fname:='';
  fname_py:='';
  faddress:='';
  fcapacity:=0;
  fleader:=0;
  fstatus:='1';
  fiscomplete:=false;
end;

constructor Tmeetingroom.Create(AOwner: TComponent);
begin
  clearf;
end;

function Tmeetingroom.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from meetingroom where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fname:=fieldbyname('name').asstring;
    fname_py:=fieldbyname('name_py').asstring;
    faddress:=fieldbyname('address').asstring;
    fcapacity:=fieldbyname('capacity').asinteger;
    fleader:=fieldbyname('leader').asinteger;
    fstatus:=fieldbyname('status').asstring;
    fiscomplete:=fieldbyname('iscomplete').asboolean;
  end;
  result:=true;
end;



procedure Tmeetingroom.generateseat(meetingroomid: integer);
var i,maxid:integer;
    lsqltext:string;
begin
  queryopen(tempquery1,'select * from room_table where meetingroom_id='''+inttostr(meetingroomid)+'''');
  tempquery1.First;
  while not tempquery1.Eof do
  begin
    for i:=1 to tempquery1.fieldbyname('peoplecount').asinteger do
    begin
      queryopen(tempquery2,'select coalesce(max(id),0) maxid from seat');
      maxid:=tempquery2.fieldbyname('maxid').asinteger+1;
      lsqltext:='insert into seat(id,'
                                +'tableid,'
                                +'seatid) values(:id,'
                                                +':tableid,'
                                                +':seatid)';
      with tempquery2 do
      begin
        close;
        sql.clear;
        sql.add(lsqltext);
        Parameters.ParamByName('id').Value:=maxid;
        Parameters.ParamByName('tableid').value:=tempquery1.fieldbyname('id').asinteger;
        Parameters.ParamByName('seatid').Value:=i;
        try
          execsql;
        except
        end;
      end;
    end;
    tempquery1.Next;
  end;
end;

procedure Tmeetingroom.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_meetingroom';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  queryopen(resultdata,sqlstr);
end;

function Tmeetingroom.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from meetingroom');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into meetingroom('
                  +'id,'
                  +'name,'
                  +'name_py,'
                  +'address,'
                  +'capacity,'
                  +'leader,'
                  +'status,'
                  +'iscomplete) values('
                                    +':id,'
                                    +':name,'
                                    +':name_py,'
                                    +':address,'
                                    +':capacity,'
                                    +':leader,'
                                    +':status,'
                                    +':iscomplete)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('name').value:='';
  Parameters.ParamByName('name_py').Value:='';
  Parameters.ParamByName('address').Value:='';
  Parameters.ParamByName('capacity').Value:=0;
  Parameters.ParamByName('leader').Value:=0;
  Parameters.ParamByName('status').Value:='1';
  Parameters.ParamByName('iscomplete').Value:=false;
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Tmeetingroom.saveitem(query:Tadoquery;id:integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('name')>-1 then
    if fname<>fieldbyname('name').asString then
      lSqlText:=lSqlText+'name=:name,';
  if fieldlist.IndexOf('name_py')>-1 then
    if fname_py<>fieldbyname('name_py').asString then
      lSqlText:=lSqlText+'name_py=:name_py,';
  if fieldlist.IndexOf('address')>-1 then
    if faddress<>fieldbyname('address').asString then
      lSqlText:=lSqlText+'address=:address,';
  if fieldlist.IndexOf('capacity')>-1 then
    if fcapacity<>fieldbyname('capacity').asinteger then
      lSqlText:=lSqlText+'capacity=:capacity,';
  if fieldlist.IndexOf('leader')>-1 then
    if fleader<>fieldbyname('leader').asinteger then
      lSqlText:=lSqlText+'leader=:leader,';
  if fieldlist.IndexOf('status')>-1 then
    if fstatus<>fieldbyname('status').asstring then
      lSqlText:=lSqlText+'status=:status,';
  if fieldlist.IndexOf('iscomplete')>-1 then
    if fiscomplete<>fieldbyname('iscomplete').asboolean then
      lSqlText:=lSqlText+'iscomplete=:iscomplete,';
  end;
  if lSqlText='' then exit;
  lSqlText:='update meetingroom set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

{ Tmeetingpeople }

procedure Tmeetingpeople.clearf;
begin
  fid:=0;
  fname:='';
  fname_py:='';
  fcareer:='';
  fgrade:='';
  fstatus:='0';
end;

constructor Tmeetingpeople.Create(AOwner: TComponent);
begin
  clearf;
end;

function Tmeetingpeople.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from meetingpeople where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fname:=fieldbyname('name').asstring;
    fname_py:=fieldbyname('name_py').asstring;
    fcareer:=fieldbyname('career').asstring;
    fgrade:=fieldbyname('grade').asstring;

    fstatus:=fieldbyname('status').asstring;
  end;
  result:=true;
end;

procedure Tmeetingpeople.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_meetingpeople';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  queryopen(resultdata,sqlstr);
end;

function Tmeetingpeople.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from meetingpeople');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into meetingpeople('
                  +'id,'
                  +'name,'
                  +'name_py,'
                  +'career,'
                  +'grade,'
                  +'status) values('
                                    +':id,'
                                    +':name,'
                                    +':name_py,'
                                    +':career,'
                                    +':grade,'
                                    +':status)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('name').value:='';
  Parameters.ParamByName('name_py').Value:='';
  Parameters.ParamByName('career').Value:='';
  Parameters.ParamByName('grade').Value:='';
  Parameters.ParamByName('status').Value:='1';
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Tmeetingpeople.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('name')>-1 then
    if fname<>fieldbyname('name').asString then
      lSqlText:=lSqlText+'name=:name,';
  if fieldlist.IndexOf('name_py')>-1 then
    if fname_py<>fieldbyname('name_py').asString then
      lSqlText:=lSqlText+'name_py=:name_py,';
  if fieldlist.IndexOf('career')>-1 then
    if fcareer<>fieldbyname('career').asString then
      lSqlText:=lSqlText+'career=:career,';
  if fieldlist.IndexOf('grade')>-1 then
    if fgrade<>fieldbyname('grade').asstring then
      lSqlText:=lSqlText+'grade=:grade,';
  if fieldlist.IndexOf('status')>-1 then
    if fstatus<>fieldbyname('status').asstring then
      lSqlText:=lSqlText+'status=:status,';
  end;
  if lSqlText='' then exit;
  lSqlText:='update meetingpeople set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

{ Tmeeting }

procedure Tmeeting.applymodify;
var
  lsqlstr:string;
begin
    lsqlstr:='update meeting set status='''+fstatus+''' where id='''+inttostr(fid)+'''' ;
  queryexec(tempquery1,lsqlstr);
end;

procedure Tmeeting.clearf;
begin
   fid:=0;
   fname:='';
   fname_py:='';
   fcapacity:=0;
   fleader:=0;
   fstatus:='1';
   fmeetingroomid:=0;
   fopendate:=DATETIMENULL;
   fopentime:='';
end;

constructor Tmeeting.Create(AOwner: TComponent);
begin
  clearf;
end;

function Tmeeting.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from meeting where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fname:=fieldbyname('name').asstring;
    fname_py:=fieldbyname('name_py').asstring;
    fmeetingroomid:=fieldbyname('meetingroomid').asinteger;
    fcapacity:=fieldbyname('capacity').asinteger;
    fleader:=fieldbyname('leader').asinteger;
    fstatus:=fieldbyname('status').asstring;
    fopendate:=fieldbyname('opendate').asdatetime;
    fopentime:=fieldbyname('opentime').asstring;
  end;
  result:=true;
end;

procedure Tmeeting.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_meeting';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  queryopen(resultdata,sqlstr);
end;

function Tmeeting.haspaixi(id: integer): boolean;
begin
  queryopen(tempquery1,'select 1 from seat_people where huiyiid='''+inttostr(id)+'''');
  if tempquery1.RecordCount>0 then result:=true
  else
  result:=false;
end;

function Tmeeting.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from meeting');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into meeting('
                  +'id,'
                  +'name,'
                  +'name_py,'
                  +'meetingroomid,'
                  +'capacity,'
                  +'leader,'
            //      +'opendate,'
                  +'opentime,'
                  +'status) values('
                                    +':id,'
                                    +':name,'
                                    +':name_py,'
                                    +':meetingroomid,'
                                    +':capacity,'
                                    +':leader,'
                                 //   +':opendate,'
                                    +':opentime,'
                                    +':status)';


  with tempquery1 do
  begin
  close;                           
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('name').value:='';
  Parameters.ParamByName('name_py').Value:='';
  Parameters.ParamByName('meetingroomid').Value:=0;
  Parameters.ParamByName('capacity').Value:=0;
  Parameters.ParamByName('leader').Value:=0;
  Parameters.ParamByName('status').Value:='1';
 // Parameters.ParamByName('opendate').Value:=DATETIMENULL;
  Parameters.ParamByName('opentime').Value:='';
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Tmeeting.paixi(meetingid: integer);
var maxid:integer;
    lsqlstr:string;
begin
  queryopen(tempquery1,'select peopleid from meeting_people where meetingid='''+inttostr(meetingid)+''' and area=''领导区''');
  queryopen(tempquery2,'select a.id seatid from seat a,room_table b,meeting c where c.meetingroomid=b.meetingroom_id and a.tableid=b.id and b.area=''领导区'' and c.id='''+inttostr(meetingid)+'''');
  tempquery1.First;
  tempquery2.First;
  while not tempquery1.Eof do
  begin
    queryopen(tempquery3,'select coalesce(max(id),0) maxid from seat_people');
    maxid:=tempquery3.fieldbyname('maxid').asinteger+1;
    lsqlstr:='insert into seat_people(id,'
                                +'peopleid,'
                                +'seat_id,'
                                +'huiyiid) values(:id,'
                                                +':peopleid,'
                                                +':seat_id,'
                                                +':huiyiid)';
    with tempquery3 do
    begin
      close;
      sql.clear;
      sql.add(lsqlstr);
      Parameters.ParamByName('id').Value:=maxid;
      Parameters.ParamByName('peopleid').value:=tempquery1.fieldbyname('peopleid').asinteger;
      Parameters.ParamByName('seat_id').Value:=tempquery2.fieldbyname('seatid').asinteger;
      Parameters.Parambyname('huiyiid').value:=meetingid;
      try
        execsql;
      except
      end;
    end;
    tempquery1.Next;
    tempquery2.Next;
  end;
  queryopen(tempquery1,'select peopleid from meeting_people where meetingid='''+inttostr(meetingid)+''' and area=''普通区''');
  queryopen(tempquery2,'select a.id seatid from seat a,room_table b,meeting c where c.meetingroomid=b.meetingroom_id and a.tableid=b.id and b.area=''普通区'' and c.id='''+inttostr(meetingid)+'''');
  tempquery1.First;
  tempquery2.First;
  while not tempquery1.Eof do
  begin
    queryopen(tempquery3,'select coalesce(max(id),0) maxid from seat_people');
    maxid:=tempquery3.fieldbyname('maxid').asinteger+1;
    lsqlstr:='insert into seat_people(id,'
                                +'peopleid,'
                                +'seat_id,'
                                +'huiyiid) values(:id,'
                                                +':peopleid,'
                                                +':seat_id,'
                                                +':huiyiid)';
    with tempquery3 do
    begin
      close;
      sql.clear;
      sql.add(lsqlstr);
      Parameters.ParamByName('id').Value:=maxid;
      Parameters.ParamByName('peopleid').value:=tempquery1.fieldbyname('peopleid').asinteger;
      Parameters.ParamByName('seat_id').Value:=tempquery2.fieldbyname('seatid').asinteger;
      Parameters.Parambyname('huiyiid').value:=meetingid;
      try
        execsql;
      except
      end;
    end;
    tempquery1.Next;
    tempquery2.Next;
  end;
end;

procedure Tmeeting.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
  Hour, Min, Sec, MSec: Word;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('name')>-1 then
    if fname<>fieldbyname('name').asString then
      lSqlText:=lSqlText+'name=:name,';
  if fieldlist.IndexOf('name_py')>-1 then
    if fname_py<>fieldbyname('name_py').asString then
      lSqlText:=lSqlText+'name_py=:name_py,';
  if fieldlist.IndexOf('meetingroomid')>-1 then
    if fmeetingroomid<>fieldbyname('meetingroomid').asinteger then
      lSqlText:=lSqlText+'meetingroomid=:meetingroomid,';
  if fieldlist.IndexOf('capacity')>-1 then
    if fcapacity<>fieldbyname('capacity').asinteger then
      lSqlText:=lSqlText+'capacity=:capacity,';
  if fieldlist.IndexOf('leader')>-1 then
    if fleader<>fieldbyname('leader').asinteger then
      lSqlText:=lSqlText+'leader=:leader,';
  if fieldlist.IndexOf('status')>-1 then
    if fstatus<>fieldbyname('status').asstring then
      lSqlText:=lSqlText+'status=:status,';
  if fieldlist.IndexOf('opendate')>-1 then
    if fopendate<>fieldbyname('opendate').asdatetime then
      lSqlText:=lSqlText+'opendate=:opendate,';
  if fieldlist.IndexOf('opentime')>-1 then
    if fopentime<>fieldbyname('opentime').asstring then
      lSqlText:=lSqlText+'opentime=:opentime,';
  end;
  if lSqlText='' then exit;
  lSqlText:='update meeting set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
     {
      if parameters[i].name='opentime' then
      begin
      DecodeTime(query.fieldvalues[parameters[i].name],Hour, Min, Sec, MSec);
      parameters[i].Value:=EncodeTime(Hour, Min, Sec, MSec);
      end
      else
      }
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

{ Tmeeting_people }

procedure Tmeeting_people.applymodify;
var lsqltext:string;
begin
  lsqltext:='update meeting_people set peopleid='''+inttostr(fpeopleid)+''',displayname='''+fdisplayname+''',meetingid='''+inttostr(fmeetingid)+''',area='''+farea+''' where id='''+inttostr(fid)+'''';
  queryexec(tempquery1,lsqltext);
end;
procedure Tmeeting_people.clearf;
begin
  fid:=0;
  fmeetingid:=0;
  fpeopleid:=0;
  farea:='';
  fdisplayname:='';
end;

constructor Tmeeting_people.create(AOwner: Tcomponent);
begin
  clearf;
end;

procedure Tmeeting_people.deleterecord(id: integer);
begin
  queryexec(tempquery1,'delete from meeting_people where id='''+inttostr(id)+'''');
end;

function Tmeeting_people.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from meeting_people where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fmeetingid:=fieldbyname('meetingid').asinteger;
    fpeopleid:=fieldbyname('peopleid').asinteger;
    farea:=fieldbyname('area').asstring;
    fdisplayname:=fieldbyname('displayname').asstring;
  end;
  result:=true;
end;

procedure Tmeeting_people.getdata(filterstr: string;
  resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_meeting_people';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  queryopen(resultdata,sqlstr);
end;



function Tmeeting_people.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from meeting_people');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into meeting_people('
                  +'id,'
                  +'meetingid,'
                  +'peopleid,'
                  +'area,'
                  +'displayname) values('
                                    +':id,'
                                    +':meetingid,'
                                    +':peopleid,'

                                    +':area,'
                                    +':displayname)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('meetingid').value:=0;
  Parameters.ParamByName('peopleid').Value:=0;
  Parameters.ParamByName('area').Value:='';
  Parameters.ParamByName('displayname').Value:='';
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;


procedure Tmeeting_people.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('meetingid')>-1 then
    if fmeetingid<>fieldbyname('meetingid').asinteger then
      lSqlText:=lSqlText+'meetingid=:meetingid,';
  if fieldlist.IndexOf('peopleid')>-1 then
    if fpeopleid<>fieldbyname('peopleid').asinteger then
      lSqlText:=lSqlText+'peopleid=:peopleid,';
  if fieldlist.IndexOf('area')>-1 then
    if farea<>fieldbyname('area').asstring then
      lSqlText:=lSqlText+'area=:area,';
  if fieldlist.IndexOf('displayname')>-1 then
    if fdisplayname<>fieldbyname('displayname').asstring then
      lSqlText:=lSqlText+'displayname=:displayname,';
  end;
  if lSqlText='' then exit;
  lSqlText:='update meeting_people set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;


{ Tparamlist }

procedure Tparamlist.applymodify;
var lsqltext:string;
begin
  lsqltext:='update paramlist set class_id='''+fclass_id+''',param_id='''+fparam_id+''',param_name='''+fparam_name+''',remarks='''+fremarks+''' where id='''+inttostr(fid)+'''';
  queryexec(tempquery1,lsqltext);
end;


procedure Tparamlist.clearf;
begin
  fid:=0;
  fclass_id:='';
  fparam_id:='';
  fparam_name:='';
  fremarks:='';
end;

constructor Tparamlist.create(AOwner: Tcomponent);
begin
  clearf;
end;

procedure Tparamlist.delrecord(id: integer);
begin
  queryexec(tempquery1,'delete from paramlist where id='''+inttostr(id)+'''');
end;

function Tparamlist.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from paramlist where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fclass_id:=fieldbyname('class_id').asstring;
    fparam_id:=fieldbyname('param_id').asstring;
    fparam_name:=fieldbyname('param_name').asstring;
    fremarks:=fieldbyname('remarks').asstring;
  end;
  result:=true;
end;

procedure Tparamlist.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from paramlist';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  queryopen(resultdata,sqlstr);
end;

function Tparamlist.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from paramlist');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into paramlist('
                  +'id,'
                  +'class_id,'
                  +'param_id,'
                  +'param_name,'
                  +'remarks) values('
                                    +':id,'
                                    +':class_id,'
                                    +':param_id,'
                                    +':param_name,'
                                    +':remarks)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('class_id').value:='';
  Parameters.ParamByName('param_id').Value:='';
  Parameters.ParamByName('param_name').Value:='';
  Parameters.ParamByName('remarks').Value:='';
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Tparamlist.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('class_id')>-1 then
    if fclass_id<>fieldbyname('class_id').asstring then
      lSqlText:=lSqlText+'class_id=:class_id,';
  if fieldlist.IndexOf('param_id')>-1 then
    if fparam_id<>fieldbyname('param_id').asstring then
      lSqlText:=lSqlText+'param_id=:param_id,';
  if fieldlist.IndexOf('param_name')>-1 then
    if fparam_name<>fieldbyname('param_name').asstring then
      lSqlText:=lSqlText+'param_name=:param_name,';
  if fieldlist.IndexOf('remarks')>-1 then
    if fremarks<>fieldbyname('remarks').asstring then
      lSqlText:=lSqlText+'remarks=:remarks,';

  end;
  if lSqlText='' then exit;
  lSqlText:='update paramlist set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

{ Tseat }

procedure Tseat.clearf;
begin
  fid:=0;
  fseatid:=0;
  ftableid:=0;
end;

constructor Tseat.Create(AOwner: TComponent);
begin
  clearf;
end;

function Tseat.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from seat where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fseatid:=fieldbyname('seatid').asinteger;
    ftableid:=fieldbyname('tableid').asinteger;
  end;
  result:=true;
end;

procedure Tseat.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_seat';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  queryopen(resultdata,sqlstr);
end;

function Tseat.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from seat');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into seat('
                  +'id,'
                  +'seatid,'
                  +'tableid) values('
                                    +':id,'
                                    +':seatid,'
                                    +':tableid)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('seatid').value:=0;
  Parameters.ParamByName('tableid').Value:=0;
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Tseat.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('seatid')>-1 then
    if fseatid<>fieldbyname('seatid').asinteger then
      lSqlText:=lSqlText+'seatid=:seatid,';
  if fieldlist.IndexOf('tableid')>-1 then
    if ftableid<>fieldbyname('tableid').asinteger then
      lSqlText:=lSqlText+'tableid=:tableid,';

  end;
  if lSqlText='' then exit;
  lSqlText:='update seat set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

{ Troomtable }

procedure Troomtable.clearf;
begin
  fid:=0;
  fmeetingroom_id:=0;
  fpeoplecount:=0;
  ftable_type:='';
  ftable_id:=0;
  farea:='';
end;

constructor Troomtable.Create(AOwner: TComponent);
begin
  clearf;
end;

procedure Troomtable.deleterecord(id:integer);
begin
  queryexec(tempquery1,'delete from room_table where id='''+inttostr(id)+'''');
end;

procedure Troomtable.applymodify;
var lsqltext:string;
begin
  lsqltext:='update room_table set meetingroom_id='''+inttostr(fmeetingroom_id)+''' where id='''+inttostr(fid)+'''';
  queryexec(tempquery1,lsqltext);
end;

function Troomtable.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from room_table where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fmeetingroom_id:=fieldbyname('meetingroom_id').asinteger;
    ftable_id:=fieldbyname('table_id').asinteger;
    fpeoplecount:=fieldbyname('peoplecount').asinteger;
    ftable_type:=fieldbyname('table_type').Asstring;
    farea:=fieldbyname('area').asstring;
  end;
  result:=true;
end;

procedure Troomtable.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_room_table';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
   queryopen(resultdata,sqlstr);
end;

function Troomtable.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from room_table');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into room_table('
                  +'id,'
                  +'meetingroom_id,'
                  +'table_id,'
                  +'peoplecount,'
                  +'table_type,'
                  +'area) values('
                                    +':id,'
                                    +':meetingroom_id,'
                                    +':table_id,'
                                    +':peoplecount,'
                                    +':table_type,'
                                    +':area)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('meetingroom_id').value:=0;
  Parameters.ParamByName('table_id').Value:=0;
  Parameters.ParamByName('peoplecount').Value:=0;
  Parameters.ParamByName('table_type').Value:='';
  Parameters.ParamByName('area').Value:='';
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Troomtable.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('meetingroom_id')>-1 then
    if fmeetingroom_id<>fieldbyname('meetingroom_id').asinteger then
      lSqlText:=lSqlText+'meetingroom_id=:meetingroom_id,';
  if fieldlist.IndexOf('table_id')>-1 then
    if ftable_id<>fieldbyname('table_id').asinteger then
      lSqlText:=lSqlText+'table_id=:table_id,';

  if fieldlist.IndexOf('peoplecount')>-1 then
    if fpeoplecount<>fieldbyname('peoplecount').asinteger then
      lSqlText:=lSqlText+'peoplecount=:peoplecount,';
  if fieldlist.IndexOf('table_type')>-1 then
    if ftable_type<>fieldbyname('table_type').asstring then
      lSqlText:=lSqlText+'table_type=:table_type,';
  if fieldlist.IndexOf('area')>-1 then
    if farea<>fieldbyname('area').asstring then
      lSqlText:=lSqlText+'area=:area,';
  end;
  if lSqlText='' then exit;
  lSqlText:='update room_table set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

{ Tseat_people }

procedure Tseat_people.clearf;
begin
  fid:=0;
  fpeopleid:=0;
  fseat_id:=0;
  fhuiyiid:=0;
end;

constructor Tseat_people.Create(AOwner: TComponent);
begin
  clearf;
end;

function Tseat_people.search(filterstr:string):boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from view_seat_people';
  if filterstr<>'' then
  lsqlstr:=lsqlstr+' where '+filterstr;
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fpeopleid:=fieldbyname('peopleid').asinteger;
    fseat_id:=fieldbyname('seat_id').asinteger;
    fhuiyiid:=fieldbyname('huiyiid').asinteger;
  end;
  result:=true;
end;

function Tseat_people.find(id: integer): boolean;
var
  lsqlstr:string;
begin
  result:=false;
  lsqlstr:='select * from seat_people where id='''+inttostr(id)+'''';
  queryopen(tempquery1,lsqlstr);
  with tempquery1 do
  begin
    fid:=fieldbyname('id').asinteger;
    fpeopleid:=fieldbyname('peopleid').asinteger;
    fseat_id:=fieldbyname('seat_id').asinteger;
    fhuiyiid:=fieldbyname('huiyiid').asinteger;
  end;
  result:=true;
end;

procedure Tseat_people.getdata(filterstr: string; resultdata: Tadoquery);
var sqlstr:string;
begin
  sqlstr:='select * from view_seat_people';
  if filterstr<>'' then
    sqlstr:=sqlstr+' where '+filterstr;
  sqlstr:=sqlstr+' order by table_id,seat_id';
  queryopen(resultdata,sqlstr);
end;

function Tseat_people.newitem: integer;
var maxid:integer;
    insertstr:string;
begin
  queryopen(tempquery1,'select coalesce(max(id),0) maxid from seat_people');
  maxid:=tempquery1.fieldbyname('maxid').asinteger+1;
  insertstr:='insert into seat_people('
                  +'id,'
                  +'seat_id,'
                  +'peopleid,'
                  +'huiyiid,) values('
                                    +':id,'
                                    +':seat_id,'
                                    +':peopleid,'
                                    +':huiyiid)';


  with tempquery1 do
  begin
  close;
  sql.clear;
  sql.add(insertstr);
  Parameters.ParamByName('id').Value:=maxid;
  Parameters.ParamByName('seat_id').value:=0;
  Parameters.ParamByName('peopleid').Value:=0;
  Parameters.ParamByName('huiyiid').value:=0;
  try
  execsql;
  result:=maxid;
  except
  result:=0;
  end;
  end;
end;

procedure Tseat_people.saveitem(query: Tadoquery; id: integer);
Var
  lSqlText : string;
  i:integer;
begin
  lSqlText:='';

  with Query do
  begin
  if fieldlist.IndexOf('seatid')>-1 then
    if fseat_id<>fieldbyname('seat_id').asinteger then
      lSqlText:=lSqlText+'seatid=:seatid,';
  if fieldlist.IndexOf('peopleid')>-1 then
    if fpeopleid<>fieldbyname('peopleid').asinteger then
      lSqlText:=lSqlText+'peopleid=:peopleid,';
  if fieldlist.IndexOf('huiyiid')>-1 then
    if fhuiyiid<>fieldbyname('huiyiid').asinteger then
      lSqlText:=lSqlText+'huiyiid=:huiyiid,';

  end;
  if lSqlText='' then exit;
  lSqlText:='update seat_people set '+lSqlText;
  delete(lSqlText,length(lSqlText),1);
  lSqlText:=lSqlText+' Where id=' + '''' + inttostr(id) + '''';
  with tempquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add(lSqlText);
    for i:=0 to parameters.Count-1 do
    begin
      parameters[i].Value:=query.fieldvalues[parameters[i].name];
    end;
    try
      ExecSQL ;
    except
    end;
  end;
end;

procedure Tseat_people.applymodify;
var lsqltext:string;
begin
  lsqltext:='update seat_people set peopleid='''+inttostr(fpeopleid)+''' where id='''+inttostr(fid)+'''';
  queryexec(tempquery1,lsqltext);
end;

procedure Tseat_people.getcancelpeople(meetingid:integer;resultdata: Tadoquery;area:string);
begin
  queryopen(resultdata,'select a.peopleid,b.name,a.displayname from meeting_people a,meetingpeople b where a.meetingid='''+inttostr(meetingid)+''' and a.area='''+area+''' and a.peopleid not in (select peopleid from seat_people where huiyiid='''+inttostr(meetingid)+''') and a.peopleid=b.id');
end;

procedure Tseat_people.getseattable(meetingid: integer;
  resultdata: Tadoquery; area: string);
var sqlstr:string;
begin
 // queryexec(resultdata,'print_seat '''+inttostr(meetingid)+''','''+area+'''');
 sqlstr:='select seatid,table_id,displayname from view_seat_people where huiyiid='''+inttostr(meetingid)+''' and area='''+area+''' order by table_id,seatid';
 queryopen(resultdata,sqlstr);
  //ResultData.Active:=true;
end;

end.
