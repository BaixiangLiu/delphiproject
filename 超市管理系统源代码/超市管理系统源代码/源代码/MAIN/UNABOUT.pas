unit UNABOUT;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, GIFImage;

type
  TFMABOUT = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image1: TImage;
    Label8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Bevel3: TBevel;
    procedure OKBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMABOUT: TFMABOUT;

implementation

uses Mapi;

{$R *.DFM}


procedure TFMABOUT.OKBtnClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMABOUT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMABOUT.Release;
end;


procedure TFMABOUT.Label2Click(Sender: TObject);
var
  MapiMessage: TMapiMessage;
  MError: Cardinal;
begin
  with MapiMessage do
  begin
    ulReserved := 0;
    lpszSubject := nil;
    lpszNoteText := PChar('huangcp@ms19.url.com.tw');
    lpszMessageType := nil;
    lpszDateReceived := nil;
    lpszConversationID := nil;
    flFlags := 0;
    lpOriginator := nil;
    nRecipCount := 0;
    lpRecips := nil;
    nFileCount := 0;
    lpFiles := nil;
  end;

  MError := MapiSendMail(0, 0, MapiMessage,
  MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);
end;

end.
