program Project1;

uses
  Forms,
  unit_main in 'unit_main.pas' {frm_main},
  unit_register in 'unit_register.pas' {frm_register},
  unit_query in 'unit_query.pas' {frm_query},
  unit_reporter in 'unit_reporter.pas' {frm_reporter},
  unit_counter in 'unit_counter.pas' {frm_counter};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '三所固定资产管理系统';
  Application.CreateForm(Tfrm_main, frm_main);
  
  Application.CreateForm(Tfrm_register, frm_register);
  Application.CreateForm(Tfrm_query, frm_query);
  Application.CreateForm(Tfrm_reporter, frm_reporter);
  Application.CreateForm(Tfrm_counter, frm_counter);
  Application.Run;
end.
