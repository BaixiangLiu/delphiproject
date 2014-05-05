unit Pgame;

interface

uses
  SysUtils, messages, Windows, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, ComCtrls, RzPrgres, RzPanel, RzCmboBx, Dialogs,
  RzButton, RzLabel, RzEdit, RzListVw, Animate, GIFCtrl,
  PcardClass, PRenameCard, PGmProtect, IdTCPConnection, IdTCPClient,
  ImgList;
type
  TReNameCard = class(TCard);
  TFgame = class(TForm)
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel2: TBevel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    RzComboBox1: TRzComboBox;
    BTsendCard: TRzBitBtn;
    BtPass: TRzBitBtn;
    ChoseMoney: TRzComboBox;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    Bevel24: TBevel;
    RzGroupBox1: TRzGroupBox;
    lbCurrPlayer: TRzLabel;
    RxGifTip: TRxGIFAnimator;
    RzBitBtn6: TRzBitBtn;
    RzBitBtn7: TRzBitBtn;
    TurnTimer: TTimer;
    Lbup: TRzLabel;
    LbDown: TRzLabel;
    LbLeft: TRzLabel;
    LbRight: TRzLabel;
    RzBitBtn4: TRzBitBtn;
    Rzlistplayer: TRzListView;
    Showmemo: TRzRichEdit;
    RzProgressBar1: TRzProgressBar;
    RzLabel1: TRzLabel;
    GroupTabuserList: TRzGroupBox;
    GroupShow: TRzGroupBox;
    Imgup: TImage;
    ImgRight: TImage;
    ImgDown: TImage;
    imgLeft: TImage;
    ImageList1: TImageList;
    Image1: TImage;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RzComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzBitBtn7Click(Sender: TObject);
    procedure RzBitBtn6Click(Sender: TObject);
    procedure TurnTimerTimer(Sender: TObject);
    procedure BtPassClick(Sender: TObject);
    procedure ChoseMoneyChange(Sender: TObject);
    procedure ChoseMoneySelect(Sender: TObject);
    procedure BTsendCardClick(Sender: TObject);
    procedure ChoseMoneyKeyPress(Sender: TObject; var Key: Char);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FTurnBeginTime: TTime;
    JPGParth: string;
  public
    GMyGame: TTSPCard;
    procedure GameCreate;
    procedure GameBeging(IrandomPlayerIndex: Byte);
    procedure GameFree;
    procedure TalktoEveryBady(Icon: TIdTcpClient; Ibuff: RCTS_Chat); //聊天
    procedure AddShow(Icontent: string); //添加显示
    function GetPostBelve(Ipostion: sPlayerPostion; ICount: Byte): TBevel; //获取筐筐
    procedure ShowCard(IValue: PROneCard; Ipst: sPlayerPostion; IPos: Byte); //将扑克绘制出来
    procedure SHowGifTip(IBevel: TBevel); //画 出牌提示
    procedure SHowButtom(IState: boolean); //轮到当前玩家 显示/隐藏按钮
    function TurnSelf(ISelfIdx: byte): boolean; //判断是否轮到自己了
    function CurrIsPassUser: boolean; //是否是返放弃用户
    procedure TakeTimeBegin(Iplayer: PRplayer); //记时开始
    procedure SetCurrLable(Iplayer: PRplayer); //设置当前玩家信息
    procedure LookValue(Sender: TObject); //察看自己的头牌
    procedure SendCards(Ibuff: RSTC_PlayerSendCards); //玩家出牌
    procedure ShowNext; //画出下一家
    procedure ShowName(IPost: sPlayerPostion; Iplayer: PRplayer); //画名字和头像
    procedure VisibleName(Ipost: sPlayerPostion); //隐藏名字和头像
    procedure PlayerWined(Iidx: byte); //玩家赢了这局了
    procedure AddMoney(ICon: TIdTCPClient); //加分
    procedure ShowRule; //显示规则
  end;

var
  Fgame: TFgame;
  CardHandle: TList;

implementation

uses Pmain, DateUtils;

{$R *.dfm}

procedure TFgame.Button4Click(Sender: TObject);
begin
  if Fmain.Tabing then begin
    Fmain.LeaveTab(Fmain.GameClient);
    Fmain.GetTabList(Fmain.GameClient);
    Close;
    Fmain.Show;
  end;
end;

procedure TFgame.Button5Click(Sender: TObject);
begin
  if Fmain.Tabing then begin
    Fmain.ReadyGame(Fmain.GameClient, not Fmain.Readying);
    Fmain.Readying := not Fmain.Readying;
  end;
end;

procedure TFgame.RzBitBtn1Click(Sender: TObject);
begin
  TButton(Sender).Visible := False;
  if Fmain.Tabing then begin
    Fmain.ReadyGame(Fmain.GameClient, not Fmain.Readying);
  end;
end;

procedure TFgame.RzBitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TFgame.RzBitBtn3Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do begin
    FileName := '请选择一个要做为背景的Bmp或者Jpg图片';
    Filter := '*.*';
    if Execute then begin
      if FileExists(FileName) then
        Image1.Picture.LoadFromFile(FileName);
      Image1.SendToBack;
    end;
  end; // with
end;

procedure TFgame.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not RzBitBtn2.Enabled then begin
    if MessageDlg('在游戏中退出是会引起公愤的...,确认要引起吗？', mtWarning, [mbYes, mbNo], 0) = Mryes then
     Fgame.GameFree;
    CanClose := True;
  end
  else begin
    CanClose := True;
  end;
end;

procedure TFgame.GameBeging(IrandomPlayerIndex: Byte);
var
  I, n: Integer;
begin
Try
  GMyGame.RandomBeginPlayer(IrandomPlayerIndex);
  //开始发排 发2轮
  for I := 0 to 1 do begin // Iterate                          //初始发牌
    for n := 0 to High(GMyGame.PlayerArr) do begin // Iterate
      ShowCard(GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].InCard(GMyGame.GetOneCard),
        GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].Postion,
        GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].CurrCardCount);
      GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].PlayerInfo^.TotMoney :=
        GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].PlayerInfo^.TotMoney - 1;
      Sleep(100);
      GMyGame.NextPlayer;
    end; // for
  end; // for
Except
 Application.MessageBox('游戏处理初始化错误','悲惨');
End;  
  for I := 0 to High(GMyGame.PlayerArr) do begin // Iterate
    GMyGame.PlayerArr[i].PlayerInfo^.PassCurrGame := False; //初始化 放弃状态
    ShowName(GMyGame.PlayerArr[i].Postion, GMyGame.PlayerArr[i].PlayerInfo);
  end; // for
  SHowGifTip(GetPostBelve(GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].Postion, 6)); //画出出牌提示
  RxGifTip.Visible := True; //显示提示
  RzGroupBox1.Visible := True; //显示筐
  SetCurrLable(GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].PlayerInfo); //显示当前用户和赌金
  if TurnSelf(Fmain.PlayerIdxIntab) then //如果轮到自己画出按钮
    SHowButtom(True);
  RzBitBtn2.Enabled := False;
  FTurnBeginTime := time;
  TurnTimer.Enabled := True;
  Refresh; //刷新一下窗体

end;

procedure TFgame.GameCreate;
var
  I: Integer;
  Ltep: PRPlayer;
  Lteparr: Tlist;
begin
Try
  Lteparr := TList.Create;
  for I := 0 to High(Fmain.GTabPlayerArr) do begin // Iterate
    Ltep := @Fmain.GTabPlayerArr[i];
    Lteparr.Add(Ltep);
  end; // for
  GMyGame := TTSPCard.Create(Fmain.GTabPlayerArrCount,
    [Lteparr[0], Lteparr[1], Lteparr[2], Lteparr[3]]);
  Lteparr.Free;
  GMyGame.SetPlayerPostion(Fmain.PlayerIdxIntab);
  ShowRule;
except
Application.MessageBox('游戏管理器创建错误','倒霉');
end;
end;

procedure TFgame.GameFree;
var
  I: Integer;
begin
  for I := CardHandle.Count - 1 downto 0 do begin // Iterate
    TReNameCard(CardHandle.Items[i]).Free;
    CardHandle.Delete(i);
  end;
  for I := 0 to High(GMyGame.PlayerArr) do // Iterate
    VisibleName(GMyGame.PlayerArr[i].Postion);
  RzGroupBox1.Visible := False;
  RzProgressBar1.Visible := False;
  RxGifTip.Visible := False;
  RxGifTip.Animate:=False;
  SHowButtom(False);
  lbCurrPlayer.Tag := 0;
  TurnTimer.Enabled := False;
  RzBitBtn1.Visible := True;
  RzBitBtn2.Enabled:=True;
  FreeAndNil(GMyGame);
end;

function TFgame.GetPostBelve(Ipostion: sPlayerPostion; ICount: Byte): TBevel;
var
  I, n: Integer;
  Ltep: string;
begin
  Result := nil;
  Ltep := inttostr(ord(Ipostion) + 1) + inttostr(ICount);
  n := strtoint(Ltep);
  for I := 0 to Fgame.ComponentCount - 1 do begin // Iterate
    if Fgame.Components[i].Tag = n then begin
      Result := Fgame.Components[i] as TBevel;
      Break;
    end;
  end; // for
end;

procedure TFgame.ShowCard(IValue: PROneCard; Ipst: sPlayerPostion; IPos: Byte);
var
  Ltep: TBevel;
  LShowCard: TReNameCard;
begin
  Ltep := GetPostBelve(Ipst, IPos);
  LShowCard := TReNameCard.Create(self);
  LShowCard.Hide;
  LshowCard.Parent := Self;
  LShowCard.Top := Ltep.Top + 8;
  LShowCard.Left := Ltep.Left + 8;
  LShowCard.Tag := Ltep.Tag;
  LShowCard.OnClick := LookValue;
  LShowCard.Suit := TCardSuit(Ord(IValue^.Kind));
  LShowCard.Value := IValue^.Value;
  LShowCard.Show;
  CardHandle.Add(LShowCard);
  if copy(inttostr(Ltep.Tag), 2, 1) = '0' then LShowCard.ShowDeck := True;
end;


procedure TFgame.LookValue(Sender: TObject);
begin
  if TReNameCard(Sender).Tag = 10 then
    TReNameCard(Sender).ShowDeck := not TReNameCard(Sender).ShowDeck;
end;

procedure TFgame.FormCreate(Sender: TObject);
begin
  CardHandle := TList.Create;
  JPGParth := ExtractFilePath(Application.ExeName) + 'CardPic\'
end;

procedure TFgame.SHowGifTip(IBevel: TBevel);
begin
  RxGifTip.Top := IBevel.Top;
  RxGifTip.Left := IBevel.Left;
end;

procedure TFgame.SHowButtom(IState: boolean);
begin
  ChoseMoney.Visible := IState;
  BTsendCard.Visible := IState;
  BtPass.Visible := IState;
  Application.ProcessMessages;
end;

function TFgame.TurnSelf(ISelfIdx: byte): boolean;
begin
  Result := False;
  if GMyGame.CurrPlayerIndex = ISelfIdx then
    Result := True;
end;

procedure TFgame.RzComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Lbuff: RCTS_Chat;
begin
  if Key = VK_RETURN then begin
    if TComboBox(Sender).Items.Add(TComboBox(Sender).Text) > 10 then
      TComboBox(Sender).Items.Delete(0);
    Lbuff.TabID := Fmain.TabID;
    Lbuff.PlayerID := Fmain.PlayerIdxIntab;
    Lbuff.Content := TComboBox(Sender).Text;
    Fmain.SendHead(Fmain.GameClient, Cmid_CTS_Chat);
    TalktoEveryBady(Fmain.GameClient, Lbuff);
    TComboBox(Sender).Text := '';
  end;
end;

procedure TFgame.RzBitBtn7Click(Sender: TObject);
begin
  RxGifTip.Animate := not RxGifTip.Animate;
end;

procedure TFgame.RzBitBtn6Click(Sender: TObject);
begin
  RxGifTip.Visible := not RxGifTip.Visible;
end;

procedure TFgame.TakeTimeBegin(Iplayer: PRplayer);
begin
  TurnTimer.Enabled := True;
  FTurnBeginTime := Time;
  RzProgressBar1.Percent := 0;
end;

procedure TFgame.SetCurrLable(Iplayer: PRplayer);
begin
  lbCurrPlayer.Caption := Format('轮到玩家<%s>出牌了' + #13 +
    ' 您可以选择跟注、' + '加注、或者' + #13 + '放弃这局(可以乘早少输点分^_^)' + #13
    + '记时结束不出牌就算自动放弃' + #13 + '当前累计赌金%dW赢了就是您的'
    , [Iplayer^.Name, lbCurrPlayer.Tag]);
end;

function TFgame.CurrIsPassUser: boolean;
begin
  Result := GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].PlayerInfo^.PassCurrGame;
end;

procedure TFgame.TurnTimerTimer(Sender: TObject);
begin
  RzProgressBar1.Percent := SecondsBetween(time, FTurnBeginTime) * 100 div 30;
  if SecondsBetween(Time, FTurnBeginTime) > 30 then begin
    RzProgressBar1.Percent := 0;
    GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].PlayerInfo^.PassCurrGame := True;
    ShowNext; // 显示下一用户
  end;
end;

procedure TFgame.SendCards(Ibuff: RSTC_PlayerSendCards);
begin
  ShowCard(GMyGame.PlayerArr[Ibuff.PlayerIdx].InCard(GMyGame.GetOneCard), //画出下一图
    GMyGame.PlayerArr[Ibuff.PlayerIdx].Postion, GMyGame.PlayerArr[Ibuff.PlayerIdx].CurrCardCount);
  GMyGame.PlayerArr[Ibuff.PlayerIdx].PlayerInfo^.TotMoney := GMyGame.PlayerArr[Ibuff.PlayerIdx].PlayerInfo^.TotMoney - Ibuff.Scores;
  lbCurrPlayer.Tag := lbCurrPlayer.Tag + Ibuff.Scores;
  GMyGame.LastMoney := Ibuff.Scores;
  ShowNext; //准备下一家
end;

procedure TFgame.ShowNext;
begin
  if GMyGame.NeedCheckWin then begin
    PlayerWined(GMyGame.CheckGameWined);
  end
  else begin
    TurnTimer.Enabled := False;
    RzProgressBar1.Percent := 0;
    FTurnBeginTime := Time;
    repeat
      GMyGame.NextPlayer;
    until not CurrIsPassUser; //下一用户
    ChoseMoney.Text := Inttostr(GMyGame.LastMoney); //设置与上局同样的钱
    BTsendCard.Caption := '跟';
    if TurnSelf(Fmain.PlayerIdxIntab) then
      SHowButtom(true); //如果轮到自己就把按钮绘制出来
    SetCurrLable(GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].PlayerInfo); //显示当前用户和赌金
    SHowGifTip(GetPostBelve(GMyGame.PlayerArr[GMyGame.CurrPlayerIndex].Postion, 6)); //显示提示当前用户
    TurnTimer.Enabled := True;
  end;
end;

procedure TFgame.SHowName(IPost: sPlayerPostion; Iplayer: PRplayer);
begin
  case IPost of //
    sdown: begin
        LbDown.Caption := Iplayer^.Name;
        ImgDown.Picture.LoadFromFile(JPGParth + 'down.bmp');
        ImgDown.Visible:=True;
      end;
    sright: begin
        LbRight.Caption := Iplayer^.Name;
        ImgRight.Picture.LoadFromFile(JPGParth + 'right.bmp');
        ImgRight.Visible:=True;
      end;
    sup: begin
        Lbup.Caption := Iplayer^.Name;
        Imgup.Picture.LoadFromFile(JPGParth + 'up.bmp');
        Imgup.Visible:=True;
      end;
    sleft: begin
        LbLeft.Caption := Iplayer^.Name;
        imgLeft.Picture.LoadFromFile(JPGParth + 'left.bmp');
        imgLeft.Visible:=True;
      end;
  end; // case
end;

procedure TFgame.BtPassClick(Sender: TObject);
var
  Lbuff: RSTC_PlayerPass;
begin
  Fmain.SendHead(Fmain.GameClient, Cmid_STC_UserPass);
  Lbuff.TabID := Fmain.TabID;
  Lbuff.PLayerIdx := GMyGame.CurrPlayerIndex;
  Fmain.GameClient.WriteBuffer(Lbuff, sizeof(Lbuff));
end;

procedure TFgame.ChoseMoneyChange(Sender: TObject);
begin
  BTsendCard.Caption := '下注';
end;

procedure TFgame.ChoseMoneySelect(Sender: TObject);
begin
  if Strtoint(ChoseMoney.Text) < GMyGame.LastMoney then
    Application.MessageBox('对不起，不能选择比上家更小的赌金,请重新选择赌金', '说明');
  ChoseMoney.Text := inttostr(GMyGame.LastMoney);
end;

procedure TFgame.BTsendCardClick(Sender: TObject);
var
  Lbuff: RSTC_PlayerSendCards;
begin
  SHowButtom(False);
  Fmain.SendHead(Fmain.GameClient, Cmid_STC_UserSendCards);
  Lbuff.TabID := Fmain.TabID;
  Lbuff.PlayerIdx := GMyGame.CurrPlayerIndex;
  Lbuff.Scores := Strtoint(ChoseMoney.text);
  Fmain.GameClient.WriteBuffer(Lbuff, Sizeof(Lbuff));
end;

procedure TFgame.ChoseMoneyKeyPress(Sender: TObject; var Key: Char);
begin
  key := #0;
end;

procedure TFgame.PlayerWined(Iidx: byte);
var
  I: Integer;
begin
  for I := 0 to CardHandle.Count - 1 do // Iterate
    if TReNameCard(CardHandle.Items[i]).ShowDeck then
      TReNameCard(CardHandle.Items[i]).ShowDeck := False;
  TurnTimer.Enabled := False;
  showmessage(Format('赢家 昵称: %s ID: %d',
    [GMyGame.PlayerArr[Iidx].PlayerInfo^.Name, Iidx]));
  RzBitBtn2.Visible := True;
  GMyGame.PlayerArr[Iidx].PlayerInfo^.TotMoney :=
    GMyGame.PlayerArr[Iidx].PlayerInfo^.TotMoney + lbCurrPlayer.Tag;
  AddMoney(Fmain.GameClient);
  GameFree;
end;

procedure TFgame.RzBitBtn4Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Fgame.ComponentCount - 1 do // Iterate
    if Fgame.Components[i] is TBevel then
      (Fgame.Components[i] as TBevel).Visible := not (Fgame.Components[i] as TBevel).Visible;
end;

procedure TFgame.Timer1Timer(Sender: TObject);
begin
  RzProgressBar1.Percent := RzProgressBar1.Percent + 5;
end;

procedure TFgame.TalktoEveryBady(Icon: TIdTcpClient; Ibuff: RCTS_Chat);
begin
  Icon.WriteBuffer(Ibuff, sizeof(Ibuff));
end;

procedure TFgame.AddShow(Icontent: string);
begin
  if Showmemo.Lines.Add(Icontent) > 500 then Showmemo.Clear;
  SendMessage(Showmemo.Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TFgame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Fmain.Tabing then begin
    Fmain.LeaveTab(Fmain.GameClient);
  end;
end;

procedure TFgame.AddMoney(ICon: TIdTCPClient);
var
  I: Integer;
  Lbuff: RCTS_UseWin;
begin
  for I := 0 to high(GMyGame.PlayerArr) - 1 do    // Iterate
    GMyGame.PlayerArr[i].PlayerInfo^.ReadGame:=False;
  Fmain.SendHead(Fmain.GameClient, Cmid_CTS_Userwin);
  Lbuff.TabId := Fmain.TabID;
  Lbuff.PlayIdx := Fmain.PlayerIdxIntab;
  Lbuff.AddScore := lbCurrPlayer.Tag;
  LbCurrPlayer.Tag := 0;
  ICon.WriteBuffer(Lbuff, Sizeof(Lbuff));
end;

procedure TFgame.VisibleName(Ipost: sPlayerPostion);
begin
  case IPost of //
    sdown: begin
        LbDown.Caption := '';
        ImgDown.Visible:=False;
      end;
    sright: begin
        LbRight.Caption := '';
        ImgRight.Visible:=False;
      end;
    sup: begin
        Lbup.Caption := '';
        Imgup.Visible:=False;
      end;
    sleft: begin
        LbLeft.Caption := '';
        imgLeft.Visible:=False;
      end;
  end; // case
end;

procedure TFgame.ShowRule;
var
  S: Pchar;
begin
  S := Pchar('比较规则: 同花顺>铁支(4张同样的带1张其它的)>葫芦(3张同样带一对)>同花>顺子>3条>2对>对子>散牌' +
    '如果是同样的牌类则比较各人最大的牌');
  AddShow(S);
end;

end.

