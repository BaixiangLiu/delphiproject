unit clientappfunction;

interface
uses Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, dxDBGrid,
  Dialogs, DB, DBCtrls, dxDBELib, StdCtrls, dxDBTLCL, dxDBCtrl, dxEdLib
  ,dxTL, Graphics,StrUtils,dxDBTL;
function getstatuslist(classname:string;Sender:Tobject):boolean;
function getparamlist(FieldName:string;ClassName:string;Sender:Tobject):boolean;

implementation
uses eseatclasses,global;

function getparamlist(FieldName:string;ClassName:string;Sender:Tobject):boolean;
var
  paramlist:Tparamlist;
  range:string;
  l_StringList,l_Descriptions:Tstrings;
begin
  result:=false;
  paramlist:=Tparamlist.Create(nil);
  range:='class_id='+quotedstr(classname);
  paramlist.GetData(range,tempquery1);
  if not (sender is TCustomdxDBTreeListControl) then  exit;
  if not (( sender as TCustomdxDBTreeListControl ).ColumnByFieldName(FieldName) is TdxDBTreeListimageColumn) then exit;
  try
   l_StringList:=(( sender as TCustomdxDBTreeListControl ).ColumnByFieldName(FieldName) as TdxDBTreeListimageColumn).Values;
   l_Descriptions:=(( sender as TCustomdxDBTreeListControl ).ColumnByFieldName(FieldName) as TdxDBTreeListimageColumn).Descriptions;
  except
    exit;
  end;

  l_StringList.Clear;
  tempquery1.First;
  while not  tempquery1.Eof do
  with tempquery1 do
  begin
    l_StringList.Add(fieldbyname('param_id').AsString);
   // if (sender is TdxDBImageEdit) then
    l_Descriptions.Add(fieldbyname('param_name').AsString);
    next;
  end;
  result:=true;
end;

function getstatuslist(classname:string;Sender:Tobject):boolean;
var
  paramlist:Tparamlist;
  range:string;
  l_StringList,l_Descriptions:Tstrings;
begin
  result:=false;
  paramlist:=Tparamlist.Create(nil);
  range:='class_id='+quotedstr(classname);
  paramlist.GetData(range,tempquery1);

 if (sender is TdxDBImageEdit) then
 begin
    l_StringList:=(sender as TdxDBImageEdit).Values;
    l_Descriptions:= (sender as TdxDBImageEdit).Descriptions;
    l_Descriptions.Clear;
 end;

 if (sender is TdxImageEdit) then
 begin
    l_StringList:=(sender as TdxImageEdit).Values;
    l_Descriptions:= (sender as TdxImageEdit).Descriptions;
    l_Descriptions.Clear;
 end;
 {
 if (( sender as TCustomdxDBTreeListControl ).ColumnByFieldName('tabletype') is TdxDBTreeListPickColumn) then
 begin
   l_StringList:=(( sender as TCustomdxDBTreeListControl ).ColumnByFieldName('param_name') as TdxDBTreeListPickColumn).Items;
   l_Descriptions:=(( sender as TCustomdxDBTreeListControl ).ColumnByFieldName('param_name') as TdxDBTreeListPickColumn).Items;
   l_Descriptions.Clear;
 end;
 }
  l_StringList.Clear;
  tempquery1.First;
  while not  tempquery1.Eof do
  with tempquery1 do
  begin
    l_StringList.add(fieldbyname('param_id').AsString);
    l_Descriptions.add(fieldbyname('param_name').asstring);
    next;
  end;
  result:=true;
end;


end.
