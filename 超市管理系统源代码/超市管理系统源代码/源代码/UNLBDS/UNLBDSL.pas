unit UNLBDSL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, ComCtrls, Thubar39, DBTables;

type
  TFMLBDSL = class(TForm)
    PageControl1: TPageControl;
    PAGE_A_LB: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ED_NAME: TEdit;
    ED_HEIGHT: TSpinEdit;
    ED_WIDTH: TSpinEdit;
    ED_LEFT: TSpinEdit;
    ED_TOP: TSpinEdit;
    ED_PRINT_STYLE1: TPanel;
    Label6: TLabel;
    ED_CAPTION: TEdit;
    ED_PRINT_STYLE2: TPanel;
    Label8: TLabel;
    Label15: TLabel;
    ED_FIELD_NAME: TComboBox;
    ED_TABLE_NAME: TComboBox;
    PAGE_B: TTabSheet;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ED_LB_FONT_STYLE: TComboBox;
    ED_LB_SUBTEXT: TSpinEdit;
    PAGE_C: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    ED_BC_HEIGHT: TSpinEdit;
    ED_BC_WIDTH: TSpinEdit;
    ED_BC_ROTAT: TSpinEdit;
    ED_BC_CODE_KIND: TComboBox;
    X_SET_OK: TButton;
    X_SET_CANCEL: TButton;
    X_SET_DEL: TButton;
    Label18: TLabel;
    ED_LB_ZOOM_W: TSpinEdit;
    ED_LB_ZOOM_H: TSpinEdit;
    Label19: TLabel;
    ED_PRINT_STYLE3: TPanel;
    Label17: TLabel;
    ED_SYSLST: TEdit;
    ED_BC_HUMAN: TRadioGroup;
    ED_LB_ROTAT: TSpinEdit;
    Label11: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    GroupBox1: TGroupBox;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Memo1: TMemo;
    procedure X_SET_CANCELClick(Sender: TObject);
    procedure X_SET_OKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure X_SET_DELClick(Sender: TObject);
    procedure ED_TABLE_NAMEChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label21Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMLBDSL: TFMLBDSL;

implementation

uses UNLBDS, DB_UTL, UN_UTL;

{$R *.DFM}

procedure TFMLBDSL.FormCreate(Sender: TObject);
begin
//取出 TALBLE
ED_TABLE_NAME.Items.Clear;
Session.GetTableNames('MAIN', '', FALSE,false,ED_TABLE_NAME.Items);
end;

procedure TFMLBDSL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
PAGE_B.TabVisible := TRUE;
PAGE_C.TabVisible := TRUE;
end;

procedure TFMLBDSL.X_SET_CANCELClick(Sender: TObject);
begin
CLOSE;
end;

procedure TFMLBDSL.X_SET_OKClick(Sender: TObject);
VAR S : TOBJECT;  //暂存对象
    N , ID : INTEGER;
begin

IF (ED_TABLE_NAME.TEXT <> '') AND (ED_FIELD_NAME.TEXT = '') THEN
   BEGIN
   SHOWMESSAGE('已设置数据域位名称,就必须设置数据表名!');   EXIT;
   END;

PAGE_B.TabVisible := TRUE;
PAGE_C.TabVisible := TRUE;

IF FMLBDS.FindComponent('S') = NIL THEN S := TOBJECT.Create;

   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
       BEGIN
       WITH FMLBDS.Components[N] DO
            BEGIN
            // LABEL ================================================
            IF (UPPERCASE(COPY(NAME,1,2)) = 'LB') AND
               (NAME = ED_NAME.Text )             THEN
               BEGIN
               S := FMLBDS.Components[N];
               WITH S AS TLBEDIT DO
                 BEGIN
                 CAPTION := ED_CAPTION.Text  ;
                 HEIGHT  := ED_HEIGHT .Value ;
                 WIDTH   := ED_WIDTH  .Value ;
                 LEFT    := ED_LEFT   .Value ;
                 TOP     := ED_TOP    .Value ;

                 _FONT_ZOOM_W := ED_LB_ZOOM_W .Value ;
                 _FONT_ZOOM_H := ED_LB_ZOOM_H .Value ;
                 _FONT_STYLE  := ED_LB_FONT_STYLE.ItemIndex;
                 _SUBTEXT     := ED_LB_SUBTEXT.Value ;
                 _ROTAT       := ED_LB_ROTAT  .Value ;
                 _TABLE_NAME := ED_TABLE_NAME .TEXT;
                 _FIELD_NAME := ED_FIELD_NAME .TEXT;
                 _SYSLST     := ED_SYSLST     .TEXT;
                 Refresh;
                 END;
               END;

            // BARCODE ================================================
            IF (UPPERCASE(COPY(NAME,1,2)) = 'BC') AND
               (NAME = ED_NAME.Text )             THEN
               BEGIN
               S := FMLBDS.Components[N];

               WITH S AS TBCEDIT DO
                  BEGIN
                  BARSTR := ED_CAPTION.Text;
                  LEFT   := ED_LEFT   .Value;
                  TOP    := ED_TOP    .Value;

                   _TABLE_NAME := ED_TABLE_NAME .TEXT;
                   _FIELD_NAME := ED_FIELD_NAME .TEXT;
                   _SYSLST     := ED_SYSLST     .TEXT;

                  _CODE_HEIGHT := ED_BC_HEIGHT .Value ;
                  _CODE_WIDTH  := ED_BC_WIDTH  .Value ;
                  _ROTAT       := ED_BC_ROTAT  .Value ;
                  _HUMAN       := ED_BC_HUMAN    .ItemIndex;
                  _CODE_STYLE  := ED_BC_CODE_KIND.ItemIndex;


               Refresh;
               END;
               END;

            END;

       END;

CLOSE;
end;


procedure TFMLBDSL.X_SET_DELClick(Sender: TObject);
VAR S : TOBJECT;  //暂存对象
    N : INTEGER;
begin

IF FMLBDS.FindComponent('S') = NIL THEN S := TOBJECT.Create;

   FOR N := 0 TO FMLBDS.ComponentCount-1 DO
       BEGIN
       WITH FMLBDS.Components[N] DO
            BEGIN
            IF (FMLBDS.Components[N].NAME = ED_NAME.TEXT) THEN
               BEGIN
               S := FMLBDS.Components[N];
               S.FREE;
               BREAK;
               END;
            END;
       END;
CLOSE;
end;

procedure TFMLBDSL.ED_TABLE_NAMEChange(Sender: TObject);
begin
ED_FIELD_NAME.Items.Clear;
IF ED_TABLE_NAME.TEXT <>'' THEN ED_FIELD_NAME.Items.TEXT := DB_QUERY_FIELDLIST(ED_TABLE_NAME.TEXT);
end;

procedure TFMLBDSL.FormShow(Sender: TObject);
begin
//QR_TABLE_LIST := 'BGDS';  // 列出的TABLE
IF ED_TABLE_NAME.TEXT <>'' THEN ED_FIELD_NAME.Items.TEXT := DB_QUERY_FIELDLIST(ED_TABLE_NAME.TEXT);
end;


procedure TFMLBDSL.Label21Click(Sender: TObject);
begin
JMSGFORM('字段设置',
'此三个字段只能一次使用一种'+#13+
'预设为"字段内容"，当"数据表名"有输入时，则以数据表名为主'+#13+
'　　　　　　　　　当"资料设置字段"有输入时，则以资料设置字段为主'+#13+
'字段内容'+#13+
'　－纯文字打印，在此格输入的文字会直接打印出来'+#13+
'数据表名'+#13+
'　－表名：为资料表的代号，根据您的需求来选择'+#13+
'　－字段名称：为资料表的代号，根据表格的关联来选择'+#13+
'资料设置字段'+#13+
'　－可作字段关联调用，EX:产品分类001=百货类，可印出百货类'+#13+
'　－关联代号请参考说明书'+#13+
''+#13+
'表名'+#13+
'BGDS ＝产品表　　　　→　条形码BGENO　名称BGNAM　'+#13+
'BCST ＝客户表　　　　→　编号BCENO　名称BCNAM　'+#13+
'BSUP ＝厂商表　　　　→　编号BSENO　名称BSNAM　'+#13+
'BMAN ＝人事表　　　　→　编号BNENO　名称BNNAM　'+#13+
'BMEM ＝会员或忠诚客户表　→　编号BMENO　名称BMNAM　'+#13+
''+#13+
''+#13+
''+#13
, 16);
end;

end.
