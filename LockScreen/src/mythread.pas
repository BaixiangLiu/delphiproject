unit mythread;

interface

uses
    Classes, Sysutils, MMSystem, Forms;

type
    TVoiceRemindThread = class(TThread)
    private

    protected
        procedure Execute; override;

    end;


implementation



uses tx;



procedure TVoiceRemindThread.Execute;
var
    FilePath: string;
begin
    FilePath := ExtractFilePath(ParamStr(0)) + '\..\data\REC001.WAV';
    playsound(PChar(FilePath), 0, SND_FILENAME);
end;



end.

