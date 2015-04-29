unit UNREP1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, FlEdit, DsnUnit, DsnSubMl, DsnSub8, Qrctrls,
  QuickRpt, ExtCtrls, Buttons, ComCtrls, ToolWin, JEdit, Spin;



type
  TQRLBEdit = class(TQRLABEL)
  private
  protected
  public
  published
  end;

type
  TQRQDEdit = class(TQRDBTEXT)
  private
  protected
  public
  published
  end;

type
  TQRSPEdit = class(TQRSHAPE)
  private
  protected
  public
  published
  end;


type
  TFMREP1 = class(TForm)
    ToolBar1: TToolBar;
    DsnSwitch1: TDsnSwitch;
    QRLB: TDsnStage;
    QuickRep: TQuickRep;
    QRBand_TITLE: TQRBand;
    QRShape9: TQRShape;
    QRBand5: TQRBand;
    QRBand_DETAIL: TQRBand;
    QRShape21: TQRShape;
    QRShape7: TQRShape;
    Dsn8Register1: TDsn8Register;
    QRShape5: TQRShape;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Query: TQuery;
    VRITUAL_LB: TLabel;
    VRITUAL_QD: TLabel;
    VRITUAL_SP: TLabel;
    Panel1: TPanel;
    BTNPRN: TSpeedButton;
    BTNCLR: TSpeedButton;
    BTNSAV: TSpeedButton;
    BTNQUT: TSpeedButton;
    PageControl1: TPageControl;
    PAGE_A: TTabSheet;
    TabSheet2: TTabSheet;
    BTN_QRLB: TSpeedButton;
    BTN_QRQD: TSpeedButton;
    BTN_QRSPV: TSpeedButton;
    BTN_QRSPH: TSpeedButton;
    BTN_QRSPR: TSpeedButton;
    CB_COL: TComboBox;
    TabSheet1: TTabSheet;
    Label6: TLabel;
    Label11: TLabel;
    ED_OBJ_TOP:   TJEdit;
    ED_OBJ_LEFT:  TJEdit;
    ED_OBJ_HEIGHT:TJEdit;
    ED_OBJ_WIDTH: TJEdit;

    Label12: TLabel;
    Label13: TLabel;
    ED_OBJ: TLabel;
    ED_PAGE_LENGTH: TFloatEdit;
    ED_PAGE_WIDTH: TFloatEdit;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    ED_PAGE_TOPMARGIN: TFloatEdit;
    Label8: TLabel;
    ED_PAGE_BOTTOMMARGIN: TFloatEdit;
    Label9: TLabel;
    ED_PAGE_LEFTMARGIN: TFloatEdit;
    Label10: TLabel;
    ED_PAGE_RIGHTMARGIN: TFloatEdit;
    ED_PAGE_TABLE: TComboBox;
    Label4: TLabel;
    BTN_OBJ_APPLY: TBitBtn;
    Label2: TLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel18: TQRLabel;
    XLB_USER_TEL: TQRLabel;
    XLB_USER_RBPST: TQRLabel;
    XLB_USER_NO: TQRLabel;
    XLB_USER_FAX: TQRLabel;
    XLB_USER_ADDR: TQRLabel;
    XLB_USER_NAME: TQRLabel;
    XLB_DAT1: TQRLabel;
    Label14: TLabel;
    ED_PAGE_TITLE: TJEdit;
    BTN_PAGE_APPLY: TBitBtn;
    XLB_TITLE: TQRLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Label15: TLabel;
    ED_OBJ_FIELD: TComboBox;
    ED_OBJ_SHAPE: TComboBox;
    Label1: TLabel;
    BTN_OBJ_APPLY_LB: TBitBtn;
    BTN_OBJ_APPLY_QD: TBitBtn;
    BTN_OBJ_APPLY_SP: TBitBtn;
    Label16: TLabel;
    Label17: TLabel;
    ED_OBJ_FONTSIZE: TSpinEdit;
    ED_OBJ_NAME: TJEdit;
    ED_OBJ_CAPTION: TJEdit;
    procedure BTNQUTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTN_QRLBClick(Sender: TObject);
    procedure BTN_QRQDClick(Sender: TObject);
    procedure BTNCLRClick(Sender: TObject);
    procedure BTN_QRSPVClick(Sender: TObject);
    procedure BTN_QRSPHClick(Sender: TObject);
    procedure BTN_QRSPRClick(Sender: TObject);
    procedure BTNSAVClick(Sender: TObject);
    procedure DsnSwitch1Click(Sender: TObject);
    procedure BTNPRNClick(Sender: TObject);
    procedure ED_PAGE_TABLEChange(Sender: TObject);
    procedure VRITUAL_LBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VRITUAL_SPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VRITUAL_QDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure BTN_OBJ_APPLYClick(Sender: TObject);
    procedure BTN_PAGE_APPLYClick(Sender: TObject);
    procedure ED_OBJ_NAMEChange(Sender: TObject);
  private
    { Private declarations }
    FUNCTION IS_CHANGED(CHANGED:BOOLEAN):BOOLEAN;
  public
    { Public declarations }
    QR_CHANGED : BOOLEAN; //更改过
    QR_NAME : STRING;  //存储档名

    QR_KEY_FIELD : STRING;  // KEY 字段
    QR_KEY_VALUE : STRING;  // KEY 对应值

    QR_TABLE_LIST : STRING;  // 列出的TABLE

    LB_CNT : INTEGER; //目前已有组件数
    QD_CNT : INTEGER; //目前已有组件数
    SP_CNT : INTEGER; //目前已有组件数
    QR_LB  : ARRAY [1..100] OF TQRLBEDIT;
    QR_QD  : ARRAY [1..100] OF TQRQDEDIT;
    QR_SP  : ARRAY [1..100] OF TQRSPEDIT;


    FUNCTION  CREATE_LB :BOOLEAN;       //产生 LABEL
    FUNCTION  CREATE_QD :BOOLEAN;       //产生 DB TEXT
    FUNCTION  CREATE_SP(SHAPE:STRING) :BOOLEAN;       //产生 SHAPE

    FUNCTION  FIND_MAX_LBCNT(KIND:STRING):INTEGER;  //找出 LABEL   最大数量

    PROCEDURE SAVE_INI;
    PROCEDURE LOAD_INI;
    PROCEDURE FREE_ALL_LB;
  end;

var
  FMREP1: TFMREP1;

implementation

USES inifiles, DB_UTL, UN_UTL, FM_UTL, MAIND, SYSINI;

{$R *.DFM}


FUNCTION TFMREP1.IS_CHANGED(CHANGED:BOOLEAN):BOOLEAN;
BEGIN
  IF CHANGED = TRUE THEN
     BEGIN
     BTN_OBJ_APPLY.Enabled := TRUE;
     QR_CHANGED := TRUE; //更改过
     END ELSE BEGIN
     BTN_OBJ_APPLY.Enabled := FALSE;
     QR_CHANGED := FALSE; //未更改过
     END;
END;




FUNCTION  TFMREP1.CREATE_LB :BOOLEAN;
BEGIN
LB_CNT := FIND_MAX_LBCNT('LB');  //找出 LABEL   最大数量

//产生对象
QR_LB[LB_CNT] := TQRLBEDIT.Create(FMREP1);
IF CB_COL.ItemIndex <=0 THEN
   BEGIN
   QR_LB[LB_CNT].Parent := QRBand_TITLE;
   END ELSE BEGIN
   QR_LB[LB_CNT].Parent := QRBand_DETAIL;
   END;

QR_LB[LB_CNT].Name := 'LB'+INTTOSTR(LB_CNT);
QR_LB[LB_CNT].COLOR:= clWhite;
QR_LB[LB_CNT].Left := 5;
QR_LB[LB_CNT].TOP  := 5;
QR_LB[LB_CNT].Caption := '标签_'+INTTOSTR(LB_CNT);
QR_LB[LB_CNT].Cursor :=  crSizeAll;
QR_LB[LB_CNT].FONT.Size := 9;
QR_LB[LB_CNT].FONT.NAME := '新宋体';
QR_LB[LB_CNT].FONT.Style  := [fsBold];
QR_LB[LB_CNT].AutoSize  := TRUE;
QR_LB[LB_CNT].WORDWRAP  := FALSE;

QR_LB[LB_CNT].OnMouseDown := VRITUAL_LBMouseDown;
QR_LB[LB_CNT].BringToFront;
END;

FUNCTION  TFMREP1.CREATE_QD :BOOLEAN;
VAR N : INTEGER;
BEGIN
QD_CNT := FIND_MAX_LBCNT('QD');  //找出 BARCODE   最大数量

//产生对象
QR_QD[QD_CNT] := TQRQDEDIT.Create(FMREP1);
IF CB_COL.ItemIndex <=0 THEN
   BEGIN
   QR_QD[QD_CNT].Parent := QRBand_TITLE;
   END ELSE BEGIN
   QR_QD[QD_CNT].Parent := QRBand_DETAIL;
   END;

QR_QD[QD_CNT].Name := 'QD'+INTTOSTR(QD_CNT);
QR_QD[QD_CNT].COLOR:= clWhite;
QR_QD[QD_CNT].Left := 5;
QR_QD[QD_CNT].TOP  := 5;
QR_QD[QD_CNT].Caption := '资料_'+INTTOSTR(QD_CNT);
QR_QD[QD_CNT].Cursor :=  crSizeAll;
QR_QD[QD_CNT].FONT.Size := 9;
QR_QD[QD_CNT].FONT.NAME := '新宋体';
QR_QD[QD_CNT].AutoSize  := FALSE;
QR_QD[QD_CNT].WORDWRAP  := FALSE;

QR_QD[QD_CNT].DATASET   := QUERY;


QR_QD[QD_CNT].OnMouseDown := VRITUAL_QDMouseDown;
QR_QD[QD_CNT].BringToFront;
END;


FUNCTION  TFMREP1.CREATE_SP(SHAPE:STRING) :BOOLEAN;
VAR N : INTEGER;
BEGIN
SP_CNT := FIND_MAX_LBCNT('SP');  //找出 BARCODE   最大数量

//产生对象
QR_SP[SP_CNT] := TQRSPEDIT.Create(FMREP1);
IF CB_COL.ItemIndex <=0 THEN
   BEGIN
   QR_SP[SP_CNT].Parent := QRBand_TITLE;
   END ELSE BEGIN
   QR_SP[SP_CNT].Parent := QRBand_DETAIL;
   END;
   
IF SHAPE = 'qrsVertLine'  THEN QR_SP[SP_CNT].Shape := qrsVertLine;
IF SHAPE = 'qrsHorLine'   THEN QR_SP[SP_CNT].Shape := qrsHorLine;
IF SHAPE = 'qrsRectangle' THEN QR_SP[SP_CNT].Shape := qrsRectangle;

IF SHAPE = 'qrsVertLine'  THEN BEGIN QR_SP[SP_CNT].WIDTH := 1 ; QR_SP[SP_CNT].HEIGHT := 20; END;
IF SHAPE = 'qrsHorLine'   THEN BEGIN QR_SP[SP_CNT].WIDTH := 20; QR_SP[SP_CNT].HEIGHT := 1;  END;

QR_SP[SP_CNT].Name := 'SP'+INTTOSTR(SP_CNT);
QR_SP[SP_CNT].COLOR:= clBLACK;
QR_SP[SP_CNT].Left := 5;
QR_SP[SP_CNT].TOP  := 5;

QR_SP[SP_CNT].OnMouseDown := VRITUAL_SPMouseDown;
QR_SP[SP_CNT].BringToFront;
END;

FUNCTION TFMREP1.FIND_MAX_LBCNT (KIND:STRING):INTEGER;  //找出 LABEL   最大数量
VAR N ,R : INTEGER;
BEGIN
R := 1;
//找出目前最后一号,   最大值
FOR N := 0 TO FMREP1.ComponentCount-1 DO
    BEGIN
    WITH FMREP1.Components[N] DO
    IF (COPY(NAME,1,2) = KIND) AND
       (R <= STRTOINTDEF(COPY(NAME,3,LENGTH(NAME)-2),1))  THEN
        R := STRTOINTDEF(COPY(NAME,3,LENGTH(NAME)-2),1) + 1;
    END;
RESULT := R;
END;






// FUNCTION ========================================================================
PROCEDURE TFMREP1.SAVE_INI;
var T : Tinifile;    N : INTEGER;    S : TOBJECT;  //暂存对象
BEGIN

TRY
   IF FMREP1.FindComponent('S') = NIL THEN S := TOBJECT.Create;
   T := Tinifile.Create(QR_NAME);

   //删除所有资料
   FOR N := 0 TO 100 DO
       BEGIN
       T.EraseSection('PAGE');
       T.EraseSection('LB'+INTTOSTR(N));
       T.EraseSection('QD'+INTTOSTR(N));
       T.EraseSection('SP'+INTTOSTR(N));
       END;

   //存入 报表 信息
   T.WriteFloat('PAGE','QRBand_TITLE.Height'  ,QRBand_TITLE.Height);
   T.WriteFloat('PAGE','QRBand_TITLE.Width'   ,QRBand_TITLE.Width);

   T.WriteFloat('PAGE','QuickRep.Page.Width'        , ED_PAGE_WIDTH.Value        );
   T.WriteFloat('PAGE','QuickRep.Page.Length'       , ED_PAGE_LENGTH.Value       );
   T.WriteFloat('PAGE','QuickRep.Page.TopMargin'    , ED_PAGE_TOPMARGIN.Value    );
   T.WriteFloat('PAGE','QuickRep.Page.BottomMargin' , ED_PAGE_BOTTOMMARGIN.Value );
   T.WriteFloat('PAGE','QuickRep.Page.LeftMargin'   , ED_PAGE_LEFTMARGIN.Value   );
   T.WriteFloat('PAGE','QuickRep.Page.RightMargin'  , ED_PAGE_RIGHTMARGIN.Value  );
   T.WriteString('PAGE','XLB_TITLE.Caption'         , ED_PAGE_TITLE.Text         );



   FOR N := 0 TO FMREP1.ComponentCount-1 DO
       BEGIN
       WITH FMREP1.Components[N] DO
            BEGIN

            // LABEL ================================================
            IF COPY(NAME,1,2) = 'LB' THEN
               BEGIN
               S := FMREP1.Components[N];

               WITH S AS TQRLBEDIT DO
               BEGIN
               T.WriteString (NAME,'NAME'   ,Name);
               T.WriteString (NAME,'PARENT' ,PARENT.Name);
               T.WriteString (NAME,'CAPTION',CAPTION);

               T.WriteInteger(NAME,'FONTSIZE' ,FONT.SIZE);

               T.WriteInteger(NAME,'LEFT'   ,LEFT);
               T.WriteInteger(NAME,'TOP'    ,TOP);
               T.WriteInteger(NAME,'HEIGHT' ,HEIGHT);
               T.WriteInteger(NAME,'WIDTH'  ,WIDTH);
               END;
               END;
            //=======================================================

            // LABEL ================================================
            IF COPY(NAME,1,2) = 'QD' THEN
               BEGIN
               S := FMREP1.Components[N];

               WITH S AS TQRDBTEXT DO
               BEGIN
               T.WriteString (NAME,'NAME'     ,Name);
               T.WriteString (NAME,'PARENT'   ,PARENT.Name);
               T.WriteString (NAME,'DATAFIELD',DATAFIELD);
               T.WriteInteger(NAME,'FONTSIZE' ,FONT.SIZE);

               T.WriteInteger(NAME,'LEFT'   ,LEFT);
               T.WriteInteger(NAME,'TOP'    ,TOP);
               T.WriteInteger(NAME,'HEIGHT' ,HEIGHT);
               T.WriteInteger(NAME,'WIDTH'  ,WIDTH);
               END;
               END;
            //=======================================================

            // LABEL ================================================
            IF COPY(NAME,1,2) = 'SP' THEN
               BEGIN
               S := FMREP1.Components[N];


               WITH S AS TQRSHAPE DO
               BEGIN
               T.WriteString (NAME,'NAME'   ,Name);
               T.WriteString (NAME,'PARENT' ,PARENT.Name);

               T.WriteInteger(NAME,'LEFT'   ,LEFT);
               T.WriteInteger(NAME,'TOP'    ,TOP);
               T.WriteInteger(NAME,'WIDTH'  ,WIDTH);
               T.WriteInteger(NAME,'HEIGHT' ,HEIGHT);

//               T.WriteString (NAME,'SHAPE'  ,VARTOSTR(SHAPE));
               T.WriteString (NAME,'COLOR'  ,COLORTOSTRING(PEN.COLOR));
               END;
               END;
            //=======================================================

            END;

       END;

FINALLY
   T.Free;
END;

END;


PROCEDURE TFMREP1.LOAD_INI;
var T : Tinifile;    N : INTEGER;    S : TOBJECT;  //暂存对象
    T_STR : STRING;
BEGIN


   
FREE_ALL_LB;  //先清除原先 LABEL

TRY
   IF FMREP1.FindComponent('S') = NIL THEN S := TOBJECT.Create;
   T := Tinifile.Create(QR_NAME);

   FOR N := 0 TO 100 DO
       BEGIN
       IF T.SectionExists('LB'+INTTOSTR(N)) = TRUE THEN CREATE_LB;
       IF T.SectionExists('QD'+INTTOSTR(N)) = TRUE THEN CREATE_QD;
       IF T.SectionExists('SP'+INTTOSTR(N)) = TRUE THEN CREATE_SP('qrsVertLine');
       END;


   ED_PAGE_WIDTH.Value        := T.ReadFloat('PAGE','QuickRep.Page.Width'        , QuickRep.Page.Width        );
   ED_PAGE_LENGTH.Value       := T.ReadFloat('PAGE','QuickRep.Page.Length'       , QuickRep.Page.Length       );
   ED_PAGE_TOPMARGIN.Value    := T.ReadFloat('PAGE','QuickRep.Page.TopMargin'    , QuickRep.Page.TopMargin    );
   ED_PAGE_BOTTOMMARGIN.Value := T.ReadFloat('PAGE','QuickRep.Page.BottomMargin' , QuickRep.Page.BottomMargin );
   ED_PAGE_LEFTMARGIN.Value   := T.ReadFloat('PAGE','QuickRep.Page.LeftMargin'   , QuickRep.Page.LeftMargin   );
   ED_PAGE_RIGHTMARGIN.Value  := T.ReadFloat('PAGE','QuickRep.Page.RightMargin'  , QuickRep.Page.RightMargin  );
   ED_PAGE_TITLE.Text         := T.ReadString('PAGE','XLB_TITLE.Caption'         , XLB_TITLE.Caption          );

   QuickRep.Page.Width         := ED_PAGE_WIDTH.Value       ;
   QuickRep.Page.Length        := ED_PAGE_LENGTH.Value      ;
   QuickRep.Page.TopMargin     := ED_PAGE_TOPMARGIN.Value   ;
   QuickRep.Page.BottomMargin  := ED_PAGE_BOTTOMMARGIN.Value;
   QuickRep.Page.LeftMargin    := ED_PAGE_LEFTMARGIN.Value  ;
   QuickRep.Page.RightMargin   := ED_PAGE_RIGHTMARGIN.Value ;
   XLB_TITLE.Caption           := ED_PAGE_TITLE.Text        ;













   FOR N := 0 TO FMREP1.ComponentCount-1 DO
       BEGIN
       WITH FMREP1.Components[N] DO
            BEGIN


            // LABEL ================================================
            IF COPY(NAME,1,2) = 'LB' THEN
               BEGIN
               S := FMREP1.Components[N];
               WITH S AS TQRLBEDIT DO
               BEGIN
               NAME    := T.ReadString (NAME,'NAME'   ,Name);
               PARENT  := QRBand_TITLE;
               IF T.ReadString (NAME,'PARENT' ,PARENT.Name) = 'QRBand_DETAIL' THEN PARENT  := QRBand_DETAIL;
               CAPTION := T.ReadString (NAME,'CAPTION',CAPTION);

               FONT.Size  := T.ReadInteger(NAME,'FONTSIZE'   ,FONT.SIZE);

               LEFT   := T.ReadInteger(NAME,'LEFT'   ,LEFT);
               TOP    := T.ReadInteger(NAME,'TOP'    ,TOP);
               HEIGHT := T.ReadInteger(NAME,'HEIGHT' ,HEIGHT);
//             WIDTH  := T.ReadInteger(NAME,'WIDTH',WIDTH);
               END;
               END;
            //=======================================================
            // LABEL ================================================
            IF COPY(NAME,1,2) = 'QD' THEN
               BEGIN
               S := FMREP1.Components[N];
               WITH S AS TQRDBTEXT DO
               BEGIN
               NAME      := T.ReadString(NAME,'NAME'     ,Name);
               PARENT  := QRBand_TITLE;
               IF T.ReadString (NAME,'PARENT' ,PARENT.Name) = 'QRBand_DETAIL' THEN PARENT  := QRBand_DETAIL;
               DATAFIELD := T.ReadString(NAME,'DATAFIELD',DATAFIELD);

               FONT.Size  := T.ReadInteger(NAME,'FONTSIZE'   ,FONT.SIZE);

               LEFT   := T.ReadInteger(NAME,'LEFT'   ,LEFT);
               TOP    := T.ReadInteger(NAME,'TOP'    ,TOP);
               HEIGHT := T.ReadInteger(NAME,'HEIGHT' ,HEIGHT);
               WIDTH  := T.ReadInteger(NAME,'WIDTH'  ,WIDTH);
               END;
               END;
            //=======================================================
            // LABEL ================================================
            IF COPY(NAME,1,2) = 'SP' THEN
               BEGIN
               S := FMREP1.Components[N];
               WITH S AS TQRSHAPE DO
               BEGIN
               NAME  := T.ReadString(NAME,'NAME'   ,Name);
               PARENT  := QRBand_TITLE;
               IF T.ReadString (NAME,'PARENT' ,PARENT.Name) = 'QRBand_DETAIL' THEN PARENT  := QRBand_DETAIL;

               LEFT   := T.ReadInteger(NAME,'LEFT'   ,LEFT);
               TOP    := T.ReadInteger(NAME,'TOP'    ,TOP);
               HEIGHT := T.ReadInteger(NAME,'HEIGHT' ,HEIGHT);
               WIDTH  := T.ReadInteger(NAME,'WIDTH'  ,WIDTH);

//               T_STR  := T.ReadString(NAME,'SHAPE'  ,VARTOSTR(SHAPE));
               IF T_STR ='0' THEN SHAPE := qrsRectangle;
               IF T_STR ='1' THEN SHAPE := qrsCircle;
               IF T_STR ='2' THEN SHAPE := qrsVertLine;
               IF T_STR ='3' THEN SHAPE := qrsHorLine;
               IF T_STR ='4' THEN SHAPE := qrsTopAndBottom;
               IF T_STR ='5' THEN SHAPE := qrsRightAndLeft;
               END;
               END;
            //=======================================================
            END;

       END;



FINALLY
   T.Free;
END;


IS_CHANGED(FALSE);   //更改过
END;

PROCEDURE TFMREP1.FREE_ALL_LB;
VAR N : INTEGER;
    FREE_OK : BOOLEAN;
BEGIN
IS_CHANGED(TRUE);   //更改过

FREE_OK := FALSE;
WHILE FREE_OK = FALSE DO
   BEGIN

   FOR N := 0 TO FMREP1.ComponentCount-1 DO
       WITH FMREP1.Components[N] DO
            IF ((COPY(NAME,1,2) = 'LB') OR (COPY(NAME,1,2) = 'QD') )AND
            (FMREP1.FindComponent(NAME) <> NIL ) THEN
            BEGIN
            FREE;          //FREE 后, ComponentCount 会改变, 所以要重新来
            BREAK;
            END;

   //重新找, 是否还有LABEL对象
   FOR N := 0 TO FMREP1.ComponentCount-1 DO
      BEGIN
       WITH FMREP1.Components[N] DO
            IF ((COPY(NAME,1,2) = 'LB') OR (COPY(NAME,1,2) = 'QD') )AND
            (FMREP1.FindComponent(NAME) <> NIL ) THEN
            BEGIN
            FREE_OK := FALSE;
            BREAK;
            END ELSE
            BEGIN
            FREE_OK := TRUE;
            END;
      END;

   END;

END;






















procedure TFMREP1.VRITUAL_LBMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
IS_CHANGED(TRUE);   //更改过
   WITH SENDER AS TQRLBEDIT DO
      BEGIN
      ED_OBJ_NAME.TEXT     := NAME;
      ED_OBJ_CAPTION.TEXT  := CAPTION;
      ED_OBJ_FONTSIZE.Value:= FONT.Size;

      ED_OBJ_TOP.Value     := TOP;
      ED_OBJ_LEFT.Value    := LEFT;
      ED_OBJ_HEIGHT.Value  := HEIGHT;
      ED_OBJ_WIDTH.Value   := WIDTH;
      END;

//   FMLBDSL.PAGE_C.TabVisible := FALSE;
//   FMLBDSL.ShowModal;

end;

procedure TFMREP1.VRITUAL_QDMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
IS_CHANGED(TRUE);   //更改过
   WITH SENDER AS TQRQDEDIT DO
      BEGIN
      ED_OBJ_NAME.TEXT     := NAME;
      ED_OBJ_FIELD.Text    := DATAFIELD;

      ED_OBJ_FONTSIZE.Value:= FONT.Size;
      

      ED_OBJ_TOP.Value     := TOP;
      ED_OBJ_LEFT.Value    := LEFT;
      ED_OBJ_HEIGHT.Value  := HEIGHT;
      ED_OBJ_WIDTH.Value   := WIDTH;
      END;
//   FMLBDSL.PAGE_C.TabVisible := FALSE;
//   FMLBDSL.ShowModal;
end;

procedure TFMREP1.VRITUAL_SPMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
IS_CHANGED(TRUE);   //更改过
   WITH SENDER AS TQRSPEDIT DO
      BEGIN
      ED_OBJ_NAME.TEXT     := NAME;

      ED_OBJ_TOP.Value     := TOP;
      ED_OBJ_LEFT.Value    := LEFT;
      ED_OBJ_HEIGHT.Value  := HEIGHT;
      ED_OBJ_WIDTH.Value   := WIDTH;

//      ED_OBJ_SHAPE.ItemIndex := STRTOINTDEF(VARTOSTR(SHAPE),0);
      END;
//   FMLBDSL.PAGE_C.TabVisible := FALSE;
//   FMLBDSL.ShowModal;
end;



























//=  SYS  ===========================================================================
procedure TFMREP1.FormCreate(Sender: TObject);
BEGIN
//  LBTITLE.Caption     := ;
  XLB_USER_RBPST.Caption := _USER_CORP_RBPST ;
  XLB_USER_NAME .Caption := _USER_CORP_NAME  ;
  XLB_USER_NO   .Caption := _USER_CORP_NO    ;
  XLB_USER_TEL  .Caption := _USER_CORP_TEL   ;
  XLB_USER_FAX  .Caption := _USER_CORP_FAX   ;
  XLB_USER_ADDR .Caption := _USER_CORP_ADDR  ;

  XLB_DAT1.Caption := '日期：' + EDATE_TO_CDATE(DATETOSTR(DATE));





//取出 TALBLE
ED_PAGE_TABLE.Items.Clear;
Session.GetTableNames('MAIN', '', FALSE,false,ED_PAGE_TABLE.Items);







//IF Application.FindComponent('FMREP1L')=nil then Application.CreateForm(TFMREP1L,FMREP1L );

LB_CNT := 1;
QD_CNT := 1;
QR_NAME := ExtractFilePath(Application.EXEName)+'/ini/QREP1.ini';
QR_TABLE_LIST := 'BGDS';  // 列出的TABLE

IF FileExists(QR_NAME) = FALSE THEN FILE_CREATE(QR_NAME);

//取出 TALBLE
//FMREP1.D_ED7.Items.Clear;
//Session.GetTableNames('MAIN', '', FALSE,false,FMREP1.D_ED8.Items);

IS_CHANGED(FALSE);   //更改过


//P_EDH.VALUE := QRLB.Height / 80;
//P_EDW.VALUE := QRLB.WIDTH  / 80;
CB_COL  .ItemIndex := 0;
end;


procedure TFMREP1.FormShow(Sender: TObject);
begin


IF ED_PAGE_TABLE.TEXT <> '' THEN
   BEGIN
   ED_OBJ_FIELD.Items.Clear;
   IF ED_PAGE_TABLE.TEXT <>'' THEN ED_OBJ_FIELD.Items.TEXT := DB_QUERY_FIELDLIST(ED_PAGE_TABLE.TEXT);

   QUERY.SQL.CLEAR;
   QUERY.SQL.ADD('SELECT * FROM ' + ED_PAGE_TABLE.TEXT );
   QUERY.CLOSE;
   QUERY.OPEN;
   END ELSE BEGIN
   END;


PAGE_A.SHOW;
LOAD_INI;
end;


procedure TFMREP1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
IF QR_CHANGED = TRUE THEN //更改过
   Case MessageDlg('是否确定存储已更改的标签资料?',mtConfirmation,[mbYes,mbNo],0) of
        mrYES :SAVE_INI;end;

//FMREP1L.Release;
FMREP1.Release;
end;






















































procedure TFMREP1.BTNQUTClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMREP1.BTN_QRLBClick(Sender: TObject);
begin
CREATE_LB;
end;

procedure TFMREP1.BTN_QRQDClick(Sender: TObject);
begin
CREATE_QD;
end;

procedure TFMREP1.BTNCLRClick(Sender: TObject);
begin
FREE_ALL_LB;
end;

procedure TFMREP1.BTN_QRSPVClick(Sender: TObject);
begin
CREATE_SP('qrsVertLine');
end;
procedure TFMREP1.BTN_QRSPHClick(Sender: TObject);
begin
CREATE_SP('qrsHorLine');
end;
procedure TFMREP1.BTN_QRSPRClick(Sender: TObject);
begin
CREATE_SP('qrsRectangle');
end;

procedure TFMREP1.BTNSAVClick(Sender: TObject);
begin
IS_CHANGED(FALSE);   //更改过
SAVE_INI;

end;

procedure TFMREP1.DsnSwitch1Click(Sender: TObject);
begin
IS_CHANGED(TRUE);   //更改过
end;

procedure TFMREP1.BTNPRNClick(Sender: TObject);
begin
//QuickRep.Print;
QuickRep.Preview;
end;

procedure TFMREP1.ED_PAGE_TABLEChange(Sender: TObject);
begin
ED_OBJ_FIELD.Items.Clear;
IF ED_PAGE_TABLE.TEXT <>'' THEN ED_OBJ_FIELD.Items.TEXT := DB_QUERY_FIELDLIST(ED_PAGE_TABLE.TEXT);

end;



procedure TFMREP1.BTN_OBJ_APPLYClick(Sender: TObject);
VAR S : TOBJECT;  //暂存对象
    N , ID : INTEGER;
begin
   IF FMREP1.FindComponent('S') = NIL THEN S := TOBJECT.Create;

   FOR N := 0 TO FMREP1.ComponentCount-1 DO
       BEGIN
       WITH FMREP1.Components[N] DO
            BEGIN
            // LABEL ================================================
            IF (UPPERCASE(COPY(NAME,1,2)) = 'LB') AND
               (NAME = ED_OBJ_NAME.Text )         THEN
               BEGIN
               S := FMREP1.Components[N];
               WITH S AS TQRLBEDIT DO
                 BEGIN
                 CAPTION := ED_OBJ_CAPTION.Text  ;
                 FONT.Size := ED_OBJ_FONTSIZE.Value;

                 TOP     := STRTOINTDEF(ED_OBJ_TOP    .TEXT, 1) ;
                 LEFT    := STRTOINTDEF(ED_OBJ_LEFT   .TEXT, 1) ;
                 HEIGHT  := STRTOINTDEF(ED_OBJ_HEIGHT .TEXT, 1) ;
                 WIDTH   := STRTOINTDEF(ED_OBJ_WIDTH  .TEXT, 1) ;

                 Refresh;
                 END;
               END;
            // ======================================================

            // LABEL ================================================
            IF (UPPERCASE(COPY(NAME,1,2)) = 'QD') AND
               (NAME = ED_OBJ_NAME.Text )         THEN
               BEGIN
               S := FMREP1.Components[N];
               WITH S AS TQRQDEDIT DO
                 BEGIN
                 FONT.Size := ED_OBJ_FONTSIZE.Value;

                 TOP     := STRTOINTDEF(ED_OBJ_TOP    .TEXT, 1) ;
                 LEFT    := STRTOINTDEF(ED_OBJ_LEFT   .TEXT, 1) ;
                 HEIGHT  := STRTOINTDEF(ED_OBJ_HEIGHT .TEXT, 1) ;
                 WIDTH   := STRTOINTDEF(ED_OBJ_WIDTH  .TEXT, 1) ;

                 DATAFIELD  := ED_OBJ_FIELD.TEXT ;
                 Refresh;
                 END;
               END;
            // ======================================================

            // LABEL ================================================
            IF (UPPERCASE(COPY(NAME,1,2)) = 'SP') AND
               (NAME = ED_OBJ_NAME.Text )         THEN
               BEGIN
               S := FMREP1.Components[N];
               WITH S AS TQRSPEDIT DO
                 BEGIN
                 TOP     := STRTOINTDEF(ED_OBJ_TOP    .TEXT, 1) ;
                 LEFT    := STRTOINTDEF(ED_OBJ_LEFT   .TEXT, 1) ;
                 HEIGHT  := STRTOINTDEF(ED_OBJ_HEIGHT .TEXT, 1) ;
                 WIDTH   := STRTOINTDEF(ED_OBJ_WIDTH  .TEXT, 1) ;

                 Refresh;
                 END;
               END;
            // ======================================================






            END;
       END;
end;



















procedure TFMREP1.BTN_PAGE_APPLYClick(Sender: TObject);
begin
QuickRep.Page.Width        := ED_PAGE_WIDTH.Value;
QuickRep.Page.Length       := ED_PAGE_LENGTH.Value;
QuickRep.Page.TopMargin    := ED_PAGE_TOPMARGIN.Value;
QuickRep.Page.BottomMargin := ED_PAGE_BOTTOMMARGIN.Value;
QuickRep.Page.LeftMargin   := ED_PAGE_LEFTMARGIN.Value;
QuickRep.Page.RightMargin  := ED_PAGE_RIGHTMARGIN.Value;

XLB_TITLE.Caption := ED_PAGE_TITLE.Text;

end;

procedure TFMREP1.ED_OBJ_NAMEChange(Sender: TObject);
begin
IS_CHANGED(TRUE);   //更改过
end;

end.
