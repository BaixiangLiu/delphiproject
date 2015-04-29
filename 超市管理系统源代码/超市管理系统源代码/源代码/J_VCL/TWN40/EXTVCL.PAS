
{*******************************************************}
{                                                       }
{       Delphi Visual Component Library Extension       }
{                                                       }
{       Copyright (c) 1996 Louis L.J.Wang               }
{                                                       }
{*******************************************************}

unit ExtVCL;

{$R-}

interface

uses
  SysUtils, Windows, Messages, Classes, Controls, Forms;

const

{ TResizeControl control messages }

  RSM_BASE         = $AF80;

{ RSM_GETSETLIMITS, controls can send this message to a TResizeControl
  to set new limits or get the current limits. Since TResizeControl is
  NOT a windowed control but a spy of its HOST control, you should pass
  this message to its associated control, TResizeControl will intercept
  this message.

  The 'Get' request is processed BEFORE the 'Set' request, so the result
  value will be the original settings if you specify 'Set' and 'Get' at
  the same time.

  For the 'Get' request, the minimum limit is returned in the lower order
  word of the result, while the maximum limit is returned in the higher
  order word, and the LIMIT_GETWIDTHLIMITS flag has higher priority than
  the LIMIT_GETHEIGHTLIMITS, therefore the result will be WIDTH LIMITS if
  you set them all together. }

  RSM_GETSETLIMITS = RSM_BASE + 0;

{ TResizeControl notification messages }

  RSN_BASE         = $AF90;

{ RSN_SIZE, TResizeControl broadcast this notification message to all
  windowed controls of its host control if WM_SIZE message is received,
  along with the original and the new Width/Height of the host control. }

  RSN_SIZE         = RSN_BASE + 0;

{ bitfield constants for Flags field of GetSetFlags }

  LIMIT_GETWIDTHLIMITS  = $00000001;
  LIMIT_GETHEIGHTLIMITS = $00000002;
  LIMIT_SETWIDTHMIN     = $00000004;
  LIMIT_SETWIDTHMAX     = $00000008;
  LIMIT_SETHEIGHTMIN    = $00000010;
  LIMIT_SETHEIGHTMAX    = $00000020;

{ Message structures }

type

  TResizeLimit = -1..MaxInt;

{ structure for fpSetLimits }

  PSetLimitsParams = ^TSetLimitsParams;
  TSetLimitsParams = record
    dwWidthMin: TResizeLimit;
    dwWidthMax: TResizeLimit;
    dwHeightMin: TResizeLimit;
    dwHeightMax: TResizeLimit;
  end;

{ structure for fpResizingInfo }

  PSizeInfo = ^TSizeInfo;
  TSizeInfo = record
    OriginWidth: Integer;
    OriginHeight: Integer;
    NewWidth: Integer;
    NewHeight: Integer;
  end;

{ message for RSM_GETSETLIMITS }

  TRSMGetSetLimits = record
    Msg: Cardinal;
    GetSetFlags: Integer;
    fpSetLimits: PSetLimitsParams;
    Result: Longint;
  end;

  TRSNSize = record
    Msg: Cardinal;
    SizeType: Longint; { same as TWMSize }
    fpSizeInfo: PSizeInfo;
    Result: Longint;
  end;

{ Event types not defined in VCL }

  TMsgSource = (msBroadcast, msWindow);
  TMsgEvent = procedure(Control: TWinControl; var Message: TMessage;
    Source: TMsgSource; var Handled: Boolean) of object;

{ TCustomSpy }

  TCustomSpy = class(TComponent)
  private
    FObjectInstance: Pointer;
    FHostWndProc: Pointer;
    FHostDefWndProc: Pointer;
    FHostWndMethod: TWndMethod;
    FControl: TWinControl;
    FIsWindowMessage: Boolean;
    FOnMessage: TMsgEvent;
    function GetControl: TWinControl;
    procedure SetControl(AControl: TWinControl);
  protected
    procedure Loaded; override;
    procedure Invalidate; virtual;
    procedure MainWndProc(var Message: TMessage);
    procedure WndProc(var Message: TMessage); virtual;
    procedure DefaultHandler(var Message: TMessage); virtual;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
    property Control: TWinControl read GetControl write SetControl;
    property OnMessage: TMsgEvent read FOnMessage write FOnMessage;
  public
    procedure HookHost;
    procedure UnhookHost;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TWinControlSpy }

  TWinControlSpy = class(TCustomSpy)
  published
    property Control;
    property OnMessage;
  end;

{ TResizeControl }

const
  rcFixed = -1;
  rcFree  = 0;
  rcRange = 1;

type
  TResizeStyle = set of (rsFixed, rsLimitMin, rsLimitMax);

  TResizeControl = class(TCustomSpy)
  private
    FLimits: array[0..3] of TResizeLimit;
    FOriginWidth: Integer;
    FOriginHeight: Integer;
    function GetLimit(Index: Integer): TResizeLimit;
    procedure SetLimit(Index: Integer; Value: TResizeLimit);
    function GetWidthStyle: TResizeStyle;
    function GetHeightStyle: TResizeStyle;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure RSMGetSetLimits(var Message: TRSMGetSetLimits); message RSM_GETSETLIMITS;
  protected
    procedure Invalidate; override;
  public
    property WidthStyle: TResizeStyle read GetWidthStyle;
    property HeightStyle: TResizeStyle read GetHeightStyle;
  published
    property Control;
    property WidthMin: TResizeLimit index 0 read GetLimit write SetLimit default rcFree;
    property WidthMax: TResizeLimit index 1 read GetLimit write SetLimit default rcFree;
    property HeightMin: TResizeLimit index 2 read GetLimit write SetLimit default rcFree;
    property HeightMax: TResizeLimit index 3 read GetLimit write SetLimit default rcFree;
  end;

{ Size controls }

{ TCustomSizeControl }

  TDragPosInfo = record
    MouseX: Integer;
    MouseY: Integer;
    ControlWidth: Integer;
    ControlHeight: Integer;
  end;

  TCustomSizeControl = class(TWinControl)
  private
    FDragging: Boolean;
    FParentResize: Boolean;
    FParentMinSize: Integer;
    FDragPos: TDragPosInfo;
    FPercent: Cardinal;
    FSizeWidth: Integer;
    FMinSize: Integer;
    FMinFree: Integer;
    FOnResize: TNotifyEvent;
    procedure SetSizeWidth(Value: Integer);
    procedure SetMinSize(Value: Integer);
    procedure SetMinFree(Value: Integer);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure RSNSize(var Message: TRSNSize); message RSN_SIZE;
  protected
    procedure Loaded; override;
    procedure CalcPercent; virtual;
    procedure CalcNewSize(ParentWidth, ParentHeight: Integer; Rated: Boolean); virtual;
    procedure SetParentLimit; virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Resize; virtual;
    property ParentResize: Boolean read FParentResize write FParentResize default True;
    property SizeWidth: Integer read FSizeWidth write SetSizeWidth default 2;
    property MinSize: Integer read FMinSize write SetMinSize default 32;
    property MinFree: Integer read FMinFree write SetMinFree default 32;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TSizeControl }

  TSizeControl = class(TCustomSizeControl)
  published
    property Align;
    property ParentShowHint;
    property ParentResize;
    property SizeWidth;
    property MinSize;
    property MinFree;
    property ShowHint;
    property OnResize;
  end;

{ TLocalMenu }

  TLocalMenu = class
  private
    FHWnd: HWND;
    FHMenu: HMENU;
    FIDList: Pointer;
    FCommand: Longint;
    procedure WndProc(var Message: TMessage);
  public
    destructor Destroy; override;
    procedure Add(const Caption: String;
      const Checked: Boolean; const CommandID: Longint);
    procedure AddGroup(const Captions: array of String;
      const Checked: array of Boolean; const Commands: array of Longint);
    function Popup(X, Y: Integer): Longint;
  end;

implementation

uses
  Menus, Consts;

type

{ TDummyControl, a dummy control makes the PROTECTED property DefWndProc
  PUBLIC. A protected property cannot be accessed outside the object, so
  this unit derive a dummy descendant of TWinControl to gain access to
  the DefWndProc property. }

  TDummyControl = class(TWinControl)
  public
    property DefWndProc;
  end;

{ VCL uses METHODs as Widnows window procedures. Because Windows cannot
  accept methods as window procedures, VCL uses MakeObjectInstance to
  create a surrogate window procedure for the 'window method'. These
  definitions was copied from FORMS.PAS, and must be exactly the same
  as it appears in the original. See online help of MakeObjectInstance
  for more information. }

  PObjectInstance = ^TObjectInstance;
  TObjectInstance = packed record
    Code: Byte;
    Offset: Integer;
    case Integer of
      0: (Next: PObjectInstance);
      1: (Method: TWndMethod);
  end;

{ Internal table for TLocalMenu to convert menu ID to command }

  PIDEntry = ^TIDEntry;
  TIDEntry = record
    NextEntry: PIDEntry;
    ID: Word;
    Command: Longint;
  end;

{ Call TWinControl's window procedure }

procedure CallControlWndProc(Control: TWinControl; var Message: TMessage);
begin
  if (Control is TWinControl) and Control.HandleAllocated then
    PObjectInstance(GetWindowLong(Control.Handle, GWL_WNDPROC))^.Method(Message);
end;

{ Determine ResizeStyle based on limits }

function ResizeStyle(Min, Max: Integer): TResizeStyle;
begin
  Result := [];
  if Max = rcFixed then Include(Result, rsFixed) else
  begin
    if Min >= rcRange then Include(Result, rsLimitMin);
    if Max >= rcRange then Include(Result, rsLimitMax);
  end;
end;

{ TCustomSpy }

function TCustomSpy.GetControl: TWinControl;
var
  AComponent: TComponent;
begin
  if not Assigned(FControl) then
  begin
    AComponent := Self;
    while not (AComponent is TForm) and (AComponent <> nil) do
      AComponent := AComponent.Owner;
    if AComponent is TWinControl then FControl := TWinControl(AComponent);
  end;
  Result := FControl;
end;

procedure TCustomSpy.SetControl(AControl: TWinControl);
begin
  UnhookHost;
  FControl := AControl;
  HookHost;
end;

procedure TCustomSpy.Loaded;
begin
  inherited;
  HookHost;
end;

procedure TCustomSpy.Invalidate;
begin
end;

procedure TCustomSpy.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TCustomSpy.WndProc(var Message: TMessage);
var
  Handled: Boolean;
begin
  FIsWindowMessage := True;
  Handled := False;
  if Assigned(FOnMessage) then FOnMessage(Control, Message, msWindow, Handled);
  if not Handled then
  begin
    Dispatch(Message);
    if Message.Result = 0 then FHostWndMethod(Message);
  end;
  FIsWindowMessage := False;
end;

procedure TCustomSpy.DefaultHandler(var Message: TMessage);
var
  Handled: Boolean;
begin
  Handled := False;
  if not FIsWindowMessage then
  begin
    if Assigned(FOnMessage) then
      FOnMessage(Control, Message, msBroadcast, Handled);
    if not Handled then Dispatch(Message);
  end;
  if not Handled then
    with Message do
      Result := CallWindowProc(FHostDefWndProc, Control.Handle, Msg, WParam, LParam);
end;

procedure TCustomSpy.WMNCDestroy(var Message: TWMNCDestroy);
begin
  UnhookHost;
  inherited;
end;

procedure TCustomSpy.HookHost;
begin
  if not (csDesigning in ComponentState) and (Control is TWinControl)
    and (FHostWndProc = nil) then
  begin
    FHostWndProc := Pointer(GetWindowLong(Control.Handle, GWL_WNDPROC));
    FHostWndMethod := PObjectInstance(FHostWndProc)^.Method;
    PObjectInstance(FHostWndProc)^.Method := MainWndProc;
    FHostDefWndProc := TDummyControl(Control).DefWndProc;
    TDummyControl(Control).DefWndProc := FObjectInstance;
  end;
end;

procedure TCustomSpy.UnhookHost;
begin
  if not (csDesigning in ComponentState) and (Control is TWinControl)
    and (FHostWndProc <> nil) then
  begin
    PObjectInstance(FHostWndProc)^.Method := FHostWndMethod;
    TDummyControl(Control).DefWndProc := FHostDefWndProc;
    FHostWndProc := nil;
    FHostDefWndProc := nil;
  end;
  Invalidate;
end;

constructor TCustomSpy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FObjectInstance := MakeObjectInstance(DefaultHandler);
end;

destructor TCustomSpy.Destroy;
begin
  Destroying;
  UnhookHost;
  if FObjectInstance <> nil then
    FreeObjectInstance(FObjectInstance);
  inherited Destroy;
end;

{ TResizeControl }

function TResizeControl.GetLimit(Index: Integer): TResizeLimit;
begin
  Result := FLimits[Index];
end;

procedure TResizeControl.SetLimit(Index: Integer; Value: TResizeLimit);
var
  PairLimit: TResizeLimit;
  PairIndex: Integer;
  Valid    : Boolean;
begin
  if Value < rcFixed then Value := rcFixed;
  PairIndex := Index xor 1;
  PairLimit := FLimits[PairIndex];
  case Odd(Index) of
    False:
      Valid := Value <= PairLimit;
    True:
      Valid := Value >= PairLimit;
  end;
  Valid := Valid or (Value < rcRange) or (PairLimit < rcRange);
  if Valid and (FLimits[Index] <> Value) then
  begin
    FLimits[Index] := Value;
    if (Control is TWinControl) and (Value >= rcRange) then
      case Index of
        0: if Control.Width < Value then Control.Width := Value;
        1: if Control.Width > Value then Control.Width := Value;
        2: if Control.Height < Value then Control.Height := Value;
        3: if Control.Height > Value then Control.Height := Value;
      end;
    if Value = rcFixed then
    begin
      if FLimits[PairIndex] <> rcFixed then
        FLimits[PairIndex] := rcFixed;
    end else
      if FLimits[PairIndex] = rcFixed then
        FLimits[PairIndex] := rcFree;
  end;
end;

function TResizeControl.GetWidthStyle: TResizeStyle;
begin
  Result := ResizeStyle(WidthMin, WidthMax);
end;

function TResizeControl.GetHeightStyle: TResizeStyle;
begin
  Result := ResizeStyle(HeightMin, HeightMax);
end;

procedure TResizeControl.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  NonClient: Integer;
begin
  inherited;
  with Message.MinMaxInfo^ do
  begin
    NonClient := Control.Width - Control.ClientWidth;
    if rsFixed in WidthStyle then
    begin
      ptMaxSize.X := Control.Width;
      ptMinTrackSize.X := Control.Width;
      ptMaxTrackSize.X := Control.Width;
    end;
    if rsLimitMin in WidthStyle then
      ptMinTrackSize.X := WidthMin + NonClient;
    if rsLimitMax in WidthStyle then
    begin
      ptMaxSize.X := WidthMax + NonClient;
      ptMaxTrackSize.X := WidthMax + NonClient;
    end;
    NonClient := Control.Height - Control.ClientHeight;
    if rsFixed in HeightStyle then
    begin
      ptMaxSize.Y := Control.Height;
      ptMinTrackSize.Y := Control.Height;
      ptMaxTrackSize.Y := Control.Height;
    end;
    if rsLimitMin in HeightStyle then
      ptMinTrackSize.Y := HeightMin + NonClient;
    if rsLimitMax in HeightStyle then
    begin
      ptMaxSize.Y := HeightMax + NonClient;
      ptMaxTrackSize.Y := HeightMax + NonClient;
    end;
  end;
end;

procedure TResizeControl.WMSize(var Message: TWMSize);
var
  SizeMsg : TRSNSize;
  SizeInfo: TSizeInfo;
begin
  inherited;
  with SizeMsg do
  begin
    Msg := RSN_SIZE;
    SizeType := Message.SizeType;
    fpSizeInfo := @SizeInfo;
    Result := 0;
  end;
  with SizeInfo do
  begin
    NewWidth := Message.Width;
    NewHeight := Message.Height;
    if FOriginWidth <> 0 then
      OriginWidth := FOriginWidth
    else
      OriginWidth := NewWidth;
    if FOriginHeight <> 0 then
      OriginHeight := FOriginHeight
    else
      OriginHeight := NewHeight;
    FOriginWidth := NewWidth;
    FOriginHeight := NewHeight;
  end;
  Control.Broadcast(SizeMsg);
end;

procedure TResizeControl.RSMGetSetLimits(var Message: TRSMGetSetLimits);
begin
  with Message, fpSetLimits^ do
  begin
    Result := 0;
    if (Limit_GetWidthLimits and GetSetFlags) <> 0 then
      Result := (WidthMin shl 16) or WidthMin
    else if (Limit_GetHeightLimits and GetSetFlags) <> 0 then
      Result := (HeightMax shl 16) or HeightMin;
    if (Limit_SetWidthMin and GetSetFlags) <> 0 then WidthMin := dwWidthMin;
    if (Limit_SetWidthMax and GetSetFlags) <> 0 then WidthMax := dwWidthMax;
    if (Limit_SetHeightMin and GetSetFlags) <> 0 then HeightMin := dwHeightMin;
    if (Limit_SetHeightMax and GetSetFlags) <> 0 then HeightMax := dwHeightMax;
  end;
end;

procedure TResizeControl.Invalidate;
begin
  inherited;
  FOriginWidth := 0;
  FOriginHeight := 0;
end;

{ TCustomSizeControl }

{ scale of 'percent' representation }

const
  cPercentScale = 100000;

procedure TCustomSizeControl.SetSizeWidth(Value: Integer);
begin
  if FSizeWidth <> Value then
  begin
    FSizeWidth := Value;
    Realign;
    SetParentLimit;
  end;
end;

procedure TCustomSizeControl.SetMinSize(Value: Integer);
begin
  if FMinSize <> Value then
  begin
    FMinSize := Value;
    SetParentLimit;
  end;
end;

procedure TCustomSizeControl.SetMinFree(Value: Integer);
begin
  if FMinFree <> Value then
  begin
    FMinFree := Value;
    SetParentLimit;
  end;
end;

procedure TCustomSizeControl.Resize;
begin
  if Assigned(FOnResize) then FOnResize(Self);
end;

procedure TCustomSizeControl.WMSize(var Message: TWMSize);
begin
  inherited;
  if not (csLoading in ComponentState) then Resize;
end;

procedure TCustomSizeControl.WMLButtonDown(var Message: TWMLButtonDown);
begin
  FDragging := True;
  with FDragPos do
  begin
    MouseX := Message.Pos.x + Left;
    MouseY := Message.Pos.y + Top;
    ControlWidth := Width;
    ControlHeight := Height;
  end;
  inherited;
end;

procedure TCustomSizeControl.WMLButtonUp(var Message: TWMLButtonUp);
begin
  FDragging := False;
  CalcPercent;
  inherited;
end;

procedure TCustomSizeControl.WMRButtonDown(var Message: TWMRButtonDown);
begin
  if FDragging then with FDragPos do
  begin
    FDragging := False;
    Width := ControlWidth;
    Height := ControlHeight;
  end;
end;

procedure TCustomSizeControl.WMMouseMove(var Message: TWMMouseMove);
var
  Delta   : Integer;
  Value   : Integer;
  MinValue: Integer;
  MaxValue: Integer;
begin
  if FDragging then
  with FDragPos do
    begin
      MinValue := SizeWidth + MinSize;
      case Align of
        alLeft, alRight:
          begin
            MaxValue := Parent.ClientWidth - MinFree;
            Delta := Message.XPos + Left - MouseX;
            if Align = alLeft then
              Value := ControlWidth + Delta
            else
              Value := ControlWidth - Delta;
            if Value < MinValue then Value := MinValue;
            if Value > MaxValue then Value := MaxValue;
            Width := Value;
          end;
        alTop, alBottom:
          begin
            MaxValue := Parent.ClientHeight - MinFree;
            Delta := Message.YPos + Top - MouseY;
            if Align = alTop then
              Value := ControlHeight + Delta
            else
              Value := ControlHeight - Delta;
            if Value < MinValue then Value := MinValue;
            if Value > MaxValue then Value := MaxValue;
            Height := Value;
          end;
      end;
    end;
  inherited;
end;

procedure TCustomSizeControl.RSNSize(var Message: TRSNSize);
var
  RSMGetMsg: TRSMGetSetLimits;
begin
  if FParentMinSize = MaxInt then
  begin
    with RSMGetMsg do
    begin
      Msg := RSM_GETSETLIMITS;
      fpSetLimits := nil;
      Result := 0;
      case Align of
        alLeft, alRight:
          GetSetFlags := LIMIT_GETWIDTHLIMITS;
        alTop, alBottom:
          GetSetFlags := LIMIT_GETHEIGHTLIMITS;
      end;
      CallControlWndProc(Parent, TMessage(RSMGetMsg));
      FParentMinSize := LoWord(Result);
    end;
    SetParentLimit;
  end;
  if FPercent = 0 then
    CalcPercent
  else
    with Message.fpSizeInfo^ do CalcNewSize(NewWidth, NewHeight, ParentResize);
end;

procedure TCustomSizeControl.Loaded;
begin
  inherited;
  if Cursor = crDefault then
    case Align of
      alLeft, alRight:
        Cursor := crHSplit;
      alTop, alBottom:
        Cursor := crVSplit;
    end;
end;

procedure TCustomSizeControl.CalcPercent;
begin
  if not (csLoading in ComponentState) then
    case Align of
      alLeft, alRight:
        FPercent := (Width - SizeWidth) * cPercentScale div Parent.ClientWidth;
      alTop, alBottom:
        FPercent := (Height - SizeWidth) * cPercentScale div Parent.ClientHeight;
    end;
end;

procedure TCustomSizeControl.CalcNewSize(ParentWidth, ParentHeight: Integer;
  Rated: Boolean);
var
  Value   : Integer;
  MinValue: Integer;
  MaxValue: Integer;
begin
  MinValue := SizeWidth + MinSize;
  case Align of
    alLeft, alRight:
      begin
        MaxValue := Parent.ClientWidth - MinFree;
        if Rated then
          Value := ParentWidth * FPercent div cPercentScale + SizeWidth
        else
          Value := Width;
        if Value < MinValue then Value := MinValue;
        if Value > MaxValue then Value := MaxValue;
        Width := Value;
      end;
    alTop, alBottom:
      begin
        MaxValue := Parent.ClientHeight - MinFree;
        if Rated then
          Value := ParentHeight * FPercent div cPercentScale + SizeWidth
        else
          Value := Height;
        if Value < MinValue then Value := MinValue;
        if Value > MaxValue then Value := MaxValue;
        Height := Value;
      end;
  end;
end;

procedure TCustomSizeControl.SetParentLimit;
var
  RSMSetMsg: TRSMGetSetLimits;
  Params   : TSetLimitsParams;
  MinLimit : Integer;
begin
  MinLimit := MinSize + MinFree + SizeWidth;
  if not (csDesigning in ComponentState) and (FParentMinSize <> MaxInt)
    and (FParentMinSize <> rcFixed) and (MinLimit > FParentMinSize) then
    with RSMSetMsg do
    begin
      Msg := RSM_GETSETLIMITS;
      fpSetLimits := @Params;
      Result := 0;
      case Align of
        alLeft, alRight:
          begin
            GetSetFlags := LIMIT_SETWIDTHMIN;
            Params.dwWidthMin := MinLimit;
          end;
        alTop, alBottom:
          begin
            GetSetFlags := LIMIT_SETHEIGHTMIN;
            Params.dwHeightMin := MinLimit;
          end;
      end;
      CallControlWndProc(Parent,TMessage(RSMSetMsg));
    end;
end;

procedure TCustomSizeControl.AlignControls(AControl: TControl; var Rect: TRect);
begin
  with Rect do
  case Align of
    alTop   : Dec(Bottom, SizeWidth);
    alBottom: Inc(Top, SizeWidth);
    alLeft  : Dec(Right, SizeWidth);
    alRight : Inc(Left, SizeWidth);
  end;
  inherited AlignControls(AControl, Rect);
end;

constructor TCustomSizeControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csOpaque, csDoubleClicks, csReplicatable];
  FParentMinSize := MaxInt;
  FParentResize := True;
  FSizeWidth := 2;
  FMinSize := 32;
  FMinFree := 32;
  Width := 185;
  Height := 41;
end;

{ TLocalMenu }

procedure TLocalMenu.WndProc(var Message: TMessage);
var
  Entry: PIDEntry;
begin
  with Message do
  begin
    if Msg = WM_COMMAND then
    begin
      Entry := FIDList;
      while Entry <> nil do
        with Entry^ do
        begin
          if ID = LoWord(WParam) then
          begin
            FCommand := Command;
            Exit;
          end;
          Entry := NextEntry;
        end;
    end;
    Result := DefWindowProc(FHWnd, Msg, WParam, LParam);
  end;
end;

destructor TLocalMenu.Destroy;
var
  Entry: PIDEntry;
begin
  if FHWnd <> 0 then DeallocateHWnd(FHWnd);
  if FHMenu <> 0 then DestroyMenu(FHMenu);
  while FIDList <> nil do
  begin
    Entry := FIDList;
    FIDList := Entry^.NextEntry;
    Dispose(Entry);
  end;
  inherited Destroy;
end;

const
  Checks: array[Boolean] of LongInt = (MF_UNCHECKED, MF_CHECKED);
  ISeparators: array[Boolean] of Longint = (MFT_STRING, MFT_SEPARATOR);

procedure TLocalMenu.Add(const Caption: String;
  const Checked: Boolean; const CommandID: Longint);
var
  Entry      : PIDEntry;
  MenuID     : Integer;
  IsSeparator: Boolean;
  Position   : Integer;
begin
  Position := -1;
  if FHWnd = 0 then FHWnd := AllocateHWnd(WndProc);
  if FHMenu = 0 then FHMenu := CreatePopupMenu;
  if FHMenu = 0 then raise EMenuError.Create(SOutOfResources); (* CreateRes *)
  try
    IsSeparator := Caption = '-';
    MenuID := GetMenuItemCount(FHMenu)+1;
    if not IsSeparator and (CommandID <> -1) then
    begin
      New(Entry);
      with Entry^ do
      begin
        ID := MenuID;
        Command := CommandID;
        NextEntry := FIDList;
      end;
      FIDList := Entry;
    end;
    InsertMenu(FHMenu, Position, MF_BYPOSITION or ISeparators[IsSeparator]
      or Checks[Checked], MenuID, PChar(Caption));
  except
    Application.HandleException(Self);
  end;
end;

procedure TLocalMenu.AddGroup(const Captions: array of String;
  const Checked: array of Boolean; const Commands: array of Longint);
var
  Index    : Integer;
  CommandID: Longint;
begin
  for Index := Low(Captions) to High(Captions) do
  begin
    if Index <= High(Commands) then
      CommandID := Commands[Index]
    else
      CommandID := -1;
    Add(Captions[Index], (Index <= High(Checked)) and Checked[Index], CommandID);
  end;
end;

function TLocalMenu.Popup(X, Y: Integer): Longint;
var
  Message: TMsg;
begin
  FCommand := -1;
  if FHMenu <> 0 then
  begin
    TrackPopupMenu(FHMenu, TPM_LEFTALIGN
      or TPM_RIGHTBUTTON, X, Y, 0, FHWnd, nil);
    while PeekMessage(Message, FHWnd, 0, 0, PM_REMOVE) do
      DispatchMessage(Message);
  end;
  Result := FCommand;
end;

end.

