// Объявляем модуль и список используемых библиотек и компонентов
unit Autorisation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, MainForm, Registration;

// Объявляем класс формы
type
  TForm1 = class(TForm)
    edtLogin: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label4: TLabel;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    btnRegister: TButton;
    CheckBox1: TCheckBox;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // Объявляем переменные формы
var
  Form1: TForm1;
  MainForm: TForm2; // Объект класса главной формы
  Registration: TForm4; // Объект класса главной формы

  // Реализуем методы класса формы
implementation

// Подключаем файл с ресурсами формы
{$R *.dfm}


procedure TForm1.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := 0;
end;


procedure TForm1.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    edtPassword.SetFocus;
  end;
end;


procedure TForm1.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnLogin.Click;
  end;
end;

// Метод, который вызывается при нажатии на кнопку "Вход"
procedure TForm1.btnLoginClick(Sender: TObject);
var
  Query: TADOQuery; // Объект TADOQuery для выполнения запроса к базе данных
begin
  // Проверяем, что поля заполнены
  if (edtLogin.Text = '') or (edtPassword.Text = '') then
  begin
    // Выводим сообщение об ошибке
    MessageBox(Handle, 'Пожалуйста, введите данные в текстовые поля!',
      'Предупреждение', MB_OK or MB_ICONWARNING);
    Exit; // Выходим из процедуры
  end;

  // Проверяем в базе данных
  Query := TADOQuery.Create(nil); // Создаем объект TADOQuery
  try
    Query.Connection := ADOConnection1;
    // Устанавливаем соединение с базой данных
    Query.SQL.Text :=
      'SELECT Name, Role, IDUser FROM Users WHERE Login = :Login AND Password = :Password';
    // Устанавливаем текст запроса
    Query.Parameters.ParamByName('Login').Value := edtLogin.Text;
    // Устанавливаем параметр :Login для запроса
    Query.Parameters.ParamByName('Password').Value := edtPassword.Text;
    // Устанавливаем параметр :Password для запроса
    Query.Open; // Выполняем запрос

    if Query.Eof then
    // Если запрос не вернул никаких строк, значит логин и/или пароль не верные
    begin
      MessageBox(Handle, 'Неверный логин или пароль!', 'Предупреждение',
        MB_OK or MB_ICONWARNING);
      Exit;
    end;

    // Создаем объект класса главной формы и передаем данные из запроса
    MainForm := TForm2.Create(nil);
    // создаем новую форму типа TForm2 и передаем nil как родительский компонент
    MainForm.UserName := Query.FieldByName('Name').AsString;
    // присваиваем полю UserName значение поля Name из объекта запроса Query
    MainForm.UserRole := Query.FieldByName('Role').AsString;
    // присваиваем полю UserRole значение поля Role из объекта запроса Query
    MainForm.UserID := Query.Fields[2].AsInteger;
    // присваиваем полю UserID значение третьего поля из объекта запроса Query, приведенное к целочисленному типу
    // Открываем главную форму и закрываем текущую
    MainForm.Show; // отображаем созданную форму MainForm
    Hide; // скрываем текущую форму (скорее всего это главная форма, но это не указано в данном коде)
  finally
    Query.Free; // освобождаем объект TADOQuery, чтобы избежать утечки памяти
  end;
end;

// Обработчик события нажатия кнопки мыши на форме
procedure TForm1.FormCreate(Sender: TObject);
begin
  ADOConnection1.Connected := False;
  ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
                                    'Data Source=' + GetCurrentDir + '\Data\data_clear.mdb;' +
                                    'Persist Security Info=False;';
  ADOConnection1.Connected := True;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  // Освобождает захват мыши, который был установлен в процедуре OnMouseDown
  Perform(WM_SYSCOMMAND, $F012, 0);
  // Выполняет команду системного меню "Перетаскивание"
end;

// Обработчик события отпускания кнопки мыши на форме
procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  // Освобождает захват мыши, который был установлен в процедуре OnMouseDown
end;

// Обработчик события нажатия на кнопку "Зарегистрироваться"
procedure TForm1.btnRegisterClick(Sender: TObject);
begin
  Registration := TForm4.Create(nil);
  // создаем новую форму типа TForm4 и передаем nil как родительский компонент
  Registration.Show; // отображаем созданную форму Registration
end;

// Обработчик события изменения состояния чекбокса
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    edtPassword.PasswordChar := #0
    // если чекбокс выбран, то отображаем пароль в открытом виде
  else
    edtPassword.PasswordChar := '•';
  // если чекбокс не выбран, то отображаем символы пароля в виде звездочек
end;

end. // конец описания модуля формы (TForm1)
