unit Freg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, PrivLvls;

type
  TregF = class (TForm)
    Label1 : TLabel;
    Label2 : TLabel;
    nameE : TEdit;
    pswE : TEdit;
    Panel1 : TPanel;
    LoginBB : TBitBtn;
    LogoutBB : TBitBtn;
    CancelBB : TBitBtn;
    procedure CancelClick (Sender : TObject);
    procedure LogInClick (Sender : TObject);
    //    procedure FormActivate(Sender: TObject);
    procedure LogOutClick (Sender : TObject);
  private
    procedure LogIn (lvl : TPrivLevel);
    { Private declarations }
  public

    { Public declarations }
  end;

function fRegShow : TPrivLevel;
var
  regF    : TregF;
  pl      : TPrivLevel;


implementation
//     uses
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          {dm ,}{sns,}{MainUnit;}
{$R *.DFM}

function fRegShow : TPrivLevel;
begin
  regF.ShowModal;
  result := pl;
end;


procedure TregF.CancelClick (Sender : TObject);
begin
  //
  //ShowMessage('Регистрация отменена');
  Close;
  pl := plNone;
  ModalResult := mrCancel;
  Abort;
end;

procedure TregF.LogInClick (Sender : TObject);
//var
//  pl: TPrivLevel;
begin
  if NameE.Text = '' then
  begin
    MessageBeep ($FFFFFFFF);
    exit;
  end;
  pl := CheckPrivLevel (NameE.Text, PswE.Text);
  if pl > plNone then
  begin
    LogIn (pl);
    LoginBB.Enabled := False;
    LogoutBB.Enabled := True;
    NameE.Enabled := False;
    PswE.Enabled := False;
    RegLogIn (NameE.Text);
    ShowMessage ('Вы работаете под именем ' + NameE.Text);
    //           InCount:=MaxUserTime;
  end
  else
  begin
    ShowMessage ('Неразрешенные имя/пароль');
    nameE.SetFocus;
  end;
  NameE.Clear;
  PswE.Clear;
  Close;
end;

procedure TregF.LogOutClick (Sender : TObject);
begin
  if Application.MessageBox ('Вы действительно хотите выйти из системы?',
    'Подтвердите выход', mb_YesNo or mb_IconQuestion) = idNo then exit;
  LogIn (plNone);
  RegLogOut (orOrder);
  NameE.Enabled := True;
  PswE.Enabled := True;
  LoginBB.Enabled := True;
  LogoutBB.Enabled := False;
  Close;

end;


procedure TRegF.LogIn (lvl : TPrivLevel);
begin
  if lvl = plNone then
  begin
    PrivLvl := plNone;
    pl := plNone;
    EnbldFields := [];
    exit;
  end
  else
    if lvl > plNone then
  begin
    EnbldFields := UsalEnbld;
    if lvl = plAdmin then
    begin
      EnbldFields := AdminEnbld;
    end;
  end;
  PrivLvl := lvl;
end;





end.
