{**********************************************}
{   TeeChart Pro 3D editor options             }
{   Copyright (c) 1999-2003 by David Berneda   }
{**********************************************}
unit TeeEdi3D;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     TeePenDlg,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     TeeProcs, TeCanvas, Chart;

type
  TFormTee3D = class(TForm)
    GB3D: TGroupBox;
    L13: TLabel;
    L4: TLabel;
    L35: TLabel;
    L36: TLabel;
    CBView3d: TCheckBox;
    SE3d: TEdit;
    CBOrthogonal: TCheckBox;
    SBZoom: TTrackBar;
    LZoom: TLabel;
    SBRotation: TTrackBar;
    SBElevation: TTrackBar;
    LRotation: TLabel;
    LElevation: TLabel;
    Label1: TLabel;
    SBHOffset: TTrackBar;
    LHOffset: TLabel;
    Label3: TLabel;
    SBVOffset: TTrackBar;
    LVOffset: TLabel;
    UD3D: TUpDown;
    CBZoomText: TCheckBox;
    Label2: TLabel;
    SBPerspec: TTrackBar;
    LPerspec: TLabel;
    Label4: TLabel;
    EOrthoAngle: TEdit;
    UDOrthoAngle: TUpDown;
    CBClipPoints: TCheckBox;
    ETextSize: TEdit;
    UDTextSize: TUpDown;
    LTextSize: TLabel;
    procedure CBOrthogonalClick(Sender: TObject);
    procedure SBZoomChange(Sender: TObject);
    procedure SBRotationChange(Sender: TObject);
    procedure SBElevationChange(Sender: TObject);
    procedure CBView3dClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBHOffsetChange(Sender: TObject);
    procedure SBVOffsetChange(Sender: TObject);
    procedure SE3dChange(Sender: TObject);
    procedure CBZoomTextClick(Sender: TObject);
    procedure SBPerspecChange(Sender: TObject);
    procedure EOrthoAngleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBClipPointsClick(Sender: TObject);
    procedure ETextSizeChange(Sender: TObject);
  private
    { Private declarations }
    TheChart : TCustomChart;
    Function GetRotation:Integer;
  public
    { Public declarations }
    AllowRotation : Boolean;
    Constructor CreateChart(AOwner:TComponent; AChart:TCustomChart);
    Procedure CheckRotation;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Constructor TFormTee3D.CreateChart(AOwner:TComponent; AChart:TCustomChart);
begin
  inherited Create(AOwner);
  TheChart:=AChart;
end;

Procedure TFormTee3D.CheckRotation;
begin
  With TheChart do
  begin
    CBOrthogonal.Enabled:=View3D and AllowRotation;
    SBRotation.Enabled  :=CBOrthogonal.Enabled and (not View3DOptions.Orthogonal);
    SBElevation.Enabled :=SBRotation.Enabled;
    EOrthoAngle.Enabled:=CBOrthogonal.Enabled;
    UDOrthoAngle.Enabled:=EOrthoAngle.Enabled;
  end;
end;

procedure TFormTee3D.CBOrthogonalClick(Sender: TObject);
begin
  With TheChart.View3DOptions do
  begin
    Orthogonal:=CBOrthogonal.Checked;
    SBRotation.Enabled:=(not Orthogonal) and AllowRotation;
    SBElevation.Enabled:=not Orthogonal;
    SBPerspec.Enabled:=not Orthogonal;
    EOrthoAngle.Enabled:=Orthogonal;
    UDOrthoAngle.Enabled:=Orthogonal;
  end;
end;

procedure TFormTee3D.SBZoomChange(Sender: TObject);
begin
  TheChart.View3DOptions.Zoom:=SBZoom.Position;
  LZoom.Caption:=IntToStr(SBZoom.Position)+'%';
end;

Function TFormTee3D.GetRotation:Integer;
begin
  result:=SBRotation.Position;
  if not TheChart.Canvas.SupportsFullRotation then
  begin
    if result>270 then Dec(result,270)
                  else Inc(result,90);
  end;
end;

procedure TFormTee3D.SBRotationChange(Sender: TObject);
var tmp : Integer;
begin
  if Showing then
  begin
    tmp:=GetRotation;
    if Assigned(TheChart) and
       Assigned(TheChart.View3DOptions) then
       TheChart.View3DOptions.Rotation:=tmp;
    LRotation.Caption:=IntToStr(tmp);
  end;
end;

procedure TFormTee3D.SBElevationChange(Sender: TObject);
begin
  if Assigned(TheChart) and
     Assigned(TheChart.View3DOptions) then
     TheChart.View3DOptions.Elevation:=SBElevation.Position;
  LElevation.Caption:=IntToStr(SBElevation.Position);
end;

procedure TFormTee3D.CBView3dClick(Sender: TObject);
var tmp:Boolean;
begin
  With TheChart do
  Begin
    View3D              :=CBView3D.Checked;
    SE3D.Enabled        :=View3D;
    UD3D.Enabled        :=SE3D.Enabled;
    CBOrthogonal.Enabled:=View3D and AllowRotation;
    tmp:=View3D and (not View3DOptions.Orthogonal);
    SBRotation.Enabled:=tmp and AllowRotation;
    SBElevation.Enabled:=tmp;
    SBPerspec.Enabled:=tmp;
    SBHOffset.Enabled:=View3D;
    SBVOffset.Enabled:=View3D;
    SBZoom.Enabled:=View3D;
    CBZoomText.Enabled:=View3D;
    EOrthoAngle.Enabled:=CBOrthogonal.Enabled;
    UDOrthoAngle.Enabled:=EOrthoAngle.Enabled;
  end;
end;

procedure TFormTee3D.FormShow(Sender: TObject);
begin
  if Assigned(TheChart) then
  With TheChart do
  begin
    CBView3D.Checked :=View3D;
    SE3D.Enabled     :=View3D;
    UD3D.Position    :=Chart3DPercent;
    CBClipPoints.Checked:=ClipPoints;

    ETextSize.Visible:=not (csDesigning in ComponentState);
    UDTextSize.Visible:=ETextSize.Visible;
    LTextSize.Visible:=ETextSize.Visible;

    if Canvas.SupportsFullRotation then
    begin
      SBRotation.Min:=0;
      SBRotation.Frequency:=20;
      SBElevation.Min:=0;
      SBElevation.Frequency:=20;
    end
    else
    begin
      SBRotation.Min:=180;
      SBRotation.Frequency:=10;
      SBElevation.Min:=TeeMinAngle;
      SBElevation.Frequency:=10;
    end;

    CBOrthogonal.Enabled :=View3D and AllowRotation;

    With View3DOptions do
    begin
      SBZoom.Position      :=Zoom;
      CBOrthogonal.Checked :=Orthogonal;

      if Canvas.SupportsFullRotation then
         SBRotation.Position:=Rotation
      else
      begin
        if Rotation>=270 then SBRotation.Position:=Rotation-90
                         else SBRotation.Position:=Rotation+270;
      end;

      SBElevation.Position :=Elevation;
      SBHOffset.Position   :=HorizOffset;
      SBVOffset.Position   :=VertOffset;
      SBRotation.Enabled   :=CBOrthogonal.Enabled and (not Orthogonal);
      CBZoomText.Checked   :=ZoomText;
      SBPerspec.Position   :=Perspective;
      UDOrthoAngle.Position:=OrthoAngle;
    end;
    EOrthoAngle.Enabled:=CBOrthogonal.Enabled;
    UDOrthoAngle.Enabled:=EOrthoAngle.Enabled;
  end;
end;

procedure TFormTee3D.SBHOffsetChange(Sender: TObject);
begin
  TheChart.View3DOptions.HorizOffset:=SBHOffset.Position;
  LHOffset.Caption:=IntToStr(SBHOffset.Position);
end;

procedure TFormTee3D.SBVOffsetChange(Sender: TObject);
begin
  TheChart.View3DOptions.VertOffset:=SBVOffset.Position;
  LVOffset.Caption:=IntToStr(SBVOffset.Position);
end;

procedure TFormTee3D.SE3dChange(Sender: TObject);
begin
  if Showing then TheChart.Chart3DPercent:=UD3D.Position;
end;

procedure TFormTee3D.CBZoomTextClick(Sender: TObject);
begin
  TheChart.View3DOptions.ZoomText:=CBZoomText.Checked;
end;

procedure TFormTee3D.SBPerspecChange(Sender: TObject);
begin
  TheChart.View3DOptions.Perspective:=SBPerspec.Position;
  LPerspec.Caption:=IntToStr(SBPerspec.Position);
end;

procedure TFormTee3D.EOrthoAngleChange(Sender: TObject);
begin
  if Showing then TheChart.View3DOptions.OrthoAngle:=UDOrthoAngle.Position;
end;

procedure TFormTee3D.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TFormTee3D.CBClipPointsClick(Sender: TObject);
begin
  TheChart.ClipPoints:=CBClipPoints.Checked;
end;

procedure TFormTee3D.ETextSizeChange(Sender: TObject);
begin
  if Showing then
  begin
    TheChart.Canvas.FontZoom:=UDTextSize.Position;
    TheChart.Invalidate;
  end;
end;

end.
