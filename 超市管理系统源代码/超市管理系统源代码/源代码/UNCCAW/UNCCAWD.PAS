unit UNCCAWD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMCCAWD = class(TDataModule)
    QBMEM: TQuery;
    DSBMEM: TDataSource;
    QCCAW: TQuery;
    DSCCAW: TDataSource;
    QCCAWBMENO: TStringField;
    QCCAWCWGET: TBooleanField;
    QCCAWCWGDS: TStringField;
    QCCAWBMENO_1: TStringField;
    QCCAWBMNAM: TStringField;
    QCCAWBMCNA: TStringField;
    QCCAWBMBTH: TDateTimeField;
    QCCAWBMSEX: TStringField;
    QCCAWBMLVE: TFloatField;
    QCCAWBMBYR: TFloatField;
    QCCAWBMBTO: TFloatField;
    QCCAWBMBPO: TFloatField;
    QCCAWBMBTM: TFloatField;
    QCCAWBMBDT: TDateTimeField;
    QCCAWBMBYD: TDateTimeField;
    QCCAWBMWPN: TStringField;
    QCCAWBMTL1: TStringField;
    QCCAWBMTL2: TStringField;
    QCCAWBMTL3: TStringField;
    QCCAWBMAD1: TStringField;
    QCCAWBMAD2: TStringField;
    QCCAWBMZP1: TStringField;
    QCCAWBMZP2: TStringField;
    QCCAWBMEML: TStringField;
    QCCAWBMWWW: TStringField;
    QCCAWBMJND: TDateTimeField;
    QCCAWBMCRD: TDateTimeField;
    QCCAWBMDAT: TDateTimeField;
    QCCAWRBPST: TStringField;
    QCCAWBMMRK: TMemoField;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMCCAWD: TFMCCAWD;

implementation

{$R *.DFM}

end.
