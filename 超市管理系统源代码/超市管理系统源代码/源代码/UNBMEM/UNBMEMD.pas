unit UNBMEMD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMBMEMD = class(TDataModule)
    DSBMEM: TDataSource;
    QBMEM: TQuery;
    UBMEM: TUpdateSQL;
    QBMNAMLIKE: TQuery;
    DSBMNAMLIKE: TDataSource;
    QBMNAMLIKEBMNAM: TStringField;
    QBMEMBMENO: TStringField;
    QBMEMBMNAM: TStringField;
    QBMEMBMCNA: TStringField;
    QBMEMBMBTH: TDateTimeField;
    QBMEMBMSEX: TStringField;
    QBMEMBMLVE: TFloatField;
    QBMEMBMBYR: TFloatField;
    QBMEMBMBTO: TFloatField;
    QBMEMBMBPO: TFloatField;
    QBMEMBMBTM: TFloatField;
    QBMEMBMBDT: TDateTimeField;
    QBMEMBMBYD: TDateTimeField;
    QBMEMBMWPN: TStringField;
    QBMEMBMTL1: TStringField;
    QBMEMBMTL2: TStringField;
    QBMEMBMTL3: TStringField;
    QBMEMBMAD1: TStringField;
    QBMEMBMAD2: TStringField;
    QBMEMBMZP1: TStringField;
    QBMEMBMZP2: TStringField;
    QBMEMBMEML: TStringField;
    QBMEMBMWWW: TStringField;
    QBMEMBMJND: TDateTimeField;
    QBMEMBMCRD: TDateTimeField;
    QBMEMBMDAT: TDateTimeField;
    QBMEMRBPST: TStringField;
    QBMEMBMMRK: TMemoField;
    procedure QBMEMAfterOpen(DataSet: TDataSet);
    procedure QBMEMAfterPost(DataSet: TDataSet);
    procedure QBMEMAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMBMEMD: TFMBMEMD;

implementation

USES UNBMEM;

{$R *.DFM}




procedure TFMBMEMD.QBMEMAfterOpen(DataSet: TDataSet);
begin
  FMBMEM.StatusBar.Panels.Items[0].Text := '¦@ '+INTTOSTR(QBMEM.RecordCount)+'µ§';
end;

procedure TFMBMEMD.QBMEMAfterPost(DataSet: TDataSet);
begin
  FMBMEM.StatusBar.Panels.Items[0].Text := '¦@ '+INTTOSTR(QBMEM.RecordCount)+'µ§';
end;

procedure TFMBMEMD.QBMEMAfterEdit(DataSet: TDataSet);
begin
  FMBMEM.UPDATEMODE;
end;

end.
