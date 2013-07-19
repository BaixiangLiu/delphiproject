{**********************************************}
{   Automatic Translation Unit  -Internal-     }
{   Copyright (c) 2001-2003 by David Berneda   }
{**********************************************}
unit TeeTranslate;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, 
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics, QForms, QControls, QStdCtrls, QButtons, QExtCtrls,
     {$ELSE}
     Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
     {$ENDIF}
     SysUtils, Classes;

type
  TAskLanguage = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    LBLangs: TListBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure LBLangsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{.$DEFINE TEEFINDMISSING}  { <-- internal use }

{$IFDEF TEEFINDMISSING}
{ internal use }
Procedure StartMissing;
Procedure EndMissing;

var Missing:TStringList=nil;
    MissingHelp:TStringList=nil;
    HelpIDList:TStringList=nil;
    MaxHelpContext:Integer=0;

Procedure StartExtract;
Procedure EndExtract;

var Extract:TStringList=nil;
{$ENDIF}

Procedure TeeTranslateControl(AControl:TControl);
Function TeeCanTranslate(Var S,HotKeyList:String):Boolean;

{ Show a dialog to change current Language. Returns True if changed. }
Function TeeAskLanguage:Boolean;

{ Returns the TeeChart Language stored at the Registry }
Function TeeLanguageRegistry:Integer;

{ Stores "Index" TeeChart Language into Registry }
Procedure TeeLanguageSaveRegistry(LanguageNum:Integer);

implementation

Uses {$IFNDEF LINUX}
     Registry,
     {$ELSE}
     IniFiles,
     {$ENDIF}
     {$IFDEF CLX}
     QComCtrls, QMenus,
     {$ELSE}
     ComCtrls, Menus,
     {$ENDIF}
     {$IFDEF TEEFINDMISSING}
     Math,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeConst;

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Function TeeAskLanguage:Boolean;
begin
  result:=False;
  with TAskLanguage.Create(nil) do
  try
    if ShowModal=mrOk then
       result:=True;
  finally
    Free;
  end;
end;

{$IFDEF TEEFINDMISSING}
{ internal use }
Procedure StartMissing;
const ContextEditorFile='f:\kylix\Docs\helpv6\Context_Editor.txt';

var t: Integer;
begin
  Missing:=TStringList.Create;
  MissingHelp:=TStringList.Create;
  HelpIDList:=TStringList.Create;
  if FileExists(ContextEditorFile) then
     HelpIDList.LoadFromFile(ContextEditorFile);
  MaxHelpContext:=0;
  
  if Assigned(TeeLanguage) then
  for t:=0 to TeeLanguage.Count-1 do
      TeeLanguage.Objects[t]:=Pointer(0);
end;

Procedure EndMissing;
var t: Integer;
begin
  Missing.Add('');
  Missing.Add('Unused:');
  Missing.Add('-------');

  if Assigned(TeeLanguage) then
  for t:=0 to TeeLanguage.Count-1 do
      if Integer(TeeLanguage.Objects[t])=0 then
         Missing.Add(TeeLanguage[t]);

  Missing.Add('-------');

  Missing.SaveToFile('c:\teemissing.txt');
  MissingHelp.Add('');
  MissingHelp.Add('Maximum helpcontext = '+IntToStr(MaxHelpContext));
  MissingHelp.SaveToFile('c:\teemissinghelp.txt');
  FreeAndNil(Missing);
  FreeAndNil(MissingHelp);
  FreeAndNil(HelpIDList);
end;

Procedure StartExtract;
begin
  Extract:=TStringList.Create;
end;

Procedure EndExtract;
begin
  Extract.SaveToFile('c:\teeextract.txt');
  Extract.Free;
end;

Function IsNumber(Const S:String):Boolean;
var Value : Double;
begin
 result:=TryStrToFloat(S,Value);
end;
{$ENDIF}

{$IFNDEF D5}
Const cHotKeyPrefix = '&';
{$ENDIF}

Function TeeCanTranslate(Var S,HotKeyList:String):Boolean;

{$IFNDEF D5}
// From Delphi sources. Delphi 4 does not has GetHotKey function.
function GetHotkey(const Text: string): string;
var
  I, L: Integer;
begin
  Result := '';
  I := 1;
  L := Length(Text);
  while I <= L do
  begin
    if Text[I] in LeadBytes then
      Inc(I)
    else if (Text[I] = cHotkeyPrefix) and
            (L - I >= 1) then
    begin
      Inc(I);
      if Text[I] <> cHotkeyPrefix then
        Result := Text[I]; // keep going there may be another one
    end;
    Inc(I);
  end;
end;
{$ENDIF}

  // Optimized version of TStringList.Values[].
  Function GetTranslatedString(Const St:String):String;
  var t    : Integer;
      i    : Integer;
      tmpS : string;
  begin
    if Assigned(TeeLanguage) then
    with TeeLanguage do
    for t:=0 to Count-1 do
    begin
      tmpS:=Strings[t];
      i:=Pos('=',tmpS);
      if (i>0) and (Copy(tmpS,1,i-1)=St) then
      begin
        result:=Copy(tmpS,i+1,MaxInt);
        {$IFDEF TEEFINDMISSING}
        Objects[t]:=Pointer(Integer(Objects[t])+1);
        {$ENDIF}
        exit;
      end;
    end;
    result:='';
  end;

  {$IFDEF TEEFINDMISSING}
  Function FoundInLanguage(const s:String):Boolean;
  var t:Integer;
  begin
    with TeeLanguage do
    for t:=0 to Count-1 do
    if Pos('='+s,UpperCase(Strings[t]))>0 then
    begin
      result:=true;
      exit;
    end;
    result:=False;
  end;
  {$ENDIF}

var s2         : String;
    s3         : String;
    s4         : String;
    tmpHot     : String;
    HasColon   : Boolean;
    HasHotKey  : Boolean;
    HasEllipse : Boolean;
    t          : Integer;
begin
  result:=False;
  if {$IFDEF TEEFINDMISSING}Assigned(TeeLanguage) and{$ENDIF}
     (s<>'?') and (s<>'%') and (s<>'0') then
  begin
    s:=Trim(s);
    if s<>'' then
    begin
      HasEllipse:=False;
      HasColon:=False;

      { remove hot-key if exists... }
      s4:=StripHotkey(s);
      HasHotKey:=s4<>s;
      if TeeLanguageHotKeyAtEnd and HasHotKey then tmpHot:=GetHotkey(s);

      { ':' }
      s2:=UpperCase(s4);
      if Copy(s2,Length(s2),1)=':' then
      begin
        HasColon:=True;
        s2:=Copy(s2,1,Length(s2)-1);
      end;

      { ... }
      if Copy(s2,Length(s2)-2,3)='...' then
      begin
        HasEllipse:=True;
        s2:=Copy(s2,1,Length(s2)-3);
      end;

      { find new translated string }
      // Optimization of: s3:=TeeLanguage.Values[s2];  { 5.03 }
      s3:=GetTranslatedString(s2);

      if s3<>'' then
      begin
        s:=s3;
        if HasHotKey then { add ampersand (hotkey) to string }
        begin
          if TeeLanguageHotKeyAtEnd then
          begin
            s:=s+'('+cHotKeyPrefix+UpperCase(tmpHot)+')';
          end
          else { default }
          for t:=1 to Length(s) do
          if s[t] in ['a'..'z','A'..'Z','0'..'9'] then
             if Pos(s[t],HotKeyList)=0 then { HotKey char not yet in list }
             begin
               HotKeyList:=HotKeyList+s[t];
               s:=Copy(s,1,t-1)+cHotKeyPrefix+Copy(s,t,Length(s)); { add hotkey }
               break;
             end;
        end;

        { after HotKey, check Ellipse and Colon }
        if HasEllipse then s:=s+'...';
        if HasColon then s:=s+':';
        result:=True;
      end
      else
      begin
       {$IFDEF TEEFINDMISSING}
       // string not found in translation, add to "missing" list...
       if Assigned(Missing) then
          if (s2<>'+') and (s2<>'-') and (s2<>'') and (not IsNumber(s2)) then
             if not FoundInLanguage(s2) then
             begin
               s2:=''''+s2+'=''#13+';
               if Missing.IndexOf(s2)=-1 then
                  Missing.Add(s2);
             end;
       {$ENDIF}
      end;
    end;
  end;
end;

type TControlAccess=class(TControl);

Procedure TeeTranslateControl(AControl:TControl);

 {$IFDEF TEEFINDMISSING}
 Procedure CheckExtract(AComp:TComponent; Const S:String);
 var tmp : String;
 begin
   if Assigned(Extract) and (S<>'') and (not IsNumber(S)) then
   begin
     if AComp.Owner=nil then tmp:='nil'
                        else tmp:=AComp.Owner.ClassName;
      Extract.Add(tmp+#9+AComp.ClassName+#9+AComp.Name+#9+S);
   end;
 end;

 Procedure CheckDuplicates;
 var Num,i,t,tt:Integer;
     s,s2:String;
 begin
   if Assigned(Missing) and (Missing.IndexOf('Duplicates:')=-1)
      and Assigned(TeeLanguage) then
   begin
     Missing.Add('');
     Missing.Add('Duplicates:');
     Missing.Add('---------------');
     for t:=0 to TeeLanguage.Count-1 do
     begin
       Num:=0;
       s:=TeeLanguage.Strings[t];
       i:=Pos('=',s);
       if i>0 then s:=Copy(s,1,i-1);
       for tt:=0 to TeeLanguage.Count-1 do
       begin
         s2:=TeeLanguage.Strings[tt];
         i:=Pos('=',s2);
         if i>0 then s2:=Copy(s2,1,i-1);
         if s=s2 then Inc(Num);
       end;

       if Num>1 then Missing.Add(s+'   ('+IntToStr(Num)+')');
     end;
     Missing.Add('---------------');
   end;
 end;

 Procedure CheckHelpContext(AControl:TWinControl);

   Function GetTextToOutput(C:TControl):String;
   var tmp : TControl;
   begin
     tmp:=C.Parent;
     if not (tmp is TCustomForm) then
        while Assigned(tmp.Parent) do
        begin
          tmp:=tmp.Parent;
          if tmp is TCustomForm then break;
        end;

     result:=C.Name+#9+C.ClassName+#9+#9+tmp.ClassName;
   end;

   Procedure CheckHelpInList(C:TControl; Num:Integer);
   var s:String;
       tmp:String;
       t:Integer;
   begin
     tmp:=IntToStr(Num);
     for t:=0 to HelpIDList.Count-1 do
         if Trim(HelpIDList.ValueFromIndex[t])=tmp then exit;

     S:='BAD: '+GetTextToOutput(C);
     if MissingHelp.IndexOf(S)=-1 then
        MissingHelp.Add(S);
   end;

 var t : Integer;
     S : String;
     tmpHelp : Integer;
 begin
   with AControl do
   for t:=0 to ControlCount-1 do
      if Controls[t] is TWinControl then
      begin
         if TWinControl(Controls[t]).HelpContext=0 then { Missing Help Context number }
         begin
           if TWinControl(Controls[t]).Visible then
           if not (Controls[t] is TPanel) then
               if (Controls[t] is TButton) and (TButton(Controls[t]).Caption='OK') then
               else
               if (Controls[t] is TBitBtn) and (TBitBtn(Controls[t]).Caption='OK') then
               else
               if (Controls[t] is TButton) and (TButton(Controls[t]).Caption='Cancel') then
               else
               if (Controls[t] is TBitBtn) and (TBitBtn(Controls[t]).Caption='Cancel') then
               else
               if (Controls[t] is TRadioGroup) then
               else
               if (Controls[t] is TTabSheet) then
               else
               if (Controls[t] is TGroupBox) then
               else
               if (Controls[t].ClassName='TGroupButton') then
               else
               if (Controls[t].ClassName='TGalleryChart') then
               else
               if (Controls[t] is TPageControl) then
               else
               if (Controls[t] is TCustomForm) then
               else
               begin
                 S:=GetTextToOutput(Controls[t]);
                 if MissingHelp.IndexOf(S)=-1 then
                    MissingHelp.Add(S);
               end;
         end
         else
         begin
           tmpHelp:=TWinControl(Controls[t]).HelpContext;
           CheckHelpInList(Controls[t],tmpHelp);
           MaxHelpContext:=Math.Max(MaxHelpContext,tmpHelp);
         end;

         CheckHelpContext(Controls[t] as TWinControl);
      end
      else
      if Controls[t] is TLabel then
         if TLabel(Controls[t]).HelpContext<>0 then
              MissingHelp.Add('Wrong TLabel helpcontext (Delphi 4) '+GetTextToOutput(Controls[t]));

  end;
  {$ENDIF}

var t          : Integer;
    tt         : Integer;
    tmp        : Integer;
    s          : String;
    HotKeyList : String;
begin
  {$IFDEF TEEFINDMISSING}
  { internal use }
  CheckDuplicates;

  if Assigned(Missing) and (AControl is TWinControl) then
     CheckHelpContext(AControl as TWinControl);
  {$ENDIF}

  if Assigned(TeeLanguage)
     {$IFDEF TEEFINDMISSING}or Assigned(Extract){$ENDIF} then
  begin

    with TControlAccess(AControl) do
    begin
      {$IFDEF TEEFINDMISSING}
      CheckExtract(AControl,TControlAccess(AControl).Caption);
      {$ENDIF}
      s:=Caption;
      if TeeCanTranslate(s,HotKeyList) then Caption:=s;
    end;

    with AControl do
    for t:=0 to ComponentCount-1 do
    begin { traverse all Components, not only Controls }

      if Components[t] is TLabel then
      with TLabel(Components[t]) do
      begin
        {$IFDEF TEEFINDMISSING}
        CheckExtract(AControl.Components[t],Caption);
        {$ENDIF}
        s:=Caption;
        if TeeCanTranslate(s,HotKeyList) then
        begin
          Caption:=s;
          AutoSize:=True;
        end;
      end
      else
      if Components[t] is TComboBox then
      with TComboBox(Components[t]) do
      begin
        tmp:=ItemIndex;
        for tt:=0 to Items.Count-1 do
        begin
          {$IFDEF TEEFINDMISSING}
          CheckExtract(AControl.Components[t],Items[tt]);
          {$ENDIF}
          s:=Items[tt];
          if TeeCanTranslate(s,HotKeyList) then Items[tt]:=s;
        end;
        if ItemIndex<>tmp then ItemIndex:=tmp;
      end
      else
      if Components[t] is TListBox then
      with TListBox(Components[t]) do
      begin
        tmp:=ItemIndex;
        for tt:=0 to Items.Count-1 do
        begin
          {$IFDEF TEEFINDMISSING}
          CheckExtract(AControl.Components[t],Items[tt]);
          {$ENDIF}
          s:=Items[tt];
          if TeeCanTranslate(s,HotKeyList) then Items[tt]:=s;
        end;
        if ItemIndex<>tmp then ItemIndex:=tmp;
      end
      else
      if Components[t] is TRadioGroup then
      with TRadioGroup(Components[t]) do
      begin
        {$IFDEF TEEFINDMISSING}
        CheckExtract(AControl.Components[t],Caption);
        {$ENDIF}
        s:=Caption;
        if TeeCanTranslate(s,HotKeyList) then Caption:=s;
        for tt:=0 to Items.Count-1 do
        begin
          {$IFDEF TEEFINDMISSING}
          CheckExtract(AControl.Components[t],Items[tt]);
          {$ENDIF}
          s:=Items[tt];
          if TeeCanTranslate(s,HotKeyList) then Items[tt]:=s;
        end;
      end
      else
      if Components[t] is TPageControl then
      with TPageControl(Components[t]) do
      begin
        for tt:=0 to PageCount-1 do
        begin
          {$IFDEF TEEFINDMISSING}
          CheckExtract(AControl.Components[t],TTabSheet(Pages[tt]).Caption);
          {$ENDIF}
          s:=TTabSheet(Pages[tt]).Caption;
          if TeeCanTranslate(s,HotKeyList) then TTabSheet(Pages[tt]).Caption:=s;
        end;
      end
      else
      if Components[t] is TTabControl then
      with TTabControl(Components[t]) do
      begin
        for tt:=0 to Tabs.Count-1 do
        begin
          {$IFDEF TEEFINDMISSING}
          CheckExtract(AControl.Components[t],Tabs[tt]{$IFDEF CLX}.Caption{$ENDIF});
          {$ENDIF}
          s:=Tabs[tt]{$IFDEF CLX}.Caption{$ENDIF};
          if TeeCanTranslate(s,HotKeyList) then
             Tabs[tt]{$IFDEF CLX}.Caption{$ENDIF}:=s;
        end;
      end
      else
      if Components[t] is TMenuItem then
      with TMenuItem(Components[t]) do
      begin
        {$IFDEF TEEFINDMISSING}
        CheckExtract(AControl.Components[t],Caption);
        {$ENDIF}
        s:=Caption;
        if TeeCanTranslate(s,HotKeyList) then Caption:=s;
      end
      else
      { last option: TControl }
      if Components[t] is TControl then
      with TControlAccess(Components[t]) do
      begin
        {$IFDEF TEEFINDMISSING}
        CheckExtract(AControl.Components[t],Caption);
        {$ENDIF}
        s:=Caption;
        if TeeCanTranslate(s,HotKeyList) then Caption:=s;
      end;

      { Hints... }
      if AControl.Components[t] is TControl then
      with TControl(AControl.Components[t]) do
      begin
        {$IFDEF TEEFINDMISSING}
        if Hint<>'' then CheckExtract(AControl.Components[t],Hint);
        {$ENDIF}
        s:=Hint;
        if (s<>'') and TeeCanTranslate(s,HotKeyList) then Hint:=s;
      end;
    end;
  end;
end;

Const
  TeeRegistry_Language='Language'; { <-- do not translate }

Function TeeLanguageRegistry:Integer;
begin
  {$IFDEF LINUX}
  with TIniFile.Create(ExpandFileName('~/.teechart')) do
  try
    result:=ReadInteger('Editor',TeeRegistry_Language,-1);
  {$ELSE}
  result:=-1;
  With TRegistry.Create do
  try
    if OpenKey(TeeMsg_EditorKey,False) and
       ValueExists(TeeRegistry_Language) then
          result:=ReadInteger(TeeRegistry_Language);
  {$ENDIF}
  finally
    Free;
  end;
end;

Procedure TeeLanguageSaveRegistry(LanguageNum:Integer);
begin
  {$IFDEF LINUX}
  with TIniFile.Create(ExpandFileName('~/.teechart')) do
  try
    WriteInteger('Editor',TeeRegistry_Language,LanguageNum);
  {$ELSE}
  With TRegistry.Create do
  try
    if OpenKey(TeeMsg_EditorKey,True) then
       WriteInteger(TeeRegistry_Language,LanguageNum);
  {$ENDIF}
  finally
    Free;
  end;
end;

procedure TAskLanguage.FormCreate(Sender: TObject);
var t : Integer;
    i : Integer;
begin
  BorderStyle:=TeeBorderStyle;

  TeeTranslateControl(Self);

  { remove the item number, set to Objects[] array }
  with LBLangs do
  for t:=0 to Items.Count-1 do
  begin
    i:=Pos(',',Items[t]);
    if i>0 then
    begin
      Items.Objects[t]:=TObject(StrToInt(Copy(Items[t],i+1,255)));
      Items[t]:=Copy(Items[t],1,i-1);
    end;
  end;

  i:=TeeLanguageRegistry;

  { find language in list }
  LBLangs.ItemIndex:=-1;

  with LBLangs do
  for t:=0 to Items.Count-1 do
  if Integer(Items.Objects[t])=i then
  begin
    ItemIndex:=t;
    break;
  end;

  { not found, select default English language }
  if LBLangs.ItemIndex=-1 then
     if LBLangs.Items.Count>0 then LBLangs.ItemIndex:=0; { default = English }
end;

procedure TAskLanguage.OKBtnClick(Sender: TObject);
begin
  { store selected language in registry }
  TeeLanguageSaveRegistry(Integer(LBLangs.Items.Objects[LBLangs.ItemIndex]));
end;

procedure TAskLanguage.LBLangsDblClick(Sender: TObject);
begin
  OKBtnClick(Self);
  ModalResult:=mrOk;
end;

initialization
  TeeProcs.TeeTranslateHook:=TeeTranslate.TeeTranslateControl;
finalization
  TeeProcs.TeeTranslateHook:=nil;
end.
