unit JDBComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls;

type
  TJDBComboBox = class(TDBComboBox)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
    procedure Change;  override;
    procedure DoExit;  override;
  published
    { Published declarations }
  end;

procedure Register;

implementation
uses un_utl;


procedure Register;
begin
  RegisterComponents('J_STD', [TJDBComboBox]);
end;

procedure TJDBComboBox.Change;
BEGIN
{
//每次变动都更新数值
   IF ITEMINDEX < 0 THEN
      BEGIN
      TEXT := '';   EXIT;   //空字符串不做任何操作
      END ELSE BEGIN
      TEXT := ITEMS.STRINGS[ITEMINDEX];
      END;
}
  inherited CHANGE;
END;

procedure TJDBComboBox.DoExit;
BEGIN


IF ITEMINDEX >= 0 THEN
   BEGIN
   DataSource.DataSet.Edit;
   DataSource.DataSet.FieldByName(DataField).AsString := INTTOSTR(ITEMINDEX);
   TEXT := ITEMS.STRINGS[ITEMINDEX];
   END ELSE TEXT := '';//空字符串不做任何操作

inherited;
END;



procedure TJDBComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var iSelStart, iSelStop: integer;
begin

  case Key of
//    vk_Escape: Reset;  // 按Esc 键时, 数据还原
//    13,
    vk_Down: // 往下键
      begin
        // 送出 WM_NEXTDLGCTL 消息, 让下一个控件取得键盘焦点
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
          Key := 0;
      end;
    vk_Up: // 往上键
      begin
        // 注意: 第三个自变量不为零时, focus 将移往上一个控件
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
          Key := 0;
      end;
    vk_Right: // 右
      begin
//        GetSelection(iSelStart, iSelStop);
        // 如果已在右边界仍按向右键, 移往下一个控件
        if (iSelStart = iSelStop) and (iSelStop = GetTextLen) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 0, 0);
          Key := 0;
        end;
      end;
    vk_Left: // 左
      begin
//        GetSelection(iSelStart, iSelStop);
        // 如果已在左边界仍按向左键, 移往上一个控件
        if (iSelStart = iSelStop) and (iSelStart = 0) then
        begin
          SendMessage(GetParentForm(Self).Handle, wm_NextDlgCtl, 1, 0);
          Key := 0;
        end;
      end;
  end;

  if Key <> 0 then inherited KeyDown(Key, Shift);
end; { TCEdit.KeyDown }

end.
