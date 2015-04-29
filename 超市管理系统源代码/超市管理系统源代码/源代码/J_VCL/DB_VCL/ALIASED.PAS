//  Filename: AliasEd.pas
//  Version : 01.02
//  Date    : 29/03/97
//  Author  : Glenn Davies
//
//  Description:
//    BDE alias management component.
//
//  History:
//    14/06/97 - V01.03
//      Revised for compatibility with Delphi 3.
//    29/03/97 - V01.02
//      Added GetDriverList and GetDriverParams methods for completeness.
//    30/05/96 - V01.01
//      Now uses methods and properties of Session rather than BDE functions.
//      As a result, most methods are now procedures which raise exceptions if
//      an error occurs rather than Boolean functions. Methods now accept
//      TStrings objects as parameters rather than only TStringList objects.
//    16/05/96 - V01.00
//      Initial version.

unit AliasEd;

interface

uses
  SysUtils, Classes, DBTables;

//------------------------------------------------------------------------------

type

  {TAliasEditor class declaration}

  TAliasEditor = class(TComponent)
  private
    fParams: TStringList;
    fConfigMode: TConfigMode;
    fOldConfigMode: TConfigMode;
  protected
    procedure InitBDE;
    procedure RestoreConfigMode;
    procedure SetConfigMode;
  public
    constructor Create(owner: TComponent); override;
    destructor Destroy; override;
    procedure Add(const alias, driver: String; the_params: TStrings);
    procedure Delete(const alias: String);
    function Exists(const alias: String): Boolean;
    procedure Modify(const alias: String; the_params: TStrings);
    procedure GetAliasList(the_params: TStrings);
    function GetDriver(const alias: String): String;
    procedure GetDriverParams(const driver_name: String; the_params: TStrings);
    procedure GetDriverList(the_params: TStrings);
    procedure GetParams(const alias: String; the_params: TStrings);
    function GetPath(const alias: String): String;
    function GetType(const alias: String): String;
    property Params: TStringList read fParams write fParams;
  published
    property ConfigMode: TConfigMode read fConfigMode write fConfigMode default [cfmPersistent];
  end;

//------------------------------------------------------------------------------

procedure Register;

//------------------------------------------------------------------------------

implementation

//------------------------------------------------------------------------------

{TAliasEditor class implementation}

//------------------------------------------------------------------------------

procedure TAliasEditor.InitBDE;
begin
  if not(Session.Active) then
    Session.Active := True;
end;

//------------------------------------------------------------------------------

procedure TAliasEditor.RestoreConfigMode;
begin
  Session.ConfigMode := fOldConfigMode;
end;

//------------------------------------------------------------------------------

procedure TAliasEditor.SetConfigMode;
begin
  fOldConfigMode := Session.ConfigMode;
  Session.ConfigMode := fConfigMode;
end;

//------------------------------------------------------------------------------

constructor TAliasEditor.Create(owner: TComponent);
begin
  inherited Create(owner);
  fParams := TStringList.Create;
  fConfigMode := [cfmPersistent];
end;

//------------------------------------------------------------------------------

destructor TAliasEditor.Destroy;
begin
  fParams.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

//  Add a new alias.

procedure TAliasEditor.Add(const alias, driver: String; the_params: TStrings);
begin
  InitBDE;
  SetConfigMode;
  try
    Session.AddAlias(alias, driver, the_params);
    Session.SaveConfigFile;
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Delete an existing alias.

procedure TAliasEditor.Delete(const alias: String);
begin
  InitBDE;
  SetConfigMode;
  try
    Session.DeleteAlias(alias);
    Session.SaveConfigFile;
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Check if an alias exists.

function TAliasEditor.Exists(const alias: String): Boolean;
begin
  result := False;
  InitBDE;
  SetConfigMode;
  try
    result := Session.IsAlias(alias);
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Modify an existing alias.

procedure TAliasEditor.Modify(const alias: String; the_params: TStrings);
begin
  InitBDE;
  SetConfigMode;
  try
    Session.ModifyAlias(alias, the_params);
    Session.SaveConfigFile;
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Get a list of available aliases.

procedure TAliasEditor.GetAliasList(the_params: TStrings);
begin
  InitBDE;
  SetConfigMode;
  try
    Session.GetAliasNames(the_params);
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Get the driver name for an alias.

function TAliasEditor.GetDriver(const alias: String): String;
begin
  InitBDE;
  SetConfigMode;
  try
    result := Session.GetAliasDriverName(alias);
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Get the default parameters for specified driver

procedure TAliasEditor.GetDriverParams(const driver_name: String; the_params: TStrings);
begin
  InitBDE;
  Session.GetDriverParams(driver_name,the_params);
end;

//------------------------------------------------------------------------------

//  Get a list of currently installed drivers

procedure TAliasEditor.GetDriverList(the_params: TStrings);
begin
  InitBDE;
  Session.GetDriverNames(the_params);
end;

//------------------------------------------------------------------------------

//  Get the parameters for an alias.

procedure TAliasEditor.GetParams(const alias: String; the_params: TStrings);
begin
  InitBDE;
  SetConfigMode;
  try
    Session.GetAliasParams(alias, the_params);
  finally
    RestoreConfigMode;
  end;
end;

//------------------------------------------------------------------------------

//  Get the path for an alias.

function TAliasEditor.GetPath(const alias: String): String;
var
  the_params: TStringList;
begin
  the_params := TStringList.Create;
  try
    GetParams(alias,the_params);
    result := the_params.Values['PATH'];
  finally
    the_params.Free;
  end;
end;

//------------------------------------------------------------------------------

//  Get the type of an alias.

function TAliasEditor.GetType(const alias: String): String;
var
  the_params: TStringList;
begin
  the_params := TStringList.Create;
  try
    GetParams(alias,the_params);
    result := the_params.Values['TYPE'];
  finally
    the_params.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('J_STD', [TAliasEditor]);
end;

//------------------------------------------------------------------------------

end.
