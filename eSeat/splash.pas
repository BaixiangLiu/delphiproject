unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ComCtrls, dxCntner, dxExEdtr, dxEdLib;

type
  TsplashForm = class(TForm)
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  splashForm: TsplashForm;
  progress : Integer;

implementation

{$R *.dfm}

procedure TsplashForm.Timer1Timer(Sender: TObject);
var
  i : integer;
begin
  ProgressBar1.Min := 0;
  ProgressBar1.Max := 10000;
  for I:=1 to 10000 do
  begin
    ProgressBar1.Position := i;
  end;
  SplashForm.ModalResult:=  mrOK;
end;

end.
