unit global;

interface
uses adodb;

function queryopen(query:Tadoquery;querystr:string):boolean;
function queryexec(query:Tadoquery;querystr:string):boolean;

const
  DATETIMENULL :Tdatetime=-700000;
var
  tempquery1:Tadoquery;
  tempquery2:Tadoquery;
  tempquery3:Tadoquery;
  inipath:string;
implementation

function queryopen(query:Tadoquery;querystr:string):boolean;
begin
  query.close;
  query.SQL.Clear;
  query.SQL.Text:=querystr;
  try
  query.open;
  result:=true;
  except
  result:=false;
  end;
end;

function queryexec(query:Tadoquery;querystr:string):boolean;
begin
  query.close;
  query.SQL.Clear;
  query.SQL.Text:=querystr;
  try
  query.ExecSQL;
  result:=true;
  except
  result:=false;
  end;
end;


end.
