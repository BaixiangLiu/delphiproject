program POSA;

uses
  Forms,
  main in 'UNMAIN\main.pas' {FMMAIN},
  MAIND in '..\main\MAIND.pas' {FMMAIND: TDataModule},
  mainU in '..\MAIN\mainU.pas',
  SYSINI in '..\MAIN\SYSINI.pas',
  UNPOSA in 'UNPOSA\UNPOSA.pas' {FMPOSA},
  UNPOSAD in 'UNPOSA\UNPOSAD.pas' {FMPOSAD: TDataModule},
  URDSP in '..\J_UTL\UNDSP\URDSP.pas' {FRDSP},
  UNPOSAS in 'UNPOSA\UNPOSAS.pas' {FMPOSAS},
  UNPOSAU in 'UNPOSA\UNPOSAU.pas',
  UNPOSAPRICE in 'UNPOSA\UNPOSAPRICE.pas' {FMPOSAPRICE},
  UNPOSAF1 in 'UNPOSA\UNPOSAF1.pas' {FMPOSAF1},
  UNPOSACARD in 'UNPOSA\UNPOSACARD.pas' {FMPOSACARD},
  UNPOSAGIFT in 'UNPOSA\UNPOSAGIFT.pas' {FMPOSAGIFT},
  mains in 'UNMAIN\mains.pas' {FMMAINS},
  UNPOSAKEY in 'UNPOSA\UNPOSAKEY.pas' {FMPOSAKEY},
  UNBMEMN in '..\UNBMEM\UNBMEMN.pas' {FMBMEMN},
  UNBGDSN in '..\UNBGDS\UNBGDSN.pas' {FMBGDSN},
  SYSLOG in '..\MAIN\SYSLOG.pas' {FMLOG},
  URINVOICE in '..\J_UTL\UNINVOICE\URINVOICE.pas' {FRINVOICE},
  UNPOSAMESSAGE in 'UNPOSA\UNPOSAMESSAGE.pas' {FMPOSAMESSAGE},
  UNBGDSQ in '..\UNBGDS\UNBGDSQ.pas' {FMBGDSQ},
  UNBMEMQ in '..\UNBMEM\UNBMEMQ.pas' {FMBMEMQ},
  UNPOSASINGLE in 'UNPOSA\UNPOSASINGLE.pas' {FMPOSASINGLE},
  mainsK in 'UNMAIN\MAINSK.PAS' {FMMAINSK};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFMMAIN, FMMAIN);
  Application.CreateForm(TFMMAIND, FMMAIND);
  Application.Run;
end.
