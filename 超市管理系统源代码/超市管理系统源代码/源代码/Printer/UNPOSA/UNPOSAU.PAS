unit UNPOSAU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, DB, DBTables;

  PROCEDURE ED_INPUT_SETFOCUS;      // SET FOCUSE
  PROCEDURE VAR_INI;

  FUNCTION  FIND_BMEM(STR:STRING; KIND:INTEGER) :STRING;      //找会员
  FUNCTION  FIND_BGDS(STR:STRING; KIND:INTEGER) :STRING;      //找产品
  PROCEDURE CHECK_PRICE;  //检查价钱
  PROCEDURE GRID_ADD;
  FUNCTION  RE_INPUT(T_BGENO:STRING):BOOLEAN;  //重复刷



  PROCEDURE FINISHI;             //完成结帐
  PROCEDURE FINISHI_SAVE_POSA;   //完成结帐_ POSA 主表
  PROCEDURE FINISHI_SAVE_POSB;   //完成结帐_ POSB 明细
  PROCEDURE FINISHI_SAVE_POSG;   //完成结帐_ POSG 礼券
  PROCEDURE FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
  PROCEDURE FINISHI_PRN_IVOICE_CONTENT(T_BGENO,T_BGNAM,T_BGCNT,T_BGCOS,T_BGCOT:STRING);  //完成结帐_ 打印发票 项目
  PROCEDURE FINISHI_PRN_IVOICE_END;      //完成结帐_ 打印发票 结尾

  PROCEDURE FINISHI_DSP_TOTAL;   //完成结帐_ 价格显示
  PROCEDURE FINISHI_OPEN_CASHBOX;//开钱柜

  PROCEDURE INCREASE_INV_NO;//累加发票号码




  
implementation

uses INIFILES, FILECTRL, SYSINI, MAINU,

     UNPOSA,
     UNPOSAF1,
     UNPOSAGIFT,

     URINVOICE,
     URDSP,      // 客显
     UN_UTL, DB_UTL, FM_UTL;


PROCEDURE ED_INPUT_SETFOCUS;      // SET FOCUSE
BEGIN
  WITH FMPOSA DO
    BEGIN
    IF _TB_CLEAR_INPUT = TRUE THEN ED_INPUT.TEXT := '';
    ED_INPUT.SetFocus;
    ED_INPUT.SelectAll;
    END;
END;

PROCEDURE VAR_INI;
VAR I : INTEGER;
BEGIN
  WITH FMPOSA DO
    BEGIN
    // 前台变量 ==================================================================
    _TB_PAENO        := '';  //此次结帐编号
    _TB_PACIV        := '';  //统一编号
    _TB_FORCUS_ROW   := 0 ; //所在列数
    _TB_RUNLG_TMECNT := 0 ; //跑马灯计数器
    _TB_RUNLG_PICCNT := 0 ; //按 跑马灯 PIC计数
    _TB_BACK_MODE := FALSE; //退货模式

    IF _TB_DISC_ALL=FALSE THEN _TB_DISC_PERCENT := 1 ; //打折比例
    _TB_DISC_PRICE   := 0 ; //折扣金额
    _TB_LAST_PRICE   := 0 ;  //去尾数另外打印

    //信用卡资料======================================
    _TB_CARD_PACNO   := '';  //信用卡号
    _TB_CARD_PACDT   := '';  //信用卡到期日
    _TB_CARD_PACNA   := 0 ;  //信用卡人姓名
    _TB_CARD_PACKD   := '';  //信用卡类别

    //礼券资料======================================
    _TB_GIFT_PGCNO   := '';  //礼券号
    _TB_GIFT_PGCDT   := '';  //礼券到期日
    _TB_GIFT_PGCNA   := 0 ;  //礼券人姓名
    _TB_GIFT_PGCKD   := '';  //礼券类别
    _TB_GIFT_PRICE   := 0 ;  //礼券总金额

    _TB_TOTAL_REC   := 0 ;  //总卖出笔数
    _TB_TOTAL_PRICE := 0 ;  //总卖出金额
    _TB_TOTAL_NOPAY := 0 ;  //不用总卖出金额     (信用卡+礼券+折扣)

    //会员资料======================================
    _TB_BMEM_BMENO   := '';   //会员姓名
    _TB_BMEM_BMNAM   := '';   //会员姓名
    _TB_BMEM_BMLVE   := 0 ;   //会员等级
    _TB_BMEM_BMBYR   := 0 ;   //年消费等级
    _TB_BMEM_BMBTO   := 0 ;   //总消费等级
    _TB_BMEM_FOUND   := FALSE ; //找到会员

    //产品资料======================================
    _TB_BG_BGENO  := '';
    _TB_BG_BGNAM  := '';
    _TB_BG_BGKIN  := ''; //产品分类
    _TB_BG_BGPST  := 0 ;   //标准价格
    _TB_BG_BGPVP  := 0 ;   //贵宾价格
    _TB_BG_BGPMM  := 0 ;   //会员价格
    _TB_BG_BGCST  := 0 ;   //特惠价格1
    _TB_BG_BGOTH  := 0 ;   //特惠价格2
    _TB_BG_FOUND  := FALSE;//找到产品
    _TB_BG_CNT    := 0;  //此笔数量
    _TB_BG_SPRICE := 0;  //此笔单价
    _TB_BG_TPRICE := 0;  //此笔单价
    _TB_BG_BGQTS  := 0;  //安存数量
    _TB_BG_BGQTN  := 0;  //库存数量
    _TB_BG_BGCOS  := 0;  //成本价

    //其它功能
    _TB_INV_PAGE      := 0; //发票页

    //显示器资料======================================
    _TB_DSP_CHANGED := FALSE;

    // 清除 POSA OUT GRID  ==================================================================
    FOR I := 1 TO 200 DO OUT_GRID.Rows[I].Text := '';

    // 清除 GIFT GRID  ==================================================================
    IF FormExists('FMPOSAGIFT')=TRUE THEN FMPOSAGIFT.Release; 

    ED_INPUT_SETFOCUS;

    // 清除 客显 ==================================================================
    DSP_TITLE;
    DSP_TEXT1('','R');
    DSP_TEXT2('','R');
    // 清除 客显 ==================================================================
  END;

END;

//读取会员资料=============================================
FUNCTION FIND_BMEM(STR:STRING; KIND:INTEGER) :STRING;  //找会员
VAR QCHECK : TQUERY;
begin
  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.Add('SELECT * FROM BMEM ');
   QCHECK.SQL.Add('WHERE BMENO IS NOT NULL');
   IF KIND = 1 THEN QCHECK.SQL.Add('  AND BMENO = '''+ STR +''' ');
   IF KIND = 2 THEN QCHECK.SQL.Add('  AND BMNAM LIKE ''%'+ STR +'%'' ');
   IF KIND = 3 THEN QCHECK.SQL.Add('  AND (BMTL1 LIKE ''%'+ STR +'%'' OR BMTL2 LIKE ''%'+ STR +'%'' OR BMTL3 LIKE ''%'+ STR +'%'' ) ');
   QCHECK.SQL.Add(' ORDER BY BMENO, BMNAM ');
   QCHECK.CLOSE;   QCHECK.OPEN;

   IF QCHECK.Eof = FALSE THEN
      BEGIN
      _TB_BMEM_FOUND := TRUE;
      _TB_BMEM_BMENO   := QCHECK.FieldByName('BMENO').AsString;   //会员姓名
      _TB_BMEM_BMNAM   := QCHECK.FieldByName('BMNAM').AsString;   //会员姓名
      _TB_BMEM_BMLVE   := QCHECK.FieldByName('BMLVE').AsINTEGER;  //会员等级
      _TB_BMEM_BMBYR   := QCHECK.FieldByName('BMBYR').AsINTEGER;  //年消费等级
      _TB_BMEM_BMBTO   := QCHECK.FieldByName('BMBTO').AsINTEGER;  //总消费等级
      _TB_BMEM_BMCRD   := EDATE_TO_CDATE(QCHECK.FieldByName('BMCRD').AsString);
      _TB_BMEM_BMDAT   := EDATE_TO_CDATE(QCHECK.FieldByName('BMDAT').AsString);

      // 客显 ===============================================================
      DSP_TITLE;
      DSP_TEXT1('Member NO:' +FILL_STR(' ', _TB_BMEM_BMENO, 'L', 10 ) ,'R');
      DSP_TEXT2('LVE:' +FILL_STR(' ', INTTOSTR(_TB_BMEM_BMLVE), 'L', 2 )+' TOTAL: '+FILL_STR(' ', INTTOSTR(_TB_BMEM_BMBTO), 'L', 6 ) ,'R');
      // 客显 ===============================================================
      END ELSE BEGIN
      _TB_BMEM_FOUND := FALSE;  //找到会员
      _TB_BMEM_BMENO := '' ;
      _TB_BMEM_BMNAM := '' ;
      _TB_BMEM_BMLVE := 0;
      _TB_BMEM_BMBYR := 0;
      _TB_BMEM_BMBTO := 0;
      _TB_BMEM_BMCRD := '';    //发卡日
      _TB_BMEM_BMDAT := '';    //入会日

      // 客显 ===============================================================
      DSP_TITLE;
      DSP_TEXT1('Can''t find this NO! ' ,'R');
      DSP_TEXT2('Please try again! ' ,'R');
      // 客显 ===============================================================
      END;



   RESULT := QCHECK.FieldByName('BMENO').AsString;
  FINALLY
   QCHECK.Free;
  END;
end;

FUNCTION FIND_BGDS(STR:STRING; KIND:INTEGER) :STRING;      //找产品
VAR QCHECK : TQUERY;
begin
  GetLocalTime(SystemDate);            //取系统日期
  FMPOSA.ED_START.Caption := INTTOSTR(SystemDate.wMinute)+'分'+INTTOSTR(SystemDate.wSecond)+'秒'+INTTOSTR(SystemDate.wMilliseconds);

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.Clear;
   QCHECK.SQL.Add('SELECT * FROM BGDS ');
   QCHECK.SQL.Add('WHERE BGENO IS NOT NULL');
   IF (COPY(STR,1,1)='@') THEN  //单品键
      BEGIN
      QCHECK.SQL.Add('  AND BGSIN = '''+ STR +''' ');
      END ELSE BEGIN
      IF KIND <= 0 THEN KIND := 1;
      IF KIND >= 3 THEN KIND := 1;
      IF KIND  = 1 THEN QCHECK.SQL.Add('  AND BGENO = '''+ STR +''' ');    //查编号
      IF KIND  = 2 THEN QCHECK.SQL.Add('  AND BGNAM LIKE ''%'+ STR +'%'' ');  //查名称
      END;
   QCHECK.CLOSE;
   QCHECK.OPEN;

   _TB_BG_BGENO := QCHECK.FieldByName('BGENO').AsString;
   _TB_BG_BGNAM := QCHECK.FieldByName('BGNAM').AsString;
   _TB_BG_BGKIN := QCHECK.FieldByName('BGKIN').AsString; //产品分类
   _TB_BG_BGQTS := QCHECK.FieldByName('BGQTS').AsInteger;//安存数量
   _TB_BG_BGQTN := QCHECK.FieldByName('BGQTN').AsInteger;//库存数量
   _TB_BG_BGCOS := QCHECK.FieldByName('BGCOS').AsFloat;   //成本价
   _TB_BG_BGPST := QCHECK.FieldByName('BGPST').AsFloat;   //标准价格
   _TB_BG_BGPVP := QCHECK.FieldByName('BGPVP').AsFloat;   //贵宾价格
   _TB_BG_BGPMM := QCHECK.FieldByName('BGPMM').AsFloat;   //会员价格
   _TB_BG_BGCST := QCHECK.FieldByName('BGCST').AsFloat;   //特惠价格1
   _TB_BG_BGOTH := QCHECK.FieldByName('BGOTH').AsFloat;   //特惠价格2


   IF QCHECK.Eof = FALSE THEN _TB_BG_FOUND := TRUE  ELSE _TB_BG_FOUND := FALSE;  //找到产品

   GetLocalTime(SystemDate);            //取系统日期
   FMPOSA.ED_END.Caption := INTTOSTR(SystemDate.wMinute)+'分'+INTTOSTR(SystemDate.wSecond)+'秒'+INTTOSTR(SystemDate.wMilliseconds);

   // 客显 ==================================================================
   DSP_TITLE;
   DSP_TEXT1(_TB_BG_BGENO,'R');
   DSP_TEXT2(FLOATTOSTR(_TB_BG_BGPST),'R');
   // 客显 ==================================================================

   RESULT := QCHECK.FieldByName('BGENO').AsString;
  FINALLY
   QCHECK.Free;
  END;

END;

PROCEDURE CHECK_PRICE;  //检查价钱
BEGIN
  _TB_BG_CNT    := 1;
  _TB_BG_SPRICE := _TB_BG_BGPST;

  //小数无条件四舍五入
  IF _TB_AUTO_ROUND = TRUE THEN _TB_BG_TPRICE := FLOATTOINT_ROUND( _TB_DISC_PERCENT *_TB_BG_BGPST )
                           ELSE _TB_BG_TPRICE := FLOATTOINT( _TB_DISC_PERCENT *_TB_BG_BGPST );
END;

PROCEDURE GRID_ADD;
VAR I , J:INTEGER;
BEGIN
  WITH FMPOSA DO
    BEGIN
    IF TRIM(_TB_BG_BGENO) = '' THEN EXIT;

    //算笔数
    FOR I := 1 TO 200 DO
      BEGIN
      J := I;
      IF TRIM(OUT_GRID.Cells[1,I]) =  '' THEN BREAK;
      END;

    FOR I := (J+1) DOWNTO 1 DO OUT_GRID.Rows[I].Text := OUT_GRID.Rows[I-1].Text;

    OUT_GRID.Cells[1,1] := _TB_BG_BGENO;
    OUT_GRID.Cells[2,1] := _TB_BG_BGNAM;
    OUT_GRID.Cells[3,1] := INTTOSTR  (_TB_BG_CNT   );  //此笔数量
    OUT_GRID.Cells[4,1] := FLOATTOSTR(_TB_BG_SPRICE);  //此笔单价
    OUT_GRID.Cells[5,1] := FLOATTOSTR(_TB_BG_TPRICE);  //此笔单价
    OUT_GRID.Cells[6,1] := INTTOSTR  (_TB_BG_BGQTN );  //库存数量
    OUT_GRID.Cells[7,1] :=            _TB_BG_BGKIN  ;  //分类
  END;

END;

FUNCTION RE_INPUT(T_BGENO:STRING):BOOLEAN;
VAR I , J   :INTEGER;
    T_QTY   :INTEGER;
    T_PRICE : REAL;
BEGIN

  WITH FMPOSA DO
    BEGIN

    //重复刷, 合并成一笔==================================================
    IF _TB_RE_INPUT = FALSE THEN
      BEGIN  //重复刷, 不 自动合并成一笔
      FOR I := 1 TO 200 DO
        BEGIN
        IF (OUT_GRID.Cells[1,I] = T_BGENO) THEN
           BEGIN
           CASE MessageDlg('此产品已刷过, 是否继续存入? '+#10#13+
                #10#13+'按　ＹＥＳ　合并成一笔'+
                #10#13+'按　ＮＯ　　分开成两笔'+
                #10#13+'按　ＥＳＣ　取消输入'
                ,mtConfirmation,[mbYes,mbNo,mbCancel],0) OF
           mrYES :
               BEGIN
               T_QTY   := STRTOINTDEF  (OUT_GRID.Cells[3,I],1) + 1;
               T_PRICE := STRTOFLOATDEF(OUT_GRID.Cells[4,I],0);
               OUT_GRID.Cells[3,I] := INTTOSTR(STRTOINTDEF(OUT_GRID.Cells[3,I],1)+1);
               OUT_GRID.Cells[5,I] := FLOATTOSTR(T_QTY * T_PRICE);
               _TB_DSP_CHANGED:= FALSE;  //已更动, 客显要更新
               RESULT := TRUE;
               ED_INPUT_SETFOCUS;
               EXIT;
               END;
           mrNO :
               BEGIN
               ED_INPUT_SETFOCUS;
               RESULT := FALSE;
               BREAK;
               END;
               ELSE BEGIN
               ED_INPUT_SETFOCUS;
               RESULT := FALSE;
               EXIT;
               END;
           END;   //CASE
           END;   //IF
        IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
        END;
        END ELSE BEGIN //重复刷, 自动合并成一笔
        FOR I := 1 TO 200 DO
          BEGIN
          IF (OUT_GRID.Cells[1,I] = T_BGENO) THEN
             BEGIN
             T_QTY   := STRTOINTDEF  (OUT_GRID.Cells[3,I],1) + 1;
             T_PRICE := STRTOFLOATDEF(OUT_GRID.Cells[4,I],0);
             OUT_GRID.Cells[3,I] := INTTOSTR(STRTOINTDEF(OUT_GRID.Cells[3,I],1)+1);
             OUT_GRID.Cells[5,I] := FLOATTOSTR(T_QTY * T_PRICE);
             _TB_DSP_CHANGED:= FALSE;  //已更动, 客显要更新
             RESULT := TRUE;
             ED_INPUT_SETFOCUS;
             EXIT;
             END;   //IF
          IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
        END; // FOR
      END;  // IF
    //重复刷, 合并成一笔==================================================
    END;
    
END;

PROCEDURE FINISHI;             //完成结帐
VAR FINISHI_REC, I : INTEGER;
    T_BGENO, T_BGNAM, T_BGCNT, T_BGCOS, T_BGCOT, T_BGKIN, T_PAIPN : STRING; //是否打印发票
BEGIN
  //发票机, 打印位置从一开始
  INVOICE_COUNTER := 0;
  _TB_INV_PAGE  := 0;

  IF ( _TB_PRN_PRINTING = TRUE) THEN FINISHI_OPEN_CASHBOX;  //是否打印发票 - 开钱柜

  // 检查要结帐的共有几笔 =====================================================
  FOR I := 1 TO 200 DO
    BEGIN
    FINISHI_REC := I;
    IF TRIM(FMPOSA.OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
    END;

  FMPOSAF1.Gauge.MaxValue := _TB_TOTAL_REC + 5;
  FINISHI_DSP_TOTAL;  FMPOSAF1.Gauge.AddProgress(1); DELAY(5);  //完成结帐_ 价格显示

  IF (_TB_PRACTICE_MODE <= 0) THEN //练习模式
     BEGIN
     FMPOSAF1.Gauge_SUB.MaxValue := FINISHI_REC;
     FINISHI_SAVE_POSA; FMPOSAF1.Gauge.AddProgress(1); DELAY(5);  //完成结帐_ POSA 主表
     FINISHI_SAVE_POSB; FMPOSAF1.Gauge.AddProgress(1); DELAY(5);  //完成结帐_ POSB 明细
     FINISHI_SAVE_POSG; FMPOSAF1.Gauge.AddProgress(1); DELAY(5);  //完成结帐_ POSG 礼券
     END;

  IF (_TB_PRACTICE_MODE <= 0) OR (_TB_PRACTICE_MODE = 1) THEN //练习模式
  IF _TB_PRN_PRINTING = TRUE THEN
     BEGIN
     FMPOSAF1.Gauge_SUB.MaxValue := FINISHI_REC;
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头

     // 检查要结帐的共有几笔 =====================================================
     FOR I := 1 TO FMPOSAF1.Gauge_SUB.MaxValue DO
        BEGIN
        FMPOSAF1.Gauge_SUB.AddProgress(1);
        T_BGENO := FMPOSA.OUT_GRID.Cells[1,I];//产品条形码
        T_BGNAM := FMPOSA.OUT_GRID.Cells[2,I];//产品名称
        T_BGCNT := FMPOSA.OUT_GRID.Cells[3,I];//产品数量
        T_BGCOS := FMPOSA.OUT_GRID.Cells[4,I];//产品单价
        T_BGCOT := FMPOSA.OUT_GRID.Cells[5,I];//产品总价

        FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
        FINISHI_PRN_IVOICE_CONTENT(T_BGENO,T_BGNAM,T_BGCNT,T_BGCOS,T_BGCOT);  //完成结帐_ 打印发票 项目
        IF TRIM(FMPOSA.OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
        END;

    FINISHI_PRN_IVOICE_END;      //完成结帐_ 打印发票 结尾
    END;

   FMPOSAF1.Gauge.AddProgress(1);             DELAY(5);
END;

PROCEDURE FINISHI_SAVE_POSA;   //完成结帐_ POSA 主表
VAR QCHECK : TQUERY;
    T_PACDT : TDATETIME;
BEGIN

  //读取销售编号 //此次结帐编号
  _TB_PAENO := TABLEFINDMAXCNT2('POSA','PAENO', EDATE_TO_CDATE(DATETOSTR(_TB_INSERT_DATE)) , 5, 1 );
  IF CHECK_CDATE(_TB_CARD_PACDT, FALSE) = TRUE THEN
  T_PACDT := STRTODATE(CDATE_TO_EDATE(_TB_CARD_PACDT));              //信用卡到期日

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.CLEAR;
   QCHECK.SQL.Add('INSERT INTO POSA');
   QCHECK.SQL.Add(' ( PAENO, PAIDE, BMENO, BNENO, PAIPN, PAIVO, PACIV, PADAT, PATME, PACNT, PACOT, PACOG, ');
   QCHECK.SQL.Add('   PACNO, PACDT, PACNA, PACKD, PABCK, PABCN, PACPD, PAWEK                            ) ');
   QCHECK.SQL.Add('   VALUES ');
   QCHECK.SQL.Add(' (:PAENO,:PAIDE,:BMENO,:BNENO,:PAIPN,:PAIVO,:PACIV,:PADAT,:PATME,:PACNT,:PACOT,:PACOG, ');
   QCHECK.SQL.Add('  :PACNO,:PACDT,:PACNA,:PACKD,:PABCK,:PABCN,:PACPD,:PAWEK                            ) ');

   QCHECK.ParamByName('PAENO').AsString := _TB_PAENO;             //销售编号
   QCHECK.ParamByName('PAIDE').AsString := _TB_NUMBER;            //柜台号码
   QCHECK.ParamByName('BMENO').AsString := _TB_BMEM_BMENO;        //会员编号
   QCHECK.ParamByName('BNENO').AsString := _TB_USER_NUMBER;       //员工编号
   QCHECK.ParamByName('PAIPN').AsBoolean  := _TB_PRN_PRINTING;     //是否打印发票
   QCHECK.ParamByName('PAIVO').AsString   := _TB_INV_NO;            //发票号码
   QCHECK.ParamByName('PACIV').AsString   := _TB_PACIV;             //统一编号
   QCHECK.ParamByName('PADAT').AsDatetime := _TB_INSERT_DATE;     //销售日期
   QCHECK.ParamByName('PATME').AsString   := TIME_GET_24H(TIME);    //销售时间
   QCHECK.ParamByName('PACNT').AsFloat    := _TB_TOTAL_QTY;          //产品数量
   QCHECK.ParamByName('PACOT').AsFloat    := _TB_TOTAL_PRICE;        //产品总价
   QCHECK.ParamByName('PACOG').AsFloat    := _TB_TOTAL_CASH;         //收入金额
   QCHECK.ParamByName('PACNO').AsString   := _TB_CARD_PACNO;      //信用卡号
   QCHECK.ParamByName('PACDT').AsDatetime := T_PACDT;             //信用卡到期日
   QCHECK.ParamByName('PACNA').AsFloat    := _TB_CARD_PACNA;      //信用卡金额
   QCHECK.ParamByName('PACKD').AsString   := _TB_CARD_PACKD;      //信用卡类别
   QCHECK.ParamByName('PABCK').AsBoolean  := False;               //发票作废
   QCHECK.ParamByName('PABCN').AsBoolean  := False;               //资料回存
   QCHECK.ParamByName('PACPD').AsBoolean  := False;               //信用卡付费
   QCHECK.ParamByName('PAWEK').AsString   := INTTOSTR(DayOfWeek(_TB_INSERT_DATE));                  //星期几
   TRY QCHECK.ExecSQL; except SHOWMESSAGE('POSA 无法新增!');   end;

  //更新会员消费
  IF TRIM(_TB_BMEM_BMENO) <> '' THEN
     BEGIN
     QCHECK.SQL.Clear;
     QCHECK.SQL.ADD('UPDATE BMEM SET');
     QCHECK.SQL.ADD(' BMBYR = BMBYR + '+FLOATTOSTR(_TB_TOTAL_PRICE)+',');
     QCHECK.SQL.ADD(' BMBTO = BMBTO + '+FLOATTOSTR(_TB_TOTAL_PRICE)+',');
     QCHECK.SQL.ADD(' BMBPO = BMBPO + '+FLOATTOSTR(_TB_TOTAL_PRICE)+'/'+INTTOSTR(_TB_SET_BMBPO)+',');
     QCHECK.SQL.ADD(' BMBTM = BMBTM + 1 ,');
     QCHECK.SQL.ADD(' BMBDT = '+_DT+ DATETOSTR(_TB_INSERT_DATE) +_DT);
     QCHECK.SQL.ADD(' WHERE BMENO = '''+_TB_BMEM_BMENO+'''');
     try QCHECK.ExecSQL;  except SHOWMESSAGE('BMEM 无法更新!');   end;
     END;

  //更新业务业绩
  IF TRIM(_TB_USER_NUMBER) <> '' THEN
     BEGIN
     QCHECK.SQL.Clear;
     QCHECK.SQL.ADD('UPDATE BSAL SET');
     QCHECK.SQL.ADD(' BASYR = BASYR + '+FLOATTOSTR(_TB_TOTAL_PRICE)+',');
     QCHECK.SQL.ADD(' BASTO = BASTO + '+FLOATTOSTR(_TB_TOTAL_PRICE)+',');
     QCHECK.SQL.ADD(' BASDT = '+_DT+ DATETOSTR(_TB_INSERT_DATE) +_DT);
     QCHECK.SQL.ADD(' WHERE BAENO = '''+_TB_USER_NUMBER+'''');
     try QCHECK.ExecSQL;  except SHOWMESSAGE('BSAL 无法更新!');   end;
     END;

  FINALLY
    QCHECK.Free;
  END;
  
END;

PROCEDURE FINISHI_SAVE_POSB;   //完成结帐_ POSB 明细
VAR QCHECK, QUPD  : TQUERY;
    I : INTEGER;
    T_PBENO, T_BGENO, T_BGNAM, T_BGCNT, T_BGCOS, T_BGCOT, T_BGKIN, T_BGQTN :STRING;
BEGIN

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QUPD   := TQUERY.Create(APPLICATION.Owner);
   QUPD   .DatabaseName := 'MAIN';
   QCHECK.SQL.CLEAR;
   QCHECK.SQL.Add('INSERT INTO POSB');
   QCHECK.SQL.Add(' ( PAENO, PBENO, BGQTN, BGENO, BGCNT, BGCOS, BGCOT ) ');
   QCHECK.SQL.Add('   VALUES ');
   QCHECK.SQL.Add(' (:PAENO,:PBENO,:BGQTN,:BGENO,:BGCNT,:BGCOS,:BGCOT ) ');

  //存入数据库
  WITH FMPOSA DO
    BEGIN
    FOR I := 1 TO 200 DO
      BEGIN
      FMPOSAF1.Gauge.AddProgress(1);
      T_PBENO := TABLEFINDMAXITM('POSB','PAENO',_TB_PAENO,'PBENO',3,1);//销售ITEM
      T_BGENO := OUT_GRID.Cells[1,I];//产品条形码
      T_BGNAM := OUT_GRID.Cells[2,I];//产品名称
      T_BGCNT := OUT_GRID.Cells[3,I];//产品数量
      T_BGCOS := OUT_GRID.Cells[4,I];//产品单价
      T_BGCOT := OUT_GRID.Cells[5,I];//产品总价
      T_BGQTN := OUT_GRID.Cells[6,I];//仓库数量
      T_BGKIN := OUT_GRID.Cells[7,I];//产品分类
      QCHECK.ParamByName('PAENO').AsString  := _TB_PAENO;                  //销售编号
      QCHECK.ParamByName('PBENO').AsString  := T_PBENO;                    //销售项次
      QCHECK.ParamByName('BGQTN').AsFloat   := STRTOFLOATDEF(T_BGQTN,-999);//仓库数量
      QCHECK.ParamByName('BGENO').AsString  := T_BGENO;                    //产品编号
      QCHECK.ParamByName('BGCNT').AsInteger := STRTOINTDEF  (T_BGCNT,1);       //产品数量
      QCHECK.ParamByName('BGCOS').AsFloat   := STRTOFLOATDEF(T_BGCOS,0);       //产品单价
      QCHECK.ParamByName('BGCOT').AsFloat   := STRTOFLOATDEF(T_BGCOT,0);       //产品小计
      TRY QCHECK.ExecSQL; except SHOWMESSAGE('POSB 无法新增!');   end;

      //更新库存资料 -分类999不更新库存
      IF T_BGKIN <> '999' THEN
         BEGIN
         QUPD.SQL.Clear;
         QUPD.SQL.ADD('UPDATE BGDS SET');
         QUPD.SQL.ADD(' BGQTN = BGQTN - '+T_BGCNT+' ,');
         QUPD.SQL.ADD(' BGDTC = '+_DT+ DATETOSTR(_TB_INSERT_DATE)  +_DT+' ');
         QUPD.SQL.ADD(' WHERE BGENO = '''+T_BGENO+'''');
         try QUPD.ExecSQL;  except SHOWMESSAGE('BGDS_BGQTN 无法更新!');   end;
         END;

      IF TRIM(OUT_GRID.Cells[1,I+1]) =  '' THEN BREAK;
      END;
    END;
  FINALLY
    QCHECK.Free;
    QUPD  .Free;
  END;
  
END;

PROCEDURE FINISHI_SAVE_POSG;   //完成结帐_ POSG 礼券
VAR QCHECK  : TQUERY;
    I : INTEGER;
    T_PGENO : STRING;
BEGIN
  IF FormExists('FMPOSAGIFT')=FALSE THEN EXIT;

  TRY
   QCHECK := TQUERY.Create(APPLICATION.Owner);
   QCHECK.DatabaseName := 'MAIN';
   QCHECK.SQL.CLEAR;
   QCHECK.SQL.Add('INSERT INTO POSG');
   QCHECK.SQL.Add(' ( PAENO, PGITM, PGENO, PGDAT, PGCOS, PGKND ) ');
   QCHECK.SQL.Add('   VALUES ');
   QCHECK.SQL.Add(' (:PAENO,:PGITM,:PGENO,:PGDAT,:PGCOS,:PGKND ) ');

   // 礼券的资料
   FOR I := 1 TO FMPOSAGIFT.GIFT_GRID.RowCount-1 DO
     BEGIN
     IF TRIM( FMPOSAGIFT.GIFT_GRID.Cells[3,I] ) = '' THEN BREAK;
     T_PGENO := TABLEFINDMAXITM('POSG','PAENO',_TB_PAENO,'PGITM',3,1);  //销售ITEM
     QCHECK.ParamByName('PAENO').AsString   := _TB_PAENO;                 //销售编号
     QCHECK.ParamByName('PGITM').AsString   := T_PGENO;                   //销售项次
     QCHECK.ParamByName('PGENO').AsString   := FMPOSAGIFT.GIFT_GRID.Cells[0,I];   //礼券编号
     IF FMPOSAGIFT.GIFT_GRID.Cells[1,I] <> '' THEN
          QCHECK.ParamByName('PGDAT').AsDATETIME := STRTODATE( CDATE_TO_EDATE(FMPOSAGIFT.GIFT_GRID.Cells[1,I]) )       //礼券到期日
     ELSE QCHECK.ParamByName('PGDAT').AsDATETIME := STRTODATE( '1900/1/1');
     QCHECK.ParamByName('PGCOS').AsFloat    := STRTOFLOATDEF(      FMPOSAGIFT.GIFT_GRID.Cells[3,I], 0);   //礼券金额
     QCHECK.ParamByName('PGKND').AsString   := FMPOSAGIFT.GIFT_GRID.Cells[2,I];   //礼券类别
     TRY QCHECK.ExecSQL; except SHOWMESSAGE('POSG 礼券 无法新增!!');   end;
     END;

  FINALLY
   QCHECK.Free;
  END;
END;

PROCEDURE FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
VAR I, J : INTEGER;
BEGIN
  //发票排版资料 抬头 ==================================
  IF INVOICE_COUNTER = 0 THEN
     BEGIN
     INCREASE_INV_NO;//累加发票号码

     IF INVOICE_PRINTER = 4 THEN    // EPSON RP-U420-110
        BEGIN
        INVOICE_IV_TEXT('');
        INVOICE_IV_TEXT('');
        INVOICE_IV_TEXT('');
        INVOICE_IV_TEXT('');
        END;

     // 发票 TITLE 设置
     FOR I := 1 TO _TB_INV_SET_IV_TS1 DO INVOICE_IV_INV_LINEFEED;
     IF TRIM(_TB_INV_SET_IV_TC1) <> '' THEN INVOICE_IV_INV_TEXT(_TB_INV_SET_IV_TC1);
     FOR I := 1 TO _TB_INV_SET_IV_TS2 DO INVOICE_IV_INV_LINEFEED;
     IF TRIM(_TB_INV_SET_IV_TC2) <> '' THEN INVOICE_IV_INV_TEXT(_TB_INV_SET_IV_TC2);

     // 必定打印部份
     INVOICE_IV_INV_TEXT(DATETOSTR(_TB_INSERT_DATE) +' '+ TIMETOSTR(TIME));
     INVOICE_IV_INV_TEXT('店'+ _SYS_RBPST+'机'+_TB_NUMBER+'序'+_TB_PAENO);
     INVOICE_IV_INV_TEXT('员'+_TB_USER_NUMBER +' -'+ _TB_INV_NO  +'- 页'+INTTOSTR(_TB_INV_PAGE ));
     IF TRIM(_TB_PACIV) <> '' THEN INVOICE_IV_INV_TEXT('统一编号: '+_TB_PACIV);

     END;
  // 打印开头 ================================================================
END;


PROCEDURE FINISHI_PRN_IVOICE_CONTENT(T_BGENO,T_BGNAM,T_BGCNT,T_BGCOS,T_BGCOT:STRING);  //完成结帐_ 打印发票 项目
VAR T_INV_C1, T_INV_C2, T_INV_C3, T_INV_C4, T_INV_C5, T_INV_C6, T_INV_C7 : STRING;
BEGIN
  //发票排版资料 内容 ==================================
  T_INV_C1 := '';
  IF _TB_INV_SET_IV_CC1 = 1 THEN T_INV_C1 := T_BGENO ;
  IF _TB_INV_SET_IV_CC1 = 2 THEN T_INV_C1 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGID1');
  IF _TB_INV_SET_IV_CC1 = 3 THEN T_INV_C1 := T_BGNAM ;
  IF _TB_INV_SET_IV_CC1 = 4 THEN T_INV_C1 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGKIN');
  IF _TB_INV_SET_IV_CC1 = 5 THEN T_INV_C1 := T_BGCNT ;
  IF _TB_INV_SET_IV_CC1 = 6 THEN T_INV_C1 := T_BGCOS ;
  IF _TB_INV_SET_IV_CC1 = 7 THEN T_INV_C1 := T_BGCOT ;
  T_INV_C2 := '';
  IF _TB_INV_SET_IV_CC2 = 1 THEN T_INV_C2 := T_BGENO ;
  IF _TB_INV_SET_IV_CC2 = 2 THEN T_INV_C2 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGID1');
  IF _TB_INV_SET_IV_CC2 = 3 THEN T_INV_C2 := T_BGNAM ;
  IF _TB_INV_SET_IV_CC2 = 4 THEN T_INV_C2 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGKIN');
  IF _TB_INV_SET_IV_CC2 = 5 THEN T_INV_C2 := T_BGCNT ;
  IF _TB_INV_SET_IV_CC2 = 6 THEN T_INV_C2 := T_BGCOS ;
  IF _TB_INV_SET_IV_CC2 = 7 THEN T_INV_C2 := T_BGCOT ;
  T_INV_C3 := '';
  IF _TB_INV_SET_IV_CC3 = 1 THEN T_INV_C3 := T_BGENO ;
  IF _TB_INV_SET_IV_CC3 = 2 THEN T_INV_C3 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGID1');
  IF _TB_INV_SET_IV_CC3 = 3 THEN T_INV_C3 := T_BGNAM ;
  IF _TB_INV_SET_IV_CC3 = 4 THEN T_INV_C3 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGKIN');
  IF _TB_INV_SET_IV_CC3 = 5 THEN T_INV_C3 := T_BGCNT ;
  IF _TB_INV_SET_IV_CC3 = 6 THEN T_INV_C3 := T_BGCOS ;
  IF _TB_INV_SET_IV_CC3 = 7 THEN T_INV_C3 := T_BGCOT ;
  T_INV_C4 := '';
  IF _TB_INV_SET_IV_CC4 = 1 THEN T_INV_C4 := T_BGENO ;
  IF _TB_INV_SET_IV_CC4 = 2 THEN T_INV_C4 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGID1');
  IF _TB_INV_SET_IV_CC4 = 3 THEN T_INV_C4 := T_BGNAM ;
  IF _TB_INV_SET_IV_CC4 = 4 THEN T_INV_C4 := DB_QUERY_FIND_VALUE('BGDS','BGENO',T_BGENO,'BGKIN');
  IF _TB_INV_SET_IV_CC4 = 5 THEN T_INV_C4 := T_BGCNT ;
  IF _TB_INV_SET_IV_CC4 = 6 THEN T_INV_C4 := T_BGCOS ;
  IF _TB_INV_SET_IV_CC4 = 7 THEN T_INV_C4 := T_BGCOT ;


  INVOICE_IV_INV_TEXT(
   COPY(T_INV_C1,1,_TB_INV_SET_IV_CP1)+ REPLICATE(' ',_TB_INV_SET_IV_CP1-LENGTH(T_INV_C1))
       +REPLICATE(' ',_TB_INV_SET_IV_CS1)+
   COPY(T_INV_C2,1,_TB_INV_SET_IV_CP2)+ REPLICATE(' ',_TB_INV_SET_IV_CP2-LENGTH(T_INV_C2))
       +REPLICATE(' ',_TB_INV_SET_IV_CS2)+
   COPY(T_INV_C3,1,_TB_INV_SET_IV_CP3)+ REPLICATE(' ',_TB_INV_SET_IV_CP3-LENGTH(T_INV_C3))
       +REPLICATE(' ',_TB_INV_SET_IV_CS3)+
        REPLICATE(' ',_TB_INV_SET_IV_CP4-LENGTH(T_INV_C4)) +COPY(T_INV_C4,1,_TB_INV_SET_IV_CP4)  );

END;

PROCEDURE FINISHI_PRN_IVOICE_END;      //完成结帐_ 打印发票 结尾
VAR T_INV_LASTLINE : INTEGER;
BEGIN
  //发票排版资料 结尾 ==================================
  T_INV_LASTLINE := 2;

  IF TRIM(_TB_INV_SET_IV_EC1) <> '' THEN INC(T_INV_LASTLINE);  // 结尾加行 1
  IF TRIM(_TB_INV_SET_IV_EC2) <> '' THEN INC(T_INV_LASTLINE);  // 结尾加行 2
  IF (_TB_LAST_SUB = TRUE) AND (_TB_LAST_PRICE > 0) THEN INC(T_INV_LASTLINE); //打印去尾数

  IF _TB_CARD_PACNA > 0 THEN INC(T_INV_LASTLINE); //信用卡号  //要印两行, 所以加两次
  IF _TB_GIFT_PGCNA > 0 THEN INC(T_INV_LASTLINE); //礼券  号  //要印两行, 所以加两次

  // 开始打印结尾
  WHILE INVOICE_COUNTER < STRTOINTDEF(INVOICE_MAXROW,0) - T_INV_LASTLINE DO  //加入空白, 使得总计在发票下方
        INVOICE_IV_INV_LINEFEED;

  IF (_TB_INV_SET_IV_RP2=TRUE) AND (_TB_CARD_PACNO<>'') THEN
     BEGIN
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
     INVOICE_IV_INV_TEXT('信用卡号码: '+_TB_CARD_PACNO); //打印信用卡号
     END;
  IF (_TB_INV_SET_IV_RP3=TRUE) AND (_TB_GIFT_PGCNO<>'') THEN
     BEGIN
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
     INVOICE_IV_INV_TEXT('礼券号码: '  +_TB_GIFT_PGCNO); //打印礼券明细
     END;

  IF (_TB_INV_SET_IV_RP1=TRUE) AND (_TB_TOTAL_PAY> 0) THEN //打印应找
     BEGIN
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
     INVOICE_IV_INV_TEXT('收现 '+ FLOATTOSTR(_TB_TOTAL_PAY) + ' 找 '+FLOATTOSTR(_TB_TOTAL_EXCHANGE)+'元');
     END;
  IF TRIM(_TB_INV_SET_IV_EC1) <> '' THEN
     BEGIN
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
     INVOICE_IV_INV_TEXT(_TB_INV_SET_IV_EC1);  // 结尾加行 1
     END;
  IF TRIM(_TB_INV_SET_IV_EC2) <> '' THEN
     BEGIN
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
     INVOICE_IV_INV_TEXT(_TB_INV_SET_IV_EC2);  // 结尾加行 2
     END;
  IF (_TB_LAST_SUB = TRUE) AND (_TB_LAST_PRICE > 0) THEN
     BEGIN
     FINISHI_PRN_IVOICE_TITLE;    //完成结帐_ 打印发票 开头
     INVOICE_IV_INV_TEXT('去尾数:'+FLOATTOSTR(_TB_LAST_PRICE)+'元'); //打印去尾数
     END;
  //=====================================================

  INVOICE_IV_INV_TEXT('  共: '+INTTOSTR( _TB_TOTAL_REC )+' 项  '+INTTOSTR( _TB_TOTAL_QTY )+' 个');
  INVOICE_IV_INV_TEXT('总计: '+REPLICATE(' ',10-LENGTH(FLOATTOSTR(_TB_TOTAL_PRICE)))+FLOATTOSTR(_TB_TOTAL_PRICE) +' 元' );

  IF (INVOICE_COUNTER < STRTOINTDEF(INVOICE_MAXROW,0)) AND (INVOICE_COUNTER >1) THEN INVOICE_IV_PAGEFEED;

END;

PROCEDURE FINISHI_DSP_TOTAL;   //完成结帐_ 价格显示
BEGIN
END;

PROCEDURE FINISHI_OPEN_CASHBOX;//开钱柜
BEGIN
IF ( _TB_PRN_CASHBOX  = TRUE) THEN //是否自动开钱柜
   begin
   try INVOICE_OPEN_CASHBOX;  except SHOWMESSAGE('钱柜无法开启!');   end;
   SYSLOG_INSERT('CBX',_TB_NUMBER,'结帐开钱柜'); //新增开钱柜记录
   end;
END;




















PROCEDURE INCREASE_INV_NO;//累加发票号码
BEGIN
  _TB_INV_PAGE := _TB_INV_PAGE + 1; //发票页

  DEC(_TB_INV_CNT); //自动累减 发票张数
  IF LENGTH(_TB_INV_NO)= 8 THEN _TB_INV_NO := STR_INC('0',_TB_INV_NO ,1, 8  ,1);
  IF LENGTH(_TB_INV_NO)=10 THEN _TB_INV_NO := STR_INC('0',_TB_INV_NO ,3,10  ,1);
END;


end.
