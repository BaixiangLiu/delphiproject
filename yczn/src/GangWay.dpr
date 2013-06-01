program GangWay;

uses
  Forms,
  frmGangWay in 'frmGangWay.pas' {frmMainGangWay},
  uDoorController in 'uDoorController.pas',
  FormWait in '..\..\CommonUnit\FormWait.pas' {frmWait},
  AES in '..\..\CommonUnit\AES.pas',
  ElAES in '..\..\CommonUnit\ElAES.pas',
  uIO in '..\..\CommonUnit\uIO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMainGangWay, frmMainGangWay);
  Application.CreateForm(TfrmWait, frmWait);
  Application.Run;
end.
