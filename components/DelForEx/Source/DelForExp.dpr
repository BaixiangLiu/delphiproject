library DelForExp;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  View-Project Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the DELPHIMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using DELPHIMM.DLL, pass string information
  using PChar or ShortString parameters. }
{$IFNDEF Ver100}
Compile this expert only for Delphi 3
{$ENDIF}

uses
  ShareMem,
  Forms,
  Windows,
  ExptIntf,
  ToolIntf,
  VirtIntf,
  SysUtils,
  Classes,
  DelForExpert in 'Delphi 3\DelForExpert.pas',
  MyIDEStream in 'Delphi 3\MyIDEStream.pas',
  Progr in 'Delphi 3\progr.pas' {ProgressDlg},
  OptDlg in 'Delphi 3\OptDlg.pas' {OptionsDlg},
  DelExpert in 'Delphi 3\DelExpert.pas' {DelExpertDlg},
  Delfor1 in 'Delphi 3\Delfor1.pas',
  OObjects in 'oObjects.pas';

exports
  InitExpert Name ExpertEntryPoint;


begin
end.
