program zipp;

uses
  Forms,
  Zip in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\ZIP.PAS' {VCLZipForm},
  IncZip in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\INCZIP.PAS' {IncompleteZipDlg},
  Ovrwrite in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\OVRWRITE.PAS' {OverwriteDlg},
  Extract in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\EXTRACT.PAS' {ExtractDlg},
  Compress in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\COMPRESS.PAS' {CompressDlg},
  Config in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\CONFIG.PAS' {ConfigDlg},
  Comment in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\COMMENT.PAS' {CommentEditor},
  ModInfo in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\MODINFO.PAS' {ModInfoForm},
  InvPwd in '\KPGB\DEMO\EXAMPLES\ZIPUTIL\INVPWD.PAS' {InvalidPwdDlg};

{$R *.RES}

begin
	{$IFDEF WIN32}
	Application.Initialize;
	{$ENDIF}
  Application.Title := 'VCLZip Zip Utility';
  Application.CreateForm(TVCLZipForm, VCLZipForm);
  Application.CreateForm(TOverwriteDlg, OverwriteDlg);
  Application.CreateForm(TExtractDlg, ExtractDlg);
  Application.CreateForm(TCompressDlg, CompressDlg);
  Application.CreateForm(TConfigDlg, ConfigDlg);
  Application.CreateForm(TCommentEditor, CommentEditor);
  Application.CreateForm(TModInfoForm, ModInfoForm);
  Application.CreateForm(TInvalidPwdDlg, InvalidPwdDlg);
  Application.Run;
end.
