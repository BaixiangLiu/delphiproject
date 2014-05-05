{|----------------------------------------------------------------------
 | Unit:        About
 |
 | Author:      Egbert van Nes
 |
 | Description: Simple about box for DelFor
 |
 | Copyright (c) 2000  Egbert van Nes
 |   All rights reserved
 |   Disclaimer and licence notes: see license.txt
 |
 |----------------------------------------------------------------------
}
unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    Label4: TLabel;
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses ShellAPI;
{$R *.DFM}

procedure TAboutBox.Label4Click(Sender: TObject);
begin
  {opens default explorer with the URL of the homepage}
  ShellExecute(HInstance, 'open', 'http://www.dow.wau.nl/aew/delforexp.html', nil, nil, SW_SHOW);
end;

end.
