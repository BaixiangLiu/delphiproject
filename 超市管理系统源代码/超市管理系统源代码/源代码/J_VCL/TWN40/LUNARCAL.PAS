unit LunarCal;

interface

uses Classes, Controls, Messages, Windows, Forms, Graphics, StdCtrls,
  Grids, SysUtils;

type
  TDayOfWeek = 0..6;

  TLunarCal = class(TCustomGrid)
  private
    FDate: TDateTime;
    FLunarYear: Integer;
    FHintDate: THintWindow;
    FMonthOffset: Integer;
    FOnChange: TNotifyEvent;
    FReadOnly: Boolean;
    FStartOfWeek: TDayOfWeek;
    FShowGregDate: Boolean;
    FShowNavigator: Boolean;
    FUpdating: Boolean;    
    FUseCurrentDate: Boolean;
    function GetCellText(ACol, ARow: Integer): string;
    function GetDateElement(Index: Integer): Integer;
    function GetGregYear(GYear, LYear: Word; LMonth: SmallInt): Word;
    procedure SetCalendarDate(Value: TDateTime);
    procedure SetDateElement(Index: Integer; Value: Integer);
    procedure SetShowNavigator(Value: Boolean);
    procedure SetStartOfWeek(Value: TDayOfWeek);
    procedure SetUseCurrentDate(Value: Boolean);
    function StoreCalendarDate: Boolean;
  protected
    procedure Change; dynamic;
    procedure ChangeMonth(Delta: Integer);
    procedure Click; override;
    function DaysPerLunarMonth(GYear, LYear, AMonth: Integer): Integer; virtual;
    function LunarDaysThisMonth: Integer; virtual;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CalendarDate: TDateTime  read FDate write SetCalendarDate stored StoreCalendarDate;
    property CellText[ACol, ARow: Integer]: string read GetCellText;
    property LunarYear: Integer read FLunarYear;
    procedure NextMonth;
    procedure NextYear;
    procedure PrevMonth;
    procedure PrevYear;
    procedure UpdateCalendar; virtual;
  published
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GridLineWidth default 0;
    property LunarDay: Integer index 3  read GetDateElement write SetDateElement stored False;
    property LunarMonth: Integer index 2  read GetDateElement write SetDateElement stored False;
    property GregYear: Integer index 1  read GetDateElement write SetDateElement stored False;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ShowHint;
    property ShowGregDate: Boolean read FShowGregDate write FShowGregDate default True;
    property ShowNavigator: Boolean read FShowNavigator write SetShowNavigator default True;
    property StartOfWeek: TDayOfWeek read FStartOfWeek write SetStartOfWeek;
    property TabOrder;
    property TabStop;
    property UseCurrentDate: Boolean read FUseCurrentDate write SetUseCurrentDate default True;
    property Visible;
    property OnClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
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
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses CSPUtils, Dialogs, Consts;

constructor TLunarCal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { defaults }
  FUseCurrentDate := True;
  FShowGregDate := True;
  FShowNavigator := True;
  FHintDate := THintWindow.Create(Self);
  FixedCols := 0;
  FixedRows := 2;
  ColCount := 7;
  RowCount := 8;
  GridLineWidth := 0;
  Height := 155;
  Width := 335;
  ScrollBars := ssNone;
  Options := Options - [goRangeSelect] + [goDrawFocusSelected];
  FDate := Date;
  UpdateCalendar;
end;

destructor TLunarCal.Destroy;
begin
  FHintDate.Free;
  Inherited;
end;

procedure TLunarCal.WndProc(var Message: TMessage);
var
  P: TPoint;
  LunarRect: TRect;
begin
  inherited;
  if Assigned(FHintDate) and (Parent <> nil) 
     and Focused and FShowGregDate then
  begin
    if not GetCursorPos(P) then Exit;
    LunarRect := ClientRect;
    LunarRect.TopLeft := ClientToScreen(LunarRect.TopLeft);
    LunarRect.BottomRight := ClientToScreen(LunarRect.BottomRight);
    if (P.X < LunarRect.Left) or (P.X > LunarRect.Right) or
       (P.Y > LunarRect.Bottom) then
      FHintDate.ReleaseHandle;
  end;
end;

procedure TLunarCal.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TLunarCal.Click;
var
  TheCellText: string;
begin
  inherited Click;
  TheCellText := CellText[Col, Row];
  if TheCellText <> '' then LunarDay := StrToInt(TheCellText);
end;

function TLunarCal.DaysPerLunarMonth(GYear, LYear, AMonth: Integer): Integer;
var
  daterec: TDateRec;
begin
  daterec.GregYear := GYear;
  daterec.LunarYear := LYear;
  daterec.wMonth := AMonth;
  daterec.wDay := 0;
  Result := DaysInLunarMonth(@daterec);
end;

function TLunarCal.LunarDaysThisMonth: Integer;
var
  daterec: TDateRec;
begin
  daterec.GregYear := GetGregYear(GregYear, LunarYear, LunarMonth);
  daterec.LunarYear := LunarYear;
  daterec.wMonth := LunarMonth;
  daterec.wDay := 0;
  Result := DaysInLunarMonth(@daterec);
end;

procedure TLunarCal.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  TheText: string;
begin
  TheText := CellText[ACol, ARow];
  with ARect, Canvas do
    TextRect(ARect, Left + (Right - Left - TextWidth(TheText)) div 2,
      Top + (Bottom - Top - TextHeight(TheText)) div 2, TheText);
end;

function TLunarCal.GetCellText(ACol, ARow: Integer): string;
var
  DayNum: Integer;
begin
  case ARow of
    0: begin
         case ACol of
           0: if FShowNavigator then 
                Result := '<'
              else  Result := '';
           2: Result := LunarYearName(LunarYear) + '年';
           3: if LunarMonth > 0 then
                Result := ShortMonthNames[LunarMonth]
              else
                Result := '闰' + ShortMonthNames[Abs(LunarMonth)];
           6: if FShowNavigator then
                Result := '>'
              else  Result := '';
         else
           Result := '';
         end;
       end;
    1: begin  { day names at tops of columns }
         Result := ShortDayNames[(StartOfWeek + ACol) mod 7 + 1]
       end;
  else 
      DayNum := FMonthOffset + ACol + (ARow - 2) * 7;
      if (DayNum < 1) or (DayNum > LunarDaysThisMonth) then Result := ''
      else Result := IntToStr(DayNum);
  end;
end;

function TLunarCal.SelectCell(ACol, ARow: Longint): Boolean;
begin
  if ((not FUpdating) and FReadOnly) or (CellText[ACol, ARow] = '') then
    Result := False
  else Result := inherited SelectCell(ACol, ARow);
end;

procedure TLunarCal.SetCalendarDate(Value: TDateTime);
begin
  FDate := Value;
  UpdateCalendar;
  Change;
end;

procedure TLunarCal.SetShowNavigator(Value: Boolean);
begin
  if Value <> FShowNavigator then
  begin
    FShowNavigator := Value;
    Invalidate;
  end;
end;

function TLunarCal.StoreCalendarDate: Boolean;
begin
  Result := not FUseCurrentDate;
end;

function TLunarCal.GetDateElement(Index: Integer): Integer;
var
  AYear, ADay, GMonth: Word;
  AMonth: SmallInt;
begin
  DecodeLunarDate(FDate, AYear, AMonth, ADay);
  case Index of
    1: begin
         FLunarYear := AYear;
         DecodeDate(FDate, AYear, GMonth, Aday);
         Result := AYear;
       end;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

procedure TLunarCal.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, ADay, GYear, GMonth, GDay: Word;
  AMonth: SmallInt;
begin
  if Value > 0 then
  begin
    DecodeLunarDate(FDate, AYear, AMonth, ADay);
    DecodeDate(FDate, GYear, GMonth, GDay);
    case Index of
      1: if GYear <> Value then GYear := Value else Exit;
      2: if (Value <= 12) and (Value <> AMonth) then AMonth := Value else Exit;
      3: if (Value <= LunarDaysThisMonth) and (Value <> ADay) then ADay := Value else Exit;
      else Exit;
    end;
    GYear := GetGregYear(GYear, AYear, AMonth);
    FDate := EncodeLunarDate(GYear, AYear, AMonth, ADay);
    FUseCurrentDate := False;
    UpdateCalendar;
    Change;
  end;
end;

procedure TLunarCal.SetStartOfWeek(Value: TDayOfWeek);
begin
  if Value <> FStartOfWeek then
  begin
    FStartOfWeek := Value;
    UpdateCalendar;
  end;
end;

procedure TLunarCal.SetUseCurrentDate(Value: Boolean);
begin
  if Value <> FUseCurrentDate then
  begin
    FUseCurrentDate := Value;
    if Value then
    begin
      FDate := Date; { use the current date, then }
      UpdateCalendar;
    end;
  end;
end;

{ Given a value of 1 or -1, moves to Next or Prev month accordingly }
procedure TLunarCal.ChangeMonth(Delta: Integer);
var
  LYear, ADay, GYear, GMonth, GDay: Word;
  AMonth: SmallInt;
  CurDay: Integer;
  OldFDate, NewDate: TDateTime;
  DaysOfLunarMonth: Integer;
begin
  OldFDate := FDate;
  DecodeLunarDate(FDate, LYear, AMonth, ADay);
  DecodeDate(FDate, GYear, GMonth, GDay);
  GYear := GetGregYear(GYear, LYear, AMonth);
  CurDay := ADay;
  if Delta > 0 then ADay := DaysPerLunarMonth(GYear, LYear, AMonth)
  else ADay := 1;
  NewDate := EncodeLunarDate(GYear, LYear, AMonth, ADay);
  NewDate := NewDate + Delta;
  DecodeLunarDate(NewDate, LYear, AMonth, ADay);
  DecodeDate(NewDate, GYear, GMonth, GDay);

  GYear := GetGregYear(GYear, LYear, AMonth);
  DaysOfLunarMonth := DaysPerLunarMonth(GYear, LYear, AMonth);
  if DaysOfLunarMonth > CurDay then ADay := CurDay
  else ADay := DaysOfLunarMonth;

  try
    CalendarDate := EncodeLunarDate(GYear, LYear, AMonth, ADay);
  except
    { to catch the EConvertError here, this is to prevent the exception
      from being raised for each display cell of the calendar }
    on EConvertError do 
      begin
        CalendarDate := OldFDate;
        MessageDlg(SLunarDateInvalidRange, mtError, [mbOK], 0);
      end;
  end;
end;

procedure TLunarCal.PrevMonth;
begin
  ChangeMonth(-1);
end;

procedure TLunarCal.NextMonth;
begin
  ChangeMonth(1);
end;

procedure TLunarCal.NextYear;
begin
  GregYear := GregYear + 1;
end;

procedure TLunarCal.PrevYear;
begin
  GregYear := GregYear - 1;
end;

procedure TLunarCal.UpdateCalendar;
var
  LYear, ADay, GYear, GMonth, GDay: Word;
  AMonth: SmallInt;
  FirstDate: TDateTime;
begin
  FUpdating := True;
  try
    DecodeLunarDate(FDate, LYear, AMonth, ADay);
    DecodeDate(FDate, GYear, GMonth, GDay);

    GYear := GetGregYear(GYear, LYear, AMonth);
    FirstDate := EncodeLunarDate(GYear, LYear, AMonth, 1);
    FMonthOffset := 2 - ((DayOfWeek(FirstDate) - StartOfWeek + 7) mod 7); { day of week for 1st of month }
    if FMonthOffset = 2 then FMonthOffset := -5;
    MoveColRow((ADay - FMonthOffset) mod 7, (ADay - FMonthOffset) div 7 + 2,
      False, False);
    Invalidate;
  finally
    FUpdating := False;
  end;
end;

procedure TLunarCal.WMSize(var Message: TWMSize);
var
  GridLines: Integer;
begin
  GridLines := 6 * GridLineWidth;
  DefaultColWidth := (Message.Width - GridLines) div 7;
  DefaultRowHeight := (Message.Height - GridLines) div 8;
end;

procedure TLunarCal.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  hitpoint: TPoint;
begin
  inherited;

  if not FShowNavigator then Exit;

  if Button = mbLeft then
  begin
    hitpoint := self.HitTest;
    if (hitpoint.x > 0) and (hitpoint.x < DefaultColWidth) and
       (hitpoint.y > 0) and (hitpoint.y < DefaultRowHeight) then
      PrevMonth
    else 
      if (hitpoint.x > (DefaultColWidth*(ColCount-1))) and 
         (hitpoint.x < (DefaultColWidth*ColCount)) and
         (hitpoint.y > 0) and (hitpoint.y < DefaultRowHeight) then 
        NextMonth;
  end;
end;

procedure TLunarCal.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  TheCellText: string;
  DateRec: TDateRec;
  ROCYearStr, HintStr: String;
  HintRect: TRect;
  P: TPoint;
  X1, Y1, X2, Y2, CursorOffset: Integer;
  TopLeftX, TopLeftY, BotRightX, BotRightY: Integer;
  CurrentRowCol: TGridCoord;
begin
  inherited;
      
  if not ShowGregDate then Exit;
  if (not Focused) or (HitTest.Y < (DefaultRowHeight*2)) then
  begin
    FHintDate.ReleaseHandle;
    Exit;
  end;
  CurrentRowCol:= MouseCoord(HitTest.X, HitTest.Y);
  TheCellText := CellText[CurrentRowCol.X, CurrentRowCol.Y];
  if TheCellText <> '' then 
  begin
    if not GetCursorPos(P) then Exit;
    CursorOffset := GetSystemMetrics(SM_CYCURSOR) DIV 2;
    X1 := DefaultColWidth * CurrentRowCol.X;
    Y1 := DefaultRowHeight * CurrentRowCol.Y;
    X2 := DefaultColWidth * (CurrentRowCol.X+1);
    Y2 := DefaultRowHeight * (CurrentRowCol.Y+1);
    if (HitTest.X > X1) and (HitTest.X < X2) and
       (HitTest.Y > Y1) and (HitTest.Y < Y2) then
    begin
      DateRec.GregYear := GetGregYear(GregYear, LunarYear, LunarMonth);
      DateRec.LunarYear := LunarYear;
      DateRec.wMonth := LunarMonth;
      DateRec.wDay := StrToInt(TheCellText);
      if not LunarToGregorianDate(@daterec) then Exit;
      
      if daterec.GregYear > 1911 then
        ROCYearStr := '中国' + IntToStr(daterec.GregYear - 1911) + '年'
      else ROCYearStr := IntToStr(daterec.GregYear) + '年';
      HintStr := ROCYearStr + IntToStr(daterec.wMonth) + '月' +
                 IntToStr(daterec.wDay) + '日';
      HintRect := FHintDate.CalcHintRect(Screen.Width, HintStr, nil);
      BotRightX := HintRect.Right + P.X;
      BotRightY := HintRect.Bottom + P.Y + CursorOffset;
      TopLeftX := HintRect.Left + P.X;
      TopLeftY := HintRect.Top + P.Y + CursorOffset;
      if BotRightX > Screen.Width then
      begin
        BotRightX := Screen.Width;
        TopLeftX := Screen.Width - (HintRect.Right - HintRect.Left);
      end;
      if BotRightY > (Screen.Height - 4) then
      begin
        BotRightY := Screen.Height - 4;
        TopLeftY := Screen.Height - (HintRect.Bottom - HintRect.Top) - 4;
      end;
      HintRect := Rect(TopLeftX, TopLeftY, BotRightX, BotRightY);
      FHintDate.ActivateHint(HintRect, HintStr);
    end;
  end
  else FHintDate.ReleaseHandle;
end; 

function TLunarCal.GetGregYear(GYear, LYear: Word; LMonth: SmallInt): Word;
var
  lpThis: PLunar;
  i: integer;
  found: Boolean;
begin
  Result := GYear;
  found := False;

  lpThis := @LunarLookup[0];
  i := nLunarEntries;
  while i > 0 do
  begin
    if lpThis^.LunarYear <> LYear then
    begin
      Inc(lpThis);
      Dec(i);
      Continue;
    end;
    if lpThis^.LunarMonth <> LMonth then
    begin
      Inc(lpThis);
      Dec(i);
      Continue;
    end;
    if Abs(lpThis^.GregYear - GYear) > 3 then
    begin
      Inc(lpThis, 59 * 12);
      Dec(i, 59 * 12);
      Continue;
    end;
    found := True;
    break;
  end;

  if not found then
    Exit;

  Result := lpThis^.GregYear;
end;

end.
 
