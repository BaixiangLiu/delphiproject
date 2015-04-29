unit dbCLBox;

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms,
     Graphics, Menus, StdCtrls, ExtCtrls, Mask, Dialogs, Buttons, ComCtrls, Db, DBCtrls, DBTables;

type
  TDBCodeListBox = class(TCustomListBox)
  private
    FDataLink: TFieldDataLink;
    FQuery : TQuery;
    FCodeField: string;
    FDisplayField: string;
    FSQL : string;
    FDisplayDatasource: TDataSource;

    function  GetCodeValue(const sText : string) : string;
    function  GetDisplayValue(const sText : string) : string;

    procedure SetCodeField(const Value: string);
    procedure SetDisplayField(const Value: string);
    procedure SetDisplayDatasource(const Value: TDataSource);
    procedure SetupQueryProperties;
    procedure ConstructSQL;
    procedure FillListBoxItems;


    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetItems(Value: TStrings);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    procedure Click; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D default True;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
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
    property Style;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    
    property CodeField : string read FCodeField write SetCodeField;
    property DisplayField : string read FDisplayField write SetDisplayField;
    property DisplayDatasource : TDataSource read FDisplayDatasource write SetDisplayDatasource;
  end;

implementation

{ TDBCodeListBox }

constructor TDBCodeListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;

  FQuery := TQuery.Create(Self);
end;

destructor TDBCodeListBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FQuery.Close;
  FQuery.Free;

  inherited Destroy;
end;

procedure TDBCodeListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TDBCodeListBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TDBCodeListBox.DataChange(Sender: TObject);
var
  sText : string;
begin
  if FDataLink.Field <> nil then
  begin
    sText := GetDisplayValue((FDataLink.Field.Text));
    ItemIndex := Items.IndexOf(sText)
  end
  else
    ItemIndex := -1;
end;

procedure TDBCodeListBox.UpdateData(Sender: TObject);
begin
  if ItemIndex >= 0 then
    FDataLink.Field.Text := GetCodeValue(Items[ItemIndex])
  else
    FDataLink.Field.Text := '';
end;

procedure TDBCodeListBox.Click;
begin
  if FDataLink.Edit then
  begin
    inherited Click;
    FDataLink.Modified;
  end;
end;

function TDBCodeListBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBCodeListBox.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBCodeListBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBCodeListBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TDBCodeListBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBCodeListBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBCodeListBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBCodeListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN] then
    if not FDataLink.Edit then Key := 0;
end;

procedure TDBCodeListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #32..#255:
      if not FDataLink.Edit then Key := #0;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TDBCodeListBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FDataLink.Edit then inherited
  else
  begin
    SetFocus;
    with Message do
      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  end;
end;

procedure TDBCodeListBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TDBCodeListBox.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

function TDBCodeListBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TDBCodeListBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TDBCodeListBox.SetDisplayDatasource(const Value: TDataSource);
begin
  if (Value <> FDisplayDatasource) then
  begin
    FDisplayDatasource := Value;
  end;
end;

procedure TDBCodeListBox.SetCodeField(const Value: string);
begin
  if (Value <> FCodeField) then
  begin
    FCodeField := Value;
  end;
end;

procedure TDBCodeListBox.SetDisplayField(const Value: string);
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
        FillListBoxItems;
      end;
    end
  end;
end;

//=============================自定义函数开始=============================
procedure TDBCodeListBox.SetupQueryProperties;
begin
  if Assigned(Field) then
    FQuery.DatabaseName := TDBDataSet(Field.DataSet).DatabaseName;
end;

procedure TDBCodeListBox.ConstructSQL;
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
        while ((FOldSQL[iPos] <> ' ') and (iPos < Length(FOLDSQL)) ) do
        begin
          FTableName := FTableName + FOldSQL[iPos];
          Inc(iPos);
        end;

        FSQL := FSQL + FTableName;
      end;
    end;
  end;

  FQuery.SQL.Clear;
  FQuery.SQL.Add(FSQL);
  FQuery.Active := True;
end;

procedure TDBCodeListBox.FillListBoxItems;
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

function TDBCodeListBox.GetDisplayValue(const sText : string) : string;
begin
  try
    if (not FQuery.Active) then
    begin
      SetupQueryProperties;
      ConstructSQL;
      FillListBoxItems;
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

function TDBCodeListBox.GetCodeValue(const sText : string) : string;
begin
  try
    if (not FQuery.Active) then
    begin
      SetupQueryProperties;
      ConstructSQL;
      FillListBoxItems;
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
 
