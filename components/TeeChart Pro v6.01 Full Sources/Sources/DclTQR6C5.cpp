//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DclTQR6C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("Tee6C5.bpi");
USEPACKAGE("TeeQR6C5.bpi");
USEUNIT("TeeQrTeeReg.pas");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("TeeDB6C5.bpi");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("TEEUI6C5.bpi");
USEPACKAGE("DclTee6C5.bpi");
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
