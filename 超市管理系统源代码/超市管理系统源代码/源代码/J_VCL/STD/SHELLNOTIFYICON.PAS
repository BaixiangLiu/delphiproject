unit ShellNotifyIcon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ShellAPI;

type
  { TShellNotifyIcon - Component by Oliver Dillinger, AUSTRIA
    Use this component to create an icon to the task notification area (thats the
    panel on the taskbar where the clock is). Simply add this file to your VCL
    and then place the ShellNotifyIcon-Component, which will appear on the
    Win95-tab on the main form of your application.

    Description of the properties:
      *) Icon: specifies the icon you want to be showed in the taskbar
      *) Tip: the text which will be shown as a tooltip when the user places the
         cursor over your icon
      *) Visible: is the icon visible?
      *) OnDlbClick: this event is fired when the user double-clicks on then icon
      *) OnMouseDown: the mouse-button is down
      *) OnMouseUp: vice versa

    If you have questions about this component or if you only want to tell that
    my English is ugly then send me an e-mail: schlabo@geocities.com

    This component has been designed using Delphi 2.01 in 1998.
  }

  TShellMouseBtnEvent = procedure(Sender: TObject; Button: TMouseButton; X, Y: Integer) of object;
  TShellDblClick = procedure(Sender: TObject; Button: TMouseButton) of object;
  EShellNotifyIcon = class(Exception);
  TShellNotifyIcon = class(TComponent)
  private
    FIconData: TNotifyIconData;
    FHookWindow: THandle;
    FIcon: TIcon;
    FTip: string;
    FVisible: Boolean;
    FOnDblClick: TShellDblClick;
    FOnMouseDown, FOnMouseUp: TShellMouseBtnEvent;
    procedure WindowProc(var Message: TMessage);
    procedure SetIcon(AIcon: TIcon);
    procedure SetTip(ATip: string);
    procedure SetVisible(AValue: Boolean);
    procedure AddIcon;
    procedure DeleteIcon;
  protected
    procedure Loaded; override;
    procedure DblClick(Button: TMouseButton); dynamic;
    procedure MouseDown(Button: TMouseButton); dynamic;
    procedure MouseUp(Button: TMouseButton); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Icon: TIcon read FIcon write SetIcon;
    property Tip: string read FTip write SetTip;
    property Visible: Boolean read FVisible write SetVisible;
    property OnDblClick: TShellDblClick read FOnDblClick write FOnDblClick;
    property OnMouseDown: TShellMouseBtnEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TShellMouseBtnEvent read FOnMouseUp write FOnMouseUp;
  end;

procedure Register;

implementation

const
  WM_ICONMESSAGE = WM_USER + 59;

constructor TShellNotifyIcon.Create(AOwner: TComponent);
begin
  inherited;
  ZeroMemory(@FIconData, SizeOf(TNotifyIconData));
  FIcon := TIcon.Create;
  FHookWindow := AllocateHWnd(WindowProc);
  if FHookWindow = 0 then
    raise EShellNotifyIcon.Create('HookWindow konnte nicht erstellt werden.');
end;

destructor TShellNotifyIcon.Destroy;
begin
  FIcon.Free;
  if FHookWindow <> 0 then DeAllocateHWnd(FHookWindow);
  if not (csDesigning in ComponentState) then DeleteIcon;
  inherited;
end;

procedure TShellNotifyIcon.WindowProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_ICONMESSAGE: begin
      case Message.lParam of
        WM_LBUTTONDBLCLK: DblClick(mbLeft);
        WM_MBUTTONDBLCLK: DblClick(mbMiddle);
        WM_RBUTTONDBLCLK: DblClick(mbRight);
        WM_LBUTTONDOWN: MouseDown(mbLeft);
        WM_MBUTTONDOWN: MouseDown(mbMiddle);
        WM_RBUTTONDOWN: MouseDown(mbRight);
        WM_LBUTTONUP: MouseUp(mbLeft);
        WM_MBUTTONUP: MouseUp(mbMiddle);
        WM_RBUTTONUP: MouseUp(mbRight);
      end;
    end;
    else Dispatch(Message);
  end;
end;

procedure TShellNotifyIcon.SetIcon(AIcon: TIcon);
begin
  FIcon.Assign(AIcon);
  if csDesigning in ComponentState then Exit;
  FIconData.hIcon := FIcon.Handle;
  Shell_NotifyIcon(NIM_MODIFY, @FIconData);
end;

procedure TShellNotifyIcon.SetTip(ATip: string);
begin
  if Length(ATip) > 64 then FTip := Copy(ATip, 1, 64)
  else FTip := ATip;
  if csDesigning in ComponentState then Exit;
  CopyMemory(@FIconData.szTip, @FTip, SizeOf(FTip));
  Shell_NotifyIcon(NIM_MODIFY, @FIconData);
end;

procedure TShellNotifyIcon.SetVisible(AValue: Boolean);
begin
  FVisible := AValue;
  if (csDesigning in ComponentState) then Exit;
  if FVisible then AddIcon
  else DeleteIcon;
end;

procedure TShellNotifyIcon.AddIcon;
begin
  if FVisible then Shell_NotifyIcon(NIM_ADD, @FIconData);
end;

procedure TShellNotifyIcon.DeleteIcon;
begin
  Shell_NotifyIcon(NIM_DELETE, @FIconData);
end;

procedure TShellNotifyIcon.Loaded;
begin
  inherited;
  if csDesigning in ComponentState then Exit;
  with FIconData do
  begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd := FHookWindow;
    uID := 59;
    uFlags := NIF_TIP or NIF_ICON or NIF_MESSAGE;
    uCallbackMessage := WM_ICONMESSAGE;
    hIcon := FIcon.Handle;
    CopyMemory(@FIconData.szTip, PChar(FTip), Length(FTip));
  end;
  AddIcon;
end;

procedure TShellNotifyIcon.DblClick(Button: TMouseButton);
begin
  if Assigned(FOnDblClick) then FOnDblClick(Self, Button);
end;

procedure TShellNotifyIcon.MouseDown(Button: TMouseButton);
var
  CursorPos: TPoint;
begin
  GetCursorPos(CursorPos);
  if Assigned(FOnMouseDown) then FOnMouseDown(Self, Button, CursorPos.X, CursorPos.Y);
end;

procedure TShellNotifyIcon.MouseUp(Button: TMouseButton);
var
  CursorPos: TPoint;
begin
  GetCursorPos(CursorPos);
  if Assigned(FOnMouseUp) then FOnMouseUp(Self, Button, CursorPos.X, CursorPos.Y);
end;

procedure Register;
begin
  RegisterComponents('J_STD', [TShellNotifyIcon]);
end;

end.
