program GangWay;

uses
  Forms,
  frmGangWay in 'frmGangWay.pas' {Form1},
  uDoorController in 'uDoorController.pas',
  FormWait in '..\..\CommonUnit\FormWait.pas' {frmWait},
  AES in '..\..\CommonUnit\AES.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmWait, frmWait);
  Application.Run;
end.
