unit main;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ComCtrls, Spin, IniFiles, ExtCtrls, DateUtils, mmsystem, ShellAPI,
    Menus;

const
    WM_TRAYNOTIFY = 2000;

type
    Tfrmmain = class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        CheckBox1: TCheckBox;
        CheckBox2: TCheckBox;
        Button2: TButton;
        SpinEdit1: TSpinEdit;
        Timer1: TTimer;
        Timer2: TTimer;
        Button3: TButton;
        PopupMenu1: TPopupMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
        procedure FormCreate(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Timer1Timer(Sender: TObject);
        procedure Timer2Timer(Sender: TObject);
        procedure Button3Click(Sender: TObject);

        procedure wmTrayNotify(var Msg: TMessage); message WM_TRAYNOTIFY;
        procedure N2Click(Sender: TObject);
        procedure N1Click(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure Minimize(var mess: TWMNCLBUTTONDOWN); message WM_NCLBUTTONDOWN;

    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmmain: Tfrmmain;
    Nid: TNotifyIconData;
    Startime: TDateTime; //程序启动时间
    Interval: Integer; //提醒间隔时间，单位为分钟
    LockScreen, VoiceRemind: string; //是否锁屏,是否声音提醒，0为False,1为Yes

implementation
uses tx, mythread;

{$R *.dfm}

procedure Tfrmmain.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9', #8, #13]) then begin
        beep;
        key := #0;
    end;
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
var
    FilePath: string;
    PresentTime: string;
    MyIni: TIniFile;
begin

    Nid.cbSize := sizeof(TNotifyIconData);
    Nid.Wnd := Handle;
    Nid.uID := 1000;
    Nid.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    Nid.uCallbackMessage := WM_TRAYNOTIFY;
    Nid.hIcon := Application.Icon.Handle;
    Nid.szTip := '保护视力专用软件 V1.0';
    Shell_NotifyIcon(NIM_ADD, @Nid);

    FilePath := ExtractFilePath(ParamStr(0)) + '\..\data\SysSet.ini';
    if not FileExists(FilePath) then begin
        Timer1.Enabled := false;
        Application.MessageBox('系统配置文件被破坏,程序无法正常运行', '警告', 16);
        Application.Terminate;
        exit;
    end;

    MyIni := TIniFile.Create(FilePath);

    PresentTime := FormatDateTime('yyyy-mm-dd hh:mm:ss', now);
    //MyIni.WriteString('Set', 'Startime', PresentTime);
    MyIni.WriteDateTime('Set', 'Startime', now);

    Startime := MyIni.ReadDateTime('Set', 'Startime', now);
    Interval := MyIni.ReadInteger('Set', 'Interval', 30);
    LockScreen := MyIni.ReadString('Set', 'LockScreen', '0');
    VoiceRemind := MyIni.ReadString('Set', 'VoiceRemind', '0');


    SpinEdit1.Value := Interval;
    if LockScreen = '0' then
        CheckBox2.Checked := False
    else CheckBox2.Checked := True;
    if VoiceRemind = '0' then
        CheckBox1.Checked := False
    else CheckBox1.Checked := True;



end;

procedure Tfrmmain.Button2Click(Sender: TObject);
var
    FilePath: string;
    MyIni: TIniFile;
begin
    FilePath := ExtractFilePath(ParamStr(0)) + '\..\data\SysSet.ini';
    MyIni := TIniFile.Create(FilePath);

    MyIni.WriteInteger('Set', 'Interval', SpinEdit1.Value);
    if CheckBox2.Checked then
        MyIni.WriteInteger('Set', 'LockScreen', 1)
    else
        MyIni.WriteInteger('Set', 'LockScreen', 0);
    if CheckBox1.Checked then
        MyIni.WriteInteger('Set', 'VoiceRemind', 1)
    else
        MyIni.WriteInteger('Set', 'VoiceRemind', 0);

    Application.MessageBox('保存设置成功，重新启动软件生效！！！', '提示信息', mb_ok + mb_iconinformation);
    Application.Terminate;

end;

procedure Tfrmmain.Button1Click(Sender: TObject);
begin
    //  frmAbout.ShowModal;
end;

procedure Tfrmmain.Timer1Timer(Sender: TObject);
begin
    if now < Startime then begin
        Timer1.Enabled := false;
        Application.MessageBox('现在的时间小于软件启动时间,请设置好系统时间后重启软件！！！', '警告', mb_ok + mb_iconwarning);
        Application.Terminate;
        exit;
    end;

    if (SecondsBetween(now, Startime) mod (Interval * 60)) = 0 then begin
        if LockScreen = '0' then begin
            if VoiceRemind = '0' then
                Application.MessageBox(PChar('你已经使用电脑' + inttostr(Interval) + '分钟，请注意休息，请不要连续使用电脑时间太长！'), '警告', mb_ok + mb_iconwarning)
            else begin
                Timer2.Enabled := True;
                Application.MessageBox(PChar('你已经使用电脑' + inttostr(Interval) + '分钟，请注意休息，请不要连续使用电脑时间太长！'), '警告', mb_ok + mb_iconwarning);
            end;
        end;

        if LockScreen = '1' then begin
            frmtx := Tfrmtx.Create(Application);
            frmtx.edtAnswer.Text := '234';
            frmtx.Showmodal;
            frmtx.Free;
        end;
    end;

end;

procedure Tfrmmain.Timer2Timer(Sender: TObject);
var
    TVRThread: TVoiceRemindThread;
begin
    TVRThread := TVoiceRemindThread.Create(False);
    Timer2.Enabled := false;
end;

procedure Tfrmmain.Button3Click(Sender: TObject);
begin
    self.Close;
end;

procedure Tfrmmain.wmTrayNotify(var Msg: TMessage);
var
    p: TPoint;
begin
    if (Msg.lparam = WM_LBUTTONDBLCLK) then begin
        self.show
    end else
        if (Msg.LParam = WM_RButtonUp) then begin
            GetCursorPos(P); //获得鼠标坐标
            PopupMenu1.Popup(P.X, P.Y); //在鼠标光标处显示弹出菜单
        end;
end; //自己写的wmTrayNotify函数

procedure Tfrmmain.N2Click(Sender: TObject);
begin
    Application.Terminate;
end;

procedure Tfrmmain.N1Click(Sender: TObject);
begin
    self.Show;
end;

procedure Tfrmmain.FormDestroy(Sender: TObject);
begin
    Shell_NotifyIcon(NIM_DELETE, @Nid); //窗口销毁时不要忘记顺带处理掉那个小图标啊
end;



procedure Tfrmmain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if Application.MessageBox('确定退出应用程序吗？', '提示', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
        CanClose := False;
    end;
end;

procedure Tfrmmain.Minimize(var mess: TWMNCLBUTTONDOWN);
begin
    //htreduce表示是否按了最小化按钮
    if mess.hittest = htreduce then begin
        self.hide;
    end
    else
        inherited;
end;

end.

