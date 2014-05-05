unit DelFor;
uses SysUtils, OObjects;
interface
type
  TWordType = (wtLineFeed, wtSpaces, wtHalfComment, wtHalfStarComment,
    wtFullComment, wtString, wtErrorString, wtOperator, wtWord, wtNumber,
    wtNothing);
const
  ftNothing = 0;
  ftSpaceBefore = 1;
  ftSpaceAfter = 2;
  ftSpaceBoth = 3;
type
  TReservedType = (rtNothing, rtReserved, rtOper, rtDirective, rtIf, rtDo,
    rtWhile, rtVar, rtProcedure, rtAsm, rtTry, rtExcept, rtEnd, rtBegin, rtIfBegin,
    rtCase, rtOf, rtLineFeed, rtColon, rtSemiColon, rtThen, rtClass, rtProgram,
    rtRepeat, rtUntil, rtRecord, rtPrivate, rtElse, rtInterface, rtImplementation);
  TReservedFormat = (rfLowerCase, rfUpperCase, rfFirstUp, rfUnchanged);
  TReservedRec = record
    ReservedType: TReservedType;
    words: PChar;
  end;
const
  ngroups = 25;
type
  TReservedArray = array[0..ngroups - 1] of TReservedRec;
const
  ReservedArray: TReservedArray = (
    (ReservedType: rtOper; words:
    ',or,shl,xor,is,in,and,div,mod,shr,as,not,to,downto'),
    (ReservedType: rtOf; words: ',of'),
    (ReservedType: rtDirective; words: ',inline,exports,dispinterface'),
    (ReservedType: rtReserved; words: ',set,label,raise,array,file,nil,string,property,out,threadvar,goto,packed,inherited'),
    (ReservedType: rtProgram; words: ',library,uses,initialization,finalization,program,unit'),
    (ReservedType: rtInterface; words: ',interface'),
    (ReservedType: rtImplementation; words: ',implementation'),
    (ReservedType: rtVar; words: ',stringresource,const,var,type'),
    (ReservedType: rtAsm; words: ',asm'),
    (ReservedType: rtPrivate; words: ',private,protected,public,published'),
    (ReservedType: rtExcept; words: ',finally,except'),
    (ReservedType: rtClass; words: ',object,class'),
    (ReservedType: rtThen; words: ',then'),
    (ReservedType: rtBegin; words: ',begin'),
    (ReservedType: rtWhile; words: ',while,with,on,for'),
    (ReservedType: rtCase; words: ',case'),
    (ReservedType: rtProcedure; words: ',function,procedure,constructor,destructor'),
    (ReservedType: rtTry; words: ',try'),
    (ReservedType: rtIf; words: ',if'),
    (ReservedType: rtUntil; words: ',until'),
    (ReservedType: rtDo; words: ',do'),
    (ReservedType: rtRecord; words: ',record'),
    (ReservedType: rtRepeat; words: ',repeat'),
    (ReservedType: rtElse; words: ',else'),
    (ReservedType: rtEnd; words: ',end'));

type

  PPascalWord = ^TPascalWord;
  TPascalWord = object(TObject)
    constructor Create;
    function Expression: PChar; virtual;
    function WordType: TWordType; virtual;
    function space(Before: Boolean): Boolean; virtual;
    function ReservedType: TReservedType; virtual;
    procedure SetSpace(Before, State: Boolean); virtual;
    procedure SetReservedType(aReservedType: TReservedType); virtual;
    function GetEString(Dest: PChar): PChar; virtual;
  end;

  PLineFeed = ^TLineFeed;
  TLineFeed = object(TPascalWord)
    nSpaces: Integer;
    oldnSpaces: Integer;
    constructor Create(aOldnSpaces: Integer);
    procedure SetIndent(n: Integer);
    procedure IncIndent(n: Integer);
    function ReservedType: TReservedType; virtual;
    function GetEString(Dest: PChar): PChar; virtual;
  end;

  PExpression = ^TExpression;
  TExpression = object(TPascalWord)
    FExpression: PChar;
    FWordType: TWordType;
    FFormatType: byte;
    FReservedType: TReservedType;
    constructor Create(aType: TWordType; aExpression: PChar);
    procedure SetExpression(aExpression: PChar);
    procedure SetSpace(Before, State: Boolean); virtual;
    procedure SetReservedType(aReservedType: TReservedType); virtual;
    function space(Before: Boolean): Boolean; virtual;
    function GetEString(Dest: PChar): PChar; virtual;
    function Expression: PChar; virtual;
    function WordType: TWordType; virtual;
    function ReservedType: TReservedType; virtual;
    destructor done; virtual;
  end;

  TPascalParser = object(TObject)
    fileText: TCollection;
    parsedText: TCollection;
    spaceOperators: Boolean;
    spaceColons: Boolean;
    reservedFormat: TReservedFormat;
    changeIndent: Boolean;
    indentBegin: Boolean;
    SpacePerIndent: Integer;
    nIndent: Integer;
    constructor Create;
    procedure LoadFile(AFileName: PChar);
    procedure Parse;
    procedure CalcIndent;
    function ReadHalfComment(Dest, source: PChar; prevType: TWordType): TWordType;
    procedure CheckReserved(PascalWord: PPascalWord);
    function ReadWord(Dest, source: PChar): TWordType;
    function GetString(Dest: PChar; var I: Integer): PChar;
    procedure WriteToFile(AFileName: PChar);
    destructor Destroy;
  end;

var
  Formatter: TPascalParser;
  InFile, outFile: string;
  Dest: array[0..250] of Char;

implementation

constructor TPascalParser.Create;
begin
  spaceOperators := True;
  spaceColons := True;
  reservedFormat := rfLowerCase;
  changeIndent := True;
  indentBegin := False;
  SpacePerIndent := 2;
  fileText {:=TCollection.Create)}.init(500, 500);
end;

procedure TPascalParser.LoadFile(AFileName: PChar);
var
  InFile: Text;
  buff: array[0..400] of Char;
  aWord: array[0..400] of Char;
  WordType: TWordType;
  PrevLine: PLineFeed;
begin
  assign(InFile, AFileName);
  reset(InFile);
  WordType := wtNothing;
  while not eof(InFile) do
  begin
    readln(InFile, buff);
    while buff[0] <> #0 do
    begin
      case WordType of
        wtHalfComment, wtHalfStarComment:
          WordType := ReadHalfComment(aWord, buff, WordType);
      else WordType := ReadWord(aWord, buff);
      end;
      if not (WordType = wtSpaces) then
        fileText.Insert(New(PExpression, Create(WordType, aWord)))
      else if PrevLine^.nSpaces = -1 then
      begin
        PrevLine^.nSpaces := StrLen(aWord);
        PrevLine^.oldnSpaces := StrLen(aWord);
      end;
    end;
    PrevLine := New(PLineFeed, Create(-1));
    fileText.Insert(PrevLine);
  end;
  Close(InFile);
end;

function TPascalParser.ReadWord(Dest, source: PChar): TWordType;
const
  operators = '+-*/=<>[].,():;{}@^';
  allOper = operators + ' {}''';
var
  Result: TWordType;
  P: PChar;
begin
  P := source;
  if P^ = ' ' then
  begin
    Result := wtSpaces;
    while (P^ = ' ') and (P^ <> #0) do inc(P);
    dec(P);
  end
  else if P^ = '{' then
  begin
    Result := wtHalfComment;
    while (P^ <> '}') and (P^ <> #0) do inc(P);
    if (P^ = '}') then Result := wtFullComment;
  end
  else if strLComp(P, '(*', 2) = 0 then
  begin
    Result := wtHalfStarComment;
    while (strLComp(P, '*)', 2) <> 0) and (P^ <> #0) do inc(P);
    if strLComp(P, '*)', 2) = 0 then Result := wtFullComment;
  end
  else if strLComp(P, '//', 2) = 0 then
  begin
    Result := wtFullComment;
    P := StrEnd(P);
  end
  else if P^ = '''' then
  begin
    Result := wtString;
    inc(P);
    while (P^ <> '''') and (P^ <> #0) do inc(P);
    if (P^ = #0) then Result := wtErrorString;
  end
  else if StrScan(operators, P^) <> nil then
  begin
    Result := wtOperator;
    if strLComp(P, '<=', 2) = 0 then inc(P);
    if strLComp(P, '>=', 2) = 0 then inc(P);
    if strLComp(P, '<>', 2) = 0 then inc(P);
    if strLComp(P, ':=', 2) = 0 then inc(P);
    if strLComp(P, '..', 2) = 0 then inc(P);
    if strLComp(P, '(.', 2) = 0 then inc(P);
    if strLComp(P, '.)', 2) = 0 then inc(P);
  end
  else if P^ in ['0'..'9', '$', '#'] then
  begin
    Result := wtNumber;
    while (P^ in ['0'..'9', '.', '$', '#']) and not (strLComp(P, '..', 2) = 0) do
      inc(P);
    if upCase(P^) = 'E' then
      if (P + 1)^ in ['0'..'9', '-'] then
      begin
        inc(P, 2);
        while (P^ in ['0'..'9']) do inc(P);
      end;
    dec(P);
  end
  else
  begin
    Result := wtWord;
    while (StrScan(allOper, P^) = nil) and (P^ <> #0) do
      inc(P);
    dec(P);
  end;
  strLCopy(Dest, source, P - source + 1);
  if (P^ = #0) then
    source^ := #0
  else
  begin
    if ((P + 1)^ = ' ') then inc(P);
    StrCopy(source, P + 1);
  end;
  ReadWord := Result;
end;

function TPascalParser.ReadHalfComment(Dest, source: PChar; prevType: TWordType): TWordType;
var
  P: PChar;
begin
  P := source;
  ReadHalfComment := prevType;
  if prevType = wtHalfComment then
  begin
    while (P^ <> '}') and (P^ <> #0) do inc(P);
    if (P^ = '}') then
    begin
      ReadHalfComment := wtFullComment;
      inc(P);
    end;
  end
  else
  begin
    while (strLComp(P, '*)', 2) <> 0) and (P^ <> #0) do inc(P);
    if strLComp(P, '*)', 2) = 0 then
    begin
      ReadHalfComment := wtFullComment;
      inc(P);
    end;
  end;
  strLCopy(Dest, source, P - source + 1);
  if P^ = #0 then
    source^ := #0
  else
  begin
    if ((P + 1)^ = ' ') then inc(P);
    StrCopy(source, P);
  end;
end;

procedure TPascalParser.CheckReserved(PascalWord: PPascalWord);
var
  P, P1, p2: PChar;
  l, I: Integer;
  buf: array[0..80] of Char;
begin
  PascalWord^.SetReservedType(rtNothing);
  P := strLower(StrCopy(buf, PascalWord^.Expression));
  l := StrLen(P);
  if P <> nil then
    for I := 0 to ngroups - 1 do
      with ReservedArray[I] do
      begin
        P1 := strPos(words, P);
        if P1 <> nil then
        begin
          p2 := P1 + l;
          if (p2^ in [#0, ',']) and ((P1 - 1)^ = ',') then
          begin
            PascalWord^.SetReservedType(ReservedType);
            Exit;
          end;
        end;
      end;
end;

procedure TPascalParser.Parse;
var
  P: PChar;
  PascalWord, next, prev: PPascalWord;
  I: Integer;
begin
  prev := nil;
  with fileText do
    for I := 0 to Count - 1 do
    begin
      PascalWord := PPascalWord(at(I));
      P := PascalWord^.Expression;
      PascalWord^.SetSpace(True, False);
      PascalWord^.SetSpace(False, False);
      if PascalWord^.WordType = wtWord then CheckReserved(PascalWord);
      if StrComp(P, ':') = 0 then PascalWord^.SetReservedType(rtColon);
      if StrComp(P, ';') = 0 then PascalWord^.SetReservedType(rtSemiColon);
      if spaceOperators and (PascalWord^.ReservedType in [rtOper, rtThen, rtOf]) then
      begin
        PascalWord^.SetSpace(True, True);
        PascalWord^.SetSpace(False, True);
      end;
      if (PascalWord^.ReservedType <> rtNothing) then
      begin
        case reservedFormat of
          rfUpperCase: strUpper(P);
          rfLowerCase: strLower(P);
          rfFirstUp:
            begin
              strLower(P);
              P^ := upCase(Char(P^));
            end;
        end;
      end;
      if PascalWord^.ReservedType in [rtDo] then
        PascalWord^.SetSpace(True, True);
      if PascalWord^.ReservedType in [rtIf, rtWhile] then
        PascalWord^.SetSpace(False, True);
  {append space after : , ;}
      if spaceColons and
        ((StrComp(P, ':') = 0) or (StrComp(P, ';') = 0) or
        (StrComp(P, ',') = 0)) then
        PascalWord^.SetSpace(False, True);

  {both sides spaces with = := < > - * + /}
      if spaceOperators and ((StrComp(P, '=') = 0) or (StrComp(P, ':=') = 0) or
        (StrComp(P, '-') = 0) or (StrComp(P, '+') = 0) or (StrComp(P, '/') = 0)
        or (StrComp(P, '*') = 0) or (P^ = '<') or (P^ = '>')) then
      begin
        PascalWord^.SetSpace(False, True);
        PascalWord^.SetSpace(True, True);
      end;

  {delimiter between 2 words (necesary)}
      if (prev <> nil) then
      begin
        if PascalWord^.space(True) and
          prev^.space(False) then prev^.SetSpace(False, False);
        if (prev^.WordType in [wtWord, wtNumber]) and
          (PascalWord^.WordType in [wtWord, wtNumber]) and not
          PascalWord^.space(True) and not prev^.space(False) then
          PascalWord^.SetSpace(True, True);
      end;
      prev := PascalWord;
    end;
  CalcIndent;
end;

procedure TPascalParser.CalcIndent;
type
  TRec = record
    RT: TReservedType;
    nInd: Integer;
  end;
var
  P: PChar;
  PrevLineFeed: PLineFeed;
  I: Integer;
  stack: array[0..100] of TRec;
  stackptr: Integer;
  rtype: TReservedType;
  PasWord: PPascalWord;
  wrapped, WrapIndent: Boolean;
  procIndent: Integer;
  interfacePart: Boolean;
  procedure Push(R: TReservedType; n, ninc: Integer);
  begin
    inc(stackptr);
    with stack[stackptr] do
    begin
      RT := R;
      nInd := n;
      nIndent := n + ninc;
    end;
  end;
  function GetStackTop: TReservedType;
  begin
    if stackptr >= 0 then
      GetStackTop := stack[stackptr].RT
    else
      GetStackTop := rtNothing;
  end;
  function Pop: TReservedType;
  begin
    if stackptr >= 0 then
    begin
      nIndent := stack[stackptr].nInd;
      Pop := stack[stackptr].RT;
      dec(stackptr);
    end
  end;
  function GetNext: PPascalWord;
  begin
    with fileText do
      if I < Count - 1 then
        GetNext := PPascalWord(at(I + 1))
      else
        GetNext := nil;
  end;

  procedure SetPrevIndent;
  begin
    if PrevLineFeed <> nil then
      PrevLineFeed^.SetIndent(nIndent);
  end;
  procedure DecPrevIndent;
  begin
    if PrevLineFeed <> nil then
      PrevLineFeed^.IncIndent(-1);
  end;
  procedure CheckIndent(var PascalWord: PPascalWord);
  var
    next: PPascalWord;
    rtype2, lastPop: TReservedType;
    J, k: Integer;
  begin
    rtype := PascalWord^.ReservedType;
    if rtype <> rtNothing then
    begin
      case rtype of
        rtIf:
          if GetStackTop <> rtElse then
            Push(rtype, nIndent + 1, 0)
          else
          begin
            Pop;
            Push(rtElse, nIndent, 0);
          end;
        rtThen:
          if GetStackTop in [rtIf, rtElse] then
          begin
            WrapIndent := False;
            Pop;
            Push(rtype, nIndent, 0);
          end;
        rtColon:
          if GetStackTop = rtOf then
          begin
            WrapIndent := False;
            Push(rtype, nIndent, 0);
            DecPrevIndent;
          end;
        rtElse:
          if GetStackTop in [rtThen, rtColon, rtOf] then
          begin
            WrapIndent := False;
            Pop;
            Push(rtype, nIndent, 0);
            DecPrevIndent;
          end;
        rtWhile:
          Push(rtype, nIndent, 0);
        rtRepeat, rtTry:
          Push(rtype, nIndent, 1);
        rtClass, rtRecord:
          begin
            WrapIndent := False;
            next := GetNext;
            rtype2 := next^.ReservedType;
            if (next <> nil) and ((StrComp(next^.Expression, '(') = 0) or
              (next^.ReservedType in [rtLineFeed, rtPrivate])) then
              Push(rtype, nIndent, 1);
          end;
        rtUntil:
          begin
            Pop;
            SetPrevIndent;
          end;
        rtExcept, rtPrivate: DecPrevIndent;
        rtDo, rtOf:
          begin
            if GetStackTop in [rtWhile, rtCase] then
            begin
              Pop;
              Push(rtype, nIndent, 1);
              WrapIndent := False;
            end;
          end;
        rtLineFeed:
          begin
            if WrapIndent and not wrapped then
            begin
              inc(nIndent);
              wrapped := True;
            end;
            next := GetNext;
            WrapIndent := not ((next <> nil) and (next^.ReservedType in
              [rtLineFeed, rtRepeat, rtVar, rtElse, rtBegin, rtProgram]));
            PrevLineFeed := PLineFeed(PascalWord);
            SetPrevIndent;
          end;
        rtAsm:
          begin
            with fileText do
              while (I < fileText.Count - 1) and
                (PPascalWord(at(I))^.ReservedType <> rtEnd) do
              begin
                if PPascalWord(at(I))^.ReservedType = rtLineFeed then
                  with PLineFeed(at(I))^ do nSpaces := oldnSpaces;
                inc(I);
              end;
          end;
        rtProgram:
          begin
            stackptr := -1;
            nIndent := 0;
            SetPrevIndent;
          end;
        rtProcedure:
          begin
            while GetStackTop = rtVar do
            begin
              Pop;
              SetPrevIndent;
            end;
            if (GetStackTop <> rtClass) and not interfacePart then
            begin
              nIndent := procIndent;
              inc(procIndent);
            end;
          end;
        rtInterface: interfacePart := True;
        rtImplementation: interfacePart := False;
        rtBegin:
          begin
            if not indentBegin and (GetStackTop in [rtDo, rtThen, rtElse]) then
              Push(rtIfBegin, nIndent, 0)
            else if GetStackTop = rtVar then
            begin
              Pop;
              Push(rtype, nIndent, 1);
            end
            else
              Push(rtype, nIndent, 1);
            SetPrevIndent;
            DecPrevIndent;
          end;
        rtVar:
          begin
            if GetStackTop <> rtVar then
              Push(rtype, nIndent, 1)
            else
              DecPrevIndent;
          end;
        rtCase:
          if GetStackTop <> rtRecord then
            Push(rtype, nIndent, 1)
          else inc(nIndent);
        rtEnd:
          begin
            WrapIndent := False;
            if procIndent > 0 then dec(procIndent);
            lastPop := Pop;
            while (stackptr >= 0) and not
              (lastPop in [rtClass, rtRecord, rtTry, rtCase, rtColon,
              rtIfBegin, rtBegin]) do
              lastPop := Pop;
            SetPrevIndent;
            if (not indentBegin) and (lastPop = rtIfBegin) then
              DecPrevIndent;
          end;
        rtSemiColon:
          begin
            if wrapped then dec(nIndent);
            wrapped := False;
            while GetStackTop in [rtDo, rtWhile, rtThen, rtElse, rtColon] do
              lastPop := Pop;
            WrapIndent := False;
            if lastPop in [rtThen, rtElse] then
            begin
              dec(nIndent);
              lastPop := rtNothing;
            end;
          end;
      end;
    end;
  end;
begin
  if changeIndent then
  begin
    wrapped := False;
    WrapIndent := True;
    interfacePart := False;
    nIndent := 0;
    procIndent := 0;
    stackptr := -1;
    I := 0;
    with fileText do
      while I < Count do
      begin
        PasWord := PPascalWord(at(I));
        rtype := PasWord^.ReservedType;
        P := PasWord^.Expression;
        CheckIndent(PasWord);
        inc(I);
      end;
  end;
end;

function TPascalParser.GetString(Dest: PChar; var I: Integer): PChar;
var
  PasWord: PPascalWord;
  P: PChar;
begin
  GetString := Dest;
  Dest^ := #0;
  P := Dest;
  with fileText do
    if (I < Count) then
    begin
      PasWord := PPascalWord(at(I));
      repeat
        P := PasWord^.GetEString(P);
        inc(I);
        if I < Count then PasWord := PPascalWord(at(I));
      until (I >= Count) or (PasWord^.ReservedType = rtLineFeed);
    end;
end;

procedure TPascalParser.WriteToFile(AFileName: PChar);
var
  outFile: Text;
  I: Integer;
  A: array[0..800] of Char;
begin
  assign(outFile, AFileName);
  Rewrite(outFile);
  I := 0;
  with fileText do
    while I < Count do
      writeln(outFile, GetString(A, I));
  Close(outFile);
end;

destructor TPascalParser.Destroy;
begin
  inherited done;
  fileText.done;
end;

constructor TPascalWord.Create;
begin
  inherited init;
end;

function TPascalWord.Expression: PChar;
begin
  Expression := nil;
end;

function TPascalWord.WordType: TWordType;
begin
  WordType := wtLineFeed;
end;

function TPascalWord.space(Before: Boolean): Boolean;
begin
  space := False;
end;

procedure TPascalWord.SetSpace(Before, State: Boolean);
begin
end;

function TPascalWord.ReservedType: TReservedType;
begin
  ReservedType := rtNothing;
end;

procedure TPascalWord.SetReservedType(aReservedType: TReservedType);
begin
end;

function TPascalWord.GetEString(Dest: PChar): PChar;
begin
  Abstract;
end;

constructor TExpression.Create(aType: TWordType; aExpression: PChar);
begin
  FWordType := aType;
  FFormatType := ftNothing;
  FReservedType := rtNothing;
  FExpression := nil;
  SetExpression(aExpression);
end;

procedure TExpression.SetExpression(aExpression: PChar);
begin
  StrDispose(FExpression);
  FExpression := StrNew(aExpression);
end;

function TExpression.Expression: PChar;
begin
  Expression := FExpression;
end;

function TExpression.WordType: TWordType;
begin
  WordType := FWordType;
end;

function TExpression.space(Before: Boolean): Boolean;
begin
  if Before then
    space := FFormatType and ftSpaceBefore > 0
  else
    space := FFormatType and ftSpaceAfter > 0;
end;

function TExpression.ReservedType: TReservedType;
begin
  ReservedType := FReservedType;
end;

destructor TExpression.done;
begin
  SetExpression(nil);
  inherited done;
end;

procedure TExpression.SetSpace(Before, State: Boolean);
var
  b: byte;
begin
  if Before then
    b := ftSpaceBefore
  else
    b := ftSpaceAfter;
  if State then
    FFormatType := FFormatType or b
  else
    FFormatType := FFormatType and not b;
end;

procedure TExpression.SetReservedType(aReservedType: TReservedType);
begin
  FReservedType := aReservedType;
end;

function TExpression.GetEString(Dest: PChar): PChar;
begin
  if space(True) then Dest := strECopy(Dest, ' ');
  Dest := strECopy(Dest, Expression);
  if space(False) then Dest := strECopy(Dest, ' ');
  GetEString := Dest;
end;

function strSpace(Dest: PChar; n: Integer): PChar;
var
  I: Integer;
begin
  strSpace := Dest;
  for I := 0 to n - 1 do
  begin
    Dest^ := ' ';
    inc(Dest);
  end;
  Dest^ := #0;
end;

function TLineFeed.ReservedType: TReservedType;
begin
  ReservedType := rtLineFeed;
end;

constructor TLineFeed.Create(aOldnSpaces: Integer);
begin
  inherited Create;
  oldnSpaces := aOldnSpaces;
  nSpaces := aOldnSpaces; {default not changed indent}
end;

procedure TLineFeed.IncIndent(n: Integer);
begin
  with Formatter do
    inc(nSpaces, n * SpacePerIndent);
end;

procedure TLineFeed.SetIndent(n: Integer);
begin
  with Formatter do
    nSpaces := n * SpacePerIndent;
end;

function TLineFeed.GetEString(Dest: PChar): PChar;
begin
  if nSpaces > 0 then GetEString := StrEnd(strSpace(Dest, nSpaces))
  else GetEString := Dest;
end;

begin
  if paramCount = 0 then
  begin
    InFile := 'TEST.PAS';
    outFile := 'TEST.OUT';
  end
  else if paramCount = 1 then
  begin
    InFile := ParamStr(1);
    outFile := InFile;
  end
  else
  begin
    InFile := ParamStr(1);
    outFile := ParamStr(2);
  end;
  Formatter.Create;
  Formatter.LoadFile(strPCopy(Dest, InFile));
  Formatter.Parse;
  Formatter.WriteToFile(strPCopy(Dest, outFile));
  Formatter.Destroy;
end.
