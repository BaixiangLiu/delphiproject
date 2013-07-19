unit DelForExpert;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, EditIntf, ExptIntf, ToolIntf, VirtIntf, StdCtrls,
  ExtCtrls, ComCtrls, OptDlg, Menus;

type

  TIDETextExpert = class(TIExpert)
  private
    MenuItem: TIMenuItemIntf;
    function GetMenuShortCut: TShortCut;
    procedure SetMenuShortCut(AShortCut: TShortCut);
  protected
    procedure OnClick(Sender: TIMenuItemIntf); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetName: string; override;
    function GetStyle: TExpertStyle; override;
    function GetIDString: string; override;
    function GetAuthor: string; override;
    function GetComment: string; override;
    function GetPage: string; override;
    function GetGlyph: HICON; override;
    function GetState: TExpertState; override;
    function GetMenuText: string; override;
    property MenuShortCut: TShortCut read GetMenuShortCut write SetMenuShortCut;
    procedure Execute; override;
  end;

function InitExpert(ToolServices: TIToolServices; RegisterProc:
  TExpertRegisterProc;
  var Terminate: TExpertTerminateProc): Boolean; stdcall;

var
  IDETextExpert: TIDETextExpert = nil;
implementation
uses DelExpert;

{ TIDETextExpert code }

function TIDETextExpert.GetName: string;
begin
  Result := 'DelForExpert'
end;

function TIDETextExpert.GetAuthor: string;
begin
  Result := 'Egbert_van_Nes'; { author }
end;

function TIDETextExpert.GetStyle: TExpertStyle;
begin
  Result := esAddIn;
end;

function TIDETextExpert.GetMenuText: string;
begin
  Result := '&Source Formatter...';
end;

function TIDETextExpert.GetComment: string;
begin
  Result := 'Delphi 5.0 source code formatter';
end;

function TIDETextExpert.GetPage: string;
begin
end;

function TIDETextExpert.GetGlyph: HICON;
begin
  Result := 0;
end;

function TIDETextExpert.GetState: TExpertState;
begin
  Result := [];
end;

function TIDETextExpert.GetIDString: string;
begin
  Result := 'e_van_nes.DelForExpert';
end;

constructor TIDETextExpert.Create;
(*{$ifdef ver120}
var
  EditMenu: TMenuItem;
  InsertPosition: Integer;
  Item: TMenuItem;
  I: Integer;
begin
  ReferenceMenuItem := (BorlandIDEServices as INTAServices).MainMenu.Main.FindMenuItem('ToolsOptionsItem');
  InsertPosition := ReferenceMenuItem.GetIndex+1;
  for I := 0 to EditMenu.Count-1 do
    if CompareText(EditMenu[I].Name, 'EditSelectAll') = 0 then
    begin
      InsertPosition := I;
      Break;
      end;
  for I := PopupMenu1.Items.Count-1 downto 0 do  begin
    // Remove the item from the popup menu.
    Item := PopupMenu1.Items[I];
    PopupMenu1.Items.Delete(I);    // Then add it to Delphi's menu.
    EditMenu.Insert(InsertPosition, Item);  end;end;*)
var
  Main: TIMainMenuIntf;
  ReferenceMenuItem: TIMenuItemIntf;
  Menu: TIMenuItemIntf;
begin
  inherited Create;
  MenuItem := nil;
  if ToolServices <> nil then
  begin
    Main := ToolServices.GetMainMenu;
    if Main <> nil then
    begin
      try
        ReferenceMenuItem := Main.FindMenuItem('ToolsOptionsItem');
        if ReferenceMenuItem <> nil then
        try
          Menu := ReferenceMenuItem.GetParent;
          if Menu <> nil then
          try
            MenuItem := Menu.InsertItem(ReferenceMenuItem.GetIndex + 1,
              GetMenuText,
              'FormatExpertItem', '',
              0, 0, 0,
              [mfEnabled, mfVisible], OnClick);
          finally
            Menu.DestroyMenuItem;
          end;
        finally
          ReferenceMenuItem.DestroyMenuItem;
        end;
      finally
        Main.Free;
      end;
    end;
  end;
  DelExpertDlg := TDelExpertDlg.Create(Application);
end;

procedure TIDETextExpert.SetMenuShortCut(AShortCut: TShortCut);
begin
  MenuItem.SetShortCut(AShortCut);
end;

function TIDETextExpert.GetMenuShortCut: TShortCut;
begin
  if MenuItem <> nil then
    Result := MenuItem.GetShortCut
  else
    Result := ShortCut(Word('D'), [ssCtrl]);
end;

destructor TIDETextExpert.Destroy;
begin
  if MenuItem <> nil then MenuItem.DestroyMenuItem;
  {if assigned(OptionsDlg) then OptionsDlg.Free;}
  inherited Destroy;
end; {Destroy}

procedure TIDETextExpert.OnClick(Sender: TIMenuItemIntf);
begin
  Execute;
end;

procedure TIDETextExpert.Execute;
begin
  if not Assigned(DelExpertDlg) then
    DelExpertDlg := TDelExpertDlg.Create(Application);
  DelExpertDlg.ShowModal;
end;

function InitExpert(ToolServices: TIToolServices; RegisterProc:
  TExpertRegisterProc;
  var Terminate: TExpertTerminateProc): Boolean;
begin
  Result := True;
  try
    ExptIntf.ToolServices := ToolServices;
    Application.Handle := ToolServices.GetParentHandle;
    IDETextExpert := TIDETextExpert.Create;
    RegisterProc(IDETextExpert);
  except
    ToolServices.RaiseException(ReleaseException);
  end;
end;
end.

