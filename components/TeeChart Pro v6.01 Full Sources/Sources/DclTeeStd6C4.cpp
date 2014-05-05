//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclteestd6C4.res");
USERES("teechart.res");
USEUNIT("TeeChartReg.pas");
USEPACKAGE("tee6C4.bpi");
USEPACKAGE("teeUI6C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("dclstd40.bpi");
USEPACKAGE("vclx40.bpi");
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
