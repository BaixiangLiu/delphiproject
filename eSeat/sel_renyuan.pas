unit sel_renyuan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, simpleselect, dxExEdtr, DB, ADODB, dxCntner, dxTL, dxDBCtrl,
  dxDBTL, jpeg, ExtCtrls, dxEditor, dxEdLib, StdCtrls, Buttons, dxDBGrid,eseatclasses;

type
  Tfrm_sel_renyuan = class(TFsimpleselect)
    listColumn1: TdxDBGridMaskColumn;
    listColumn2: TdxDBGridMaskColumn;
    listColumn3: TdxDBGridMaskColumn;
    listColumn4: TdxDBGridMaskColumn;
    listColumn5: TdxDBGridMaskColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    renyuan:Tmeetingpeople;
  public
    { Public declarations }
  end;

var
  frm_sel_renyuan: Tfrm_sel_renyuan;

implementation

{$R *.dfm}

procedure Tfrm_sel_renyuan.FormCreate(Sender: TObject);
begin
  inherited;
  renyuan:=tmeetingpeople.Create(nil);
end;

procedure Tfrm_sel_renyuan.FormShow(Sender: TObject);
begin
  inherited;
  renyuan.getdata('',query);
end;

end.
