unit UNRCJND;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMRCJND = class(TDataModule)
    DSRCJN: TDataSource;
    QRCJN: TQuery;
    URCJN: TUpdateSQL;
    QRCJNB: TQuery;
    DSRCJNB: TDataSource;
    URCJNB: TUpdateSQL;
    QRCJNB_BGNAM: TStringField;
    QRCJNB_BGID1: TStringField;
    QBSUPPPP: TQuery;
    QRCJNRJENO: TStringField;
    QRCJNRJTYP: TStringField;
    QRCJNRJDAT: TDateTimeField;
    QRCJNBNENO: TStringField;
    QRCJNBSENO: TStringField;
    QRCJNRJAM1: TFloatField;
    QRCJNRJAMT: TFloatField;
    QRCJNRJMRK: TMemoField;
    QRCJNRJSTA: TBooleanField;
    QRCJNBRJENO: TStringField;
    QRCJNBRJITM: TStringField;
    QRCJNBBGENO: TStringField;
    QRCJNBRJGCN: TFloatField;
    QRCJNBRJGCS: TFloatField;
    QRCJNBRJGCT: TFloatField;
    procedure DSRCJNDataChange(Sender: TObject; Field: TField);
    procedure QRCJNAfterEdit(DataSet: TDataSet);
    procedure QRCJNCalcFields(DataSet: TDataSet);
    procedure QRCJNBCalcFields(DataSet: TDataSet);
    procedure QRCJNAfterInsert(DataSet: TDataSet);
    procedure QRCJNBAfterInsert(DataSet: TDataSet);
    procedure QRCJNBAfterPost(DataSet: TDataSet);
    procedure QRCJNAfterPost(DataSet: TDataSet);
    procedure DSRPCHADataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    T_BGCOT : INTEGER;
    T_ROGCN : INTEGER;
  end;

var
  FMRCJND: TFMRCJND;

implementation

USES SYSINI, UN_UTL, DB_UTL, MAIND, FM_UTL, MAINU,
     UNRCJN;

{$R *.DFM}










procedure TFMRCJND.DSRCJNDataChange(Sender: TObject; Field: TField);
VAR I : INTEGER;
begin
IF (FMRCJN.FORMMODE = 'INS') OR (FMRCJN.FORMMODE = 'UPD') THEN EXIT;

QRCJNB.SQL.CLEAR;
QRCJNB.SQL.ADD('SELECT * FROM RCJNB ');
QRCJNB.SQL.ADD('WHERE RJENO = '''+QRCJN.FieldByName('RJENO').AsString+'''');
QRCJNB.SQL.ADD('ORDER BY RJENO, RJITM');
QRCJNB.CLOSE;
QRCJNB.OPEN;
{
FMRCJND.QRCJNB.First;
WHILE NOT FMRCJND.QRCJNB.EOF DO
  BEGIN
  I := I + FMRCJND.QRCJNB.FIELDBYNAME('ROGCT').AsInteger;
  FMRCJND.QRCJNB.NEXT;
  END;

FMRCJN._RODM2.TEXT := INTTOSTR(I);
FMRCJN._RODM1.TEXT := INTTOSTR(
0-
(FMRCJND.QRCJNROSA1.AsInteger+
 FMRCJND.QRCJNROSA2.AsInteger+
 FMRCJND.QRCJNROSA3.AsInteger+
 FMRCJND.QRCJNROSA4.AsInteger+
 FMRCJND.QRCJNROSA5.AsInteger+
 FMRCJND.QRCJNROTX1.AsInteger+
 FMRCJND.QRCJNROTX2.AsInteger) +
(FMRCJND.QRCJNROAM1.AsInteger+
 FMRCJND.QRCJNROAM2.AsInteger+
 FMRCJND.QRCJNROAM3.AsInteger+
 FMRCJND.QRCJNROAM4.AsInteger) );

FMRCJN._ROAMD.TEXT := INTTOSTR(
  STRTOINTDEF( FMRCJN._RODM1.TEXT, 0) +
  STRTOINTDEF( FMRCJN._RODM2.TEXT, 0) -
  STRTOINTDEF( FMRCJN.ROAMT.TEXT, 0)  );
 }
end;


procedure TFMRCJND.QRCJNAfterEdit(DataSet: TDataSet);
begin
T_ROGCN := QRCJNB.FieldByName('RJGCN').AsINTEGER;
FMRCJN.UPDATEMODE;
end;

procedure TFMRCJND.QRCJNAfterInsert(DataSet: TDataSet);
begin
FMRCJN.INSERTMODE;
end;

procedure TFMRCJND.QRCJNCalcFields(DataSet: TDataSet);
begin
//QRCJN_BCNAM.Value := DB_QUERY_FIND_VALUE('BCST','BCENO',QRCJNBCENO.Value,'BCNAM');
end;

procedure TFMRCJND.QRCJNBCalcFields(DataSet: TDataSet);
begin
IF QRCJNBBGENO.Value <> '' THEN
   BEGIN
   QRCJNB_BGNAM.Value := DB_QUERY_FIND_VALUE('BGDS','BGENO',QRCJNBBGENO.AsString,'BGNAM');
//   QRCJNB_BGID1.Value := DB_QUERY_FIND_VALUE('BGDS','BGENO',QRCJNBBGENO.AsString,'BGID1');
   END;

end;


procedure TFMRCJND.QRCJNBAfterInsert(DataSet: TDataSet);
begin
T_ROGCN := 0;
    QRCJNBRJENO.VALUE := FMRCJN.RJENO.TEXT  ;
    QRCJNBRJITM.VALUE := TABLEFINDMAXITM('RCJNB','RJENO',FMRCJN.RJENO.TEXT,'RJITM',5,1);
    QRCJNBBGENO.VALUE := ''  ;
    QRCJNBRJGCN.VALUE := 0   ;
    QRCJNBRJGCS.VALUE := 0   ;
    QRCJNBRJGCT.VALUE := 0   ;

FMRCJN.INSERTMODE;
end;

procedure TFMRCJND.QRCJNBAfterPost(DataSet: TDataSet);
begin
   FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCJND.QRCJNB);


   BGDS_UPDATE_BGQTN( QRCJNB.FieldByName('BGENO').AsString,
                    ( T_ROGCN - QRCJNB.FieldByName('RJGCN').AsINTEGER)); //¶i³f³æ

FMRCJN.NORMALMODE;
end;

procedure TFMRCJND.QRCJNAfterPost(DataSet: TDataSet);
begin
FMRCJN.NORMALMODE;
end;

procedure TFMRCJND.DSRPCHADataChange(Sender: TObject; Field: TField);
begin
{     FMRCJND.QRPCHB.SQL.CLEAR;
     FMRCJND.QRPCHB.SQL.ADD('SELECT *  ');
     FMRCJND.QRPCHB.SQL.ADD('FROM RPCHB ,BGDS');
     FMRCJND.QRPCHB.SQL.ADD('WHERE RHENO = '''+FMRCJND.QRPCHA.FieldByName('RHENO').AsString+'''');
     FMRCJND.QRPCHB.SQL.ADD('  AND RPCHB.BGENO = BGDS.BGENO ');
     FMRCJND.QRPCHB.SQL.ADD('ORDER BY RPCHB.RHENO, RPCHB.BGENO ');
     FMRCJND.QRPCHB.CLOSE;
     FMRCJND.QRPCHB.OPEN;
}
end;

end.
