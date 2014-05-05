//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltgl6C4.res");
USEUNIT("TeeOpenGLReg.pas");
USEPACKAGE("teegl6C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("TeeUI6C4.bpi");
USEPACKAGE("Tee6C4.bpi");
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
