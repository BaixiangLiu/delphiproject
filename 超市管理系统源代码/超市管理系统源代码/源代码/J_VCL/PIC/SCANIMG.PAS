(********************************************************************
   Image scanning component using EZTW32.DLL     

                     1998. 3. 2. SungKee-Min.   
                     South Korea.
*********************************************************************

!! Very simple, and very easy to use!!

Property
  ScanedImage : TImage.  // Containing scaned image component as bitmap.

Method
  SelectImageSource(Hwnd : THandle) // Popup the select source window.
  AcqureScanner(Hwnd : THandle)     // Acqure Scanner method

%% Caution %%
  You must call the SelectImageSource() method before use AcqureScanner().
  Also you should include EzTw32.dll file with your application.

********************************************************************)



unit ScanImg;

interface

uses
  Windows, Messages, Classes, extctrls, ClipBrd;

type
  TScanImage = class(TComponent)
  private
    { Private declarations }
    FImage : TImage;
  protected
    { Protected declarations }
    procedure SetImage (Value : TImage);
    procedure Notification(AComponent: TComponent;
        Operation: TOperation); override;
  public
    { Public declarations }
    procedure SelectImageSource(Hwnd : THandle);
    procedure AcqureScanner(Hwnd : THandle);
  published
    { Published declarations }
    property ScanedImage : TImage read FImage write SetImage;
  end;

procedure Register;

implementation

const
     TWAIN_BW=1;      { 1-bit per pixel, B&W      (== TWPT_BW) }
     TWAIN_GRAY=4;    { 1,4, or 8-bit grayscale  (== TWPT_GRAY) }
     TWAIN_RGB=4;     { 24-bit RGB color         (== TWPT_RGB) }
     TWAIN_PALETTE=8; { 1,4, or 8-bit palette    (== TWPT_PALETTE) }
     TWAIN_ANYTYPE=0; { any of the above }

(*----------------------------------------------------------------------------*)
// Functions from 'EZTW32.DLL'
(*----------------------------------------------------------------------------*)
function TWAIN_AcquireToClipboard(hwnd: HWND; pixmask: Cardinal): Integer;
  Pascal; far; external 'EZTW32.DLL' name 'TWAIN_AcquireToClipboard';
function TWAIN_SelectImageSource(hwnd: HWND): Integer;
  Pascal; far; external 'EZTW32.DLL' name 'TWAIN_SelectImageSource';
function TWAIN_LoadSourceManager: integer;
  Pascal; far; external 'EZTW32.DLL' name 'TWAIN_LoadSourceManager';
function TWAIN_UnloadSourceManager: integer;
  Pascal; far; external 'EZTW32.DLL' name 'TWAIN_UnloadSourceManager';
(*----------------------------------------------------------------------------*)



procedure TScanImage.SetImage (Value : TImage);
begin
  FImage := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TScanImage.Notification(AComponent: TComponent;
    Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if (AComponent = FImage) then FImage := nil;
end;

(*----------------------------------------------------------------------------*)
procedure TScanImage.SelectImageSource(Hwnd : THandle);
// Select Image Source.
(*----------------------------------------------------------------------------*)
begin
  TWAIN_SelectImageSource(Hwnd);
end;

(*----------------------------------------------------------------------------*)
procedure TScanImage.AcqureScanner(Hwnd : THandle);
// Scanning and put the bitmap to Image component.
(*----------------------------------------------------------------------------*)
begin
  if not Assigned(FImage) then Exit;
  if (TWAIN_LoadSourceManager >0) Then
  Begin
    if (TWAIN_AcquireToClipboard(Hwnd,TWAIN_ANYTYPE)>0)
    Then
      FImage.Picture.Bitmap.LoadFromClipboardFormat(
          cf_BitMap,
          ClipBoard.GetAsHandle(cf_Bitmap),
          0
        );
    ClipBoard.Clear;
    TWAIN_UnLoadSourceManager;
  End;
end;

(*----------------------------------------------------------------------------*)
(*----------------------------------------------------------------------------*)
procedure Register;
(*----------------------------------------------------------------------------*)
begin
  RegisterComponents('Samples', [TScanImage]);
end;
(*----------------------------------------------------------------------------*)
(*----------------------------------------------------------------------------*)

end.


