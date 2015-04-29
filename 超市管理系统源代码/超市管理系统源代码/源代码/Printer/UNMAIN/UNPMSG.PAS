unit UNPMSG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus;

type
  TFMPMSG = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    EXIT1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EXIT1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMPMSG: TFMPMSG;

implementation

USES MAINU, SYSINI;

{$R *.DFM}

procedure TFMPMSG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
IF MessageDlg('是否确定要删除此个人信息吗?',mtWarning, [mbYes, mbNo], 0) = mrYes then
   POS_DEL_PERSONAL_MESSAGE(_USER_ID);

FMPMSG.Release;
end;

procedure TFMPMSG.FormActivate(Sender: TObject);
begin
// 检查个人信息
//T_MESSAGE := POS_CHECK_PERSONAL_MESSAGE(_USER_ID);
IF TRIM(_USER_MSG) = '' THEN _USER_MSG := '目前没有任何留言!';

Memo1.Lines.TEXT := _USER_MSG;
end;

procedure TFMPMSG.Memo1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
IF KEY = 27 THEN CLOSE;
end;

procedure TFMPMSG.EXIT1Click(Sender: TObject);
begin
CLOSE;
end;

end.
