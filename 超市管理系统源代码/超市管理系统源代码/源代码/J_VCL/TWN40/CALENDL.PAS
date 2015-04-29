unit CalendL;

interface

uses Classes, Controls, Messages, Windows, Forms, Graphics, StdCtrls,
  Grids, SysUtils;

type
  TDayOfWeek = 0..6;

  TCalendarL = class(TCustomGrid)
  private
    FDate: TDateTime;
    FMonthOffset: Integer;
    FOnChange: TNotifyEvent;
    FReadOnly: Boolean;
    FStartOfWeek: TDayOfWeek;
    FUpdating: Boolean;
    FShowNavigator: Boolean;
    FUseCurrentDate: Boolean;
    function GetCellText(ACol, ARow: Integer): string;
    function GetDateElement(Index: Integer): Integer;
    procedure SetCalendarDate(Value: TDateTime);
    procedure SetDateElement(Index: Integer; Value: Integer);
    procedure SetStartOfWeek(Value: TDayOfWeek);
    procedure SetShowNavigator(Value: Boolean);
    procedure SetUseCurrentDate(Value: Boolean);
    function StoreCalendarDate: Boolean;
  protected
    procedure Change; dynamic;
    procedure ChangeMonth(Delta: Integer);
    procedure Click; override;
    function DaysPerMonth(AYear, AMonth: Integer): Integer; virtual;
    function DaysThisMonth: Integer; virtual;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function IsLeapYear(AYear: Integer): Boolean; virtual;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    property CalendarDate: TDateTime  read FDate write SetCalendarDate stored StoreCalendarDate;
    property CellText[ACol, ARow: Integer]: string read GetCellText;
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
    property Day: Integer index 3  read GetDateElement write SetDateElement stored False;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GridLineWidth;
    property Month: Integer index 2  read GetDateElement write SetDateElement stored False;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ShowHint;
    property ShowNavigator: Boolean read FShowNavigator write SetShowNavigator default True;
    property StartOfWeek: TDayOfWeek read FStartOfWeek write SetStartOfWeek;
    property TabOrder;
    property TabStop;
    property UseCurrentDate: Boolean read FUseCurrentDate write SetUseCurrentDate default True;
    property Visible;
    property YearROC: Integer index 1  read GetDateElement write SetDateElement stored False;
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

constructor TCalendarL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { defaults }
  FUseCurrentDate := True;
  FShowNavigator := True;
  FixedCols := 0;
  FixedRows := 2;
  ColCount := 7;
  RowCount := 8;
  Height := 155;
  Width := 335;
  ScrollBars := ssNone;
  Options := Options - [goRangeSelect] + [goDrawFocusSelected];
  FDate := Date;
  UpdateCalendar;
end;

procedure TCalendarL.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCalendarL.Click;
var
  TheCellText: string;
begin
  inherited Click;
  TheCellText := CellText[Col, Row];
  if TheCellText <> '' then Day := StrToInt(TheCellText);
end;

function TCalendarL.IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function TCalendarL.DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result); { leap-year Feb is special }
end;

function TCalendarL.DaysThisMonth: Integer;
begin
  Result := DaysPerMonth(YearROC+1911, Month);
end;

procedure TCalendarL.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  TheText: string;
begin
  TheText := CellText[ACol, ARow];
  with ARect, Canvas do
    TextRect(ARect, Left + (Right - Left - TextWidth(TheText)) div 2,
      Top + (Bottom - Top - TextHeight(TheText)) div 2, TheText);
end;

function TCalendarL.GetCellText(ACol, ARow: Integer): string;
var
  DayNum: Integer;
begin
  case ARow of
    0: begin
         case ACol of
           0: if FShowNavigator then 
                Result := '<'
              else  Result := '';
           2: Result := 'ÖÐ¹ú';
           3: Result := IntToStr(YearROC) + 'Äê';
           4: Result := ShortMonthNames[Month];
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
      if (DayNum < 1) or (DayNum > DaysThisMonth) then Result := ''
      else Result := IntToStr(DayNum);
  end;
end;

function TCalendarL.SelectCell(ACol, ARow: Longint): Boolean;
begin
  if ((not FUpdating) and FReadOnly) or (CellText[ACol, ARow] = '') then
    Result := False
  else Result := inherited SelectCell(ACol, ARow);
end;

procedure TCalendarL.SetCalendarDate(Value: TDateTime);
begin
  FDate := Value;
  UpdateCalendar;
  Change;
end;

procedure TCalendarL.SetShowNavigator(Value: Boolean);
begin
  if Value <> FShowNavigator then
  begin
    FShowNavigator := Value;
    Invalidate;
  end;
end;

function TCalendarL.StoreCalendarDate: Boolean;
begin
  Result := not FUseCurrentDate;
end;

function TCalendarL.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    { Taiwanese date, the year component need to be subtracted by 1911 }
    1: Result := AYear - 1911;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

procedure TCalendarL.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value >= 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      { Taiwanese date, the year component need to be added by 1911 }
      1: if AYear <> (Value+1911) then AYear := Value + 1911 else Exit;
      2: if (Value <= 12) and (Value <> AMonth) then AMonth := Value else Exit;
      3: if (Value <= DaysThisMonth) and (Value <> ADay) then ADay := Value else Exit;
      else Exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);
    FUseCurrentDate := False;
    UpdateCalendar;
    Change;
  end;
end;

procedure TCalendarL.SetStartOfWeek(Value: TDayOfWeek);
begin
  if Value <> FStartOfWeek then
  begin
    FStartOfWeek := Value;
    UpdateCalendar;
  end;
end;

procedure TCalendarL.SetUseCurrentDate(Value: Boolean);
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
procedure TCalendarL.ChangeMonth(Delta: Integer);
var
  AYear, AMonth, ADay: Word;
  NewDate: TDateTime;
  CurDay: Integer;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  CurDay := ADay;
  if Delta > 0 then ADay := DaysPerMonth(AYear, AMonth)
  else ADay := 1;
  NewDate := EncodeDate(AYear, AMonth, ADay);
  NewDate := NewDate + Delta;
  DecodeDate(NewDate, AYear, AMonth, ADay);
  if DaysPerMonth(AYear, AMonth) > CurDay then ADay := CurDay
  else ADay := DaysPerMonth(AYear, AMonth);
  CalendarDate := EncodeDate(AYear, AMonth, ADay);
end;

procedure TCalendarL.PrevMonth;
begin
  ChangeMonth(-1);
end;

procedure TCalendarL.NextMonth;
begin
  ChangeMonth(1);
end;

procedure TCalendarL.NextYear;
begin
  if IsLeapYear(YearROC+1911) and (Month = 2) and (Day = 29) then Day := 28;
  YearROC := YearROC + 1;
end;

procedure TCalendarL.PrevYear;
begin
  if IsLeapYear(YearROC+1911) and (Month = 2) and (Day = 29) then Day := 28;
  YearROC := YearROC - 1;
end;

procedure TCalendarL.UpdateCalendar;
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;
begin
  FUpdating := True;
  try
    DecodeDate(FDate, AYear, AMonth, ADay);
    FirstDate := EncodeDate(AYear, AMonth, 1);
    FMonthOffset := 2 - ((DayOfWeek(FirstDate) - StartOfWeek + 7) mod 7); { day of week for 1st of month }
    if FMonthOffset = 2 then FMonthOffset := -5;
    MoveColRow((ADay - FMonthOffset) mod 7, (ADay - FMonthOffset) div 7 + 2,
      False, False);
    Invalidate;
  finally
    FUpdating := False;
  end;
end;

procedure TCalendarL.WMSize(var Message: TWMSize);
var
  GridLines: Integer;
begin
  GridLines := 6 * GridLineWidth;
  DefaultColWidth := (Message.Width - GridLines) div 7;
  DefaultRowHeight := (Message.Height - GridLines) div 8;
end;

procedure TCalendarL.MouseDown(Button: TMouseButton; Shift: TShiftState;
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

end.
 
