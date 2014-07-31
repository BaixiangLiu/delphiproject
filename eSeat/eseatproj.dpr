program eseatproj;

uses
  Forms,Controls,
  main in 'main.pas' {frmmain},
  dm_seat in 'dm_seat.pas' {dmseat: TDataModule},
  huichang in 'huichang.pas' {frmhuichang},
  huiyi in 'huiyi.pas' {frmhuiyi},
  renyuan in 'renyuan.pas' {frmrenyuan},
  paixi in 'paixi.pas' {frmpaixi},
  cxtj in 'cxtj.pas' {frmcxtj},
  eseatclasses in 'eseatclasses.pas',
  global in 'global.pas',
  clientappfunction in 'clientappfunction.pas',
  login in 'login.pas' {frmlogin},
  simpleselect in 'simpleselect.pas' {Fsimpleselect},
  sel_renyuan in 'sel_renyuan.pas' {frm_sel_renyuan},
  sel_huichang in 'sel_huichang.pas' {frm_sel_huichang},
  param in 'param.pas' {frm_param},
  seatcard in 'seatcard.pas' {frmcard},
  prtseat in 'prtseat.pas' {Form2},
  splash in 'splash.pas' {splashForm};

{$R *.res}

begin


  Application.Initialize;

  splashForm:=TSplashForm.Create(Application);
  splashForm.ShowModal;

  if  (SplashForm.ModalResult =  mrOK) then
  begin
    Application.CreateForm(Tfrmmain, frmmain);
    Application.CreateForm(Tdmseat, dmseat);
    Application.CreateForm(Tfrmcxtj, frmcxtj);
    Application.CreateForm(Tfrmlogin, frmlogin);
    Application.CreateForm(TFsimpleselect, Fsimpleselect);
    Application.CreateForm(Tfrm_sel_renyuan, frm_sel_renyuan);
    Application.CreateForm(Tfrm_sel_huichang, frm_sel_huichang);
    Application.CreateForm(Tfrm_param, frm_param);
    Application.CreateForm(Tfrmcard, frmcard);
    Application.CreateForm(TForm2, Form2);
    Application.CreateForm(TsplashForm, splashForm);
    splashForm.close;
    splashForm.free;

    Application.Run;
  end;
end.
