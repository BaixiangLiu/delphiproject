//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeImage6C4.res");
USEPACKAGE("vcl40.bpi");
USEFORMNS("TeePng.pas", Teepng, TeePNGOptions);
USEFORMNS("TeeGIF.pas", Teegif, TeeGIFOptions);
USEFORMNS("TeeJPEG.pas", Teejpeg, TeeJPEGOptions);
USEUNIT("GIFImage.pas");
USEPACKAGE("vcljpg40.bpi");
USEPACKAGE("TeeUI6C4.bpi");
USEPACKAGE("TeePro6C4.bpi");
USEPACKAGE("Tee6C4.bpi");
USEUNIT("pcx.pas");
USEFORMNS("teepcx.pas", Teepcx, PCXOptions);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
