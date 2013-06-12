unit frmGangWay;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, DB, DBAccess, Ora, StdCtrls, ComCtrls, Grids, DBGrids, RzDBGrid,
    MemDS, RzEdit, Mask, Buttons, RzCmboBx, IniFiles;

type
    TfrmMainGangWay = class(TForm)
        OraSession1: TOraSession;
        StatusBar1: TStatusBar;
        OraQuery1: TOraQuery;
        OraDataSource1: TOraDataSource;
        gridResult: TRzDBGrid;
        GroupBox1: TGroupBox;
        btnQuery: TBitBtn;
        dtBegin: TRzDateTimeEdit;
        dtEnd: TRzDateTimeEdit;
        Label1: TLabel;
        Label2: TLabel;
        cbDev: TRzComboBox;
        Label3: TLabel;
        Label4: TLabel;
        edtName: TRzEdit;
        btnReport: TBitBtn;
        btnExport: TBitBtn;
        Memo1: TMemo;
        procedure FormCreate(Sender: TObject);
        procedure btnQueryClick(Sender: TObject);
        procedure btnExportClick(Sender: TObject);
        procedure btnReportClick(Sender: TObject);
        procedure FixDBGridColumnWidth(const DBGrid: TDBGrid);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmMainGangWay: TfrmMainGangWay;


procedure getList();
procedure getReport();

implementation

uses uDoorController, AES, FormWait, uIO;
{$R *.dfm}

procedure TfrmMainGangWay.FormCreate(Sender: TObject);
var
    yktServer: string;
    yktUser: string;
    yktPass: string;
begin


    if iniConfig = nil then
        iniConfig := TInifile.Create(ExtractFilePath(paramstr(0)) + '..\config\' + CONFIGFILE);

    APP_DEBUGMODE := iniConfig.ReadBool('yczn', 'debug', false);
    if APP_DEBUGMODE then begin
        yktServer := iniConfig.readstring('ykt', 'serverurl', '127.0.0.1:1521:yktdb');
        yktUser := iniConfig.readstring('ykt', 'user', 'ykt_cur');
        yktPass := iniConfig.readstring('ykt', 'pass', 'kingstar');
        iniConfig.WriteString('ykt', 'serverurl', EncryptString(Trim(yktServer), CryptKey));
        iniConfig.WriteString('ykt', 'user', EncryptString(Trim(yktUser), CryptKey));
        iniConfig.WriteString('ykt', 'pass', EncryptString(Trim(yktPass), CryptKey));
        iniConfig.WriteBool('yczn', 'debug', false);
    end
    else begin
        yktServer := trim(DecryptString(iniConfig.readstring('ykt', 'serverurl', '127.0.0.1:1521:yktdb'), CryptKey));
        yktUser := trim(DecryptString(iniConfig.readstring('ykt', 'user', 'ykt_cur'), CryptKey));
        yktPass := trim(DecryptString(iniConfig.readstring('ykt', 'pass', 'kingstar'), CryptKey));
    end;


    with OraSession1 do begin
        Options.Direct := true;
        Server := yktServer;
        UserName := yktUser;
        Password := yktPass;
        LoginPrompt := False;
        Connected := true;
        StatusBar1.Panels.Items[0].Text := 'database connected.';
    end;
end;

procedure TfrmMainGangWay.btnQueryClick(Sender: TObject);
begin
    {
    with TFromWaitThread.Create(getList, '正在查询，请稍后...') do begin
        FreeOnTerminate := True;
        Resume;
    end;
    }
    getList();
end;


procedure getList();
var
    sSql: string;
begin
    sSql := 'select a.transdate as 刷卡日期,' +
        ' a.transtime as 刷卡时间, ' +
        ' a.devphyid as 设备物理ID, ' +
        ' a.devseqno as 设备流水号, ' +
        ' a.cardno as 交易卡号, ' +
        ' a.stuempno as 学工号, ' +
        ' a.custname as 姓名, ' +
        ' a.transmark as 事件代码, ' +
        ' b.dictcaption as 说明, ' +
        ' t1.deptname as 部门或学院, ' +
        ' t1.classname as 班级, ' +
        ' t1.custtypename as 类别 ' +
        ' from ykt_cur.t_doordtl a left join ykt_cur.v_dictionary b on b.dicttype=86 and a.transmark=b.dictval ' +
        ' left join ( ' +
        '   select a.*,b.custtypename,c.feename,d.deptname from t_customer a ' +
        ' left join t_custtype b on a.custtype=b.custtype ' +
        ' left join t_feetype c on a.feetype=c.feetype ' +
        ' left join t_dept d on a.deptcode=d.deptcode ' +
        '   ) t1 on a.stuempno=t1.stuempno ' +
        ' where 1=1 ';

    if (frmMainGangWay.dtBegin.EditText <> '') then begin
        sSql := sSql + ' and transdate >= ''' + StringReplace(frmMainGangWay.dtBegin.EditText, '-', '', [rfReplaceAll]) + '''';
    end;

    if (frmMainGangWay.dtEnd.EditText <> '') then begin
        sSql := sSql + ' and transdate <= ''' + StringReplace(frmMainGangWay.dtEnd.EditText, '-', '', [rfReplaceAll]) + '''';
    end;


    if (frmMainGangWay.cbDev.Text <> '-') then begin
        sSql := sSql + ' and devphyid = ''' + frmMainGangWay.cbDev.Text + '''';
    end;

    if (frmMainGangWay.edtName.Text <> '') then begin
        sSql := sSql + ' and custname = ''' + frmMainGangWay.edtName.Text + '''';
    end;

    frmMainGangWay.memo1.Lines.Clear;
    frmMainGangWay.memo1.Lines.Add(sSql);
    with frmMainGangWay.OraQuery1 do begin
        close;
        SQL.Clear;
        SQL.Add(sSql);
        open;
        frmMainGangWay.StatusBar1.Panels.Items[3].Text := '记录数：' + IntToStr(RecordCount);
    end;
    //frmMainGangWay.FixDBGridColumnWidth(frmMainGangWay.gridResult);
end;


procedure getReport();
var
    sSql: string;
begin
    sSql := 'select a.transdate as 刷卡日期,' +
        ' a.transtime as 刷卡时间, ' +
        ' a.devphyid as 设备物理ID, ' +
        ' a.devseqno as 设备流水号, ' +
        ' a.cardno as 交易卡号, ' +
        ' a.stuempno as 学工号, ' +
        ' a.custname as 姓名, ' +
        ' a.transmark as 事件代码, ' +
        ' b.dictcaption as 说明 ' +
        ' from ykt_cur.t_doordtl a left join ykt_cur.v_dictionary b on b.dicttype=86 and a.transmark=b.dictval ' +
        ' where 1=1 ';

    if (frmMainGangWay.dtBegin.EditText <> '') then begin
        sSql := sSql + ' and transdate >= ''' + StringReplace(frmMainGangWay.dtBegin.EditText, '-', '', [rfReplaceAll]) + '''';
    end;

    if (frmMainGangWay.dtEnd.EditText <> '') then begin
        sSql := sSql + ' and transdate <= ''' + StringReplace(frmMainGangWay.dtEnd.EditText, '-', '', [rfReplaceAll]) + '''';
    end;


    if (frmMainGangWay.cbDev.Text <> '-') then begin
        sSql := sSql + ' and devphyid = ''' + frmMainGangWay.cbDev.Text + '''';
    end
    else begin
        sSql := sSql + ' and devphyid in (''59310'',''59332'',''59333'',''59357'',''59373'',''59469'' )';
    end;

    if (frmMainGangWay.edtName.Text <> '') then begin
        sSql := sSql + ' and custname = ''' + frmMainGangWay.edtName.Text + '''';
    end;

    with frmMainGangWay.OraQuery1 do begin
        close;
        SQL.Clear;
        SQL.Add(
            ' select  刷卡日期, 说明,count(*) as 总数 from ( ' +
            sSql + ' ) group by   刷卡日期, 说明 '
            );
        open;
        frmMainGangWay.StatusBar1.Panels.Items[3].Text := '记录数：' + IntToStr(RecordCount);
    end;

    //frmMainGangWay.FixDBGridColumnWidth(frmMainGangWay.gridResult);
end;

procedure TfrmMainGangWay.btnExportClick(Sender: TObject);
begin
    DBGridSaveXLS(gridResult, ExtractFilePath(paramstr(0)) + '.\' + '导出结果.xls');
end;


procedure TfrmMainGangWay.FixDBGridColumnWidth(const DBGrid: TDBGrid);
var
    i: Integer;
    cusWidth: Integer; //改变窗体大小后，数据表格宽度
    varWidth: Integer; //每列宽度
    totColumns: Integer;
begin
    totColumns := 0;
    cusWidth := Abs(DBGrid.ClientWidth);
    for i := 0 to -1 + DBGrid.Columns.Count do begin
        Inc(totColumns);
    end;
    varWidth := cusWidth div totColumns;
    for i := 0 to DBGrid.Columns.Count - 1 do begin
        if i = DBGrid.Columns.Count - 1 then begin
            DBGrid.Columns[i].Width := varWidth - 16;
        end
        else begin
            DBGrid.Columns[i].Width := varWidth;
        end;
    end;
end;

procedure TfrmMainGangWay.btnReportClick(Sender: TObject);
begin
    {
    with TFromWaitThread.Create(getReport, '正在统计，请稍后...') do begin
        FreeOnTerminate := True;
        Resume;
    end;
    }
    getReport();
end;


end.

