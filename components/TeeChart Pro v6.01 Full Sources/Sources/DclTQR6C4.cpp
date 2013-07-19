//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DclTQR6C4.res");
USEUNIT("TeeQRTeeReg.pas");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("Tee6C4.bpi");
USEPACKAGE("TeeQR6C4.bpi");
USEPACKAGE("TeeDB6C4.bpi");
USEPACKAGE("TeeUI6C4.bpi");
USEPACKAGE("DclTee6C4.bpi");
USEPACKAGE("Vclx40.bpi");
USEPACKAGE("bcbsmp40.bpi");
USEPACKAGE("Qrpt40.bpi");
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
