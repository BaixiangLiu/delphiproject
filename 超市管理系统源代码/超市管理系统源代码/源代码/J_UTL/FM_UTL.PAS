unit fm_utl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,DB , DBGrids, Buttons, ToolWin, ComCtrls, ExtCtrls, DBCtrls, StdCtrls,
  Mask, DBTables, Registry;


//按钮模式设置
FUNCTION BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNPRN,BTNQUT: TSpeedButton;
                          INS_MD,UPD_MD,DEL_MD,YES_MD,CAL_MD,SER_MD,PRN_MD,QUT_MD: Boolean):Boolean;
FUNCTION BTN_ENABLED_MODE_BITBTN(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNPRN,BTNQUT: TBITBTN;
                          INS_MD,UPD_MD,DEL_MD,YES_MD,CAL_MD,SER_MD,PRN_MD,QUT_MD: Boolean):Boolean;
//加载按钮图形
FUNCTION BTN_LOADBMPFILE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNPRN,BTNQUT: TSpeedButton;
                         INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,PRN_TB,QUT_TB: TBitmap):Boolean;

//加载按钮图形
FUNCTION BTN_LOADBMPFILE_BITBTN(BTNNAME: TBITBTN;FILENAME: STRING):Boolean;
FUNCTION BTN_LOADBMPSTREAM_BITBTN(BTNNAME: TBITBTN; T_STREAM: TBitmap):Boolean;

//GRID BOOLEAN 画图
FUNCTION GRID_DRAWCOLUMNCELL(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState;True_bmp, False_bmp, Blank_bmp : TBitmap):boolean;

//FORM =========================================================================
//检查FORM 是否存在
FUNCTION FormExists(FORM_NAME:STRING):BOOLEAN;
// FORM 释放内存
FUNCTION FormRelease(T_FORM:TFORM):BOOLEAN;
FUNCTION FormFREE(T_FORM:STRING):BOOLEAN;
FUNCTION DataModuleRelease(T_FORM:TDataModule):BOOLEAN;

FUNCTION Form_MDI_POSITION    (T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
FUNCTION Form_MDI_SHOWMODAL   (T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
FUNCTION Form_MDI_SHOW        (T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
FUNCTION Form_NORMAL_SHOW     (T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
FUNCTION Form_NORMAL_SHOWMODAL(T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
//FUNCTION Form_SET_NORMAL   (T_FORM:TFORM):BOOLEAN;
//FUNCTION Form_SET_MDIFORM  (T_FORM:TFORM):BOOLEAN;
//FORM =========================================================================



//数据库类 =====================================================================

//检查 是否为空字段
FUNCTION FM_CHECK_FIELD_BLANK(F_VALUE,F_NAME,F_MESSAGE : STRING):boolean;

//更新数据库 POST
FUNCTION FM_DB_QUERY_POST  (T_DATABASE:TDATABASE;T_QUERY:TQUERY):boolean;
FUNCTION FM_DB_QUERY_UPDATE(T_DATABASE:TDATABASE;T_QUERY:TQUERY):boolean;
//数据库类 =====================================================================


// 登录器 REGISTER =============================================================
FUNCTION REGISTER_NUMBER_POS(CPU_ID:LONGINT):STRING;
FUNCTION REGISTER_NUMBER_WHOUSE(CPU_ID:LONGINT):STRING;

FUNCTION REGISTER_POS_CREATE(T_REG_NAME:STRING):BOOLEAN;
FUNCTION REGISTER_POS_REGISTER(T_REG_NAME, T_SF_ID:STRING):BOOLEAN;

FUNCTION REGISTER_KEY_VALUE_STR (T_REG_NAME, T_KEY:STRING):STRING;
FUNCTION REGISTER_KEY_VALUE_DATE(T_REG_NAME, T_KEY:STRING):TDATE;
FUNCTION REGISTER_KEY_CHECK(T_REG_NAME:STRING):BOOLEAN;
FUNCTION REGISTER_KEY_CREATE(T_REG_NAME:STRING):BOOLEAN;
FUNCTION REGISTER_KEY_DELETE(T_REG_NAME:STRING):BOOLEAN;

FUNCTION REGISTER_SAVE_OBJECT_INT(T_REG_NAME:STRING;T_KEY:INTEGER):BOOLEAN;
FUNCTION REGISTER_SAVE_OBJECT_STR(T_REG_NAME:STRING;T_KEY:STRING ):BOOLEAN;

FUNCTION REGISTER_LOAD_OBJECT_INT(T_REG_NAME:STRING;T_DEFAULT:INTEGER):INTEGER;
FUNCTION REGISTER_LOAD_OBJECT_STR(T_REG_NAME:STRING;T_DEFAULT:STRING ):STRING;
// 登录器 REGISTER =============================================================



implementation

USES UN_UTL;


//按钮模式设置
FUNCTION BTN_ENABLED_MODE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNPRN,BTNQUT: TSpeedButton;
                          INS_MD,UPD_MD,DEL_MD,YES_MD,CAL_MD,SER_MD,PRN_MD,QUT_MD: Boolean):Boolean;
BEGIN
  RESULT:= TRUE;
  with BTNINS do Enabled := INS_MD;
  with BTNUPD do Enabled := UPD_MD;
  with BTNDEL do Enabled := DEL_MD;
  with BTNYES do Enabled := YES_MD;
  with BTNCAL do Enabled := CAL_MD;
  with BTNSER do Enabled := SER_MD;
  with BTNPRN do Enabled := PRN_MD;
  with BTNQUT do Enabled := QUT_MD;
END;

FUNCTION BTN_ENABLED_MODE_BITBTN(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNPRN,BTNQUT: TBITBTN;
                          INS_MD,UPD_MD,DEL_MD,YES_MD,CAL_MD,SER_MD,PRN_MD,QUT_MD: Boolean):Boolean;
BEGIN
  RESULT:= TRUE;
  with BTNINS do Enabled := INS_MD;
  with BTNUPD do Enabled := UPD_MD;
  with BTNDEL do Enabled := DEL_MD;
  with BTNYES do Enabled := YES_MD;
  with BTNCAL do Enabled := CAL_MD;
  with BTNSER do Enabled := SER_MD;
  with BTNPRN do Enabled := PRN_MD;
  with BTNQUT do Enabled := QUT_MD;
END;

//加载按钮图形
FUNCTION BTN_LOADBMPFILE(BTNINS,BTNUPD,BTNDEL,BTNYES,BTNCAL,BTNSER,BTNPRN,BTNQUT: TSpeedButton;
                         INS_TB,UPD_TB,DEL_TB,YES_TB,CAL_TB,SER_TB,PRN_TB,QUT_TB: TBitmap):Boolean;
BEGIN
  RESULT:= TRUE;
  with BTNINS do Glyph := INS_TB;
  with BTNUPD do Glyph := UPD_TB;
  with BTNDEL do Glyph := DEL_TB;
  with BTNYES do Glyph := YES_TB;
  with BTNCAL do Glyph := CAL_TB;
  with BTNSER do Glyph := SER_TB;
  with BTNPRN do Glyph := PRN_TB;
  with BTNQUT do Glyph := QUT_TB;
END;

FUNCTION BTN_LOADBMPFILE_BITBTN(BTNNAME: TBITBTN;FILENAME: STRING):Boolean;
BEGIN
  RESULT:= TRUE;
  IF BTNNAME.Glyph.Empty  = TRUE THEN
  IF FileExists(FILENAME) = TRUE THEN BTNNAME.Glyph.LoadFromFile(FILENAME);
END;


FUNCTION BTN_LOADBMPSTREAM_BITBTN(BTNNAME: TBITBTN; T_STREAM: TBitmap):Boolean;
BEGIN
  RESULT:= TRUE;
  IF BTNNAME.Glyph.Empty  = TRUE THEN with BTNNAME do Glyph := T_STREAM;
END;


FUNCTION GRID_DRAWCOLUMNCELL(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState;True_bmp, False_bmp, Blank_bmp : TBitmap):boolean;
var X,Y ,N: Integer;
BEGIN
  RESULT:= TRUE;
  WITH SENDER AS TDBGRID DO
    BEGIN
    FOR N := 0 TO datasource.DataSet.FieldCount -1 DO
       BEGIN
       IF datasource.DataSet.Fields[N].DataType = ftBoolean THEN
          BEGIN
          if (Column.Field.DisplayText = 'True' ) then
             BEGIN
             Canvas.StretchDraw(Rect, blank_bmp);
             X := ( Rect.Right  - Rect.Left - TRUE_BMP.Width  ) div 2;
             Y := ( Rect.Bottom - Rect.Top  - TRUE_BMP.Height ) div 2;
             Canvas.Draw(Rect.Left + x, Rect.Top + y, TRUE_BMP);
             END;
          if (Column.Field.DisplayText = 'False' ) then
             BEGIN
             Canvas.StretchDraw(Rect, blank_bmp);
             X := ( Rect.Right  - Rect.Left - TRUE_BMP.Width  ) div 2;
             Y := ( Rect.Bottom - Rect.Top  - TRUE_BMP.Height ) div 2;
             Canvas.Draw(Rect.Left + x, Rect.Top + y, FALSE_BMP);
             END;
          END;    // IF 
       END;   // FOR
    END;   // WITH
END;


//检查FORM 是否存在
FUNCTION FormExists(FORM_NAME:STRING):BOOLEAN;
BEGIN
  IF Application.FindComponent(FORM_NAME)=nil then RESULT := FALSE ELSE RESULT := TRUE;
END;

// FORM 释放内存
FUNCTION FormRelease(T_FORM:TFORM):BOOLEAN;
BEGIN
  IF Application.FindComponent(T_FORM.Name) <> nil then
  IF FormExists(T_FORM.Name)=TRUE THEN
     BEGIN
     T_FORM.Release;
     RESULT := TRUE;
     END ELSE RESULT := FALSE;
END;

FUNCTION FormFREE(T_FORM:STRING):BOOLEAN;
BEGIN
  IF Application.FindComponent(T_FORM) <> nil then
     BEGIN
     Application.FindComponent(T_FORM).FREE;
     RESULT := TRUE;
     END ELSE RESULT := FALSE;
END;

FUNCTION DataModuleRelease(T_FORM:TDataModule):BOOLEAN;
BEGIN
  IF Application.FindComponent(T_FORM.Name)<>nil then
     BEGIN
     T_FORM.FREE;
     RESULT := TRUE;
     END ELSE RESULT := FALSE;
END;




FUNCTION Form_MDI_POSITION(T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
BEGIN
  WITH T_FORM AS TFORM DO
     BEGIN
     WINDOWSTATE:=wsNormal;
     POSITION:=poScreenCenter;
     FORMSTYLE:=FSMDICHILD;
     IF X >= 0 THEN LEFT := X; IF Y >=0 THEN TOP := Y;
     RESULT := TRUE;
     END;
END;

FUNCTION Form_MDI_SHOWMODAL(T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
BEGIN
  WITH T_FORM AS TFORM DO
     BEGIN
     WINDOWSTATE:=wsNormal;
     POSITION:=poScreenCenter;
     FORMSTYLE:=FSMDICHILD;
     Visible := FALSE;
     SHOWMODAL;
     IF X >= 0 THEN LEFT := X; IF Y >=0 THEN TOP := Y;
     RESULT := TRUE;
     END;
END;

FUNCTION Form_MDI_SHOW(T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
BEGIN
  WITH T_FORM AS TFORM DO
     BEGIN
     WINDOWSTATE:=wsNormal;
     POSITION:=poScreenCenter;
     FORMSTYLE:=FSMDICHILD;
     Visible := FALSE;
     SHOW;
     IF X >= 0 THEN LEFT := X; IF Y >=0 THEN TOP := Y;
     RESULT := TRUE;
     END;
END;

FUNCTION Form_NORMAL_SHOW  (T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
BEGIN
  WITH T_FORM AS TFORM DO
     BEGIN
     WINDOWSTATE:=wsNormal;
     POSITION:=poScreenCenter;
     FORMSTYLE:=FSNORMAL;
     IF X >= 0 THEN LEFT := X; IF Y >=0 THEN TOP := Y;
     SHOW;
     RESULT := TRUE;
     END;
END;

FUNCTION Form_NORMAL_SHOWMODAL(T_FORM:TFORM;X,Y:INTEGER):BOOLEAN;
BEGIN
  WITH T_FORM AS TFORM DO
     BEGIN
     WINDOWSTATE:=wsNormal;
     POSITION:=poScreenCenter;
     FORMSTYLE:=FSNormal;
     Visible := FALSE;
     SHOWMODAL;
     IF X >= 0 THEN LEFT := X; IF Y >=0 THEN TOP := Y;
     RESULT := TRUE;
     END;
END;




//数据库类 =====================================================================

//检查 是否为空字段
FUNCTION FM_CHECK_FIELD_BLANK(F_VALUE,F_NAME,F_MESSAGE : STRING):boolean;
BEGIN
  IF TRIM(F_VALUE) = '' THEN
     BEGIN
     IF F_MESSAGE <> '' THEN SHOWMESSAGE(F_MESSAGE);
     RESULT := FALSE;
     END ELSE RESULT := TRUE;
END;

//更新数据库 POST
FUNCTION FM_DB_QUERY_POST(T_DATABASE:TDATABASE;T_QUERY:TQUERY):boolean;
BEGIN
  try
    WITH T_QUERY    AS TQUERY    DO Post;
    WITH T_DATABASE AS TDATABASE DO STARTTRANSACTION;
    WITH T_QUERY    AS TQUERY    DO ApplyUpdates;
    WITH T_QUERY    AS TQUERY    DO CommitUpdates;
    WITH T_DATABASE AS TDATABASE DO COMMIT;
    RESULT := TRUE;
  EXCEPT
    WITH T_DATABASE AS TDATABASE DO ROLLBACK;
    WITH T_QUERY    AS TQUERY    DO CANCELUpdates;
    SHOWMESSAGE('存盘失败!');
    RESULT := FALSE;
  END;
END;

FUNCTION FM_DB_QUERY_UPDATE(T_DATABASE:TDATABASE;T_QUERY:TQUERY):boolean;
BEGIN
  try
    WITH T_DATABASE AS TDATABASE DO STARTTRANSACTION;
    WITH T_QUERY    AS TQUERY    DO ApplyUpdates;
    WITH T_QUERY    AS TQUERY    DO CommitUpdates;
    WITH T_DATABASE AS TDATABASE DO COMMIT;
    RESULT := TRUE;
  EXCEPT
    WITH T_DATABASE AS TDATABASE DO ROLLBACK;
    WITH T_QUERY    AS TQUERY    DO CANCELUpdates;
    SHOWMESSAGE('存盘失败!');
    RESULT := FALSE;
  END;
END;








FUNCTION REGISTER_NUMBER_POS(CPU_ID:LONGINT):STRING;
VAR T_REG:LONGINT;
BEGIN
 T_REG  := (((CPU_ID *2) +4) *6)+8         ;
 RESULT := COPY_R(INTTOSTR(T_REG),1,8);
END;

FUNCTION REGISTER_NUMBER_WHOUSE(CPU_ID:LONGINT):STRING;
VAR T_REG:LONGINT;
BEGIN
 T_REG  := (((CPU_ID *5) +3) *4)-2    ;
 RESULT := COPY_R(INTTOSTR(T_REG),1,8);
END;










FUNCTION REGISTER_POS_CREATE(T_REG_NAME:STRING):BOOLEAN;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    IF Reg.OpenKey(T_REG_NAME,True) then
       BEGIN
       Reg.WriteDate   ('RUN_FIRST_DATE',DATE);
       Reg.WriteInteger('CPU_ID'        ,GetCPUID[4]);
       Reg.WriteString ('SF_ID'         ,'');
       RESULT := TRUE;
       END ELSE RESULT := FALSE;
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_POS_REGISTER(T_REG_NAME, T_SF_ID:STRING):BOOLEAN;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    IF Reg.OpenKey(T_REG_NAME,True) then
       BEGIN
       Reg.WriteString ('SF_ID' ,T_SF_ID);
       RESULT := TRUE;
       END ELSE RESULT := FALSE;
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_KEY_VALUE_STR (T_REG_NAME, T_KEY:STRING):STRING;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    IF Reg.OpenKey(T_REG_NAME,True) then RESULT := Reg.ReadString (T_KEY);
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_KEY_VALUE_DATE(T_REG_NAME, T_KEY:STRING):TDATE;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    IF Reg.OpenKey(T_REG_NAME,True) then RESULT := Reg.ReadDate (T_KEY);
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_KEY_CHECK(T_REG_NAME:STRING):BOOLEAN;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    RESULT := Reg.KeyExists( T_REG_NAME );
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_KEY_CREATE(T_REG_NAME:STRING):BOOLEAN;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey( T_REG_NAME ,True);
    RESULT := TRUE;
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_KEY_DELETE(T_REG_NAME:STRING):BOOLEAN;
var REG: TRegistry;
BEGIN
  REG := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.DeleteKey( T_REG_NAME );
    RESULT := TRUE;
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;
















FUNCTION REGISTER_SAVE_OBJECT_INT(T_REG_NAME:STRING;T_KEY:INTEGER):BOOLEAN;
VAR REG: TRegistry;
BEGIN
  RESULT      := FALSE;
  REG         := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  TRY
    IF Reg.OpenKey(T_REG_NAME,True) THEN
       BEGIN
       Reg.WriteInteger(T_REG_NAME, T_KEY);
       RESULT := TRUE;
       END;
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_SAVE_OBJECT_STR(T_REG_NAME:STRING;T_KEY:STRING ):BOOLEAN;
VAR REG: TRegistry;
BEGIN
  RESULT      := FALSE;
  REG         := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  TRY
    IF Reg.OpenKey(T_REG_NAME,True) THEN
       BEGIN
       Reg.WriteString(T_REG_NAME, T_KEY);
       RESULT := TRUE;
       END;
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;










FUNCTION REGISTER_LOAD_OBJECT_INT(T_REG_NAME:STRING;T_DEFAULT:INTEGER):INTEGER;
VAR REG: TRegistry;
BEGIN
  RESULT      := T_DEFAULT;
  REG         := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  TRY
    IF Reg.KeyExists(T_REG_NAME)=False THEN
       BEGIN
       Reg.OpenKey(T_REG_NAME,True);
       Reg.WriteInteger(T_REG_NAME, T_DEFAULT);
       Reg.CloseKey;
       END;
    IF Reg.OpenKey(T_REG_NAME,True)    THEN RESULT := Reg.ReadInteger(T_REG_NAME);
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;

FUNCTION REGISTER_LOAD_OBJECT_STR(T_REG_NAME:STRING;T_DEFAULT:STRING ):STRING;
VAR REG: TRegistry;
BEGIN
  RESULT      := T_DEFAULT;
  REG         := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  TRY
    IF Reg.KeyExists(T_REG_NAME)=False THEN
       BEGIN
       Reg.OpenKey(T_REG_NAME,True);
       Reg.WriteString(T_REG_NAME, T_DEFAULT);
       Reg.CloseKey;
       END;
    IF Reg.OpenKey(T_REG_NAME,True)    THEN RESULT := Reg.ReadString(T_REG_NAME);
  FINALLY
    Reg.CloseKey;
    Reg.Free;
  END;
END;














end.
