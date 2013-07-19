{|----------------------------------------------------------------------
 | Unit:        Setup1
 |
 | Author:      Egbert van Nes
 |
 | Description: Setup of DelForExp
 |
 | Copyright (c) 2000  Egbert van Nes
 |   All rights reserved
 |   Disclaimer and licence notes: see license.txt
 |
 |----------------------------------------------------------------------
}
unit Setup1;

interface

procedure Run;
function GetDelForName: string;

implementation
uses Registry, Windows, SysUtils, DelforEng;

var
  TheReg: TRegistry;
const
  DelphiRoot = '\Software\Borland\Delphi';
  Delphi20 = '\2.0';
  Delphi30 = '\3.0';
  Delphi40 = '\4.0';
  Delphi50 = '\5.0';
  Delphi60 = '\6.0';
  Delphi70 = '\7.0';
  Experts = '\Experts';
  OldTheExpert30 = 'DelForExp'; //Old name
  OldTheExpert20 = 'DelForEx'; //Old name
  TheExpert20 = 'DelForEx2';
  TheExpert30 = 'DelForEx3';
  TheExpert40 = 'DelForEx4';
  TheExpert50 = 'DelForEx5';
  TheExpert60 = 'DelForEx6'; //future
  TheExpert70 = 'DelForEx7';
  Dll = '.dll';
const
{$IFDEF Ver150}DelphiVersion: Byte = 7;
{$ELSE}
{$IFDEF Ver140}DelphiVersion: Byte = 6;
{$ELSE}
{$IFDEF Ver130}DelphiVersion: Byte = 5;
{$ELSE}
{$IFDEF Ver120}DelphiVersion: Byte = 4;
{$ELSE}
{$IFDEF Ver100}DelphiVersion: Byte = 3;
{$ELSE}
{$IFDEF Ver90}DelphiVersion: Byte = 2;
{$ELSE}
  DelphiVersion: Byte := 0;
{$ENDIF}{$ENDIF}{$ENDIF}{$ENDIF}{$ENDIF}{$ENDIF}
var
  Path: string;

procedure ShowMessage(S: string);
const
  Cap: PChar = 'Setup DelFor';
begin
  MessageBox(0, PChar(S), Cap, mb_Ok);
end;

procedure CopyFile(FromName, ToName: PChar);
{ Simple, fast file copy program with some error-checking }
var
  FromF, ToF: file;
  NumRead, NumWritten: Integer;
  Buf: array[1..2048] of Char;
begin
  AssignFile(FromF, FromName); { Open input file }
  try
    AssignFile(ToF, ToName); { Open output file }
    try
      Reset(FromF, 1); { Record size = 1 }
      try
        Rewrite(ToF, 1); { Record size = 1 }
      except
        on E: EInOutError do
          if E.Message = 'I/O error 32' then
          begin
            ShowMessage('Failed to copy file "' + FromName + '"'#10#13 +
              'Please close Delphi and try installing again');
          end;
      end;
      repeat
        BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
        BlockWrite(ToF, Buf, NumRead, NumWritten);
      until (NumRead = 0) or (NumWritten <> NumRead);
    finally
      CloseFile(ToF);
    end;
  finally
    CloseFile(FromF);
  end;
end;

procedure ShowOKMessage(ExpName, Delphi: string);
begin
  ShowMessage(ExpName + ' installed in ' + Delphi +
    #13'"Source formatter" should be the second item of the "Tools" menu,' +
    #13'Run SetupEx again to UnInstall');
end;

procedure Run;
var
  S, ExpName, PathName: string;
  {A: array[0..80] of Char;}
  HasDelphi2, HasDelphi3, HasDelphi4,
    HasDelphi5, HasDelphi6, HasDelphi7, HasPrevious, InstalledSomeThing: Boolean;
  procedure CheckVersion(const Dx: string; const HasDelphix: Boolean;
    const Delphixx, TheExpertxx: string);
  begin
    ExpName := TheExpertxx;
    PathName := Path + TheExpertxx + Dll;
    if HasDelphix and FileExists(PathName) then
      with TheReg do
      begin
        OpenKey(DelphiRoot + Delphixx + Experts, True);
        if HasPrevious then
        begin
          S := ReadString(ExpName);
          if (S <> '') then
          begin
            if not InstalledSomeThing then
            begin
              DeleteValue(ExpName);
              ShowMessage(ExpName + ' removed from ' + Dx);
            end
          end
          else
          begin
            if InstalledSomeThing then
            begin
              WriteString(ExpName, PathName);
              ShowOKMessage(ExpName, Dx);
            end;
          end;
        end
        else
        begin
          S := ReadString(ExpName);
          if S <> '' then
          begin
            DeleteValue(ExpName);
            ShowMessage(ExpName + ' removed from ' + Dx);
          end
          else
          begin
            InstalledSomeThing := True;
            WriteString(ExpName, PathName);
            ShowOKMessage(ExpName, Dx);
          end;
        end;
        HasPrevious := True;
      end;
  end;
begin
  TheReg := TRegistry.Create;
  try
    Path := ExtractFileDir(ParamStr(0)) + '\';
    with TheReg do
    begin
      RootKey := HKEY_CURRENT_USER;
      HasDelphi2 := OpenKey(DelphiRoot + Delphi20, False);
      HasDelphi3 := OpenKey(DelphiRoot + Delphi30, False);
      HasDelphi4 := OpenKey(DelphiRoot + Delphi40, False);
      HasDelphi5 := OpenKey(DelphiRoot + Delphi50, False);
      HasDelphi6 := OpenKey(DelphiRoot + Delphi60, False);
      HasDelphi7 := OpenKey(DelphiRoot + Delphi70, False);
      if not (HasDelphi2 or HasDelphi3 or HasDelphi4 or HasDelphi5 or HasDelphi6
      or HasDelphi7) then
        raise ERegistryException.Create('Delphi 2, 3, 4, 5, 6 or 7 not installed')
      else
      try
        InstalledSomeThing := False;
        HasPrevious := False;
        CheckVersion('Delphi 7', HasDelphi7, Delphi70, TheExpert70);
        CheckVersion('Delphi 6', HasDelphi6, Delphi60, TheExpert60);
        CheckVersion('Delphi 5', HasDelphi5, Delphi50, TheExpert50);
        CheckVersion('Delphi 4', HasDelphi4, Delphi40, TheExpert40);
        CheckVersion('Delphi 3', HasDelphi3, Delphi30, OldTheExpert30);
        CheckVersion('Delphi 3', HasDelphi3, Delphi30, TheExpert30);
        CheckVersion('Delphi 2', HasDelphi2, Delphi20, OldTheExpert20);
        CheckVersion('Delphi 2', HasDelphi2, Delphi20, TheExpert20);
        {if InstalledSomeThing then
          if FileExists(path + Delfordll) then
          begin
            GetSystemDirectory(@A, 80);
            CopyFile(Delfordll, StrCat(StrCat(A, '\'), Delfordll));
          end;  //not necessary anymore}
      finally
        CloseKey;
      end;
    end
  finally
    TheReg.Free;
  end;
end;

function GetDelForName: string;
var
  I: Integer;
begin
  TheReg := TRegistry.Create;
  try
    with TheReg do
    begin
      RootKey := HKEY_CURRENT_USER;
      Result := '';
      case DelphiVersion of
        7: if OpenKey(DelphiRoot + Delphi70 + Experts, False) then
            Result := ReadString(TheExpert70);
        6: if OpenKey(DelphiRoot + Delphi60 + Experts, False) then
            Result := ReadString(TheExpert60);
        5: if OpenKey(DelphiRoot + Delphi50 + Experts, False) then
            Result := ReadString(TheExpert50);
        4: if OpenKey(DelphiRoot + Delphi40 + Experts, False) then
            Result := ReadString(TheExpert40);
        3: if OpenKey(DelphiRoot + Delphi30 + Experts, False) then
            Result := ReadString(TheExpert30);
        2: if OpenKey(DelphiRoot + Delphi20 + Experts, False) then
            Result := ReadString(TheExpert20);
        0:
          begin
            I := 8;
            repeat
              Dec(I);
              DelphiVersion := I;
              Result := GetDelForName;
            until (Result <> '') or (I = 2);
            if I = 2 then Result := 'DelForExp.dll'
          end;
      end;
      CloseKey;
    end
  finally
    TheReg.Free;
  end;
end;

initialization
end.
