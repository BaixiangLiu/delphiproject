
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1995,98 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit DBGridsX;

{$R-}

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
  Graphics, Grids, DBCtrls, Db, Menus, ImgList, DBGrids;

type
  TColumnExt = class;
  TCustomDBGridExt = class;

  TColumnTitleExt = class(TPersistent)
  private
    FColumn: TColumnExt;
    FCaption: string;
    FFont: TFont;
    FColor: TColor;
    FAlignment: TAlignment;
    procedure FontChanged(Sender: TObject);
    function GetAlignment: TAlignment;
    function GetColor: TColor;
    function GetCaption: string;
    function GetFont: TFont;
    function IsAlignmentStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsCaptionStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetCaption(const Value: string); virtual;
  protected
    procedure RefreshDefaultFont;
  public
    constructor Create(Column: TColumnExt);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultCaption: string;
    procedure RestoreDefaults; virtual;
    property Column: TColumnExt read FColumn;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment
      stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
  end;

  TColumnExt = class(TCollectionItem)
  private
    FField: TField;
    FFieldName: string;
    FColor: TColor;
    FWidth: Integer;
    FTitle: TColumnTitleExt;
    FFont: TFont;
    FImeMode: TImeMode;
    FImeName: TImeName;
    FPickList: TStrings;
    FPopupMenu: TPopupMenu;
    FDropDownRows: Cardinal;
    FButtonStyle: TColumnButtonStyle;
    FAlignment: TAlignment;
    FReadonly: Boolean;
    FAssignedValues: TColumnValues;
    FVisible: Boolean;
    FExpanded: Boolean;
    FStored: Boolean;
    procedure FontChanged(Sender: TObject);
    function  GetAlignment: TAlignment;
    function  GetColor: TColor;
    function  GetExpanded: Boolean;
    function  GetField: TField;
    function  GetFont: TFont;
    function  GetImeMode: TImeMode;
    function  GetImeName: TImeName;
    function  GetParentColumn: TColumnExt;
    function  GetPickList: TStrings;
    function  GetReadOnly: Boolean;
    function  GetShowing: Boolean;
    function  GetWidth: Integer;
    function  GetVisible: Boolean;
    function  IsAlignmentStored: Boolean;
    function  IsColorStored: Boolean;
    function  IsFontStored: Boolean;
    function  IsImeModeStored: Boolean;
    function  IsImeNameStored: Boolean;
    function  IsReadOnlyStored: Boolean;
    function  IsWidthStored: Boolean;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetButtonStyle(Value: TColumnButtonStyle);
    procedure SetColor(Value: TColor);
    procedure SetExpanded(Value: Boolean);
    procedure SetField(Value: TField); virtual;
    procedure SetFieldName(const Value: String);
    procedure SetFont(Value: TFont);
    procedure SetImeMode(Value: TImeMode); virtual;
    procedure SetImeName(Value: TImeName); virtual;
    procedure SetPickList(Value: TStrings);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetTitle(Value: TColumnTitleExt);
    procedure SetWidth(Value: Integer); virtual;
    procedure SetVisible(Value: Boolean);
    function GetExpandable: Boolean;
  protected
    function  CreateTitle: TColumnTitleExt; virtual;
    function  GetGrid: TCustomDBGridExt;
    function GetDisplayName: string; override;
    procedure RefreshDefaultFont;
    procedure SetIndex(Value: Integer); override;
    property IsStored: Boolean read FStored write FStored default True;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function  DefaultAlignment: TAlignment;
    function  DefaultColor: TColor;
    function  DefaultFont: TFont;
    function  DefaultImeMode: TImeMode;
    function  DefaultImeName: TImeName;
    function  DefaultReadOnly: Boolean;
    function  DefaultWidth: Integer;
    function  Depth: Integer;
    procedure RestoreDefaults; virtual;
    property  Grid: TCustomDBGridExt read GetGrid;
    property  AssignedValues: TColumnValues read FAssignedValues;
    property  Expandable: Boolean read GetExpandable;
    property  Field: TField read GetField write SetField;
    property  ParentColumn: TColumnExt read GetParentColumn;
    property  Showing: Boolean read GetShowing;
  published
    property  Alignment: TAlignment read GetAlignment write SetAlignment
      stored IsAlignmentStored;
    property  ButtonStyle: TColumnButtonStyle read FButtonStyle write SetButtonStyle
      default cbsAuto;
    property  Color: TColor read GetColor write SetColor stored IsColorStored;
    property  DropDownRows: Cardinal read FDropDownRows write FDropDownRows default 7;
    property  Expanded: Boolean read GetExpanded write SetExpanded default True;
    property  FieldName: String read FFieldName write SetFieldName;
    property  Font: TFont read GetFont write SetFont stored IsFontStored;
    property  ImeMode: TImeMode read GetImeMode write SetImeMode stored IsImeModeStored;
    property  ImeName: TImeName read GetImeName write SetImeName stored IsImeNameStored;
    property  PickList: TStrings read GetPickList write SetPickList;
    property  PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property  ReadOnly: Boolean read GetReadOnly write SetReadOnly
      stored IsReadOnlyStored;
    property  Title: TColumnTitleExt read FTitle write SetTitle;
    property  Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    property  Visible: Boolean read GetVisible write SetVisible;
  end;

  TColumnClassExt = class of TColumnExt;

  TDBGridColumnsExt = class(TCollection)
  private
    FGrid: TCustomDBGridExt;
    function GetColumn(Index: Integer): TColumnExt;
    function InternalAdd: TColumnExt;
    procedure SetColumn(Index: Integer; Value: TColumnExt);
    procedure SetState(NewState: TDBGridColumnsState);
    function GetState: TDBGridColumnsState;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Grid: TCustomDBGridExt; ColumnClass: TColumnClassExt);
    function  Add: TColumnExt;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RestoreDefaults;
    procedure RebuildColumns;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property State: TDBGridColumnsState read GetState write SetState;
    property Grid: TCustomDBGridExt read FGrid;
    property Items[Index: Integer]: TColumnExt read GetColumn write SetColumn; default;
  end;

  TGridDataLinkExt = class(TDataLink)
  private
    FGrid: TCustomDBGridExt;
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FModified: Boolean;
    FInUpdateData: Boolean;
    FSparseMap: Boolean;
    function GetDefaultFields: Boolean;
    function GetFields(I: Integer): TField;
  protected
    procedure ActiveChanged; override;
    procedure BuildAggMap;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    function IsAggRow(Value: Integer): Boolean; virtual;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    function  GetMappedIndex(ColIndex: Integer): Integer;
  public
    constructor Create(AGrid: TCustomDBGridExt);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property DefaultFields: Boolean read GetDefaultFields;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property SparseMap: Boolean read FSparseMap write FSparseMap;
  end;

  TBookmarkListExt = class
  private
    FList: TStringList;
    FGrid: TCustomDBGridExt;
    FCache: TBookmarkStr;
    FCacheIndex: Integer;
    FCacheFind: Boolean;
    FLinkActive: Boolean;
    function GetCount: Integer;
    function GetCurrentRowSelected: Boolean;
    function GetItem(Index: Integer): TBookmarkStr;
    procedure SetCurrentRowSelected(Value: Boolean);
    procedure StringsChanged(Sender: TObject);
  protected
    function CurrentRow: TBookmarkStr;
    function Compare(const Item1, Item2: TBookmarkStr): Integer;
    procedure LinkActive(Value: Boolean);
  public
    constructor Create(AGrid: TCustomDBGridExt);
    destructor Destroy; override;
    procedure Clear;           // free all bookmarks
    procedure Delete;          // delete all selected rows from dataset
    function  Find(const Item: TBookmarkStr; var Index: Integer): Boolean;
    function  IndexOf(const Item: TBookmarkStr): Integer;
    function  Refresh: Boolean;// drop orphaned bookmarks; True = orphans found
    property Count: Integer read GetCount;
    property CurrentRowSelected: Boolean read GetCurrentRowSelected
      write SetCurrentRowSelected;
    property Items[Index: Integer]: TBookmarkStr read GetItem; default;
  end;

  TDBGridOptionExt = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect,
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect,
    dgEnters);
  TDBGridOptionsExt = set of TDBGridOptionExt;

  TDrawColumnCellEventExt = procedure (Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumnExt; State: TGridDrawState) of object;
  TDBGridClickEventExt = procedure (Column: TColumnExt) of object;

  TCustomDBGridExt = class(TCustomGrid)
  private
    FIndicators: TImageList;
    FTitleFont: TFont;
    FReadOnly: Boolean;
    FOriginalImeName: TImeName;
    FOriginalImeMode: TImeMode;
    FUserChange: Boolean;
    FIsESCKey: Boolean;
    FLayoutFromDataset: Boolean;
    FOptions: TDBGridOptionsExt;
    FTitleOffset, FIndicatorOffset: Byte;
    FUpdateLock: Byte;
    FLayoutLock: Byte;
    FInColExit: Boolean;
    FDefaultDrawing: Boolean;
    FSelfChangingTitleFont: Boolean;
    FSelecting: Boolean;
    FSelRow: Integer;
    FDataLink: TGridDataLinkExt;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnDrawDataCell: TDrawDataCellEvent;
    FOnDrawColumnCell: TDrawColumnCellEventExt;
    FEditText: string;
    FColumns: TDBGridColumnsExt;
    FVisibleColumns: TList;
    FBookmarks: TBookmarkListExt;
    FSelectionAnchor: TBookmarkStr;
    FOnEditButtonClick: TNotifyEvent;
    FOnColumnMoved: TMovedEvent;
    FOnCellClick: TDBGridClickEventExt;
    FOnTitleClick:TDBGridClickEventExt;
    FDragCol: TColumnExt;
    function AcquireFocus: Boolean;
    procedure DataChanged;
    procedure EditingChanged;
    function GetDataSource: TDataSource;
    function GetFieldCount: Integer;
    function GetFields(FieldIndex: Integer): TField;
    function GetSelectedField: TField;
    function GetSelectedIndex: Integer;
    procedure InternalLayout;
    procedure MoveCol(RawCol, Direction: Integer);
    function PtInExpandButton(X,Y: Integer; var MasterCol: TColumnExt): Boolean;
    procedure ReadColumns(Reader: TReader);
    procedure RecordChanged(Field: TField);
    procedure SetIme;
    procedure SetColumns(Value: TDBGridColumnsExt);
    procedure SetDataSource(Value: TDataSource);
    procedure SetOptions(Value: TDBGridOptionsExt);
    procedure SetSelectedField(Value: TField);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetTitleFont(Value: TFont);
    procedure TitleFontChanged(Sender: TObject);
    procedure UpdateData;
    procedure UpdateActive;
    procedure UpdateIme;
    procedure UpdateScrollBar;
    procedure UpdateRowCount;
    procedure WriteColumns(Writer: TWriter);
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMDeferLayout(var Message); message cm_DeferLayout;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
  protected
    FUpdateFields: Boolean;
    FAcquireFocus: Boolean;
    function  RawToDataColumn(ACol: Integer): Integer;
    function  DataToRawColumn(ACol: Integer): Integer;
    function  AcquireLayoutLock: Boolean;
    procedure BeginLayout;
    procedure BeginUpdate;
    procedure CalcSizingState(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure CancelLayout;
    function  CanEditAcceptKey(Key: Char): Boolean; override;
    function  CanEditModify: Boolean; override;
    function  CanEditShow: Boolean; override;
    procedure CellClick(Column: TColumnExt); dynamic;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    function CalcTitleRect(Col: TColumnExt; ARow: Integer;
      var MasterCol: TColumnExt): TRect;
    function ColumnAtDepth(Col: TColumnExt; ADepth: Integer): TColumnExt;
    procedure ColEnter; dynamic;
    procedure ColExit; dynamic;
    procedure ColWidthsChanged; override;
    function  CreateColumns: TDBGridColumnsExt; dynamic;
    function  CreateEditor: TInplaceEdit; override;
    procedure CreateWnd; override;
    procedure DeferLayout;
    procedure DefineFieldMap; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); dynamic; { obsolete }
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumnExt; State: TGridDrawState); dynamic;
    procedure EditButtonClick; dynamic;
    procedure EndLayout;
    procedure EndUpdate;
    function  GetColField(DataCol: Integer): TField;
    function  GetEditLimit: Integer; override;
    function  GetEditMask(ACol, ARow: Longint): string; override;
    function  GetEditText(ACol, ARow: Longint): string; override;
    function  GetFieldValue(ACol: Integer): string;
    function  HighlightCell(DataCol, DataRow: Integer; const Value: string;
      AState: TGridDrawState): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure InvalidateTitles;
    procedure LayoutChanged; virtual;
    procedure LinkActive(Value: Boolean); virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MoveToNextCol;
    procedure Scroll(Distance: Integer); virtual;
    procedure SetColumnAttributes; virtual;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    function  StoreColumns: Boolean;
    procedure TimedScroll(Direction: TGridScrollDirection); override;
    procedure TitleClick(Column: TColumnExt); dynamic;
    procedure TopLeftChanged; override;
    function UseRightToLeftAlignmentForField(const AField: TField;
      Alignment: TAlignment): Boolean;
    function BeginColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    function CheckColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    function EndColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    property Columns: TDBGridColumnsExt read FColumns write SetColumns;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataLink: TGridDataLinkExt read FDataLink;
    property IndicatorOffset: Byte read FIndicatorOffset;
    property LayoutLock: Byte read FLayoutLock;
    property Options: TDBGridOptionsExt read FOptions write SetOptions
      default [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgEnters];
    property ParentColor default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property SelectedRows: TBookmarkListExt read FBookmarks;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property UpdateLock: Byte read FUpdateLock;
    property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
    property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
    property OnDrawDataCell: TDrawDataCellEvent read FOnDrawDataCell
      write FOnDrawDataCell; { obsolete }
    property OnDrawColumnCell: TDrawColumnCellEventExt read FOnDrawColumnCell
      write FOnDrawColumnCell;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick
      write FOnEditButtonClick;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnCellClick: TDBGridClickEventExt read FOnCellClick write FOnCellClick;
    property OnTitleClick: TDBGridClickEventExt read FOnTitleClick write FOnTitleClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); { obsolete }
    procedure DefaultDrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumnExt; State: TGridDrawState);
    procedure DefaultHandler(var Msg); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure ShowPopupEditor(Column: TColumnExt; X: Integer = Low(Integer);
      Y: Integer = Low(Integer)); dynamic;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function ValidFieldIndex(FieldIndex: Integer): Boolean;
    property EditorMode;
    property FieldCount: Integer read GetFieldCount;
    property Fields[FieldIndex: Integer]: TField read GetFields;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
  end;

  TDBGridExt = class(TCustomDBGridExt)
  public
    property Canvas;
    property SelectedRows;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns stored False; //StoreColumns;
    property Constraints;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
    property OnTitleClick;
  end;

implementation

uses Math, DBConsts, Dialogs;


const
  bmArrow = 'DBXGARROW';
  bmEdit = 'DBXEDIT';
  bmInsert = 'DBXINSERT';
  bmMultiDot = 'DBXMULTIDOT';
  bmMultiArrow = 'DBXMULTIARROW';

  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);  { 250 million }

{ Error reporting }

procedure RaiseGridError(const S: string);
begin
  raise EInvalidGridOperation.Create(S);
end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

{ TDBGridInplaceEdit }

{ TDBGridInplaceEdit adds support for a button on the in-place editor,
  which can be used to drop down a table-based lookup list, a stringlist-based
  pick list, or (if button style is esEllipsis) fire the grid event
  OnEditButtonClick.  }

type
  TEditStyle = (esSimple, esEllipsis, esPickList, esDataList);
  TPopupListbox = class;

  TDBGridInplaceEdit = class(TInplaceEdit)
  private
    FButtonWidth: Integer;
    FDataList: TDBLookupListBox;
    FPickList: TPopupListbox;
    FActiveList: TWinControl;
    FLookupSource: TDatasource;
    FEditStyle: TEditStyle;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetEditStyle(Value: TEditStyle);
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message wm_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    function OverButton(const P: TPoint): Boolean;
    function ButtonRect: TRect;
  protected
    procedure BoundsChanged; override;
    procedure CloseUp(Accept: Boolean);
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DropDown;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
    property  EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property  ActiveList: TWinControl read FActiveList write FActiveList;
    property  DataList: TDBLookupListBox read FDataList;
    property  PickList: TPopupListbox read FPickList;
  public
    constructor Create(Owner: TComponent); override;
  end;

{ TPopupListbox }

  TPopupListbox = class(TCustomListbox)
  private
    FSearchText: String;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

procedure TPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TPopupListbox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TPopupListbox.Keypress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27: FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SelectString, WORD(-1), Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TPopupListbox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  TDBGridInPlaceEdit(Owner).CloseUp((X >= 0) and (Y >= 0) and
      (X < Width) and (Y < Height));
end;


constructor TDBGridInplaceEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TDBGridInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  SetRect(R, 2, 2, Width - 2, Height);
  if FEditStyle <> esSimple then
    if not TCustomDBGridExt(Owner).UseRightToLeftAlignment then
      Dec(R.Right, FButtonWidth)
    else
      Inc(R.Left, FButtonWidth - 2);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
end;

procedure TDBGridInplaceEdit.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList then
      ListValue := FDataList.KeyValue
    else
      if FPickList.ItemIndex <> -1 then
        ListValue := FPickList.Items[FPicklist.ItemIndex];
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    if Assigned(FDataList) then
      FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if FActiveList = FDataList then
        with TCustomDBGridExt(Grid), Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify then
          begin
            DataSet.Edit;
            MasterField.Value := ListValue;
          end;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with TCustomDBGridExt(Grid), Columns[SelectedIndex].Field do
            Text := ListValue;
  end;
end;

procedure TDBGridInplaceEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TDBGridInplaceEdit.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
  Column: TColumnExt;
begin
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with TCustomDBGridExt(Grid) do
      Column := Columns[SelectedIndex];
    if FActiveList = FDataList then
    with Column.Field do
    begin
      FDataList.Color := Color;
      FDataList.Font := Font;
      FDataList.RowCount := Column.DropDownRows;
      FLookupSource.DataSet := LookupDataSet;
      FDataList.KeyField := LookupKeyFields;
      FDataList.ListField := LookupResultField;
      FDataList.ListSource := FLookupSource;
      FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
{      J := Column.DefaultWidth;
      if J > FDataList.ClientWidth then
        FDataList.ClientWidth := J;
}    end
    else
    begin
      FPickList.Color := Color;
      FPickList.Font := Font;
      FPickList.Items := Column.Picklist;
      if FPickList.Items.Count >= Integer(Column.DropDownRows) then
        FPickList.Height := Integer(Column.DropDownRows) * FPickList.ItemHeight + 4
      else
        FPickList.Height := FPickList.Items.Count * FPickList.ItemHeight + 4;
      if Column.Field.IsNull then
        FPickList.ItemIndex := -1
      else
        FPickList.ItemIndex := FPickList.Items.IndexOf(Column.Field.Text);
      J := FPickList.ClientWidth;
      for I := 0 to FPickList.Items.Count - 1 do
      begin
        Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
        if Y > J then J := Y;
      end;
      FPickList.ClientWidth := J;
    end;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FActiveList.Height > Screen.Height then Y := P.Y - FActiveList.Height;
    SetWindowPos(FActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

type
  TWinControlCracker = class(TWinControl) end;

procedure TDBGridInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    TCustomDBGridExt(Grid).EditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TDBGridInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TDBGridInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FEditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
  begin
    if FListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(FActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and (FEditStyle = esEllipsis) and WasPressed then
    TCustomDBGridExt(Grid).EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
begin
  if FEditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    if FEditStyle in [esDataList, esPickList] then
    begin
      if FActiveList = nil then
        Flags := DFCS_INACTIVE
      else if FPressed then
        Flags := DFCS_FLAT or DFCS_PUSHED;
      DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
    end
    else   { esEllipsis }
    begin
      if FPressed then Flags := BF_FLAT;
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
      X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(FPressed);
      Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(FPressed);
      W := FButtonWidth shr 3;
      if W = 0 then W := 1;
      PatBlt(DC, X, Y, W, W, BLACKNESS);
      PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
      PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TDBGridInplaceEdit.SetEditStyle(Value: TEditStyle);
begin
  if Value = FEditStyle then Exit;
  FEditStyle := Value;
  case Value of
    esPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TPopupListbox.Create(Self);
          FPickList.Visible := False;
          FPickList.Parent := Self;
          FPickList.OnMouseUp := ListMouseUp;
          FPickList.IntegralHeight := True;
          FPickList.ItemHeight := 11;
        end;
        FActiveList := FPickList;
      end;
    esDataList:
      begin
        if FDataList = nil then
        begin
          FDataList := TPopupDataList.Create(Self);
          FDataList.Visible := False;
          FDataList.Parent := Self;
          FDataList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FDataList;
      end;
  else  { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
  with TCustomDBGridExt(Grid) do
    Self.ReadOnly := Columns[SelectedIndex].ReadOnly;
  Repaint;
end;

procedure TDBGridInplaceEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TDBGridInplaceEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TDBGridInplaceEdit.UpdateContents;
var
  Column: TColumnExt;
  NewStyle: TEditStyle;
  MasterField: TField;
begin
  with TCustomDBGridExt(Grid) do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
   cbsEllipsis: NewStyle := esEllipsis;
   cbsAuto:
     if Assigned(Column.Field) then
     with Column.Field do
     begin
       { Show the dropdown button only if the field is editable }
       if FieldKind = fkLookup then
       begin
         MasterField := Dataset.FieldByName(KeyFields);
         { Column.DefaultReadonly will always be True for a lookup field.
           Test if Column.ReadOnly has been assigned a value of True }
         if Assigned(MasterField) and MasterField.CanModify and
           not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
           with TCustomDBGridExt(Grid) do
             if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
               NewStyle := esDataList
       end
       else
       if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
         not Column.Readonly then
         NewStyle := esPickList
       else if DataType in [ftDataset, ftReference] then
         NewStyle := esEllipsis;
     end;
  end;
  EditStyle := NewStyle;
  inherited UpdateContents;
  Font.Assign(Column.Font);
end;

procedure TDBGridInplaceEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) then
    CloseUp(False);
end;

procedure TDBGridInplaceEdit.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TDBGridInplaceEdit.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if HWND(Message.WParam) <> TCustomDBGridExt(Grid).Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
  CloseUp(False);
end;

function TDBGridInplaceEdit.ButtonRect: TRect;
begin
  if not TCustomDBGridExt(Owner).UseRightToLeftAlignment then
    Result := Rect(Width - FButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, FButtonWidth, Height);
end;

function TDBGridInplaceEdit.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

procedure TDBGridInplaceEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (FEditStyle <> esSimple) and OverButton(Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TDBGridInplaceEdit.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TDBGridInplaceEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (FEditStyle <> esSimple) and OverButton(P) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TDBGridInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle in [esPickList, esDataList] then
      with TWMKey(Message) do
      begin
        DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
        if (CharCode <> 0) and FListVisible then
        begin
          with TMessage(Message) do
            SendMessage(FActiveList.Handle, Msg, WParam, LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;


{ TGridDataLinkExt }

type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

constructor TGridDataLinkExt.Create(AGrid: TCustomDBGridExt);
begin
  inherited Create;
  FGrid := AGrid;
  VisualControl := True;
end;

destructor TGridDataLinkExt.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TGridDataLinkExt.GetDefaultFields: Boolean;
var
  I: Integer;
begin
  Result := True;
  if DataSet <> nil then Result := DataSet.DefaultFields;
  if Result and SparseMap then
  for I := 0 to FFieldCount-1 do
    if FFieldMap[I] < 0 then
    begin
      Result := False;
      Exit;
    end;
end;

function TGridDataLinkExt.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (FFieldMap[I] >= 0) then
    Result := DataSet.FieldList[FFieldMap[I]]
  else
    Result := nil;
end;

function TGridDataLinkExt.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  if FFieldCount >= MaxMapSize then RaiseGridError(STooManyColumns);
  if SparseMap then
    Field := DataSet.FindField(FieldName)
  else
    Field := DataSet.FieldByName(FieldName);

  if FFieldCount = Length(FFieldMap) then
  begin
    NewSize := Length(FFieldMap);
    if NewSize = 0 then
      NewSize := 8
    else
      Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    SetLength(FFieldMap, NewSize);
  end;
  if Assigned(Field) then
  begin
    FFieldMap[FFieldCount] := Dataset.FieldList.IndexOfObject(Field);
    Field.FreeNotification(FGrid);
  end
  else
    FFieldMap[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TGridDataLinkExt.ActiveChanged;
begin
  FGrid.LinkActive(Active);
  FModified := False;
end;

procedure TGridDataLinkExt.ClearMapping;
begin
  FFieldMap := nil;
  FFieldCount := 0;
end;

procedure TGridDataLinkExt.Modified;
begin
  FModified := True;
end;

procedure TGridDataLinkExt.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := False;
end;

procedure TGridDataLinkExt.DataSetScrolled(Distance: Integer);
begin
  FGrid.Scroll(Distance);
end;

procedure TGridDataLinkExt.LayoutChanged;
var
  SaveState: Boolean;
begin
  { FLayoutFromDataset determines whether default column width is forced to
    be at least wide enough for the column title.  }
  SaveState := FGrid.FLayoutFromDataset;
  FGrid.FLayoutFromDataset := True;
  try
    FGrid.LayoutChanged;
  finally
    FGrid.FLayoutFromDataset := SaveState;
  end;
  inherited LayoutChanged;
end;

procedure TGridDataLinkExt.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
      FGrid.ShowEditor;
    end;
  end;
end;

procedure TGridDataLinkExt.EditingChanged;
begin
  FGrid.EditingChanged;
end;

procedure TGridDataLinkExt.RecordChanged(Field: TField);
begin
  FGrid.RecordChanged(Field);
  FModified := False;
end;

procedure TGridDataLinkExt.UpdateData;
begin
  FInUpdateData := True;
  try
    if FModified then FGrid.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

function TGridDataLinkExt.GetMappedIndex(ColIndex: Integer): Integer;
begin
  if (0 <= ColIndex) and (ColIndex < FFieldCount) then
    Result := FFieldMap[ColIndex]
  else
    Result := -1;
end;

procedure TGridDataLinkExt.Reset;
begin
  if FModified then RecordChanged(nil) else Dataset.Cancel;
end;

function TGridDataLinkExt.IsAggRow(Value: Integer): Boolean;
begin
  Result := False;
end;

procedure TGridDataLinkExt.BuildAggMap;
begin
end;

{ TColumnTitleExt }
constructor TColumnTitleExt.Create(Column: TColumnExt);
begin
  inherited Create;
  FColumn := Column;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
end;

destructor TColumnTitleExt.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TColumnTitleExt.Assign(Source: TPersistent);
begin
  if Source is TColumnTitleExt then
  begin
    if cvTitleAlignment in TColumnTitleExt(Source).FColumn.FAssignedValues then
      Alignment := TColumnTitleExt(Source).Alignment;
    if cvTitleColor in TColumnTitleExt(Source).FColumn.FAssignedValues then
      Color := TColumnTitleExt(Source).Color;
    if cvTitleCaption in TColumnTitleExt(Source).FColumn.FAssignedValues then
      Caption := TColumnTitleExt(Source).Caption;
    if cvTitleFont in TColumnTitleExt(Source).FColumn.FAssignedValues then
      Font := TColumnTitleExt(Source).Font;
  end
  else
    inherited Assign(Source);
end;

function TColumnTitleExt.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TColumnTitleExt.DefaultColor: TColor;
var
  Grid: TCustomDBGridExt;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.FixedColor
  else
    Result := clBtnFace;
end;

function TColumnTitleExt.DefaultFont: TFont;
var
  Grid: TCustomDBGridExt;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.TitleFont
  else
    Result := FColumn.Font;
end;

function TColumnTitleExt.DefaultCaption: string;
var
  Field: TField;
begin
  Field := FColumn.Field;
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FColumn.FieldName;
end;

procedure TColumnTitleExt.FontChanged(Sender: TObject);
begin
  Include(FColumn.FAssignedValues, cvTitleFont);
  FColumn.Changed(True);
end;

function TColumnTitleExt.GetAlignment: TAlignment;
begin
  if cvTitleAlignment in FColumn.FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TColumnTitleExt.GetColor: TColor;
begin
  if cvTitleColor in FColumn.FAssignedValues then
    Result := FColor
  else
    Result := DefaultColor;
end;

function TColumnTitleExt.GetCaption: string;
begin
  if cvTitleCaption in FColumn.FAssignedValues then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TColumnTitleExt.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvTitleFont in FColumn.FAssignedValues) then
  begin
    Def := DefaultFont;
    if (FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color) then
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TColumnTitleExt.IsAlignmentStored: Boolean;
begin
  Result := (cvTitleAlignment in FColumn.FAssignedValues) and
    (FAlignment <> DefaultAlignment);
end;

function TColumnTitleExt.IsColorStored: Boolean;
begin
  Result := (cvTitleColor in FColumn.FAssignedValues) and
    (FColor <> DefaultColor);
end;

function TColumnTitleExt.IsFontStored: Boolean;
begin
  Result := (cvTitleFont in FColumn.FAssignedValues);
end;

function TColumnTitleExt.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in FColumn.FAssignedValues) and
    (FCaption <> DefaultCaption);
end;

procedure TColumnTitleExt.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvTitleFont in FColumn.FAssignedValues) then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnTitleExt.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvTitleFont in FColumn.FAssignedValues;
  FColumn.FAssignedValues := FColumn.FAssignedValues - ColumnTitleValues;
  FCaption := '';
  RefreshDefaultFont;
  { If font was assigned, changing it back to default may affect grid title
    height, and title height changes require layout and redraw of the grid. }
  FColumn.Changed(FontAssigned);
end;

procedure TColumnTitleExt.SetAlignment(Value: TAlignment);
begin
  if (cvTitleAlignment in FColumn.FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FColumn.FAssignedValues, cvTitleAlignment);
  FColumn.Changed(False);
end;

procedure TColumnTitleExt.SetColor(Value: TColor);
begin
  if (cvTitleColor in FColumn.FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FColumn.FAssignedValues, cvTitleColor);
  FColumn.Changed(False);
end;

procedure TColumnTitleExt.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TColumnTitleExt.SetCaption(const Value: string);
var
  Grid: TCustomDBGridExt;
begin
  if Column.IsStored then
  begin
    if (cvTitleCaption in FColumn.FAssignedValues) and (Value = FCaption) then Exit;
    FCaption := Value;
    Include(Column.FAssignedValues, cvTitleCaption);
    Column.Changed(False);
  end
  else
  begin
    Grid := Column.GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Column.Field) then
      Column.Field.DisplayLabel := Value;
  end;
end;


{ TColumnExt }

constructor TColumnExt.Create(Collection: TCollection);
var
  Grid: TCustomDBGridExt;
begin
  Grid := nil;
  if Assigned(Collection) and (Collection is TDBGridColumnsExt) then
    Grid := TDBGridColumnsExt(Collection).Grid;
  if Assigned(Grid) then Grid.BeginLayout;
  try
    inherited Create(Collection);
    FDropDownRows := 7;
    FButtonStyle := cbsAuto;
    FFont := TFont.Create;
    FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
    FImeMode := imDontCare;
    FImeName := Screen.DefaultIme;
    FTitle := CreateTitle;
    FVisible := True;
    FExpanded := True;
    FStored := True;
  finally
    if Assigned(Grid) then Grid.EndLayout;
  end;
end;

destructor TColumnExt.Destroy;
begin
  FTitle.Free;
  FFont.Free;
  FPickList.Free;
  inherited Destroy;
end;

procedure TColumnExt.Assign(Source: TPersistent);
begin
  if Source is TColumnExt then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := TColumnExt(Source).FieldName;
      if cvColor in TColumnExt(Source).AssignedValues then
        Color := TColumnExt(Source).Color;
      if cvWidth in TColumnExt(Source).AssignedValues then
        Width := TColumnExt(Source).Width;
      if cvFont in TColumnExt(Source).AssignedValues then
        Font := TColumnExt(Source).Font;
      if cvImeMode in TColumnExt(Source).AssignedValues then
        ImeMode := TColumnExt(Source).ImeMode;
      if cvImeName in TColumnExt(Source).AssignedValues then
        ImeName := TColumnExt(Source).ImeName;
      if cvAlignment in TColumnExt(Source).AssignedValues then
        Alignment := TColumnExt(Source).Alignment;
      if cvReadOnly in TColumnExt(Source).AssignedValues then
        ReadOnly := TColumnExt(Source).ReadOnly;
      Title := TColumnExt(Source).Title;
      DropDownRows := TColumnExt(Source).DropDownRows;
      ButtonStyle := TColumnExt(Source).ButtonStyle;
      PickList := TColumnExt(Source).PickList;
      PopupMenu := TColumnExt(Source).PopupMenu;
      FVisible := TColumnExt(Source).FVisible;
      FExpanded := TColumnExt(Source).FExpanded;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TColumnExt.CreateTitle: TColumnTitleExt;
begin
  Result := TColumnTitleExt.Create(Self);
end;

function TColumnExt.DefaultAlignment: TAlignment;
begin
  if Assigned(Field) then
    Result := FField.Alignment
  else
    Result := taLeftJustify;
end;

function TColumnExt.DefaultColor: TColor;
var
  Grid: TCustomDBGridExt;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Color
  else
    Result := clWindow;
end;

function TColumnExt.DefaultFont: TFont;
var
  Grid: TCustomDBGridExt;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Font
  else
    Result := FFont;
end;

function TColumnExt.DefaultImeMode: TImeMode;
var
  Grid: TCustomDBGridExt;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.ImeMode
  else
    Result := FImeMode;
end;

function TColumnExt.DefaultImeName: TImeName;
var
  Grid: TCustomDBGridExt;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.ImeName
  else
    Result := FImeName;
end;

function TColumnExt.DefaultReadOnly: Boolean;
var
  Grid: TCustomDBGridExt;
begin
  Grid := GetGrid;
  Result := (Assigned(Grid) and Grid.ReadOnly) or
    (Assigned(Field) and FField.ReadOnly);
end;

function TColumnExt.DefaultWidth: Integer;
var
  W: Integer;
  RestoreCanvas: Boolean;
  TM: TTextMetric;
begin
  if GetGrid = nil then
  begin
    Result := 64;
    Exit;
  end;
  with GetGrid do
  begin
    if Assigned(Field) then
    begin
      RestoreCanvas := not HandleAllocated;
      if RestoreCanvas then
        Canvas.Handle := GetDC(0);
      try
        Canvas.Font := Self.Font;
        GetTextMetrics(Canvas.Handle, TM);
        Result := Field.DisplayWidth * (Canvas.TextWidth('0') - TM.tmOverhang)
          + TM.tmOverhang + 4;
        if dgTitles in Options then
        begin
          Canvas.Font := Title.Font;
          W := Canvas.TextWidth(Title.Caption) + 4;
          if Result < W then
            Result := W;
        end;
      finally
        if RestoreCanvas then
        begin
          ReleaseDC(0,Canvas.Handle);
          Canvas.Handle := 0;
        end;
      end;
    end
    else
      Result := DefaultColWidth;
  end;
end;

procedure TColumnExt.FontChanged;
begin
  Include(FAssignedValues, cvFont);
  Title.RefreshDefaultFont;
  Changed(False);
end;

function TColumnExt.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TColumnExt.GetColor: TColor;
begin
  if cvColor in FAssignedValues then
    Result := FColor
  else
    Result := DefaultColor;
end;

function TColumnExt.GetExpanded: Boolean;
begin
  Result := FExpanded and Expandable;
end;

function TColumnExt.GetField: TField;
var
  Grid: TCustomDBGridExt;
begin    { Returns Nil if FieldName can't be found in dataset }
  Grid := GetGrid;
  if (FField = nil) and (Length(FFieldName) > 0) and Assigned(Grid) and
    Assigned(Grid.DataLink.DataSet) then
  with Grid.Datalink.Dataset do
    if Active or (not DefaultFields) then
      SetField(FindField(FieldName));
  Result := FField;
end;

function TColumnExt.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if not (cvFont in FAssignedValues) and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TColumnExt.GetGrid: TCustomDBGridExt;
begin
  if Assigned(Collection) and (Collection is TDBGridColumnsExt) then
    Result := TDBGridColumnsExt(Collection).Grid
  else
    Result := nil;
end;

function TColumnExt.GetDisplayName: string;
begin
  Result := FFieldName;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TColumnExt.GetImeMode: TImeMode;
begin
  if cvImeMode in FAssignedValues then
    Result := FImeMode
  else
    Result := DefaultImeMode;
end;

function TColumnExt.GetImeName: TImeName;
begin
  if cvImeName in FAssignedValues then
    Result := FImeName
  else
    Result := DefaultImeName;
end;

function TColumnExt.GetParentColumn: TColumnExt;
var
  Col: TColumnExt;
  Fld: TField;
  I: Integer;
begin
  Result := nil;
  Fld := Field;
  if (Fld <> nil) and (Fld.ParentField <> nil) and (Collection <> nil) then
    for I := Index - 1 downto 0 do
    begin
      Col := TColumnExt(Collection.Items[I]);
      if Fld.ParentField = Col.Field then
      begin
        Result := Col;
        Exit;
      end;
    end;
end;

function TColumnExt.GetPickList: TStrings;
begin
  if FPickList = nil then
    FPickList := TStringList.Create;
  Result := FPickList;
end;

function TColumnExt.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
end;

function TColumnExt.GetShowing: Boolean;
var
  Col: TColumnExt;
begin
  Result := not Expanded and Visible;
  if Result then
  begin
    Col := Self;
    repeat
      Col := Col.ParentColumn;
    until (Col = nil) or not Col.Expanded;
    Result := Col = nil;
  end;
end;

function TColumnExt.GetVisible: Boolean;
var
  Col: TColumnExt;
begin
  Result := FVisible;
  if Result then
  begin
    Col := ParentColumn;
    Result := Result and ((Col = nil) or Col.Visible);
  end;
end;

function TColumnExt.GetWidth: Integer;
begin
  if not Showing then
    Result := -1
  else if cvWidth in FAssignedValues then
    Result := FWidth
  else
    Result := DefaultWidth;
end;

function TColumnExt.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TColumnExt.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TColumnExt.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

function TColumnExt.IsImeModeStored: Boolean;
begin
  Result := (cvImeMode in FAssignedValues) and (FImeMode <> DefaultImeMode);
end;

function TColumnExt.IsImeNameStored: Boolean;
begin
  Result := (cvImeName in FAssignedValues) and (FImeName <> DefaultImeName);
end;

function TColumnExt.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

function TColumnExt.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TColumnExt.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnExt.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFont in FAssignedValues;
  FTitle.RestoreDefaults;
  FAssignedValues := [];
  RefreshDefaultFont;
  FPickList.Free;
  FPickList := nil;
  ButtonStyle := cbsAuto;
  Changed(FontAssigned);
end;

procedure TColumnExt.SetAlignment(Value: TAlignment);
var
  Grid: TCustomDBGridExt;
begin
  if IsStored then
  begin
    if (cvAlignment in FAssignedValues) and (Value = FAlignment) then Exit;
    FAlignment := Value;
    Include(FAssignedValues, cvAlignment);
    Changed(False);
  end
  else
  begin
    Grid := GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Field) then
      Field.Alignment := Value;
  end;
end;

procedure TColumnExt.SetButtonStyle(Value: TColumnButtonStyle);
begin
  if Value = FButtonStyle then Exit;
  FButtonStyle := Value;
  Changed(False);
end;

procedure TColumnExt.SetColor(Value: TColor);
begin
  if (cvColor in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
end;

procedure TColumnExt.SetField(Value: TField);
begin
  if FField = Value then Exit;
  FField := Value;
  if Assigned(Value) then
    FFieldName := Value.FullName;
  if not IsStored then
  begin
    if Value = nil then
      FFieldName := '';
    RestoreDefaults;
  end;
  Changed(False);
end;

procedure TColumnExt.SetFieldName(const Value: String);
var
  AField: TField;
  Grid: TCustomDBGridExt;
begin
  AField := nil;
  Grid := GetGrid;
  if Assigned(Grid) and Assigned(Grid.DataLink.DataSet) and
    not (csLoading in Grid.ComponentState) and (Length(Value) > 0) then
      AField := Grid.DataLink.DataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  SetField(AField);
  Changed(False);
end;

procedure TColumnExt.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(False);
end;

procedure TColumnExt.SetImeMode(Value: TImeMode);
begin
  if (cvImeMode in FAssignedValues) or (Value <> DefaultImeMode) then
  begin
    FImeMode := Value;
    Include(FAssignedValues, cvImeMode);
  end;
  Changed(False);
end;

procedure TColumnExt.SetImeName(Value: TImeName);
begin
  if (cvImeName in FAssignedValues) or (Value <> DefaultImeName) then
  begin
    FImeName := Value;
    Include(FAssignedValues, cvImeName);
  end;
  Changed(False);
end;

procedure TColumnExt.SetIndex(Value: Integer);
var
  Grid: TCustomDBGridExt;
  Fld: TField;
  I, OldIndex: Integer;
  Col: TColumnExt;
begin
  OldIndex := Index;
  Grid := GetGrid;

  if IsStored then
  begin
    Grid.BeginLayout;
    try
      I := OldIndex + 1;  // move child columns along with parent
      while (I < Collection.Count) and (TColumnExt(Collection.Items[I]).ParentColumn = Self) do
        Inc(I);
      Dec(I);
      if OldIndex > Value then   // column moving left
      begin
        while I > OldIndex do
        begin
          Collection.Items[I].Index := Value;
          Inc(OldIndex);
        end;
        inherited SetIndex(Value);
      end
      else
      begin
        inherited SetIndex(Value);
        while I > OldIndex do
        begin
          Collection.Items[OldIndex].Index := Value;
          Dec(I);
        end;
      end;
    finally
      Grid.EndLayout;
    end;
  end
  else
  begin
    if (Grid <> nil) and Grid.Datalink.Active then
    begin
      if Grid.AcquireLayoutLock then
      try
        Col := Grid.ColumnAtDepth(Grid.Columns[Value], Depth);
        if (Col <> nil) then
        begin
          Fld := Col.Field;
          if Assigned(Fld) then
            Field.Index := Fld.Index;
        end;
      finally
        Grid.EndLayout;
      end;
    end;
    inherited SetIndex(Value);
  end;
end;

procedure TColumnExt.SetPickList(Value: TStrings);
begin
  if Value = nil then
  begin
    FPickList.Free;
    FPickList := nil;
    Exit;
  end;
  PickList.Assign(Value);
end;

procedure TColumnExt.SetPopupMenu(Value: TPopupMenu);
begin
  FPopupMenu := Value;
  if Value <> nil then Value.FreeNotification(GetGrid);
end;

procedure TColumnExt.SetReadOnly(Value: Boolean);
var
  Grid: TCustomDBGridExt;
begin
  Grid := GetGrid;
  if not IsStored and Assigned(Grid) and Grid.Datalink.Active and Assigned(Field) then
    Field.ReadOnly := Value
  else
  begin
    if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
    FReadOnly := Value;
    Include(FAssignedValues, cvReadOnly);
    Changed(False);
  end;
end;

procedure TColumnExt.SetTitle(Value: TColumnTitleExt);
begin
  FTitle.Assign(Value);
end;

procedure TColumnExt.SetWidth(Value: Integer);
var
  Grid: TCustomDBGridExt;
  TM: TTextMetric;
  DoSetWidth: Boolean;
begin
  DoSetWidth := IsStored;
  if not DoSetWidth then
  begin
    Grid := GetGrid;
    if Assigned(Grid) then
    begin
      if Grid.HandleAllocated and Assigned(Field) and Grid.FUpdateFields then
      with Grid do
      begin
        Canvas.Font := Self.Font;
        GetTextMetrics(Canvas.Handle, TM);
        Field.DisplayWidth := (Value + (TM.tmAveCharWidth div 2) - TM.tmOverhang - 3)
          div TM.tmAveCharWidth;
      end;
      if (not Grid.FLayoutFromDataset) or (cvWidth in FAssignedValues) then
        DoSetWidth := True;
    end
    else
      DoSetWidth := True;
  end;
  if DoSetWidth then
  begin
    if ((cvWidth in FAssignedValues) or (Value <> DefaultWidth))
      and (Value <> -1) then
    begin
      FWidth := Value;
      Include(FAssignedValues, cvWidth);
    end;
    Changed(False);
  end;
end;

procedure TColumnExt.SetVisible(Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TColumnExt.SetExpanded(Value: Boolean);
const
  Direction: array [Boolean] of ShortInt = (-1,1);
var
  Grid: TCustomDBGridExt;
  WasShowing: Boolean;
begin
  if Value <> FExpanded then
  begin
    Grid := GetGrid;
    WasShowing := (Grid <> nil) and Grid.Columns[Grid.SelectedIndex].Showing;
    FExpanded := Value;
    Changed(True);
    if (Grid <> nil) and WasShowing then
    begin
      if not Grid.Columns[Grid.SelectedIndex].Showing then
        // The selected cell was hidden by this expand operation
        // Select 1st child (next col = 1) when parent is expanded
        // Select child's parent (prev col = -1) when parent is collapsed
        Grid.MoveCol(Grid.Col, Direction[FExpanded]);
    end;
  end;
end;

function TColumnExt.Depth: Integer;
var
  Col: TColumnExt;
begin
  Result := 0;
  Col := ParentColumn;
  if Col <> nil then Result := Col.Depth + 1;
end;

function TColumnExt.GetExpandable: Boolean;
var
  Fld: TField;
begin
  Fld := Field;
  Result := (Fld <> nil) and (Fld.DataType in [ftADT, ftArray]);
end;

{ TDBGridColumnsExt }

constructor TDBGridColumnsExt.Create(Grid: TCustomDBGridExt; ColumnClass: TColumnClassExt);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TDBGridColumnsExt.Add: TColumnExt;
begin
  Result := TColumnExt(inherited Add);
end;

function TDBGridColumnsExt.GetColumn(Index: Integer): TColumnExt;
begin
  Result := TColumnExt(inherited Items[Index]);
end;

function TDBGridColumnsExt.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

procedure TDBGridColumnsExt.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FColumns: TDBGridColumnsExt;
  published
    property Columns: TDBGridColumnsExt read FColumns write FColumns;
  end;

procedure TDBGridColumnsExt.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := FGrid.CreateColumns;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Columns);
  finally
    Wrapper.Columns.Free;
    Wrapper.Free;
  end;
end;

procedure TDBGridColumnsExt.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count-1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TDBGridColumnsExt.RebuildColumns;

  procedure AddFields(Fields: TFields; Depth: Integer);
  var
    I: Integer;
  begin
    Inc(Depth);
    for I := 0 to Fields.Count-1 do
    begin
      Add.FieldName := Fields[I].FullName;
      if Fields[I].DataType in [ftADT, ftArray] then
        AddFields((Fields[I] as TObjectField).Fields, Depth);
    end;
  end;

begin
  if Assigned(FGrid) and Assigned(FGrid.DataSource) and
    Assigned(FGrid.Datasource.Dataset) then
  begin
    FGrid.BeginLayout;
    try
      Clear;
      AddFields(FGrid.Datasource.Dataset.Fields, 0);
    finally
      FGrid.EndLayout;
    end
  end
  else
    Clear;
end;

procedure TDBGridColumnsExt.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TDBGridColumnsExt.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TDBGridColumnsExt.SetColumn(Index: Integer; Value: TColumnExt);
begin
  Items[Index].Assign(Value);
end;

procedure TDBGridColumnsExt.SetState(NewState: TDBGridColumnsState);
begin
  if NewState = State then Exit;
  if NewState = csDefault then
    Clear
  else
    RebuildColumns;
end;

procedure TDBGridColumnsExt.Update(Item: TCollectionItem);
var
  Raw: Integer;
begin
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if Item = nil then
  begin
    FGrid.LayoutChanged;
  end
  else
  begin
    Raw := FGrid.DataToRawColumn(Item.Index);
    FGrid.InvalidateCol(Raw);
    FGrid.ColWidths[Raw] := TColumnExt(Item).Width;
  end;
end;

function TDBGridColumnsExt.InternalAdd: TColumnExt;
begin
  Result := Add;
  Result.IsStored := False;
end;

function TDBGridColumnsExt.GetState: TDBGridColumnsState;
begin
  Result := TDBGridColumnsState((Count > 0) and Items[0].IsStored);
end;

{ TBookmarkListExt }

constructor TBookmarkListExt.Create(AGrid: TCustomDBGridExt);
begin
  inherited Create;
  FList := TStringList.Create;
  FList.OnChange := StringsChanged;
  FGrid := AGrid;
end;

destructor TBookmarkListExt.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TBookmarkListExt.Clear;
begin
  if FList.Count = 0 then Exit;
  FList.Clear;
  FGrid.Invalidate;
end;

function TBookmarkListExt.Compare(const Item1, Item2: TBookmarkStr): Integer;
begin
  with FGrid.Datalink.Datasource.Dataset do
    Result := CompareBookmarks(TBookmark(Item1), TBookmark(Item2));
end;

function TBookmarkListExt.CurrentRow: TBookmarkStr;
begin
  if not FLinkActive then RaiseGridError(sDataSetClosed);
  Result := FGrid.Datalink.Datasource.Dataset.Bookmark;
end;

function TBookmarkListExt.GetCurrentRowSelected: Boolean;
var
  Index: Integer;
begin
  Result := Find(CurrentRow, Index);
end;

function TBookmarkListExt.Find(const Item: TBookmarkStr; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Item = FCache) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    Result := FCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := FList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(FList[I], Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := Result;
end;

function TBookmarkListExt.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TBookmarkListExt.GetItem(Index: Integer): TBookmarkStr;
begin
  Result := FList[Index];
end;

function TBookmarkListExt.IndexOf(const Item: TBookmarkStr): Integer;
begin
  if not Find(Item, Result) then
    Result := -1;
end;

procedure TBookmarkListExt.LinkActive(Value: Boolean);
begin
  Clear;
  FLinkActive := Value;
end;

procedure TBookmarkListExt.Delete;
var
  I: Integer;
begin
  with FGrid.Datalink.Datasource.Dataset do
  begin
    DisableControls;
    try
      for I := FList.Count-1 downto 0 do
      begin
        Bookmark := FList[I];
        Delete;
        FList.Delete(I);
      end;
    finally
      EnableControls;
    end;
  end;
end;

function TBookmarkListExt.Refresh: Boolean;
var
  I: Integer;
begin
  Result := False;
  with FGrid.DataLink.Datasource.Dataset do
  try
    CheckBrowseMode;
    for I := FList.Count - 1 downto 0 do
      if not BookmarkValid(TBookmark(FList[I])) then
      begin
        Result := True;
        FList.Delete(I);
      end;
  finally
    UpdateCursorPos;
    if Result then FGrid.Invalidate;
  end;
end;

procedure TBookmarkListExt.SetCurrentRowSelected(Value: Boolean);
var
  Index: Integer;
  Current: TBookmarkStr;
begin
  Current := CurrentRow;
  if (Length(Current) = 0) or (Find(Current, Index) = Value) then Exit;
  if Value then
    FList.Insert(Index, Current)
  else
    FList.Delete(Index);
  FGrid.InvalidateRow(FGrid.Row);
end;

procedure TBookmarkListExt.StringsChanged(Sender: TObject);
begin
  FCache := '';
  FCacheIndex := -1;
end;


{ TCustomDBGridExt }

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then DrawBitmap.Free;
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        DrawText(Handle, PChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then  
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

constructor TCustomDBGridExt.Create(AOwner: TComponent);
var
  Bmp: TBitmap;
begin
  inherited Create(AOwner);
  inherited DefaultDrawing := False;
  FAcquireFocus := True;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    FIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiDot);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    FIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;
  FTitleOffset := 1;
  FIndicatorOffset := 1;
  FUpdateFields := True;
  FOptions := [dgEditing, dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgEnters];
  if SysLocale.PriLangID = LANG_KOREAN then
    Include(FOptions, dgAlwaysShowEditor);
  DesignOptionsBoost := [goColSizing];
  VirtualView := True;
  UsesBitmap;
  ScrollBars := ssHorizontal;
  inherited Options := [goFixedHorzLine, goFixedVertLine, goHorzLine,
    goVertLine, goColSizing, goColMoving, goTabs, goEditing];
  FColumns := CreateColumns;
  FVisibleColumns := TList.Create;
  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := TGridDataLinkExt.Create(Self);
  Color := clWindow;
  ParentColor := False;
  FTitleFont := TFont.Create;
  FTitleFont.OnChange := TitleFontChanged;
  FSaveCellExtents := False;
  FUserChange := True;
  FDefaultDrawing := True;
  FBookmarks := TBookmarkListExt.Create(Self);
  HideEditor;
end;

destructor TCustomDBGridExt.Destroy;
begin
  FColumns.Free;
  FColumns := nil;
  FVisibleColumns.Free;
  FVisibleColumns := nil;
  FDataLink.Free;
  FDataLink := nil;
  FIndicators.Free;
  FTitleFont.Free;
  FTitleFont := nil;
  FBookmarks.Free;
  FBookmarks := nil;
  inherited Destroy;
  ReleaseBitmap;
end;

function TCustomDBGridExt.AcquireFocus: Boolean;
begin
  Result := True;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

function TCustomDBGridExt.RawToDataColumn(ACol: Integer): Integer;
begin
  Result := ACol - FIndicatorOffset;
end;

function TCustomDBGridExt.DataToRawColumn(ACol: Integer): Integer;
begin
  Result := ACol + FIndicatorOffset;
end;

function TCustomDBGridExt.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TCustomDBGridExt.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then Columns.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TCustomDBGridExt.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TCustomDBGridExt.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      Columns.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

function TCustomDBGridExt.CanEditAcceptKey(Key: Char): Boolean;
begin
  with Columns[SelectedIndex] do
    Result := FDatalink.Active and Assigned(Field) and Field.IsValidChar(Key);
end;

function TCustomDBGridExt.CanEditModify: Boolean;
begin
  Result := False;
  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly then
  with Columns[SelectedIndex] do
    if (not ReadOnly) and Assigned(Field) and Field.CanModify
      and (not (Field.DataType in ftNonTextTypes) or Assigned(Field.OnSetText)) then
    begin
      FDatalink.Edit;
      Result := FDatalink.Editing;
      if Result then FDatalink.Modified;
    end;
end;

function TCustomDBGridExt.CanEditShow: Boolean;
begin
  Result := (LayoutLock = 0) and inherited CanEditShow;
end;

procedure TCustomDBGridExt.CellClick(Column: TColumnExt);
begin
  if Assigned(FOnCellClick) then FOnCellClick(Column);
end;

procedure TCustomDBGridExt.ColEnter;
begin
  UpdateIme;
  if Assigned(FOnColEnter) then FOnColEnter(Self);
end;

procedure TCustomDBGridExt.ColExit;
begin
  if Assigned(FOnColExit) then FOnColExit(Self);
end;

procedure TCustomDBGridExt.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  FromIndex := RawToDataColumn(FromIndex);
  ToIndex := RawToDataColumn(ToIndex);
  Columns[FromIndex].Index := ToIndex;
  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
end;

procedure TCustomDBGridExt.ColWidthsChanged;
var
  I: Integer;
begin
  inherited ColWidthsChanged;
  if (FDatalink.Active or (FColumns.State = csCustomized)) and
    AcquireLayoutLock then
  try
    for I := FIndicatorOffset to ColCount - 1 do
      FColumns[I - FIndicatorOffset].Width := ColWidths[I];
  finally
    EndLayout;
  end;
end;

function TCustomDBGridExt.CreateColumns: TDBGridColumnsExt;
begin
  Result := TDBGridColumnsExt.Create(Self, TColumnExt);
end;

function TCustomDBGridExt.CreateEditor: TInplaceEdit;
begin
  Result := TDBGridInplaceEdit.Create(Self);
end;

procedure TCustomDBGridExt.CreateWnd;
begin
  BeginUpdate;   { prevent updates in WMSize message that follows WMCreate }
  try
    inherited CreateWnd;
  finally
    EndUpdate;
  end;
  UpdateRowCount;
  UpdateActive;
  UpdateScrollBar;
  FOriginalImeName := ImeName;
  FOriginalImeMode := ImeMode;
end;

procedure TCustomDBGridExt.DataChanged;
begin
  if not HandleAllocated then Exit;
  UpdateRowCount;
  UpdateScrollBar;
  UpdateActive;
  InvalidateEditor;
  ValidateRect(Handle, nil);
  Invalidate;
end;

procedure TCustomDBGridExt.DefaultHandler(var Msg);
var
  P: TPopupMenu;
  Cell: TGridCoord;
begin
  inherited DefaultHandler(Msg);
  if TMessage(Msg).Msg = wm_RButtonUp then
    with TWMRButtonUp(Msg) do
    begin
      Cell := MouseCoord(XPos, YPos);
      if (Cell.X < FIndicatorOffset) or (Cell.Y < 0) then Exit;
      P := Columns[RawToDataColumn(Cell.X)].PopupMenu;
      if (P <> nil) and P.AutoPopup then
      begin
        SendCancelMode(nil);
        P.PopupComponent := Self;
        with ClientToScreen(SmallPointToPoint(Pos)) do
          P.Popup(X, Y);
        Result := 1;
      end;
    end;
end;

procedure TCustomDBGridExt.DeferLayout;
var
  M: TMsg;
begin
  if HandleAllocated and
    not PeekMessage(M, Handle, cm_DeferLayout, cm_DeferLayout, pm_NoRemove) then
    PostMessage(Handle, cm_DeferLayout, 0, 0);
  CancelLayout;
end;

procedure TCustomDBGridExt.DefineFieldMap;
var
  I: Integer;
begin
  if FColumns.State = csCustomized then
  begin   { Build the column/field map from the column attributes }
    DataLink.SparseMap := True;
    for I := 0 to FColumns.Count-1 do
      FDataLink.AddMapping(FColumns[I].FieldName);
  end
  else   { Build the column/field map from the field list order }
  begin
    FDataLink.SparseMap := False;
    with Datalink.Dataset do
      for I := 0 to FieldList.Count - 1 do
        with FieldList[I] do if Visible then Datalink.AddMapping(FullName);
  end;
end;

function TCustomDBGridExt.UseRightToLeftAlignmentForField(const AField: TField;
  Alignment: TAlignment): Boolean;
begin
  Result := False;
  if IsRightToLeft then
    Result := OkToChangeFieldAlignment(AField, Alignment);
end;

procedure TCustomDBGridExt.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
var
  Alignment: TAlignment;
  Value: string;
begin
  Alignment := taLeftJustify;
  Value := '';
  if Assigned(Field) then
  begin
    Alignment := Field.Alignment;
    Value := Field.DisplayText;
  end;
  WriteText(Canvas, Rect, 2, 2, Value, Alignment,
    UseRightToLeftAlignmentForField(Field, Alignment));
end;

procedure TCustomDBGridExt.DefaultDrawColumnCell(const Rect: TRect;
  DataCol: Integer; Column: TColumnExt; State: TGridDrawState);
var
  Value: string;
begin
  Value := '';
  if Assigned(Column.Field) then
    Value := Column.Field.DisplayText;
  WriteText(Canvas, Rect, 2, 2, Value, Column.Alignment,
    UseRightToLeftAlignmentForField(Column.Field, Column.Alignment));
end;

procedure TCustomDBGridExt.ReadColumns(Reader: TReader);
begin
  Columns.Clear;
  Reader.ReadValue;
  Reader.ReadCollection(Columns);
end;

procedure TCustomDBGridExt.WriteColumns(Writer: TWriter);
begin
  Writer.WriteCollection(Columns);
end;

procedure TCustomDBGridExt.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('Columns', ReadColumns, WriteColumns,
    ((Columns.State = csCustomized) and (Filer.Ancestor = nil)) or
    ((Filer.Ancestor <> nil) and
     ((Columns.State <> TCustomDBGridExt(Filer.Ancestor).Columns.State) or
      (not CollectionsEqual(Columns, TCustomDBGridExt(Filer.Ancestor).Columns)) )));
end;

function TCustomDBGridExt.ColumnAtDepth(Col: TColumnExt; ADepth: Integer): TColumnExt;
begin
  Result := Col;
  while (Result <> nil) and (Result.Depth > ADepth) do
    Result := Result.ParentColumn;
end;

function TCustomDBGridExt.CalcTitleRect(Col: TColumnExt; ARow: Integer;
  var MasterCol: TColumnExt): TRect;
var
  I,J: Integer;
  InBiDiMode: Boolean;
  DrawInfo: TGridDrawInfo;
begin
  MasterCol := ColumnAtDepth(Col, ARow);
  if MasterCol = nil then Exit;

  I := DataToRawColumn(MasterCol.Index);
  if I >= LeftCol then
    J := MasterCol.Depth
  else
  begin
    I := LeftCol;
    if Col.Depth > ARow then
      J := ARow
    else
      J := Col.Depth;
  end;

  Result := CellRect(I, J);

  InBiDiMode := UseRightToLeftAlignment and
                (Canvas.CanvasOrientation = coLeftToRight);

  for I := Col.Index to Columns.Count-1 do
  begin
    if ColumnAtDepth(Columns[I], ARow) <> MasterCol then Break;
    if not InBiDiMode then
    begin
      J := CellRect(DataToRawColumn(I), ARow).Right;
      if J = 0 then Break;
      Result.Right := Max(Result.Right, J);
    end
    else
    begin
      J := CellRect(DataToRawColumn(I), ARow).Left;
      if J >= ClientWidth then Break;
      Result.Left := J;
    end;
  end;
  J := Col.Depth;
  if (J <= ARow) and (J < FixedRows-1) then
  begin
    CalcFixedInfo(DrawInfo);
    Result.Bottom := DrawInfo.Vert.FixedBoundary - DrawInfo.Vert.EffectiveLineWidth;
  end;
end;

procedure TCustomDBGridExt.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  FrameOffs: Byte;

  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

  procedure DrawTitleCell(ACol, ARow: Integer; Column: TColumnExt; var AState: TGridDrawState);
  const
    ScrollArrows: array [Boolean, Boolean] of Integer =
      ((DFCS_SCROLLRIGHT, DFCS_SCROLLLEFT), (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
  var
    MasterCol: TColumnExt;
    TitleRect, TextRect, ButtonRect: TRect;
    I: Integer;
    InBiDiMode: Boolean;
  begin
    TitleRect := CalcTitleRect(Column, ARow, MasterCol);

    if MasterCol = nil then
    begin
      Canvas.FillRect(ARect);
      Exit;
    end;

    Canvas.Font := MasterCol.Title.Font;
    Canvas.Brush.Color := MasterCol.Title.Color;
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
      InflateRect(TitleRect, -1, -1);
    TextRect := TitleRect;
    I := GetSystemMetrics(SM_CXHSCROLL);
    if ((TextRect.Right - TextRect.Left) > I) and MasterCol.Expandable then
    begin
      Dec(TextRect.Right, I);
      ButtonRect := TitleRect;
      ButtonRect.Left := TextRect.Right;
      I := SaveDC(Canvas.Handle);
      try
        Canvas.FillRect(ButtonRect);
        InflateRect(ButtonRect, -1, -1);
        IntersectClipRect(Canvas.Handle, ButtonRect.Left,
          ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom);
        InflateRect(ButtonRect, 1, 1);
        { DrawFrameControl doesn't draw properly when orienatation has changed.
          It draws as ExtTextOut does. }
        InBiDiMode := Canvas.CanvasOrientation = coRightToLeft;
        if InBiDiMode then { stretch the arrows box }
          Inc(ButtonRect.Right, GetSystemMetrics(SM_CXHSCROLL) + 4);
        DrawFrameControl(Canvas.Handle, ButtonRect, DFC_SCROLL,
          ScrollArrows[InBiDiMode, MasterCol.Expanded] or DFCS_FLAT);
      finally
        RestoreDC(Canvas.Handle, I);
      end;
    end;
    with MasterCol.Title do
      WriteText(Canvas, TextRect, FrameOffs, FrameOffs, Caption, Alignment,
        IsRightToLeft);
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
    begin
      InflateRect(TitleRect, 1, 1);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_TOPLEFT);
    end;
    AState := AState - [gdFixed];  // prevent box drawing later
  end;

var
  OldActive: Integer;
  Indicator: Integer;
  Highlight: Boolean;
  Value: string;
  DrawColumn: TColumnExt;
  MultiSelected: Boolean;
  ALeft: Integer;
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end
  else
    FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect(ARect);
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := FDataLink.ActiveRecord;
        try
          FDatalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          FDatalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = FDataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if FDataLink.DataSet <> nil then
          case FDataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> FDatalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        FIndicators.BkColor := FixedColor;
        ALeft := ARect.Right - FIndicators.Width - FrameOffs;
        if Canvas.CanvasOrientation = coRightToLeft then Inc(ALeft);
        FIndicators.Draw(Canvas, ALeft,
          (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator, True);
        if ARow = FDatalink.ActiveRecord then
          FSelRow := ARow + FTitleOffset;
      end;
    end;
  end
  else with Canvas do
  begin
    DrawColumn := Columns[ACol];
    if not DrawColumn.Showing then Exit;
    if not (gdFixed in AState) then
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color;
    end;
    if ARow < 0 then
      DrawTitleCell(ACol, ARow + FTitleOffset, DrawColumn, AState)
    else if (FDataLink = nil) or not FDataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := FDataLink.ActiveRecord;
      try
        FDataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if Highlight then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
        if FDefaultDrawing then
          WriteText(Canvas, ARect, 2, 2, Value, DrawColumn.Alignment,
            UseRightToLeftAlignmentForField(DrawColumn.Field, DrawColumn.Alignment));
        if Columns.State = csDefault then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        FDataLink.ActiveRecord := OldActive;
      end;
      if FDefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and (ValidParentForm(Self).ActiveControl = Self) then
        Windows.DrawFocusRect(Handle, ARect);
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, 1, 1);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
  end;
end;

procedure TCustomDBGridExt.DrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
begin
  if Assigned(FOnDrawDataCell) then FOnDrawDataCell(Self, Rect, Field, State);
end;

procedure TCustomDBGridExt.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumnExt; State: TGridDrawState);
begin
  if Assigned(OnDrawColumnCell) then
    OnDrawColumnCell(Self, Rect, DataCol, Column, State);
end;

procedure TCustomDBGridExt.EditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then
    FOnEditButtonClick(Self)
  else
    ShowPopupEditor(Columns[SelectedIndex]);
end;

procedure TCustomDBGridExt.EditingChanged;
begin
  if dgIndicator in Options then InvalidateCell(0, FSelRow);
end;

procedure TCustomDBGridExt.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
        if FLayoutLock = 1 then
          FColumns.EndUpdate;
      end;
    finally
      Dec(FLayoutLock);
      EndUpdate;
    end;
  end;
end;

procedure TCustomDBGridExt.EndUpdate;
begin
  if FUpdateLock > 0 then
    Dec(FUpdateLock);
end;

function TCustomDBGridExt.GetColField(DataCol: Integer): TField;
begin
  Result := nil;
  if (DataCol >= 0) and FDatalink.Active and (DataCol < Columns.Count) then
    Result := Columns[DataCol].Field;
end;

function TCustomDBGridExt.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomDBGridExt.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(SelectedField) and (SelectedField.DataType = ftString) then
    Result := SelectedField.Size;
end;

function TCustomDBGridExt.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
  if FDatalink.Active then
  with Columns[RawToDataColumn(ACol)] do
    if Assigned(Field) then
      Result := Field.EditMask;
end;

function TCustomDBGridExt.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
  if FDatalink.Active then
  with Columns[RawToDataColumn(ACol)] do
    if Assigned(Field) then
      Result := Field.Text;
  FEditText := Result;
end;

function TCustomDBGridExt.GetFieldCount: Integer;
begin
  Result := FDatalink.FieldCount;
end;

function TCustomDBGridExt.GetFields(FieldIndex: Integer): TField;
begin
  Result := FDatalink.Fields[FieldIndex];
end;

function TCustomDBGridExt.GetFieldValue(ACol: Integer): string;
var
  Field: TField;
begin
  Result := '';
  Field := GetColField(ACol);
  if Field <> nil then Result := Field.DisplayText;
end;

function TCustomDBGridExt.GetSelectedField: TField;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index <> -1 then
    Result := Columns[Index].Field
  else
    Result := nil;
end;

function TCustomDBGridExt.GetSelectedIndex: Integer;
begin
  Result := RawToDataColumn(Col);
end;

function TCustomDBGridExt.HighlightCell(DataCol, DataRow: Integer;
  const Value: string; AState: TGridDrawState): Boolean;
var
  Index: Integer;
begin
  Result := False;
  if (dgMultiSelect in Options) and Datalink.Active then
    Result := FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  if not Result then
    Result := (gdSelected in AState)
      and ((dgAlwaysShowSelection in Options) or Focused)
        { updatelock eliminates flicker when tabbing between rows }
      and ((UpdateLock = 0) or (dgRowSelect in Options));
end;

procedure TCustomDBGridExt.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;

  procedure ClearSelection;
  begin
    if (dgMultiSelect in Options) then
    begin
      FBookmarks.Clear;
      FSelecting := False;
    end;
  end;

  procedure DoSelection(Select: Boolean; Direction: Integer);
  var
    AddAfter: Boolean;
  begin
    AddAfter := False;
    BeginUpdate;
    try
      if (dgMultiSelect in Options) and FDatalink.Active then
        if Select and (ssShift in Shift) then
        begin
          if not FSelecting then
          begin
            FSelectionAnchor := FBookmarks.CurrentRow;
            FBookmarks.CurrentRowSelected := True;
            FSelecting := True;
            AddAfter := True;
          end
          else
          with FBookmarks do
          begin
            AddAfter := Compare(CurrentRow, FSelectionAnchor) <> -Direction;
            if not AddAfter then
              CurrentRowSelected := False;
          end
        end
        else
          ClearSelection;
      FDatalink.MoveBy(Direction);
      if AddAfter then FBookmarks.CurrentRowSelected := True;
    finally
      EndUpdate;
    end;
  end;

  procedure NextRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
        if FDataLink.EOF then Exit else Cancel
      else
        DoSelection(Select, 1);
      if FDataLink.EOF and CanModify and (not ReadOnly) and (dgEditing in Options) then
        Append;
    end;
  end;

  procedure PriorRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
      if (State = dsInsert) and not Modified and FDataLink.EOF and
        not FDatalink.FModified then
        Cancel
      else
        DoSelection(Select, -1);
  end;

  procedure Tab(GoForward: Boolean);
  var
    ACol, Original: Integer;
  begin
    ACol := Col;
    Original := ACol;
    BeginUpdate;    { Prevent highlight flicker on tab to next/prior row }
    try
      while True do
      begin
        if GoForward then
          Inc(ACol) else
          Dec(ACol);
        if ACol >= ColCount then
        begin
          NextRow(False);
          ACol := FIndicatorOffset;
        end
        else if ACol < FIndicatorOffset then
        begin
          PriorRow(False);
          ACol := ColCount - FIndicatorOffset;
        end;
        if ACol = Original then Exit;
        if TabStops[ACol] then
        begin
          MoveCol(ACol, 0);
          Exit;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;

  function DeletePrompt: Boolean;
  var
    Msg: string;
  begin
    if (FBookmarks.Count > 1) then
      Msg := SDeleteMultipleRecordsQuestion
    else
      Msg := SDeleteRecordQuestion;
    Result := not (dgConfirmDelete in Options) or
      (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

const
  RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END];

begin
  KeyDownEvent := OnKeyDown;
  if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
  if not FDatalink.Active or not CanGridAcceptKey(Key, Shift) then Exit;
  if (dgEnters in Options) and (Key = VK_RETURN) then  Key := VK_TAB;
  with FDatalink.DataSet do
    if ssCtrl in Shift then
    begin
      if (Key in RowMovementKeys) then ClearSelection;
      case Key of
        VK_UP, VK_PRIOR: FDataLink.MoveBy(-FDatalink.ActiveRecord);
        VK_DOWN, VK_NEXT: FDataLink.MoveBy(FDatalink.BufferCount - FDatalink.ActiveRecord - 1);
        VK_LEFT: MoveCol(FIndicatorOffset, 1);
        VK_RIGHT: MoveCol(ColCount - 1, -1);
        VK_HOME: First;
        VK_END: Last;
        VK_DELETE:
          if (not ReadOnly) and not IsEmpty
            and CanModify and DeletePrompt then
          if FBookmarks.Count > 0 then
            FBookmarks.Delete
          else
            Delete;
      end
    end
    else
      case Key of
        VK_UP: PriorRow(True);
        VK_DOWN: NextRow(True);
        VK_LEFT:
          if dgRowSelect in Options then
            PriorRow(False) else
            MoveCol(Col - 1, -1);
        VK_RIGHT:
          if dgRowSelect in Options then
            NextRow(False) else
            MoveCol(Col + 1, 1);
        VK_HOME:
          if (ColCount = FIndicatorOffset+1)
            or (dgRowSelect in Options) then
          begin
            ClearSelection;
            First;
          end
          else
            MoveCol(FIndicatorOffset, 1);
        VK_END:
          if (ColCount = FIndicatorOffset+1)
            or (dgRowSelect in Options) then
          begin
            ClearSelection;
            Last;
          end
          else
            MoveCol(ColCount - 1, -1);
        VK_NEXT:
          begin
            ClearSelection;
            FDataLink.MoveBy(VisibleRowCount);
          end;
        VK_PRIOR:
          begin
            ClearSelection;
            FDataLink.MoveBy(-VisibleRowCount);
          end;
        VK_INSERT:
          if CanModify and (not ReadOnly) and (dgEditing in Options) then
          begin
            ClearSelection;
            Insert;
          end;
        VK_TAB: if not (ssAlt in Shift) then Tab(not (ssShift in Shift));
        VK_ESCAPE:
          begin
            if SysLocale.PriLangID = LANG_KOREAN then
              FIsESCKey := True;
            FDatalink.Reset;
            ClearSelection;
            if not (dgAlwaysShowEditor in Options) then HideEditor;
          end;
        VK_F2: EditorMode := True;
      end;
end;

procedure TCustomDBGridExt.KeyPress(var Key: Char);
begin
  FIsESCKey := False;
  if (dgEnters in Options) and (Key = #13) then  Key := Char(VK_TAB);
  if not (dgAlwaysShowEditor in Options) and (Key = #13) then
    FDatalink.UpdateData;
  inherited KeyPress(Key);
end;

procedure TCustomDBGridExt.KeyUp(var Key: Word; Shift: TShiftState);
const
  NavigateKeys = [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_HOME, VK_END, VK_TAB, 
                  VK_ESCAPE];
var
  linelength: Integer;
begin
  inherited;
  if not (Assigned(SelectedField) and (SelectedField.DataType = ftString)) then Exit;
  if Key in NavigateKeys then Exit;
  if (Key = VK_RETURN) and (dgEnters in Options) then
  begin
    MoveToNextCol;
    Exit;
  end;
  // Handle normal keys only
  if (Shift = []) and (Key in [$20..$FF]) and Assigned(InplaceEditor) then
  begin
    linelength := SendMessage(InplaceEditor.Handle, EM_LINELENGTH, 0, 0);
    if linelength >= SelectedField.Size then 
      MoveToNextCol;
  end;
end;

procedure TCustomDBGridExt.MoveToNextCol;

  procedure ClearSelection;
  begin
    if (dgMultiSelect in Options) then
    begin
      FBookmarks.Clear;
      FSelecting := False;
    end;
  end;

  procedure DoSelection(Select: Boolean; Direction: Integer);
  var
    AddAfter: Boolean;
  begin
    AddAfter := False;
    BeginUpdate;
    try
      if (dgMultiSelect in Options) and FDatalink.Active then
        begin
          if not FSelecting then
          begin
            FSelectionAnchor := FBookmarks.CurrentRow;
            FBookmarks.CurrentRowSelected := True;
            FSelecting := True;
            AddAfter := True;
          end
          else
          with FBookmarks do
          begin
            AddAfter := Compare(CurrentRow, FSelectionAnchor) <> -Direction;
            if not AddAfter then
              CurrentRowSelected := False;
          end
        end
        else
          ClearSelection;
      FDatalink.MoveBy(Direction);
      if AddAfter then FBookmarks.CurrentRowSelected := True;
    finally
      EndUpdate;
    end;
  end;

  procedure NextRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
        if FDataLink.EOF then Exit else Cancel
      else
        DoSelection(Select, 1);
      if FDataLink.EOF and CanModify and (not ReadOnly) and (dgEditing in Options) then
        Append;
    end;
  end;

  procedure PriorRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
      if (State = dsInsert) and not Modified and FDataLink.EOF and
        not FDatalink.FModified then
        Cancel
      else
        DoSelection(Select, -1);
  end;

  procedure Tab(GoForward: Boolean);
  var
    ACol, Original: Integer;
  begin
    ACol := Col;
    Original := ACol;
    BeginUpdate;    { Prevent highlight flicker on tab to next/prior row }
    try
      while True do
      begin
        if GoForward then
          Inc(ACol) else
          Dec(ACol);
        if ACol >= ColCount then
        begin
          NextRow(False);
          ACol := FIndicatorOffset;
        end
        else if ACol < FIndicatorOffset then
        begin
          PriorRow(False);
          ACol := ColCount - FIndicatorOffset;
        end;
        if ACol = Original then Exit;
        if TabStops[ACol] then
        begin
          MoveCol(ACol, 0);
          Exit;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;

begin
  if not FDatalink.Active then Exit;
  Tab(True);
end;

{ InternalLayout is called with layout locks and column locks in effect }
procedure TCustomDBGridExt.InternalLayout;

  function FieldIsMapped(F: TField): Boolean;
  var
    X: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for X := 0 to FDatalink.FieldCount-1 do
      if FDatalink.Fields[X] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

  procedure CheckForPassthroughs;  // check for Columns.State flip-flop
  var
    SeenPassthrough: Boolean;
    I, J: Integer;
    Column: TColumnExt;
  begin
    SeenPassthrough := False;
    for I := 0 to FColumns.Count-1 do
      if not FColumns[I].IsStored then
        SeenPassthrough := True
      else if SeenPassthrough then
      begin  // we have both persistent and non-persistent columns.  Kill the latter
        for J := FColumns.Count-1 downto 0 do
        begin
          Column := FColumns[J];
          if not Column.IsStored then
            Column.Free;
        end;
        Exit;
      end;
  end;

  procedure ResetColumnFieldBindings;
  var
    I, J, K: Integer;
    Fld: TField;
    Column: TColumnExt;
  begin
    if FColumns.State = csDefault then
    begin
       { Destroy columns whose fields have been destroyed or are no longer
         in field map }
      if (not FDataLink.Active) and (FDatalink.DefaultFields) then
        FColumns.Clear
      else
        for J := FColumns.Count-1 downto 0 do
          with FColumns[J] do
          if not Assigned(Field)
            or not FieldIsMapped(Field) then Free;
      I := FDataLink.FieldCount;
      if (I = 0) and (FColumns.Count = 0) then Inc(I);
      for J := 0 to I-1 do
      begin
        Fld := FDatalink.Fields[J];
        if Assigned(Fld) then
        begin
          K := J;
           { Pointer compare is valid here because the grid sets matching
             column.field properties to nil in response to field object
             free notifications.  Closing a dataset that has only default
             field objects will destroy all the fields and set associated
             column.field props to nil. }
          while (K < FColumns.Count) and (FColumns[K].Field <> Fld) do
            Inc(K);
          if K < FColumns.Count then
            Column := FColumns[K]
          else
          begin
            Column := FColumns.InternalAdd;
            Column.Field := Fld;
          end;
        end
        else
          Column := FColumns.InternalAdd;
        Column.Index := J;
      end;
    end
    else
    begin
      { Force columns to reaquire fields (in case dataset has changed) }
      for I := 0 to FColumns.Count-1 do
        FColumns[I].Field := nil;
    end;
  end;

  procedure MeasureTitleHeights;
  var
    I, J, K, D, B: Integer;
    RestoreCanvas: Boolean;
    Heights: array of Integer;
  begin
    RestoreCanvas := not HandleAllocated;
    if RestoreCanvas then
      Canvas.Handle := GetDC(0);
    try
      Canvas.Font := Font;
      K := Canvas.TextHeight('Wg') + 3;
      if dgRowLines in Options then
        Inc(K, GridLineWidth);
      DefaultRowHeight := K;
      B := GetSystemMetrics(SM_CYHSCROLL);
      if dgTitles in Options then
      begin
        SetLength(Heights, FTitleOffset+1);
        for I := 0 to FColumns.Count-1 do
        begin
          Canvas.Font := FColumns[I].Title.Font;
          D := FColumns[I].Depth;
          if D <= High(Heights) then
          begin
            J := Canvas.TextHeight('Wg') + 4;
            if FColumns[I].Expandable and (B > J) then
              J := B;
            Heights[D] := Max(J, Heights[D]);
          end;
        end;
        if Heights[0] = 0 then
        begin
          Canvas.Font := FTitleFont;
          Heights[0] := Canvas.TextHeight('Wg') + 4;
        end;
        for I := 0 to High(Heights)-1 do
          RowHeights[I] := Heights[I];
      end;
    finally
      if RestoreCanvas then
      begin
        ReleaseDC(0,Canvas.Handle);
        Canvas.Handle := 0;
      end;
    end;
  end;

var
  I, J: Integer;
begin
  if (csLoading in ComponentState) then Exit;

  if HandleAllocated then KillMessage(Handle, cm_DeferLayout);

  CheckForPassthroughs;
  FIndicatorOffset := 0;
  if dgIndicator in Options then
    Inc(FIndicatorOffset);
  FDatalink.ClearMapping;
  if FDatalink.Active then DefineFieldMap;
  DoubleBuffered := (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView;
  ResetColumnFieldBindings;
  FVisibleColumns.Clear;
  for I := 0 to FColumns.Count-1 do
    if FColumns[I].Showing then FVisibleColumns.Add(FColumns[I]);
  ColCount := FColumns.Count + FIndicatorOffset;
  inherited FixedCols := FIndicatorOffset;
  FTitleOffset := 0;
  if dgTitles in Options then
  begin
    FTitleOffset := 1;
    if (FDatalink <> nil) and (FDatalink.Dataset <> nil)
      and FDatalink.Dataset.ObjectView then
    begin
      for I := 0 to FColumns.Count-1 do
      begin
        if FColumns[I].Showing then
        begin
          J := FColumns[I].Depth;
          if J >= FTitleOffset then FTitleOffset := J+1;
        end;
      end;
    end;
  end;
  UpdateRowCount;
  MeasureTitleHeights;
  SetColumnAttributes;
  UpdateActive;
  Invalidate;
end;

procedure TCustomDBGridExt.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

procedure TCustomDBGridExt.LinkActive(Value: Boolean);
var
  Comp: TComponent;
  I: Integer;
begin
  if not Value then HideEditor;
  FBookmarks.LinkActive(Value);
  try
    LayoutChanged;
  finally
    for I := ComponentCount-1 downto 0 do
    begin
      Comp := Components[I];   // Free all the popped-up subgrids
      if (Comp is TCustomDBGridExt)
        and (TCustomDBGridExt(Comp).DragKind = dkDock) then
        Comp.Free;
    end;
    UpdateScrollBar;
    if Value and (dgAlwaysShowEditor in Options) then ShowEditor;
  end;
end;

procedure TCustomDBGridExt.Loaded;
begin
  inherited Loaded;
  if FColumns.Count > 0 then
    ColCount := FColumns.Count;
  LayoutChanged;
end;

function TCustomDBGridExt.PtInExpandButton(X,Y: Integer; var MasterCol: TColumnExt): Boolean;
var
  Cell: TGridCoord;
  R: TRect;
begin
  MasterCol := nil;
  Result := False;
  Cell := MouseCoord(X,Y);
  if (Cell.Y < FTitleOffset) and FDatalink.Active
    and (Cell.X >= FIndicatorOffset)
    and (RawToDataColumn(Cell.X) < Columns.Count) then
  begin
    R := CalcTitleRect(Columns[RawToDataColumn(Cell.X)], Cell.Y, MasterCol);
    if not UseRightToLeftAlignment then
      R.Left := R.Right - GetSystemMetrics(SM_CXHSCROLL)
    else
      R.Right := R.Left + GetSystemMetrics(SM_CXHSCROLL);
    Result := MasterCol.Expandable and PtInRect(R, Point(X,Y));
  end;
end;

procedure TCustomDBGridExt.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  OldCol,OldRow: Integer;
  MasterCol: TColumnExt;
begin
  if not AcquireFocus then Exit;
  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    DblClick;
    Exit;
  end;

  if Sizing(X, Y) then
  begin
    FDatalink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  Cell := MouseCoord(X, Y);
  if (Cell.X < 0) and (Cell.Y < 0) then
  begin
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  if (DragKind = dkDock) and (Cell.X < FIndicatorOffset) and
    (Cell.Y < FTitleOffset) and (not (csDesigning in ComponentState)) then
  begin
    BeginDrag(false);
    Exit;
  end;

  if PtInExpandButton(X,Y, MasterCol) then
  begin
    MasterCol.Expanded := not MasterCol.Expanded;
    ReleaseCapture;
    UpdateDesigner;
    Exit;
  end;

  if ((csDesigning in ComponentState) or (dgColumnResize in Options)) and
    (Cell.Y < FTitleOffset) then
  begin
    FDataLink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  if FDatalink.Active then
    with Cell do
    begin
      BeginUpdate;   { eliminates highlight flicker when selection moves }
      try
        FDatalink.UpdateData; // validate before moving
        HideEditor;
        OldCol := Col;
        OldRow := Row;
        if (Y >= FTitleOffset) and (Y - Row <> 0) then
          FDatalink.MoveBy(Y - Row);
        if X >= FIndicatorOffset then
          MoveCol(X, 0);
        if (dgMultiSelect in Options) and FDatalink.Active then
          with FBookmarks do
          begin
            FSelecting := False;
            if ssCtrl in Shift then
              CurrentRowSelected := not CurrentRowSelected
            else
            begin
              Clear;
              CurrentRowSelected := True;
            end;
          end;
        if (Button = mbLeft) and
          (((X = OldCol) and (Y = OldRow)) or (dgAlwaysShowEditor in Options)) then
          ShowEditor         { put grid in edit mode }
        else
          InvalidateEditor;  { draw editor, if needed }
      finally
        EndUpdate;
      end;
    end;
end;

procedure TCustomDBGridExt.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  SaveState: TGridState;
begin
  SaveState := FGridState;
  inherited MouseUp(Button, Shift, X, Y);
  if (SaveState = gsRowSizing) or (SaveState = gsColSizing) or
    ((InplaceEditor <> nil) and (InplaceEditor.Visible) and
     (PtInRect(InplaceEditor.BoundsRect, Point(X,Y)))) then Exit;
  Cell := MouseCoord(X,Y);
  if (Button = mbLeft) and (Cell.X >= FIndicatorOffset) and (Cell.Y >= 0) then
    if Cell.Y < FTitleOffset then
      TitleClick(Columns[RawToDataColumn(Cell.X)])
    else
      CellClick(Columns[SelectedIndex]);
end;

procedure TCustomDBGridExt.MoveCol(RawCol, Direction: Integer);
var
  OldCol: Integer;
begin
  FDatalink.UpdateData;
  if RawCol >= ColCount then
    RawCol := ColCount - 1;
  if RawCol < FIndicatorOffset then RawCol := FIndicatorOffset;
  if Direction <> 0 then
  begin
    while (RawCol < ColCount) and (RawCol >= FIndicatorOffset) and
      (ColWidths[RawCol] <= 0) do
      Inc(RawCol, Direction);
    if (RawCol >= ColCount) or (RawCol < FIndicatorOffset) then Exit;
  end;
  OldCol := Col;
  if RawCol <> OldCol then
  begin
    if not FInColExit then
    begin
      FInColExit := True;
      try
        ColExit;
      finally
        FInColExit := False;
      end;
      if Col <> OldCol then Exit;
    end;
    if not (dgAlwaysShowEditor in Options) then HideEditor;
    Col := RawCol;
    ColEnter;
  end;
end;

procedure TCustomDBGridExt.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
  NeedLayout: Boolean;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TPopupMenu) then
    begin
      for I := 0 to Columns.Count-1 do
        if Columns[I].PopupMenu = AComponent then
          Columns[I].PopupMenu := nil;
    end
    else if (FDataLink <> nil) then
      if (AComponent = DataSource)  then
        DataSource := nil
      else if (AComponent is TField) then
      begin
        NeedLayout := False;
        BeginLayout;
        try
          for I := 0 to Columns.Count-1 do
            with Columns[I] do
              if Field = AComponent then
              begin
                Field := nil;
                NeedLayout := True;
              end;
        finally
          if NeedLayout and Assigned(FDatalink.Dataset)
            and not FDatalink.Dataset.ControlsDisabled then
            EndLayout
          else
            DeferLayout;
        end;
      end;
  end;
end;

procedure TCustomDBGridExt.RecordChanged(Field: TField);
var
  I: Integer;
  CField: TField;
begin
  if not HandleAllocated then Exit;
  if Field = nil then
    Invalidate
  else
  begin
    for I := 0 to Columns.Count - 1 do
      if Columns[I].Field = Field then
        InvalidateCol(DataToRawColumn(I));
  end;
  CField := SelectedField;
  if ((Field = nil) or (CField = Field)) and
    (Assigned(CField) and (CField.Text <> FEditText) and
    ((SysLocale.PriLangID <> LANG_KOREAN) or FIsESCKey)) then
  begin
    InvalidateEditor;
    if InplaceEditor <> nil then InplaceEditor.Deselect;
  end;
end;

procedure TCustomDBGridExt.Scroll(Distance: Integer);
var
  OldRect, NewRect: TRect;
  RowHeight: Integer;
begin
  if not HandleAllocated then Exit;
  OldRect := BoxRect(0, Row, ColCount - 1, Row);
  if (FDataLink.ActiveRecord >= RowCount - FTitleOffset) then UpdateRowCount;
  UpdateScrollBar;
  UpdateActive;
  NewRect := BoxRect(0, Row, ColCount - 1, Row);
  ValidateRect(Handle, @OldRect);
  InvalidateRect(Handle, @OldRect, False);
  InvalidateRect(Handle, @NewRect, False);
  if Distance <> 0 then
  begin
    HideEditor;
    try
      if Abs(Distance) > VisibleRowCount then
      begin
        Invalidate;
        Exit;
      end
      else
      begin
        RowHeight := DefaultRowHeight;
        if dgRowLines in Options then Inc(RowHeight, GridLineWidth);
        if dgIndicator in Options then
        begin
          OldRect := BoxRect(0, FSelRow, ColCount - 1, FSelRow);
          InvalidateRect(Handle, @OldRect, False);
        end;
        NewRect := BoxRect(0, FTitleOffset, ColCount - 1, 1000);
        ScrollWindowEx(Handle, 0, -RowHeight * Distance, @NewRect, @NewRect,
          0, nil, SW_Invalidate);
        if dgIndicator in Options then
        begin
          NewRect := BoxRect(0, Row, ColCount - 1, Row);
          InvalidateRect(Handle, @NewRect, False);
        end;
      end;
    finally
      if dgAlwaysShowEditor in Options then ShowEditor;
    end;
  end;
  if UpdateLock = 0 then Update;
end;

procedure TCustomDBGridExt.SetColumns(Value: TDBGridColumnsExt);
begin
  Columns.Assign(Value);
end;

function ReadOnlyField(Field: TField): Boolean;
var
  MasterField: TField;
begin
  Result := Field.ReadOnly;
  if not Result and (Field.FieldKind = fkLookup) then
  begin
    Result := True;
    if Field.DataSet = nil then Exit;
    MasterField := Field.Dataset.FindField(Field.KeyFields);
    if MasterField = nil then Exit;
    Result := MasterField.ReadOnly;
  end;
end;

procedure TCustomDBGridExt.SetColumnAttributes;
var
  I: Integer;
begin
  for I := 0 to FColumns.Count-1 do
  with FColumns[I] do
  begin
    TabStops[I + FIndicatorOffset] := Showing and not ReadOnly and DataLink.Active and
      Assigned(Field) and not (Field.FieldKind = fkCalculated) and not ReadOnlyField(Field);
    ColWidths[I + FIndicatorOffset] := Width;
  end;
  if (dgIndicator in Options) then
    ColWidths[0] := IndicatorWidth;
end;

procedure TCustomDBGridExt.SetDataSource(Value: TDataSource);
begin
  if Value = FDatalink.Datasource then Exit;
  FBookmarks.Clear;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  LinkActive(FDataLink.Active);
end;

procedure TCustomDBGridExt.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  FEditText := Value;
end;

procedure TCustomDBGridExt.SetOptions(Value: TDBGridOptionsExt);
const
  LayoutOptions = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TDBGridOptionsExt;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [];
    if dgColLines in Value then
      NewGridOptions := NewGridOptions + [goFixedVertLine, goVertLine];
    if dgRowLines in Value then
      NewGridOptions := NewGridOptions + [goFixedHorzLine, goHorzLine];
    if dgColumnResize in Value then
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
    if dgTabs in Value then Include(NewGridOptions, goTabs);
    if dgRowSelect in Value then
    begin
      Include(NewGridOptions, goRowSelect);
      Exclude(Value, dgAlwaysShowEditor);
      Exclude(Value, dgEditing);
    end;
    if dgEditing in Value then Include(NewGridOptions, goEditing);
    if dgAlwaysShowEditor in Value then Include(NewGridOptions, goAlwaysShowEditor);
    inherited Options := NewGridOptions;
    if dgMultiSelect in (FOptions - Value) then FBookmarks.Clear;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    FOptions := Value;
    if ChangedOptions * LayoutOptions <> [] then LayoutChanged;
  end;
end;

procedure TCustomDBGridExt.SetSelectedField(Value: TField);
var
  I: Integer;
begin
  if Value = nil then Exit;
  for I := 0 to Columns.Count - 1 do
    if Columns[I].Field = Value then
      MoveCol(DataToRawColumn(I), 0);
end;

procedure TCustomDBGridExt.SetSelectedIndex(Value: Integer);
begin
  MoveCol(DataToRawColumn(Value), 0);
end;

procedure TCustomDBGridExt.SetTitleFont(Value: TFont);
begin
  FTitleFont.Assign(Value);
  if dgTitles in Options then LayoutChanged;
end;

function TCustomDBGridExt.StoreColumns: Boolean;
begin
  Result := Columns.State = csCustomized;
end;

procedure TCustomDBGridExt.TimedScroll(Direction: TGridScrollDirection);
begin
  if FDatalink.Active then
  begin
    with FDatalink do
    begin
      if sdUp in Direction then
      begin
        FDataLink.MoveBy(-ActiveRecord - 1);
        Exclude(Direction, sdUp);
      end;
      if sdDown in Direction then
      begin
        FDataLink.MoveBy(RecordCount - ActiveRecord);
        Exclude(Direction, sdDown);
      end;
    end;
    if Direction <> [] then inherited TimedScroll(Direction);
  end;
end;

procedure TCustomDBGridExt.TitleClick(Column: TColumnExt);
begin
  if Assigned(FOnTitleClick) then FOnTitleClick(Column);
end;

procedure TCustomDBGridExt.TitleFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  if dgTitles in Options then LayoutChanged;
end;

procedure TCustomDBGridExt.UpdateActive;
var
  NewRow: Integer;
  Field: TField;
begin
  if FDatalink.Active and HandleAllocated and not (csLoading in ComponentState) then
  begin
    NewRow := FDatalink.ActiveRecord + FTitleOffset;
    if Row <> NewRow then
    begin
      if not (dgAlwaysShowEditor in Options) then HideEditor;
      MoveColRow(Col, NewRow, False, False);
      InvalidateEditor;
    end;
    Field := SelectedField;
    if Assigned(Field) and (Field.Text <> FEditText) then
      InvalidateEditor;
  end;
end;

procedure TCustomDBGridExt.UpdateData;
var
  Field: TField;
begin
  Field := SelectedField;
  if Assigned(Field) then
    Field.Text := FEditText;
end;

procedure TCustomDBGridExt.UpdateRowCount;
var
  OldRowCount: Integer;
begin
  OldRowCount := RowCount;
  if RowCount <= FTitleOffset then RowCount := FTitleOffset + 1;
  FixedRows := FTitleOffset;
  with FDataLink do
    if not Active or (RecordCount = 0) or not HandleAllocated then
      RowCount := 1 + FTitleOffset
    else
    begin
      RowCount := 1000;
      FDataLink.BufferCount := VisibleRowCount;
      RowCount := RecordCount + FTitleOffset;
      if dgRowSelect in Options then TopRow := FixedRows;
      UpdateActive;
    end;
  if OldRowCount <> RowCount then Invalidate;
end;

procedure TCustomDBGridExt.UpdateScrollBar;
var
  SIOld, SINew: TScrollInfo;
begin
  if FDatalink.Active and HandleAllocated then
    with FDatalink.DataSet do
    begin
      SIOld.cbSize := sizeof(SIOld);
      SIOld.fMask := SIF_ALL;
      GetScrollInfo(Self.Handle, SB_VERT, SIOld);
      SINew := SIOld;
      if IsSequenced then
      begin
        SINew.nMin := 1;
        SINew.nPage := Self.VisibleRowCount;
        SINew.nMax := Integer(DWORD(RecordCount) + SINew.nPage - 1);
        if State in [dsInactive, dsBrowse, dsEdit] then
          SINew.nPos := RecNo;  // else keep old pos
      end
      else
      begin
        SINew.nMin := 0;
        SINew.nPage := 0;
        SINew.nMax := 4;
        if FDataLink.BOF then SINew.nPos := 0
        else if FDataLink.EOF then SINew.nPos := 4
        else SINew.nPos := 2;
      end;
      if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
        (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
        SetScrollInfo(Self.Handle, SB_VERT, SINew, True);
    end;
end;

function TCustomDBGridExt.ValidFieldIndex(FieldIndex: Integer): Boolean;
begin
  Result := DataLink.GetMappedIndex(FieldIndex) >= 0;
end;

procedure TCustomDBGridExt.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      TitleFont := Font;
    finally
      FSelfChangingTitleFont := False;
    end;
    LayoutChanged;
  end;
end;

procedure TCustomDBGridExt.CMBiDiModeChanged(var Message: TMessage);
var
  Loop: Integer;
begin
  inherited;
  for Loop := 0 to ComponentCount - 1 do
    if Components[Loop] is TCustomDBGridExt then
      with Components[Loop] as TCustomDBGridExt do
        { Changing the window, echos down to the subgrid }
        if Parent <> nil then
          Parent.BiDiMode := Self.BiDiMode;
end;

procedure TCustomDBGridExt.CMExit(var Message: TMessage);
begin
  try
    if FDatalink.Active then
      with FDatalink.Dataset do
        if (dgCancelOnExit in Options) and (State = dsInsert) and
          not Modified and not FDatalink.FModified then
          Cancel else
          FDataLink.UpdateData;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TCustomDBGridExt.CMFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  BeginLayout;
  try
    for I := 0 to Columns.Count-1 do
      Columns[I].RefreshDefaultFont;
  finally
    EndLayout;
  end;
end;

procedure TCustomDBGridExt.CMDeferLayout(var Message);
begin
  if AcquireLayoutLock then
    EndLayout
  else
    DeferLayout;
end;

procedure TCustomDBGridExt.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  MasterCol: TColumnExt;
begin
  inherited;
  if (Msg.Result = 1) and ((FDataLink = nil) or
    ((Columns.State = csDefault) and
     (FDataLink.DefaultFields or (not FDataLink.Active)))) then
    Msg.Result := 0
  else if (Msg.Result = 0) and (FDataLink <> nil) and (FDataLink.Active)
    and (Columns.State = csCustomized)
    and PtInExpandButton(Msg.XPos, Msg.YPos, MasterCol) then
    Msg.Result := 1;
end;

procedure TCustomDBGridExt.WMSetCursor(var Msg: TWMSetCursor);
begin
  if ((csDesigning in ComponentState) and
      ((FDataLink = nil) or
       ((Columns.State = csDefault) and
        (FDataLink.DefaultFields or not FDataLink.Active)
       )
      ) or
      ((Msg.HitTest = HTCLIENT) and not Sizing(HitTest.X, HitTest.Y))) then
    Windows.SetCursor(LoadCursor(0, IDC_ARROW))
  else inherited;
end;

procedure TCustomDBGridExt.WMSize(var Message: TWMSize);
begin
  inherited;
  if UpdateLock = 0 then UpdateRowCount;
  InvalidateTitles;
end;

procedure TCustomDBGridExt.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
begin
  if not AcquireFocus then Exit;
  if FDatalink.Active then
    with Message, FDataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: FDataLink.MoveBy(-FDatalink.ActiveRecord - 1);
        SB_LINEDOWN: FDataLink.MoveBy(FDatalink.RecordCount - FDatalink.ActiveRecord);
        SB_PAGEUP: FDataLink.MoveBy(-VisibleRowCount);
        SB_PAGEDOWN: FDataLink.MoveBy(VisibleRowCount);
        SB_THUMBPOSITION:
          begin
            if IsSequenced then
            begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(Self.Handle, SB_VERT, SI);
              if SI.nTrackPos <= 1 then First
              else if SI.nTrackPos >= RecordCount then Last
              else RecNo := SI.nTrackPos;
            end
            else
              case Pos of
                0: First;
                1: FDataLink.MoveBy(-VisibleRowCount);
                2: Exit;
                3: FDataLink.MoveBy(VisibleRowCount);
                4: Last;
              end;
          end;
        SB_BOTTOM: Last;
        SB_TOP: First;
      end;
end;

procedure TCustomDBGridExt.SetIme;
var
  Column: TColumnExt;
begin
  if not SysLocale.FarEast then Exit;

  ImeName := FOriginalImeName;
  ImeMode := FOriginalImeMode;
  Column := Columns[SelectedIndex];
  if Column.IsImeNameStored then ImeName := Column.ImeName;
  if Column.IsImeModeStored then ImeMode := Column.ImeMode;

  if InplaceEditor <> nil then
  begin
    TDBGridInplaceEdit(Self).ImeName := ImeName;
    TDBGridInplaceEdit(Self).ImeMode := ImeMode;
  end;
end;

procedure TCustomDBGridExt.UpdateIme;
begin
  if not SysLocale.FarEast then Exit;
  SetIme;
  SetImeName(ImeName);
  SetImeMode(Handle, ImeMode);
end;

procedure TCustomDBGridExt.WMIMEStartComp(var Message: TMessage);
begin
  inherited;
  ShowEditor;
end;

procedure TCustomDBGridExt.WMSetFocus(var Message: TWMSetFocus);
begin
  if not ((InplaceEditor <> nil) and
    (Message.FocusedWnd = InplaceEditor.Handle)) then SetIme;
  inherited;
end;

procedure TCustomDBGridExt.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if not ((InplaceEditor <> nil) and
      (HWND(Message.WParam) = InplaceEditor.Handle)) then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
end;

{ Defer action processing to datalink }

function TCustomDBGridExt.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.ExecuteAction(Action);
end;

function TCustomDBGridExt.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.UpdateAction(Action);
end;

procedure TCustomDBGridExt.ShowPopupEditor(Column: TColumnExt; X, Y: Integer);
var
  SubGrid: TCustomDBGridExt;
  DS: TDataSource;
  I: Integer;
  FloatRect: TRect;
  Cmp: TControl;
begin
  if not ((Column.Field <> nil) and (Column.Field is TDataSetField)) then  Exit;

  // find existing popup for this column field, if any, and show it
  for I := 0 to ComponentCount-1 do
    if Components[I] is TCustomDBGridExt then
    begin
      SubGrid := TCustomDBGridExt(Components[I]);
      if (SubGrid.DataSource <> nil) and
        (SubGrid.DataSource.DataSet = (Column.Field as TDatasetField).NestedDataset) then
      begin
        SubGrid.Parent.Show;
        SubGrid.SetFocus;
        Exit;
      end;
    end;

  // create another instance of this kind of grid
  SubGrid := TCustomDBGridExt(TComponentClass(Self.ClassType).Create(Self));
  try
    DS := TDataSource.Create(SubGrid); // incestuous, but easy cleanup
    DS.Dataset := (Column.Field as TDatasetField).NestedDataset;
    SubGrid.DataSource := DS;
    SubGrid.Columns.State := Columns.State;
    SubGrid.Columns[0].Expanded := True;
    SubGrid.Visible := False;
    SubGrid.FloatingDockSiteClass := TCustomDockForm;
    FloatRect.TopLeft := ClientToScreen(CellRect(Col, Row).BottomRight);
    if X > Low(Integer) then FloatRect.Left := X;
    if Y > Low(Integer) then FloatRect.Top := Y;
    FloatRect.Right := FloatRect.Left + Width;
    FloatRect.Bottom := FloatRect.Top + Height;
    SubGrid.ManualFloat(FloatRect);
//    SubGrid.ManualDock(nil,nil,alClient);
    SubGrid.Parent.BiDiMode := Self.BiDiMode; { This carries the BiDi setting }
    I := SubGrid.CellRect(SubGrid.ColCount-1, 0).Right;
    if (I > 0) and (I < Screen.Width div 2) then
      SubGrid.Parent.ClientWidth := I
    else
      SubGrid.Parent.Width := Screen.Width div 4;
    SubGrid.Parent.Height := Screen.Height div 4;
    SubGrid.Align := alClient;
    SubGrid.DragKind := dkDock;
    SubGrid.Color := Color;
    SubGrid.Ctl3D := Ctl3D;
    SubGrid.Cursor := Cursor;
    SubGrid.Enabled := Enabled;
    SubGrid.FixedColor := FixedColor;
    SubGrid.Font := Font;
    SubGrid.HelpContext := HelpContext;
    SubGrid.IMEMode := IMEMode;
    SubGrid.IMEName := IMEName;
    SubGrid.Options := Options;
    Cmp := Self;
    while (Cmp <> nil) and (TCustomDBGridExt(Cmp).PopupMenu = nil) do
      Cmp := Cmp.Parent;
    if Cmp <> nil then
      SubGrid.PopupMenu := TCustomDBGridExt(Cmp).PopupMenu;
    SubGrid.TitleFont := TitleFont;
    SubGrid.Visible := True;
    SubGrid.Parent.Show;
  except
    SubGrid.Free;
    raise;
  end;
end;

procedure TCustomDBGridExt.CalcSizingState(X, Y: Integer;
  var State: TGridState; var Index, SizingPos, SizingOfs: Integer;
  var FixedInfo: TGridDrawInfo);
var
  R: TGridCoord;
begin
  inherited CalcSizingState(X, Y, State, Index, SizingPos, SizingOfs, FixedInfo);
  if (State = gsColSizing) and (FDataLink <> nil)
    and (FDatalink.Dataset <> nil) and FDataLink.Dataset.ObjectView then
  begin
    R := MouseCoord(X, Y);
    R.X := RawToDataColumn(R.X);
    if (R.X >= 0) and (R.X < Columns.Count) and (Columns[R.X].Depth > R.Y) then
      State := gsNormal;
  end;
end;

function TCustomDBGridExt.CheckColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  I, ARow: Integer;
  DestCol: TColumnExt;
begin
  Result := inherited CheckColumnDrag(Origin, Destination, MousePt);
  if Result and (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    assert(FDragCol <> nil);
    ARow := FDragCol.Depth;
    if Destination <> Origin then
    begin
      DestCol := ColumnAtDepth(Columns[RawToDataColumn(Destination)], ARow);
      if DestCol.ParentColumn <> FDragCol.ParentColumn then
        if Destination < Origin then
          DestCol := Columns[FDragCol.ParentColumn.Index+1]
        else
        begin
          I := DestCol.Index;
          while DestCol.ParentColumn <> FDragCol.ParentColumn do
          begin
            Dec(I);
            DestCol := Columns[I];
          end;
        end;
      if (DestCol.Index > FDragCol.Index) then
      begin
        I := DestCol.Index + 1;
        while (I < Columns.Count) and (ColumnAtDepth(Columns[I],ARow) = DestCol) do
          Inc(I);
        DestCol := Columns[I-1];
      end;
      Destination := DataToRawColumn(DestCol.Index);
    end;
  end;
end;

function TCustomDBGridExt.BeginColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  I, ARow: Integer;
begin
  Result := inherited BeginColumnDrag(Origin, Destination, MousePt);
  if Result and (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    ARow := MouseCoord(MousePt.X, MousePt.Y).Y;
    FDragCol := ColumnAtDepth(Columns[RawToDataColumn(Origin)], ARow);
    if FDragCol = nil then Exit;
    I := DataToRawColumn(FDragCol.Index);
    if Origin <> I then Origin := I;
    Destination := Origin;
  end;
end;

function TCustomDBGridExt.EndColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  Result := inherited EndColumnDrag(Origin, Destination, MousePt);
  FDragCol := nil;
end;

procedure TCustomDBGridExt.InvalidateTitles;
var
  R: TRect;
  DrawInfo: TGridDrawInfo;
begin
  if HandleAllocated and (dgTitles in Options) and (FDatalink <> nil) and
    (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    CalcFixedInfo(DrawInfo);
    R := Rect(0, 0, Width, DrawInfo.Vert.FixedBoundary);
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TCustomDBGridExt.TopLeftChanged;
begin
  InvalidateTitles;
  inherited TopLeftChanged;
end;

end.
