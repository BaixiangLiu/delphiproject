unit LOGO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Gauges, StdCtrls, jpeg;

type
  TFMLOGO = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Gauge: TGauge;
    Label2: TLabel;
    OK_IMAGE: TImage;
    COMPANY_IMG: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    N : INTEGER;
    PICNAME : STRING;
  public
    { Public declarations }
  end;

var
  FMLOGO: TFMLOGO;

PROCEDURE DLL_SHOWMODAL_LOGO;

implementation

{$R *.DFM}

PROCEDURE DLL_SHOWMODAL_LOGO;
BEGIN
  IF Application.FindComponent('FMLOGO')= NIL THEN Application.CreateForm(TFMLOGO,FMLOGO);
  FMLOGO.ShowModal;
END;

procedure TFMLOGO.Timer1Timer(Sender: TObject);
begin
  INC(N);
  IF N >= 50 THEN CLOSE;
  IF Gauge.Progress <= 100 THEN
     BEGIN
     Gauge.MaxValue := 100;
     Gauge.AddProgress(8);
     END;
end;

procedure TFMLOGO.FormCreate(Sender: TObject);
begin
  N:= 0;
  
  PICNAME := '\DELPHI\PIC\MICROPOS.JPG';
  IF FileExists(PICNAME)=TRUE THEN Image1.Picture.LoadFromFile(PICNAME);
  
  // ¼ì²éÊÔÓÃ
  IF FileExists('\SYSTEM.SYS') = FALSE  THEN
     BEGIN
     PICNAME := '\DELPHI\PIC\MICROPOSBETA.JPG';
     IF FileExists(PICNAME)=TRUE THEN OK_IMAGE.Picture.LoadFromFile(PICNAME);
     END;
  
  PICNAME := '\DELPHI\PIC\COMPANY.JPG';
  IF FileExists(PICNAME)=TRUE THEN COMPANY_IMG.Picture.LoadFromFile(PICNAME);
end;

procedure TFMLOGO.Image1Click(Sender: TObject);
begin
  CLOSE;
end;

procedure TFMLOGO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TIMER1.Enabled := FALSE;
  FMLOGO.Release;
end;

end.
