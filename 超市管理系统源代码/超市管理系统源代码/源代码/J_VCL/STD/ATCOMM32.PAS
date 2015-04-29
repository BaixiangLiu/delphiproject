(**************************************************************
*                                                             *
* UNIT:         ATComm32                                      *
* DESCRIPTION:  Win95 serial port communications unit         *
* AUTHOR:       Mike Stahl, Applied Technology Consultants    *
* CONTACT:      mstahl@mars.execulink.com                     *
* VERSION:      1.1                                           *
*                                                             *
***************************************************************
*                                                             *
* History                                                     *
* Aug-13-1996  1.1  MMS  Bug fixes from original              *
* Aug-09-1996  1.0  MMS  Original                             *
*                                                             *
***************************************************************
*                                                             *
* Thanks to QCComm and CateTerm for the base & ideas          *
*                                                             *
* Please e-mail me your ideas for improvements!               *
*                                                             *
***************************************************************)

unit ATComm32;

interface

{ Units used by this unit }
uses
   Windows,
   Messages,
   SysUtils,
   Classes,
   Forms,
   ExtCtrls;

{ ComPort class }
type
   T_ATComm32 = class(TComponent)

{ Private declarations }
private

   { Handle of currently open port }
   int_PortHandle: LongInt;

   { Current port number }
   int_PortNumber : Integer;

   { Current baud rate }
   int_BaudRate: LongInt;

   { Current Data bits per byts }
   int_DataBits : ShortInt;

   { Current Stop bits per byte }
   int_StopBits : ShortInt;

   { Current Parity (No/Odd/Even/Mark/Space = 0-4) }
   byt_Parity : Byte;

   { Response terminator string }
   sInTerminator: String;

   { Set true when a timeout occurs }
   boo_TimerExpired: Boolean;

   { Timeout timer }
   tim_TimeoutTimer: TTimer;

   { Wait for the timer to time-out when polling for response }
   boo_WaitForResp : boolean;

   { True while port is blocked, waiting for response }
   boo_InUse: Boolean;

   { Events (method pointers) user can assign code to these }
   pmOnTimeout: TNotifyEvent;	{ timeout event }

   { Procedure to set the port number }
   procedure SetPort(int_PortNumberToSet: Integer);

   { Procedure to set the baud rate }
   procedure SetBaud(int_BaudRateToSet: LongInt);

   { Procedure to set the Data bits }
   procedure SetData(int_DataBitsToSet: ShortInt);

   { Procedure to set the stop bits }
   procedure SetStop(int_StopBitsToSet: ShortInt);

   { Procedure to set the Parity }
   procedure SetParity(byt_ParityToSet: Byte);

   { Procedure to set the Timeout event }
   procedure TimesUp(Sender: TObject);

   { Procedure to set the Timeout length }
   procedure SetTimeout(lTimeout: LongInt);

   { Function to return the number of character waiting in input buffer }
   function GetInCount: LongInt;

   { Function to get the default time in the Timeout counter }
   function GetTimeout: LongInt;


{ Protected declarations }
protected

   procedure Timeout; dynamic;


{ Public declarations }
public

	{ Create the class }
	constructor Create(AOwner: TComponent); override;

   { Destroy the class }
	destructor Destroy; override;

   { Open the comm port }
	function Open: Boolean;

   { flag indicating if port is open }
	function IsOpen: Boolean;

   { Write to the comm port }
   function Write(const sData: String): Boolean;

   { Read from the comm port }
   function Read: String;

   { Flush data in the comm port buffer }
	procedure Flush;

   { Close the comm port }
	procedure Close;



{ Published declarations }
published

		{ timeout for waiting for a response, in mS }
		property ResponseTime: LongInt read GetTimeout write SetTimeout;

		{ timeout event }
		property OnTimeout: TNotifyEvent read pmOnTimeout write pmOnTimeout;

		{ flag set when a timeout occured }
		property TimedOut: Boolean read boo_TimerExpired;

		{ baud rate }
		property Baud: LongInt read int_BaudRate write SetBaud;

		{ parity }
		property Parity: byte read byt_Parity write SetParity;

		{ COM port }
		property Port: Integer read int_PortNumber write SetPort;

		{ data bits }
		property DataBits: ShortInt read int_DataBits write SetData;

		{ baud rate }
		property StopBits: ShortInt read int_StopBits write SetStop;

		{ number of characters received }
		property InCount: LongInt read GetInCount;

		{ string to signal end of input from external device }
		property EndOfResponse: String read sInTerminator write sInTerminator;

      { flag to wait for timeout for any response - regardless of EndOfResponse string }
      property WaitForResponse: Boolean read boo_WaitForResp write boo_WaitForResp;

		{ flag indication if port is blocked }
		property InUse: Boolean read boo_InUse;
end;


procedure Register;

{*************************************************************************
*  IMPLEMENTATION                                                        *
*************************************************************************}

implementation



{------------------------------------------------------------------------------
Register the component with the Delphi IDE.  Place on page 'ATC'
}
procedure Register;
begin
	RegisterComponents('Custom', [T_ATComm32]);
end;



{------------------------------------------------------------------------------
Component constructor
}
constructor T_ATComm32.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);

     { set default property values }
     int_PortHandle := INVALID_HANDLE_VALUE; { invalidate to start }

     { Default port settings }
     int_BaudRate := 56000;
     int_DataBits := 8;
     int_StopBits := 1;
     byt_Parity := 0;

     { Dont wait for timeout regardless of EndOfResponse string }
     boo_WaitForResp := False;

     { Not expired }
     boo_TimerExpired := False;

     { Not in use }
     boo_InUse := False;

     { Terminator string }
     sInTerminator := '';

     { create a tim_TimeoutTimer for checking for timeout }
     tim_TimeoutTimer := TTimer.Create(Self);
     tim_TimeoutTimer.Enabled := False;
     tim_TimeoutTimer.Interval := 1000; { 1 second }
     tim_TimeoutTimer.OnTimer := TimesUp;

end;





{------------------------------------------------------------------------------
Component destructor
}
destructor T_ATComm32.Destroy;
begin

	{ deallocate the tim_TimeoutTimer }
	tim_TimeoutTimer.Free;
	tim_TimeoutTimer := nil;

	{ close the com port (if open) }
	Close;

	{ destroy ancestor class }
	inherited Destroy;
end;




{------------------------------------------------------------------------------
Set the Timeout property to the specified milliseconds
}
procedure T_ATComm32.SetTimeout(lTimeout: LongInt);
begin
	if Assigned(tim_TimeoutTimer) then tim_TimeoutTimer.Interval := lTimeout;
end;




{------------------------------------------------------------------------------
Get the current timeout setting
}
function T_ATComm32.GetTimeout: LongInt;
begin
	if Assigned(tim_TimeoutTimer)
  then Result := tim_TimeoutTimer.Interval
  else Result := 0;
end;




{------------------------------------------------------------------------------
Return True if port is open
}
function T_ATComm32.IsOpen: Boolean;
begin
   Result := (int_PortHandle <> INVALID_HANDLE_VALUE);
end;




{------------------------------------------------------------------------------
Set the baud rate property
}
procedure T_ATComm32.SetBaud(int_BaudRateToSet: LongInt);
begin
  if int_BaudRateToSet <> int_BaudRate then
  begin
	   int_BaudRate := int_BaudRateToSet;

		{ if port is open, then close it and then reopen it
		to reset the baud rate }
		if IsOpen then
		begin
			Close;
			Open;
		end;
	end;
end;




{------------------------------------------------------------------------------
Set the data bits property
}
procedure T_ATComm32.SetData(int_DataBitsToSet: ShortInt);
begin
  if int_DataBitsToSet <> int_DataBits then
  begin
	   int_DataBits := int_DataBitsToSet;

		{ if port is open, then close it and then reopen it
		to reset the baud rate }
		if IsOpen then
		begin
			Close;
			Open;
		end;
	end;
end;



{------------------------------------------------------------------------------
Set the Stop bits property
}
procedure T_ATComm32.SetStop(int_StopBitsToSet: ShortInt);
begin
  if int_StopBitsToSet <> int_StopBits then
  begin
	   int_StopBits := int_StopBitsToSet;

		{ if port is open, then close it and then reopen it
		to reset the baud rate }
		if IsOpen then
		begin
			Close;
			Open;
		end;
	end;
end;




{------------------------------------------------------------------------------
Set the parity property
}
procedure T_ATComm32.SetParity(byt_ParityToSet: Byte);
begin
  if byt_ParityToSet <> byt_Parity then
  begin
	   byt_Parity := byt_ParityToSet;

		{ if port is open, then close it and then reopen it
		to reset the baud rate }
		if IsOpen then
		begin
			Close;
			Open;
		end;
	end;
end;






{------------------------------------------------------------------------------
Set the Port property
}
procedure T_ATComm32.SetPort(int_PortNumberToSet: Integer);
begin

  { If changing the port }
	if int_PortNumberToSet <> int_PortNumber then
  begin
  	int_PortNumber := int_PortNumberToSet;
		{ if port was open, then close and reopen it}
		if int_PortHandle <> INVALID_HANDLE_VALUE then
		begin
			Close;
			Open;
		end;
	 end;
end;





{------------------------------------------------------------------------------
Opens the COM port, returns True if ok
}
function T_ATComm32.Open: Boolean;
var
	str_Com: String;
	dcbPort: TDCB; {device control block }

begin

	{ close port if open already }
	if int_PortHandle <> INVALID_HANDLE_VALUE then Close;

   { try to open the port }
  	str_Com := 'COM' + IntToStr(int_PortNumber);
   int_PortHandle := CreateFile(PChar(str_Com),
      GENERIC_READ or GENERIC_WRITE,
      0,
      nil,
      OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL,
      LongInt(0));

	{ If created stream ok, set the baud rate and other parameters }
	if (int_PortHandle <> INVALID_HANDLE_VALUE) then
	begin
		if GetCommState(int_PortHandle, dcbPort) then
		begin
			{ fill in the fields of the structure }
			dcbPort.BaudRate := int_BaudRate;
			dcbPort.ByteSize := int_DataBits;
			dcbPort.Parity := byt_Parity;
			dcbPort.StopBits := int_StopBits;
			dcbPort.Flags := 0;

			{ UNSUPPORTED flag bit fields:
			dcb_Binary, dcb_Parity, dcb_OutxCtsFlow, dcb_fOutxDsrFlow,
			dcb_fOutX, dcb_fInX, dcb_DtrFlow, dcb_RtsFlow
			}

			SetCommState(int_PortHandle, dcbPort);
		end;
	end;

	{ return True if handle is valid }
	Result := (int_PortHandle <> INVALID_HANDLE_VALUE);

end;




{------------------------------------------------------------------------------
Close the COM port
}
procedure T_ATComm32.Close;
begin
	if int_PortHandle <> INVALID_HANDLE_VALUE
   then begin
      CloseHandle(int_PortHandle);
    	int_PortHandle := INVALID_HANDLE_VALUE;
  end;
end;





{------------------------------------------------------------------------------
Write a string out the COM port, return true if all chars written
}
function T_ATComm32.Write(const sData: String): Boolean;
var
	dwCharsWritten: DWord;

begin
	Result := False; { default to error return }

	if int_PortHandle <> INVALID_HANDLE_VALUE then
	begin
     	dwCharsWritten := 0;
		WriteFile(int_PortHandle, PChar(sData)^, Length(sData), dwCharsWritten, nil);
		if dwCharsWritten = Length(sData) then Result := True;
	end;
end;



{------------------------------------------------------------------------------
Return the number of bytes waiting in the queue
}
function T_ATComm32.GetInCount: LongInt;
var
	statPort: TCOMSTAT;
	dwErrorCode: DWord;
begin
	Result := 0;

	if int_PortHandle <> INVALID_HANDLE_VALUE then
	 begin
		ClearCommError(int_PortHandle, dwErrorCode, @statPort);
		Result := statPort.cbInQue;
	 end;
end;




{------------------------------------------------------------------------------
Reads a string from the port, puts it into pchBuffer, returns the
number of characters read
}
function T_ATComm32.Read: String;
const
	BUF_LEN = 1024;

var
	cbCharsAvailable, cbCharsRead: DWord;
	boo_FoundTerm: Boolean;
	sBuffer: String;

begin
	Result := '';

  { check boo_InUse in case of rentrancy }
	if not boo_InUse then
   begin

		boo_InUse := True;

		if int_PortHandle <> INVALID_HANDLE_VALUE then
		begin

			{ if no terminator is defined, simply read any available data and return }
			if (Length(sInTerminator) = 0) AND (NOT boo_WaitForResp) then
			begin
				cbCharsAvailable := GetInCount;
				if cbCharsAvailable > 0 then
				begin
					SetLength(sBuffer, cbCharsAvailable + 1); { allocate space }
					ReadFile(int_PortHandle, PChar(sBuffer)^, cbCharsAvailable, cbCharsRead, nil);
					SetLength(sBuffer, cbCharsRead); { adjust length }
               Result := sBuffer;
				end;
			end
   		else { a terminator is defined, so read port until terminator found or timed out }
	   	begin
		   	boo_FoundTerm := False;
			   boo_TimerExpired := False;
  				tim_TimeoutTimer.Enabled := True;	{ start the timeout tim_TimeoutTimer }

   			{ loop until timeout or terminator recieved }
	   		repeat
					{ give tim_TimeoutTimer message a chance to occur}
  					Application.ProcessMessages;
		   		cbCharsAvailable := GetInCount;

			   	if cbCharsAvailable > 0 then
				   begin
  						if cbCharsAvailable >= Length(sBuffer)
                  then SetLength(sBuffer, cbCharsAvailable + 1); { allocate space }

                  { Read what's waiting at the port }
	   				ReadFile(int_PortHandle, PChar(sBuffer)^, cbCharsAvailable, cbCharsRead, nil);

		   			{ append chars read to end of result buffer }
			   		Result := Result + Copy(sBuffer, 0, StrLen(PChar(sBuffer)));

     					if (Pos(sInTerminator, Result) <> 0) and (Length(sInTerminator) = 0) then
      				begin
	      				boo_FoundTerm := True;
		      		end
      			end;
		   	until (boo_TimerExpired) or (boo_FoundTerm);
            tim_TimeoutTimer.Enabled := False;
	   	end;
      end;
     	boo_InUse := False;
	end;
end;




{------------------------------------------------------------------------------
tim_TimeoutTimer procedure - signals a timeout
}
procedure T_ATComm32.TimesUp(Sender: TObject);
begin
	boo_TimerExpired := True;
	tim_TimeoutTimer.Enabled := False;
	Timeout; // execute user code
end;



{------------------------------------------------------------------------------
Timeout event - user assigned code
}
procedure T_ATComm32.Timeout;
begin
	{ if user has assigned code to the timeout event, then call it }
	if Assigned(pmOnTimeout) then pmOnTimeout(self);
end;




{------------------------------------------------------------------------------
Flush the port by reading any characters in the queue
}
procedure T_ATComm32.Flush;
begin
	if int_PortHandle <> INVALID_HANDLE_VALUE then
	begin
		PurgeComm(int_PortHandle,
        PURGE_TXABORT or
        PURGE_RXABORT or
        PURGE_TXCLEAR or
        PURGE_RXCLEAR);
	end;
end;

end.
