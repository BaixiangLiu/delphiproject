unit URCOLLECT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Spin, Mask, Menus;

type
  TFRCOLLECT = class(TForm)
    PageControl: TPageControl;
    PAGE_A: TTabSheet;
    ED_PORT: TRadioGroup;
    ED_POWERSAVING: TCheckBox;
    Label2: TLabel;
    BTNQUT: TBitBtn;
    TabSheet2: TTabSheet;
    P_TEST_WARM_START: TBitBtn;
    ED_ADDRESS: TMaskEdit;
    Label11: TLabel;
    ED_TIMEOUT: TSpinEdit;
    ED_BAUDRATE: TRadioGroup;
    ED_DATABIT: TRadioGroup;
    ED_STOPBIT: TRadioGroup;
    ED_PARITY: TRadioGroup;
    ED_LOGFILE: TRadioGroup;
    Label1: TLabel;
    ED_ESCDELAY: TSpinEdit;
    Label3: TLabel;
    ED_NAKDELAY: TSpinEdit;
    BTNESC: TBitBtn;
    Label4: TLabel;
    ED_FORMNAME: TMaskEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ED_SOURCENAME: TMaskEdit;
    Label5: TLabel;
    MainMenu: TMainMenu;
    N5: TMenuItem;
    GroupBox1: TGroupBox;
    Memo: TMemo;
    procedure BTNQUTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BTNESCClick(Sender: TObject);
    procedure P_TEST_WARM_STARTClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


   // ϵͳ����
   PROCEDURE COLLECT_CHANGE_VARIABLE;
   PROCEDURE COLLECT_OPEN_PORT;
   PROCEDURE COLLECT_READ_INI;
   PROCEDURE COLLECT_WRITE_INI;

   PROCEDURE COLLECT_Return_code(RET:INTEGER);
   FUNCTION  COLLECT_WARM_START: BOOLEAN;
   FUNCTION  COLLECT_COLD_START: BOOLEAN;
   FUNCTION  COLLECT_UP_LOAD   : BOOLEAN;


var
  FRCOLLECT: TFRCOLLECT;

  COLLECT_TF            :TEXTFILE;
  COLLECT_PORT          :INTEGER;   // ���ӿ�
  COLLECT_BAUDRATE      :INTEGER;   // ���Ӷ˿ڵĲ�����
  COLLECT_DATABIT       :INTEGER;   // ����λ
  COLLECT_STOPBIT       :INTEGER;   // ֹͣλ
  COLLECT_PARITY        :INTEGER;   // ��żУ��λ
  COLLECT_LOGFILE       :INTEGER;   // ������Ƿ�Ҫ��¼
  COLLECT_TIMEOUT       :INTEGER;   // ��ʱ
  COLLECT_ESCDELAY      :INTEGER;
  COLLECT_NAKDELAY      :INTEGER;
  COLLECT_ADDRESS       :STRING;    // �����ַ
  COLLECT_POWERSAVING   :BOOLEAN;   // �Ƿ�Ҫ�нڵ�ģʽ
  COLLECT_FORMNAME      :STRING;    // ������
  COLLECT_SOURCENAME    :STRING;    // Դ�ļ���


implementation

USES UN_UTL, FM_UTL, SYSINI;

{$R *.DFM}
{$i multipas.pas }



PROCEDURE COLLECT_CHANGE_VARIABLE;
BEGIN
  COLLECT_PORT        := FRCOLLECT.ED_PORT       .ItemIndex;
  COLLECT_BAUDRATE    := FRCOLLECT.ED_BAUDRATE   .ItemIndex;
  COLLECT_DATABIT     := FRCOLLECT.ED_DATABIT    .ItemIndex;
  COLLECT_STOPBIT     := FRCOLLECT.ED_STOPBIT    .ItemIndex;
  COLLECT_PARITY      := FRCOLLECT.ED_PARITY     .ItemIndex;
  COLLECT_LOGFILE     := FRCOLLECT.ED_LOGFILE    .ItemIndex;
  COLLECT_TIMEOUT     := FRCOLLECT.ED_TIMEOUT    .Value;
  COLLECT_ESCDELAY    := FRCOLLECT.ED_ESCDELAY   .Value;
  COLLECT_NAKDELAY    := FRCOLLECT.ED_NAKDELAY   .Value;
  COLLECT_ADDRESS     := FRCOLLECT.ED_ADDRESS    .TEXT;
  COLLECT_POWERSAVING := FRCOLLECT.ED_POWERSAVING.CHECKED;
  COLLECT_FORMNAME    := FRCOLLECT.ED_FORMNAME   .TEXT;
  COLLECT_SOURCENAME  := FRCOLLECT.ED_SOURCENAME .TEXT;
END;

PROCEDURE COLLECT_OPEN_PORT;
BEGIN
 HM_OpenCommPort (COLLECT_PORT, COLLECT_BAUDRATE, 8, 0, 1);
 HM_CloseCommPort(COLLECT_PORT);
END;

PROCEDURE COLLECT_READ_INI;
BEGIN
  IF FileExists(FILEPATH_COLLECT) = TRUE  THEN
     BEGIN
     COLLECT_PORT          := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_PORT'         ,0    );
     COLLECT_BAUDRATE      := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_BAUDRATE'     ,9    );
     COLLECT_DATABIT       := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_DATABIT'      ,1    );
     COLLECT_STOPBIT       := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_STOPBIT'      ,0    );
     COLLECT_PARITY        := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_PARITY'       ,0    );
     COLLECT_LOGFILE       := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_LOGFILE'      ,1    );
     COLLECT_TIMEOUT       := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_TIMEOUT'      ,400  );
     COLLECT_ESCDELAY      := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_ESCDELAY'     ,10   );
     COLLECT_NAKDELAY      := INI_LOAD_INT (FILEPATH_COLLECT,'COLLECT_NAKDELAY'     ,30   );
     COLLECT_ADDRESS       := INI_LOAD_STR (FILEPATH_COLLECT,'COLLECT_ADDRESS'      ,'A'  );
     COLLECT_POWERSAVING   := INI_LOAD_BOOL(FILEPATH_COLLECT,'COLLECT_POWERSAVING'  ,FALSE);
     COLLECT_FORMNAME      := INI_LOAD_STR (FILEPATH_COLLECT,'COLLECT_FORMNAME'     ,'FORM.DAT' );
     COLLECT_SOURCENAME    := INI_LOAD_STR (FILEPATH_COLLECT,'COLLECT_SOURCENAME'   ,'FORM.DAT' );
     IF FormExists('FRCOLLECT' )=TRUE THEN
        BEGIN
        FRCOLLECT.ED_PORT       .ItemIndex := COLLECT_PORT       ;
        FRCOLLECT.ED_BAUDRATE   .ItemIndex := COLLECT_BAUDRATE   ;
        FRCOLLECT.ED_DATABIT    .ItemIndex := COLLECT_DATABIT    ;
        FRCOLLECT.ED_STOPBIT    .ItemIndex := COLLECT_STOPBIT    ;
        FRCOLLECT.ED_PARITY     .ItemIndex := COLLECT_PARITY     ;
        FRCOLLECT.ED_LOGFILE    .ItemIndex := COLLECT_LOGFILE    ;
        FRCOLLECT.ED_TIMEOUT    .Value     := COLLECT_TIMEOUT    ;
        FRCOLLECT.ED_ESCDELAY   .Value     := COLLECT_ESCDELAY   ;
        FRCOLLECT.ED_NAKDELAY   .Value     := COLLECT_NAKDELAY   ;
        FRCOLLECT.ED_ADDRESS    .TEXT      := COLLECT_ADDRESS    ;
        FRCOLLECT.ED_POWERSAVING.CHECKED   := COLLECT_POWERSAVING;
        FRCOLLECT.ED_FORMNAME   .TEXT      := COLLECT_FORMNAME   ;
        FRCOLLECT.ED_SOURCENAME .TEXT      := COLLECT_SOURCENAME ;
        END;
    END;
END;

PROCEDURE COLLECT_WRITE_INI;
BEGIN
  IF FileExists(FILEPATH_COLLECT) = TRUE  THEN
     BEGIN
     FILE_REWRITE(FILEPATH_COLLECT);

     IF FormExists('FRCOLLECT' )=TRUE THEN COLLECT_CHANGE_VARIABLE;
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_PORT'        ,COLLECT_PORT        );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_BAUDRATE'    ,COLLECT_BAUDRATE    );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_DATABIT'     ,COLLECT_DATABIT     );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_STOPBIT'     ,COLLECT_STOPBIT     );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_PARITY'      ,COLLECT_PARITY      );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_LOGFILE'     ,COLLECT_LOGFILE     );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_TIMEOUT'     ,COLLECT_TIMEOUT     );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_ESCDELAY'    ,COLLECT_ESCDELAY    );
     INI_SAVE_INT (FILEPATH_COLLECT,'COLLECT_NAKDELAY'    ,COLLECT_NAKDELAY    );
     INI_SAVE_STR (FILEPATH_COLLECT,'COLLECT_ADDRESS'     ,COLLECT_ADDRESS     );
     INI_SAVE_BOOL(FILEPATH_COLLECT,'COLLECT_POWERSAVING' ,COLLECT_POWERSAVING );
     INI_SAVE_STR (FILEPATH_COLLECT,'COLLECT_FORMNAME'    ,COLLECT_FORMNAME    );
     INI_SAVE_STR (FILEPATH_COLLECT,'COLLECT_SOURCENAME'  ,COLLECT_SOURCENAME  );
     END;
END;


procedure TFRCOLLECT.FormCreate(Sender: TObject);
begin
  PAGE_A.SHOW;

  IF FileExists(FILEPATH_COLLECT) = FALSE THEN
     BEGIN
     FILE_CREATE(FILEPATH_COLLECT);
     COLLECT_WRITE_INI;
     END ELSE BEGIN
     COLLECT_READ_INI;
     END;
end;

procedure TFRCOLLECT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRCOLLECT.Release;
end;

procedure TFRCOLLECT.BTNQUTClick(Sender: TObject);
begin
  COLLECT_WRITE_INI;
  CLOSE;
end;

procedure TFRCOLLECT.BTNESCClick(Sender: TObject);
begin
  CLOSE;
end;











//BCP �����=================================
PROCEDURE COLLECT_Return_code(RET:INTEGER);
BEGIN

CASE RET OF
   1	: SHOWMESSAGE('����'+#10#13+'CONNECT    ');
   2	: SHOWMESSAGE('����'+#10#13+'RING       ');
   3    : SHOWMESSAGE('û���ͳ�����'+#10#13+'NO CARRIER ');
   4	: SHOWMESSAGE('���ʹ���'+#10#13+'ERROR      ');
   6	: SHOWMESSAGE('û����Ӧ'+#10#13+'NO DIALTONE');
   7	: SHOWMESSAGE('æ'+#10#13+'BUSY       ');
   8	: SHOWMESSAGE('û����Ӧ'+#10#13+'NO ANSWER  ');
   24	: SHOWMESSAGE('�ӳ���'+#10#13+'DELAYED    ');
   32	: SHOWMESSAGE(''+#10#13+'BLACKLISTED');
   33	: SHOWMESSAGE(''+#10#13+'FAX        ');
   35	: SHOWMESSAGE(''+#10#13+'DATA       ');
   40	: SHOWMESSAGE(''+#10#13+'CARRIER    ');
   200	: SHOWMESSAGE(''+#10#13+'Timeout    ');
END;


END;

FUNCTION COLLECT_WARM_START : BOOLEAN;
BEGIN
  try
    COLLECT_OPEN_PORT;
    COLLECT_CHANGE_VARIABLE;
    HM_OpenCommPort    ( COLLECT_PORT, COLLECT_BAUDRATE, COLLECT_DATABIT, COLLECT_PARITY, COLLECT_STOPBIT );
    COLLECT_Return_code( HM_warm_start(COLLECT_PORT,COLLECT_ADDRESS[1])  );
    HM_CloseCommPort   ( COLLECT_PORT);
  except
    HM_CloseCommPort(COLLECT_PORT);
    SHOWMESSAGE('��������, ��������������һ��!');
  end;
END;

FUNCTION COLLECT_COLD_START : BOOLEAN;
BEGIN
  try
    COLLECT_OPEN_PORT;
    COLLECT_CHANGE_VARIABLE;
    HM_OpenCommPort    ( COLLECT_PORT, COLLECT_BAUDRATE, COLLECT_DATABIT, COLLECT_PARITY, COLLECT_STOPBIT );
    COLLECT_Return_code( HM_COLD_start(COLLECT_PORT,COLLECT_ADDRESS[1])  );
    HM_CloseCommPort   ( COLLECT_PORT);
  except
    HM_CloseCommPort(COLLECT_PORT);
    SHOWMESSAGE('��������, ��������������һ��!');
  end;
END;

FUNCTION COLLECT_UP_LOAD : BOOLEAN;
var i , ret, lTotalLength ,lByteCounter, lPacketCounter: integer;
    fn1, fn2 : string;
    BCP_SUCESS : BOOLEAN;
BEGIN
  BCP_SUCESS := FALSE;
  COLLECT_WARM_START;  //������, ����ȷ�����ɹ�

  WHILE BCP_SUCESS = FALSE DO
    BEGIN
    try
    COLLECT_OPEN_PORT;
    COLLECT_CHANGE_VARIABLE;

    fn1 := COLLECT_SOURCENAME;
    fn2 := COLLECT_FORMNAME;

    HM_OpenCommPort (COLLECT_PORT, COLLECT_BAUDRATE, COLLECT_DATABIT, COLLECT_PARITY, COLLECT_STOPBIT );
    HM_set_upload_file_save_mode(1);
    DELAY(1000);
    HM_upload(COLLECT_PORT,COLLECT_ADDRESS[1], PCHAR(fn1), PCHAR(fn2));
    DELAY(1000);
    HM_CloseCommPort(COLLECT_PORT);
    IF FormExists('FRCOLLECT' )=TRUE THEN FRCOLLECT.MEMO.Lines.Add ('PORT='+INTTOSTR(COLLECT_PORT)+' Address='+COLLECT_ADDRESS+' Upload='+fn1+' Save to='+fn2);
    except
    HM_CloseCommPort(COLLECT_PORT);
    SHOWMESSAGE('��������, ��������������һ��!');
    end;

    Case MessageDlg('~~~~~�����ռ�����ʾOK!, ��ʾ�������!~~~~~'+#10#13+
                    '��YES    : ��ɴ���! (��������ʾ OK ʱ)    '+#10#13+
                    '��NO     : ���´���! (������û����ʾ OK ʱ)'+#10#13+
                    'ע�� : �������ռ�����ʾUPLOADINGʱ,��δOK �밴NO ���´��䵵��!',mtConfirmation,[mbYes,mbNo],0) of
         mrYES :begin
                if fn1 = 'FORM.DAT' THEN
                   BEGIN
                   HM_OpenCommPort (COLLECT_PORT, COLLECT_BAUDRATE, COLLECT_DATABIT, COLLECT_PARITY, COLLECT_STOPBIT );
                   HM_delete(COLLECT_PORT,COLLECT_ADDRESS[1], PCHAR(fn1));
                   HM_CloseCommPort(COLLECT_PORT);
                   END;
                BCP_SUCESS := TRUE;
                end;
         mrNO  :COLLECT_WARM_START;
         end;


    END;


END;










// TEST BCP �����=================================
procedure TFRCOLLECT.P_TEST_WARM_STARTClick(Sender: TObject);
begin
  COLLECT_WARM_START;
end;

procedure TFRCOLLECT.BitBtn2Click(Sender: TObject);
begin
  COLLECT_COLD_START;
end;

procedure TFRCOLLECT.BitBtn3Click(Sender: TObject);
begin
  COLLECT_UP_LOAD;
end;

procedure TFRCOLLECT.BitBtn4Click(Sender: TObject);
var i , ret, lTotalLength ,lByteCounter, lPacketCounter: integer;
    fn1, fn2 : string;
begin
     fn1 := 'form.dat';// InputBox('Upload file', 'Source file name', '');
     fn2 := 'form.dat';//InputBox('Upload file', 'Destination file name', fn1);
     fn1 := 'INC.DAT';// InputBox('Upload file', 'Source file name', '');
     fn2 := 'formA.dat';//InputBox('Upload file', 'Destination file name', fn1);

     HM_OpenCommPort(COLLECT_PORT, COLLECT_BAUDRATE, 8, 0, 1);
     ret := HM_upload(1,'A', pchar(fn1), pchar(fn2));
     HM_CloseCommPort(1);
end;


end.

