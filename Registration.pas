unit Registration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
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
    procedure FormCreate(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

// Обработчик кнопки регистрации нового пользователя
procedure TForm4.btnRegisterClick(Sender: TObject);
var
  Query: TADOQuery;
begin
  // Проверяем, заполнены ли все поля
  if (edtName.Text = '') or (edtLogin.Text = '') or (edtPassword.Text = '') then
  begin
    MessageBox(Handle, 'Заполните все поля!', 'Предупреждение',
      MB_OK or MB_ICONWARNING);
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
      MessageBox(Handle, 'Логин уже занят!', 'Предупреждение',
        MB_OK or MB_ICONWARNING);
      Exit;
    end;
  finally
    Query.Free;
  end;

  // Регистрируем пользователя
  Query := TADOQuery.Create(nil);
  try
    Query.Connection := ADOConnection1;
    Query.SQL.Text :=
      'INSERT INTO [Users] ([Name], [Login], [Password], [Role]) VALUES (:Name, :Login, :Password, :Role)';
    Query.Parameters.ParamByName('Name').Value := edtName.Text;
    Query.Parameters.ParamByName('Login').Value := edtLogin.Text;
    Query.Parameters.ParamByName('Password').Value := edtPassword.Text;
    Query.Parameters.ParamByName('Role').Value := 'User';

    Query.ExecSQL;

    // Показываем сообщение об успешной регистрации и закрываем форму
    MessageBox(Handle, 'Пользователь успешно зарегестрирован, Вы можете войти!',
      'Успех', MB_OK or MB_ICONWARNING);
    Close;

  finally
    Query.Free;
  end;
end;

// Обработчик клика по чекбоксу "Показывать пароль"
procedure TForm4.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    edtPassword.PasswordChar := #0
  else
    edtPassword.PasswordChar := '•';
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  ADOConnection1.Connected := False;
  ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
                                    'Data Source=' + GetCurrentDir + '\Data\data_clear.mdb;' +
                                    'Persist Security Info=False;';
  ADOConnection1.Connected := True;
end;

procedure TForm4.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := 0;
end;


procedure TForm4.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edtPassword.SetFocus;
  end;
end;

procedure TForm4.edtNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edtLogin.SetFocus;
  end;
end;

procedure TForm4.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnRegister.Click;
  end;
end;

end.
