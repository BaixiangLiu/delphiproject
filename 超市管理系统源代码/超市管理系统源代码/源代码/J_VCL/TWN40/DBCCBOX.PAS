unit dbCCBox;

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms,
     Graphics, Menus, StdCtrls, ExtCtrls, Mask, Dialogs, Buttons, ComCtrls, Db, DBCtrls, DBTables;

type

{ TDBCodeComboBox }

  TDBCodeComboBox = class(TCustomComboBox)
  private
    FDataLink: TFieldDataLink;
    FPaintControl: TPaintControl;
    FQuery : TQuery;
    FCodeField: string;
    FDisplayField: string;
    FSQL : string;
    FDisplayDatasource: TDataSource;

    procedure SetCodeField(const Value: string);
    procedure SetDisplayField(const Value: string);
    procedure SetDisplayDatasource(const Value: TDataSource);
    function  GetCodeValue(const sText : string) : string;
    function  GetDisplayValue(const sText : string) : string;

    procedure UpdateData(Sender: TObject);
    procedure SetupQueryProperties;
    procedure ConstructSQL;
    procedure FillComboBoxItems;

    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetComboText: string;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetComboText(const Value: string);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetEditReadOnly;
    procedure SetItems(Value: TStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure Change; override;
    procedure Click; override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: Pointer); override;
    procedure CreateWnd; override;
    procedure DropDown; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetStyle(Value: TComboboxStyle); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property Text;
  published
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property Items write SetItems;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;

    property CodeField : string read FCodeField write SetCodeField;
    property DisplayField : string read FDisplayField write SetDisplayField;
    property DisplayDatasource : TDataSource read FDisplayDatasource write SetDisplayDatasource;
  end;

implementation

{ TDBCodeComboBox }

constructor TDBCodeComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FPaintControl := TPaintControl.Create(Self, 'CODECOMBOBOX');

  FQuery := TQuery.Create(Self);
end;

destructor TDBCodeComboBox.Destroy;
begin
  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  FQuery.Close;
  FQuery.Free;

  inherited Destroy;
end;

procedure TDBCodeComboBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TDBCodeComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBCodeComboBox.CreateWnd;
begin
  inherited CreateWnd;
  SetEditReadOnly;
end;

procedure TDBCodeComboBox.DataChange(Sender: TObject);
begin
  if not (Style = csSimple) and DroppedDown then
    Exit;
  if FDataLink.Field <> nil then
    SetComboText(FDataLink.Field.Text)
  else
    if csDesigning in ComponentState then
      SetComboText(Name)
    else
      SetComboText('');
end;

procedure TDBCodeComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := GetComboText;
end;

procedure TDBCodeComboBox.SetComboText(const Value: string);
var
  I: Integer;
  Redraw: Boolean;
begin
  if Value <> GetComboText then
  begin
    if Style <> csDropDown then
    begin
      Redraw := (Style <> csSimple) and HandleAllocated;
      if Redraw then SendMessage(Handle, WM_SETREDRAW, 0, 0);
      try
        if Value = '' then I := -1 else I := Items.IndexOf(Value);
        ItemIndex := I;
      finally
        if Redraw then
        begin
          SendMessage(Handle, WM_SETREDRAW, 1, 0);
          Invalidate;
        end;
      end;
      if I >= 0 then Exit;
    end;
    if Style in [csDropDown, csSimple] then Text := GetDisplayValue(Value);
  end;
end;

function TDBCodeComboBox.GetComboText: string;
var
  I: Integer;
begin
  try
    if Style in [csDropDown, csSimple] then
      Result := GetCodeValue(Text)
    else
    begin
      I := ItemIndex;
      if I < 0 then
        Result := ''
      else
        Result := GetCodeValue(Items[I]);
    end;
  except
    on Exception do;
  end;
end;

procedure TDBCodeComboBox.Change;
begin
  FDataLink.Edit;
  inherited Change;
  FDataLink.Modified;
end;

procedure TDBCodeComboBox.Click;
begin
  FDataLink.Edit;
  inherited Click;
  FDataLink.Modified;
end;

procedure TDBCodeComboBox.DropDown;
begin
  inherited DropDown;
end;

function TDBCodeComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBCodeComboBox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBCodeComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBCodeComboBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
//  fCodeField := Value;
end;

function TDBCodeComboBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBCodeComboBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBCodeComboBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBCodeComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_BACK, VK_DELETE, VK_UP, VK_DOWN, 32..255] then
  begin
    if not FDataLink.Edit and (Key in [VK_UP, VK_DOWN]) then
      Key := 0;
  end;
end;

procedure TDBCodeComboBox.KeyPress(var Key: Char);
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
      end;
  end;
end;

procedure TDBCodeComboBox.EditingChange(Sender: TObject);
begin
  SetEditReadOnly;
end;

procedure TDBCodeComboBox.SetEditReadOnly;
begin
  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(not FDataLink.Editing), 0);
end;

procedure TDBCodeComboBox.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_COMMAND:
        if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
          if not FDataLink.Edit then
          begin
            if Style <> csSimple then
              PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
            Exit;
          end;
      CB_SHOWDROPDOWN:
        if Message.WParam <> 0 then FDataLink.Edit else
          if not FDataLink.Editing then DataChange(Self); {Restore text}
      WM_CREATE,
      WM_WINDOWPOSCHANGED,
      CM_FONTCHANGED:
        FPaintControl.DestroyHandle;
    end;
  inherited WndProc(Message);
end;

procedure TDBCodeComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_LBUTTONDOWN:
        if (Style = csSimple) and (ComboWnd <> EditHandle) then
          if not FDataLink.Edit then Exit;
    end;
  inherited ComboWndProc(Message, ComboWnd, ComboProc);
end;

procedure TDBCodeComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(False), 0);
end;

procedure TDBCodeComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TDBCodeComboBox.WMPaint(var Message: TWMPaint);
var
  S: string;
  R: TRect;
  P: TPoint;
  Child: HWND;
begin
  if csPaintCopy in ControlState then
  begin
    if FDataLink.Field <> nil then S := FDataLink.Field.Text else S := '';
    if Style = csDropDown then
    begin
      SendMessage(FPaintControl.Handle, WM_SETTEXT, 0, Longint(PChar(S)));
      SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
      Child := GetWindow(FPaintControl.Handle, GW_CHILD);
      if Child <> 0 then
      begin
        Windows.GetClientRect(Child, R);
        Windows.MapWindowPoints(Child, FPaintControl.Handle, R.TopLeft, 2);
        GetWindowOrgEx(Message.DC, P);
        SetWindowOrgEx(Message.DC, P.X - R.Left, P.Y - R.Top, nil);
        IntersectClipRect(Message.DC, 0, 0, R.Right - R.Left, R.Bottom - R.Top);
        SendMessage(Child, WM_PAINT, Message.DC, 0);
      end;
    end else
    begin
      SendMessage(FPaintControl.Handle, CB_RESETCONTENT, 0, 0);
      if Items.IndexOf(S) <> -1 then
      begin
        SendMessage(FPaintControl.Handle, CB_ADDSTRING, 0, Longint(PChar(S)));
        SendMessage(FPaintControl.Handle, CB_SETCURSEL, 0, 0);
      end;
      SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
    end;
  end else
    inherited;
end;

procedure TDBCodeComboBox.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TDBCodeComboBox.SetStyle(Value: TComboboxStyle);
begin
  if (Value = csSimple) and Assigned(FDatalink) and FDatalink.DatasourceFixed then
    //DatabaseError(SNotReplicatable);
    ;
  inherited SetStyle(Value);
end;

function TDBCodeComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TDBCodeComboBox.CMGetDatalink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TDBCodeComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TDBCodeComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TDBCodeComboBox.SetDisplayDatasource(const Value: TDataSource);
begin
  if (Value <> FDisplayDatasource) then
  begin
    FDisplayDatasource := Value;
  end;
end;

procedure TDBCodeComboBox.SetCodeField(const Value: string);
begin
  if (Value <> FCodeField) then
  begin
    FCodeField := Value;
  end;
end;

procedure TDBCodeComboBox.SetDisplayField(const Value: string);
begin
  if (Value <> FDisplayField) then
  begin
    FDisplayField := Value;

    if (assigned(Field)) then
    begin
      if (Assigned(DisplayDatasource)) then
      begin
        SetupQueryProperties;
        ConstructSQL;
        FillComboBoxItems;
        ItemIndex := 0;        
      end;
    end
  end;
end;

//=============================自定义函数开始=============================
procedure TDBCodeComboBox.SetupQueryProperties;
begin
  if Assigned(Field) then
    FQuery.DatabaseName := TDBDataSet(Field.DataSet).DatabaseName;
end;

procedure TDBCodeComboBox.ConstructSQL;
var
  iPos : Integer;
  FOldSQL : string;
  FTableName : string;
begin
  if (Assigned(FDisplayDatasource) and Assigned(FDisplayDatasource.DataSet) ) then
  begin
    FQuery.Active := False;

    FSQL := 'select ' + FCodeField + ',' + FDisplayField + ' from ';
    FTableName := '';

    if (FDisplayDatasource.DataSet is TTable) then
    begin
      FSQL := FSQL + TTable(FDisplayDatasource.DataSet).TableName;
    end
    else
    begin
      FOldSQL := UpperCase(TQuery(FDisplayDatasource.DataSet).SQL.Text);
      iPos := Pos('FROM', FOldSQL);
      if (iPos > 0) then
      begin
        while (FOldSQL[iPos] <> ' ') do
          Inc(iPos);

        Inc(iPos);
        while ( (FOldSQL[iPos] <> ' ') and (iPos < Length(FOLDSQL)) ) do
        begin
          FTableName := FTableName + FOldSQL[iPos];
          Inc(iPos);
        end;

        FSQL := FSQL + FTableName;
      end;
    end;

    FQuery.SQL.Clear;
    FQuery.SQL.Add(FSQL);
    FQuery.Active := True;
  end;
end;

procedure TDBCodeComboBox.FillComboBoxItems;
begin
  if (FQuery.Active) then
  begin
    Items.Clear;
    While (not FQuery.EOF) do
    begin
      Items.Add(FQuery.Fields[1].Value);
      FQuery.Next;
    end;
  end;
end;

function TDBCodeComboBox.GetDisplayValue(const sText : string) : string;
begin
  try
    if (not FQuery.Active) then
    begin
      try
        SetupQueryProperties;
        ConstructSQL;
        FillComboBoxItems;
      except
        on Exception do;
      end;
    end;

    Result := '';
    if (FQuery.Active) then
      if FQuery.Locate(FCodeField, sText, []) then
      begin
        Result := FQuery.FieldByName(FDisplayField).Value;
      end;
  except
    On Exception do;
  end;
end;

function TDBCodeComboBox.GetCodeValue(const sText : string) : string;
begin
  try
    if (not FQuery.Active) then
    begin
      SetupQueryProperties;
      ConstructSQL;
      FillComboBoxItems;
    end;

    Result := '';
    if (FQuery.Active) then
      if FQuery.Locate(FDisplayField, sText, []) then
      begin
        Result := FQuery.FieldByName(FCodeField).Value;
      end;
  except
    On Exception do;
  end;
end;

//自定义函数结束

end.
 
