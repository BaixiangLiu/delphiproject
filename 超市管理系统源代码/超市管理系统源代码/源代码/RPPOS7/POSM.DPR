program POSM;

uses
  Forms,
  main in 'main.pas' {FMMAIN},
  MAIND in '..\MAIND.pas' {FMMAIND: TDataModule},
  mainU in '..\mainU.pas',
  SYSINI in '..\..\Utility\unsys\SYSINI.pas',
  SYSLSTP in '..\..\Utility\unsys\SYSLSTP.pas' {FMLSTP},
  SYSLST in '..\..\Utility\unsys\SYSLST.pas' {FMLST},
  RPPOS7P in 'RPPOS7P.pas' {RMPOS7P},
  RPPOS7F in 'RPPOS7F.pas' {RMPOS7F};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFMMAIND, FMMAIND);
  Application.CreateForm(TFMMAIN, FMMAIN);
  Application.Run;
end.
