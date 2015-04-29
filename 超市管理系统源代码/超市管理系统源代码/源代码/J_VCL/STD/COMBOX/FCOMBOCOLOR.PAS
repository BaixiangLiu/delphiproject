unit FComboColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FnpComboColor;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    FnpComboColor1: TFnpComboColor;
    Button9: TButton;
    Button10: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  case (Sender as TRadioGroup).ItemIndex of
    0: FnpComboColor1.SortBy := ccsUnsorted;
    1: FnpComboColor1.SortBy := ccsColor;
    2: FnpComboColor1.SortBy := ccsText;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  { Add colors to FnpComboColor }
  FnpComboColor1.AddColor('Red', clRed);
  FnpComboColor1.AddColor('Blue', clBlue);
  FnpComboColor1.AddColor('Green', clGreen);
  FnpComboColor1.AddColor('Black', clBlack);
  FnpComboColor1.AddColor('White', clWhite);
  FnpComboColor1.AddColor('Yellow', clYellow);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FnpComboColor1.AddColor('Aqua', clAqua);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FnpComboColor1.AddColor('Lime', clLime);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FnpComboColor1.AddColor('Silver', clSilver);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FnpComboColor1.AddColor('Navy', clNavy);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  FnpComboColor1.AddColor('Olive', clOlive);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  FnpComboColor1.SelectedColor := clRed;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  FnpComboColor1.SelectedColorText := 'Blue';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  FnpComboColor1.AddColor('Purple', clPurple);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  FnpComboColor1.ColorWidth := FnpComboColor1.ColorWidth - 1;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  FnpComboColor1.ColorWidth := FnpComboColor1.ColorWidth + 1;
end;

end.
