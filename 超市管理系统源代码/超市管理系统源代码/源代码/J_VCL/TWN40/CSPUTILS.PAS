
{*******************************************************}
{                                                       }
{       Delphi Runtime Library                          }
{       System Utilities Unit                           }
{                                                       }
{       Copyright (C) 1995,97 Borland International     }
{                                                       }
{*******************************************************}

unit CSPUtils;

interface

const
  nLunarEntries = 1472;
  nLunarYear = 60;

type
  TLunar = record
    GregYear: Longint;
    GregDay, GregMonth, LunarYear: Byte;
    LunarMonth: Shortint;
    LunarDay: Byte;
  end;
  PLunar = ^TLunar;
  TLunarLookup = array[0..nLunarEntries] of TLunar;
  TLunarYear = array[0..nLunarYear] of PChar;

  TDateRec = Record
    GregYear, LunarYear, wDay: Word;
    wMonth: Smallint;
  end;
  PDateRec = ^TDateRec;

{$I LUNARTBL.INC}

(***** Lunar date support functions *****)
function DaysInLunarMonth(PLunarDate: PDateRec): integer;
function DaysInGregorianMonth(PGregDate: PDateRec): integer;
function LunarYearName(index: Word): string;
function LunarYearNameToNumeric(const LunarYearName: String): integer;
function GregorianToLunarDate(PGregDate: PDateRec): Boolean;
function LunarToGregorianDate(PLunarDate: PDateRec): Boolean;

{ EncodeLunarDate encodes the given Gregorian year, Lunar year, month, and 
  day into a TDateTime value.  The Lunar year must be between 1 and 60, the 
  Lunar month must be between 1 and 12, and the Lunar day must be between 1 
  and N, where N is the number of days in the specified month.  The routine 
  is a wrapper to EncodeDate, but the date it processes is Lunar date. }
function EncodeLunarDate(GYear, LYear: Word; LMonth: SmallInt; LDay: Word): TDateTime;

{ DecodeLunarDate decodes the integral (date) part of the given TDateTime 
  value into its corresponding Gregorian, Lunar year, month, and day. If the 
  given TDateTime value is less than or equal to zero, the year, month, and 
  day return parameters are all set to zero. The routine is a wrapper to 
  DecodeDate, but the date it processes is Lunar date. }
procedure DecodeLunarDate(Date: TDateTime; var LYear: Word; 
                          var LMonth: SmallInt; var LDay: Word);

(***** Null-terminated MBCS string support functions *****)
function IsLeadByte(Chr: PChar): Boolean;
function AnsiStrCComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function AnsiStrCCopy(Dest, Source: PChar; MaxLen: Cardinal): PChar;
function AnsiStrLen(Str: PChar): Cardinal;
function AnsiStrCIComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function AnsiStrPCCopy(Dest: PChar; const Source: string; MaxLen: Cardinal): PChar;

(***** PASCAL type MBCS string support functions *****)
function AnsiCopy(S: string; Index, Count: Integer): string;
procedure AnsiDelete(var S: string; Index, Count: Integer);
procedure AnsiInsert(Source: string; var S: string; Index: Integer);
function AnsiLength(S: string): Integer;

(***** Localized routines that support Taiwanese Date/Time *****)

{ DateTimeToStrL converts a variable of type TDateTime to a string, the format
  of the returned date string is based on the value of Stat:
    0: the function returns Taiwanese date format
    1: the function returns Windows LongDateFormat
    2: the function returns Windows ShortDateFormat }
function DateTimeToStrL(Date: TDateTime; Stat: Byte): string;

{ DateTimeToStringL has the same functionality as DateTimeToString, except
  it supports token 'G' (Taiwanese year), the year return is Taiwanese
  Year (Ming Guo) and it supports Taiwanese date/time format }
procedure DateTimeToStringL(var Result: string; const Format: string;
  DateTime: TDateTime);

{ StrToDateL has the same functionality as StrToDate, except that the date
  format must be in either of the formats: "民國x年x月x日" or "x月x日" }
function StrToDateL(const S: string): TDateTime;

{ StrToTimeL has the same functionality as StrToTime, except that the 
  time value is prefixed by the "上午" or "下午" indicator }
function StrToTimeL(const S: string): TDateTime;

{ StrToDateTimeL has the same functionality as StrToDateTime, except that
  the date and time parts of the string must follow the formats described
  for the StrToDateL and StrToTimeL functions }
function StrToDateTimeL(const S: string): TDateTime;

{ TimeToStrL converts the time part of the given TDateTime value to a string.
  The conversion uses the format specified by the LocalTimeFormat global
  variable. }
function TimeToStrL(Time: TDateTime): string;

{$I CSP.INC}

implementation

uses SysUtils, Windows, Classes;

function IsLeadByte(Chr: PChar): Boolean;
begin
  Result := False;
  if Chr^ in LeadBytes then
    Result := True;
end;

function AnsiStrCComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  chlen, len: Integer;
begin
  if SysLocale.FarEast then
  begin
    chlen := CharToByteLen(String(Str1), MaxLen);
    len := CharToByteLen(String(Str2), MaxLen);
    if chlen < len then chlen := len;
    Result := AnsiStrLComp(Str1, Str2, chlen);
  end
  else
    Result := AnsiStrLComp(Str1, Str2, MaxLen);
end;

function AnsiStrCCopy(Dest, Source: PChar; MaxLen: Cardinal): PChar;
begin
  Result := StrLCopy(Dest, Source, CharToByteLen(String(Source), MaxLen));
end;

function AnsiStrLen(Str: PChar): Cardinal;
begin
  Result := ByteToCharLen(String(Str), StrLen(Str));
end;

function AnsiStrCIComp(Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  chlen, len: Integer;
begin
  if SysLocale.FarEast then
  begin
    chlen := CharToByteLen(String(Str1), MaxLen);
    len := CharToByteLen(String(Str2), MaxLen);
    if chlen < len then chlen := len;
    Result := AnsiStrLIComp(Str1, Str2, chlen);
  end
  else
    Result := AnsiStrLIComp(Str1, Str2, MaxLen);
end;                          

function AnsiStrPCCopy(Dest: PChar; const Source: string; MaxLen: Cardinal): PChar;
begin
  Result := StrLCopy(Dest, PChar(Source), CharToByteLen(Source, MaxLen));
end;

function AnsiCopy(S: string; Index, Count: Integer): string;
var
  P: PChar;
begin
  Result := '';
  if Index > ByteToCharLen(S, Length(S)) then exit;
  P := PChar(S) + CharToByteIndex(S, Index) - 1;
  SetString(Result, P, CharToByteLen(String(P), Count));
end;

procedure AnsiDelete(var S: string; Index, Count: Integer);
var
  P: PChar;
  bIndex: Integer;
begin
  if Index > ByteToCharLen(S, Length(S)) then exit;
  bIndex := CharToByteIndex(S, Index);
  P := PChar(S) + bIndex - 1;
  Delete(S, bIndex, CharToByteLen(String(P), Count));
end;

procedure AnsiInsert(Source: string; var S: string; Index: Integer);
begin
  Insert(Source, S, CharToByteIndex(S, Index));
end;

function AnsiLength(S: string): Integer;
begin
  Result := ByteToCharLen(S, Length(S));
end;

procedure DateTimeToStringL(var Result: string; const Format: string;
  DateTime: TDateTime);
begin
  DateTimeToString(Result, Format, DateTime);
end;

function DateTimeToStrL(Date: TDateTime; Stat: Byte): string;
var
  Hour, Min, Sec, MSec: Word;
  DateTimeStr: string;
begin
  case Stat of
    0:
     begin
       DateTimeToString(Result, 'geeee''年''M''月''d''日''', Date);
       DecodeTime(Date, Hour, Min, Sec, MSec);
       if (Hour <> 0) or (Min <> 0) or (Sec <> 0) then
       begin
         DateTimeToString(DateTimeStr, LongTimeFormat, Date);
         Result := Result + ' ' + DateTimeStr;
       end;
     end;
    1:
     begin
       DateTimeToString(Result, LongDateFormat, Date);
       DecodeTime(Date, Hour, Min, Sec, MSec);
       if (Hour <> 0) or (Min <> 0) or (Sec <> 0) then
       begin
         DateTimeToString(DateTimeStr, LongTimeFormat, Date);
         Result := Result + ' ' + DateTimeStr;
       end;
     end;
    2:
     begin
       DateTimeToString(Result, ShortDateFormat, Date);
       DecodeTime(Date, Hour, Min, Sec, MSec);
       if (Hour <> 0) or (Min <> 0) or (Sec <> 0) then
       begin
         DateTimeToString(DateTimeStr, LongTimeFormat, Date);
         Result := Result + ' ' + DateTimeStr;
       end;
     end;
  end;
end;

function TimeToStrL(Time: TDateTime): string;
begin
  DateTimeToString(Result, LongTimeFormat, Time);
end;

{ the following routines are copied from SysUtils.pas }
function CurrentYear: Word;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTime.wYear;
end;

function DoEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;
var
  I: Integer;
  DayTable: PDayTable;
begin
  Result := False;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= DayTable^[Month]) then
  begin
    for I := 1 to Month - 1 do Inc(Day, DayTable^[I]);
    I := Year - 1;
    Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
    Result := True;
  end;
end;

function DoEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;
begin
  Result := False;
  if (Hour < 24) and (Min < 60) and (Sec < 60) and (MSec < 1000) then
  begin
    Time := (Hour * 3600000 + Min * 60000 + Sec * 1000 + MSec) / MSecsPerDay;
    Result := True;
  end;
end;

procedure ScanToNumber(const S: string; var Pos: Integer);
begin
  while (Pos <= Length(S)) and not (S[Pos] in ['0'..'9']) do
  begin
    if S[Pos] in LeadBytes then Inc(Pos);
    Inc(Pos);
  end;
end;

procedure ScanBlanks(const S: string; var Pos: Integer);
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(S)) and (S[I] = ' ') do Inc(I);
  Pos := I;
end;

function ScanString(const S: string; var Pos: Integer;
  const Symbol: string): Boolean;
begin
  Result := False;
  if Symbol <> '' then
  begin
    ScanBlanks(S, Pos);
    if AnsiCompareText(Symbol, Copy(S, Pos, Length(Symbol))) = 0 then
    begin
      Inc(Pos, Length(Symbol));
      Result := True;
    end;
  end;
end;

function ScanNumber(const S: string; var Pos: Integer;
  var Number: Word): Boolean;
var
  I: Integer;
  N: Word;
begin
  Result := False;
  ScanBlanks(S, Pos);
  I := Pos;
  N := 0;
  while (I <= Length(S)) and (S[I] in ['0'..'9']) and (N < 1000) do
  begin
    N := N * 10 + (Ord(S[I]) - Ord('0'));
    Inc(I);
  end;
  if I > Pos then
  begin
    Pos := I;
    Number := N;
    Result := True;
  end;
end;

function ScanChar(const S: string; var Pos: Integer; Ch: Char): Boolean;
begin
  Result := False;
  ScanBlanks(S, Pos);
  if (Pos <= Length(S)) and (S[Pos] = Ch) then
  begin
    Inc(Pos);
    Result := True;
  end;
end;

function ScanTime(const S: string; var Pos: Integer;
  var Time: TDateTime): Boolean;
var
  BaseHour: Integer;
  Hour, Min, Sec: Word;
begin
  Result := False;
  BaseHour := -1;
  if ScanString(S, Pos, TimeAMString) or ScanString(S, Pos, 'AM') then
    BaseHour := 0
  else if ScanString(S, Pos, TimePMString) or ScanString(S, Pos, 'PM') then
    BaseHour := 12;
  if BaseHour >= 0 then ScanBlanks(S, Pos);
  if not ScanNumber(S, Pos, Hour) then Exit;
  Min := 0;
  if ScanChar(S, Pos, TimeSeparator) then
    if not ScanNumber(S, Pos, Min) then Exit;
  Sec := 0;
  if ScanChar(S, Pos, TimeSeparator) then
    if not ScanNumber(S, Pos, Sec) then Exit;
  if BaseHour < 0 then
    if ScanString(S, Pos, TimeAMString) or ScanString(S, Pos, 'AM') then
      BaseHour := 0
    else
      if ScanString(S, Pos, TimePMString) or ScanString(S, Pos, 'PM') then
        BaseHour := 12;
  if BaseHour >= 0 then
  begin
    if (Hour = 0) or (Hour > 12) then Exit;
    if Hour = 12 then Hour := 0;
    Inc(Hour, BaseHour);
  end;
  ScanBlanks(S, Pos);
  Result := DoEncodeTime(Hour, Min, Sec, 0, Time);
end;

procedure ConvertError(const Ident: string);
begin
  raise EConvertError.Create(Ident);
end;

procedure ConvertErrorFmt(const Ident: string; const Args: array of const);
begin
  raise EConvertError.CreateFmt(Ident, Args);
end;

type
  TDateOrder = (doMDY, doDMY, doYMD);

function GetDateOrder(const DateFormat: string): TDateOrder;
var
  I: Integer;
begin
  Result := doMDY;
  I := 1;
  while I <= Length(DateFormat) do
  begin
    case Chr(Ord(DateFormat[I]) and $DF) of
      'E': Result := doYMD;
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
    else
      Inc(I);
      Continue;
    end;
    Exit;
  end;
  Result := doMDY;
end;
{ the above routines are copied from SYSUtils.pas }

function ScanDateL(const S: string; var Pos: Integer;
  var Date: TDateTime): Boolean;
var
  Y, M, D: Word;
  FormatStr, EraName: string;
  SystemTime: TSystemTime;
  Buffer: array[Byte] of char;
  P: PChar;
begin
  Result := False;

  GetLocalTime(SystemTime);
  FormatStr := 'gg';
  GetDateFormat(GetThreadLocale, DATE_USE_ALT_CALENDAR, @SystemTime,
    PChar(FormatStr), Buffer, SizeOf(Buffer));
  EraName := Buffer;
  if (SysLocale.PriLangID = LANG_CHINESE) and 
     (SysLocale.SubLangID = SUBLANG_CHINESE_TRADITIONAL) and
     (ByteToCharLen(EraName, Length(EraName)) = 4) then
  begin
    P := Buffer + CharToByteIndex(EraName, 3) - 1;
    SetString(EraName, P, CharToByteLen(P, 2));
  end;
  if EraName = '' then Exit;

  if ScanString(S, Pos, EraName) then 
  begin
    if not ScanNumber(S, Pos, Y) then Exit;
    ScanToNumber(S, Pos);
    if not ScanNumber(S, Pos, M) then Exit;
    ScanToNumber(S, Pos);
    if not ScanNumber(S, Pos, D) then Exit;
    ScanToNumber(S, Pos);

    Y := Y + 1911;
  end
  else 
    begin
      if not ScanNumber(S, Pos, M) then Exit;
      ScanToNumber(S, Pos);
      if not ScanNumber(S, Pos, D) then Exit;
      ScanToNumber(S, Pos);

      Y := CurrentYear;
    end;
  Result := DoEncodeDate(Y, M, D, Date);
end;

function StrToDateL(const S: string): TDateTime;
var
  Pos: Integer;
begin
  Pos := 1;
  if not ScanDateL(S, Pos, Result) or (Pos <= Length(S)) then
    ConvertErrorFmt('''%s'' is not a valid date', [S]);
end;

function StrToTimeL(const S: string): TDateTime;
begin
  Result := StrToTime(S);
end;

function StrToDateTimeL(const S: string): TDateTime;
var
  Pos: Integer;
  Date, Time: TDateTime;
begin
  Pos := 1;
  Time := 0;
  if not ScanDateL(S, Pos, Date) or not ((Pos > Length(S)) or
    ScanTime(S, Pos, Time)) then
    ConvertErrorFmt('''%s'' is not a valid date and time', [S]);
  if Date >= 0 then
    Result := Date + Time else
    Result := Date - Time;
end;

function EncodeLunarDate(GYear, LYear: Word; LMonth: SmallInt; LDay: Word): TDateTime;
var
  daterec: TDateRec;
begin
  daterec.GregYear := GYear;
  daterec.LunarYear := LYear;
  daterec.wMonth := LMonth;
  daterec.wDay := LDay;
  if not LunarToGregorianDate(@daterec) then
    ConvertError(SLunarDateEncodeError);
  Result := EncodeDate(daterec.GregYear, daterec.wMonth, daterec.wDay);
end;

procedure DecodeLunarDate(Date: TDateTime; var LYear: Word; 
                          var LMonth: SmallInt; var LDay: Word);
var
  daterec: TDateRec;
  GYear, GMonth, GDay: Word;
begin
  DecodeDate(Date, GYear, GMonth, GDay);

  daterec.GregYear := GYear;
  daterec.wMonth := GMonth;
  daterec.wDay := GDay;
  if not GregorianToLunarDate(@daterec) then
    ConvertError(SLunarDateDecodeError);
  LYear := daterec.LunarYear;
  LMonth := daterec.wMonth;
  LDay := daterec.wDay;
end;

function DaysInGregorianMonth(PGregDate: PDateRec): integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[PGregDate^.wMonth];
  if (PGregDate^.wMonth = 2) and IsLeapYear(PGregDate^.GregYear) then 
    Inc(Result); { leap-year Feb is special }
end;

function DaysInLunarMonth(PLunarDate: PDateRec): integer;
var
  Ydiff, DupRec, YMatched, YMatchedM1: integer;
  lpThis, lpThat: PLunar;
  found: Boolean;
begin
  Result := 0;
  found := False;

  lpThis := @LunarLookup[0];

  { Index to specified GregYear in the LunarLookup table, and limit the 
    search to records of current GregYear, since in this case, GregYear is
    the primary search key.  Note that LunarLookup table must be organized
    in a sequential manner base on GregYear in order for this indexing
    to work }
  if PLunarDate^.GregYear <> lpThis^.GregYear then
  begin
    Ydiff := PLunarDate^.GregYear - lpThis^.GregYear;
    Ydiff := Ydiff * 12;
    if (Ydiff < 0) or (Ydiff > nLunarEntries) then Exit;
    lpThis := @LunarLookup[Ydiff];

    { Adjust the lpThis pointer due to leap months in the table }
    if lpThis^.GregYear >= PLunarDate^.GregYear then
      while (lpThis^.GregYear >= PLunarDate^.GregYear) and
            (lpThis^.GregMonth <> 1) do
        Dec(lpThis)  {back track to first record with the specified GregYear}
    else 
      if lpThis^.GregYear < PlunarDate^.GregYear then
        while lpThis^.GregYear < PLunarDate^.GregYear do
          Inc(lpThis);
  end;

  DupRec := 0;
  YMatched := 0;
  lpThat := lpThis;
  while PLunarDate^.GregYear = lpThat^.GregYear do
  begin
    if PlunarDate^.wMonth = lpThat^.LunarMonth then
    begin
      Inc(DupRec);
      YMatched := lpThat^.LunarYear;
    end;
    if Integer(lpThat) <= Integer(@LunarLookup[nLunarEntries]) then
      Inc(lpThat)
    else Exit;
  end;
  if YMatched = 1 then
    YMatchedM1 := 60
  else  YMatchedM1 := YMatched - 1;
  if (DupRec > 1) and not ((PlunarDate^.LunarYear = YMatched) or
     (PlunarDate^.LunarYear = YMatchedM1)) then
    ConvertError(SLunarDateDupLunarMonth);

  while PLunarDate^.GregYear = lpThis^.GregYear do
  begin
    if lpThis^.LunarMonth <> PLunarDate^.wMonth then
    begin
      Inc(lpThis);
      Continue;
    end;
    if (DupRec > 1) and (PLunarDate^.LunarYear <> lpThis^.LunarYear) then
    begin
      Inc(lpThis);
      Continue;
    end;
    found := True;
    break;
  end;

  if not found then
    Exit;

  Result := lpThis^.LunarDay;
end;

function DaysSince01011899(wYear, wMonth, wDay: Word): TDateTime;
var
  DateOrder: TDateOrder;
  datestr: string;
begin
  DateOrder := GetDateOrder(ShortDateFormat);
  case DateOrder of
    doMDY: datestr := IntToStr(wMonth) + DateSeparator + IntToStr(wDay) + DateSeparator + IntToStr(wYear);
    doDMY: datestr := IntToStr(wDay) + DateSeparator + IntToStr(wMonth) + DateSeparator + IntToStr(wYear);
    doYMD: datestr := IntToStr(wYear) + DateSeparator + IntToStr(wMonth) + DateSeparator + IntToStr(wDay);
  end;
  Result := StrToDate(datestr);
end;

function LunarYearName(index: Word): string;
begin
  Result := '';
  if (index >= 1) and (index <= 60) then 
    Result := LunarYear[index];
end;

function LunarYearNameToNumeric(const LunarYearName: String): integer;
var
  StrList: TStringList;
  I: Integer;
begin
  Result := 0;
  StrList := TStringList.Create;
  try
    StrList.Sorted := False;
    for I := 1 to 60 do
      StrList.Add(LunarYear[I]);
    if StrList.Count > 0 then
      Result := StrList.IndexOf(LunarYearName) + 1;
  finally
    StrList.Destroy;
  end;
end;

function GregorianToLunarDate(PGregDate: PDateRec): Boolean;
var
  delta, nthis: integer;
  lpThis: PLunar;
  DaysSinceNow, DaysSinceThis: TDateTime;
begin
  Result := False;
  DaysSinceThis := 0;

  DaysSinceNow := DaysSince01011899(PGregDate^.GregYear, PGregDate^.wMonth, PGregDate^.wDay);
  
  nthis := nLunarEntries - 1;
  delta := nthis;
  
  while True do
  begin
    lpThis := @LunarLookup[nthis];
    DaysSinceThis := DaysSince01011899(lpThis^.GregYear, lpThis^.GregMonth, lpThis^.GregDay);
    
    if delta = 0 then break;

    if DaysSinceThis > DaysSinceNow then
      Dec(nthis, delta)
    else
      Inc(nthis, delta);

    if (nthis < 0) or (nthis >= nLunarEntries) then
      Exit;

    if (delta <> 1) then
    begin
      Inc(delta, delta mod 2);
      delta := delta div 2;
    end
    else
      delta := 0;
  end;

  if DaysSinceThis > DaysSinceNow then
  begin
    Dec(nthis);
    lpthis := @LunarLookup[nthis];
    DaysSinceThis := DaysSince01011899(lpThis^.GregYear, lpthis^.GregMonth, lpThis^.GregDay);
  end;

  PGregDate^.GregYear := lpThis^.GregYear;
  PGregDate^.LunarYear := lpThis^.LunarYear;
  PGregDate^.wMonth := lpThis^.LunarMonth;
  PGregDate^.wDay := Trunc(DaysSinceNow - DaysSinceThis + 1);

  Result := True;
end;

function LunarToGregorianDate(PLunarDate: PDateRec): Boolean;
var
  Ydiff, DupRec, YMatched, YMatchedM1: integer;
  lpThis, lpThat: PLunar;
  DaysInMonth: integer;
begin
  Result := False;

  lpThis := @LunarLookup[0];

  { Index to specified GregYear in the LunarLookup table, and limit the 
    search to records of current GregYear, since in this case, GregYear is
    the primary search key.  Note that LunarLookup table must be organized
    in a sequential manner base on GregYear in order for this indexing
    to work }
  if PLunarDate^.GregYear <> lpThis^.GregYear then
  begin
    Ydiff := PLunarDate^.GregYear - lpThis^.GregYear;
    Ydiff := Ydiff * 12;
    if (Ydiff < 0) or (Ydiff > nLunarEntries) then Exit;
    lpThis := @LunarLookup[Ydiff];

    { Adjust the lpThis pointer due to leap months in the table }
    if lpThis^.GregYear >= PLunarDate^.GregYear then
      while (lpThis^.GregYear >= PLunarDate^.GregYear) and
            (lpThis^.GregMonth <> 1) do
        Dec(lpThis)  {back track to first record with the specified GregYear}
    else 
      if lpThis^.GregYear < PlunarDate^.GregYear then
        while lpThis^.GregYear < PLunarDate^.GregYear do
          Inc(lpThis);
  end;

  DupRec := 0;
  YMatched := 0;
  lpThat := lpThis;
  while PLunarDate^.GregYear = lpThat^.GregYear do
  begin
    if PlunarDate^.wMonth = lpThat^.LunarMonth then
    begin
      Inc(DupRec);
      YMatched := lpThat^.LunarYear;
    end;
    if Integer(lpThat) <= Integer(@LunarLookup[nLunarEntries]) then
      Inc(lpThat)
    else Exit;
  end;
  if YMatched = 1 then
    YMatchedM1 := 60
  else  YMatchedM1 := YMatched - 1;
  if (DupRec > 1) and not ((PlunarDate^.LunarYear = YMatched) or
     (PlunarDate^.LunarYear = YMatchedM1)) then
    ConvertError(SLunarDateDupLunarMonth);

  while PLunarDate^.GregYear = lpThis^.GregYear do
  begin
    if lpThis^.LunarMonth <> PLunarDate^.wMonth then
    begin
      Inc(lpThis);
      Continue;
    end;
    if (DupRec > 1) and (PLunarDate^.LunarYear <> lpThis^.LunarYear) then
    begin
      Inc(lpThis);
      Continue;
    end;
    Result := True;
    break;
  end;
  
  if not Result then 
    Exit;

  PLunarDate^.GregYear := lpThis^.GregYear;
  PLunarDate^.LunarYear := lpThis^.LunarYear;
  PLunarDate^.wMonth := lpThis^.GregMonth;

  DaysInMonth := DaysInGregorianMonth(PLunarDate);
  Inc(PLunarDate^.wDay, lpThis^.GregDay - 1);
  
  if PLunarDate^.wDay > DaysInMonth then
  begin
    Inc(PLunarDate^.wMonth);
    if PLunarDate^.wMonth > 12 then 
    begin
      Dec(PLunarDate^.wMonth, 12);
      Inc(PLunarDate^.GregYear);
    end;
    Dec(PLunarDate^.wDay, DaysInMonth);
  end;

  Result := True;
end;

end.
 
