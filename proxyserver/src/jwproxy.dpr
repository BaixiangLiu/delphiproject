program jwproxy;

uses
    Forms,
    main in 'main.pas' {Form1};

{$R *.RES}

begin
    Application.Initialize;
    Application.Title := '零和代理服务器';
    Application.CreateForm(TForm1, Form1);
    Application.Run;
end.

