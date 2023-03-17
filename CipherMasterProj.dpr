program CipherMasterProj;

uses
  Vcl.Forms,
  Autorisation in 'Autorisation.pas' {Form1},
  MainForm in 'MainForm.pas' {Form2},
  Registration in 'Registration.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
