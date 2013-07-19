{********************************************}
{      TeeOpenGL Editor Component            }
{   Copyright (c) 1999-2003 by David Berneda }
{         All Rights Reserved                }
{********************************************}
unit TeeGLEditor;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QExtCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, ExtCtrls, StdCtrls,
  {$ENDIF}
  TeeOpenGL, TeCanvas, TeeProcs, TeePenDlg;

type
  TTeeOpenGLBackup=packed record
    Active                 : Boolean;
    AmbientLight           : Integer;
    FontOutlines           : Boolean;
    LightColor             : TColor;
    LightVisible           : Boolean;
    LightX                 : Double;
    LightY                 : Double;
    LightZ                 : Double;
    ShadeQuality           : Boolean;
    Shininess              : Double;
    TeeOpenGLFontExtrusion : Integer;
    DrawStyle              : TTeeCanvasSurfaceStyle;
  end;

  TFormTeeGLEditor = class(TForm)
    CBActive: TCheckBox;
    BOK: TButton;
    BCancel: TButton;
    TabControl1: TTabControl;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CheckBox4: TCheckBox;
    TBX: TTrackBar;
    TBY: TTrackBar;
    TBZ: TTrackBar;
    TrackBar5: TTrackBar;
    BLightColor: TButtonColor;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    CBOutlines: TCheckBox;
    CBShade: TCheckBox;
    TBAmbient: TTrackBar;
    TBShine: TTrackBar;
    UDDepth: TUpDown;
    Edit1: TEdit;
    Label3: TLabel;
    CBStyle: TComboFlat;
    procedure BOKClick(Sender: TObject);
    procedure CBShadeClick(Sender: TObject);
    procedure CBOutlinesClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TBShineChange(Sender: TObject);
    procedure TBAmbientChange(Sender: TObject);
    procedure CBActiveClick(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TBXChange(Sender: TObject);
    procedure TBYChange(Sender: TObject);
    procedure TBZChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    GL           : TTeeOpenGL;
    GLBackup     : TTeeOpenGLBackup;
    Procedure SetLight(ALight:TGLLightSource);
    function TheLight:TGLLightSource;
  public
    { Public declarations }
  end;

Function EditTeeOpenGL(AOwner:TComponent; ATeeOpenGL:TTeeOpenGL):Boolean;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeGLCanvas, TeeEditCha;

Function EditTeeOpenGL(AOwner:TComponent; ATeeOpenGL:TTeeOpenGL):Boolean;
begin
  With TFormTeeGLEditor.Create(AOwner) do
  try
    Tag:=Integer(ATeeOpenGL);
    result:=ShowModal=mrOk;
  finally
    Free;
  end
end;

procedure TFormTeeGLEditor.BOKClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFormTeeGLEditor.CBShadeClick(Sender: TObject);
begin
  if not CreatingForm then GL.ShadeQuality:=CBShade.Checked;
end;

procedure TFormTeeGLEditor.CBOutlinesClick(Sender: TObject);
begin
  if not CreatingForm then GL.FontOutlines:=CBOutlines.Checked;
end;

procedure TFormTeeGLEditor.Edit1Change(Sender: TObject);
begin
  if not CreatingForm then
  begin
    TeeOpenGLFontExtrusion:=UDDepth.Position;
    GL.Canvas.DeleteFont;
    GL.TeePanel.Repaint;
  end;
end;

procedure TFormTeeGLEditor.TBShineChange(Sender: TObject);
begin
  if not CreatingForm then GL.Shininess:=TBShine.Position*0.01;
end;

procedure TFormTeeGLEditor.TBAmbientChange(Sender: TObject);
begin
  if not CreatingForm then GL.AmbientLight:=TBAmbient.Position;
end;

procedure TFormTeeGLEditor.CBActiveClick(Sender: TObject);
begin
  if not CreatingForm then GL.Active:=CBActive.Checked;
end;

function TFormTeeGLEditor.TheLight:TGLLightSource;
begin
  if TabControl1.TabIndex=0 then result:=GL.Light0
  else
  if TabControl1.TabIndex=1 then result:=GL.Light1
  else
    result:=GL.Light2;
end;

procedure TFormTeeGLEditor.CheckBox4Click(Sender: TObject);
begin
  if not CreatingForm then TheLight.Visible:=CheckBox4.Checked;
end;

procedure TFormTeeGLEditor.TrackBar5Change(Sender: TObject);
begin
  if not CreatingForm then
  With TheLight,TrackBar5 do
  begin
    Color:=RGB(Position,Position,Position);
    BLightColor.Repaint;
  end;
end;

procedure TFormTeeGLEditor.TBXChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Position.X:=TBX.Position;
end;

procedure TFormTeeGLEditor.TBYChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Position.Y:=TBY.Position;
end;

procedure TFormTeeGLEditor.TBZChange(Sender: TObject);
begin
  if not CreatingForm then TheLight.Position.Z:=TBZ.Position;
end;

procedure TFormTeeGLEditor.FormShow(Sender: TObject);
begin
  GL:=TTeeOpenGL(Tag);
  if Assigned(GL) then
  With GL do
  begin
    CBShade.Checked:=ShadeQuality;
    CBOutlines.Checked:=FontOutlines;
    CBStyle.ItemIndex:=Ord(DrawStyle);
    UDDepth.Position:=TeeOpenGLFontExtrusion;
    TBShine.Position:=Round(Shininess*100.0);
    TBAmbient.Position:=AmbientLight;
    CBActive.Checked:=Active;

    SetLight(Light0);

    GLBackup.ShadeQuality:=ShadeQuality;
    GLBackup.FontOutlines:=FontOutlines;
    GLBackup.DrawStyle:=DrawStyle;
    GLBackup.TeeOpenGLFontExtrusion:=TeeOpenGLFontExtrusion;
    GLBackup.Shininess:=Shininess;
    GLBackup.AmbientLight:=AmbientLight;
    GLBackup.Active:=Active;
  end;
  CreatingForm:=False;
end;

Procedure TFormTeeGLEditor.SetLight(ALight:TGLLightSource);
begin
  CheckBox4.Checked:=ALight.Visible;
  TrackBar5.Position:=GetRValue(ALight.Color);
  with ALight.Position do
  begin
    TBX.Position:=Round(X);
    TBY.Position:=Round(Y);
    TBZ.Position:=Round(Z);
  end;
  BLightColor.LinkProperty(ALight,'Color');

  GLBackup.LightVisible:=ALight.Visible;
  GLBackup.LightColor:=ALight.Color;
  with ALight.Position do
  begin
    GLBackup.LightX:=X;
    GLBackup.LightY:=Y;
    GLBackup.LightZ:=Z;
  end;
end;

procedure TFormTeeGLEditor.BCancelClick(Sender: TObject);
begin
  With GL do
  begin
    ShadeQuality:=GLBackup.ShadeQuality;
    FontOutlines:=GLBackup.FontOutlines;
    DrawStyle:=GLBackup.DrawStyle;

    if TeeOpenGLFontExtrusion<>GLBackup.TeeOpenGLFontExtrusion then
    begin
      TeeOpenGLFontExtrusion:=GLBackup.TeeOpenGLFontExtrusion;
      Canvas.DeleteFont;
    end;

    Shininess     :=GLBackup.Shininess;
    AmbientLight  :=GLBackup.AmbientLight;
    Active        :=GLBackup.Active;

    With TheLight do
    begin
      Visible:=GLBackup.LightVisible;
      Color  :=GLBackup.LightColor;
      with Position do
      begin
        X:=GLBackup.LightX;
        Y:=GLBackup.LightY;
        Z:=GLBackup.LightZ;
      end;
    end;
  end;
  ModalResult:=mrCancel;
end;

procedure TFormTeeGLEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  BorderStyle:=TeeBorderStyle;
  TabControl1.Tabs.Clear;
  TabControl1.Tabs.Add('Light 0'); // <--- do not translate
  TabControl1.Tabs.Add('Light 1'); // <--- do not translate
  TabControl1.Tabs.Add('Light 2'); // <--- do not translate
  TeeTranslateControl(Self);
end;

type TTeePanelAccess=class(TCustomTeePanel);

Procedure TeeOpenGLShowEditor(Editor:TChartEditForm);
var tmp     : TTabSheet;
    tmpForm : TFormTeeGLEditor;
    tmpGL   : TComponent;
begin
  if Assigned(Editor) and Assigned(Editor.Chart) then
  begin
    tmpGL:=TTeePanelAccess(Editor.Chart).GLComponent;
    if Assigned(tmpGL)
       {$IFDEF TEEOCX}
       and
        ( (not (cetOpenGL in Editor.TheHiddenTabs)) or { 5.02 }
          ( (cetOpenGL in Editor.TheHiddenTabs) and TTeeOpenGL(tmpGL).Active )
        )
        {$ENDIF}
        then
    begin
      tmp:=TTabSheet.Create(Editor);
      tmp.Caption:='OpenGL';
      tmp.PageControl:=Editor.MainPage;
      tmpForm:=TFormTeeGLEditor.Create(Editor);
      ShowControls(False,[tmpForm.BOk,tmpForm.BCancel]);

      tmpForm.CBActive.Checked:=TTeeOpenGL(tmpGL).Active; { 5.02 }

      {$IFDEF TEEOCX}
      if (cetOpenGL in Editor.TheHiddenTabs) and TTeeOpenGL(tmpGL).Active then
         tmpForm.CBActive.Visible:=False;
      {$ENDIF}

      AddFormTo(tmpForm,tmp,Integer(TTeeOpenGL(tmpGL)));
    end;
  end;
end;

procedure TFormTeeGLEditor.TabControl1Change(Sender: TObject);
begin
  SetLight(TheLight);
end;

procedure TFormTeeGLEditor.CBStyleChange(Sender: TObject);
begin
  if not CreatingForm then
     GL.DrawStyle:=TTeeCanvasSurfaceStyle(CBStyle.ItemIndex);
end;

initialization
  TeeOnShowEditor:=TeeOpenGLShowEditor;
finalization
  TeeOnShowEditor:=nil;
end.
