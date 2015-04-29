unit JEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls,
  SYSSTR, JEDITM, JEDITL;


type
  TEDITtype = (EDIT,EDATE_EDIT,CDATE_EDIT,TIME_EDIT,INTEGER_EDIT,FLOAT_EDIT);
  TSHOWCAL  = (NONE,CCAL,LCAL,ECAL);

  TJEdit = class(TEdit)
  private
    FDigits : byte;
    FMin,FMax    : extended;
    fdec         : char;
    Fertext      : string;
    foldval      : extended;

    FEDITtype: TEDITType;
    FSHOWCAL : TSHOWCAL;
    FBADINPUT: BOOLEAN;
    FLONGTIME: BOOLEAN;
//    FVALUE   : EXTENDED;
//    FOnExit       : TNotifyEvent;
  protected
    procedure setvalue(Newvalue : extended);
    function  getvalue : extended;
    procedure setdigits(Newvalue : byte);
    procedure setmin(Newvalue : extended);
    procedure setmax(Newvalue : extended);
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUP(var Key: Word; Shift: TShiftState); override;
  public
    FUNCTION  CALL_FMSTR():STRING;
    procedure doEnter;override;
    procedure DoExit; override;
    constructor create (aowner : TComponent);override;
    destructor Destroy; override;
  published
    property Digits   : byte read FDigits write setDigits;
    property Value    : extended read getvalue write setValue;
    property Min : extended read Fmin write setMin;
    property Max : extended read Fmax write setmax;

    property _EditType: TEDITType read FEDITType write FEDITType;
    property _SHOWCAL : TSHOWCAL  read FSHOWCAL  write FSHOWCAL;
    property _BADINPUT: BOOLEAN  read FBADINPUT  write FBADINPUT;
    property _LONGTIME: BOOLEAN  read FLONGTIME  write FLONGTIME;
//    property OnExit : TNotifyEvent read FOnExit  write FOnExit;
  end;


  TJDBEdit = class(TDBEdit)
  private
    FEDITtype: TEDITType;
    FSHOWCAL : TSHOWCAL;
//    FOnExit       : TNotifyEvent;
  protected
    PROCEDURE CHANGE; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUP(var Key: Word; Shift: TShiftState); override;
  public
    FUNCTION  CALL_FMSTR():STRING;
    procedure doEnter;override;
    procedure DoExit; override;
    constructor create (aowner : TComponent);override;
    destructor Destroy; override;
  published
    property _EditType: TEDITType read FEDITType write FEDITType;
    property _SHOWCAL : TSHOWCAL  read FSHOWCAL  write FSHOWCAL;
//    property OnExit : TNotifyEvent read FOnExit  write FOnExit;
  end;

const
    notext       = '[No Text]';

    LB_MESSAGE_EDATE_EDIT = '������Ӣ�����ڸ�ʽ'+#10#13+
                            '��: 1995/3/2      '+#10#13+
                            '��: 2001/10/25    '+#10#13;
    LB_MESSAGE_CDATE_EDIT = '�������������ڸ�ʽ'+#10#13+
//                            '��:  89-03-02  ��8λ'+#10#13+
                            '��: 1999-01-25 ��10λ'+#10#13;
    LB_MESSAGE_TIME_EDIT  = '������ʱ���ʽ    '+#10#13+
                            '��:  08:25   ��5λ'+#10#13+
                            '��:  21:15   ��5λ'+#10#13;
    LB_MESSAGE_INTEGER_EDIT = '������������ʽ  '+#10#13+
                            '��:  100086       '+#10#13+
                            '��:      25       '+#10#13;
    LB_MESSAGE_FLOAT_EDIT = '�����뺬С����ʽ  '+#10#13+
                            '��:  25.562       '+#10#13+
                            '��: 85216.5       '+#10#13;

procedure Register;

implementation

uses un_utl, FM_UTL;

procedure Register;
begin
  RegisterComponents('J_STD', [TJEdit]);
  RegisterComponents('J_STD', [TJDBEdit]);
end;

//==================================================================
// EDIT= EDIT= EDIT= EDIT= EDIT= EDIT= EDIT= EDIT= EDIT= EDIT= EDIT=
//==================================================================
procedure TJedit.setvalue(Newvalue : extended);
var tmp : string;
begin
        if newvalue > fmax then begin
           if fertext <> notext then showmessage(fertext);
           newvalue := fmax;
        end;
        if newvalue < fmin then begin
           if fertext <> notext then showmessage(fertext);
           newvalue := fmin;
        end;
        tmp := floattostrf(newvalue,fffixed,18,fdigits);
        text:=tmp;
end;

function TJedit.getvalue : extended;
var ts : string;
begin
        IF _EDITTYPE = FLOAT_EDIT THEN
        IF CHECK_FLOATINT(TEXT) = FALSE THEN TEXT:= '0';

        ts := text;
        if (ts = '-') or (ts = fdec) or (ts = '') then ts := '0';
        try
           result := strtofloat(ts);
        except
           //if fertext <> notext then showmessage(fertext);
           result := fmin;
        end;
        if result < fmin then begin
           //if fertext <> notext then showmessage(fertext);
           result := fmin;
        end;
        if result > fmax then begin
           //if fertext <> notext then showmessage(fertext);
           result := fmax;
        end;
end;

procedure TJEDIT.setdigits;
begin
     if fdigits <> newValue then begin
        if newvalue > 18 then newvalue := 18;
        fdigits := newvalue;
        setvalue(getvalue);
     end;
end;

procedure TJEDIT.setmin;
begin
     if fmin <> newValue then begin
        if fmin > fmax then begin
	   showmessage('Min-Value has to be less than or equal to Max-Value !');
           newvalue := fmax;
	end;
	fmin := newvalue;
        setvalue(getvalue);
     end;
end;
procedure TJEDIT.setmax;
begin
     if fmax <> newValue then begin
        if fmin > fmax then begin
	   showmessage('Max-Value has to be greater than or equal to Min-Value !');
           newvalue := fmin;
	end;	
        fmax := newvalue;
        setvalue(getvalue);
     end;
end;

constructor TJEdit.create (aowner : TComponent);
begin
     inherited create(aowner);
     _EDITTYPE := EDIT;

     fdec := decimalseparator;
     fdigits := 1;
     fmin := 0;
     fmax := 999999999;
     fertext := notext;
     _BADINPUT := FALSE;
     _LONGTIME := FALSE;

     IF FormExists('FMEDITM' )=FALSE THEN
        BEGIN
        Application.CreateForm(TFMEDITM,  FMEDITM );
        FMEDITM.Left := SCREEN.Width  +1000;
        FMEDITM.Top  := SCREEN.Height +1000;
        FMEDITM.SHOW;
        END;
     IF FormExists('FMEDITL' )=FALSE THEN
        BEGIN
        Application.CreateForm(TFMEDITL,  FMEDITL );
        FMEDITL.Left := SCREEN.Width  +1000;
        FMEDITL.Top  := SCREEN.Height +1000;
        FMEDITL.SHOW;
        END;
end;

destructor TJedit.Destroy;
begin
// ���� MESSAGE ����
IF FormExists('FMEDITM' )=TRUE THEN
   BEGIN
   FMEDITM.Left := SCREEN.Width  +1000;
   FMEDITM.Top  := SCREEN.Height +1000;
   END;
// ���� MESSAGE ����
IF FormExists('FMEDITL' )=TRUE THEN
   BEGIN
   FMEDITL.Left := SCREEN.Width  +1000;
   FMEDITL.Top  := SCREEN.Height +1000;
   END;
  inherited Destroy;
end;

procedure TJedit.doenter;
begin
  IF _EDITTYPE = FLOAT_EDIT THEN foldval:=getvalue;


  IF _EDITTYPE = EDATE_EDIT   THEN FMEDITM.Label1.Caption := LB_MESSAGE_EDATE_EDIT;
  IF _EDITTYPE = CDATE_EDIT   THEN FMEDITM.Label1.Caption := LB_MESSAGE_CDATE_EDIT;
  IF _EDITTYPE = TIME_EDIT    THEN FMEDITM.Label1.Caption := LB_MESSAGE_TIME_EDIT;
  IF _EDITTYPE = INTEGER_EDIT THEN FMEDITM.Label1.Caption := LB_MESSAGE_INTEGER_EDIT;
  IF _EDITTYPE = FLOAT_EDIT   THEN FMEDITM.Label1.Caption := LB_MESSAGE_FLOAT_EDIT;


// ���� MESSAGE ����
IF _EDITTYPE <> EDIT THEN
  BEGIN
  FMEDITM.Left := SCREEN.Width  - FMEDITM.Width;
  FMEDITM.Top  := SCREEN.Height - FMEDITM.Height;
  SETFOCUS;
  END;
// ���� MESSAGE ����
IF _EDITTYPE = CDATE_EDIT THEN
IF _SHOWCAL  <> NONE      THEN
  BEGIN
  FMEDITL.Left := 0;
  FMEDITL.Top  := SCREEN.Height - FMEDITL.Height;
  SETFOCUS;
  END;

  inherited;
end;

procedure TJedit.DoExit;
VAR //T_STR:STRING;
    ts : string;
    result:extended;
BEGIN
inherited;

// ���� MESSAGE ����
   FMEDITM.Left := SCREEN.Width  +1000;
   FMEDITM.Top  := SCREEN.Height +1000;
// ���� MESSAGE ����
   FMEDITL.Left := SCREEN.Width  +1000;
   FMEDITL.Top  := SCREEN.Height +1000;

  //�հ�����
  IF TRIM(TEXT) = '' THEN EXIT;

  IF _EDITTYPE = EDATE_EDIT THEN
     IF CHECK_EDATE(TEXT,_BADINPUT) = FALSE THEN
        BEGIN
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = CDATE_EDIT THEN
     IF CHECK_CDATE(TEXT,_BADINPUT) = FALSE THEN
        BEGIN
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;


  IF _EDITTYPE = TIME_EDIT THEN
     IF CHECK_TIME(TEXT,_BADINPUT) = FALSE THEN
     IF (_LONGTIME=TRUE) AND CHECK_LONGTIME(TEXT,_BADINPUT) = FALSE THEN
        BEGIN
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = INTEGER_EDIT THEN
     IF CHECK_INT  (TEXT)=FALSE THEN
        BEGIN
        SHOWMESSAGE('������ʽ����,����������!');
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = FLOAT_EDIT THEN
     IF CHECK_FLOATINT(TEXT)=FALSE THEN
        BEGIN
        SHOWMESSAGE('��������ʽ����,����������!');
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = FLOAT_EDIT THEN
     BEGIN
        ts := text;
        try
           result := strtofloat(ts);
        except
           if fertext <> notext then showmessage(fertext);
           setvalue(foldval);
           selectall;
           setfocus;
           exit;
        end;
        if (result < fmin) or (result > fmax) then begin
           if fertext <> notext then showmessage(fertext);
           setvalue(foldval);
           selectall;
           setfocus;
           exit;
        end;
        text := floattostrf(result,fffixed,18,fdigits);
        value:=strtofloat(text);
     END;   
END;

FUNCTION TJEdit.CALL_FMSTR():STRING;
BEGIN
   IF Application.FindComponent('FMSTR')=nil then Application.CreateForm(TFMSTR, FMSTR );
   FMSTR.Left := SCREEN.Width - FMSTR.Width;
   FMSTR.SHOWMODAL;
   RESULT := FMSTR.RETURN_STR;
END;

procedure TJEDIT.keypress;
var    ts           : string;
//       result           : extended;
begin
  IF _EDITTYPE = FLOAT_EDIT THEN
     BEGIN
     if key = #27 then begin
        setvalue(foldval);
        selectall;
        inherited;
        exit;
     end;
     if key < #32 then begin
        inherited;
        exit;
     end;
        ts := copy(text,1,selstart)+copy(text,selstart+sellength+1,500);
     if (key <'0') or (key > '9') then if (key <> fdec) and (key <> '-') then begin
        inherited;
        key := #0;
        exit;
     end;
     if key = fdec then if pos(fdec,ts) <> 0 then begin
        inherited;
        key := #0;
        exit;
     end;
     if key = '-' then if pos('-',ts) <> 0 then begin
        inherited;
        key := #0;
        exit;
     end;
     if key = '-' then if fmin >= 0 then begin
        inherited;
        key := #0;
        exit;
     end;
     if key = fdec then if fdigits = 0 then begin
        inherited;
        key := #0;
        exit;
     end;
     // seltext durch key ersetzen
        ts := copy(text,1,selstart)+key+copy(text,selstart+sellength+1,500);
     // ��erpr��en, ob g��tiger wert;
     if key > #32 then if pos(fdec,ts)<> 0 then begin
        if length(ts)-pos(fdec,ts) > fdigits then begin
           inherited;
           key := #0;
           exit;
        end;
     end;
     if key = '-' then if pos('-',ts) <> 1 then begin
        inherited;
        key := #0;
        exit;
     end;

     if ts ='' then begin
        inherited;key := #0;
        text := floattostrf(fmin,fffixed,18,fdigits);selectall;
        exit;
     end;
     if ts = '-' then begin
        inherited;key:=#0;
        text := '-0';selstart := 1;sellength:=1;
        exit;
     end;
     if ts = fdec then begin
        inherited;key:=#0;
        text := '0'+fdec+'0';
        selstart :=2;
        sellength:=1;
        exit;
     end;
     END;
     inherited;
end;



procedure TJEdit.KeyDown(var Key: Word; Shift: TShiftState);
//var  iSelStart, iSelStop: integer;
begin

// F12 ���� �����ֹ���
IF KEY = 123 THEN
   BEGIN
   TEXT := TEXT + CALL_FMSTR;
   SelStart  := length(TEXT)+1;
   END;

  case Key of
//    vk_Escape: Reset;  // ��Esc ��ʱ, ���ݻ�ԭ
//    13,
    vk_Down: // ���¼�
      begin
        // �ͳ� WM_NEXTDLGCTL ��Ϣ, ����һ���ؼ�ȡ�ü��̽���
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
          Key := 0;
      end;
    vk_Up: // ���ϼ�
      begin
        // ע��: �������Ա�����Ϊ��ʱ, focus ��������һ���ؼ�
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
          Key := 0;
      end;
{    vk_Right: // ��
      begin
//        GetSelection(iSelStart, iSelStop);
        // ��������ұ߽��԰����Ҽ�, ������һ���ؼ�
        if (iSelStart = iSelStop) and (iSelStop = GetTextLen) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
          Key := 0;
        end;
      end;
    vk_Left: // ��
      begin
//        GetSelection(iSelStart, iSelStop);
        // ���������߽��԰������, ������һ���ؼ�
        if (iSelStart = iSelStop) and (iSelStart = 0) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
          Key := 0;
        end;
      end;}
  end;

  if Key <> 0 then inherited KeyDown(Key, Shift);


//  IF _EDITTYPE = INTEGER_EDIT THEN VALUE  := STRTOINTDEF(TEXT,0);
  IF _EDITTYPE = FLOAT_EDIT THEN
     BEGIN
     IF CHECK_FLOATINT(TEXT) = TRUE THEN VALUE  := STRTOFLOAT(TEXT)
                                    ELSE VALUE  := 0;
     END;

end; { TCEdit.KeyDown }

procedure TJEdit.KeyUP(var Key: Word; Shift: TShiftState);
var T_YEAR : INTEGER;
begin
  IF (_EDITTYPE = CDATE_EDIT)AND
     ((LENGTH(TEXT)=6)OR(LENGTH(TEXT)=7))AND(STRTOINTDEF(TEXT,-1)>0) THEN
     IF CHECK_CDATE(TEXT,_BADINPUT) = TRUE THEN
        BEGIN
        T_YEAR := STRTOINTDEF( DATE_GET_YEAR(CDATE_TO_EDATE(TEXT)), 1988);
        IF (T_YEAR > 1911) AND (T_YEAR < 2030) THEN
        FMEDITL.CLCal1.CalendarDate := STRTODATE(CDATE_TO_EDATE(TEXT));
        FMEDITL.CLCal1.CalendarDate := STRTODATE(CDATE_TO_EDATE(TEXT));
        END;

inherited;
end;




//==================================================================
// DBEDIT= DBEDIT= DBEDIT= DBEDIT= DBEDIT= DBEDIT= DBEDIT= DBEDIT= DBEDIT=
//==================================================================
constructor TJDBEdit.create (aowner : TComponent);
begin
     inherited create(aowner);
     _EDITTYPE := EDIT;

     IF FormExists('FMEDITM' )=FALSE THEN
        BEGIN
        Application.CreateForm(TFMEDITM,  FMEDITM );
        FMEDITM.Left := SCREEN.Width  +1000;
        FMEDITM.Top  := SCREEN.Height +1000;
        FMEDITM.SHOW;
        END;
     IF FormExists('FMEDITL' )=FALSE THEN
        BEGIN
        Application.CreateForm(TFMEDITL,  FMEDITL );
        FMEDITL.Left := SCREEN.Width  +1000;
        FMEDITL.Top  := SCREEN.Height +1000;
        FMEDITL.SHOW;
        END;
end;

destructor TJDBedit.Destroy;
begin
// ���� MESSAGE ����
IF FormExists('FMEDITM' )=TRUE THEN
   BEGIN
   FMEDITM.Left := SCREEN.Width  +1000;
   FMEDITM.Top  := SCREEN.Height +1000;
   END;
// ���� MESSAGE ����
IF FormExists('FMEDITL' )=TRUE THEN
   BEGIN
   FMEDITL.Left := SCREEN.Width  +1000;
   FMEDITL.Top  := SCREEN.Height +1000;
   END;
  inherited Destroy;
end;

procedure TJDBedit.doenter;
begin
  IF _EDITTYPE = EDATE_EDIT   THEN FMEDITM.Label1.Caption := LB_MESSAGE_EDATE_EDIT;
  IF _EDITTYPE = CDATE_EDIT   THEN FMEDITM.Label1.Caption := LB_MESSAGE_CDATE_EDIT;
  IF _EDITTYPE = TIME_EDIT    THEN FMEDITM.Label1.Caption := LB_MESSAGE_TIME_EDIT;
  IF _EDITTYPE = INTEGER_EDIT THEN FMEDITM.Label1.Caption := LB_MESSAGE_INTEGER_EDIT;
  IF _EDITTYPE = FLOAT_EDIT   THEN FMEDITM.Label1.Caption := LB_MESSAGE_FLOAT_EDIT;

// ���� MESSAGE ����
IF _EDITTYPE <> EDIT THEN
  BEGIN
  FMEDITM.Left := SCREEN.Width  - FMEDITM.Width;
  FMEDITM.Top  := SCREEN.Height - FMEDITM.Height;
  SETFOCUS;
  END;
// ���� MESSAGE ����
IF _EDITTYPE = CDATE_EDIT THEN
IF _SHOWCAL  <> NONE      THEN
  BEGIN
  FMEDITL.Left := 0;
  FMEDITL.Top  := SCREEN.Height - FMEDITL.Height;
  SETFOCUS;
  END;
  inherited;
end;

procedure TJDBEdit.DoExit;
BEGIN
inherited;

// ���� MESSAGE ����
   FMEDITM.Left := SCREEN.Width  +1000;
   FMEDITM.Top  := SCREEN.Height +1000;
// ���� MESSAGE ����
   FMEDITL.Left := SCREEN.Width  +1000;
   FMEDITL.Top  := SCREEN.Height +1000;

  //�հ�����
  IF TRIM(TEXT) = '' THEN EXIT;

  IF _EDITTYPE = EDATE_EDIT THEN
     IF CHECK_EDATE(TEXT,FALSE) = FALSE THEN
        BEGIN
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = CDATE_EDIT THEN
     IF CHECK_CDATE(TEXT,FALSE) = FALSE THEN
        BEGIN
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = TIME_EDIT THEN
     IF CHECK_TIME(TEXT,FALSE) = FALSE THEN
        BEGIN
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;

  IF _EDITTYPE = INTEGER_EDIT THEN
     IF STRTOINTDEF(TEXT,-1) < 0 THEN
        BEGIN
        SHOWMESSAGE('������ʽ����,����������!');
        IF (ENABLED=TRUE)AND(VISIBLE=TRUE) THEN SETFOCUS;
        EXIT;
        END;


END;



PROCEDURE TJDBEDIT.CHANGE;
begin
  inherited;
//     SHOWMESSAGE(TEXT+'='+Field.AsString);

//  CHECK_CDATE(TEXT,false);
  IF (Modified = TRUE ) THEN
     BEGIN
     IF (_EDITTYPE = CDATE_EDIT ) AND (CHECK_CDATE(TEXT,FALSE) = TRUE) THEN
        BEGIN
        FIELD.ASSTRING := TEXT;
//        FIELD.ASSTRING := CDATE_TO_EDATE(TEXT);
        SelStart := LENGTH(TEXT);
        END;
     END ELSE  BEGIN
     IF (_EDITTYPE = CDATE_EDIT ) AND (CHECK_EDATE(TEXT,FALSE) = TRUE) THEN
        BEGIN
        TEXT := EDATE_TO_CDATE(Field.AsString);
        END;
     END;

end;

FUNCTION TJDBEdit.CALL_FMSTR():STRING;
BEGIN
   IF Application.FindComponent('FMSTR')=nil then Application.CreateForm(TFMSTR, FMSTR );
   FMSTR.Left := SCREEN.Width - FMSTR.Width;
   FMSTR.SHOWMODAL;
   RESULT := FMSTR.RETURN_STR;
END;


procedure TJDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
//var iSelStart, iSelStop: integer;
begin
// F12 ���� �����ֹ���
IF KEY = 123 THEN
   BEGIN
   TEXT := TEXT + CALL_FMSTR;
   SelStart  := length(TEXT)+1;
   END;

  case Key of
//    vk_Escape: Reset;  // ��Esc ��ʱ, ���ݻ�ԭ
//    13,
    vk_Down: // ���¼�
      begin
        // �ͳ� WM_NEXTDLGCTL ��Ϣ, ����һ���ؼ�ȡ�ü��̽���
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
          Key := 0;
      end;
    vk_Up: // ���ϼ�
      begin
        // ע��: �������Ա�����Ϊ��ʱ, focus ��������һ���ؼ�
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
          Key := 0;
      end;
{    vk_Right: // ��
      begin
//        GetSelection(iSelStart, iSelStop);
        // ��������ұ߽��԰����Ҽ�, ������һ���ؼ�
        if (iSelStart = iSelStop) and (iSelStop = GetTextLen) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
          Key := 0;
        end;
      end;
    vk_Left: // ��
      begin
//        GetSelection(iSelStart, iSelStop);
        // ���������߽��԰������, ������һ���ؼ�
        if (iSelStart = iSelStop) and (iSelStart = 0) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
          Key := 0;
        end;
      end;}
  end;

  if Key <> 0 then inherited KeyDown(Key, Shift);
end; { TCEdit.KeyDown }


procedure TJDBEdit.KeyUP(var Key: Word; Shift: TShiftState);
var T_YEAR : INTEGER;
begin
  IF (_EDITTYPE = CDATE_EDIT)AND
     ((LENGTH(TEXT)=10))
     //AND(STRTOINTDEF(TEXT,-1)>0)
     THEN
     IF CHECK_CDATE(TEXT,FALSE) = TRUE THEN
        BEGIN
        T_YEAR := STRTOINTDEF( DATE_GET_YEAR(CDATE_TO_EDATE(TEXT)), 1988);
        IF (T_YEAR > 1911) AND (T_YEAR < 2030) THEN
        FMEDITL.CLCal1.CalendarDate := STRTODATE(CDATE_TO_EDATE(TEXT));
        FMEDITL.CLCal1.CalendarDate := STRTODATE(CDATE_TO_EDATE(TEXT));
        END;

inherited;
end;




//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================




end.
