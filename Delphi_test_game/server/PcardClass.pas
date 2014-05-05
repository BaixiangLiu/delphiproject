unit PcardClass;

interface
uses SysUtils, Contnrs, Dialogs, Classes, PGmProtect;

type
  SKind = (Fan, Xi, Red, Black, BigSupper, SmallSupper); //4种花色+大飞+小飞
  SWinCardKind = (SWCKsan, SWCKdui, SWCKtwodui, SWCKTree, SWCKsun, SWCKsamecolor,
    SWCKTreeandTwo, SWCKfourandone, SWCKsameCLSun);
  PRoneCard = ^ROneCard;
  ROneCard = packed record //牌的结构
    Kind: SKind;
    Value: Integer;
  end;
  TBaseCard = class
  private
    FtotCard: Byte; //总牌数
    FCardArr: array of ROneCard; //一扑克数组
    FCardStack: TStack; //当前牌局
    FCurrCardCount: Byte; //当前的牌数
    FRandomarr: array of Byte;
  public
    property TotCardCounts: byte read FtotCard write FtotCard;
    property CardCount: Byte read FCurrCardCount write FCurrCardCount; //当前的牌数
    procedure RandomArr(Icount: Byte); //洗数组
    procedure CardStackPop; //将洗过的牌写进入牌局
    function GetRandomArrEntry: pointer;
    function GetRandom(Ilength: byte): Pointer; //设置好数组大小后从外部获取数组
    procedure MakeCards(INeesSupper: boolean = True; ILoopCount: byte = 1); //产生牌局 可以选择是否要大小鬼 和 产生几副牌
    function GetOneCard: PROneCard; //发一张牌
    function TralsateCard(IOneCard: ROneCard): string; //转换牌的表现形式
    function ResultCall(ICards: TList): string; //返回一组数
    constructor Create;
    destructor Destory;
  end;
  sPlayerPostion = (sdown, sright, sup, sleft);
  TPlayer = class //玩家类
  private

    FCardArr: TList; //玩家手上的牌
    FPostion: sPlayerPostion; //玩家的位置
    function GetCurrCardCount: Byte;
  public
    PlayerInfo: PRplayer; //玩家的信息
    property CurrCardCount: Byte read GetCurrCardCount default 0; //手里的牌数
    property Cards: TList read FCardArr write FCardArr; //手里的牌
    property Postion: sPlayerPostion read FPostion write FPostion; //玩家的位置
    function InCard(Icard: PROneCard): PROneCard; //摸牌
    function OutCard(Iindex: Integer): PROneCard; //打牌
    constructor Create(IInfo: PRplayer);
    destructor Destory;
  end;
  TZSYCard = class(TBaseCard) //争上游
  private
    FCurrPlayerIndex: Byte; // 记录当前应该出牌的用户
    FLastId: Byte; //上一个用户
    FLastCards: TList; //最后一局的牌局
    FCurrCards: Tlist; //当前的牌局
  protected
    property LastID: byte read FLastId write FLastId; //上一个用户
    property LastCards: TList read FLastCards write FLastCards; //最后一局的牌局
  public
    property CurrCards: TList read FCurrCards write FCurrCards;
    property CurrSendPlayerIdx: Byte read FCurrPlayerIndex write FCurrPlayerIndex; //记录当前应该出牌的用户
    procedure NextPlayer;
    function CanPlayThisCard(IPlayer: TPlayer; IcardS: TList): boolean; //是否可以出这把牌
    function CheckWined(IPlayer: TPlayer): boolean; //检测是否已经赢了
    function RandomBeginPlayer(IplayerCount: Byte): Byte; //随机一个开始出牌的用户
    constructor Create;
    destructor Destory;
  end;
  TTSPCard = class(TBaseCard) //梭哈
  private
    FCurrPlayerIndex: Byte; // 记录当前应该出牌的用户
    FLastMoney: Integer; //上一局的赌注
    function CaseScKind(Icards: TList): SWinCardKind; //返回牌的类型
  public
    PlayerArr: array of TPlayer;
    property CurrPlayerIndex: Byte read FCurrPlayerIndex write FCurrPlayerIndex;
    property LastMoney: Integer read FLastMoney write FLastMoney default 0;
    procedure NextPlayer;
    function CheckGameWined: Byte; //检测游戏的赢家
    function NeedCheckWin: boolean; //下一用户之前判断是否需要检测输赢
    function CheckOutWined: Byte; //用户退出的时候检查是否赢了 如果赢了返回索引号
    function RandomBeginPlayer(IplayerCount: Byte): Byte; //随机一个开始出牌的用户
    procedure SetPlayerPostion(IcurrIdx: Byte); //根据当前用户索引 设定位置
    constructor Create(IPlayerCount: Byte; Iarr: array of PRplayer);
    destructor Destory;
  end;

implementation

{ TCard }

procedure TBaseCard.CardStackPop;
var
  I: Integer;
begin
  for I := 0 to Length(FRandomarr) - 1 do begin // Iterate
    FCardStack.Push(@FCardArr[FRandomarr[i]]);
  end; // for
end;

constructor TBaseCard.Create;
begin
  FCardStack := TStack.Create;
end;

destructor TBaseCard.Destory;
begin
  FCardStack.Free;
  FCardArr := nil;
  inherited;
end;

function TBaseCard.GetOneCard: PROneCard;
begin
  Dec(FCurrCardCount);
  Result := PROneCard(FCardStack.Pop);
end;

function TBaseCard.GetRandom(Ilength: byte): Pointer;
begin
  SetLength(FRandomarr, Ilength);
  Result := Pointer(FRandomarr);
end;

function TBaseCard.GetRandomArrEntry: pointer;
begin
  Result := @FRandomarr;
end;

procedure TBaseCard.MakeCards(INeesSupper: boolean = True; ILoopCount: byte = 1);
var
  j, L, M: Integer;
  LKind: SKind;
begin
  FtotCard := 0;
  for M := 1 to ILoopCount do begin // Iterate
    for L := 0 to 3 do begin // Iterate
      LKind := Skind(L);
      for J := 1 to 13 do begin // Iterate
        Inc(FtotCard);
        SetLength(FCardArr, FtotCard);
        FCardArr[FtotCard - 1].Kind := LKind;
        FCardArr[FtotCard - 1].Value := J;
      end; // for
    end; // for
    if INeesSupper then begin
      Inc(FtotCard, 1);
      SetLength(FCardArr, FtotCard);
      FCardArr[FtotCard - 1].Kind := BigSupper;
      FCardArr[FtotCard - 1].Value := 17;
      Inc(FtotCard, 1);
      SetLength(FCardArr, FtotCard);
      FCardArr[FtotCard - 1].Kind := SmallSupper;
      FCardArr[FtotCard - 1].Value := 16;
    end;
  end; // for
end;

procedure TBaseCard.RandomArr(Icount: Byte);
var
  i, X: Integer;
begin
  Randomize;
  SetLength(FRandomarr, Icount);
  for I := 0 to Icount do begin // Iterate
    repeat
      x := Random(Icount);
    until FRandomarr[x] = 0;
    FRandomarr[X] := i;
  end; // for
  FCurrCardCount := Length(FCardArr);
end;

function TBaseCard.ResultCall(ICards: TList): string;
var
  I: Integer;
begin
  for I := 0 to ICards.Count - 1 do begin // Iterate
    Result := Result + '<' + inttostr(i) + '>' + TralsateCard(PROneCard(ICards.Items[i])^);
  end; // for
end;

function TBaseCard.TralsateCard(IOneCard: ROneCard): string;
var
  LTep: string;
begin
  case IOneCard.Kind of //
    Black: ltep := '黑桃';
    Red: Ltep := '红心';
    Xi: LTep := '梅花';
    Fan: Ltep := '方块';
    BigSupper: LTep := '大鬼';
    SmallSupper: LTep := '小鬼';
  end; // case
  case IOneCard.Value of //
    1: LTep := LTep + 'A';
    2: LTep := LTep + '2';
    3: LTep := LTep + '3';
    4: LTep := LTep + '4';
    5: LTep := LTep + '5';
    6: LTep := LTep + '6';
    7: LTep := LTep + '7';
    8: LTep := LTep + '8';
    9: LTep := LTep + '9';
    10: LTep := LTep + '10';
    11: LTep := LTep + 'J';
    12: LTep := LTep + 'Q';
    13: LTep := LTep + 'K';
  end; // case
  Result := LTep;
end;

{ TZSYCard }

procedure TZSYCard.NextPlayer;
begin
  FCurrPlayerIndex := FCurrPlayerIndex + 1;
  if FCurrPlayerIndex > 3 then FCurrPlayerIndex := 0;
end;

function TZSYCard.CanPlayThisCard(IPlayer: TPlayer; IcardS: TList): boolean;
begin
  Result := False;
end;

function TZSYCard.CheckWinEd(IPlayer: TPlayer): boolean;
begin
  Result := IPlayer.CurrCardCount = 0; //判断是否赢了
end;

constructor TZSYCard.Create;
begin
  inherited Create;
  FLastCards := TList.Create;
  FCurrCards := TList.Create;
end;

destructor TZSYCard.Destory;
var
  I: Integer;
begin
  for I := 0 to FLastCards.Count - 1 do begin // Iterate
    Dispose(FLastCards.Items[i]);
  end; // for
  FLastCards.Free;
  FCurrCards.free;
end;

function TZSYCard.RandomBeginPlayer(IplayerCount: Byte): Byte;
begin
  Randomize;
  FCurrPlayerIndex := random(IplayerCount);
  Result := FCurrPlayerIndex;
end;

{ TPlayer }

constructor TPlayer.Create(IInfo: PRplayer);
begin
  PlayerInfo := IInfo;
  FCardArr := TList.Create;
end;

destructor TPlayer.Destory;
begin
  FCardArr.Free;
end;

function TPlayer.GetCurrCardCount: Byte;
begin
  Result := Cards.Count;
end;

function TPlayer.InCard(Icard: PROneCard): PROneCard; //摸牌
begin
  FCardArr.Add(Icard);
  Result := Icard;
end;

function TPlayer.OutCard(Iindex: Integer): PROneCard; //打牌
begin
  Result := Cards.Items[Iindex];
  Cards.Delete(Iindex);
end;

{ TTSPCard }

function composit(Ilist: TList): TList; //牌排序
var
  Lnum, Lnt: Integer;
  Lmin: Integer;
begin
  Result := TList.Create;
  Lnum := 0;
  Lmin := PRoneCard(Ilist.Items[0]).Value; //
  Result.Add(Ilist.Items[0]);
  while Lnum < Ilist.Count - 1 do begin
    inc(Lnum);
    if PRoneCard(Ilist.Items[Lnum]).Value = 1 then
      PRoneCard(Ilist.Items[Lnum]).Value := 14;
    if PRoneCard(Ilist.Items[Lnum]).Value <= Lmin then begin
      Lmin := pRoneCard(Ilist.Items[Lnum]).Value;
      Result.Insert(0, Ilist.Items[Lnum]);
    end
    else begin
      Lnt := 0;
      repeat
        if pRoneCard(Ilist.Items[Lnum]).Value >
          PRoneCard(Result.Items[Lnt]).Value then
          Inc(Lnt)
        else Break;
      until Lnt = Result.Count;
      Result.Insert(Lnt, Ilist.Items[Lnum]);
    end;
  end;
  Ilist.Free;
end;

function SameCardCount(Ivalue: Byte; Icards: TList): Byte; //返回同样值的数量
var
  I: Integer;
begin
  result := 0;
  for I := 0 to Icards.Count - 1 do begin // Iterate
    if Ivalue = Pronecard(Icards.Items[i]).Value then inc(Result);
  end; // for
end;

function SameCardMaxCount(icards: TList): Byte; //返回同样牌最多的数
var
  i: Integer;
  Ltep: Byte;
  Lthen: Byte;
begin
  Ltep := Pronecard(icards.Items[0]).Value;
  Result := SameCardCount(Ltep, icards);
  for i := 1 to icards.Count - 1 do begin
    if Ltep = Pronecard(icards.Items[i]).Value then Continue //如果是同样的牌就跳过
    else begin
      Ltep := Pronecard(icards.Items[i]).Value; //取得不同值
        Lthen := SameCardCount(Ltep, icards); //获取牌数
      if Lthen > Result then Result := Lthen; //返回最多的
    end;
  end;
end;

function IsSameColor(Icards: TList): Boolean; //返回是否是同花
var
  I: Integer;
  Ltep: SKind;
begin
  result := True;
  Ltep := Pronecard(Icards.Items[0]).Kind;
  for I := 1 to Icards.Count - 1 do // Iterate
    if Ltep <> Pronecard(Icards.Items[i]).Kind then begin
      Result := False;
      Break;
    end;
end;

function IsSun(Icards: TList): Boolean; //是否是顺子
var
  I: Integer;
  Ltep: Byte;
begin
  result := True;
  Ltep := Pronecard(Icards.Items[0]).Value;
  for I := 1 to Icards.Count - 1 do // Iterate
    if Ltep + 1 <> Pronecard(Icards.Items[i]).Value then begin
      Result := False;
      Break;
    end;
end;

function GetMaxvalue(Icard: Tlist): Byte; //获取最大值
begin
  Result := Pronecard(Icard.Items[Icard.Count-1]).Value; //因为已经排过续了所以最后一张牌最大
end;

function GetMaxColor(Ivalue:byte;Icard: Tlist): SKind;
var
  I: Integer;
begin
  result := Pronecard(Icard.Items[0]).Kind;
  for I := 0 to Icard.Count - 1 do begin // Iterate
    If Ivalue=Pronecard(Icard.Items[i]).Value Then
    if ord(Pronecard(Icard.Items[i]).Kind) > ord(Result) then
      Result := Pronecard(Icard.Items[i]).Kind;
  end; // for
end;

Function GetMinCount(Icard:TList):Byte;//获取最小的牌数
Var
  I: Integer;
  n:byte;
Begin
  n :=SameCardCount(Pronecard(Icard.Items[0]).Value,Icard);
  For I := 1 To Icard.Count - 1 Do Begin    // Iterate
    If n<SameCardCount(Pronecard(Icard.Items[i]).Value,Icard) Then
     n:=SameCardCount(Pronecard(Icard.Items[i]).Value,Icard);
  End;    // for
  Result:=n;
End;

function TTSPCard.CaseScKind(Icards: TList): SWinCardKind;
begin
  if IsSameColor(Icards) then begin
    if IsSun(Icards) then
      Result := SWCKsameCLSun
    else Result := SWCKsamecolor;
  end
  else if SameCardMaxCount(Icards) = 4 then Result := SWCKfourandone
  else if (SameCardMaxCount(Icards) = 3) then begin
    if GetMinCount(Icards) = 2 then Result := SWCKTreeandTwo
    else Result := SWCKTree
  end
  else if SameCardMaxCount(Icards) = 2 then begin
    if GetMinCount(Icards) = 2 then
      Result := SWCKtwodui
    else Result := SWCKdui
  end
  else Result := SWCKsan;
end;

function TTSPCard.CheckGameWined: Byte;
Var
  I,x,n: Integer;
  Ltep,Lnext:SWinCardKind;
  LmaxOne,LmaxTwo:Byte;
begin
  X:=0;
  For I := 0 To length(PlayerArr) - 1 Do Begin    // Iterate
    If PlayerArr[i].PlayerInfo^.PassCurrGame Then Continue
    Else x:=i;
  End;    // for
  Result:=x;
  n:=x;
  PlayerArr[X].FCardArr:=composit(PlayerArr[X].FCardArr);
  Ltep:=CaseScKind(PlayerArr[X].FCardArr);
  For I := n+1 To length(PlayerArr) - 1 Do Begin    // Iterate
    PlayerArr[i].FCardArr:=composit(PlayerArr[i].FCardArr);
    Lnext:=CaseScKind(PlayerArr[i].FCardArr);
    If Ltep=Lnext Then Begin //如果是同样的牌
      LmaxOne:=GetMaxvalue(PlayerArr[i].FCardArr);
      LmaxTwo:=GetMaxvalue(PlayerArr[X].FCardArr);
      if LmaxOne>LmaxTwo then begin
         Result:=i;
         x:=i;
      end
      Else Begin
        If LmaxOne=LmaxTwo Then Begin
          If Ord(GetMaxColor(LmaxOne,PlayerArr[i].FCardArr))>ord(GetMaxColor(LmaxTwo,PlayerArr[X].FCardArr)) Then
           Result:=i;
           x:=i;
        End;
      End;
    End;
  End;    // for
end;

function TTSPCard.CheckOutWined: Byte;
var
  I, N: Integer;
  Cur: Byte;
begin
  Result := 250;
  Cur:=0;
  n := 0;
  for I := 0 to High(PlayerArr) do begin // Iterate
    if PlayerArr[i].PlayerInfo^.PassCurrGame then inc(n)
    else Cur := i;
  end; // for
  if n = 3 then Result := Cur;
end;


constructor TTSPCard.Create(IPlayerCount: Byte; Iarr: array of PRplayer);
var
  I: Integer;
begin
  inherited Create;
  SetLength(PlayerArr, IPlayerCount);
  for I := 0 to IPlayerCount - 1 do begin // Iterate
    PlayerArr[i] := TPlayer.Create(Iarr[i]);
  end; // for

end;

destructor TTSPCard.Destory;
var
  I: Integer;
begin
  for I := 0 to Length(PlayerArr) - 1 do begin // Iterate
    PlayerArr[i].Free;
  end; // for
end;

function TTSPCard.NeedCheckWin: boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to High(PlayerArr) do begin // Iterate
    if PlayerArr[i].PlayerInfo^.PassCurrGame then Continue;
    if PlayerArr[i].CurrCardCount <> 5 then begin
      Result := False;
      Break;
    end;
  end; // for
end;

procedure TTSPCard.NextPlayer;
begin
  FCurrPlayerIndex := FCurrPlayerIndex + 1;
  if FCurrPlayerIndex > 3 then FCurrPlayerIndex := 0;
end;

function TTSPCard.RandomBeginPlayer(IplayerCount: Byte): Byte;
begin
  FCurrPlayerIndex := IplayerCount;
  Result := FCurrPlayerIndex;
end;

procedure TTSPCard.SetPlayerPostion(IcurrIdx: Byte);
var
  I, n, x: Integer;
begin
  for I := 0 to Length(PlayerArr) - 1 do begin // Iterate //获取起始玩家索引
    if PlayerArr[i].PlayerInfo.ID = IcurrIdx then
      break;
  end; // for
  x := i;
  n := 0;
  repeat
    PlayerArr[x].Postion := sPlayerPostion(n); //设置位置
    inc(n); //增加位置引用
    inc(x); //下一索引
    if X > high(Playerarr) then X := 0; //如果索引超过限制就从头
  until n > 3; //如果设置完位置就推出
end;

end.

