
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,98 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit CSPCtrls;

{$R-}

interface

uses Messages, Windows, SysUtils, Classes, Controls, Forms, Menus, Graphics,
     StdCtrls, Mask, Db, DBCtrls;

type

  TEditExt = class(TCustomEdit)
  private
    FClickTime: DWord;
    FDefaultHKL: HKL;
    FGoEnter: Boolean;
    FOriginHKL: HKL;
  protected
    procedure KeyPress(var Key: Char); override;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DefaultHKL: HKL read FDefaultHKL write FDefaultHKL default 0;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GoEnter: Boolean read FGoEnter write FGoEnter default True;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  // T\FieldDataLinkExt is a duplicate of TFieldDataLink in DBCtrls.pas, the
  // reason for making a copy here is due to the need to refer to its
  // private property, FModified, by TDBGridExt
  TFieldDataLinkExt = class(TDataLink)
  private
    FField: TField;
    FFieldName: string;
    FControl: TComponent;
    FEditing: Boolean;
    FModified: Boolean;
    FOnDataChange: TNotifyEvent;
    FOnEditingChange: TNotifyEvent;
    FOnUpdateData: TNotifyEvent;
    FOnActiveChange: TNotifyEvent;
    function GetCanModify: Boolean;
    procedure SetEditing(Value: Boolean);
    procedure SetField(Value: TField);
    procedure SetFieldName(const Value: string);
    procedure UpdateField;
    procedure UpdateRightToLeft;
  protected
    procedure ActiveChanged; override;
    procedure EditingChanged; override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create;
    function Edit: Boolean;
    procedure Modified;
    procedure Reset;
    property CanModify: Boolean read GetCanModify;
    property Control: TComponent read FControl write FControl;
    property Editing: Boolean read FEditing;
    property Field: TField read FField;
    property FieldName: string read FFieldName write SetFieldName;
    property OnDataChange: TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnEditingChange: TNotifyEvent read FOnEditingChange write FOnEditingChange;
    property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;
    property OnActiveChange: TNotifyEvent read FOnActiveChange write FOnActiveChange;
  end;

  TDBEditExt = class(TCustomMaskEdit)
  private
    FClickTime: DWord;
    FDefaultHKL: HKL;
    FGoEnter: Boolean;
    FOriginHKL: HKL;

    FDataLink: TFieldDataLinkExt;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;

    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DefaultHKL: HKL read FDefaultHKL write FDefaultHKL default 0;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GoEnter: Boolean read FGoEnter write FGoEnter default True;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses ImmAPI;

{ Interval holding RButton to activate HKL menu }

const
  HKLMenuInterval: Integer = 300;

{ Set and return original HKLMenuInterval }

function SetHKLMenuInterval(Interval: Integer): Integer;
begin
  Result := HKLMenuInterval;
  if (Interval >= 100) and (Interval <= 5000) then
    HKLMenuInterval := Interval;
end;

{ TEditExt }

constructor TEditExt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGoEnter := True;
end;

procedure TEditExt.KeyPress(var Key: Char);
begin
  if FGoEnter and (Key = #13) and (Parent is TForm) then 
    TControl(Self.Owner).Perform(WM_NEXTDLGCTL, 0, 0)
  else  inherited;
end;

procedure TEditExt.WMRButtonDown(var Message: TWMRButtonDown);
begin
  FClickTime := GetMessageTime;
  inherited;
end;

procedure TEditExt.WMRButtonUp(var Message: TWMRButtonUp);
begin
  if GetMessageTime - FClickTime >= HKLMenuInterval then
  begin
    with ClientToScreen(SmallPointToPoint(Message.Pos)) do
      DefaultHKL := SelectDefaultHKL(Self, X, Y,
        DefaultHKL, FOriginHKL);
    Exit;
  end;
  inherited;
end;

procedure TEditExt.CMEnter(var Message: TCMEnter);
begin
  SetCurrentHKL(FDefaultHKL);
  inherited;
end;

procedure TEditExt.CMExit(var Message: TCMExit);
begin
  SaveCurrentHKL(FDefaultHKL);
  inherited;
end;

procedure TEditExt.Loaded;
begin
  inherited;
  FOriginHKL := DefaultHKL;
  DefaultHKL := ReadDefaultHKL(Self, DefaultHKL);
end;

{ TFieldDataLinkExt }

constructor TFieldDataLinkExt.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TFieldDataLinkExt.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    FModified := False;
    if Assigned(FOnEditingChange) then FOnEditingChange(Self);
  end;
end;

procedure TFieldDataLinkExt.SetFieldName(const Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName :=  Value;
    UpdateField;
  end;
end;

procedure TFieldDataLinkExt.SetField(Value: TField);
begin
  if FField <> Value then
  begin
    FField := Value;
    EditingChanged;
    RecordChanged(nil);
    UpdateRightToLeft;
  end;
end;

procedure TFieldDataLinkExt.UpdateField;
begin
  SetField(nil);
  if Active and (FFieldName <> '') then
  begin
    if Assigned(FControl) then
      SetField(GetFieldProperty(DataSource.DataSet, FControl, FFieldName)) else
      SetField(DataSource.DataSet.FieldByName(FFieldName));
  end;
end;

procedure TFieldDataLinkExt.UpdateRightToLeft;
var
  IsRightAligned: Boolean;
  AUseRightToLeftAlignment: Boolean;
begin
  if Assigned(FControl) and (FControl is TWinControl) then
    with FControl as TWinControl do
      if IsRightToLeft then
      begin
        IsRightAligned :=
          (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_RIGHT) = WS_EX_RIGHT;
        AUseRightToLeftAlignment :=
          DBUseRightToLeftAlignment(TControl(FControl), Field);
        if (IsRightAligned and (not AUseRightToLeftAlignment)) or
           ((not IsRightAligned) and AUseRightToLeftAlignment) then
          Perform(CM_RECREATEWND, 0, 0);
      end;    
end;

function TFieldDataLinkExt.Edit: Boolean;
begin
  if CanModify then inherited Edit;
  Result := FEditing;
end;

function TFieldDataLinkExt.GetCanModify: Boolean;
begin
  Result := not ReadOnly and (Field <> nil) and Field.CanModify;
end;

procedure TFieldDataLinkExt.Modified;
begin
  FModified := True;
end;

procedure TFieldDataLinkExt.Reset;
begin
  RecordChanged(nil);
end;

procedure TFieldDataLinkExt.ActiveChanged;
begin
  UpdateField;
  if Assigned(FOnActiveChange) then FOnActiveChange(Self);
end;

procedure TFieldDataLinkExt.EditingChanged;
begin
  SetEditing(inherited Editing and CanModify);
end;

procedure TFieldDataLinkExt.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FField) and (FControl is TWinControl) then
    if TWinControl(FControl).CanFocus then
    begin
      Field^ := nil;
      TWinControl(FControl).SetFocus;
    end;
end;

procedure TFieldDataLinkExt.RecordChanged(Field: TField);
begin
  if (Field = nil) or (Field = FField) then
  begin
    if Assigned(FOnDataChange) then FOnDataChange(Self);
    FModified := False;
  end;
end;

procedure TFieldDataLinkExt.LayoutChanged;
begin
  UpdateField;
end;

procedure TFieldDataLinkExt.UpdateData;
begin
  if FModified then
  begin
    if (Field <> nil) and Assigned(FOnUpdateData) then FOnUpdateData(Self);
    FModified := False;
  end;
end;

{ TDBEditExt }

procedure TDBEditExt.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType = ftString) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

constructor TDBEditExt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLinkExt.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FGoEnter := True;
end;

destructor TDBEditExt.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TDBEditExt.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
  FOriginHKL := DefaultHKL;
  DefaultHKL := ReadDefaultHKL(Self, DefaultHKL);
end;

procedure TDBEditExt.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TDBEditExt.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TDBEditExt.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TDBEditExt.KeyPress(var Key: Char);
begin
  if FGoEnter and (Key = #13) and (Parent is TForm) then 
    TControl(Self.Owner).Perform(WM_NEXTDLGCTL, 0, 0)
  else  
    begin
      inherited KeyPress(Key);
      if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
        not FDataLink.Field.IsValidChar(Key) then
      begin
        MessageBeep(0);
        Key := #0;
      end;
      case Key of
        ^H, ^V, ^X, #32..#255:
          FDataLink.Edit;
        #27:
          begin
            FDataLink.Reset;
            SelectAll;
            Key := #0;
          end;
      end;
    end;
end;

function TDBEditExt.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TDBEditExt.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TDBEditExt.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TDBEditExt.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TDBEditExt.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBEditExt.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBEditExt.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBEditExt.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

function TDBEditExt.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBEditExt.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBEditExt.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBEditExt.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType = ftString) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing and FDataLink.FModified then
        Modified := True;
    end;
  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

procedure TDBEditExt.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TDBEditExt.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TDBEditExt.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBEditExt.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBEditExt.CMEnter(var Message: TCMEnter);
begin
  SetCurrentHKL(FDefaultHKL);

  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TDBEditExt.CMExit(var Message: TCMExit);
begin
  SaveCurrentHKL(FDefaultHKL);

  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TDBEditExt.WMPaint(var Message: TWMPaint);
const
  AlignStyle : array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  AAlignment: TAlignment;
  ExStyle: DWORD;
begin
  AAlignment := FAlignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  if ((AAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
  begin
    if SysLocale.MiddleEast and HandleAllocated and (IsRightToLeft) then
    begin { This keeps the right aligned text, right aligned }
      ExStyle := DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
        (not WS_EX_RTLREADING) and (not WS_EX_LEFTSCROLLBAR);
      if UseRightToLeftReading then ExStyle := ExStyle or WS_EX_RTLREADING;
      if UseRightToLeftScrollbar then ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
      ExStyle := ExStyle or
        AlignStyle[UseRightToLeftAlignment, AAlignment];
      if DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) <> ExStyle then
        SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
    end;
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      if not Enabled then
        Font.Color := clGrayText;
      if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
        S := EditText;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case AAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      if SysLocale.MiddleEast then UpdateTextFlags;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TDBEditExt.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TDBEditExt.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

function TDBEditExt.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TDBEditExt.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TDBEditExt.WMRButtonDown(var Message: TWMRButtonDown);
begin
  FClickTime := GetMessageTime;
  inherited;
end;

procedure TDBEditExt.WMRButtonUp(var Message: TWMRButtonUp);
begin
  if GetMessageTime - FClickTime >= HKLMenuInterval then
  begin
    with ClientToScreen(SmallPointToPoint(Message.Pos)) do
      DefaultHKL := SelectDefaultHKL(Self, X, Y,
        DefaultHKL, FOriginHKL);
    Exit;
  end;
  inherited;
end;

end.


