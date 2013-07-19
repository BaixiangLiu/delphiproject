//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("TeeImage6C5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("GIFImage.pas");
USEFORMNS("TeeGIF.pas", Teegif, TeeGIFOptions);
USEFORMNS("TeeJPEG.pas", Teejpeg, TeeJPEGOptions);
USEFORMNS("TeePng.pas", Teepng, TeePNGOptions);
USEPACKAGE("vcljpg50.bpi");
USEPACKAGE("TeeUI6C5.bpi");
USEPACKAGE("Tee6C5.bpi");
USEUNIT("pcx.pas");
USEUNIT("TeeVMLCanvas.pas");
USEFORMNS("teepcx.pas", Teepcx, PCXOptions);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
