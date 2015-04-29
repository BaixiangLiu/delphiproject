
{*******************************************************}
{                                                       }
{       Delphi Visual Component Library Extension       }
{                                                       }
{       Copyright (c) 1996 Louis L.J.Wang               }
{                                                       }
{*******************************************************}

unit ImmAPI;

{$R-}

interface

uses
  Windows, SysUtils, Classes, Controls, ExtVCL;

{ Special keyboard layout handle definitions }

type
  TSpecialKbdLayout     = (klDefault, klSystem, klDefaultLocale, klLocale);
  TSpecialKbdLayoutName = array[TSpecialKbdLayout] of String;
  TSpecialKbdLayoutHKL  = array[TSpecialKbdLayout] of HKL;

{ Default language ID }

const
  LangID_Chinese_Traditional = $0404;
  SysLangID : Word = 0;

{ Keyboard layout name definitions }

const
  hKlListSize   = 64; { maximum size of keyboard layout table }

{ Reset HKL command ID }

const
  hKlResetDefault = $80000000;

type
  ThKlIndex = 0..hKlListSize-1;
  PhKlTable = ^ThKlTable;
  ThKlTable = array[ThKlIndex] of HKL;

{ Keyboard layout list object }

type
  ThKlList = class
  private
    FhKlList: PhKlTable;
    FhKlCount: ThKlIndex;
    function GetHandle(Index: ThKlIndex): HKL;
    function GetName(Index: ThKlIndex): String;
  public
    constructor Create;
    destructor Destroy; override;
    function GetLocaleFirstHKL(Locale: Word): HKL;
    procedure GethKlValues(Proc: TGetStrProc);
    function GethKlHandle(const hKlName: String): HKL;
    property Count: ThKlIndex read FhKlCount;
    property HKLHandle[Index: ThKlIndex]: HKL read GetHandle;
    property HKLName[Index: ThKlIndex]: String read GetName;
  end;

{ Set locale representation of special keyboard layouts }

procedure SetSpecialKbdLayoutNames(const NewName: TSpecialKbdLayoutName);

{ Get system description of keyboard layout }

function GetKeyboardLayoutDescription(hKl: HKL): String;

{ Translate keyboard layout to string }

function HKLToString(hKl: HKL): string;

{ Translate string to keyboard layout }

function StringToHKL(const S: string): HKL;

{ Translate keyboard layout to identifier }

function HKLToIdent(hKl: HKL; var Ident: String): boolean;

{ Translate identifier to keyboard layout }

function IdentToHKL(const Ident: String; var hKl: HKL): boolean;

{ Get values of available keyboard layout }

procedure GetHKLValues(Proc: TGetStrProc);

{ Get current keyboard layout }

function GetCurrentHKL: HKL;

{ Set current keyboard layout, including specials }

procedure SetCurrentHKL(hKl: HKL);

{ Save current keyboard layout, if special, for later reference }

procedure SaveCurrentHKL(var DefHKL: HKL);

{ Read DefaultHKL from system registry }

function ReadDefaultHKL(Control: TWinControl; DefHKL: HKL): HKL;

{ Write DefaultHKL to system registry }

procedure WriteDefaultHKL(Control: TWinControl; DefHKL: HKL);

{ Create popup menu with keyboard layout names }

function KbdLayoutMenu(DefHKL: HKL): TLocalMenu;

{ Call popup menu for locale controls }

function PopupKbdLayoutMenu(X, Y: Integer; DefHKL: HKL): HKL;

{ Select default HKL of locale control }

function SelectDefaultHKL(Control: TWinControl;
  X, Y: Integer; DefHKL, OriginHKL: HKL): HKL;

implementation

uses
  Forms, Registry;

{ Keyboard layout name definitions }

const
  klListSize   = 32; { maximum size of keyboard layout table }
  klDescLen    = 64; { maximun length of keyboard layout description }

  NameNeutral  = 'Language Neutral';

{ IMM module name }

  ImmDLL = 'imm32.dll';

{ Special keyboard layout names }

var
  SpecialKbdLayoutNames : TSpecialKbdLayoutName
    = ('Default', 'System', 'DefaultLocale', 'Locale');
  SpecialKbdLayoutHKLs  : TSpecialKbdLayoutHKL
    = (0, 0, 0, 0);

{ DLL function types and pointers }

type
  PFNImmGetDescription = ^TFNImmGetDescription;
  TFNImmGetDescription = function(hKl: HKL; PAnsiChar: PAnsiChar;
    uBufLen: UINT): UINT; stdcall;

  TSysHKLList = array[0..klListSize-1] of HKL;

{ Unit private data for DLL interface }

var
  ImmModule        : HModule = 0;
  ImmGetDescription: TFNImmGetDescription = nil;
  DefAppName       : String;

{ Unit private data for keyboard layout information }

  SysHKLList : TSysHKLList;
  SysHKLCount: 0..klListSize-1;

{ Initialize IMM32.DLL if required }

procedure InitImmDLL;
begin
  if ImmModule = 0 then
    ImmModule := LoadLibrary(ImmDLL);
end;

{ Set locale representation of special keyboard layouts }

procedure SetSpecialKbdLayoutNames(const NewName: TSpecialKbdLayoutName);
begin
  SpecialKbdLayoutNames := NewName;
end;

{ Get system description of keyboard layout }

function GetKeyboardLayoutDescription(hKl: HKL): String;
var
  Description: array[0..klDescLen] of AnsiChar;
  DescLen    : UINT;
begin
  if (hKl >= Ord(Low(TSpecialKbdLayout)))
    and (hKl <= Ord(High(TSpecialKbdLayout))) then
    Result := SpecialKbdLayoutNames[TSpecialKbdLayout(hKl)]
  else
  begin
    DescLen := 0;
    InitImmDLL;
    if @ImmGetDescription = nil then
      @ImmGetDescription := GetProcAddress(ImmModule, 'ImmGetDescriptionA');
    if @ImmGetDescription <> nil then
      DescLen := ImmGetDescription(hKl, @Description, klDescLen);
    if DescLen = 0 then
      DescLen := VerLanguageName(LoWord(hKl), @Description, klDescLen);
    Result := Trim(StrPas(Description))
  end;
end;

{ Translate keyboard layout to string }

function HKLToString(hKl: HKL): string;
begin
  if not HKLToIdent(hKl, Result) then
    FmtStr(Result, '$%.8x', [hKl]);
end;

{ Translate string to keyboard layout }

function StringToHKL(const S: string): HKL;
begin
  if not IdentToHKL(S, Result) then
    Result := StrToInt(S);
end;

{ Translate keyboard layout to identifier }

function HKLToIdent(hKl: HKL; var Ident: String): boolean;
begin
  Ident := GetKeyboardLayoutDescription(hKl);
  Result := (Ident <> '');
end;

{ Translate identifier to keyboard layout }

function IdentToHKL(const Ident: String; var hKl: HKL): boolean;
var
  hKlList: ThKlList;
begin
  hKlList := ThKlList.Create;
  hKl := hKlList.GethKlHandle(Ident);
  hKlList.Free;
  Result := (hKl <> -1);
end;

{ Get values of available keyboard layout }

procedure GetHKLValues(Proc: TGetStrProc);
var
  hKlList: ThKlList;
begin
  hKlList := ThKlList.Create;
  hKlList.GethKlValues(Proc);
  hKlList.Free;
end;

{ Get current keyboard layout }

function GetCurrentHKL: HKL;
begin
  Result := GetKeyboardLayout(0);
end;

{ Set current keyboard layout, including specials }

procedure SetCurrentHKL(hKl: HKL);
begin
  case TSpecialKbdLayout(LoWord(hKl)) of
    klDefault, klSystem, klDefaultLocale:
      hKl := SpecialKbdLayoutHKLs[TSpecialKbdLayout(hKl)];
    klLocale:
      LongRec(hKl).Lo := LoWord(SpecialKbdLayoutHKLs[TSpecialKbdLayout(hKl)]);
  end;
  if LoWord(hKl) <> 0 then ActivateKeyboardLayout(hKl,0);
end;

{ Save current keyboard layout, if special, for later reference }

procedure SaveCurrentHKL(var DefHKL: HKL);
var
  Handle: HKL;
begin
  Handle := GetCurrentHKL;
  if LoWord(Handle) = SysLangID then
    case TSpecialKbdLayout(LoWord(DefHKL)) of
      klLocale:
        LongRec(DefHKL).Hi := HiWord(Handle);
      klDefaultLocale:
        SpecialKbdLayoutHKLs[klDefaultLocale] := Handle;
    end;
end;

{ Get keyboard layout handle }

function ThKlList.GetHandle(Index: ThKlIndex): HKL;
var
  Temp : Integer;
begin
  Temp := -1;
  Result := Temp;
  if Index < FhKlCount then Result := FhKlList[Index];
end;

{ Get keyboard layout name }

function ThKlList.GetName(Index: ThKlIndex): String;
begin
  Result := '';
  if Index < FhKlCount then
    Result := GetKeyboardLayoutDescription(FhKlList[Index]);
end;

{ Obtain Keyboard layout list from system }

constructor ThKlList.Create;
begin
  inherited Create;
  fhKlList := nil;
  FhKlCount := GetKeyboardLayoutList(hKlListSize, FhKlList^);
  GetMem(FhKlList, SizeOf(HKL) * FhKlCount);
  FhKlCount := GetKeyboardLayoutList(FhKlCount, FhKlList^);
end;

{ Destroy ThKlList object }

destructor ThKlList.Destroy;
begin
  if FhKlList <> nil then
    FreeMem(FhKlList, SizeOf(HKL) * FhKlCount);
  inherited Destroy;
end;

{ Get first HKL of specified locale }

function ThKlList.GetLocaleFirstHKL(Locale: Word): HKL;
var
  Index: ThKlIndex;
begin
  for Index := 0 to FhKlCount -1 do
    if Locale = LoWord(FhKlList[Index]) then
    begin
      Result := FhKlList[Index];
      Exit;
    end;
  Result := 0;
end;

{ Get available Keyboard layout names }

procedure ThKlList.GethKlValues(Proc: TGetStrProc);
var
  hKl: TSpecialKbdLayout;
  I  : ThKlIndex;
begin
  for hKl := Low(TSpecialKbdLayout) to High(TSpecialKbdLayout) do
    Proc(SpecialKbdLayoutNames[hKl]);
  for I := 0 to FhKlCount - 1
    do Proc(GetKeyboardLayoutDescription(FhKlList[I]));
end;

{ Get handle value of given string }

function ThKlList.GethKlHandle(const hKlName: String): HKL;
var
  TheName: String;
  Special: TSpecialKbdLayout;
  Index  : ThKlIndex;
  Temp   : Integer;
begin
  Temp := -1;
  TheName := Trim(hKlName);
  for Special := Low(TSpecialKbdLayout) to High(TSpecialKbdLayout) do
    if CompareText(TheName, SpecialKbdLayoutNames[Special]) = 0 then
    begin
      Result := Ord(Special);
      Exit;
    end;
  for Index := 0 to FhKlCount - 1 do
    if CompareText(TheName, GetKeyboardLayOutDescription(FhKlList[Index])) = 0 then
    begin
      Result := FhKlList[Index];
      Exit;
    end;
  Result := Temp;
end;

{ Get registry key of controls DefaultHKL }

function RegHKLKey(Control: TWinControl): String;
begin
  if Application.Name <> '' then
    Result := 'Software\' + Application.Name
      + '\HKL\' + GetParentForm(Control).Name
  else
    Result := 'Software\' + DefAppName
      + '\HKL\' + GetParentForm(Control).Name;
end;

{ Read DefaultHKL from system registry }

function ReadDefaultHKL(Control: TWinControl; DefHKL: HKL): HKL;
begin
  Result := DefHKL;
  with TRegistry.Create do
  try
    if OpenKey(RegHKLKey(Control), False) then
    begin
      if ValueExists(Control.Name) then
        Result := ReadInteger(Control.Name)
      else 
        Result := DefHKL;
    end;
  finally
    Free;
  end;
end;

{ Write DefaultHKL to system registry }

procedure WriteDefaultHKL(Control: TWinControl; DefHKL: HKL);
begin
  with TRegistry.Create do
  try
    if OpenKey(RegHKLKey(Control), True) then
      try
        if DefHKL = hKlResetDefault then
          DeleteValue(Control.Name)
        else
          WriteInteger(Control.Name, DefHKL);
      except
        on ERegistryException do;
      end;
  finally
    Free;
  end;
end;

{ Create popup menu with keyboard layout names }

function KbdLayoutMenu(DefHKL: HKL): TLocalMenu;
const
  ResetName: array[Boolean] of String
           = ('Reset default', '还原默认值');
var
  LocMenu: TLocalMenu;
  hKl    : TSpecialKbdLayout;
  Index  : ThklIndex;
begin
  if LoWord(DefHKL) <= Ord(High(TSpecialKbdLayout)) then
    DefHKL := LoWord(DefHKL);
  LocMenu := TLocalMenu.Create;
  LocMenu.Add(ResetName[SysLangID = LangID_Chinese_Traditional],
    False, hKlResetDefault);
  LocMenu.Add('-', False, -1);
  for hKl := Low(TSpecialKbdLayout) to High(TSpecialKbdLayout) do
    LocMenu.Add(SpecialKbdLayoutNames[hKl], Ord(hKl) = DefHKL, Ord(hKl));
  LocMenu.Add('-', False, -1);
  with ThKlList.Create do
  begin
    for Index := 0 to Count - 1 do
      LocMenu.Add(HKLName[Index], HKLHandle[Index] = DefHKL,
        HKLHandle[Index]);
    Free;
  end;
  Result := LocMenu;
end;

{ Call popup menu for locale controls }

function PopupKbdLayoutMenu(X, Y: Integer; DefHKL: HKL): HKL;
begin
  with KbdLayoutMenu(DefHKL) do
  begin
    Result := Popup(X, Y);
    Free;
  end;
end;

{ Select default HKL of locale control }

function SelectDefaultHKL(Control: TWinControl;
  X, Y: Integer; DefHKL, OriginHKL: HKL): HKL;
var
  TempHKL: HKL;
begin
  with Control do
    if not Focused and CanFocus then SetFocus;
  Result := DefHKL;
  TempHKL := PopupKbdLayoutMenu(X, Y, DefHKL);
  if TempHKL <> -1 then
  begin
    WriteDefaultHKL(Control, TempHKL);
    if TempHKL = hKlResetDefault then TempHKL := OriginHKL;
    if Control.Focused then SetCurrentHKL(TempHKL);
    Result := TempHKL;
  end;
end;

{ Initialize ImmAPI library }

procedure InitializeImmAPI;
{ Special keyboard layout names in Traditional Chinese }
const
  ChineseHKLNames: TSpecialKbdLayoutName
    = ('不改变输入法', '系统预设输入法', '预设中文输入法', '中文输入法');
var
  Index: TSpecialKbdLayout;
begin
  SysLangID := GetSystemDefaultLangID;
  with ThKlList.Create do
  begin
    SpecialKbdLayoutHKLs[klSystem] := GetCurrentHKL;
    SpecialKbdLayoutHKLs[klLocale] := GetLocaleFirstHKL(SysLangID);
    SpecialKbdLayoutHKLs[klDefaultLocale] := GetLocaleFirstHKL(SysLangID);
    Free;
  end;
  if SysLangID = LangID_Chinese_Traditional then { Traditional Chinese }
    SetSpecialKbdLayoutNames(ChineseHKLNames)
  else
    for Index := Succ(Low(TSpecialKbdLayout)) to High(TSpecialKbdLayout) do
      SpecialKbdLayoutNames[Index] := SpecialKbdLayoutNames[Index] + ' ['
        + GetKeyboardLayoutDescription(SpecialKbdLayoutHKLs[Index]) + ']';
end;

initialization
  InitializeImmAPI;
  DefAppName := ExtractFileName(Application.ExeName);
  DefAppName := Copy(DefAppName, 1, AnsiPos('.', DefAppName)-1);
finalization
  if ImmModule <> 0 then FreeLibrary(ImmModule);
end.

