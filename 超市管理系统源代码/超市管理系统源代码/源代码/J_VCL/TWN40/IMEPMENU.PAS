
{*******************************************************}
{                                                       }
{       Delphi Visual Component Library                 }
{                                                       }
{       Copyright (c) 1995,97 Borland International     }
{                                                       }
{*******************************************************}

unit ImePMenu;

{$S-,W-,R-}
{$C PRELOAD}

interface

uses Windows, SysUtils, Classes, Controls, Messages, Menus, DsgnIntf;

const
  USKBLayout = '00000409';

type
  TImePopupMenu = class(TPopupMenu)
  private
    KBClosehdle: HKL;
    function SetPopupComponentIme(const ImeMd: TImeMode; const ImeNm: string): Boolean;
    procedure PhonItemClicked(Sender: TObject);
    procedure ChaJeiItemClicked(Sender: TObject);
    procedure QuickItemClicked(Sender: TObject);
    procedure IntCodeItemClicked(Sender: TObject);
    procedure RowColItemClicked(Sender: TObject);
    procedure DaYiItemClicked(Sender: TObject);
    procedure RomanItemClicked(Sender: TObject);
    procedure HanYinItemClicked(Sender: TObject);
    procedure OffItemClicked(Sender: TObject);
  protected
    procedure CreateImeMenuItems;
    procedure RemoveImeMenuItems;
    procedure WriteState(Writer: TWriter); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(X, Y: Integer); override;
  end;

implementation

uses TypInfo, StdCtrls, ComCtrls, DBCtrls, DBGrids, DBGridsX, 
     Forms, Mask, CheckLst, DBLookup, FileCtrl, CSPCtrls;

const
  PhonName = '注音';
  ChaJeiName = '倉頡';
  QuickName = '速成';
  IntCodeName = '內碼';
  RowColName = '行列';
  DaYiName = '大易';
  RomanName = '英數';
  HanYinName = '漢英';
  OffName = '關閉IME';

type
  TEditControl = Class(TWinControl)
  public
    property ImeName;
    property ImeMode;
  end;

constructor TImePopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateImeMenuItems;
  // Load US Keyboard layout as the "close IME" handle
  KBClosehdle := LoadKeyboardLayout(USKBLayout, KLF_ACTIVATE);
  ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
end;

destructor TImePopupMenu.Destroy;
begin
  RemoveImeMenuItems;
  inherited Destroy;
end;

procedure TImePopupMenu.CreateImeMenuItems;
var
  I: Integer;
  AMenu: TMenu;
  NewMenuItem: TMenuItem;
begin
  if not SysLocale.FarEast then Exit;
  AMenu := Self;
  for I := 0 to Screen.Imes.Count - 1 do
  begin
    if AnsiCompareText(Screen.Imes[I], PhonName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, PhonItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], ChaJeiName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, ChaJeiItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], QuickName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, QuickItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], IntCodeName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, IntCodeItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], RowColName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, RowColItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], DaYiName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, DaYiItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], RomanName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, RomanItemClicked, 0, '')
    else
    if AnsiCompareText(Screen.Imes[I], HanYinName) = 0 then
      NewMenuItem := NewItem(Screen.Imes[I], scNone, False, True, HanYinItemClicked, 0, '')
    else
      Continue;

    AMenu.Items.Add(NewMenuItem);
  end;

  NewMenuItem := NewItem(OffName, scNone, False, True, OffItemClicked, 0, '');
  AMenu.Items.Add(NewMenuItem);
end;

procedure TImePopupMenu.RemoveImeMenuItems;
var
  AMenu: TMenu;
  I, itemcnt: integer;
begin
  if not SysLocale.FarEast then Exit;
  AMenu := Self;
  itemcnt := AMenu.Items.Count;
  for I := itemcnt - 1 downto 0 do
    AMenu.Items.Delete(I);
end;

procedure TImePopupMenu.WriteState(Writer: TWriter);
begin
  RemoveImeMenuItems;
  Inherited;
  CreateImeMenuItems;
end;

function TImePopupMenu.SetPopupComponentIme(const ImeMd: TImeMode; const ImeNm: string): Boolean;
begin
  Result := True;

  // skip setting for TEditExt and TDBEditExt components
  if (PopupComponent is TEditExt) or (PopupComponent is TDBEditExt) then
  begin
    Result := False;
    Exit;
  end;

  If PopupComponent is TEdit then
  begin
    TEdit(PopupComponent).ImeName := ImeNm;
    TEdit(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TMemo then
  begin
    TMemo(PopupComponent).ImeName := ImeNm;
    TMemo(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TRichEdit then
  begin
    TRichEdit(PopupComponent).ImeName := ImeNm;
    TRichEdit(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBEdit then
  begin
    TDBEdit(PopupComponent).ImeName := ImeNm;
    TDBEdit(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBMemo then
  begin
    TDBMemo(PopupComponent).ImeName := ImeNm;
    TDBMemo(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBRichEdit then
  begin
    TDBRichEdit(PopupComponent).ImeName := ImeNm;
    TDBRichEdit(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBGrid then
  begin
    TDBGrid(PopupComponent).ImeName := ImeNm;
    TDBGrid(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBGridExt then
  begin
    TDBGridExt(PopupComponent).ImeName := ImeNm;
    TDBGridExt(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TListBox then
  begin
    TListBox(PopupComponent).ImeName := ImeNm;
    TListBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TComboBox then
  begin
    TComboBox(PopupComponent).ImeName := ImeNm;
    TComboBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TMaskEdit then
  begin
    TMaskEdit(PopupComponent).ImeName := ImeNm;
    TMaskEdit(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TCheckListBox then
  begin
    TCheckListBox(PopupComponent).ImeName := ImeNm;
    TCheckListBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBListBox then
  begin
    TDBListBox(PopupComponent).ImeName := ImeNm;
    TDBListBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBComboBox then
  begin
    TDBComboBox(PopupComponent).ImeName := ImeNm;
    TDBComboBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBLookupListBox then
  begin
    TDBLookupListBox(PopupComponent).ImeName := ImeNm;
    TDBLookupListBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBLookupComboBox then
  begin
    TDBLookupComboBox(PopupComponent).ImeName := ImeNm;
    TDBLookupComboBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBLookupList then
  begin
    TDBLookupList(PopupComponent).ImeName := ImeNm;
    TDBLookupList(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDBLookupCombo then
  begin
    TDBLookupCombo(PopupComponent).ImeName := ImeNm;
    TDBLookupCombo(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TFileListBox then
  begin
    TFileListBox(PopupComponent).ImeName := ImeNm;
    TFileListBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDirectoryListBox then
  begin
    TDirectoryListBox(PopupComponent).ImeName := ImeNm;
    TDirectoryListBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TDriveComboBox then
  begin
    TDriveComboBox(PopupComponent).ImeName := ImeNm;
    TDriveComboBox(PopupComponent).ImeMode := ImeMd;
  end
  else
  If PopupComponent is TFilterComboBox then
  begin
    TFilterComboBox(PopupComponent).ImeName := ImeNm;
    TFilterComboBox(PopupComponent).ImeMode := ImeMd;
  end
  else
    Result := False;
end;

procedure TImePopupMenu.PhonItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, PhonName) then Exit;
  SetImeName(PhonName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.ChaJeiItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, ChaJeiName) then Exit;
  SetImeName(ChaJeiName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.QuickItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, QuickName) then Exit;
  SetImeName(QuickName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.IntCodeItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, IntCodeName) then Exit;
  SetImeName(IntCodeName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.RowColItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, RowColName) then Exit;
  SetImeName(RowColName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.DaYiItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, DaYiName) then Exit;
  SetImeName(DaYiName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.RomanItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, RomanName) then Exit;
  SetImeName(RomanName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.HanYinItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imSHanguel, HanYinName) then Exit;
  SetImeName(HanYinName);
  SetImeMode(TWinControl(PopupComponent).Handle, imSHanguel);
end;

procedure TImePopupMenu.OffItemClicked(Sender: TObject);
begin
  if not SetPopupComponentIme(imDontCare, '') then Exit;
  if not (KBClosehdle = 0) then
    ActivateKeyboardLayout(KBClosehdle, KLF_ACTIVATE);
end;

procedure TImePopupMenu.Popup(X, Y: Integer);
var
  i: Integer;
begin
  for i := 0 to Items.Count - 1 do
    if AnsiCompareText(Items[i].Caption, OffName) = 0 then
    begin
      if TEditControl(PopupComponent).ImeName = '' then
        Items[i].Checked := True
      else
        Items[i].Checked := False;
    end   
    else
      begin
        if AnsiCompareText(Items[i].Caption, 
                           TEditControl(PopupComponent).ImeName) = 0 then
          Items[i].Checked := True
        else
          Items[i].Checked := False;
      end;

  inherited;
end;

end.


