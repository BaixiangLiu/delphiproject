unit ASEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TAutoSkipEvent = procedure(Sender: TObject; var bSkip : Boolean) of object;

  TASkipEdit = class(TEdit)
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

procedure TASkipEdit.SetAutoSkipLength(const Value : Integer);
begin
  if (Value <> FAutoSkipLength) then
  begin
    if ((MaxLength <> 0) and (Value > MaxLength)) then
    begin
      ShowMessage('你设置的AutoSkipLength大于MaxLength的特性值，请检查')
    end
    else
      FAutoSkipLength := Value;
  end;
end;

procedure TASkipEdit.SkipToNextControl();
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

procedure TASkipEdit.WMChar();
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

procedure TASkipEdit.WndProc(var Message: TMessage);
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
 
