program ProtectingEyes;

uses
    Forms,
    windows,
    main in '..\src\main.pas' {frmmain},
    tx in '..\src\tx.pas' {frmtx},
    mythread in '..\src\mythread.pas';

var
    Mutex: THandle;

{$R *.res}

begin
    Mutex := CreateMutex(nil, False, '保护视力专用软件 V1.0');
    if GetLastError <> ERROR_ALREADY_EXISTS then begin
        Application.Initialize;
        Application.Title := '保护视力专用软件';
        Application.CreateForm(Tfrmmain, frmmain);
        Application.ShowMainForm := false;
        Application.Run;


    end

    else
        Application.MessageBox('应用程序已经运行,请勿运行程序的多个副本！', '警告', mb_ok + mb_iconwarning);
    ReleaseMutex(Mutex);

end.

