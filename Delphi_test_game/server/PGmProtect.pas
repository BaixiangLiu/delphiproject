unit PGmProtect;

interface
uses
  IdTCPServer;
type
  SGameKind = (SGKsh, SGKsk, SGKddz); //游戏类型
  PRWaiteTab = ^RWaiteTab;
  RWaiteTab = packed record
    TabID: Cardinal;
    TabKind: SGameKind;
    TabName: string[40];
    TabPlayerCount: Byte;
    TabMaxCount:Byte;
  end;
  PRPlayer = ^Rplayer;
  Rplayer = record //玩家结构
    Index: Byte; //自己的索引
    ID: Cardinal; //id号
    Name: string[20]; //呢称
    Contenting: TIdPeerThread; //连接
    ReadGame: boolean; //准备好开始游戏
    PassCurrGame: boolean; //是否放弃了当前游戏
    TotMoney: Integer; //总分
  end;
  RHead = packed record
    Cmid: Cardinal;
  end;
  RCTS_login = packed record
    Acc: string[20];
    psd: string[20];
  end;
  RCTS_Login_RESP = packed record
    Code: string[20];
  end;
  RCTS_CreateTab = packed record
    TabName: string[40];
    TabKind: SGameKind;
  end;
  RCTS_CreateTab_RESP = packed record
    tabid: Cardinal;
  end;
  RCTS_JoinTab = packed record
    TabID: Cardinal;
  end;
  RCTS_JoinTab_RESP = packed record
    TabId: Cardinal;
    PlayerINDEX: byte;
  end;
  RCTS_ReadyGame = packed record
    TabID: Cardinal;
    PlayerINDEX: byte;
    STate: boolean;
  end;
  RCTS_LeaveTab = packed record
    TabID: Cardinal;
    PlayerID: Byte;
  end;
  RCTS_Chat=Packed Record
    SendIdx:Cardinal;
    TabID:Cardinal;
    PlayerID:Byte;
    Content:string[128];
  end;
  RCTS_GetOnlinesUser=Packed Record
    Count:Integer;
  end;
  RCTS_UseWin=Packed Record
    TabId:Cardinal;
    PlayIdx:Byte;
    AddScore:Integer;
  end;
  RSTC_GiveCards = packed record
    CardsSize: Cardinal;
    Count: Byte;
    SupperState: boolean; //是否创建大小鬼
    LoopCount: Byte; //循环次数
  end;
  RSTC_ReSetPalyerIDX = packed record
    NewIdx: Byte;
  end;
  RSTC_GiveWaiteTabList = packed record
    ListSize: Cardinal;
  end;
  sTabChange = (TabAdd, TabFree, TabAddPlayer, TabDeletePlayer);
  RSTC_TabChange = packed record
    Kind: sTabChange;
    Param: Cardinal;
    WaiteTab: RWaiteTab;
  end;
  RSTC_GiveTabPlayerList = packed record
    size: Cardinal;
    Count: Cardinal;
  end;
  sPlayerChange = (PlayerIn, PlayerOut, PlayerReady, PlayernotReady);
  RSTC_PlayerIO = packed record
    Kind: sPlayerChange;
    Idx: Byte;
    Player: Rplayer;
    State: boolean;
  end;
  RSTC_GiveBeginPlayerIdx = packed record
    Index: Byte;
  end;
  RSTC_PlayerSendCards = packed record
    TabID: Cardinal;
    PlayerIdx: Byte;
    SendCards: string[20]; //牌的索引可以用|分隔
    Scores: Integer; //下的注
  end;
  RSTC_PlayerPass = packed record
    TabID: Cardinal;
    PLayerIdx: byte;
  end;

  Function TranstrlGameState(Ikind:SGameKind):String;
const
  CappstateNormal = '正常状态';
  CappStateStop = '服务停止状态';
  CappStateTermintal = '程序结束状态';

  CErrorCode = 99;
  Cmid_CTS_Login = 10001; //登陆
  ClogRESP1 = '成功登陆';
  ClogRESP2 = '用户名不存在';
  ClogRESP3 = '用户名或者密码错误';

  Cmid_CTS_ReadyGame = 10002; //准备开始游戏
  CMid_CTS_DisConn = 10003; //断开连接
  CMid_CTS_JoinTab = 10004; //加入Tab
  CMID_CTS_LeaveTab = 10005; //离开桌子
  CMID_CTS_CreateTab = 10006; //创建桌子
  Cmid_CTS_Chat=10007; //聊天
  Cmid_CTS_GetOnlinesUser=10008;//获取在线用户
  Cmid_CTS_Userwin=10009;//用户赢了+分

  Cmid_STC_GiveCards = 20001; //接收牌局
  CMID_STC_ReSetPlayerIDX = 20002; //重新设置玩家在这张桌子的索引iD号
  Cmid_STC_GiveWaiteTabList = 20003; //发送在等待桌子的列表
  Cmid_STC_TabChange = 20004; //桌子产生变动
  Cmid_STC_GiveTabPlayerList = 20005; //给tab用户列表
  Cmid_STC_PlayerIO = 20006; //玩家变动
  Cmid_STC_GiveBeginPlayerIdx = 20007; //给开始玩家的索引
  Cmid_STC_UserSendCards = 20008; //玩家出牌
  Cmid_STC_UserPass = 20009; //玩家放弃或跳过

implementation
  Function TranstrlGameState(Ikind:SGameKind):String;
  Begin
    Case Ikind Of    //
      SGKsh:Result:='梭哈';
      Else Result:='不认识的类型';
    End;    // case
  End;
end.
