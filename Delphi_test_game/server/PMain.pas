unit PMain;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, PGmProtect, PcardClass,
  StdCtrls;
type
  TTab = class //桌子类
  private
    FId: Cardinal; //自己的id号
    FmaxCount: Byte; //最大的玩家数量
    FGaming: boolean; //是否在游戏中
    FGamekind: SGameKind; //在玩啥游戏
    FTabName: string; //桌子名
    FPlayerArr: Tlist; //玩家的列表
    FSendBuffPlayerArr: array of RPlayer; //数组
    function GetPlayerCount: Byte;
    function GetSendBuffEntry: Pointer; //获取tab用户的进入点
    procedure GiveTabPlayerList(AThread: TIdPeerThread; IEntryPointer: Pointer; Isize: Integer); overload; //给指定用户发送列表
    procedure GiveTabPlayerList(IEntryPointer: Pointer; Isize: Integer); overload; //给所有用户发送
    procedure PlayerChange(IKind: sPlayerChange; IIdx: Byte; Iplayer: Prplayer; Istate: boolean = True); //用户进出
    procedure JoinTabRESP(Athread: TIdPeerThread; IPlayerIdx: byte);
  public
    property MaxCount: byte read FmaxCount write FmaxCount;
    property gameing: boolean read FGaming;
    property TabName: string read FTabName write FTabName;
    property id: Cardinal read Fid write Fid;
    property GameKind: SGameKind read FGamekind;
    property PlayerCount: Byte read GetPlayerCount;
    function InPlayer(IPplayer: PRPlayer): Byte; //加入玩家
    procedure LeavePlayer(Iindex: byte; IsOut: boolean = false); //离开玩家
    function GetPlayer(Iindex: Byte): PRplayer; //获取玩家指针
    procedure ReadyGame(IplayerIdx: Byte; IReadState: Boolean); //玩家准备或者取消准备游戏
    function IsallReady: boolean; //判断是否所有玩家准备就绪
    procedure BeginGame; //开始这张桌子的游戏
    procedure GiveBeginPlayerIdx(Iidx: byte); //随机给开始玩家索引标志着开始游戏
    procedure PlayerCards(IBuff: RSTC_PlayerSendCards); //玩家出牌
    procedure PlayerPass(Ibuff: RSTC_PlayerPass); //玩家跳过
    procedure PlayerChat(Ibuff: RCTS_Chat); //玩家聊天
    procedure PlayerWin(Ibuff:RCTS_UseWin);//玩家赢钱
    constructor Create(ItabName: string; IGmKind: SGameKind; IId: Cardinal; ImaxPlayer: Byte = 4);
    destructor Destory;
  end;
  TGameTabMana = class //游戏局管理类
  private
    FGobleTabID: Cardinal; //游戏桌子的ID号
  public
    FCurrTabCount: Cardinal; //现有的桌子数量
    FGameTabArr: TList; //桌子列表
    property CurrTabCount: Cardinal read FCurrTabCount; //现有的桌子数量
    function GetaTabID: Cardinal; //申请一个tabiD
    function NewTab(ITabName: string; ISGkind: SGameKind): Cardinal; //创建一张桌子
    procedure FreeTab(Iindex: Cardinal); //释放桌子
    function GetTab(IId: Cardinal): TTab; //获取桌子
    constructor Create;
    destructor Destory;
  end;
type
  TFMain = class(TForm)
    GameServer: TIdTCPServer;
    Memo1: TMemo;
    procedure GameServerConnect(AThread: TIdPeerThread);
    procedure GameServerExecute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GameServerListenException(AThread: TIdListenerThread;
      AException: Exception);
    procedure GameServerDisconnect(AThread: TIdPeerThread);
    procedure GameServerException(AThread: TIdPeerThread;
      AException: Exception);
  private
    GBuffHead: RHead;
    GBuffLogin: RCTS_login;
    Lbuff: array of RWaiteTab; //传输tab的buff
    LBuffCount: Cardinal; // 传输tab的记数
    FOnlinesUserCount:Integer;//在线用户数量
    Property OnlinesUserCount:Integer Read FOnlinesUserCount Write FOnlinesUserCount;
    function CanLoginIn(ILogin: RCTS_login): Boolean; //判断是否允许客户端登陆‘
    procedure CreateTab(athread: TIdPeerThread);
    procedure JoinTab(Athread: TIdPeerThread);
    procedure ReadyGame(Athread: TIdPeerThread);
    procedure LeaveTab(athread: TIdPeerThread);
    procedure DisConn(Athread: TIdPeerThread);
    procedure PlayerSendCard(Athread: TIdPeerThread);
    procedure PlayerPass(Athread: TIdPeerThread);
    procedure PlayerChat(Athread: TIdPeerThread);
    Procedure GetOnlineUsersCount(Athread:TIdPeerThread);
    procedure PlayerWinMoney(Athread:TIdPeerThread);//用户赢钱了
  public
    AppState: string;
    GameManage: TGameTabMana;
    WaitePlayerLIst: TList; //等待玩家的列表
    procedure AddShow(IStr: string);
    procedure SendHead(AThread: TIdPeerThread; Iheadcmid: Smallint);
    procedure GiveCards(aThread: TIdPeerThread; TENtryPointer: Pointer; IRandomsArrSize: Integer; ICount: Byte); //给用户牌局
    function GetWaiteTabArrEntry(var ICount: Cardinal): Pointer; //获取等待的桌子列表的进入点
    procedure GiveUserTabList(athread: TIdPeerThread; TENtryPointer: Pointer; ISize: Integer); //产生传输buff
    procedure TabChanged(athread: TIdPeerThread; Ikind: sTabChange; Iparam: Cardinal; IWaiteTab: PRWaiteTab); overload; //给一用户桌子列表发生改变
    procedure TabChanged(Ikind: sTabChange; Iparam: Cardinal; IWaiteTab: PRWaiteTab); overload; //给所有闲逛用户桌子列表发生改变
  end;

var
  FMain: TFMain;

implementation

uses Math;

{$R *.dfm}

{ TGameTabMana }

constructor TGameTabMana.Create;
begin
  FGameTabArr := TList.Create;
end;

destructor TGameTabMana.Destory;
var
  I: Integer;
begin
  for I := 0 to FGameTabArr.Count - 1 do begin // Iterate
    TTab(FGameTabArr.Items[i]).Free;
  end; // for
  FGameTabArr.Free;
end;

procedure TGameTabMana.FreeTab(Iindex: Cardinal);
var
  Ltep: TTab;
begin
  Dec(FCurrTabCount);
  Ltep := GetTab(Iindex);
  FMain.TabChanged(TabFree, Ltep.id, nil);
  FGameTabArr.Delete(FGameTabArr.IndexOf(Ltep));
end;

function TGameTabMana.GetaTabID: Cardinal;
begin
  inc(FGobleTabID);
  Result := FGobleTabID;
end;

function TGameTabMana.GetTab(IId: Cardinal): TTab;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FGameTabArr.Count - 1 do begin // Iterate
    if TTab(FGameTabArr[i]).id = IId then begin
      Result := TTab(FGameTabArr[i]);
      Break;
    end;
  end; // for
end;

function TGameTabMana.NewTab(ITabName: string; ISGkind: SGameKind): Cardinal;
var
  LTab: TTab;
  LTep: PRWaiteTab;
begin
  inc(FCurrTabCount);
  LTab := TTab.Create(ITabName, ISGkind, GetaTabID);
  FGameTabArr.Add(LTab);
  Result := LTab.id;
  new(LTep); //给所有闲逛的用户发送新桌子
  LTep.TabID := LTab.id;
  LTep.TabKind := LTab.GameKind;
  LTep.TabName := LTab.TabName;
  LTep.TabPlayerCount := 0;
  FMain.TabChanged(TabAdd, LTep.tabid, LTep);
  Dispose(LTep);
end;

{ TTab }

procedure TTab.BeginGame;
var
  I, x: Integer;
  Test: array of byte;
begin
  FGaming := True; //将桌子改为游戏中
  Randomize;
  SetLength(Test, 52);
  for I := 0 to 51 do begin // Iterate
    repeat
      x := Random(51);
    until Test[x] = 0;
    Test[X] := i;
  end; // for
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    PRplayer(FPlayerArr[i]).TotMoney:=PRplayer(FPlayerArr[i]).TotMoney-2;
    FMain.GiveCards(PRplayer(FPlayerArr.Items[i]).Contenting,
      @test[0], 52 * Sizeof(byte), 52);
  end; // for
  GiveBeginPlayerIdx(Random(MaxCount-1) + 1);
end;

constructor TTab.Create(ItabName: string; Igmkind: SGameKind; Iid: Cardinal; ImaxPlayer: Byte);
begin
  MaxCount := ImaxPlayer;
  FGaming := False;
  FTabName := ItabName;
  FGamekind := IGmKind;
  FId := IId;
  FPlayerArr := TList.Create;
end;

destructor TTab.Destory;
begin
  FPlayerArr.Free;
end;

function TTab.GetPlayer(Iindex: Byte): PRplayer;
begin
  Result := PRplayer(FPlayerArr.Items[Iindex]);
end;

function TTab.GetSendBuffEntry: Pointer;
var
  I: Integer;
begin
  SetLength(FSendBuffPlayerArr, PlayerCount);
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    FSendBuffPlayerArr[i] := PRplayer(FPlayerArr.Items[i])^;
  end; // for
  Result := Pointer(FSendBuffPlayerArr);
end;

procedure TTab.GiveTabPlayerList(AThread: TIdPeerThread;
  IEntryPointer: Pointer; Isize: Integer);
var
  LBuff: RSTC_GiveTabPlayerList;
begin
  FMain.SendHead(AThread, Cmid_STC_GiveTabPlayerList);
  LBuff.size := Isize;
  LBuff.Count := PlayerCount;
  AThread.Connection.WriteBuffer(Lbuff, Sizeof(LBuff));
  AThread.Connection.WriteBuffer(IEntryPointer^, LBuff.size);
end;

procedure TTab.GiveTabPlayerList(IEntryPointer: Pointer; Isize: Integer);
var
  I: Integer;
  Lbuff: RSTC_GiveTabPlayerList;
begin
  for I := 0 to PlayerCount - 1 do begin // Iterate
    Lbuff.size := Isize;
    Lbuff.Count := PlayerCount;
    PRPlayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(Lbuff, sizeof(Lbuff));
    PRPlayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(IEntryPointer^, Lbuff.size);
  end; // for
end;

function TTab.InPlayer(IPplayer: PRPlayer): byte;
begin
  GiveTabPlayerList(IPplayer.Contenting, GetSendBuffEntry, sizeof(Rplayer) * PlayerCount); //给玩家返回此tab里的玩家列表
  FMain.WaitePlayerLIst.Delete(FMain.WaitePlayerLIst.IndexOf(IPplayer)); //从闲逛玩家列表中移出
  IPplayer.ReadGame := False; //初始化进入时玩家准备游戏的状态
  IPplayer.Index := id;
  Result := FPlayerArr.Add(IPplayer);
  IPplayer.ID := Result;
  PlayerChange(PlayerIn, 0, IPplayer); //通知之前的其它玩家
  JoinTabRESP(IPplayer.Contenting, Result);
  FMain.TabChanged(TabAddPlayer, id, nil);
end;

function TTab.IsallReady: boolean;
var
  I: Integer;
begin
  Result := True;
  if PlayerCount < MaxCount then begin
    Result := False;
    Exit;
  end;
  for I := 0 to PlayerCount - 1 do begin // Iterate
    if not PRplayer(FPlayerArr.Items[i]).ReadGame then begin
      Result := False;
      break;
    end;
  end; // for
end;

procedure TTab.LeavePlayer(Iindex: byte; IsOut: boolean = false);
var
  I: Integer;
  LBuff: RSTC_ReSetPalyerIDX;
begin
  FMain.TabChanged(TabDeletePlayer, id, nil);
  if not IsOut then
    FMain.WaitePlayerLIst.Add(FPlayerArr.Items[iindex]); //将玩家加入等待列表
  PRplayer(FPlayerArr.Items[Iindex]).ReadGame := False; //初始化玩同意开始游戏的状态
  FPlayerArr.Delete(Iindex);
  PlayerChange(PlayerOut, Iindex, nil);
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    FMain.SendHead(PRplayer(FPlayerArr.Items[i]).Contenting,CMID_STC_ReSetPlayerIDX);
    LBuff.NewIdx := i;
    PRplayer(FPlayerArr.Items[i]).ID := i;
    PRplayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(lbuff, sizeof(LBuff));
  end; // for
  If FPlayerArr.Count=0 Then  Self.Free;    
end;

procedure TTab.PlayerChange(IKind: sPlayerChange; IIdx: Byte;
  Iplayer: Prplayer; Istate: boolean = True);
var
  I: Integer;
  Lbuff: RSTC_PlayerIO;
begin
  for I := 0 to PlayerCount - 1 do begin // Iterate
    FMain.SendHead(PRplayer(FPlayerArr.Items[i]).Contenting, Cmid_STC_PlayerIO);
    Lbuff.Kind := IKind;
    Lbuff.Idx := IIdx;
    if Iplayer <> nil then
      Lbuff.Player := Iplayer^;
    Lbuff.State := Istate;
    PRplayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(Lbuff, sizeof(Lbuff));
  end; // for
end;

procedure TTab.JoinTabRESP(Athread: TIdPeerThread; IPlayerIdx: byte);
var
  LResp: RCTS_JoinTab_RESP;
begin
  LResp.TabId := id;
  LResp.PlayerINDEX := IPlayerIdx;
  FMain.SendHead(Athread, CMid_CTS_JoinTab);
  Athread.Connection.WriteBuffer(lRESP, Sizeof(LResp));
end;


procedure TTab.ReadyGame(IplayerIdx: Byte; IReadState: Boolean);
var
  LtepState: sPlayerChange;
begin
  PRplayer(FPlayerArr.Items[IplayerIdx]).ReadGame := IReadState;
  if IReadState then LtepState := PlayerReady else LtepState := PlayernotReady;
  PlayerChange(LtepState, IplayerIdx, nil);
  if IReadState then //如果都准备好了那就开始游戏
    if IsallReady then
      BeginGame;
end;

function TTab.GetPlayerCount: Byte;
begin
  Result := FPlayerArr.Count;
end;

procedure TTab.GiveBeginPlayerIdx(Iidx: byte);
var
  I: Integer;
  Lbuff: RSTC_GiveBeginPlayerIdx;
begin
  Lbuff.Index := Iidx;
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    FMain.SendHead(PRplayer(FPlayerArr.Items[i]).Contenting, Cmid_STC_GiveBeginPlayerIdx);
    PRplayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(Lbuff, Sizeof(Lbuff));
  end; // for
end;

procedure TTab.PlayerCards(IBuff: RSTC_PlayerSendCards);
var
  I: Integer;
begin
  PRplayer(FPlayerArr[IBuff.PlayerIdx]).TotMoney:=PRplayer(FPlayerArr[IBuff.PlayerIdx]).TotMoney-IBuff.Scores;
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    FMain.SendHead(PRplayer(FPlayerArr.Items[i]).Contenting, Cmid_STC_UserSendCards);
    PRplayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(IBuff, Sizeof(IBuff));
  end; // for
end;

procedure TTab.PlayerPass(Ibuff: RSTC_PlayerPass);
var
  I: Integer;
begin
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    FMain.SendHead(PRplayer(FPlayerArr.Items[i]).Contenting, Cmid_STC_UserPass);
    PRplayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(IBuff, Sizeof(IBuff));
  end; // for
end;

procedure TTab.PlayerChat(Ibuff: RCTS_Chat);
var
  I: Integer;
begin
  for I := 0 to FPlayerArr.Count - 1 do begin // Iterate
    FMain.SendHead(PRplayer(FPlayerArr.Items[i]).Contenting, Cmid_CTS_Chat);
    PRplayer(FPlayerArr.Items[i]).Contenting.Connection.WriteBuffer(IBuff, Sizeof(IBuff));
  end; // for
end;



procedure TTab.PlayerWin(Ibuff: RCTS_UseWin);
var
  I: Integer;
begin
  for I := 0 to  FPlayerArr.Count-1 do    // Iterate
    PRplayer(FPlayerArr[i]).ReadGame:=False;
  prPlayer(FPlayerArr.Items[Ibuff.PlayIdx]).TotMoney:=
    prPlayer(FPlayerArr.Items[Ibuff.PlayIdx]).TotMoney+Ibuff.AddScore;
end;

{ TFMain }

function TFMain.CanLoginIn(ILogin: RCTS_login): Boolean;
begin
  Result := True;
end;

procedure TFMain.GameServerConnect(AThread: TIdPeerThread);
var
  I: Integer;
  LTep: PRPlayer;
  LEntry: Pointer;
begin
  if AppState <> CappstateNormal then AThread.Connection.Disconnect;
  AddShow('客户端试图登录...');
  Athread.Connection.ReadBuffer(GbuffHead, sizeof(GBuffHead));
  if GBuffHead.Cmid = Cmid_CTS_Login then
    Athread.Connection.ReadBuffer(Gbufflogin, Sizeof(GBuffLogin));
  if CanLoginIn(GBuffLogin) then begin
    AddShow('通过验证');
      //产生player的记录
    New(ltep);
    LTep^.Name := GBuffLogin.Acc;
    LTep^.Contenting := AThread;
    LTep^.TotMoney := 100;
    AThread.Data := Pointer(ltep);
    WaitePlayerLIst.Add(AThread.Data);
    AddShow('生成管理对象');
      //给用户发送现有桌子列表
    AddShow('向客户端发送空闲桌子情况');
    LEntry := GetWaiteTabArrEntry(LBuffCount);
    GiveUserTabList(AThread, LEntry, LBuffCount * sizeof(RWaiteTab));
    OnlinesUserCount:=OnlinesUserCount+1;
    if WaitePlayerLIst.Count>0 then      
      For I := 0 To WaitePlayerLIst.Count - 1 Do     // Iterate
        GetOnlineUsersCount(PrPlayer(waitePlayerList.Items[i]).Contenting);
  end
  else begin
    AddShow('没有通过应证 断开连接');
    Athread.Connection.Disconnect;
  end;
end;

procedure TFMain.GameServerExecute(AThread: TIdPeerThread);
var
  LHead: RHead;
  Ltep: pointer;
begin
  if AppState <> CappstateNormal then Exit;
  with AThread do begin
    Connection.ReadBuffer(LHead, SizeOf(LHead));
    case LHead.Cmid of //
      CMid_CTS_JoinTab: JoinTab(AThread); //加入桌子
      CMID_CTS_LeaveTab: LeaveTab(AThread);
      CMid_CTS_DisConn: begin
          SendHead(AThread, CMid_CTS_DisConn);
          AThread.Terminate;
        end;
      CMID_CTS_CreateTab: CreateTab(AThread);
      Cmid_CTS_ReadyGame: ReadyGame(AThread);
      Cmid_STC_GiveWaiteTabList: begin
          Ltep := GetWaiteTabArrEntry(LBuffCount);
          GiveUserTabList(AThread, Ltep, LBuffCount * sizeof(RWaiteTab))
        end;
      Cmid_STC_UserSendCards: PlayerSendCard(AThread);
      Cmid_STC_UserPass: PlayerPass(AThread);
      Cmid_CTS_Chat: PlayerChat(AThread);
      Cmid_CTS_GetOnlinesUser:GetOnlineUsersCount(AThread);
      Cmid_CTS_Userwin:PlayerWinMoney(AThread);
    end; // case
  end; // with
end;


procedure TFMain.JoinTab(Athread: TIdPeerThread);
var
  LBuff: RCTS_JoinTab;
  LTep: TTab;
begin
  with Athread do begin
    Connection.ReadBuffer(LBuff, SIZEOf(LBuff));
    LTep := GameManage.GetTab(LBuff.TabID);
    if LTep.PlayerCount + 1 <= LTep.MaxCount then begin
      LTep.InPlayer(Prplayer(Athread.Data));
      AddShow('用户' + Prplayer(Athread.Data).Name + '加入了' + inttostr(LBuff.TabID) + '号桌子');
    end;
  end; // with
end;

procedure TFMain.LeaveTab(athread: TIdPeerThread);
var
  Lbuff: RCTS_LeaveTab;
begin
  with Athread do begin
    Connection.ReadBuffer(LBuff, SIZEOf(LBuff));
    AddShow(Format('用户%s在离开了桌子%d',
      [Prplayer(Athread.Data).Name, Lbuff.TabID]));
    GameManage.GetTab(LBuff.TabID).LeavePlayer(Lbuff.PlayerID);
    FMain.SendHead(athread, CMID_CTS_LeaveTab); //告诉用户他已经成功离开了
  end; // with
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  GameManage := TGameTabMana.Create;
  WaitePlayerLIst := TList.Create;
  AppState := CappstateNormal;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  GameServer.Free;
  WaitePlayerLIst.Free;
  GameManage.Free;
end;

procedure TFMain.GiveCards(aThread: TIdPeerThread; TENtryPointer: Pointer; IRandomsArrSize: Integer; ICount: Byte);
var
  Lbuff: RSTC_GiveCards;
begin
  FMain.SendHead(aThread, Cmid_STC_GiveCards);
  Lbuff.CardsSize := IRandomsArrSize;
  Lbuff.Count := ICount;
  aThread.Connection.WriteBuffer(lbuff, SIZEOF(Lbuff));
  aThread.Connection.WriteBuffer(tenTryPointer^, Lbuff.CardsSize);
end;

procedure TFMain.CreateTab(athread: TIdPeerThread);
var
  Lbuff: RCTS_CreateTab;
  LResp: RCTS_CreateTab_RESP;
begin
  with athread do begin
    athread.Connection.ReadBuffer(Lbuff, Sizeof(Lbuff));
    LResp.tabid := GameManage.NewTab(Lbuff.TabName, Lbuff.TabKind);
    AddShow('创建名为' + Lbuff.TabName + '的桌子');
    GameManage.GetTab(LResp.tabid).InPlayer(PRplayer(athread.Data));
    SendHead(athread, CMID_CTS_CreateTab);
    Connection.WriteBuffer(lresp, sizeof(LResp));
  end; // with
end;

procedure TFMain.GiveUserTabList(athread: TIdPeerThread;
  TENtryPointer: Pointer; ISize: Integer);
var
  Lbuff: RSTC_GiveWaiteTabList;
begin
  SendHead(athread, Cmid_STC_GiveWaiteTabList);
  Lbuff.ListSize := ISize;
  aThread.Connection.WriteBuffer(lbuff, SIZEOF(Lbuff));
  aThread.Connection.WriteBuffer(tenTryPointer^, ISize);
end;

function TFMain.GetWaiteTabArrEntry(var Icount: Cardinal): Pointer;
var
  I: Integer;
begin
  if GameManage.FGameTabArr.Count = 0 then begin Result := nil; Exit; end;
  icount := 0;
  for I := 0 to GameManage.FGameTabArr.Count - 1 do begin // Iterate
    if not tTab(GameManage.FGameTabArr.Items[i]).gameing then begin
      inc(icount);
      SetLength(Lbuff, icount);
      Lbuff[icount - 1].TabID := tTab(GameManage.FGameTabArr.Items[i]).id;
      Lbuff[icount - 1].TabKind := tTab(GameManage.FGameTabArr.Items[i]).GameKind;
      Lbuff[icount - 1].TabName := tTab(GameManage.FGameTabArr.Items[i]).TabName;
      Lbuff[icount - 1].TabPlayerCount := tTab(GameManage.FGameTabArr.Items[i]).PlayerCount;
      Lbuff[icount - 1].TabMaxCount := tTab(GameManage.FGameTabArr.Items[i]).MaxCount;
    end;
  end; // for
  Result := Pointer(Lbuff);
end;

procedure TFMain.SendHead(AThread: TIdPeerThread; Iheadcmid: Smallint);
begin
  if not Assigned(AThread) then exit;
  GBuffHead.Cmid := Iheadcmid;
  AThread.Connection.WriteBuffer(GbuffHead, sizeof(GBuffHead));
end;

procedure TFMain.TabChanged(athread: TIdPeerThread; Ikind: sTabChange;
  Iparam: Cardinal; IWaiteTab: PRWaiteTab);
var
  Lbuff: RSTC_TabChange;
begin
  SendHead(athread, Cmid_STC_TabChange);
  Lbuff.Kind := Ikind;
  Lbuff.Param := Iparam;
  if Assigned(IWaiteTab) then
    Lbuff.WaiteTab := IwaiteTab^;
  athread.Connection.WriteBuffer(Lbuff, Sizeof(Lbuff));
end;

procedure TFMain.AddShow(IStr: string);
begin
  if Memo1.Lines.Add(datetimetostr(now) + ' :' + IStr) > 500 then
    Memo1.Clear;
end;

procedure TFMain.TabChanged(Ikind: sTabChange; Iparam: Cardinal; IWaiteTab: PRWaiteTab);
var
  I: Integer;
  Lbuff: RSTC_TabChange;
begin
  for I := 0 to WaitePlayerLIst.Count - 1 do begin // Iterate
    SendHead(PRPlayer(WaitePlayerLIst.Items[I]).Contenting, Cmid_STC_TabChange);
    Lbuff.Kind := Ikind;
    Lbuff.Param := Iparam;
    if Assigned(IWaiteTab) then
      Lbuff.WaiteTab := IwaiteTab^;
    PRPlayer(WaitePlayerLIst.Items[I]).Contenting.Connection.WriteBuffer(Lbuff, Sizeof(Lbuff));
  end; // for
end;

procedure TFMain.ReadyGame(Athread: TIdPeerThread);
var
  Lbuff: RCTS_ReadyGame;
begin
  Athread.Connection.ReadBuffer(Lbuff, Sizeof(Lbuff));
  GameManage.GetTab(Lbuff.TabID).ReadyGame(Lbuff.PlayerINDEX, Lbuff.STate);
  AddShow(Format('用户%s在桌子%d上将状态设置为%s', [Prplayer(Athread.Data).Name,
    Lbuff.TabID, inttostr(Ord(Lbuff.STate))]));
end;

procedure TFMain.GameServerListenException(AThread: TIdListenerThread;
  AException: Exception);
begin
  AddShow(AException.Message);
end;

procedure TFMain.DisConn(Athread: TIdPeerThread);
var
  I: Integer;
begin
  OnlinesUserCount:=OnlinesUserCount-1;
  AddShow('用户' + Prplayer(Athread.Data).Name + '退出连接了');
  i := WaitePlayerLIst.IndexOf(Athread.Data);
  if i > -1 then
    WaitePlayerLIst.Delete(i)
  else begin
    GameManage.GetTab(Prplayer(Athread.Data).Index).LeavePlayer(Prplayer(Athread.Data).ID, True);
  end;
  For I := 0 To WaitePlayerLIst.Count - 1 Do   // Iterate
  GetOnlineUsersCount(pRplayer(WaitePlayerLIst.Items[i]).Contenting);
  Dispose(Pointer(AThread.Data));
end;

procedure TFMain.GameServerDisconnect(AThread: TIdPeerThread);
begin
  DisConn(AThread);
end;

procedure TFMain.GameServerException(AThread: TIdPeerThread;
  AException: Exception);
begin
  if AThread.Connection.Connected then AThread.Connection.Disconnect;
end;

procedure TFMain.PlayerPass(Athread: TIdPeerThread);
var
  Lbuff: RSTC_PlayerPass;
begin
  Athread.Connection.ReadBuffer(Lbuff, sizeof(Lbuff));
  GameManage.GetTab(Lbuff.TabID).PlayerPass(Lbuff);
end;

procedure TFMain.PlayerSendCard(Athread: TIdPeerThread);
var
  Lbuff: RSTC_PlayerSendCards;
begin
  Athread.Connection.ReadBuffer(Lbuff, sizeof(Lbuff));
  GameManage.GetTab(Lbuff.TabID).PlayerCards(Lbuff);
end;

procedure TFMain.PlayerChat(Athread: TIdPeerThread);
var
  Lbuff: RCTS_Chat;
begin
  Athread.Connection.ReadBuffer(Lbuff, Sizeof(Lbuff));
  GameManage.GetTab(Lbuff.TabID).PlayerChat(Lbuff);
end;

procedure TFMain.GetOnlineUsersCount(Athread: TIdPeerThread);
Var
  Lbuff:RCTS_GetOnlinesUser;
begin
  Lbuff.Count:=OnlinesUserCount;
  SendHead(Athread,Cmid_CTS_GetOnlinesUser);
  Athread.Connection.WriteBuffer(Lbuff,Sizeof(Lbuff));
end;

procedure TFMain.PlayerWinMoney(Athread: TIdPeerThread);
var
  LBuff:RCTS_UseWin;
begin
  Athread.Connection.ReadBuffer(LBuff,Sizeof(LBuff));
  GameManage.GetTab(LBuff.TabId).PlayerWin(LBuff);
end;

end.

