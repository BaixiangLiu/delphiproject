unit cxtj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, dxPageControl,
  ExtCtrls, dxDBTLCl, dxGrClms, StdCtrls, Buttons, dxEditor, dxEdLib,
  ComCtrls, ToolWin, dxDBEdtr, dxDBELib,eseatclasses;

type
  Tfrmcxtj = class(TForm)
    dxPageControl1: TdxPageControl;
    dxTabSheet1: TdxTabSheet;
    dxTabSheet2: TdxTabSheet;
    dxTabSheet3: TdxTabSheet;
    dxPageControl2: TdxPageControl;
    dxTabSheet4: TdxTabSheet;
    dxTabSheet5: TdxTabSheet;
    dxTabSheet6: TdxTabSheet;
    Label9: TLabel;
    dxEdit1: TdxEdit;
    Label10: TLabel;
    dxDateEdit1: TdxDateEdit;
    Label11: TLabel;
    dxDateEdit2: TdxDateEdit;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Label7: TLabel;
    dxEdit2: TdxEdit;
    Label8: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    dxEdit3: TdxEdit;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel1: TPanel;
    dxDBGrid3: TdxDBGrid;
    dxDBGridMaskColumn1: TdxDBGridMaskColumn;
    dxDBGridMaskColumn2: TdxDBGridMaskColumn;
    dxDBGrid1Column7: TdxDBGridDateColumn;
    dxDBGrid1Column8: TdxDBGridTimeColumn;
    dxDBGridMaskColumn3: TdxDBGridMaskColumn;
    dxDBGridMaskColumn4: TdxDBGridMaskColumn;
    dxDBGridMaskColumn5: TdxDBGridMaskColumn;
    dxDBGridMaskColumn6: TdxDBGridMaskColumn;
    dxImageEdit1: TdxImageEdit;
    dxImageEdit2: TdxImageEdit;
    Label1: TLabel;
    dxImageEdit3: TdxImageEdit;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Column1: TdxDBGridMaskColumn;
    dxDBGrid1Column3: TdxDBGridMaskColumn;
    dxDBGrid1Column6: TdxDBGridMaskColumn;
    dxDBGrid1Column2: TdxDBGridMaskColumn;
    dxDBGrid1Column4: TdxDBGridMaskColumn;
    dxDBGrid1Column5: TdxDBGridMaskColumn;
    dxDBGrid2: TdxDBGrid;
    dxDBGridMaskColumn7: TdxDBGridMaskColumn;
    dxDBGridMaskColumn8: TdxDBGridMaskColumn;
    dxDBGridMaskColumn9: TdxDBGridMaskColumn;
    dxDBGridMaskColumn10: TdxDBGridMaskColumn;
    dxDBGridMaskColumn11: TdxDBGridMaskColumn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    meeting:Tmeeting;
    meetingroom:Tmeetingroom;
    people:Tmeetingpeople;
  public
    { Public declarations }
  end;

var
  frmcxtj: Tfrmcxtj;

implementation

{$R *.dfm}
uses dm_seat,clientappfunction;

procedure Tfrmcxtj.BitBtn3Click(Sender: TObject);
var filterstr:string;
begin
  filterstr:='';
  if (dxedit3.Text='') and (dximageedit1.text='') then
    people.getdata('',dmseat.aq_meetingpeople)
  else
  begin
    if dxedit3.text<>'' then filterstr:=filterstr+'name like ''%'+dxedit3.text+'%'' and ';
    if dximageedit1.text<>'' then filterstr:=filterstr+'status='''+dximageedit1.text+''' and ';

    filterstr:=copy(filterstr,1,length(filterstr)-5);
    people.getdata(filterstr,dmseat.aq_meetingpeople);
  end
end;

procedure Tfrmcxtj.BitBtn7Click(Sender: TObject);
var filterstr:string;
begin
  filterstr:='';
  if (dxedit1.Text='') and (dximageedit3.text='') and (dxdateedit1.text='') and (dxdateedit2.text='') then
    meeting.getdata('',dmseat.aq_meeting)
  else
  begin
    if dxedit1.text<>'' then filterstr:=filterstr+'name like ''%'+dxedit1.text+'%'' and ';
    if dximageedit3.text<>'' then filterstr:=filterstr+'status='''+dximageedit3.text+''' and ';
    if dxdateedit1.text<>'' then filterstr:=filterstr+'opendate>='''+dxdateedit1.text+''' and ';
    if dxdateedit2.text<>'' then filterstr:=filterstr+'opendate<'''+dxdateedit2.text+''' and ';
    filterstr:=copy(filterstr,1,length(filterstr)-5);
    meeting.getdata(filterstr,dmseat.aq_meeting);
  end
end;

procedure Tfrmcxtj.BitBtn8Click(Sender: TObject);
begin
//huiyireset
dxedit1.text:='';
dximageedit3.text:='';
dxdateedit1.text:='';
dxdateedit2.text:='';

end;

procedure Tfrmcxtj.BitBtn5Click(Sender: TObject);
var
  filterstr:string;
begin
  filterstr:='';
  if (dxedit1.Text='') and (dximageedit2.text='') then
    meetingroom.getdata('',dmseat.aq_meetingroom)
  else
  begin
    if dxedit1.text<>'' then filterstr:=filterstr+'name like ''%'+dxedit1.text+'%'' and ';
    if dximageedit2.text<>'' then filterstr:=filterstr+'status='''+dximageedit2.text+''' and ';

    filterstr:=copy(filterstr,1,length(filterstr)-5);
    meetingroom.getdata(filterstr,dmseat.aq_meetingroom);
  end

end;

procedure Tfrmcxtj.BitBtn6Click(Sender: TObject);
begin
  dxedit1.Text:='';
  dximageedit2.Text:='';
end;

procedure Tfrmcxtj.BitBtn4Click(Sender: TObject);
begin
    dxedit3.Text:='';
  dximageedit1.Text:='';
end;

procedure Tfrmcxtj.FormCreate(Sender: TObject);
begin
  meeting:=tmeeting.Create(nil);
  meetingroom:=tmeetingroom.Create(nil);
  people:=tmeetingpeople.Create(nil);
end;

procedure Tfrmcxtj.FormShow(Sender: TObject);
begin
  if dxpagecontrol1.ActivePage=dxtabsheet1 then
  getstatuslist('meetingroomstatus',dximageedit2);

  if dxpagecontrol1.ActivePage=dxtabsheet2 then
  getstatuslist('meetingstatus',dximageedit3);

  if dxpagecontrol1.ActivePage=dxtabsheet3 then
  getstatuslist('meetingpeople',dximageedit1);

end;

end.
