unit UNRPTX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, jpeg, ExtCtrls;

type
  TFMRPTX = class(TForm)
    Image: TImage;
    IMG_POS2: TImage;
    LB_POSD: TLabel;
    LB_QUT: TLabel;
    IMG_QUT: TImage;
    IMG_POS3: TImage;
    IMG_POS5: TImage;
    IMG_POS6: TImage;
    IMG_POS7: TImage;
    IMG_POSD: TImage;
    IMG_POS1: TImage;
    LB_POS1: TLabel;
    LB_POS2: TLabel;
    LB_POS3: TLabel;
    LB_POS5: TLabel;
    LB_POS6: TLabel;
    LB_POS7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNQUTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PANEL_PAMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure IMG_POSDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMRPTX: TFMRPTX;

implementation

uses INIFILES, FILECTRL, UN_UTL, FM_UTL, DB_UTL, SYSINI, MAINU,



     RPPOS3F,    //会员消费记录明细表
//     RPPOS4F, RPPOS4P,                      //仓库销售计算报表
     RPPOS5F,    //会员消费计算报表
     RPPOS6F,    //产品销售计算报表
     RPPOS7F,    //礼券刷卡明细表

     RPTOP1F,    // 产品销售排行搒
     RPTOP2F,    // 会员销售排行搒
     RPTOP3F,    // 客户销售排行搒
     RPLOGF ;     // 使用者登录表




{$R *.DFM}

procedure TFMRPTX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FMRPTX.Release;
end;

procedure TFMRPTX.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMRPTX.FormCreate(Sender: TObject);
VAR FILENAME: STRING;
begin
FILENAME := ExtractFilePath(Application.EXEName)+'PIC\RPTX.JPG';
IF FileExists(FILENAME)=TRUE THEN IMAGE.Picture.LoadFromFile(FILENAME);



FILENAME := ExtractFilePath(Application.EXEName)+'PIC\REPORT.BMP';
IF FileExists(FILENAME)=TRUE THEN IMG_POSD.Picture.LoadFromFile(FILENAME);
IF FileExists(FILENAME)=TRUE THEN IMG_POS1.Picture.LoadFromFile(FILENAME);
IF FileExists(FILENAME)=TRUE THEN IMG_POS2.Picture.LoadFromFile(FILENAME);
IF FileExists(FILENAME)=TRUE THEN IMG_POS3.Picture.LoadFromFile(FILENAME);
IF FileExists(FILENAME)=TRUE THEN IMG_POS5.Picture.LoadFromFile(FILENAME);
IF FileExists(FILENAME)=TRUE THEN IMG_POS6.Picture.LoadFromFile(FILENAME);
IF FileExists(FILENAME)=TRUE THEN IMG_POS7.Picture.LoadFromFile(FILENAME);


FILENAME := ExtractFilePath(Application.EXEName)+'PIC\HOME.BMP';
IF FileExists(FILENAME)=TRUE THEN IMG_QUT.Picture.LoadFromFile(FILENAME);
end;

procedure TFMRPTX.PANEL_PAMouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
begin
{
PANEL_PA.Font.Color := clNavy;
PANEL_PB.Font.Color := clNavy;
PANEL_PC.Font.Color := clNavy;
PANEL_PD.Font.Color := clNavy;


IF SENDER = PANEL_PA THEN PANEL_PA.FONT.COLOR := CLRED;
IF SENDER = PANEL_PB THEN PANEL_PB.FONT.COLOR := CLRED;
IF SENDER = PANEL_PC THEN PANEL_PC.FONT.COLOR := CLRED;
IF SENDER = PANEL_PD THEN PANEL_PD.FONT.COLOR := CLRED;
}
end;

procedure TFMRPTX.IMG_POSDClick(Sender: TObject);
begin



IF ( SENDER=IMG_POS3 ) OR ( SENDER=LB_POS3 ) THEN
   BEGIN
   IF PERMISSION_CHECK(_USER_ID,'RPT_POS3') = FALSE THEN EXIT; //检查权限============================================
   IF FormExists('RMPOS3F')=FALSE THEN Application.CreateForm(TRMPOS3F,  RMPOS3F  );
   Form_NORMAL_SHOW(RMPOS3F,-1,-1);
   END;
IF ( SENDER=IMG_POS5 ) OR ( SENDER=LB_POS5 ) THEN
   BEGIN
   IF PERMISSION_CHECK(_USER_ID,'RPT_POS5') = FALSE THEN EXIT; //检查权限============================================
   IF FormExists('RMPOS5F')=FALSE THEN Application.CreateForm(TRMPOS5F,  RMPOS5F  );
   Form_NORMAL_SHOW(RMPOS5F,-1,-1);
   END;
IF ( SENDER=IMG_POS6 ) OR ( SENDER=LB_POS6 ) THEN
   BEGIN
   IF PERMISSION_CHECK(_USER_ID,'RPT_POS6') = FALSE THEN EXIT; //检查权限============================================
   IF FormExists('RMPOS6F')=FALSE THEN Application.CreateForm(TRMPOS6F,  RMPOS6F  );
   Form_NORMAL_SHOW(RMPOS6F,-1,-1);
   END;
IF ( SENDER=IMG_POS7 ) OR ( SENDER=LB_POS7 ) THEN
   BEGIN
   IF PERMISSION_CHECK(_USER_ID,'RPT_POS7') = FALSE THEN EXIT; //检查权限============================================
   IF FormExists('RMPOS7F')=FALSE THEN Application.CreateForm(TRMPOS7F,  RMPOS7F  );
   Form_NORMAL_SHOW(RMPOS7F,-1,-1);
   END;















end;

end.
