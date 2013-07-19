{|----------------------------------------------------------------------
 | Program:     DelFor
 |
 | Author:      Egbert van Nes
 |
 | Description: Standalone version of DelForExp
 |
 | NOTE: you should install mwEdit first to be able to compile
 | this program
 |
 | Copyright (c) 2000  Egbert van Nes
 |   All rights reserved
 |   Disclaimer and licence notes: see license.txt
 |
 |----------------------------------------------------------------------
}
program DelFor;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  ViewWnd in 'ViewWnd.pas' {ViewForm},
  Progr in 'progr.pas' {ProgressDlg},
  About in 'About.pas' {AboutBox},
  OptDlg in 'OptDlg.pas' {OptionsDlg},
  EditFile in 'EditFile.pas' {FileEditDlg},
  OObjects in 'oObjects.pas',
  DelForTypes in 'DelforTypes.pas',
  Delfor1 in 'Delfor1.pas',
  DelforEng in 'DelforEng.pas';

{$R *.RES}

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TOptionsDlg, OptionsDlg);
  Application.Title := 'Delphi Formatter';
  Application.CreateForm(TProgressDlg, ProgressDlg);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

