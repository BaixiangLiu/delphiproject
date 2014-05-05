{|----------------------------------------------------------------------
 | Unit:        Main
 |
 | Author:      Egbert van Nes
 |
 | Description: Main form for DelFor
 |
 | Copyright (c) 2000  Egbert van Nes
 |   All rights reserved
 |   Disclaimer and licence notes: see license.txt
 |
 |----------------------------------------------------------------------
}
unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, Delfor1;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FileExitItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpContentsItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    StatusLine: TStatusBar;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SpeedBar: TPanel;
    ExitButton: TSpeedButton;
    FileOpenButton: TSpeedButton;
    SaveButton: TSpeedButton;
    SaveAllButton: TSpeedButton;
    HelpButton: TSpeedButton;
    AboutButton: TSpeedButton;
    CloseAll1: TMenuItem;
    Format1: TMenuItem;
    FormatAllItem: TMenuItem;
    FormatCurrentItem: TMenuItem;
    OptionsItem: TMenuItem;
    FormatAllButton: TSpeedButton;
    FormatCurrentButton: TSpeedButton;
    SaveAllItem: TMenuItem;
    Edit1: TMenuItem;
    EditUndoItem: TMenuItem;
    N1: TMenuItem;
    EditCutItem: TMenuItem;
    EditPasteItem: TMenuItem;
    EditCopyItem: TMenuItem;
    FindDialog1: TFindDialog;
    N6: TMenuItem;
    WindowMinimizeAll: TMenuItem;
    EditRedoItem: TMenuItem; { &About... }
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure WindowTile(Sender: TObject);
    procedure WindowCascade(Sender: TObject);
    procedure WindowArrange(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure CloseAll1Click(Sender: TObject);
    procedure FormatAllItemClick(Sender: TObject);
    procedure FormatCurrentItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveAllItemClick(Sender: TObject);
    procedure EditUndoItemClick(Sender: TObject);
    procedure EditCutItemClick(Sender: TObject);
    procedure EditCopyItemClick(Sender: TObject);
    procedure EditPasteItemClick(Sender: TObject);
    procedure EditFindItemClick(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OptionsItemClick(Sender: TObject);
    procedure FileReloadAllItemClick(Sender: TObject);
    procedure WindowMinimizeAllClick(Sender: TObject);
    procedure EditRedoItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    Formatter: TPascalParser;
    ViewForm: TForm;
    procedure UpdateMenu;
    function GetActiveForm: TForm;
    procedure PerformFileOpen(AFileName: string);
    procedure Config(DoRead: Boolean);
  end;

var
  MainForm: TMainForm;

implementation
uses ViewWnd, Progr, About, OptDlg, Clipbrd;

{$R *.DFM}

procedure TMainForm.UpdateMenu;
var
  Child: TForm;
  I: Integer;
  P1, P2: TPoint;
  HasKids, HasChanged, FormattedAll: Boolean;
  CurrentFormatted, CurrentModified, HasSelected: Boolean;
begin
  HasKids := MDIChildCount > 0;
  HasChanged := False;
  FormattedAll := HasKids;
  for I := 0 to MDIChildCount - 1 do
  begin
    Child := MDIChildren[I];
    if Child is TViewForm then
      with TViewForm(Child), Memo1 do
      begin
        if AllFormatted then
          HasChanged := True
        else
        begin
          if Modified then
            HasChanged := True;
          FormattedAll := False;
        end;
      end;
  end;
  Child := GetActiveForm;
  CurrentFormatted := (Child <> nil) and (TViewForm(Child).CurrentFormatted);
  if Child <> nil then
  begin
    P1 := TViewForm(Child).Memo1.BlockBegin;
    P2 := TViewForm(Child).Memo1.BlockEnd;
  end;
  HasSelected := (Child <> nil) and not CompareMem(@P1, @P2, SizeOf(TPoint));
  CurrentModified := (Child <> nil) and (TViewForm(Child).Memo1.Modified);
  FileSaveItem.Enabled := HasKids and CurrentModified or CurrentFormatted;
  FileSaveAsItem.Enabled := HasKids;
  WindowTileItem.Enabled := HasKids;
  WindowCascadeItem.Enabled := HasKids;
  WindowArrangeItem.Enabled := HasKids;
  CloseAll1.Enabled := HasKids;
  FormatAllItem.Enabled := HasKids and not FormattedAll;
  FormatCurrentItem.Enabled := HasKids and not CurrentFormatted;
  SaveAllItem.Enabled := HasChanged;
  if ViewForm <> nil then
  begin
    EditUndoItem.Enabled := HasKids and TViewForm(ViewForm).Memo1.CanUndo;
    EditRedoItem.Enabled := HasKids and TViewForm(ViewForm).Memo1.CanRedo;
  end;
  EditCutItem.Enabled := HasKids and HasSelected;
  EditPasteItem.Enabled := HasKids and Clipboard.HasFormat(CF_TEXT);
  EditCopyItem.Enabled := HasKids and HasSelected;
  WindowMinimizeAll.Enabled := HasKids;
  SaveButton.Enabled := HasKids and CurrentModified or CurrentFormatted;
  SaveAllButton.Enabled := HasKids;
  FormatAllButton.Enabled := HasKids and not FormattedAll;
  FormatCurrentButton.Enabled := HasKids and not CurrentFormatted;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  Application.HelpFile := ChangeFileExt(ParamStr(0), '.hlp');
  Formatter := TPascalParser.Create(PChar(ExtractFilePath(ParamStr(0))));
  Formatter.CfgFile := ChangeFileExt(ParamStr(0), '.cfg');
  Config(True);
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.SimpleText := Application.Hint;
end;

function GetNextFile(var ProjFile {, inFile}: Text; var FileName: string):
  Boolean;
var
  Buf: array[0..300] of Char;
  P, P2: PChar;
begin
  repeat
    Readln(ProjFile, Buf);
    if (StrScan(Buf, '''') <> nil) and
      (StrPos(Buf, ' in') <> nil) then
    begin
      P := StrScan(Buf, '''') + 1;
      P2 := StrScan(P, '''');
      if P2 <> nil then
      begin
        P2^ := #0;
        FileName := string(P);
      end;
      Result := True;
      Exit;
    end
  until Eof(ProjFile);
  Result := False;
end;

procedure TMainForm.PerformFileOpen(AFileName: string);
var
  {ViewForm: TViewForm;}
  ProjFile: TextFile;
  FileName, Dir: string;
begin
  if FileExists(AFileName) then
  begin
    if ViewForm = nil then
      ViewForm := TViewForm.Create(Self);
    with TViewForm(ViewForm) do
    begin
      LoadFile(AFileName);
      Show;
    end;
    if (CompareText(ExtractFileExt(AFileName),
      '.dpr') = 0) and (MessageDlg('Ok to open all files in the project "' +
        ExtractFileName(AFileName) + '" ?',
      mtConfirmation, [mbYes, mbNo], 0) = ID_YES) then
    begin
      AssignFile(ProjFile, AFileName);
      try
        Dir := ExtractFileDir(ExpandFileName(AFileName));
        if Dir <> '' then
          Chdir(Dir);
        Reset(ProjFile);
        while GetNextFile(ProjFile, FileName) do
        begin
          if ViewForm = nil then
            ViewForm := TViewForm.Create(Self);
          with TViewForm(ViewForm) do
          begin
            LoadFile(FileName);
            if Caption = '' then
              Free
            else
              Show;
          end;
        end;
      finally
        CloseFile(ProjFile);
      end;
    end;
  end;
end;

procedure TMainForm.FileOpen(Sender: TObject);
var
  I: Integer;
begin
  with OpenDialog do
    if Execute then
    begin
      with Files do
        for I := 0 to Count - 1 do
          PerformFileOpen(Files.Strings[I]);
    end;
  UpdateMenu;
end;

procedure TMainForm.FileSave(Sender: TObject);
var
  ViewForm: TForm;
begin
  ViewForm := Screen.ActiveForm;
  if (ViewForm <> nil) and (ViewForm is TViewForm) then
    TViewForm(ViewForm).SaveTo('');
  UpdateMenu;
end;

procedure TMainForm.FileSaveAs(Sender: TObject);
var
  ViewForm: TForm;
begin
  ViewForm := Screen.ActiveForm;
  if (ViewForm <> nil) and (ViewForm is TViewForm) then
  begin
    SaveDialog.FileName := ViewForm.Caption;
    if SaveDialog.Execute then
      with TViewForm(ViewForm) do
      begin
        SetCurrentFileName(SaveDialog.FileName);
        SaveCurrent;
      end;
  end;
  UpdateMenu;
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.WindowTile(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowCascade(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowArrange(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
  Application.HelpCommand(Help_Contents, 0);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.CloseAll1Click(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
  UpdateMenu;
end;

procedure TMainForm.FormatAllItemClick(Sender: TObject);
var
  I: Integer;
  Child: TForm;
begin
  ProgressDlg.Show;
  Application.ProcessMessages;
  for I := 0 to MDIChildCount - 1 do
  begin
    Child := MDIChildren[I];
    if Child is TViewForm then
      TViewForm(Child).FormatAll;
  end;
  ProgressDlg.Hide;
  UpdateMenu;
end;

procedure TMainForm.FormatCurrentItemClick(Sender: TObject);
begin
  ViewForm := Screen.ActiveForm;
  if (ViewForm <> nil) and (ViewForm is TViewForm) then
  begin
    ProgressDlg.Show;
    Application.ProcessMessages;
    TViewForm(ViewForm).FormatCurrent;
    if ProgressDlg <> nil then
      ProgressDlg.Hide;
  end;
  UpdateMenu;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  I: Integer;
  Dir: string;
begin
  if OptionsDlg <> nil then
    OptionsDlg.HelpFile := PChar(Application.HelpFile);
  if ProgressDlg <> nil then
  begin
    ProgressDlg.Hide;
    ProgressDlg.Parent := Application.MainForm;
  end;
  if paramCount > 0 then
  begin
    for I := 1 to paramCount do
      PerformFileOpen(ParamStr(I));
    Dir := ExtractFileDir(ExpandFileName(ParamStr(paramCount)));
    if Dir <> '' then
      Chdir(Dir);
  end;
  UpdateMenu;
  OptionsDlg.Formatter := Formatter;
end;

procedure TMainForm.SaveAllItemClick(Sender: TObject);
var
  Child: TForm;
  I: Integer;
  Action: TCloseAction;
begin
  for I := 0 to MDIChildCount - 1 do
  begin
    Child := MDIChildren[I];
    if Child is TViewForm then
      TViewForm(Child).FormClose(nil, Action);
  end;
  UpdateMenu;
end;

function TMainForm.GetActiveForm: TForm;
begin
  Result := TForm(Screen.ActiveForm);
  if (Result <> nil) and not (Result is TViewForm) then
    Result := nil;
end;

procedure TMainForm.EditUndoItemClick(Sender: TObject);
begin
  ViewForm := TForm(GetActiveForm);
  if ViewForm <> nil then
    TViewForm(ViewForm).Memo1.Undo;
end;

procedure TMainForm.EditCutItemClick(Sender: TObject);
begin
  ViewForm := TForm(GetActiveForm);
  if ViewForm <> nil then
    with TViewForm(ViewForm).Memo1 do
      CutToClipboard;
  UpdateMenu;
end;

procedure TMainForm.EditCopyItemClick(Sender: TObject);
begin
  ViewForm := TForm(GetActiveForm);
  if ViewForm <> nil then
    with TViewForm(ViewForm).Memo1 do
      CopyToClipboard;
end;

procedure TMainForm.EditPasteItemClick(Sender: TObject);
begin
  ViewForm := TForm(GetActiveForm);
  if ViewForm <> nil then
    with TViewForm(ViewForm).Memo1 do
      PasteFromClipboard;
end;

procedure TMainForm.EditFindItemClick(Sender: TObject);
begin
  ViewForm := TForm(GetActiveForm);
  if ViewForm <> nil then
  begin
    with TViewForm(ViewForm) do
    begin
      SelStart := 0;
      SelLength := 0;
    end;
    FindDialog1.Execute;
  end;

end;

procedure TMainForm.FindDialog1Find(Sender: TObject);
var
  SelPos, StartPos: Integer;
begin
  if ViewForm <> nil then
    with TViewForm(ViewForm), Memo1, FindDialog1 do
    begin
      { Perform a global case-sensitive search for FindText in Memo1 }
      StartPos := SelStart + SelLength;
      if frMatchCase in Options then
        SelPos := Pos(FindText, Lines.Text[StartPos])
      else
        SelPos := Pos({UpperCase}(FindText),
          {UpperCase}(Memo1.Lines.Text[StartPos]));
      if SelPos > 0 then
      begin
        SelStart := StartPos + SelPos - 1;
        SelLength := Length(FindText);
        ViewForm.SetFocus;
        CloseDialog;
      end
      else
        MessageDlg(Concat('Could not find "', FindText, '" in Memo1.'), mtError,
          [mbOK], 0);
    end;
  UpdateMenu;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Config(False);
  Formatter.Free;
  MainForm := nil;
end;

procedure TMainForm.OptionsItemClick(Sender: TObject);
begin
  OptionsDlg.ShowModal;
  if ViewForm <> nil then
  begin
    ProgressDlg.Show;
    TViewForm(ViewForm).FormatFormatted;
    ProgressDlg.Hide;
  end;
end;

procedure TMainForm.FileReloadAllItemClick(Sender: TObject);
var
  Child: TForm;
  I: Integer;
begin
  for I := 0 to MDIChildCount - 1 do
  begin
    Child := MDIChildren[I];
    if Child is TViewForm then
      with TViewForm(Child) do
        if {Formatted or} Memo1.Modified then
          LoadFile(Caption);
  end;
  ProgressDlg.Hide;
  UpdateMenu;
end;

procedure TMainForm.WindowMinimizeAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TMainForm.Config(DoRead: Boolean);
begin
  Formatter.Config(DoRead);
end;

procedure TMainForm.EditRedoItemClick(Sender: TObject);
begin
  if ViewForm <> nil then
    TViewForm(ViewForm).Memo1.Redo;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i: integer;
begin
  CloseAll1Click(nil);
  CanClose := True;
  for i := 0 to MDIChildCount - 1 do
    if TForm(MDIChildren[i]).ModalResult = mrcancel then
      CanClose := False;
end;

end.

