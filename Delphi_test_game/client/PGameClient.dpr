program PGameClient;

uses
  Forms,
  Pmain in 'Pmain.pas' {Fmain},
  PGmProtect in '..\GameServer\PGmProtect.pas',
  Pgame in 'Pgame.pas' {Fgame},
  xdarray in '..\GameServer\XDARRAY.PAS',
  Plogin in 'Plogin.pas' {Flogin},
  PRenameCard in 'PRenameCard.pas',
  PcardClass in 'PcardClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFmain, Fmain);
  Application.CreateForm(TFlogin, Flogin);
  Application.CreateForm(TFgame, Fgame);
  Flogin.ShowModal;
  Application.Run;
end.

