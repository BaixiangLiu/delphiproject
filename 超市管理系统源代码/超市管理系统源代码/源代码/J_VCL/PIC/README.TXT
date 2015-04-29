*************************************************
   Image scanning component using EZTW32.DLL     

                     1998. 3. 2. SungKee-Min.   
                     oranke@inote.com
                     South Korea.
*************************************************

!! Very simple Scanning component and very easy to use!!

TScanImage.
  This is a component that scan image from scanner. It
  supports most of the TWAIN compotable scanner, and all 
  scaned image sent to the TImage component.
 
Property
  ScanedImage : TImage.  // Containing scaned image 
                            component as bitmap.

Method
  SelectImageSource(Hwnd : THandle) // Popup the select 
                                       source window.
  AcqureScanner(Hwnd : THandle)     // Acqure Scanner method

%% Caution %%
  You must call the SelectImageSource() method before use 
  AcqureScanner(). Also you should include EzTw32.dll file
  with your application.

 