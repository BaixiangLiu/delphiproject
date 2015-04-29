unit UNEMAIL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Psock, NMsmtp, StdCtrls, Buttons;

type
  TFMEMAIL = class(TForm)
    NMSMTP1: TNMSMTP;
    StatusBar: TStatusBar;
    GroupBox4: TGroupBox;
    Label11: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit10: TEdit;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    Edit5: TEdit;
    Edit6: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BTN_SERVER_CONN: TButton;
    BTN_SERVER_DISC: TButton;
    Edit4: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    procedure BTN_SERVER_CONNClick(Sender: TObject);
    procedure BTN_SERVER_DISCClick(Sender: TObject);
    procedure NMSMTP1Connect(Sender: TObject);
    procedure NMSMTP1Disconnect(Sender: TObject);
    procedure NMSMTP1Status(Sender: TComponent; Status: String);
    procedure NMSMTP1EncodeStart(Filename: String);
    procedure NMSMTP1EncodeEnd(Filename: String);
    procedure NMSMTP1ConnectionFailed(Sender: TObject);
    procedure NMSMTP1ConnectionRequired(var handled: Boolean);
    procedure NMSMTP1Failure(Sender: TObject);
    procedure NMSMTP1HostResolved(Sender: TComponent);
    procedure NMSMTP1InvalidHost(var handled: Boolean);
    procedure NMSMTP1PacketSent(Sender: TObject);
    procedure NMSMTP1RecipientNotFound(Recipient: String);
    procedure NMSMTP1SendStart(Sender: TObject);
    procedure NMSMTP1Success(Sender: TObject);
    procedure NMSMTP1HeaderIncomplete(var handled: Boolean;
      hiType: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMEMAIL: TFMEMAIL;

implementation

USES UN_UTL, FM_UTL;

{$R *.DFM}

var Q: Integer;




procedure TFMEMAIL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 NMSMTP1.Abort;
end;

procedure TFMEMAIL.BTN_SERVER_CONNClick(Sender: TObject);
begin
  BTN_SERVER_CONN.Enabled := FALSE;

  NMSMTP1.Host := Edit1.Text;
  NMSMTP1.Port := StrToInt(Edit2.Text);
  NMSMTP1.UserID := Edit4.Text;

  TRY
    NMSMTP1.Connect;
  EXCEPT
    SHOWMESSAGE('�޷���������������,��ȷ��������Ƿ���������!');
    FMEMAIL.Release;
  END;

end;

procedure TFMEMAIL.BTN_SERVER_DISCClick(Sender: TObject);
begin
  BTN_SERVER_CONN.Enabled := TRUE;
  NMSMTP1.Disconnect;
end;

procedure TFMEMAIL.NMSMTP1Connect(Sender: TObject);
begin
  StatusBar.SimpleText := '�Ѿ�����������';
end;

procedure TFMEMAIL.NMSMTP1Disconnect(Sender: TObject);
begin
  If StatusBar <> nil then
    StatusBar.SimpleText := '�Ѿ��������ж�';
end;

procedure TFMEMAIL.NMSMTP1Status(Sender: TComponent; Status: String);
begin
  If StatusBar <> nil then
    StatusBar.SimpleText := status;
end;

procedure TFMEMAIL.NMSMTP1EncodeStart(Filename: String);
begin
  StatusBar.SimpleText := '������ '+Filename;
end;

procedure TFMEMAIL.NMSMTP1EncodeEnd(Filename: String);
begin
  StatusBar.SimpleText := '��ɱ��� '+Filename;
end;

procedure TFMEMAIL.NMSMTP1ConnectionFailed(Sender: TObject);
begin
  ShowMessage('����ʧ��!');
end;

procedure TFMEMAIL.NMSMTP1ConnectionRequired(var handled: Boolean);
begin
  If MessageDlg('��Ҫ����������, �Ƿ�Ҫ������ ?', mtConfirmation, mbOkCancel, 0) = mrOk then
  Begin
    Handled := TRUE;
    NMSMTP1.Connect;
  End;
end;

procedure TFMEMAIL.NMSMTP1Failure(Sender: TObject);
begin
  StatusBar.SimpleText := 'ʧ��!';
end;

procedure TFMEMAIL.NMSMTP1HostResolved(Sender: TComponent);
begin
  StatusBar.SimpleText := '���� Resolved';
end;

procedure TFMEMAIL.NMSMTP1InvalidHost(var handled: Boolean);
var
  TmpStr: String;
begin
  If InputQuery('����ȷ������!', '������һ���µ�����', TmpStr) then
  Begin
    NMSMTP1.Host := TmpStr;
    Handled := TRUE;
  End;
end;

procedure TFMEMAIL.NMSMTP1PacketSent(Sender: TObject);
begin
  StatusBar.SimpleText := IntToStr(NMSMTP1.BytesSent)+' bytes of '+IntToStr(NMSMTP1.BytesTotal)+' sent';
end;

procedure TFMEMAIL.NMSMTP1RecipientNotFound(Recipient: String);
begin
//  ShowMessage('Recipient "'+Recipient+'" not found');
end;

procedure TFMEMAIL.NMSMTP1SendStart(Sender: TObject);
begin
  StatusBar.simpleText := '�����ʼ���';
end;

procedure TFMEMAIL.NMSMTP1Success(Sender: TObject);
begin
  StatusBar.SimpleText := '�ɹ�!';
end;

procedure TFMEMAIL.NMSMTP1HeaderIncomplete(var handled: Boolean;
  hiType: Integer);
begin
  ShowMessage('��ͷ������!');
end;





procedure TFMEMAIL.BitBtn1Click(Sender: TObject);
VAR X, Y : INTEGER;
begin
  IF (TRIM(Edit5.TEXT) ='') OR
     (TRIM(Edit6.TEXT) ='') OR
     (TRIM(MEMO1.Lines.Text) ='') THEN
     BEGIN
     SHOWMESSAGE('���ϲ�����!');
     EXIT;
     END;



  NMSMTP1.SubType := mtHtml;

  NMSMTP1.PostMessage.ToAddress.Add(Edit7.Text);

  NMSMTP1.PostMessage.FromAddress := Edit6.Text;
  NMSMTP1.PostMessage.FromName := Edit5.Text;
  NMSMTP1.PostMessage.Subject := Edit10.Text;
  NMSMTP1.PostMessage.ToBlindCarbonCopy.Add('');
  NMSMTP1.PostMessage.ToCarbonCopy.Add('');
  NMSMTP1.PostMessage.Body.Assign(Memo1.Lines);



  TRY
    NMSMTP1.SendMail;
  FINALLY
    SHOWMESSAGE('���ͳɹ�!');
    FMEMAIL.Release;
  END;




end;

procedure TFMEMAIL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
IF BTN_SERVER_CONN.Enabled = FALSE THEN BTN_SERVER_DISC.Click;

FMEMAIL.Release;
end;

procedure TFMEMAIL.FormCreate(Sender: TObject);
begin
BTN_SERVER_CONN.Click;
end;

end.
