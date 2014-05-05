unit unit_waiting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  Tfrm_waiting = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_waiting: Tfrm_waiting;

implementation

uses unit_counter, unit_main;

{$R *.dfm}

procedure Tfrm_waiting.FormShow(Sender: TObject);
begin
frm_counter.QuickRep1.DataSet.Open;
frm_counter.QuickRep1.DataSet.Refresh;
frm_counter.ADODataSet1.Open;
frm_counter.ADODataSet1.Refresh;
timer1.Enabled:=true;
end;

procedure Tfrm_waiting.Timer1Timer(Sender: TObject);
begin
if progressbar1.Position<>progressbar1.max then
begin
progressbar1.Position:=progressbar1.Position+progressbar1.Step;
end
else
begin
timer1.Enabled:=false;
progressbar1.Position:=0;
frm_waiting.Close;
end;
end;

end.
