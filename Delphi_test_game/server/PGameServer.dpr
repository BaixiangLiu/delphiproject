program PGameServer;

uses
  Forms,
  PMain in 'PMain.pas' {FMain},
  PGmProtect in 'PGmProtect.pas',
  PcardClass in 'PcardClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.

