unit UNLBDS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, QuickRpt, Spin, Buttons, Thubar39, ToolWin, ComCtrls,
  DsnUnit, DsnSubMl, DsnSubGr, DsnSelect, DsnSub8, DBTables, FlEdit;

type

  TLBEdit = class(TLABEL)
  private
  protected
  public
  _FONT_STYLE  : INTEGER; //��������
  _FONT_ZOOM_W : INTEGER; //�������ű���
  _FONT_ZOOM_H : INTEGER; //�������ű���
  _SUBTEXT     : INTEGER; //������
  _ROTAT       : INTEGER; //�Ƕ�

    _CAPTION    : STRING; //1
    _TABLE_NAME : STRING; //2
    _FIELD_NAME : STRING; //2
    _SYSLST     : STRING; //3
  published
  end;

type
  TBCEdit = class(THUBarcode39)
  private
  protected
  public
  _CODE_SIZE  : STRING;
  _CODE_STYLE : INTEGER;
  _CODE_ZOOM_W : INTEGER; //�������ű���
  _CODE_ZOOM_H : INTEGER; //�������ű���
  _CODE_HEIGHT : INTEGER; //���
  _CODE_WIDTH  : INTEGER; //���
  _ROTAT       : INTEGER; //�Ƕ�
  _HUMAN       : INTEGER; //�������µ�����

    _CAPTION    : STRING; //1
    _TABLE_NAME : STRING; //2
    _FIELD_NAME : STRING; //2
    _SYSLST     : STRING; //3
  published
  end;

type
  TFMLBDS = class(TForm)
    ToolBar1: TToolBar;
    BTNTXT: TSpeedButton;
    BTNBCD: TSpeedButton;
    BTNLOD: TSpeedButton;
    BTNSAV: TSpeedButton;
    BTNCLR: TSpeedButton;
    BTNPRN: TSpeedButton;
    BTNCLV: TSpeedButton;
    BTNQUT: TSpeedButton;
    DsnSwitch1: TDsnSwitch;
    Dsn8Register1: TDsn8Register;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    P_EDH: TFloatEdit;
    P_EDW: TFloatEdit;
    VRITUAL_BC: THUBarcode39;
    X_BC: THUBarcode39;
    QR: TQuickRep;
    VRITUAL_LB: TLabel;
    QRLB: TDsnStage;
    procedure SAVClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TXTClick(Sender: TObject);
    procedure LODClick(Sender: TObject);
    procedure CLRClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QUTClick(Sender: TObject);
    procedure PRNClick(Sender: TObject);
    procedure BCDClick(Sender: TObject);
    procedure BTNCLVClick(Sender: TObject);
    procedure DsnSwitch1Click(Sender: TObject);
    procedure VRITUAL_LBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VRITUAL_BCMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure P_EDHChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imRulerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    //�ƶ�ͼ
//    Dragging: Boolean;          { Drag operation in progress flag }
//    XOffset, YOffset: Integer;  { Offsets from shape upper left }
//    FocusRect: TRect;           { Dotted outline while dragging }
//    Temp_Height, Temp_Left, Temp_Top : Integer;
    //========================================================================

  public
    { Public declarations }
    QR_CHANGED : BOOLEAN; //���Ĺ�
    QR_NAME : STRING;  //�洢�ļ���

    QR_KEY_FIELD : STRING;  // KEY �ֶ�
    QR_KEY_VALUE : STRING;  // KEY ��ӳֵ

    QR_TABLE_LIST : STRING;  // �г���TABLE

    LB_CNT : INTEGER; //Ŀǰ���������
    BC_CNT : INTEGER; //Ŀǰ���������
    QR_LB  : ARRAY [1..100] OF TLBEDIT;
    QR_BC  : ARRAY [1..100] OF TBCEDIT;

    FUNCTION  CREATE_LB :BOOLEAN;       //���� LABEL
    FUNCTION  CREATE_BC :BOOLEAN;       //���� BARCODE

    FUNCTION  FIND_MAX_LBCNT :INTEGER;  //�ҳ� LABEL   �������
    FUNCTION  FIND_MAX_BCCNT :INTEGER;  //�ҳ� BARCODE �������

//==========================================
    PROCEDURE SAVE_INI;
    PROCEDURE LOAD_INI;
    PROCEDURE FREE_ALL_LB;
    FUNCTION  PRINT_ALL_LB(LB_CNT:INTEGER):BOOLEAN;

  end;

var
  FMLBDS: TFMLBDS;

implementation

uses inifiles, SYSINI, UN_UTL, DB_UTL, URCLEVER, URARGOX,
     UNLBDSL,
     MAIND, MAIN;

{$R *.DFM}

FUNCTION  TFMLBDS.CREATE_LB :BOOLEAN;
BEGIN
LB_CNT := FIND_MAX_LBCNT;  //�ҳ� LABEL   �������

//��������
QR_LB[LB_CNT] := TLBEDIT.Create(FMLBDS);
QR_LB[LB_CNT].Parent := QRLB;
QR_LB[LB_CNT].Name := 'LB'+INTTOSTR(LB_CNT);
QR_LB[LB_CNT].COLOR:= $00FDC580;
QR_LB[LB_CNT].Left := 10;
QR_LB[LB_CNT].TOP  := 10;
QR_LB[LB_CNT].Caption := 'LB'+INTTOSTR(LB_CNT);
QR_LB[LB_CNT].Cursor :=  crSizeAll;
QR_LB[LB_CNT].FONT.Size := 16;
QR_LB[LB_CNT].AutoSize  := TRUE;
QR_LB[LB_CNT].OnMouseDown := VRITUAL_LBMouseDown;

QR_LB[LB_CNT]._FONT_STYLE := 1; //��������
QR_LB[LB_CNT]._FONT_ZOOM_W:= 1; //�������ű���
QR_LB[LB_CNT]._FONT_ZOOM_H:= 1; //�������ű���
QR_LB[LB_CNT]._SUBTEXT    := -1; //������
QR_LB[LB_CNT]._ROTAT      := 0; //�Ƕ�
END;

FUNCTION  TFMLBDS.CREATE_BC :BOOLEAN;
VAR N : INTEGER;
BEGIN
BC_CNT := FIND_MAX_BCCNT;  //�ҳ� BARCODE   �������

//��������
QR_BC[BC_CNT] := TBCEDIT.Create(FMLBDS);
QR_BC[BC_CNT].Parent := QRLB;
QR_BC[BC_CNT].Name := 'BC'+INTTOSTR(BC_CNT);
QR_BC[BC_CNT].Left := 10;
QR_BC[BC_CNT].TOP  := 10;
QR_BC[BC_CNT].BARSTR := 'BC'+INTTOSTR(BC_CNT);
QR_BC[BC_CNT].Cursor :=  crSizeAll;
QR_BC[BC_CNT].FONT.Size := 16;
QR_BC[BC_CNT].AutoSize  := TRUE;
QR_BC[BC_CNT].OnMouseDown := VRITUAL_BCMouseDown;

QR_BC[BC_CNT]._CODE_SIZE   := '';
QR_BC[BC_CNT]._CODE_STYLE  := 1;
QR_BC[BC_CNT]._CODE_ZOOM_W := 1; //�������ű���
QR_BC[BC_CNT]._CODE_ZOOM_H := 1; //�������ű���
QR_BC[BC_CNT]._CODE_HEIGHT := 32; //���
QR_BC[BC_CNT]._CODE_WIDTH  := 1; //���
QR_BC[BC_CNT]._ROTAT       := 0; //�Ƕ�
QR_BC[BC_CNT]._HUMAN       := 0; //�������µ�����
END;

FUNCTION  TFMLBDS.FIND_MAX_LBCNT :INTEGER;  //�ҳ� LABEL   �������
VAR N ,R : INTEGER;
BEGIN
R := 1;
//�ҳ�Ŀǰ���һ��,   ���ֵ
FOR N := 0 TO FMLBDS.ComponentCount-1 DO
    BEGIN
    WITH FMLBDS.Components[N] DO
    IF (COPY(NAME,1,2) = 'LB') AND
       (R <= STRTOINTDEF(COPY(NAME,3,LENGTH(NAME)-2),1))  THEN
        R := STRTOINTDEF(COPY(NAME,3,LENGTH(NAME)-2),1) + 1;
    END;
RESULT := R;
END;
FUNCTION  TFMLBDS.FIND_MAX_BCCNT :INTEGER;  //�ҳ� BARCODE �������
VAR N ,R : INTEGER;
BEGIN
R := 1;
//�ҳ�Ŀǰ���һ��,   ���ֵ
FOR N := 0 TO FMLBDS.ComponentCount-1 DO
    BEGIN
    WITH FMLBDS.Components[N] DO
    IF (COPY(NAME,1,2) = 'BC') AND
       (R <= STRTOINTDEF(COPY(NAME,3,LENGTH(NAME)-2),1))  THEN
        R := STRTOINTDEF(COPY(NAME,3,LENGTH(NAME)-2),1) + 1;
    END;
RESULT := R;
END;


//=  SYS  ===========================================================================
procedure TFMLBDS.FormCreate(Sender: TObject);
BEGIN

IF Application.FindComponent('FMLBDSL')=nil then Application.CreateForm(TFMLBDSL,FMLBDSL );

LB_CNT := 1;
BC_CNT := 1;
QR_NAME := ExtractFilePath(Application.EXEName)+'QR.ini';
QR_TABLE_LIST := 'BGDS';  // �г���TABLE

IF FileExists(QR_NAME) = FALSE THEN FILE_CREATE(QR_NAME);

//ȡ�� TALBLE
//FMLBDS.D_ED7.Items.Clear;
//Session.GetTableNames('MAIN', '', FALSE,false,FMLBDS.D_ED8.Items);

QR_CHANGED := FALSE; //���Ĺ�

P_EDH.VALUE := QRLB.Height / 80;
P_EDW.VALUE := QRLB.WIDTH  / 80;
end;

procedure TFMLBDS.FormShow(Sender: TObject);
begin
//QR_NAME := ExtractFilePath(Application.EXEName)+'QR.ini';

end;

procedure TFMLBDS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
IF QR_CHANGED = TRUE THEN //���Ĺ�
   Case MessageDlg('�Ƿ�ȷ���洢�Ѹ��ĵı�ǩ����?',mtConfirmation,[mbYes,mbNo],0) of
        mrYES :SAVE_INI;end;

FMLBDSL.Release;
FMLBDS.Release;
end;


// FUNCTION ========================================================================
PROCEDURE TFMLBDS.SAVE_INI;
var T : Tinifile;    N : INTEGER;    S : TOBJECT;  //�ݴ����
BEGIN

TRY
   IF FMLBDS.FindComponent('S') = NIL THEN S := TOBJECT.Create;
   T := Tinifile.Create(QR_NAME);


   //ɾ����������
   FOR N := 0 TO 100 DO
       BEGIN
       T.EraseSection('QRLB');
       T.EraseSection('LB'+INTTOSTR(N));
       T.EraseSection('BC'+INTTOSTR(N));
       END;

   //�����ǩ��С
   T.WriteInteger('QRLB','HEIGHT' ,QRLB.HEIGHT);
   T.WriteInteger('QRLB','WIDTH'  ,QRLB.WIDTH);

   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
       BEGIN
       WITH FMLBDS.Components[N] DO
            BEGIN

            // LABEL ================================================
            IF COPY(NAME,1,2) = 'LB' THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TLBEDIT DO
               BEGIN
               T.WriteString (NAME,'NAME'   ,Name);
               T.WriteString (NAME,'CAPTION',CAPTION);

               T.WriteInteger(NAME,'LEFT'   ,LEFT);
               T.WriteInteger(NAME,'TOP'    ,TOP);
               T.WriteInteger(NAME,'HEIGHT' ,HEIGHT);
               T.WriteInteger(NAME,'WIDTH'  ,WIDTH);
               T.WriteINTEGER(NAME,'_FONT_STYLE' ,_FONT_STYLE);  //��������
               T.WriteINTEGER(NAME,'_FONT_ZOOM_W',_FONT_ZOOM_W); //�������ű���
               T.WriteINTEGER(NAME,'_FONT_ZOOM_H',_FONT_ZOOM_H); //�������ű���
               T.WriteINTEGER(NAME,'SUBTEXT',_SUBTEXT);
               T.WriteINTEGER(NAME,'ROTAT'  ,_ROTAT);

               T.WriteInteger(NAME,'FONT'   ,_FONT_STYLE);
               T.WriteString (NAME,'TABLE'  ,_TABLE_NAME);
               T.WriteString (NAME,'FIELD'  ,_FIELD_NAME);
               T.WriteString (NAME,'SYSLST' ,_SYSLST);
               END;
               END;
            //=======================================================

            // LABEL ================================================
            IF COPY(NAME,1,2) = 'BC' THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TBCEDIT DO
               BEGIN
               T.WriteString (NAME,'NAME'   ,Name);
               T.WriteString (NAME,'BARSTR' ,BARSTR);

               T.WriteInteger(NAME,'LEFT'   ,LEFT);
               T.WriteInteger(NAME,'TOP'    ,TOP);
               T.WriteInteger(NAME,'HEIGHT' ,_CODE_HEIGHT);
               T.WriteInteger(NAME,'WIDTH'  ,_CODE_WIDTH);

               T.WriteString (NAME,'TABLE'  ,_TABLE_NAME);
               T.WriteString (NAME,'FIELD'  ,_FIELD_NAME);
               T.WriteString (NAME,'SYSLST' ,_SYSLST);

               T.WriteInteger(NAME,'BC_HEIGHT'   ,_CODE_HEIGHT);
               T.WriteInteger(NAME,'BC_ROTAT'    ,_ROTAT);
               T.WriteInteger(NAME,'BC_WIDE'     ,_CODE_WIDTH);
               T.WriteInteger(NAME,'BC_BARKIND'  ,_CODE_STYLE);
               T.WriteINTEGER(NAME,'BC_ROTAT'    ,_ROTAT);
               T.WriteINTEGER(NAME,'BC_HUMAN'    ,_HUMAN);

               END;
               END;
            //=======================================================

            // EDIT ================================================
            IF COPY(NAME,1,2) = 'ED' THEN
               BEGIN
               T.WriteString(NAME,'NAME',NAME);
               END;
            //=======================================================

            END;

       END;

FINALLY
   T.Free;
END;




END;

PROCEDURE TFMLBDS.LOAD_INI;
var T : Tinifile;    N : INTEGER;    S : TOBJECT;  //�ݴ����
BEGIN
FREE_ALL_LB;  //�����ԭ�� LABEL

TRY

   IF FMLBDS.FindComponent('S') = NIL THEN S := TOBJECT.Create;
   T := Tinifile.Create(QR_NAME);

   FOR N := 0 TO 100 DO
       BEGIN
       IF T.SectionExists('LB'+INTTOSTR(N)) = TRUE THEN CREATE_LB;
       IF T.SectionExists('BC'+INTTOSTR(N)) = TRUE THEN CREATE_BC;
       END;

   // LOAD ��ǩ��С
   QRLB.HEIGHT := T.ReadInteger('QRLB','HEIGHT' ,QRLB.HEIGHT);
   QRLB.WIDTH  := T.ReadInteger('QRLB','WIDTH'  ,QRLB.WIDTH);
   P_EDH.VALUE := QRLB.Height / 80;
   P_EDW.VALUE := QRLB.WIDTH  / 80;

   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
       BEGIN
       WITH FMLBDS.Components[N] DO
            BEGIN

            // LABEL ================================================
            IF COPY(NAME,1,2) = 'LB' THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TLBEDIT DO
               BEGIN

               NAME    := T.ReadString (NAME,'NAME'   ,Name);
               CAPTION := T.ReadString (NAME,'CAPTION',CAPTION);
               LEFT    := T.ReadInteger(NAME,'LEFT'   ,LEFT);
               TOP     := T.ReadInteger(NAME,'TOP'    ,TOP);
               _FONT_STYLE := T.ReadINTEGER(NAME,'_FONT_STYLE' ,_FONT_STYLE);  //��������
               _FONT_ZOOM_W:= T.ReadINTEGER(NAME,'_FONT_ZOOM_W',_FONT_ZOOM_W); //�������ű���
               _FONT_ZOOM_H:= T.ReadINTEGER(NAME,'_FONT_ZOOM_H',_FONT_ZOOM_H); //�������ű���
               _SUBTEXT    := T.ReadINTEGER(NAME,'SUBTEXT',-1);
               _ROTAT      := T.ReadINTEGER(NAME,'ROTAT'  , 0);

               _FONT_STYLE := T.ReadInteger(NAME,'FONT'    ,16);
               _TABLE_NAME := T.ReadSTRING (NAME,'TABLE'   ,'');
               _FIELD_NAME := T.ReadSTRING (NAME,'FIELD'   ,'');
               _SYSLST     := T.ReadSTRING (NAME,'SYSLST'  ,'');

               FONT.Size := 8 * STRTOINTDEF(FMLBDSL.ED_LB_FONT_STYLE.Items.Strings[_FONT_STYLE],2);
               IF _SYS_CFG_BARPRN = 0 THEN
                  IF _FONT_STYLE = 9 THEN FONT.Size := 16;  // ��������
               IF _SYS_CFG_BARPRN = 1 THEN
                  IF _FONT_STYLE = 6 THEN FONT.Size := 16;  // ��������
               END;
               END;
            //=======================================================
            // LABEL ================================================
            IF COPY(NAME,1,2) = 'BC' THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TBCEDIT DO
               BEGIN
               NAME  := T.ReadString(NAME,'NAME'   ,Name);
               BARSTR:= T.ReadString(NAME,'BARSTR' ,BARSTR);

               LEFT := T.ReadInteger(NAME,'LEFT'   ,LEFT);
               TOP := T.ReadInteger(NAME,'TOP'    ,TOP);


               _TABLE_NAME := T.ReadSTRING (NAME,'TABLE'   ,'');
               _FIELD_NAME := T.ReadSTRING (NAME,'FIELD'   ,'');
               _SYSLST     := T.ReadSTRING (NAME,'SYSLST'  ,'');

               _CODE_HEIGHT := T.ReadInteger(NAME,'BC_HEIGHT' ,36);
               _ROTAT       := T.ReadInteger(NAME,'BC_ROTAT'  ,0);
               _HUMAN       := T.ReadInteger(NAME,'BC_HUMAN'  ,0);
               _CODE_WIDTH  := T.ReadInteger(NAME,'BC_WIDE'   ,4);
               _CODE_STYLE  := T.ReadInteger(NAME,'BC_BARKIND',0);

               END;
               END;
            //=======================================================
            END;

       END;



FINALLY
   T.Free;
END;


//����CLEVER
URCLEVER.CLEVER_HEIGHT := FLOATTOSTR(FMLBDS.QRLB.Height / 80);
URCLEVER.CLEVER_WIDTH  := FLOATTOSTR(FMLBDS.QRLB.WIDTH  / 80);

//����ARGOX
FRARGOX.ED_LB_H.Text := FLOATTOSTR(FMLBDS.QRLB.Height );
FRARGOX.ED_LB_W.Text := FLOATTOSTR(FMLBDS.QRLB.WIDTH  );
//FRARGOX.ED_LB_H.Value := FMLBDS.QRLB.Height ;
//FRARGOX.ED_LB_W.Value := FMLBDS.QRLB.WIDTH  ;

QR_CHANGED := FALSE; //���Ĺ�
END;

PROCEDURE TFMLBDS.FREE_ALL_LB;
VAR N : INTEGER;
    FREE_OK : BOOLEAN;
BEGIN
QR_CHANGED := TRUE; //���Ĺ�

FREE_OK := FALSE;
WHILE FREE_OK = FALSE DO
   BEGIN

   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
       WITH FMLBDS.Components[N] DO
            IF ((COPY(NAME,1,2) = 'LB') OR (COPY(NAME,1,2) = 'BC') )AND
            (FMLBDS.FindComponent(NAME) <> NIL ) THEN
            BEGIN
            FREE;          //FREE ��, ComponentCount ��ı�, ����Ҫ������
            BREAK;
            END;

   //������, �Ƿ���LABEL����
   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
      BEGIN
       WITH FMLBDS.Components[N] DO
            IF ((COPY(NAME,1,2) = 'LB') OR (COPY(NAME,1,2) = 'BC') )AND
            (FMLBDS.FindComponent(NAME) <> NIL ) THEN
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

FUNCTION  TFMLBDS.PRINT_ALL_LB(LB_CNT:INTEGER):BOOLEAN;
VAR S : TOBJECT;  //�ݴ����
    N : INTEGER;
    T_TEXT : STRING;
    P_CODE, P_HUMAN : STRING;
BEGIN

TRY
   IF FMLBDS.FindComponent('S') = NIL THEN S := TOBJECT.Create;

//���������ӡ-------------------------------------------
IF _SYS_CFG_BARPRN = 0 THEN   CLEVER_PRINT_TITLE;
IF _SYS_CFG_BARPRN = 1 THEN   FRARGOX.PRINT_TITLE;
//-------------------------------------------

   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
       BEGIN
       WITH FMLBDS.Components[N] DO
            BEGIN
            T_TEXT := '';

            // LABEL ================================================
            IF UPPERCASE(COPY(NAME,1,2)) = 'LB' THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TLBEDIT DO
                    BEGIN
// ED_RIUNP.Caption := UNSETREAD('BGDSBGUNP' ,FieldByName('RIUNP').AsString);
                    IF (TRIM(QR_KEY_FIELD)<>'')AND(TRIM(QR_KEY_VALUE)<>'') THEN
                        IF _TABLE_NAME <> '' THEN T_TEXT := DB_QUERY_FIND_VALUE(_TABLE_NAME,QR_KEY_FIELD,QR_KEY_VALUE,_FIELD_NAME);
                    IF _TABLE_NAME =  '' THEN T_TEXT := CAPTION;

                    //���������ӡ-------------------------------------------
                    IF _SYS_CFG_BARPRN = 0 THEN CLEVER_PRINT_TEXT2(LEFT,(TOP)*1,FMLBDSL.ED_LB_FONT_STYLE.Items.Strings[_FONT_STYLE],_ROTAT,_FONT_ZOOM_H,_FONT_ZOOM_W,T_TEXT ,_SUBTEXT);
                    IF _SYS_CFG_BARPRN = 1 THEN FRARGOX.PRINT_TEXT2(LEFT,(TOP)*1,FMLBDSL.ED_LB_FONT_STYLE.Items.Strings[_FONT_STYLE],_FONT_ZOOM_H,_FONT_ZOOM_W,'N',T_TEXT ,_SUBTEXT);
                    //-------------------------------------------
                    END;
               END;
            //=======================================================

            // BARCODE ================================================
            IF UPPERCASE(COPY(NAME,1,2)) = 'BC' THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TBCEDIT DO
                    BEGIN
                    IF (TRIM(QR_KEY_FIELD)<>'')AND(TRIM(QR_KEY_VALUE)<>'') THEN
                       IF _TABLE_NAME <> '' THEN T_TEXT := DB_QUERY_FIND_VALUE(_TABLE_NAME,QR_KEY_FIELD,QR_KEY_VALUE,_FIELD_NAME);
                    IF _TABLE_NAME =  '' THEN T_TEXT := BARSTR;

                    //���������ӡ-------------------------------------------
                    IF _SYS_CFG_BARPRN=0 THEN
                       BEGIN
                       CLEVER_CODE := _CODE_STYLE;
                       CLEVER_PRINT_BARCODE(LEFT,(TOP)*1,_CODE_HEIGHT,_HUMAN,_ROTAT,_CODE_WIDTH,T_TEXT);
                       END;
                    IF _SYS_CFG_BARPRN=1 THEN
                       BEGIN
                       IF _HUMAN = 0 THEN P_HUMAN := 'N';
                       IF _HUMAN = 1 THEN P_HUMAN := 'B';
                       FRARGOX.PRINT_BARCODE(LEFT,(TOP)*1,_CODE_STYLE,_CODE_HEIGHT,P_HUMAN,T_TEXT);
                       END;
                    //-------------------------------------------
//                    IF _TABLE_NAME <> '' THEN FMCLEVER.PRINT_BARCODE(LEFT,(TOP)*1,_HEIGHT,0,_ROTAT,_WIDE,_FIELD_NAME);
//                    IF _TABLE_NAME =  '' THEN FMCLEVER.PRINT_BARCODE(LEFT,(TOP)*1,_HEIGHT,0,_ROTAT,_WIDE,BARSTR);
                    END;
               END;
            //=======================================================
            END;

       END;

//���������ӡ-------------------------------------------
IF _SYS_CFG_BARPRN=0 THEN CLEVER_PRINT_END(LB_CNT);
IF _SYS_CFG_BARPRN=1 THEN FRARGOX.PRINT_END(LB_CNT);
//-------------------------------------------

FINALLY
//   S.Free;
END;

END;
















procedure TFMLBDS.LODClick(Sender: TObject);
begin
LOAD_INI;
end;

procedure TFMLBDS.SAVClick(Sender: TObject);
BEGIN
QR_CHANGED := FALSE; //���Ĺ�
SAVE_INI;
end;


procedure TFMLBDS.TXTClick(Sender: TObject);
begin
CREATE_LB;
end;

procedure TFMLBDS.BCDClick(Sender: TObject);
begin
CREATE_BC;
//CREATE_BARCODE();
end;


procedure TFMLBDS.CLRClick(Sender: TObject);
begin
FREE_ALL_LB;
end;

procedure TFMLBDS.QUTClick(Sender: TObject);
begin
CLOSE;
end;


procedure TFMLBDS.PRNClick(Sender: TObject);
begin
PRINT_ALL_LB(1);
end;

procedure TFMLBDS.BTNCLVClick(Sender: TObject);
begin
IF _SYS_CFG_BARPRN=0 THEN FRCLEVER.ShowModal;
IF _SYS_CFG_BARPRN=1 THEN FRARGOX.ShowModal;
end;

procedure TFMLBDS.DsnSwitch1Click(Sender: TObject);
begin
QR_CHANGED := TRUE; //���Ĺ�
end;

procedure TFMLBDS.VRITUAL_LBMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
QR_CHANGED := TRUE; //���Ĺ�
IF Button = mbRight THEN
   BEGIN
   WITH SENDER AS TLBEDIT DO
       BEGIN
       FMLBDSL.ED_CAPTION.Text := CAPTION;
       FMLBDSL.ED_HEIGHT.Value := HEIGHT;
       FMLBDSL.ED_WIDTH .Value := WIDTH;
       FMLBDSL.ED_LEFT  .Value := LEFT;
       FMLBDSL.ED_TOP   .Value := TOP;

       FMLBDSL.ED_NAME.TEXT    := NAME;

//       FMLBDSL.ED_FONT_SIZE .VALUE := _FONT_SIZE   ;
       FMLBDSL.ED_LB_ZOOM_W  .VALUE := _FONT_ZOOM_W ; //�������ű���
       FMLBDSL.ED_LB_ZOOM_H  .VALUE := _FONT_ZOOM_H ; //�������ű���
       FMLBDSL.ED_LB_FONT_STYLE.ItemIndex := _FONT_STYLE; //�������ű���
       FMLBDSL.ED_LB_SUBTEXT .VALUE := _SUBTEXT;      //�������ű���
       FMLBDSL.ED_LB_ROTAT   .VALUE := _ROTAT;        //�������ű���
//  _FONT_STYLE : STRING;

 //  _PRINT_STYLE: INTEGER;  //��ӡ��ʽ
       FMLBDSL.ED_TABLE_NAME.Text := _TABLE_NAME;
       FMLBDSL.ED_FIELD_NAME.Text := _FIELD_NAME;
       FMLBDSL.ED_SYSLST    .Text := _SYSLST    ;

       END;

   FMLBDSL.PAGE_C.TabVisible := FALSE;
   FMLBDSL.ShowModal;
   END;

end;

procedure TFMLBDS.VRITUAL_BCMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

QR_CHANGED := TRUE; //���Ĺ�
IF Button = mbRight THEN
   BEGIN
   WITH SENDER AS TBCEDIT DO
       BEGIN
       FMLBDSL.ED_CAPTION.Text := BARSTR;
       FMLBDSL.ED_HEIGHT.Value := _CODE_HEIGHT;
       FMLBDSL.ED_WIDTH .Value := _CODE_WIDTH;
       FMLBDSL.ED_LEFT  .Value := LEFT;
       FMLBDSL.ED_TOP   .Value := TOP;

       FMLBDSL.ED_NAME.TEXT    := NAME;

       FMLBDSL.ED_TABLE_NAME.Text := _TABLE_NAME;
       FMLBDSL.ED_FIELD_NAME.Text := _FIELD_NAME;

       FMLBDSL.ED_BC_HEIGHT .Value := _CODE_HEIGHT;
       FMLBDSL.ED_BC_WIDTH  .Value := _CODE_WIDTH ;
       FMLBDSL.ED_BC_ROTAT  .Value := _ROTAT      ;
       FMLBDSL.ED_BC_HUMAN    .ItemIndex := _HUMAN      ;
       FMLBDSL.ED_BC_CODE_KIND.ItemIndex := _CODE_STYLE;

       END;
   FMLBDSL.PAGE_B.TabVisible := FALSE;
   FMLBDSL.ShowModal;
   END;
end;























procedure TFMLBDS.Label1Click(Sender: TObject);
begin
JMSGFORM('����ť˵��',
'�������֣��������ְ�ť�����ڱ�ǩ���Ͻǲ���һ���µ����ֶ���'+#13+
'���������룭���������밴ť�����ڱ�ǩ���Ͻǲ���һ���µ����������'+#13+
'����λ�ã��������˰�ť����������ҷ�������ƶ����ʵ�λ��'+#13+
'�������棭��Ŀǰ���ô��̣��Է����Ժ�ʹ��'+#13+
'�塡��������Ŀǰ����������Է����������'+#13+
'�򡡡�ӡ����Ŀǰ�Ű��ӡ������ȡ���ݿ����ϲ��ᱻ��ӡ����'+#13+
'ֽ�����ã��Թ���Ϊ��������ֽ�ź�ֽ�ŵļ��'+#13+
'����������ã�����Ŀǰ�����������״̬'+#13+
'�ᡡ�������뿪�˳���'+#13+
''+#13
,16);
end;

procedure TFMLBDS.Label2Click(Sender: TObject);
begin
JMSGFORM('��ǩ˵��',
'�˱�ǩֻ������һ���ǩ��ӡ���ϣ�'+#13+
'�ڱ�ǩ�ı߽羡����Ҫ���ö��󣬷������ֽ��ӡ��һ��һ�ޣ�'+#13+
'�������"����������"����˻��濴��ֻ��λ�ã������ǽ��'+#13+
'�ڶ����ϵ�������Ҽ������Գ��ֶ����е���ϸ����'+#13+
'�ڱ�ǩ�������������ּ����������Ƹ�Ϊһ����'+#13+
'��ǩԤ���ļ���·��Ϊ��'+#13+
'����WIN POS 2000 = C:\DELPHI\POS\QRBGDS.INI'+#13+
'����WIN TEMPLE   = C:\DELPHI\TEMPLE\QRBGDS.INI'+#13+
'��������·��������ϵͳ���ܡ�ϵͳ���á���ǩ·��������'+#13+
''+#13+
''+#13
,16);
end;

procedure TFMLBDS.Label3Click(Sender: TObject);
begin
JMSGFORM('��������',
'��ֽ��ӡ��һ��һ�ޣ�'+#13+
'�������������̫�����߽磬��ֽ�Ŵ�С���ò���ȷ'+#13+
'�޷���굥���Ҽ���������'+#13+
'��������"�޸�λ��"��ť������ʱ���Ͳ������Ҽ���������'+#13+
'�޷�΢������'+#13+
'���������ڶ����ϰ��Ҽ��������ã������ϱ߽����߽�'+#13+
'ÿ�δ�ӡ���ֺ��'+#13+
'������������������ΪEAN13ʱ�����������ݱ������13���������'+#13+
'�����������ж��󳬳�ֽ��̫�࣬ʹ��������޷�����'+#13+
''+#13+
''+#13+
''+#13
,16);
end;

procedure TFMLBDS.P_EDHChange(Sender: TObject);
begin
QR_CHANGED := TRUE; //���Ĺ�

IF (STRTOFLOATDEF(P_EDH.Text,-1) >= 0 ) AND
   (STRTOFLOATDEF(P_EDW.Text,-1) >= 0 ) THEN
   BEGIN
   FRCLEVER.ED_LB_H.Text := P_EDH.TEXT;
   FRCLEVER.ED_LB_W.Text := P_EDW.TEXT;


   QRLB.Height := ROUND(P_EDH.Value * 80);
   QRLB.WIDTH  := ROUND(P_EDW.Value * 80);
//   QRLB.Height := ROUND(STRTOFLOAT(FRCLEVER.ED_LB_H.Text) * 80);
//   QRLB.Width  := ROUND(STRTOFLOAT(FRCLEVER.ED_LB_W.Text) * 80);
   END;

end;













// ruler =======================================================================================
procedure TFMLBDS.imRulerMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
  var
       xx : integer;

  begin
  end;



end.
