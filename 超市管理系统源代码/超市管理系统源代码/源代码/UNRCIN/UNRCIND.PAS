unit UNRCIND;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TFMRCIND = class(TDataModule)
    DSRCIN: TDataSource;
    QRCIN: TQuery;
    URCIN: TUpdateSQL;
    QRCINB: TQuery;
    DSRCINB: TDataSource;
    URCINB: TUpdateSQL;
    QRCINB_BGNAM: TStringField;
    QRCONBSTORY: TQuery;
    DSRCONBSTORY: TDataSource;
    QRCONBSTORYBGENO: TStringField;
    QRCONBSTORYROGCN: TFloatField;
    QRCONBSTORYROGCS: TFloatField;
    QRCONBSTORYROGCT: TFloatField;
    QRCONBSTORYRBPST: TStringField;
    QRCONBSTORYBCNAM: TStringField;
    QRCONBSTORYRODAT: TDateTimeField;
    QRCINB_BGID1: TStringField;
    QRCINBRIENO: TStringField;
    QRCINBRIITM: TStringField;
    QRCINBBGENO: TStringField;
    QRCINBRIUNP: TStringField;
    QRCINBRIGCN: TFloatField;
    QRCINBRIGCS: TFloatField;
    QRCINBRIGCT: TFloatField;
    DSRPCHA: TDataSource;
    QRPCHA: TQuery;
    QRPCHARHENO: TStringField;
    QRPCHABSENO: TStringField;
    QRPCHARHPTD: TDateTimeField;
    QRPCHARHPTT: TStringField;
    QRPCHARHPDT: TDateTimeField;
    QRPCHABNENO: TStringField;
    QRPCHARHSAT: TStringField;
    QRPCHARHTRN: TBooleanField;
    QRPCHARHMRK: TStringField;
    QRPCHARHMEM: TMemoField;
    QRPCHA_BNNAM: TStringField;
    QRPCHA_BSNAM: TStringField;
    QRPCHARH_OVERDAT: TBooleanField;
    QRPCHARH_OVERINT: TStringField;
    URPCHA: TUpdateSQL;
    QRPCHB: TQuery;
    QRPCHBRHENO: TStringField;
    QRPCHBBGENO: TStringField;
    QRPCHBRHCSI: TFloatField;
    QRPCHBRHCST: TFloatField;
    QRPCHBRHPCA: TFloatField;
    QRPCHBRHTRN: TBooleanField;
    QRPCHBBGENO_1: TStringField;
    QRPCHBBGID1: TStringField;
    QRPCHBBGNAM: TStringField;
    QRPCHBBGKIN: TStringField;
    QRPCHBBGPST: TFloatField;
    QRPCHBBGPVP: TFloatField;
    QRPCHBBGPMM: TFloatField;
    QRPCHBBGPR1: TFloatField;
    QRPCHBBGPR2: TFloatField;
    QRPCHBBGPR3: TFloatField;
    QRPCHBBGQTS: TFloatField;
    QRPCHBBGCOS: TFloatField;
    QRPCHBBSENO: TStringField;
    DSRPCHB: TDataSource;
    URPCHB: TUpdateSQL;
    QRCINRIENO: TStringField;
    QRCINRITYP: TStringField;
    QRCINRIDAT: TDateTimeField;
    QRCINBNENO: TStringField;
    QRCINBSENO: TStringField;
    QRCINRISNO: TStringField;
    QRCINRIIID: TStringField;
    QRCINRIINO: TStringField;
    QRCINRIIAD: TStringField;
    QRCINRIPAY: TStringField;
    QRCINRIEXG: TStringField;
    QRCINRIEXR: TFloatField;
    QRCINRIAM1: TFloatField;
    QRCINRIAM2: TFloatField;
    QRCINRIAMT: TFloatField;
    QRCINRISA1: TFloatField;
    QRCINRISA2: TFloatField;
    QRCINRISA3: TFloatField;
    QRCINRISA4: TFloatField;
    QRCINRISA5: TFloatField;
    QRCINRIMRK: TMemoField;
    QRCINRISTA: TBooleanField;
    QBSUP: TQuery;
    procedure DSRCINDataChange(Sender: TObject; Field: TField);
    procedure QRCINAfterEdit(DataSet: TDataSet);
    procedure QRCINCalcFields(DataSet: TDataSet);
    procedure QRCINBCalcFields(DataSet: TDataSet);
    procedure QRCINAfterInsert(DataSet: TDataSet);
    procedure QRCINBAfterInsert(DataSet: TDataSet);
    procedure QRCINBAfterPost(DataSet: TDataSet);
    procedure QRCINAfterPost(DataSet: TDataSet);
    procedure DSRPCHADataChange(Sender: TObject; Field: TField);
    procedure QRPCHACalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    T_BGCOT : INTEGER;
    T_ROGCN : INTEGER;
  end;

var
  FMRCIND: TFMRCIND;

implementation

USES SYSINI, UN_UTL, DB_UTL, MAIND, FM_UTL, MAINU,
     UNRCIN;

{$R *.DFM}










procedure TFMRCIND.DSRCINDataChange(Sender: TObject; Field: TField);
VAR I : INTEGER;
begin
IF (FMRCIN.FORMMODE = 'INS') OR (FMRCIN.FORMMODE = 'UPD') THEN EXIT;

QRCINB.SQL.CLEAR;
QRCINB.SQL.ADD('SELECT * FROM RCINB ');
QRCINB.SQL.ADD('WHERE RIENO = '''+QRCIN.FieldByName('RIENO').AsString+'''');
QRCINB.SQL.ADD('ORDER BY RIENO, RIITM');
QRCINB.CLOSE;
QRCINB.OPEN;
{
FMRCIND.QRCINB.First;
WHILE NOT FMRCIND.QRCINB.EOF DO
  BEGIN
  I := I + FMRCIND.QRCINB.FIELDBYNAME('ROGCT').AsInteger;
  FMRCIND.QRCINB.NEXT;
  END;

FMRCIN._RODM2.TEXT := INTTOSTR(I);
FMRCIN._RODM1.TEXT := INTTOSTR(
0-
(FMRCIND.QRCINROSA1.AsInteger+
 FMRCIND.QRCINROSA2.AsInteger+
 FMRCIND.QRCINROSA3.AsInteger+
 FMRCIND.QRCINROSA4.AsInteger+
 FMRCIND.QRCINROSA5.AsInteger+
 FMRCIND.QRCINROTX1.AsInteger+
 FMRCIND.QRCINROTX2.AsInteger) +
(FMRCIND.QRCINROAM1.AsInteger+
 FMRCIND.QRCINROAM2.AsInteger+
 FMRCIND.QRCINROAM3.AsInteger+
 FMRCIND.QRCINROAM4.AsInteger) );

FMRCIN._ROAMD.TEXT := INTTOSTR(
  STRTOINTDEF( FMRCIN._RODM1.TEXT, 0) +
  STRTOINTDEF( FMRCIN._RODM2.TEXT, 0) -
  STRTOINTDEF( FMRCIN.ROAMT.TEXT, 0)  );
 }
end;


procedure TFMRCIND.QRCINAfterEdit(DataSet: TDataSet);
begin
T_ROGCN := QRCINB.FieldByName('RIGCN').AsINTEGER;
FMRCIN.UPDATEMODE;
end;

procedure TFMRCIND.QRCINAfterInsert(DataSet: TDataSet);
begin
FMRCIN.INSERTMODE;
end;

procedure TFMRCIND.QRCINCalcFields(DataSet: TDataSet);
begin
//QRCIN_BCNAM.Value := DB_QUERY_FIND_VALUE('BCST','BCENO',QRCINBCENO.Value,'BCNAM');
end;

procedure TFMRCIND.QRCINBCalcFields(DataSet: TDataSet);
begin
IF QRCINBBGENO.Value <> '' THEN
   BEGIN
   QRCINB_BGNAM.Value := DB_QUERY_FIND_VALUE('BGDS','BGENO',QRCINBBGENO.AsString,'BGNAM');
//   QRCINB_BGID1.Value := DB_QUERY_FIND_VALUE('BGDS','BGENO',QRCINBBGENO.AsString,'BGID1');
   END;

end;


procedure TFMRCIND.QRCINBAfterInsert(DataSet: TDataSet);
begin
T_ROGCN := 0;
    QRCINBRIENO.VALUE := FMRCIN.RIENO.TEXT  ;
    QRCINBRIITM.VALUE := TABLEFINDMAXITM('RCINB','RIENO',FMRCIN.RIENO.TEXT,'RIITM',5,1);
//    QRCINBRHENO.VALUE := ''  ;
    QRCINBBGENO.VALUE := ''  ;
    QRCINBRIUNP.VALUE := '001'  ;
//    QRCINBRIGCV.VALUE := 0   ;
    QRCINBRIGCN.VALUE := 0   ;
    QRCINBRIGCS.VALUE := 0   ;
    QRCINBRIGCT.VALUE := 0   ;

FMRCIN.INSERTMODE;
end;

procedure TFMRCIND.QRCINBAfterPost(DataSet: TDataSet);
begin
FM_DB_QUERY_UPDATE(FMMAIND.DATABASE,FMRCIND.QRCINB);


BGDS_UPDATE_BGQTN( QRCINB.FieldByName('BGENO').AsString,
               - ( T_ROGCN-QRCINB.FieldByName('RIGCN').AsINTEGER)); //¶i³f³æ

FMRCIN.NORMALMODE;
end;

procedure TFMRCIND.QRCINAfterPost(DataSet: TDataSet);
begin
FMRCIN.NORMALMODE;
end;

procedure TFMRCIND.DSRPCHADataChange(Sender: TObject; Field: TField);
begin
{     FMRCIND.QRPCHB.SQL.CLEAR;
     FMRCIND.QRPCHB.SQL.ADD('SELECT *  ');
     FMRCIND.QRPCHB.SQL.ADD('FROM RPCHB ,BGDS');
     FMRCIND.QRPCHB.SQL.ADD('WHERE RHENO = '''+FMRCIND.QRPCHA.FieldByName('RHENO').AsString+'''');
     FMRCIND.QRPCHB.SQL.ADD('  AND RPCHB.BGENO = BGDS.BGENO ');
     FMRCIND.QRPCHB.SQL.ADD('ORDER BY RPCHB.RHENO, RPCHB.BGENO ');
     FMRCIND.QRPCHB.CLOSE;
     FMRCIND.QRPCHB.OPEN;
}     
end;

procedure TFMRCIND.QRPCHACalcFields(DataSet: TDataSet);
begin
IF DATE >= QRPCHARHPDT.Value THEN
   QRPCHARH_OVERDAT.Value := TRUE ELSE
   QRPCHARH_OVERDAT.Value := FALSE;

QRPCHARH_OVERINT.AsString := INTTOSTR(
EDATE_SUB_EDATE(DATE, QRPCHARHPDT.Value));

QRPCHA_BSNAM.Value := DB_QUERY_FIND_VALUE('BSUP','BSENO',QRPCHABSENO.Value,'BSNAM');

end;

end.
