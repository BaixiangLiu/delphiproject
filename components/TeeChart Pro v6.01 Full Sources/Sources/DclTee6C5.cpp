//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltee6C5.res");
USERES("teechart.res");
USEPACKAGE("dcldb50.bpi");
USEPACKAGE("tee6C5.bpi");
USEPACKAGE("teedb6C5.bpi");
USEPACKAGE("teeUI6C5.bpi");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclx50.bpi");
USEFORMNS("TeeExpForm.pas", Teeexpform, TeeDlgWizard);
USEUNIT("TeeChartReg.pas");
USEUNIT("TeeChartExp.pas");
USEPACKAGE("dclbde50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("Vclbde50.bpi");
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
