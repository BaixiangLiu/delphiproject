{**********************************************}
{   TeeChart Pro and TeeTree VCL About Form    }
{   Copyright (c) 1995-2003 by David Berneda   }
{**********************************************}
unit TeeAbout;
{$I TeeDefs.inc}

interface

uses {$IFDEF LINUX}
     Libc,
     {$ELSE}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     Qt, QGraphics, QControls, QForms, QExtCtrls, QStdCtrls,
     {$ELSE}
     Graphics, Controls, Forms, ExtCtrls, StdCtrls,
     {$ENDIF}
     Classes, SysUtils;

type
  TTeeAboutForm = class(TForm)
    BClose: TButton;
    Image2: TImage;
    LabelCopy: TLabel;
    LabelVersion: TLabel;
    Label1: TLabel;
    Labelwww: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    LabelEval: TLabel;
    procedure LabelwwwClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TeeWindowHandle={$IFDEF CLX}QOpenScrollViewH{$ELSE}Integer{$ENDIF};

Procedure GotoURL(Handle:TeeWindowHandle; Const URL:String);

{ Displays the TeeChart about-box dialog }
Procedure TeeShowAboutBox(Const ACaption:String=''; Const AVersion:String='');

Var TeeAboutBoxProc:Procedure=nil;
    TeeIsTrial:Boolean=False;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFNDEF LINUX}
     ShellApi,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeConst;

Procedure TeeShowAboutBox(Const ACaption:String=''; Const AVersion:String='');
var tmp : TTeeAboutForm;
begin
  tmp:=TTeeAboutForm.Create(nil);
  with tmp do
  try
    if ACaption<>'' then Caption:=ACaption;
    if AVersion<>'' then LabelVersion.Caption:=AVersion;
  
    if TeeIsTrial then
       LabelEval.Caption:=LabelEval.Caption+' TRIAL';

    TeeTranslateControl(tmp);
    ShowModal;
  finally
    Free;
  end;
end;

Procedure GotoURL(Handle: TeeWindowHandle; Const URL:String);
{$IFNDEF LINUX}
Var St : TeeString256;
{$ENDIF}
begin
  {$IFNDEF LINUX}
  ShellExecute({$IFDEF CLX}0{$ELSE}Handle{$ENDIF},'open',
                 StrPCopy(St,URL),nil,nil,SW_SHOW);  { <-- do not translate }
  {$ENDIF}
end;

procedure TTeeAboutForm.LabelwwwClick(Sender: TObject);
begin
  GotoURL(Handle,LabelWWW.Caption);
end;

procedure TTeeAboutForm.FormPaint(Sender: TObject);
begin
  {$IFNDEF CLX}  // CLX repaints on top of form !
  With TTeeCanvas3D.Create do
  try
    ReferenceCanvas:=Self.Canvas;
    GradientFill(ClientRect,$E0E0E0,clDkGray,gdRadial);
  finally
    Free;
  end;
  {$ENDIF}
end;

procedure TTeeAboutForm.FormCreate(Sender: TObject);
begin
  Caption:=Caption+' '+TeeMsg_Version;
  LabelVersion.Caption:=TeeMsg_Version {$IFDEF CLX}+' CLX'{$ENDIF};
  LabelCopy.Caption:=TeeMsg_Copyright;
  BorderStyle:=TeeBorderStyle;
end;

Procedure TeeShowAboutBox2;
begin
  if Assigned(TeeAboutBoxProc) then
  begin
    TeeShowAboutBox;
    TeeAboutBoxProc:=nil;
  end;
end;

initialization
  TeeAboutBoxProc:=TeeShowAboutBox2;
finalization
  TeeAboutBoxProc:=nil;
end.
