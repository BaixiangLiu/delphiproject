unit main;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    RXShell, Menus, StdCtrls, ExtCtrls, ScktComp, IniFiles, ComCtrls;
type
    session_record = record
        Used: boolean;
        SS_Handle: integer;
        CSocket: Tclientsocket;
        Lookingup: boolean;
        LookupTime: integer;
        Request: boolean;
        request_str: string;
        client_connected: boolean;
        remote_connected: boolean;
    end;
type
    TForm1 = class(TForm)
        ServerSocket1: TServerSocket;
        ClientSocket1: TClientSocket;
        Timer1: TTimer;
        Memo1: TMemo;
        PopupMenu1: TPopupMenu;
        menuopen: TMenuItem;
        menuclose: TMenuItem;
        N1: TMenuItem;
        N2: TMenuItem;
        RxTrayIcon1: TRxTrayIcon;
        N3: TMenuItem;
        N4: TMenuItem;
        btopen: TButton;
        btclose: TButton;
        Button3: TButton;
        bthide: TButton;
        menuhide: TMenuItem;
        Panel1: TPanel;
        StatusBar1: TStatusBar;
        Panel2: TPanel;
        procedure AppException(sender: TObject; e: Exception);
        procedure menuopenClick(Sender: TObject);
        procedure menucloseClick(Sender: TObject);
        procedure menuexit(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure ServerSocket1Listen(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ServerSocket1ClientConnect(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ServerSocket1ClientDisconnect(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ServerSocket1ClientError(Sender: TObject;
            Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
            var ErrorCode: Integer);
        procedure ServerSocket1ClientRead(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ClientSocket1Connect(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ClientSocket1Disconnect(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
            ErrorEvent: TErrorEvent; var ErrorCode: Integer);
        procedure ClientSocket1Write(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
        procedure Timer1Timer(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure RxTrayIcon1Click(Sender: TObject; Button: TMouseButton;
            Shift: TShiftState; X, Y: Integer);
        procedure ClientSocket1Lookup(Sender: TObject;
            Socket: TCustomWinSocket);
        procedure bthideClick(Sender: TObject);
        procedure menuhideClick(Sender: TObject);
        procedure Timer2Timer(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure ClientSocket1Connecting(Sender: TObject;
            Socket: TCustomWinSocket);
    private
        { Private declarations }
    public
        Server_Enabled: boolean;
        session: array of session_record;
        sessions: integer;
        LookupTimeOut: integer;
        InvalidRequests: integer;
    end;

var
    Form1: TForm1;
    iniConfig: TInifile;

implementation

{$R *.DFM}

procedure TForm1.AppException(sender: TObject; E: Exception);
begin
    //
end;

procedure TForm1.menuopenClick(Sender: TObject);
begin
    serversocket1.active := true;
end;

procedure TForm1.menucloseClick(Sender: TObject);
begin
    serversocket1.Active := false;
    server_enabled := false;
    menuopen.Enabled := true;
    btopen.Enabled := true;
    menuclose.Enabled := false;
    btclose.Enabled := false;
end;

procedure TForm1.menuexit(Sender: TObject);
begin
    application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
    proxyPort: integer;
begin
    if iniConfig = nil then
        iniConfig := TInifile.Create(ExtractFilePath(paramstr(0)) + '..\config\app.ini');

    proxyPort := iniConfig.ReadInteger('app', 'Port', 8087);
    server_enabled := false;
    sessions := 0;
    invalidrequests := 0;
    LookupTimeOut := iniConfig.ReadInteger('app', 'TimeOut', 60000);
    timer1.Enabled := true;
    menuopen.Enabled := false;
    btopen.Enabled := false;
    menuclose.Enabled := true;
    btclose.Enabled := true;
    serversocket1.Port := proxyPort;
    serversocket1.Active := true;
    //application.OnActionExecute   :=appexception;

    StatusBar1.Panels[3].Text := intToStr(proxyPort);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    timer1.Enabled := false;
    if server_enabled then serversocket1.Active := false;
end;

procedure TForm1.ServerSocket1Listen(Sender: TObject;
    Socket: TCustomWinSocket);
begin
    server_enabled := true;
    menuopen.Enabled := false;
    btopen.Enabled := false;
    menuclose.Enabled := true;
    btclose.Enabled := true;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
    Socket: TCustomWinSocket);
var i, j: integer;
begin
    j := -1;
    for i := 1 to sessions do
        if not session[i - 1].Used and not session[i - 1].CSocket.active then begin
            j := i - 1;
            session[j].Used := true;
            break;
        end
        else
            if not session[i - 1].Used and session[i - 1].CSocket.active then session[j].CSocket.active := false;
    if j = -1 then begin
        j := sessions;
        inc(sessions);
        setlength(session, sessions);
        session[j].Used := true;
        session[j].CSocket := Tclientsocket.Create(nil);
        session[j].CSocket.onconnect := clientsocket1connect;
        session[j].CSocket.ondisconnect := clientsocket1disconnect;
        session[j].CSocket.onerror := clientsocket1error;
        session[j].CSocket.onread := clientsocket1read;
        session[j].CSocket.onwrite := clientsocket1write;
        session[j].CSocket.onlookup := clientsocket1lookup;
        session[j].CSocket.onconnecting := clientsocket1connecting;
        session[j].lookingup := false;
    end;
    session[j].SS_Handle := socket.SocketHandle;
    session[j].Request := false;
    session[j].client_connected := true;
    session[j].remote_connected := false;
    StatusBar1.Panels[1].Text := inttostr(sessions);
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
    Socket: TCustomWinSocket);
var i, j, k: integer;
begin
    for i := 1 to sessions do
        if (session[i - 1].SS_Handle = socket.sockethandle) and session[i - 1].Used then begin
            session[i - 1].client_connected := false;
            if session[i - 1].remote_connected then
                session[i - 1].CSocket.active := false
            else
                session[i - 1].Used := false;
            break;
        end;
    j := sessions;
    k := 0;
    for i := 1 to j do begin
        if session[j - i].Used then break;
        inc(k);
    end;
    if k > 0 then begin
        sessions := sessions - k;
        setlength(session, sessions);
    end;
    StatusBar1.Panels[1].Text := inttostr(sessions);
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
    Socket: TCustomWinSocket);
var i: integer;
begin
    for i := 1 to sessions do
        if (session[i - 1].Csocket.socket.sockethandle = socket.SocketHandle) and session[i - 1].Used then begin
            session[i - 1].CSocket.tag := socket.sockethandle;
            session[i - 1].remote_connected := true;
            session[i - 1].Lookingup := false;
            break;
        end;
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
    Socket: TCustomWinSocket);
var
    i, j, k: integer;
begin
    for i := 1 to sessions do
        if (session[i - 1].CSocket.tag = socket.SocketHandle) and session[i - 1].Used then begin
            session[i - 1].remote_connected := false;
            if not session[i - 1].client_connected then
                session[i - 1].Used := false
            else
                for k := 1 to serversocket1.Socket.ActiveConnections do
                    if (serversocket1.Socket.Connections[k - 1].SocketHandle = session[i - 1].SS_Handle) and session[i - 1].Used then begin
                        serversocket1.Socket.Connections[k - 1].Close;
                        break;
                    end;
            break;
        end;
    j := sessions;
    k := 0;
    for i := 1 to j do begin
        if session[j - i].Used then
            break;
        inc(k);
    end;
    if k > 0 then begin
        sessions := sessions - k;
        setlength(session, sessions);
    end;
    StatusBar1.Panels[1].Text := inttostr(sessions);
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
    Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
    var ErrorCode: Integer);
var
    i, j, k: integer;
begin
    for i := 1 to sessions do
        if (session[i - 1].CSocket.tag = socket.SocketHandle) and session[i - 1].Used then begin
            socket.Close;
            session[i - 1].remote_connected := false;
            if not session[i - 1].client_connected then
                session[i - 1].Used := false
            else
                for k := 1 to serversocket1.Socket.ActiveConnections do
                    if (serversocket1.Socket.Connections[k - 1].SocketHandle = session[i - 1].SS_Handle) and session[i - 1].Used then begin
                        serversocket1.Socket.Connections[k - 1].Close;
                        break;
                    end;
            break;
        end;
    j := sessions;
    k := 0;
    for i := 1 to j do begin
        if session[j - i].Used then
            break;
        inc(k);
    end;
    errorcode := 0;
    if k > 0 then begin
        sessions := sessions - k;
        setlength(session, sessions);
    end;
    StatusBar1.Panels[1].Text := inttostr(sessions);
end;

procedure TForm1.ClientSocket1Write(Sender: TObject;
    Socket: TCustomWinSocket);
var i: integer;
begin
    for i := 1 to sessions do
        if (session[i - 1].CSocket.tag = socket.SocketHandle) and session[i - 1].Used then begin
            if session[i - 1].Request then begin
                socket.SendText(session[i - 1].request_str);
                session[i - 1].Request := false;
            end;
            break;
        end;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
    Socket: TCustomWinSocket);
var
    i, j, rec_bytes: integer;
    rec_buffer: array[0..2047] of char;
begin
    for i := 1 to sessions do
        if (session[i - 1].CSocket.tag = socket.SocketHandle) and session[i - 1].used then begin
            rec_bytes := socket.ReceiveBuf(rec_buffer, 2048);
            for j := 1 to serversocket1.Socket.ActiveConnections do
                if serversocket1.Socket.Connections[j - 1].SocketHandle = session[i - 1].SS_Handle then begin
                    serversocket1.Socket.Connections[j - 1].SendBuf(rec_buffer, rec_bytes);
                    break;
                end;
            break;
        end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
    i, j: integer;
begin
    for i := 1 to sessions do
        if session[i - 1].Used and session[i - 1].Lookingup then begin
            inc(session[i - 1].LookupTime);
            if session[i - 1].LookupTime > lookuptimeout then begin
                session[i - 1].Lookingup := false;
                session[i - 1].CSocket.active := false;
                for j := 1 to serversocket1.socket.activeconnections do
                    if serversocket1.Socket.Connections[j - 1].sockethandle = session[i - 1].ss_handle then begin
                        serversocket1.socket.connections[j - 1].close;
                        break;
                    end;
            end;
        end;

end;


procedure TForm1.ServerSocket1ClientError(Sender: TObject;
    Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
    var ErrorCode: Integer);
var i, j, k: integer;
begin
    for i := 1 to sessions do
        if (session[i - 1].SS_Handle = socket.sockethandle) and session[i - 1].Used then begin
            session[i - 1].client_connected := false;
            if session[i - 1].remote_connected then
                session[i - 1].CSocket.active := false
            else
                session[i - 1].Used := false;
            break;
        end;
    j := sessions;
    k := 0;
    for i := 1 to j do begin
        if session[j - i].Used then
            break;
        inc(k);
    end;
    if k > 0 then begin
        sessions := sessions - k;
        setlength(session, sessions);
    end;
    StatusBar1.Panels[1].Text := inttostr(sessions);
    errorcode := 0;
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
    Socket: TCustomWinSocket);
var
    tmp, line, host: string;
    i, j, port: integer;
begin
    for i := 1 to sessions do
        if session[i - 1].Used and (session[i - 1].SS_Handle = socket.sockethandle) then begin
            session[i - 1].request_str := socket.receivetext;
            tmp := session[i - 1].request_str;
            memo1.lines.add(tmp);
            j := pos(char(13) + char(10), tmp);
            while j > 0 do begin
                line := copy(tmp, 1, j - 1);
                delete(tmp, 1, j + 1);
                j := pos('Host', line);
                if j > 0 then begin
                    delete(line, 1, j + 5);
                    j := pos(':', line);
                    if j > 0 then begin
                        host := copy(line, 1, j - 1);
                        delete(line, 1, j - 1);
                        try
                            port := strtoint(line);
                        except
                            port := 80
                        end;
                    end
                    else begin
                        host := trim(line);
                        port := 80;
                    end;
                    if not session[i - 1].remote_connected then begin
                        session[i - 1].request := true;
                        session[i - 1].CSocket.host := host;
                        session[i - 1].CSocket.port := port;
                        session[i - 1].CSocket.active := true;
                        session[i - 1].lookingup := true;
                        session[i - 1].lookuptime := 0;
                    end
                    else
                        session[i - 1].Csocket.socket.sendtext(session[i - 1].request_str);
                    break;
                end;
                j := pos(char(13) + char(10), tmp);
            end;
            break;
        end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
    form1.Show;
end;

procedure TForm1.RxTrayIcon1Click(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
    form1.Show;
end;

procedure TForm1.ClientSocket1Lookup(Sender: TObject;
    Socket: TCustomWinSocket);
begin
    //
end;

procedure TForm1.bthideClick(Sender: TObject);
begin
    form1.Hide;
end;

procedure TForm1.menuhideClick(Sender: TObject);
begin
    form1.Hide;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
    if form1.WindowState = wsminimized then showmessage('aaaa');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    form1.WindowState := wsminimized;
end;

procedure TForm1.ClientSocket1Connecting(Sender: TObject;
    Socket: TCustomWinSocket);
begin
    //
end;

end.

