unit DelForExpert;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, EditIntf, ExptIntf, ToolIntf, VirtIntf, StdCtrls,
  ExtCtrls, ComCtrls, OptDlg;

type

  TIDETextExpert = class(TIExpert)
  private
    MenuItem: TIMenuItemIntf;
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
    function HasShortCut(Menu: TIMainMenuIntf; Ch: Char): Boolean;
    procedure Execute; override;
  end;


function InitExpert(ToolServices: TIToolServices; RegisterProc:
  TExpertRegisterProc;
  var Terminate: TExpertTerminateProc): Boolean; stdcall;


var
  IDETextExpert: TIDETextExpert = nil;
implementation
uses DelExpert, Menus;

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
  Result := 'Delphi 3.0 source code formatter';
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

function TIDETextExpert.HasShortCut(Menu: TIMainMenuIntf; Ch: Char): Boolean;
var
  SubMenuItem, SubMenu, MenuItems: TIMenuItemIntf;
  short, I, j: Integer;
begin
  short := ShortCut(Word(Ch), [ssCtrl]);
  Result := False;
  if menu <> nil then
  begin
    MenuItems := Menu.GetMenuItems;
    if MenuItems <> nil then
    try
      for j := 0 to MenuItems.GetItemCount - 1 do
      begin
        SubMenu := MenuItems.GetItem(j);
        if SubMenu <> nil then
        try
          for I := 0 to SubMenu.GetItemCount - 1 do
          begin
            SubMenuItem := SubMenu.GetItem(I);
            if SubMenuItem <> nil then
            try
              if SubMenuItem.GetShortCut = short then
              begin
                Result := True;
                Exit;
              end;
            finally
              SubMenuItem.Free;
            end;
          end;
        finally
          SubMenu.DestroyMenuItem;
        end;
      end;
    finally
      MenuItems.DestroyMenuItem;
    end;
  end;
end;

constructor TIDETextExpert.Create;
var
  Ch: Char;
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
            Ch := 'D';
            while HasShortCut(Main, Ch) do
              inc(Ch);
            MenuItem.SetShortCut(ShortCut(Word(Ch), [ssCtrl]));
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
  if not assigned(DelExpertDlg) then
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

