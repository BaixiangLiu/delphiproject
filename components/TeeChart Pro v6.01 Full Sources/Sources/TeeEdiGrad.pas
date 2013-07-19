{**********************************************}
{  TChartGradient Editor Dialog                }
{  Copyright (c) 1999-2003 by David Berneda    }
{**********************************************}
unit TeeEdiGrad;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeeProcs, TeePenDlg, TeCanvas;

type
  TTeeGradientEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    SBBalance: TScrollBar;
    LabelBalance: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    LRadialX: TLabel;
    LRadialY: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    BSwap: TButton;
    BStart: TButtonColor;
    BEnd: TButtonColor;
    BMid: TButtonColor;
    CBMid: TCheckBox;
    Panel1: TPanel;
    BOk: TButton;
    BCancel: TButton;
    Panel2: TPanel;
    CBVisible: TCheckBox;
    Label1: TLabel;
    CBDirection: TComboFlat;
    procedure CBVisibleClick(Sender: TObject);
    procedure CBDirectionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BSwapClick(Sender: TObject);
    procedure CBMidClick(Sender: TObject);
    procedure BMidClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure SBBalanceChange(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure BEndClick(Sender: TObject);
  private
    { Private declarations }
    Backup : TCustomTeeGradient;
    IModified  : Boolean;
    IOnlyStart : Boolean;
    SettingProps : Boolean;
    procedure CheckDirection;
    procedure CheckVisible;
  public
    { Public declarations }
    TheGradient : TCustomTeeGradient;
    Constructor CreateCustom(AOwner:TComponent; AGradient:TCustomTeeGradient);
    Procedure RefreshGradient(AGradient:TCustomTeeGradient);
  end;

Function EditTeeGradient(AOwner:TComponent; AGradient:TCustomTeeGradient):Boolean; overload;
Function EditTeeGradient(AOwner:TComponent; AGradient:TCustomTeeGradient;
                         OnlyStart:Boolean; HideVisible:Boolean=False):Boolean; overload;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeConst;

Function EditTeeGradient( AOwner:TComponent;
                          AGradient:TCustomTeeGradient):Boolean;
begin
  result:=EditTeeGradient(AOwner,AGradient,False,False);
end;

Function EditTeeGradient( AOwner:TComponent;
                          AGradient:TCustomTeeGradient;
                          OnlyStart:Boolean;
                          HideVisible:Boolean=False):Boolean;
begin
  With TeeCreateForm(TTeeGradientEditor,AOwner) as TTeeGradientEditor do
  try
    Tag:=Integer(AGradient);
    IOnlyStart:=OnlyStart;

    if IOnlyStart then
    begin
      BEnd.Visible:=False;
      BSwap.Visible:=False;
    end;

    CBVisible.Visible:=not HideVisible;
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Constructor TTeeGradientEditor.CreateCustom(AOwner:TComponent; AGradient:TCustomTeeGradient);
Begin
  inherited Create(AOwner);
  TheGradient:=AGradient;
  Tag:=Integer(TheGradient);
  Panel1.Visible:=False;
  BOk.Visible:=False;
  BCancel.Visible:=False;
  Height:=Height-BOk.Height;
end;

procedure TTeeGradientEditor.CheckVisible;
Begin
  EnableControls(IOnlyStart or TheGradient.Visible,
                 [CBDirection,BStart,CBMid,BMid,BEnd,BSwap]);
end;

procedure TTeeGradientEditor.CheckDirection;
var tmp : Boolean;
begin
  With TheGradient do
  begin
    tmp:=(Direction=gdFromCenter) or
         (Direction=gdRadial) or
         (Direction=gdFromTopLeft) or
         (Direction=gdFromBottomLeft);
    EnableControls(IOnlyStart or Visible and (not tmp),[CBMid,BMid]);
    EnableControls(Direction=gdRadial,[Label2,Label3,TrackBar1,TrackBar2]);
  end;
end;

procedure TTeeGradientEditor.CBVisibleClick(Sender: TObject);
begin
  IModified:=True;
  TheGradient.Visible:=CBVisible.Checked;
  CheckVisible;
end;

procedure TTeeGradientEditor.CBDirectionChange(Sender: TObject);
begin
  IModified:=True;
  TheGradient.Direction:=TGradientDirection(CBDirection.ItemIndex);
  CheckDirection;
end;

Procedure TTeeGradientEditor.RefreshGradient(AGradient:TCustomTeeGradient);
begin
  SettingProps:=True;
  Tag:=Integer(AGradient);
  TheGradient:=AGradient;
  if Assigned(TheGradient) then
  begin
    Backup.Free;
    Backup:=TChartGradient.Create(nil);
    Backup.Assign(TheGradient);

    With TheGradient do
    begin
      SBBalance.Position:=Balance;
      CBVisible.Checked:=Visible;
      CBDirection.ItemIndex:=Ord(Direction);
      CBMid.Checked:=MidColor=clNone;
      TrackBar1.Position:=RadialX;
      LRadialX.Caption:=IntToStr(RadialX);
      TrackBar2.Position:=RadialY;
      LRadialY.Caption:=IntToStr(RadialY);
    end;

    BStart.LinkProperty(TheGradient,'StartColor');
    BMid.LinkProperty(TheGradient,'MidColor');
    BEnd.LinkProperty(TheGradient,'EndColor');
    CheckVisible;
    CheckDirection;
  end;

  SettingProps:=False;
end;

procedure TTeeGradientEditor.FormShow(Sender: TObject);
begin
  RefreshGradient(TChartGradient(Tag));
  IModified:=False;
  TeeTranslateControl(Self);
end;

procedure TTeeGradientEditor.BCancelClick(Sender: TObject);
begin
  if IModified then
  begin
    TheGradient.Assign(Backup);
    TheGradient.Changed(Self);
  end;
end;

procedure TTeeGradientEditor.FormDestroy(Sender: TObject);
begin
  Backup.Free;
end;

procedure TTeeGradientEditor.BSwapClick(Sender: TObject);
var tmp : TColor;
begin
  IModified:=True;
  With TheGradient do
  begin
    tmp:=StartColor;
    StartColor:=EndColor;
    EndColor:=tmp;
  end;
  BStart.Repaint;
  BEnd.Repaint;
end;

procedure TTeeGradientEditor.CBMidClick(Sender: TObject);
begin
  if not SettingProps then
  begin
    IModified:=True;
    if CBMid.Checked then TheGradient.MidColor:=clNone
                     else TheGradient.UseMiddleColor;
    BMid.Repaint;
  end;
end;

procedure TTeeGradientEditor.BMidClick(Sender: TObject);
begin
  IModified:=True;
  CBMid.Checked:=TheGradient.MidColor=clNone;
end;

procedure TTeeGradientEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  BorderStyle:=TeeBorderStyle;
end;

procedure TTeeGradientEditor.TrackBar1Change(Sender: TObject);
begin
  IModified:=True;
  TheGradient.RadialX:=TrackBar1.Position;
  LRadialX.Caption:=IntToStr(TheGradient.RadialX);
end;

procedure TTeeGradientEditor.TrackBar2Change(Sender: TObject);
begin
  IModified:=True;
  TheGradient.RadialY:=TrackBar2.Position;
  LRadialY.Caption:=IntToStr(TheGradient.RadialY);
end;

procedure TTeeGradientEditor.SBBalanceChange(Sender: TObject);
begin
  if not SettingProps then
  begin
    IModified:=True;
    TheGradient.Balance:=SBBalance.Position;
  end;
  LabelBalance.Caption:=FormatFloat(TeeMsg_DefPercentFormat,TheGradient.Balance);
end;

procedure TTeeGradientEditor.BStartClick(Sender: TObject);
begin
  IModified:=True;
end;

procedure TTeeGradientEditor.BEndClick(Sender: TObject);
begin
  IModified:=True;
end;

end.
