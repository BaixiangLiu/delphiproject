unit tx;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, jpeg, ExtCtrls, DateUtils, MMSystem;

type
    Tfrmtx = class(TForm)
        Image1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Timer1: TTimer;
        Label3: TLabel;
        Label4: TLabel;
        Timer2: TTimer;
        Memo1: TMemo;
        Panel1: TPanel;
        Label5: TLabel;
        Edit1: TEdit;
        Button1: TButton;
        edtAnswer: TEdit;
        procedure FormCreate(Sender: TObject);
        procedure FormKeyPress(Sender: TObject; var Key: Char);
        procedure Timer1Timer(Sender: TObject);
        procedure Timer2Timer(Sender: TObject);
        procedure Button1Click(Sender: TObject);


    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmtx: Tfrmtx;
    Sec: integer;
    sAnswer: string;

implementation
uses main, mythread;

{$R *.dfm}

procedure Tfrmtx.FormCreate(Sender: TObject);
begin
    BorderStyle := bsNone;
    Height := screen.height;
    Width := screen.width;
    Position := poScreenCenter;
    FormStyle := fsStayOnTop;

    Sec := 60;
end;


procedure Tfrmtx.FormKeyPress(Sender: TObject; var Key: Char);
begin
    Beep;
    key := #0;
end;

procedure Tfrmtx.Timer1Timer(Sender: TObject);
begin
    if Sec > 0 then begin
        sec := Sec - 1;
        frmtx.Label3.Caption := intToStr(Sec);
    end
    else begin
        frmtx.Close;
    end;
end;



procedure Tfrmtx.Timer2Timer(Sender: TObject);
var
    TVRThread: TVoiceRemindThread;
begin
    if VoiceRemind = '0' then begin
        Timer2.Enabled := false;
    end;

    if VoiceRemind = '1' then begin
        TVRThread := TVoiceRemindThread.Create(False);
        Timer2.Enabled := false;
    end;
end;

procedure Tfrmtx.Button1Click(Sender: TObject);
begin
    if Trim(edit1.Text) = Trim(edtAnswer.Text) then begin
        frmtx.Close;
    end
    else begin
        Sec := 60;
    end;
end;

end.

