//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USERES("TeeLanguage6C6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("Tee6C6.bpi");
USEPACKAGE("TeePro6C6.bpi");
USEUNIT("TeeSpanish.pas");
USEUNIT("TeeCatalan.pas");
USEUNIT("TeeDanish.pas");
USEUNIT("TeeDutch.pas");
USEUNIT("TeeFrench.pas");
USEUNIT("TeeGerman.pas");
USEUNIT("TeeHungarian.pas");
USEUNIT("TeeSwedish.pas");
USEUNIT("TeeChinese.pas");
USEUNIT("TeeChineseSimp.pas");
USEUNIT("TeeBrazil.pas");
USEUNIT("TeeRussian.pas");
USEUNIT("TeeItalian.pas");
USEUNIT("TeeSlovene.pas");
USEUNIT("TeePortuguese.pas");
USEUNIT("TeeFinnish.pas");
USEUNIT("TeeGalician.pas");
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
 