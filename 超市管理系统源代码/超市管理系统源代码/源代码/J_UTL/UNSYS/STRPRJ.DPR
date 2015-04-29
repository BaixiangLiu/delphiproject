program STRPRJ;

uses
  Forms,
  SYSSTR in 'SYSSTR.pas' {FMSTR};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFMSTR, FMSTR);
  Application.Run;
end.
