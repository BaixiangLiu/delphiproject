unit Pmain;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PGmProtect, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, xdarray, PRenameCard, PcardClass, RzLabel, Mask,
  RzEdit, RzCmboBx, ComCtrls, RzListVw, RzButton, RzBckgnd, ImgList,
  RzStatus, RzSplit, ExtCtrls, RzPanel;
type
  TReciveThread = class(TThread)
  private
    Ghead: RHead;
    procedure SHowGameForm; //显示gameform
    procedure ShowMainForm; //显示MainForm
    procedure SynShowNext; //画下一个玩家
    procedure SynSendCard; //出牌
    procedure SynAddMemo; // 添加到显示框
    procedure SynDrawPlayerList; //画出用户列表框
    procedure SynDrawTabList; //画出用户列表框
    procedure BeginGame; //让主线程开始游戏
    procedure DoExecute(ICon: TIdTCPClient);
    procedure RevDisconn;
    procedure RevCreateTab(ICon: TIdTCPClient);
    procedure RevJoinTab(ICon: TIdTCPClient);
    procedure RevLeaveTab(ICon: TIdTCPClient);
    procedure RevTabChanged(ICon: TIdTCPClient);
    procedure RevPlayerChange(Icon: TIdTCPClient);
    procedure RevResetPlayerIdx(ICon: TIdTCPClient);
    procedure RevGiveCards(Icon: TIdTCPClient);
    procedure RevGetBeginPlayerIdx(Icon: TIdTCPClient);
    procedure RevPlayerSendCards(Icon: TIdTCPClient);
    procedure RevPlayerPass(Icon: TIdTCPClient);
    procedure RevPlayerChat(Icon: TIdTCPClient);
    procedure RevOnlinesUsers(Icon: TIdTCPClient);
  public
    LGbuff: RSTC_GiveBeginPlayerIdx;
    LGSendCard: RSTC_PlayerSendCards;
    LGbuffChat: RCTS_Chat;
    LGbuffPlayerIO: RSTC_PlayerIO;
    procedure Execute; override;
  end;
  TFmain = class(TForm)
    GameClient: TIdTCPClient;
    RzBackground1: TRzBackground;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    GameTabList: TRzListView;
    EgameKind: TRzComboBox;
    EgameMaxplayerCount: TRzComboBox;
    RzButton2: TRzButton;
    EtabName: TRzEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    ImageList1: TImageList;
    RzSizePanel1: TRzSizePanel;
    RzSizePanel2: TRzSizePanel;
    RzStatusBar1: TRzStatusBar;
    RzClockStatus1: TRzClockStatus;
    RzStatusPane1: TRzStatusPane;
    RzFieldStatus1: TRzFieldStatus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzButton2Click(Sender: TObject);
    procedure GameTabListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  //  procedure RzButton1Click(Sender: TObject);
    procedure GameTabListDblClick(Sender: TObject);
  private
    Ghead: RHead; //包头缓冲
    GWaiteTabArr: array of RWaiteTab; //等待桌子的数组
    GWaiteTabArrCount: Cardinal; //等待桌子的数组记数
    FTabID: Cardinal;
    FPlayerIdxIntab: Byte;
    FReadying: boolean;
    FIntabing: boolean;
    Fgaming: Boolean;
    procedure DisConn(ICon: TIdTCPClient);
    procedure PlantTabList; //更新桌子显示
    procedure RevTabPlayerList(Icon: TIdTCPClient);
    function CreateTab(ICon: TIdTCPClient; ItabName: string; IGameKind: SGameKind): boolean; //创建桌子
    function JionTab(Icon: TIdTCPClient; ITabId: Cardinal): boolean; //加入桌子
  public
    Appstate: string;
    GReciveThread: TReciveThread;
    GTabPlayerArr: array of Rplayer; //tab内玩家数组
    GTabPlayerArrCount: Byte; //tab内玩家数组记数
    property Tabing: boolean read FIntabing write FIntabing default False;
    property Readying: boolean read FReadying write FReadying default False;
    property Gaming: boolean read Fgaming write Fgaming default False;
    property TabID: Cardinal read FTabID write FTabID;
    property PlayerIdxIntab: Byte read FPlayerIdxIntab write FPlayerIdxIntab;
    procedure AddShow(Istr: string);
    procedure SendHead(ICon: TIdTCPClient; IheadCmid: Smallint); //发命令
    function LoginIn(ICon: TIdTCPClient; Iacc, Ipsd: string): boolean; //登陆
    procedure ReciveWaiteList(ICon: TIdTCPClient); //获取桌子列表
    function GetWaiteTab(ItabID: Cardinal): Cardinal;
    procedure GetTabList(Icon: TIdTCPClient); //获取空闲桌子列表
    function ReadyGame(Icon: TIdTCPClient; IReadyState: boolean): boolean; //准备好游戏了
    procedure LeaveTab(Icon: TIdTCPClient); //离开桌子
    { Public declarations }
  end;

var
  Fmain: TFmain;

implementation

uses Pgame, DateUtils, Plogin;

{$R *.dfm}

{ TFmain }

function TFmain.LoginIn(ICon: TIdTCPClient; Iacc, Ipsd: string): boolean;
var
  LBuff: RCTS_login;
begin
  Result := True;
  try
    SendHead(ICon, Cmid_CTS_Login);
    LBuff.Acc := Iacc;
    LBuff.psd := Ipsd;
    ICon.WriteBuffer(Lbuff, Sizeof(Lbuff));
    ICon.ReadBuffer(Ghead,Sizeof(Ghead));
  except
    Result := False;
  end;
end;



procedure TFmain.ReciveWaiteList(ICon: TIdTCPClient);
var
  Ibuff: RSTC_GiveWaiteTabList;
begin
  ICon.ReadBuffer(Ibuff, Sizeof(Ibuff));
  GWaiteTabArrCount := Ibuff.ListSize div Sizeof(RWaiteTab);
  if GWaiteTabArrCount > 0 then begin
    SetLength(GWaiteTabArr, GWaiteTabArrCount);
    ICon.ReadBuffer(Pointer(GWaiteTabArr)^, Ibuff.ListSize);
    PlantTabList;
  end;
end;

procedure TFmain.SendHead(ICon: TIdTCPClient; IheadCmid: Smallint);
begin
  Ghead.Cmid := IheadCmid;
  ICon.WriteBuffer(Ghead, sizeof(Ghead));
end;

function TFmain.CreateTab(ICon: TIdTCPClient; ItabName: string;
  IGameKind: SGameKind): boolean;
var
  Lbuff: RCTS_CreateTab;
begin
  Result := True;
  SendHead(ICon, CMID_CTS_CreateTab);
  Lbuff.TabName := ItabName;
  Lbuff.TabKind := IGameKind;
  ICon.WriteBuffer(Lbuff, Sizeof(Lbuff));
end;

function TFmain.JionTab(Icon: TIdTCPClient; ITabId: Cardinal): boolean;
var
  Ibuff: RCTS_JoinTab;
begin
  Result := True;
  SendHead(Icon, CMid_CTS_JoinTab);
  Ibuff.TabID := ITabId;
  Icon.WriteBuffer(Ibuff, Sizeof(Ibuff));
end;

procedure TFmain.LeaveTab(Icon: TIdTCPClient);
var
  Lbuff: RCTS_LeaveTab;
begin
  SendHead(Icon, CMID_CTS_LeaveTab);
  Lbuff.TabID := TabID;
  Lbuff.PlayerID := PlayerIdxIntab;
  Icon.WriteBuffer(Lbuff, Sizeof(Lbuff));
  Tabing := False;
end;

procedure TFmain.GetTabList(Icon: TIdTCPClient);
begin
  SendHead(Icon, Cmid_STC_GiveWaiteTabList);
end;

procedure TFmain.PlantTabLIst;
var
  I: Integer;
  Ltep: TListItem;
begin
  GameTabList.Clear;
  for I := 0 to GWaiteTabArrCount - 1 do begin // Iterate
    if GWaiteTabArr[i].TabName <> '' then begin
      Ltep := GameTabList.Items.Add;
      Ltep.Caption := GwaiteTabarr[i].TabName;
      Ltep.ImageIndex := 0;
    end;
  end; // for
end;

function TFmain.ReadyGame(Icon: TIdTCPClient;
  IReadyState: boolean): boolean;
var
  Ibuff: RCTS_ReadyGame;
begin
  Result := True;
  SendHead(Icon, Cmid_CTS_ReadyGame);
  Ibuff.TabID := TabID;
  Ibuff.PlayerINDEX := PlayerIdxIntab;
  Ibuff.STate := IReadyState;
  Icon.WriteBuffer(Ibuff, Sizeof(Ibuff));
end;

procedure TFmain.RevTabPlayerList(Icon: TIdTCPClient);
var
  Lbuff: RSTC_GiveTabPlayerList;
begin
  Icon.ReadBuffer(Lbuff, sizeof(Lbuff));
  GTabPlayerArrCount := Lbuff.Count;
  SetLength(GTabPlayerArr, GTabPlayerArrCount);
  Icon.ReadBuffer(Pointer(GTabPlayerArr)^, Lbuff.size);
end;


procedure TFmain.AddShow(Istr: string);
begin

end;

function TFmain.GetWaiteTab(ItabID: Cardinal): Cardinal;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Length(GWaiteTabArr) - 1 do begin // Iterate
    if GWaiteTabArr[i].TabID = ItabID then begin
      Result := i;
      break;
    end;
  end; // for
end;

procedure TFmain.DisConn(ICon: TIdTCPClient);
begin
  try
    SendHead(ICon, CMid_CTS_DisConn);
  except
  end;
end;

{ TReciveThread }

procedure TReciveThread.BeginGame;
begin
  Fgame.GameBeging(LGbuff.Index);
end;

procedure TReciveThread.DoExecute(Icon: TIdTCPClient);
begin
  if Fmain.Appstate <> CappstateNormal then Exit;
  ICon.ReadBuffer(Ghead, sizeof(GHead));
  case Ghead.Cmid of //
    CMid_CTS_JoinTab: RevJoinTab(ICon); //加入tab返回的
    CMID_CTS_CreateTab: RevCreateTab(ICon); //创建tab返回的
    CMID_CTS_LeaveTab: RevLeaveTab(ICon);
    Cmid_STC_TabChange: RevTabChanged(ICon); //桌子状态变更
    Cmid_STC_PlayerIO: RevPlayerChange(ICon); //tab内玩家变更
    Cmid_STC_GiveWaiteTabList: Fmain.ReciveWaiteList(Icon); //接受桌子列表
    CMID_STC_ReSetPlayerIDX: RevResetPlayerIdx(ICon); //重设玩家在桌子内的的索引
    Cmid_STC_GiveTabPlayerList: Fmain.RevTabPlayerList(ICon); //接收tab内的玩家列表
    CMid_CTS_DisConn: RevDisconn; //断开连接
    Cmid_STC_GiveCards: RevGiveCards(ICon); //获取随机数组
    Cmid_STC_GiveBeginPlayerIdx: RevGetBeginPlayerIdx(ICon); //获取开始玩家索引
    Cmid_STC_UserSendCards: RevPlayerSendCards(ICon); //用户出牌
    Cmid_STC_UserPass: RevPlayerPass(ICon); //用户跳过
    Cmid_CTS_Chat: RevPlayerChat(ICon); //用户聊天
    Cmid_CTS_GetOnlinesUser: RevOnlinesUsers(ICon);
  end; // case
end;

procedure TReciveThread.Execute;
begin
  while not Terminated do begin
    try
      if Fmain.Appstate = CappstateNormal then
        DoExecute(Fmain.GameClient);
    except
    end;
  end; // while
end;

procedure TReciveThread.RevCreateTab(ICon: TIdTCPClient);
var
  Ibuff: RCTS_CreateTab_Resp;
begin
  ICon.ReadBuffer(Ibuff, Sizeof(Ibuff));
  Fmain.TabID := Ibuff.tabid;
  Fmain.Tabing := True;
  Synchronize(SHowGameForm);
end;

procedure TReciveThread.RevDisconn;
begin
  Fmain.Appstate := CappStateStop;
  Fmain.GameClient.Disconnect;
  Application.Terminate;
end;

procedure TReciveThread.RevGetBeginPlayerIdx(Icon: TIdTCPClient);
begin
  Icon.ReadBuffer(LGbuff, sizeof(LGbuff));
  Synchronize(BeginGame);
end;

procedure TReciveThread.RevGiveCards(Icon: TIdTCPClient);
var
  Lbuff: RSTC_GiveCards;
begin
  Fgame.GameCreate;
  Icon.ReadBuffer(Lbuff, sizeof(Lbuff));
  Icon.ReadBuffer(Fgame.GMyGame.GetRandom(Lbuff.CardsSize div sizeof(byte))^, Lbuff.CardsSize);
  Fgame.GMyGame.MakeCards(False); //产生牌局
  Fgame.GMyGame.CardStackPop; //进盏
end;

procedure TReciveThread.RevJoinTab(ICon: TIdTCPClient);
var
  Ibuff: RCTS_JoinTab_RESP;
begin
  ICon.ReadBuffer(Ibuff, Sizeof(Ibuff));
  Fmain.TabID := Ibuff.TabId;
  Fmain.PlayerIdxIntab := Ibuff.PlayerINDEX;
  Fmain.Tabing := True;
  Synchronize(SHowGameForm);
end;

procedure TReciveThread.RevLeaveTab(ICon: TIdTCPClient);
begin
  Synchronize(ShowMainForm);
end;

procedure TReciveThread.RevOnlinesUsers(Icon: TIdTCPClient);
var
  Lbuff: RCTS_GetOnlinesUser;
begin
  Fmain.GameClient.ReadBuffer(Lbuff, Sizeof(Lbuff));
  Fmain.RzFieldStatus1.Tag := Lbuff.Count;
  Fmain.RzFieldStatus1.Caption := Format('在线玩家：%d个', [Fmain.RzFieldStatus1.Tag]);
//  Synchronize(SynDrawOnlineUsersCount);
end;

procedure TReciveThread.RevPlayerChange(Icon: TIdTCPClient);
begin
  Icon.ReadBuffer(LGbuffPlayerIO, sizeof(LGbuffPlayerIO));
  case LGbuffPlayerIO.Kind of
    PlayerIn: begin
        Inc(Fmain.GTabPlayerArrCount);
        if Fmain.GTabPlayerArrCount >= length(Fmain.GTabPlayerArr) then
          Setlength(Fmain.GTabPlayerArr, length(Fmain.GTabPlayerArr) + 1);
        Fmain.GTabPlayerArr[Fmain.GTabPlayerArrCount - 1] := LGbuffPlayerIO.Player;
        Synchronize(SynDrawPlayerList);
      end;
    PlayerOut: begin
        Dec(Fmain.GTabPlayerArrCount);
        DynArrayDelete(Fmain.GTabPlayerArr, sizeof(LGbuffPlayerIO.Player), LGbuffPlayerIO.Idx, 1);
        SynDrawPlayerList;
        Synchronize(SynDrawPlayerList);
      end;
    PlayerReady: begin
        Fmain.GTabPlayerArr[LGbuffPlayerIO.Idx].ReadGame := LGbuffPlayerIO.State;
        Fgame.Rzlistplayer.Items[LGbuffPlayerIO.Idx].ImageIndex:=1;
      end;
    PlayernotReady: begin
        Fmain.GTabPlayerArr[LGbuffPlayerIO.Idx].ReadGame := LGbuffPlayerIO.State;
        Fgame.Rzlistplayer.Items[LGbuffPlayerIO.Idx].ImageIndex:=0;
      end;
  end;
end;

procedure TReciveThread.RevPlayerChat(Icon: TIdTCPClient);
begin
  Icon.ReadBuffer(LGbuffchat, sizeof(LGbuffChat));
  SynAddMemo;
  Application.ProcessMessages;
end;

procedure TReciveThread.RevPlayerPass(Icon: TIdTCPClient);
var
  IBuff: RSTC_PlayerPass;
begin
  ICon.ReadBuffer(Ibuff, sizeof(Ibuff));
  Fgame.GMyGame.PlayerArr[IBuff.PLayerIdx].PlayerInfo^.PassCurrGame:=True;
  Synchronize(SynSHowNext);
end;

procedure TReciveThread.RevPlayerSendCards(Icon: TIdTCPClient);
begin
  ICon.ReadBuffer(LGsendCard, sizeof(LGsendCard));
  Synchronize(SynSendCard);
end;

procedure TReciveThread.RevResetPlayerIdx(ICon: TIdTCPClient);
var
  Ibuff: RSTC_ReSetPalyerIDX;
begin
  ICon.ReadBuffer(Ibuff, sizeof(Ibuff));
  Fmain.PlayerIdxIntab := Ibuff.NewIdx;
end;

procedure TReciveThread.RevTabChanged(ICon: TIdTCPClient);
var
  Lbuff: RSTC_TabChange;
  LTep: Cardinal;
begin
  ICon.ReadBuffer(Lbuff, Sizeof(Lbuff));
  Ltep := Fmain.GetWaiteTab(Lbuff.Param);
  case Lbuff.Kind of //
    TabAdd: begin
        inc(Fmain.GWaiteTabArrCount);
        Setlength(Fmain.GWaiteTabArr, Fmain.GWaiteTabArrCount);
        Fmain.GWaiteTabArr[Fmain.GWaiteTabArrCount - 1] := Lbuff.WaiteTab;
        Synchronize(SynDrawTabList);
      end;
    TabFree: begin
        DynArrayDelete(Fmain.GWaiteTabArr, sizeof(Lbuff.WaiteTab),
          LTep, 1);
        Fmain.GameTabList.Items.Delete(LTep);
        Synchronize(SynDrawTabList);
      end;
    TabAddPlayer: Inc(Fmain.GWaiteTabArr[LTep].TabPlayerCount);
    TabDeletePlayer: Dec(Fmain.GWaiteTabArr[LTep].TabPlayerCount);
  end; // case
end;

procedure TFmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DisConn(GameClient);
  Hide;
end;


procedure TReciveThread.SHowGameForm;
begin
  Fmain.Hide;
  Fgame.Show;
end;

procedure TReciveThread.ShowMainForm;
begin
  Fmain.GameTabList.Clear;
  Fmain.GetTabList(Fmain.GameClient);
  Fmain.SendHead(Fmain.GameClient, Cmid_CTS_GetOnlinesUser);
  Fgame.Hide;             
  Fmain.Show;
end;

procedure TReciveThread.SynAddMemo;
begin
  Fgame.AddShow(Format('%s说: ' + LGbuffChat.Content,
    [Fmain.GTabPlayerArr[LGbuffChat.PlayerID].Name]));
end;


procedure TReciveThread.SynDrawPlayerList;
var
  I: Integer;
  Ltep: TListItem;
begin
  Fgame.Rzlistplayer.Clear;
  for I := 0 to high(FMain.GTabPlayerArr) do begin // Iterate
    Ltep := Fgame.Rzlistplayer.Items.Add;
    Ltep.Caption := FMain.GTabPlayerArr[i].Name;
    if not FMain.GTabPlayerArr[i].ReadGame then
      Ltep.ImageIndex := 0
    Else Ltep.ImageIndex := 1;
  end; // for
end;

procedure TReciveThread.SynDrawTabList;
begin
  Fmain.PlantTabList;
end;

procedure TReciveThread.SynSendCard;
begin
  Fgame.SendCards(LGSendCard);
end;

procedure TReciveThread.SynSHowNext;
var
  Ltep: byte;
begin
  Ltep := Fgame.GMyGame.CheckOutWined;
  if Ltep <> 250 then Fgame.ShowNext
  else Fgame.PlayerWined(Ltep);
end;

procedure TFmain.RzBitBtn2Click(Sender: TObject);
begin
  if not Tabing then begin
    Tabing := CreateTab(GameClient, EtabName.Text, sgamekind(ord(EgameKind.ItemIndex)));
  end;
end;

procedure TFmain.RzBitBtn1Click(Sender: TObject);
begin
  if not Tabing then begin
    if GameTabList.Selected <> nil then begin
      JionTab(GameClient, GWaiteTabArr[GameTabList.Selected.Index].TabID);
    end
    else Application.MessageBox('请选择一个您要加入的桌子，如果没有选择您可以自己创建一个', '说明');
  end;
end;

procedure TFmain.RzButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TFmain.GameTabListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  GameTabList.Hint := Format('桌子名:%s ID:%d 类型:%s 现在有玩家:%d 最大玩家数:%d',
    [GwaiteTabarr[item.Index].TabName, GwaiteTabarr[item.Index].TabID,
    TranstrlGameState(GwaiteTabarr[item.Index].TabKind),
      GwaiteTabarr[item.Index].TabPlayerCount, GwaiteTabarr[item.Index].TabMaxCount]);
end;


procedure TFmain.GameTabListDblClick(Sender: TObject);
begin
  if GameTabList.Selected <> nil then RzBitBtn1.Click;
end;

end.

