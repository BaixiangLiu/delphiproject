unit ASDBEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls;

type
  TAutoSkipEvent = procedure(Sender: TObject; var bSkip : Boolean) of object;

  TAutoSkipDBEdit = class(TDBEdit)
  private
    { Private declarations }
    FAutoSkip : Boolean;
    FAutoSkipLength : Integer;
    FBeforeSkip: TAutoSkipEvent;
    FAfterSkip: TNotifyEvent;

    procedure SetAutoSkipLength(const Value : Integer);
  protected
    { Protected declarations }
    procedure WMChar(); virtual;
    procedure SkipToNextControl();
  public
    { Public declarations }
    procedure WndProc(var Message: TMessage); override;
  published
    { Published declarations }
    property AutoSkip : Boolean read FAutoSkip write FAutoSkip;
    property AutoSkipLength : Integer read FAutoSkipLength write SetAutoSkipLength;
    property BeforeSkip : TAutoSkipEvent read FBeforeSkip write FBeforeSkip;
    property AfterSkip : TNotifyEvent read FAfterSkip write FAfterSkip;
  end;

implementation

uses DB;

procedure TAutoSkipDBEdit.SetAutoSkipLength(const Value : Integer);
begin
  if (Value <> FAutoSkipLength) then
  begin
    if (Assigned(Field)) then
    begin
      if ((Field.DataType = ftString) and (Value > Field.Size)) then
      begin
        if (MessageDlg('你設定的AutoSkipLength大於欄位允許的長度: ' + IntToStr(Field.Size) + ' ，要設定成欄位允許的最大長度嗎', mtInformation, [mbYes, mbNo], 0) = mrYes) then
        begin
          FAutoSkipLength := Field.Size;
        end;
      end
      else
        FAutoSkipLength := Value;
    end
    else
    begin
      if ((MaxLength <> 0) and (Value > MaxLength)) then
      begin
        ShowMessage('你設定的AutoSkipLength大於MaxLength的特性值，請檢查');
      end
      else
        FAutoSkipLength := Value;
    end;
  end;
end;

procedure TAutoSkipDBEdit.SkipToNextControl();
var
  aForm : TCustomForm;
  aComponent, aFirstComponent : TWinControl;
  iCount : Integer;
  bFound : Boolean;
begin
//  SendMessage(GetParentForm(Self).Handle, WM_NEXTDLGCTL, 0, 0);
  bFound := False;
  aForm := GetParentForm(Self);

  aFirstComponent := TWinControl(aForm.Components[0]);
  for iCount := 0 to aForm.ComponentCount - 1 do
  begin
    if (aForm.Components[iCount] is TWinControl) then
    begin
      aComponent := TWinControl(aForm.Components[iCount]);
      if (aFirstComponent.TabOrder > aComponent.TabOrder) then
        aFirstComponent := aComponent;
      if ( (Self.TabOrder + 1) = aComponent.TabOrder) then
      begin
        aComponent.SetFocus;
        bFound := True;
        break;
      end;
    end;
  end;

  if (not bFound) then
    aFirstComponent.SetFocus;
end;

procedure TAutoSkipDBEdit.WMChar();
var
  bSkip : Boolean;
begin
  bSkip := True;
  if (Length(Text) >= FAutoSkipLength) then
  begin
    if Assigned(FBeforeSkip) then
      FBeforeSkip(Self, bSkip);

    if (bSkip) then
    begin
      SkipToNextControl();

      if Assigned(FAfterSkip) then
        FAfterSkip(Self);
    end;
  end;
end;

procedure TAutoSkipDBEdit.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);

  if (FAutoSkip) then
  begin
    case Message.Msg of
      WM_CHAR :
        begin
          if ((Message.WParam <> VK_DELETE) and (Message.WParam <> VK_BACK)) then
            WMChar();
        end;
    end;
  end;
end;

end.
