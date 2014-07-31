unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, dxsbar, ExtCtrls, dxBar, ImgList;

type
  Tfrmmain = class(TForm)
    dxSideBarStore1: TdxSideBarStore;
    dxSideBar1: TdxSideBar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    dxSideBarStore1Item1: TdxStoredSideItem;
    dxSideBarStore1Item2: TdxStoredSideItem;
    dxSideBarStore1Item3: TdxStoredSideItem;
    dxSideBarStore1Item4: TdxStoredSideItem;
    Timer1: TTimer;
    dxSideBarStore1Item5: TdxStoredSideItem;
    dxSideBarStore1Item6: TdxStoredSideItem;
    dxSideBarStore1Item7: TdxStoredSideItem;
    dxSideBarStore1Item8: TdxStoredSideItem;
    dxSideBarStore1Item9: TdxStoredSideItem;
    dxSideBarStore1Item10: TdxStoredSideItem;
    dxSideBarStore1Item11: TdxStoredSideItem;
    dxSideBarStore1Item12: TdxStoredSideItem;
    dxSideBarStore1Item13: TdxStoredSideItem;
    dxSideBarStore1Item14: TdxStoredSideItem;
    N6: TMenuItem;
    ImageListLarge: TImageList;
    ImageListSmall: TImageList;
    PopupMenu1: TPopupMenu;
    N7: TMenuItem;
    N8: TMenuItem;
    procedure dxSideBar1ItemClick(Sender: TObject; Item: TdxSideBarItem);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    { Private declarations }
    FAnchors:Tanchors;
  //  procedure WMMOVING(var Msg: TMessage); message WM_MOVING;
  public
    { Public declarations }
  end;

var
  frmmain: Tfrmmain;

implementation

{$R *.dfm}
uses Math,huichang,huiyi,renyuan,cxtj,login,dm_seat,global, param;
           {
procedure Tfrmmain.WMMOVING(var Msg: TMessage);
begin
inherited;
with PRect(Msg.LParam)^ do begin
Left := Min(Max(0, Left), Screen.Width - Width);
Top := Min(Max(0, Top), Screen.Height - Height);
Right := Min(Max(Width, Right), Screen.Width);
Bottom := Min(Max(Height, Bottom), Screen.Height);
FAnchors := [];
if Left = 0 then Include(FAnchors, akLeft);
if Right = Screen.Width then Include(FAnchors, akRight);
if Top = 0 then Include(FAnchors, akTop);
if Bottom = Screen.Height then Include(FAnchors, akBottom);
Timer1.Enabled := FAnchors <> [];
end;
end;
   }
procedure Tfrmmain.dxSideBar1ItemClick(Sender: TObject;
  Item: TdxSideBarItem);
begin
//------------------会场管理----------------------
  if item.caption='增加会场' then
  begin
    if Application.FindComponent('frmhuichang') = nil then
      Application.CreateForm(Tfrmhuichang,frmhuichang);
    frmhuichang.caption:='增加会场';
    frmhuichang.BitBtn1.Visible:=true;
 //   frmhuichang.BitBtn2.Visible:=false;
    frmhuichang.BitBtn3.Visible:=false;
    frmhuichang.BitBtn4.Visible:=false;
    frmhuichang.showmodal;
  end;
  if item.caption='修改会场' then
  begin
    if Application.FindComponent('frmhuichang') = nil then
      Application.CreateForm(Tfrmhuichang,frmhuichang);
    frmhuichang.caption:='修改会场';
    frmhuichang.BitBtn1.Visible:=false;
//    frmhuichang.BitBtn2.Visible:=true;
    frmhuichang.BitBtn3.Visible:=false;
    frmhuichang.BitBtn4.Visible:=false;
    frmhuichang.showmodal;
  end;
  if item.caption='禁用会场' then
  begin
    if Application.FindComponent('frmhuichang') = nil then
      Application.CreateForm(Tfrmhuichang,frmhuichang);
    frmhuichang.caption:='禁用会场';
    frmhuichang.BitBtn1.Visible:=false;
 //   frmhuichang.BitBtn2.Visible:=false;
    frmhuichang.BitBtn3.Visible:=true;
    frmhuichang.BitBtn4.Visible:=false;
    frmhuichang.showmodal;
  end;
  if item.caption='启用会场' then
  begin
    if Application.FindComponent('frmhuichang') = nil then
      Application.CreateForm(Tfrmhuichang,frmhuichang);
    frmhuichang.caption:='启用会场';
    frmhuichang.BitBtn1.Visible:=false;
//    frmhuichang.BitBtn2.Visible:=false;
    frmhuichang.BitBtn3.Visible:=false;
    frmhuichang.BitBtn4.Visible:=true;
    frmhuichang.showmodal;
  end;
  //------------------会议管理----------------------
  if item.caption='增加会议' then
  begin
    if Application.FindComponent('frmhuiyi') = nil then
      Application.CreateForm(Tfrmhuiyi,frmhuiyi);
    frmhuiyi.caption:='增加会议';
    frmhuiyi.BitBtn1.Visible:=true;
  //  frmhuiyi.BitBtn2.Visible:=false;
    frmhuiyi.BitBtn3.Visible:=false;
    frmhuiyi.BitBtn6.Visible:=false;
    frmhuiyi.showmodal;
  end;
  if item.caption='修改会议' then
  begin
    if Application.FindComponent('frmhuiyi') = nil then
      Application.CreateForm(Tfrmhuiyi,frmhuiyi);
    frmhuiyi.caption:='修改会议';
    frmhuiyi.BitBtn1.Visible:=false;
//    frmhuiyi.BitBtn2.Visible:=true;
    frmhuiyi.BitBtn3.Visible:=false;
    frmhuiyi.BitBtn6.Visible:=false;
    frmhuiyi.showmodal;
  end;
  if item.caption='取消会议' then
  begin
    if Application.FindComponent('frmhuiyi') = nil then
      Application.CreateForm(Tfrmhuiyi,frmhuiyi);
    frmhuiyi.caption:='取消会议';
    frmhuiyi.BitBtn1.Visible:=false;
//    frmhuiyi.BitBtn2.Visible:=false;
    frmhuiyi.BitBtn3.Visible:=true;
    frmhuiyi.BitBtn6.Visible:=false;
    frmhuiyi.showmodal;
  end;

  //------------------人员管理----------------------
  if item.caption='新增参会人员' then
  begin
    if Application.FindComponent('frmrenyuan') = nil then
      Application.CreateForm(Tfrmrenyuan,frmrenyuan);
    frmrenyuan.caption:='新增参会人员';
    frmrenyuan.BitBtn1.Visible:=true;
 //   frmrenyuan.BitBtn2.Visible:=false;

    frmrenyuan.showmodal;
  end;
  if item.caption='修改人员信息' then
  begin
    if Application.FindComponent('frmrenyuan') = nil then
      Application.CreateForm(Tfrmrenyuan,frmrenyuan);
    frmrenyuan.caption:='修改人员信息';
    frmrenyuan.BitBtn1.Visible:=false;
 //   frmrenyuan.BitBtn2.Visible:=true;
   
    frmrenyuan.showmodal;
  end;
  //--------------------查询统计------------------
  if item.caption='会场查询与汇总' then
  begin
    if Application.FindComponent('frmcxtj') = nil then
      Application.CreateForm(Tfrmcxtj,frmcxtj);
    frmcxtj.caption:='会场查询与汇总';
    frmcxtj.dxPageControl1.ActivePage:=frmcxtj.dxTabSheet1 ;
    frmcxtj.dxPageControl2.ActivePage:=frmcxtj.dxTabSheet4;
    frmcxtj.showmodal;
  end;
  if item.caption='会议查询与汇总' then
  begin
    if Application.FindComponent('frmcxtj') = nil then
      Application.CreateForm(Tfrmcxtj,frmcxtj);
    frmcxtj.caption:='会议查询与汇总';
    frmcxtj.dxPageControl1.ActivePage:=frmcxtj.dxtabsheet2 ;
    frmcxtj.showmodal;
  end;
  if item.caption='人员查询与汇总' then
  begin
    if Application.FindComponent('frmcxtj') = nil then
      Application.CreateForm(Tfrmcxtj,frmcxtj);
    frmcxtj.caption:='人员查询与汇总';
    {
    frmcxtj.dxTabSheet1.Visible:=false;
    frmcxtj.dxTabSheet2.Visible:=false;
    frmcxtj.dxTabSheet3.Visible:=true;
    frmcxtj.dxTabSheet4.Visible:=false;
    frmcxtj.dxTabSheet5.Visible:=false;
    frmcxtj.dxTabSheet6.Visible:=true;
    }
    frmcxtj.dxPageControl1.ActivePage:=frmcxtj.dxtabsheet3 ;
    frmcxtj.showmodal;
  end;
  //------------------席位安排----------------------
  if item.caption='席位安排' then
  begin
    if Application.FindComponent('frmhuiyi') = nil then
      Application.CreateForm(Tfrmhuiyi,frmhuiyi);
    frmhuiyi.caption:='席位安排';
    frmhuiyi.BitBtn1.Visible:=false;
 //   frmhuiyi.BitBtn2.Visible:=false;
    frmhuiyi.BitBtn3.Visible:=false;
    frmhuiyi.BitBtn6.Visible:=true;
    frmhuiyi.showmodal;
  end;
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer1.Interval := 200;
  FormStyle := fsStayOnTop;
end;

procedure Tfrmmain.Timer1Timer(Sender: TObject);
const 
  cOffset = 2;
begin
{
if WindowFromPoint(Mouse.CursorPos) = Handle then begin
if akLeft in FAnchors then Left := 0;
if akTop in FAnchors then Top := 0;
if akRight in FAnchors then Left := Screen.Width - Width;
if akBottom in FAnchors then Top := Screen.Height - Height;
end else begin
if akLeft in FAnchors then Left := -Width + cOffset;
if akTop in FAnchors then Top := -Height + cOffset;
if akRight in FAnchors then Left := Screen.Width - cOffset;
if akBottom in FAnchors then Top := Screen.Height - cOffset;
end;
} 
end;

procedure Tfrmmain.FormShow(Sender: TObject);
begin
  inipath:=ExtractFilePath(Application.ExeName);
  if FileExists(inipath + 'conn.ini') then
  begin
    if not dmseat.connectdb(dmseat.seatconn) then
    begin
      if Application.FindComponent('frmlogin') = nil then
        Application.CreateForm(Tfrmlogin,frmlogin);
      frmlogin.ShowModal;
    end;
  end
  else
  begin
    if Application.FindComponent('frmlogin') = nil then
      Application.CreateForm(Tfrmlogin,frmlogin);
    frmlogin.ShowModal;
  end;

end;

procedure Tfrmmain.N6Click(Sender: TObject);
begin
  if Application.FindComponent('frm_param') = nil then
      Application.CreateForm(Tfrm_param,frm_param);
    frm_param.ShowModal;
end;

procedure Tfrmmain.N7Click(Sender: TObject);
begin
  dxSideBar1.ActiveGroup.IconType := dxsgLargeIcon;
  N7.Checked := True;
end;

procedure Tfrmmain.N8Click(Sender: TObject);
begin
  dxSideBar1.ActiveGroup.IconType := dxsgSmallIcon;
  N8.Checked := True;
end;

end.
