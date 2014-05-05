unit Plogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzTabs, RzButton, StdCtrls, Mask, RzEdit, RzLabel, RzBckgnd, PGmProtect,
  RzCmboBx;

type
  TFlogin = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzBackground1: TRzBackground;
    RzBackground2: TRzBackground;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    Epsd: TRzEdit;
    RzButton1: TRzButton;
    RzButton2: TRzButton;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    EAcc: TRzComboBox;
    EserviceIP: TRzComboBox;
    EServicePort: TRzComboBox;
    RzButton3: TRzButton;
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure EpsdKeyPress(Sender: TObject; var Key: Char);
    procedure RzButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RzButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Flogin: TFlogin;

implementation

uses Pmain;
const
  CAccTree = 'AccTree';
  CServiceIP = 'ServiceIp';
  CservicePort = 'ServicePort';

{$R *.dfm}

procedure TFlogin.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Epsd.SetFocus;
end;

procedure TFlogin.EpsdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then RzButton1.Click;

end;

procedure TFlogin.RzButton2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFlogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fmain.GameClient.Connected then CanClose := True else CanClose := False;
end;

procedure TFlogin.RzButton1Click(Sender: TObject);
begin
  try
    Fmain.GameClient.Host := EserviceIP.Text;
    Fmain.GameClient.Port := strtoint(EServicePort.Text);
    Fmain.GameClient.Connect(5000);
    if Fmain.LoginIn(Fmain.GameClient, EAcc.Text, Epsd.Text) then
      Fmain.ReciveWaiteList(Fmain.GameClient);
    Fmain.GReciveThread := TReciveThread.Create(False);
    Fmain.Appstate := CappstateNormal;
    if (EAcc.Text <> '') and (EAcc.text <> EAcc.Items[0]) then begin
      EAcc.Items.Insert(0, EAcc.Text);
      if EAcc.Items.Count > 8 then
        EAcc.Items.Delete(9);
      EAcc.Items.SaveToFile(CAccTree);
    end;
    sleep(100);
    Close;
  except
    Application.MessageBox('连接服务器失败,请检查是否设置错误。', '抱歉');
  end;
    Pmain.Fmain.EgameKind.Hide;
    Pmain.Fmain.EgameMaxplayerCount.Hide;
    Pmain.Fmain.RzLabel2.Hide;
    Pmain.Fmain.RzLabel3.Hide;
end;

procedure TFlogin.FormCreate(Sender: TObject);
begin
  if FileExists(CAccTree) then begin
    EAcc.Items.LoadFromFile(CAccTree);
    EAcc.ItemIndex := 0;
  end;
  if FileExists(CServiceIP) then begin
    EserviceIP.Items.LoadFromFile(CServiceIP);
    EserviceIP.ItemIndex := 0;
  end;
  if FileExists(CservicePort) then begin
    EServicePort.Items.LoadFromFile(CservicePort);
    EServicePort.ItemIndex := 0;
  end;
end;

procedure TFlogin.RzButton3Click(Sender: TObject);
begin
  EserviceIP.Items[0] := EserviceIP.Text;
  EserviceIP.Items.SaveToFile(CServiceIP);
  EServicePort.Items[0] := EServicePort.Text;
  EServicePort.Items.SaveToFile(CservicePort);
  Application.MessageBox('修改成功', '修改');
end;

end.

