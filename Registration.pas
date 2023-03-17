unit Registration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtName: TEdit;
    edtPassword: TEdit;
    btnRegister: TButton;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    Label3: TLabel;
    edtLogin: TEdit;
    CheckBox1: TCheckBox;
    procedure btnRegisterClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.btnRegisterClick(Sender: TObject);
var
  Query: TADOQuery;
begin
  if (edtName.Text = '') or (edtLogin.Text = '') or (edtPassword.Text = '') then
  begin
    MessageBox(Handle, 'Заполните все поля!', 'Предупреждение', MB_OK or MB_ICONWARNING);
    Exit;
  end;

  // Проверяем, что логин не занят
  Query := TADOQuery.Create(nil);
  try
    Query.Connection := ADOConnection1;
    Query.SQL.Text := 'SELECT Count(*) FROM Users WHERE Login = :Login';
    Query.Parameters.ParamByName('Login').Value := edtLogin.Text;
    Query.Open;
    if Query.Fields[0].AsInteger > 0 then
    begin
      MessageBox(Handle, 'Логин уже занят!', 'Предупреждение', MB_OK or MB_ICONWARNING);
      Exit;
    end;
  finally
    Query.Free;
  end;

  // Регистрируем пользователя
  Query := TADOQuery.Create(nil);
  try
    Query.Connection := ADOConnection1;
    Query.SQL.Text := 'INSERT INTO [Users] ([Name], [Login], [Password], [Role]) VALUES (:Name, :Login, :Password, :Role)';
    Query.Parameters.ParamByName('Name').Value := edtName.Text;
    Query.Parameters.ParamByName('Login').Value := edtLogin.Text;
    Query.Parameters.ParamByName('Password').Value := edtPassword.Text;
    Query.Parameters.ParamByName('Role').Value := 'User';

    Query.ExecSQL;

    MessageBox(Handle, 'Пользователь успешно зарегестрирован, Вы можете войти!', 'Успех', MB_OK or MB_ICONWARNING);
    // Закрываем форму
    Close;

  finally
    Query.Free;
  end;
end;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then
  edtPassword.PasswordChar := #0
 else
  edtPassword.PasswordChar := '•';
end;

end.
