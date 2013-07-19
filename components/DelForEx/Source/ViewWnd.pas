{|----------------------------------------------------------------------
 | Unit:        ViewWnd
 |
 | Author:      Egbert van Nes
 |
 | Description: Edit form for DelFor
 |
 | Copyright (c) 2000  Egbert van Nes
 |   All rights reserved
 |   Disclaimer and licence notes: see license.txt
 |
 |----------------------------------------------------------------------
}
unit ViewWnd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, mwCustomEdit, mwHighlighter, mwPasSyn, Menus;

type
  TViewForm = class(TForm)
    FindDialog1: TFindDialog;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TmwCustomEdit;
    PopupMenu1: TPopupMenu;
    ClosepageItem: TMenuItem;
    Openneweditwindow1: TMenuItem;
    N1: TMenuItem;
    Formatpage1: TMenuItem;
    mwPasSyn1: TmwPasSyn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ClosepageItemClick(Sender: TObject);
    procedure Openneweditwindow1Click(Sender: TObject);
    procedure Formatpage1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    TheList: TList;
    procedure UpdateStatusBar;
    procedure FormatterProgress(Sender: TObject; Progress: Integer);
    procedure FormatPascal(TabNo: Integer);
    function GlobalFindFile(var Item: TObject; NotIndex: Integer;
      FileName: PChar): Boolean;
    procedure MemoReset;
    function GelSelLength: Integer;
    function GetSelStart: Integer;
    procedure SetSelLength(const Value: Integer);
    procedure SetSelStart(const Value: Integer);
    { Private declarations }
  public
    destructor Destroy; override;
    function FindFile(var Item: TObject; NotIndex: Integer;
      FileName: PChar): Boolean;
    procedure LoadFile(AFileName: string);
    function CurrentFileContent: TObject;
    procedure FormatAll;
    procedure FormatFormatted;
    procedure SetCurrentFileName(FileName: string);
    procedure FormatCurrent;
    function SaveCurrent: Boolean;
    function CurrentFormatted: Boolean;
    function AllFormatted: Boolean;
    procedure FormatToFile(FromFile, ToFile: string);
    procedure SaveTo(AFileName: string);
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelLength: Integer read GelSelLength write SetSelLength;
    { Public declarations }
  end;

var
  ViewForm: TViewForm;

implementation
uses Delfor1, Progr, Main;

{$R *.DFM}
const
  MaxMemoSize = 65535 - 2500;
type
  TFileContent = class
  private
    FList: TStringList;
    FFileName: PChar;
    FModified: Boolean;
    FFormatted: Boolean;
    FTopLine: Integer;
    FCaretX: Integer;
    FCaretY: Integer;
    FBlockStart: TPoint;
    FBlockEnd: TPoint;
    procedure SetFileName(const Value: PChar);
    procedure SetText(const Value: PChar);
    function GetText: PChar;
  public
    constructor Create(AFileName: string);
    destructor Destroy; override;
    procedure Format;
    procedure SaveFile;
    procedure SaveMemoSettings(AMemo: TmwCustomEdit);
    procedure SetMemoSettings(AMemo: TmwCustomEdit);
    property FileName: PChar read FFileName write SetFileName;
    property Text: PChar read GetText write SetText;
    property Modified: Boolean read FModified write FModified;
    property Formatted: Boolean read FFormatted write FFormatted;
    property List: TStringList read FList write FList;
  end;

procedure TViewForm.UpdateStatusBar;
begin
  if Memo1.Modified then
    StatusBar1.Panels[1].Text := 'Modified'
  else if CurrentFormatted then
    StatusBar1.Panels[1].Text := 'Formatted'
  else
    StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[0].Text := Format('%5d :%5d', [Memo1.CaretY, Memo1.CaretX]);
  if Memo1.InsertMode then
    StatusBar1.Panels[2].Text := 'Insert'
  else
    StatusBar1.Panels[2].Text := 'Overwrite';
end;

function TViewForm.CurrentFormatted: Boolean;
begin
  Result := (TheList <> nil) and TFileContent(CurrentFileContent).Formatted;
end;

procedure TViewForm.LoadFile(AFileName: string);
var
  ATab: TTabSheet;
  Name: string;
  P: PChar;
  FileContent: TFileContent;
  Item: TObject;
  NewList: Boolean;
  FileInList: Boolean;
begin
  if FileExists(AFileName) then
  begin
    NewList := False;
    Name := ExtractFileName(AFileName);
    AFileName := ExpandFileName(AFileName);
    P := StrScan(PChar(Name), '.');
    P^ := #0;
    if TheList <> nil then
    begin
      ATab := TTabSheet.Create(PageControl1);
      ATab.Parent := PageControl1;
      ATab.PageControl := PageControl1;
      ATab.OnShow := TabSheet1Show;
      ATab.Caption := Name;
    end
    else
    begin
      NewList := True;
      TabSheet1.Caption := Name;
      TheList := TList.Create;
    end;
    FileInList := False;
    FileContent := nil;
    if GlobalFindFile(Item, -1, PChar(AFileName)) then
    begin
      FileInList := True;
      FileContent := TFileContent(Item);
    end;
    if not FileInList then
      FileContent := TFileContent.Create(AFileName);
    if FileContent.Text <> nil then
      TheList.Add(FileContent);
    if NewList then TabSheet1Show(TabSheet1);
  end;
  (*
  Formatted := False;
  LargeFile := True;
  Memo1.Lines.Clear;
  if not FileExists(aFileName) then
    Caption := ''
  else
  begin
    Caption := aFileName;
    Memo1.Lines.BeginUpdate;
    try
      MemoryStream := TMemoryStream.Create;
      try
        MemoryStream.LoadFromFile(aFileName);
        SetString(S, PChar(MemoryStream.memory), MemoryStream.Size);
      finally
        MemoryStream.Free;
      end;
      AdjustLineBreaks(S);
      if Strlen(PChar(S)) > MaxMemoSize then
      begin
        LargeFile := True;
        (PChar(S) + MaxMemoSize)^ := #0;
        Memo1.Lines.Text := S;
        Memo1.Lines.Add('{***  FILE TOO LARGE, CAN ONLY VIEW PART OF THIS FILE  ***}');
        Memo1.Lines.Add('{***  BUT STILL POSSIBLE TO FORMAT AND SAVE            ***}');
      end
      else
      begin
        LargeFile := False;
        Memo1.Lines.Text := S;
      end;
    except
      on EInvalidOperation do
      begin
        LargeFile := True;
        Memo1.Lines.Clear;
        Memo1.Lines.Add('{***  FILE TOO LARGE, CAN ONLY VIEW PART OF THIS FILE  ***}');
        Memo1.Lines.Add('{***  BUT STILL POSSIBLE TO FORMAT AND SAVE            ***');
        Memo1.ReadOnly := True;
        AssignFile(InFile, aFileName);
        try
          Reset(InFile);
          while not Eof(InFile) do
          begin
            ReadLn(InFile, S);
            Memo1.Lines.Add(S);
          end;
        finally
          CloseFile(InFile);
        end;
      end;
    end;
    Memo1.Modified := False;
    UpdateStatusBar;
    List:=TList.Create;
    List.Add(Memo1.Lines);
    Memo1.Lines.EndUpdate;
  end;
  end;*)
end;

function StrInsert(Str1, Str2: PChar; I: Integer): PChar;
var
  LenStr2: Integer;
begin
  if I < 0 then I := 0;
  LenStr2 := StrLen(Str2);
  StrMove(Str1 + I + LenStr2, Str1 + I, Integer(StrLen(Str1)) - I + 1);
  StrMove(Str1 + I, Str2, LenStr2);
  StrInsert := Str1;
end;

function MakeBakFile(Dest, FileName: PChar): PChar;
var
  F: file;
  P: PChar;
begin
  if FileExists(FileName) then
  begin
    MakeBakFile := StrCopy(Dest, FileName);
    P := StrRScan(Dest, '.');
    if P = nil then
      StrCat(Dest, '.~')
    else
    begin
      (StrEnd(P) - 1)^ := #0;
      StrInsert(P + 1, '~', 0);
    end;
    if FileExists(Dest) then
    begin
      AssignFile(F, Dest);
      Erase(F);
    end;
    AssignFile(F, FileName);
    try
      Rename(F, Dest);
    except
      on EInOutError do ;
    end;
  end
  else MakeBakFile := StrCopy(Dest, '');
end;

procedure TViewForm.SaveTo(AFileName: string);
var
  BakFile: array[0..255] of Char;
  FromFile: string;
begin
  Screen.Cursor := crHourGlass;
  try
    if CurrentFormatted or  Memo1.Modified then
    begin
      FromFile := Caption;
      if AFileName = '' then
        AFileName := Caption
      else
        Caption := AFileName;
      MakeBakFile(BakFile, PChar(AFileName));
      if (FromFile = Caption) and (StrComp(BakFile, '') <> 0) then
        FromFile := string(BakFile);
      Memo1.Lines.SaveToFile(AFileName);
      Memo1.Modified := False;
      TFileContent(CurrentFileContent).Modified:=False;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
  UpdateStatusBar;
end;

procedure TViewForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ModifiedFile: TFileContent;
  I, Istart: Integer;
  function Modified(var Istart: Integer): Boolean;
  var
    I: Integer;
  begin
    ModifiedFile := nil;
    Result := False;
    with TheList do
    begin
      for I := Istart to Count - 1 do
        if TFileContent(Items[I]).Modified then
        begin
          Result := True;
          Istart := I + 1;
          ModifiedFile := TFileContent(Items[I]);
          Exit;
        end;
      Istart := Count;
    end;
  end;
begin
  Istart := 0;
  if (Memo1 <> nil) and Memo1.Modified then
  begin
    Memo1.Modified := False;
    ModifiedFile := TFileContent(CurrentFileContent);
    if (TheList <> nil) then
      ModifiedFile.Text := PChar(Memo1.Lines.Text);
  end;
  while Modified(Istart) do
  begin
    case (MessageDlg('Do you want to save changes in ' +
      string(ModifiedFile.FileName),
      mtConfirmation, [mbYes, mbNo, mbCancel, mbYesToAll,mbNoToAll], 0)) of
      mrYes: ModifiedFile.SaveFile;
      mrNo: ModifiedFile.Modified := False;
      mrNoToAll:
          with TheList do
          begin
            for I := 0 to Count - 1 do
              TFileContent(Items[I]).Modified:=False;
          end;
      mrYesToAll:
          with TheList do
          begin
            for I := 0 to Count - 1 do
              TFileContent(Items[I]).SaveFile;
          end;
      mrCancel:
        begin
          Action := caNone;
          ModalResult:=mrCancel;
          Exit;
        end;
    end;
  end;
  Action := caFree;
  ModalResult:=mrOK;
end;

procedure TViewForm.FormatToFile(FromFile, ToFile: string);
begin
  with MainForm.Formatter do
  begin
    Clear;
    OnProgress := nil;
    LoadFromFile(PChar(FromFile));
    if Parse then
      WriteToFile(PChar(ToFile));
  end;
  {Formatted := True;}
  UpdateStatusBar;
end;

{procedure TViewForm.FormatPascal;
var
  buff: array[0..400] of char;
  i, k: integer;
  CurLine: integer;
  oldLargeFile:boolean;
begin
  if (not Formatted) and (ProgressDlg <> nil)
     and (ProgressDlg.Visible) then
    with MainForm do
    begin
      OldLargeFile:=LargeFile;
      largeFile:=True;
      Formatter.Clear;
      ProgressDlg.FileLabel.Caption := self.Caption;
      Application.processMessages;
      with memo1.Lines do
        for i := 0 to count - 1 do
        begin
          Formatter.add(strPCopy(buff, memo1.Lines[i]));
          ProgressDlg.ProgressBar1.Position := i * 100 div count div 3;
        end;
      Formatter.Parse;
      ProgressDlg.ProgressBar1.Position := 66;
      Memo1.Lines.BeginUpdate;
      CurLine := SendMessage(Memo1.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
      Memo1.Clear;
      Memo1.Lines.Clear;
      i := 0;
      k := 0;
      with Formatter do
        while i < count do
        begin
          GetString(buff, i);
          inc(k);
          Memo1.Lines.add(buff);
          if (i mod 50 = 0) then
            ProgressDlg.ProgressBar1.Position := 66 + i * 100 div count div 3;
        end;
      if k <> Memo1.Lines.Count then
        Memo1.ReadOnly := True
      else
        LargeFile:=OldLargeFile;
      k := memo1.Lines.count - 1;
      while (Memo1.lines[k] = '') do
      begin
        Memo1.Lines.delete(k);
        dec(k);
      end;
      SendMessage(memo1.handle, EM_LINESCROLL, 0, curLine);
      memo1.Modified:=False;
      Memo1.Lines.EndUpdate;
      Formatted := True;
    end;
end;
 }

procedure TViewForm.FormatterProgress(Sender: TObject; Progress: Integer);
begin
  ProgressDlg.ProgressBar1.Position := Progress;
end;

procedure TViewForm.FormatPascal(TabNo: Integer);
var
  AFileContent: TFileContent;
  IsCurrentTab: Boolean;
begin
  if {(not Formatted) and }(ProgressDlg <> nil) and (TheList <> nil)
    and (ProgressDlg.Visible) then
    with MainForm do
    begin
      Formatter.OnProgress := FormatterProgress;
      Formatter.Clear;
      IsCurrentTab := TabNo = PageControl1.ActivePage.PageIndex;
      AFileContent := TFileContent(TheList.Items[TabNo]);
      ProgressDlg.SetFileName(AFileContent.FileName);
      ProgressDlg.ProgressBar1.Position := 0;
      Application.ProcessMessages;
      if IsCurrentTab then
      begin
        AFileContent.Text := PChar(Memo1.Lines.Text);
        Memo1.Modified := False;
      end;
      AFileContent.Format;
      if IsCurrentTab then
        TabSheet1Show(PageControl1.ActivePage);
      ProgressDlg.ProgressBar1.Position := 100;
       {
      Memo1.Lines.BeginUpdate;
      CurLine := SendMessage(Memo1.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
      Memo1.Lines.Clear;
      S := Formatter.Text;
      Memo1.Lines.Text := S;
      StrDispose(S);
      SendMessage(Memo1.Handle, EM_LINESCROLL, 0, CurLine);
      Memo1.Modified := False;
      Memo1.Lines.EndUpdate;
      Formatted := True;   }
      UpdateStatusBar;
    end;
end;

procedure TViewForm.Memo1Change(Sender: TObject);
begin
  TFileContent(CurrentFileContent).Formatted := False;
  Memo1.Modified := True;
  MainForm.UpdateMenu;
  UpdateStatusBar;
end;

function TViewForm.CurrentFileContent: TObject;
begin
  Result := TheList.Items[PageControl1.ActivePage.PageIndex];
end;

destructor TViewForm.Destroy;
var
  TheItem: TFileContent;
  Item: TObject;
  I: Integer;
begin
  inherited Destroy;
  with TheList do
    for I := 0 to Count - 1 do
    begin
      TheItem := TFileContent(Items[I]);
      if not GlobalFindFile(Item, I, TheItem.FileName) then
        TheItem.Free
      else
        Insert(I, nil);
    end;
  if MainForm <> nil then
    MainForm.UpdateMenu;
end;

procedure TViewForm.SetCurrentFileName(FileName: string);
var
  S: string;
  P: PChar;
begin
  Caption := ExpandFileName(FileName);
  TFileContent(CurrentFileContent).FileName := PChar(FileName);
  S := ExtractFileName(FileName);
  P := StrScan(PChar(S), '.');
  if P <> nil then P^ := #0;
  PageControl1.ActivePage.Caption := S;
end;

procedure TViewForm.Memo1Click(Sender: TObject);
begin
  MainForm.UpdateMenu;
  UpdateStatusBar;
end;

procedure TViewForm.FormActivate(Sender: TObject);
var
  FileContent: TFileContent;
begin
  MainForm.ViewForm := Self;
  Memo1.Parent := TTabSheet(PageControl1.ActivePage);
  Memo1.Modified := False;
  Memo1.ClearUndo;
  MemoReset;
  if TheList <> nil then
  begin
    FileContent := TFileContent(TheList.Items[PageControl1.ActivePage.PageIndex]);
    Memo1.Lines := FileContent.List;
    FileContent.SetMemoSettings(Memo1);
    Caption := string(FileContent.FileName);
  end;
  MainForm.UpdateMenu;
end;

procedure TViewForm.TabSheet1Show(Sender: TObject);
var
  FileContent: TFileContent;
begin
  Memo1.BeginUpdate;
  if TheList <> nil then
  begin
    FileContent := TFileContent(CurrentFileContent);
    if Memo1.Modified then
      FileContent.Text := PChar(Memo1.Lines.Text);
    FileContent.SaveMemoSettings(Memo1);
  end;
  Memo1.Parent := TTabSheet(Sender);
  Memo1.Modified := False;
  Memo1.ClearUndo;
  MemoReset;
  if TheList <> nil then
  begin
    FileContent := TFileContent(TheList.Items[TTabSheet(Sender).PageIndex]);
    Memo1.Lines := FileContent.List;
    FileContent.SetMemoSettings(Memo1);
    Caption := string(FileContent.FileName);
  end;
  Memo1.EndUpdate;
end;

procedure TViewForm.FormDestroy(Sender: TObject);
begin
  if MainForm <> nil then MainForm.ViewForm := nil;
end;

procedure TViewForm.MemoReset;
begin
  Memo1.TopLine := 0;
  Memo1.CaretX := 0;
  Memo1.CaretY := 0;
  SelStart := 0;
  SelLength := 0;
end;
{ TFileContent }

constructor TFileContent.Create(AFileName: string);
begin
  inherited Create;
  FileName := StrNew(PChar(ExpandFileName(AFileName)));
  FList := TStringList.Create;
  FList.LoadFromFile(FileName);
  Modified := False;
end;

destructor TFileContent.Destroy;
begin
  Text := nil;
  FileName := nil;
  inherited Destroy;
end;

procedure TFileContent.Format;
begin
  MainForm.Formatter.Clear;
  MainForm.Formatter.LoadFromList(FList);
  if MainForm.Formatter.Parse then
  begin
    Text := MainForm.Formatter.Text;
    Formatted := True;
  end;
end;

function TFileContent.GetText: PChar;
begin
  Result := PChar(FList.Text);
end;

procedure TFileContent.SaveFile;
var
  BakFile: array[0..255] of Char;
begin
  if Modified then
  begin
    MakeBakFile(BakFile, FileName);
    FList.SaveToFile(FileName);
  end;
  Modified := False;
end;

procedure TFileContent.SaveMemoSettings(AMemo: TmwCustomEdit);
begin
  FTopLine := AMemo.TopLine;
  FCaretX := AMemo.CaretX;
  FCaretY := AMemo.CaretY;
  FBlockStart := AMemo.BlockBegin;
  FBlockEnd := AMemo.BlockEnd;
end;

procedure TFileContent.SetFileName(const Value: PChar);
begin
  Modified := True;
  StrDispose(FFileName);
  FFileName := StrNew(PChar(ExpandFileName(string(Value))));
end;

procedure TFileContent.SetMemoSettings(AMemo: TmwCustomEdit);
begin
  with AMemo do
  begin
    TopLine := FTopLine;
    CaretX := FCaretX;
    CaretY := FCaretY;
    TopLine := FTopLine;
    BlockBegin := FBlockStart;
    BlockEnd := FBlockEnd;
  end;
end;

procedure TFileContent.SetText(const Value: PChar);
begin
  if Value = nil then
  begin
    FList.Free;
    FList := nil;
    Exit;
  end;
  if FList = nil then FList := TStringList.Create;
  FList.Text := string(Value);
  Modified := True;
end;

procedure TViewForm.FormatAll;
var
  I: Integer;
begin
  if TheList <> nil then
    with TheList do
      for I := 0 to Count - 1 do
        FormatPascal(I);
end;

procedure TViewForm.FormatFormatted;
var
  I: Integer;
  FileContent: TFileContent;
begin
  if TheList <> nil then
    with TheList do
      for I := 0 to Count - 1 do
      begin
        FileContent := TFileContent(Items[I]);
        if (FileContent <> nil) and FileContent.Formatted then
        begin
          FileContent.Formatted := False;
          FormatPascal(I);
        end;
      end;
end;

procedure TViewForm.FormatCurrent;
begin
  FormatPascal(PageControl1.ActivePage.PageIndex);
end;

procedure TViewForm.PageControl1Change(Sender: TObject);
begin
  MainForm.UpdateMenu;
  UpdateStatusBar;
end;

function TViewForm.AllFormatted: Boolean;
var
  I: Integer;
begin
  Result := True;
  if TheList <> nil then
    for I := 0 to TheList.Count - 1 do
      if not TFileContent(TheList.Items[I]).Formatted then
      begin
        Result := False;
        Exit;
      end;
end;

procedure TViewForm.ClosepageItemClick(Sender: TObject);
var
  I: Integer;
  DoubleFile: Boolean;
  TheContent, Item: TObject;
begin
  if SaveCurrent then
  begin
    I := PageControl1.ActivePage.PageIndex;
    PageControl1.ActivePage.Free;
    if TheList.Count = 1 then
      Close
    else
    begin
      TheContent := TheList.Items[I];
      TheList.Delete(I);
      if TheContent <> nil then
      begin
        DoubleFile := GlobalFindFile(Item, -1, TFileContent(TheContent).FileName);
        if not DoubleFile then
          TheContent.Free;
      end;
    end;
  end;
end;

function TViewForm.GlobalFindFile(var Item: TObject; NotIndex: Integer; FileName: PChar): Boolean;
var
  I: Integer;
  Child: TForm;
begin
  Result := False;
  with MainForm do
    if (MainForm=nil) or (MDIChildCount = 0) then
      Result := FindFile(Item, NotIndex, FileName)
    else
      for I := 0 to MDIChildCount - 1 do
      begin
        Child := MDIChildren[I];
        if Child is TViewForm then
          if Child = Self then
            Result := FindFile(Item, NotIndex, FileName)
          else
            Result := TViewForm(Child).FindFile(Item, -1, FileName);
        if Result then
          Exit;
      end;
end;

function TViewForm.FindFile(var Item: TObject; NotIndex: Integer; FileName: PChar): Boolean;
var
  I: Integer;
begin
  Result := False;
  if TheList <> nil then
    for I := 0 to TheList.Count - 1 do
      if (I <> NotIndex) and (TheList.Items[I] <> nil) and
        (StrIComp(TFileContent(TheList.Items[I]).FileName, FileName) = 0) then
      begin
        Item := TheList.Items[I];
        Result := True;
      end;
end;

function TViewForm.SaveCurrent: Boolean;
var
  ModifiedFile: TFileContent;
begin
  Result := True;
  ModifiedFile := TFileContent(CurrentFileContent);
  if Memo1.Modified then
  begin
    Memo1.Modified := False;
    if (TheList <> nil) then
      ModifiedFile.Text := PChar(Memo1.Lines.Text)
    else
      Exit;
  end;
  if ModifiedFile.Modified then
  begin
    case (MessageDlg('Do you want to save changes in ' +
      string(ModifiedFile.FileName),
      mtConfirmation, [mbYes, mbNo, mbCancel], 0)) of
      mrYes:
        ModifiedFile.SaveFile;
      mrCancel: Result := False;
    end;
  end;
end;

procedure TViewForm.Openneweditwindow1Click(Sender: TObject);
begin
  MainForm.ViewForm := nil;
  MainForm.PerformFileOpen(TFileContent(CurrentFileContent).FileName);
end;

procedure TViewForm.Formatpage1Click(Sender: TObject);
begin
  MainForm.FormatCurrentItemClick(nil);
end;

procedure TViewForm.FormDeactivate(Sender: TObject);
var
  FileContent: TFileContent;
begin
  if TheList <> nil then
  begin
    FileContent := TFileContent(CurrentFileContent);
    if Memo1.Modified then
      FileContent.Text := PChar(Memo1.Lines.Text);
    FileContent.SaveMemoSettings(Memo1);
  end;
end;

procedure TViewForm.Memo1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpdateStatusBar;
end;

function TViewForm.GelSelLength: Integer;
begin
  Result := Memo1.GetSelEnd - Memo1.GetSelStart;
end;

function TViewForm.GetSelStart: Integer;
begin
  Result := Memo1.GetSelStart;
end;

procedure TViewForm.SetSelLength(const Value: Integer);
begin
  with Memo1 do
    SetSelEnd(GetSelStart + Value);
end;

procedure TViewForm.SetSelStart(const Value: Integer);
begin
  Memo1.SetSelStart(Value);
end;

end.

