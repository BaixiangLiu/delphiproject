unit sel_huichang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, simpleselect, dxExEdtr, DB, ADODB, dxCntner, dxTL, dxDBCtrl,
  dxDBTL, jpeg, ExtCtrls, dxEditor, dxEdLib, StdCtrls, Buttons, dxDBGrid,eseatclasses;

type
  Tfrm_sel_huichang = class(TFsimpleselect)
    listColumn1: TdxDBGridMaskColumn;
    listColumn2: TdxDBGridMaskColumn;
    listColumn3: TdxDBGridMaskColumn;
    listColumn4: TdxDBGridMaskColumn;
    listColumn5: TdxDBGridMaskColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    huichang:Tmeetingroom;
  public
    { Public declarations }
  end;

var
  frm_sel_huichang: Tfrm_sel_huichang;

implementation

{$R *.dfm}

procedure Tfrm_sel_huichang.FormCreate(Sender: TObject);
begin
  inherited;
  huichang:=tmeetingroom.Create(nil);
end;

procedure Tfrm_sel_huichang.FormShow(Sender: TObject);
begin
  inherited;
  huichang.getdata('',query);
end;

end.
