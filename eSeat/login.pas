unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxCntner, dxEditor, dxEdLib, Buttons, ExtCtrls,inifiles;

type
  Tfrmlogin = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dxEdit1: TdxEdit;
    dxEdit2: TdxEdit;
    dxEdit3: TdxEdit;
    dxEdit4: TdxEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    connfile:Tinifile;
  public
    { Public declarations }
  end;

var
  frmlogin: Tfrmlogin;

implementation

{$R *.dfm}

uses main,dm_seat,global;
procedure Tfrmlogin.BitBtn1Click(Sender: TObject);
begin
  connfile:=Tinifile.Create(inipath+'conn.ini');
  connfile.WriteString('db','servername',dxedit1.Text);
  connfile.WriteString('db','dbname',dxedit2.Text);
  connfile.WriteString('db','username',dxedit3.Text);
  connfile.WriteString('db','password',dxedit4.Text);
  connfile.WriteBool('db','sqlautority',radiobutton1.checked);
  connfile.Free;
  if dmseat.connectdb(dmseat.seatconn) then
  begin
    close;
    if Application.FindComponent('frmmain') = nil then
      Application.CreateForm(Tfrmmain,frmmain);
    frmmain.Show;

  end;
end;

procedure Tfrmlogin.FormShow(Sender: TObject);
begin
  if fileexists(inipath+'conn.ini') then
  begin
  connfile:=Tinifile.Create(inipath+'conn.ini');
  dxedit1.Text:=connfile.readString('db','servername','');
  dxedit2.Text:=connfile.readString('db','dbname','');
  dxedit3.Text:=connfile.readString('db','username','');
  dxedit4.Text:=connfile.readString('db','password','');
  radiobutton1.Checked:=connfile.ReadBool('db','sqlautority',true);
  connfile.Free;
  end;
end;

procedure Tfrmlogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  close;
end;

procedure Tfrmlogin.BitBtn2Click(Sender: TObject);
begin
  close;
end;

end.
