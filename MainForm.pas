unit MainForm;

interface

uses
  Winapi.ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.WinXPanels, Vcl.ComCtrls, Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB, Clipbrd, Vcl.NumberBox;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    ShifrShow: TButton;
    labelLogo: TLabel;
    nameUser: TLabel;
    ShifrPanel: TPanel;
    AccountShow: TButton;
    AdminShow: TButton;
    Button3: TButton;
    AccountPanel: TPanel;
    AdminPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    ShifrAdd: TPanel;
    brnAddShifr: TButton;
    btnDeleteShifr: TButton;
    Label6: TLabel;
    statusAdmin: TLabel;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Edit1: TEdit;
    Label8: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label9: TLabel;
    Button6: TButton;
    DBGrid2: TDBGrid;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Label10: TLabel;
    NumberBox1: TNumberBox;
    Label11: TLabel;
    Label12: TLabel;
    Edit3: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ShifrShowClick(Sender: TObject);
    procedure AccountShowClick(Sender: TObject);
    procedure AdminShowClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure brnAddShifrClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteShifrClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure ComboBox1Select(Sender: TObject);
  private
  FUserName: string;
  FUserRole: string;
  FUserID: Integer;
  FSelectedRowIndex: Integer;
  FSelectedRowIndex2: Integer;
  { Private declarations }
public
  property UserName: string read FUserName write FUserName;
  property UserRole: string read FUserRole write FUserRole;
  property UserID: Integer read FUserID write FUserID;
  { Public declarations }

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.AccountShowClick(Sender: TObject);
begin
  AccountPanel.Visible := True;
  AccountPanel.BringToFront;
  label5.Caption := 'Имя пользователя: ' + FUserName + #13#10 + 'Доступная роль: ' + FUserRole + #13#10 + 'Персональный идентификатор: ' + FUserID.ToString;
  ShifrPanel.Visible := False;
  AdminPanel.Visible := False;
end;

procedure TForm2.AdminShowClick(Sender: TObject);
begin
AdminPanel.Visible := True;
  AdminPanel.BringToFront;

  ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.SQL.Text := 'SELECT * FROM [Users]';
  ADOQuery1.Open;

  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  DBGrid2.DataSource := DataSource1;
  DBGrid2.Columns[0].Title.Caption := 'Номер в базе';
  DBGrid2.Columns[0].Width := 80;
  DBGrid2.Columns[1].Title.Caption := 'Имя пользователя';
  DBGrid2.Columns[1].Width := 215;
  DBGrid2.Columns[2].Title.Caption := 'Логин';
  DBGrid2.Columns[2].Width := 150;
  DBGrid2.Columns[3].Title.Caption := 'Пароль';
  DBGrid2.Columns[3].Width := 85;
  DBGrid2.Columns[4].Title.Caption := 'Роль';
  DBGrid2.Columns[4].Width := 97;

  ShifrPanel.Visible := False;
  AccountPanel.Visible := False;
end;


procedure TForm2.brnAddShifrClick(Sender: TObject);
begin
  ShifrAdd.Visible := True; // делаем панель видимой
  ShifrAdd.BringToFront; // вызываем панель на передний план
end;

procedure TForm2.btnDeleteShifrClick(Sender: TObject);
var
  IDText: Integer;
begin
  // Получаем IDText из выбранной строки в DBGrid1
  if FSelectedRowIndex > 0 then
  begin
    // переходим к выбранной строке
    DBGrid1.DataSource.DataSet.RecNo := FSelectedRowIndex;

    // получаем значения из ячеек выбранной строки
    IDText := DBGrid1.Columns[0].Field.AsInteger;

    // Предупреждение перед удалением
    if MessageBox(Handle, PChar('Вы уверены, что хотите удалить запись с IDText = ' + IntToStr(IDText) + '?'),
        PChar('Удаление записи'), MB_ICONWARNING or MB_YESNO) = IDYES then
    begin
      // Выполняем SQL-запрос на удаление записи
      ADOQuery1.SQL.Text := 'DELETE FROM [Text] WHERE [IDText] = ' + IntToStr(IDText);
      ADOQuery1.ExecSQL;

// обновляем таблицу (это дубляж кода, он используется по нажатию и отображению панели)
ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.SQL.Text := 'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID ORDER BY [DateAdded] ASC';
  ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
  ADOQuery1.Open;

  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Columns[0].Title.Caption := 'Номер в базе';
  DBGrid1.Columns[0].Width := 80;
  DBGrid1.Columns[1].Title.Caption := 'Шифрованный текст';
  DBGrid1.Columns[1].Width := 215;
  DBGrid1.Columns[2].Title.Caption := 'Метод шифрования';
  DBGrid1.Columns[2].Width := 150;
  DBGrid1.Columns[3].Title.Caption := 'Дата создания';
  DBGrid1.Columns[3].Width := 125;
// -----

MessageBox(Handle, 'Удалено успешно!', 'Успех', MB_OK or MB_ICONWARNING);
    end;
  end
  else
    ShowMessage('Выберите строку для удаления!');
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  ExeName: string;
begin
  ExeName := Application.ExeName;
  ShellExecute(Handle, nil, PChar(ExeName), nil, nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin

  ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.SQL.Text := 'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded], [IDUser] FROM [Text] ORDER BY [DateAdded] ASC';
  ADOQuery1.Open;

  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Columns[0].Title.Caption := 'Номер в базе';
  DBGrid1.Columns[0].Width := 80;
  DBGrid1.Columns[1].Title.Caption := 'Шифрованный текст';
  DBGrid1.Columns[1].Width := 215;
  DBGrid1.Columns[2].Title.Caption := 'Метод шифрования';
  DBGrid1.Columns[2].Width := 100;
  DBGrid1.Columns[3].Title.Caption := 'Дата создания';
  DBGrid1.Columns[3].Width := 125;
  DBGrid1.Columns[4].Title.Caption := '№ аккаунта';
  DBGrid1.Columns[4].Width := 70;

end;

procedure TForm2.Button5Click(Sender: TObject);
begin

  ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.SQL.Text := 'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID ORDER BY [DateAdded] ASC';
  ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
  ADOQuery1.Open;

  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Columns[0].Title.Caption := 'Номер в базе';
  DBGrid1.Columns[0].Width := 80;
  DBGrid1.Columns[1].Title.Caption := 'Шифрованный текст';
  DBGrid1.Columns[1].Width := 215;
  DBGrid1.Columns[2].Title.Caption := 'Метод шифрования';
  DBGrid1.Columns[2].Width := 150;
  DBGrid1.Columns[3].Title.Caption := 'Дата создания';
  DBGrid1.Columns[3].Width := 125;

end;

procedure TForm2.Button6Click(Sender: TObject);
var
  Login: string;
  Role: string;
begin
  // Получаем значения из выбранной строки в DBGrid1
  if FSelectedRowIndex2 > 0 then
  begin
    // переходим к выбранной строке
    DBGrid2.DataSource.DataSet.RecNo := FSelectedRowIndex2;

    // получаем значения из ячеек выбранной строки
    Login := DBGrid2.Columns[2].Field.AsString;
    Role := DBGrid2.Columns[4].Field.AsString;

     // Меняем роль пользователя
  if Role = 'User' then
    Role := 'Admin'
  else if Role = 'Admin' then
    Role := 'User';

    // Выполняем SQL-запрос на обновление роли пользователя
  ADOQuery1.SQL.Text := 'UPDATE [Users] SET Role = ' + QuotedStr(Role) + ' WHERE [Login] = ' + QuotedStr(Login);
  ADOQuery1.ExecSQL;

  // Обновляем содержимое DBGrid2

  ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.SQL.Text := 'SELECT * FROM [Users]';
  ADOQuery1.Open;

  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  DBGrid2.DataSource := DataSource1;
  DBGrid2.Columns[0].Title.Caption := 'Номер в базе';
  DBGrid2.Columns[0].Width := 80;
  DBGrid2.Columns[1].Title.Caption := 'Имя пользователя';
  DBGrid2.Columns[1].Width := 215;
  DBGrid2.Columns[2].Title.Caption := 'Логин';
  DBGrid2.Columns[2].Width := 150;
  DBGrid2.Columns[3].Title.Caption := 'Пароль';
  DBGrid2.Columns[3].Width := 85;
  DBGrid2.Columns[4].Title.Caption := 'Роль';
  DBGrid2.Columns[4].Width := 97;
    ShowMessage('Успешно!');
  end
  else
    ShowMessage('Выберите строку!');
end;


procedure TForm2.ComboBox1Select(Sender: TObject);
begin
  if ComboBox1.Text = 'Цезарь' then
  begin
    NumberBox1.Visible := true;
    Label11.Visible := true;
    Edit3.Visible := false;
    Label12.Visible := false;
  end
  else if ComboBox1.Text = 'Шифр Атбаша' then
       begin
       NumberBox1.Visible := false;
       Label11.Visible := false;
       Edit3.Visible := false;
       Label12.Visible := false;
       end
  else
  begin
    Edit3.Visible := true;
    Label12.Visible := true;
    NumberBox1.Visible := false;
    Label11.Visible := false;
  end;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
begin
  FSelectedRowIndex := DBGrid1.DataSource.DataSet.RecNo;
end;

procedure TForm2.DBGrid2CellClick(Column: TColumn);
begin
  FSelectedRowIndex2 := DBGrid2.DataSource.DataSet.RecNo;
end;



procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Res: Integer;
begin
  Res := MessageBox(Handle, 'Вы действительно хотите закрыть приложение?', 'Закрыть', MB_YESNO or MB_ICONQUESTION);
  CanClose := Res = IDYES;
  if CanClose then
    Application.Terminate;
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
inherited;
  FSelectedRowIndex := -1;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
nameUser.Caption := 'Добро пожаловать: ' + FUserName;
if FUserRole = 'Admin' then
  begin
  // показываем для роли администратора
  AdminShow.Visible := true;
  statusAdmin.Visible := true;
  Button4.Visible := true;
  Button5.Visible := true;
  end;
end;


procedure TForm2.ShifrShowClick(Sender: TObject);
begin
  ShifrPanel.Visible := True;
  ShifrPanel.BringToFront;

  ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;
  ADOQuery1.SQL.Text := 'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID';
  ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
  ADOQuery1.Open;

  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.Columns[0].Title.Caption := 'Номер в базе';
  DBGrid1.Columns[0].Width := 80;
  DBGrid1.Columns[1].Title.Caption := 'Шифрованный текст';
  DBGrid1.Columns[1].Width := 215;
  DBGrid1.Columns[2].Title.Caption := 'Метод шифрования';
  DBGrid1.Columns[2].Width := 150;
  DBGrid1.Columns[3].Title.Caption := 'Дата создания';
  DBGrid1.Columns[3].Width := 125;

  AccountPanel.Visible := False;
  AdminPanel.Visible := False;
end;

// МЕТОДЫ ШИФРОВАНИЯ ИДУТ В ВИДЕ ФУНКЦИЙ, КОТОРЫЕ ПРИНИМАЮТ И ВОЗВРАЩАЮТ ОПРЕДЕЛЕННЫЕ ЗНАЧЕНИЯ

//*** Цезарь ***
// Этот метод принимает текст и сдвиг и возвращает зашифрованный текст.
// Он работает по принципу замены каждой буквы входного текста на букву, находящуюся на расстоянии сдвига в алфавите.

function CaesarCipher(PlainText: string; Shift: Integer): string;
var
  i: Integer;
  EncryptedText: string;
  NumberBox1 : TNumberBox;
begin
  NumberBox1 := TNumberBox.Create(nil);
  EncryptedText := '';
  for i := 1 to Length(PlainText) do // проходим по каждому символу входного текста
    if PlainText[i] in ['a'..'z'] then // если символ - маленькая буква английского алфавита
      EncryptedText := EncryptedText + Chr(Ord('a') + ((Ord(PlainText[i]) - Ord('a') + Shift) mod 26)) // шифруем символ по формуле шифра Цезаря для маленьких букв
    else if PlainText[i] in ['A'..'Z'] then // если символ - большая буква английского алфавита
      EncryptedText := EncryptedText + Chr(Ord('A') + ((Ord(PlainText[i]) - Ord('A') + Shift) mod 26)) // шифруем символ по формуле шифра Цезаря для больших букв
    else
      EncryptedText := EncryptedText + PlainText[i]; // оставляем символ неизменным, если он не является буквой
  Result := EncryptedText; // возвращаем зашифрованный или расшифрованный текст
end;


//*** Шифр Атбаша ***
// Этот метод принимает текст и возвращает его зашифрованную версию с помощью шифра Атбаша.
// Шифр Атбаша является одним из простых методов замены символов, где каждый символ заменяется на символ, расположенный на противоположном конце алфавита.
// Таким образом, первая буква заменяется на последнюю, вторая на предпоследнюю и т.д.
// Для расшифровки текста необходимо просто использовать шифр Атбаша еще раз.
// Функция для шифрования текста методом Атбаш
function AtbashCipher(PlainText: string): string;
var
  i: Integer;
  EncryptedText: string; // переменная для хранения зашифрованного текста
begin
  EncryptedText := ''; // инициализируем переменную
  for i := 1 to Length(PlainText) do // цикл по всем символам входного текста
  begin
    if (PlainText[i] >= 'A') and (PlainText[i] <= 'Z') then // если символ - заглавная буква
      EncryptedText := EncryptedText + Chr(Ord('Z') - (Ord(PlainText[i]) - Ord('A'))) // добавляем в зашифрованный текст соответствующий символ из обратного алфавита
    else if (PlainText[i] >= 'a') and (PlainText[i] <= 'z') then // если символ - строчная буква
      EncryptedText := EncryptedText + Chr(Ord('z') - (Ord(PlainText[i]) - Ord('a'))) // добавляем в зашифрованный текст соответствующий символ из обратного алфавита
    else // если символ не является буквой
      EncryptedText := EncryptedText + PlainText[i]; // добавляем символ в зашифрованный текст без изменений
  end;
  Result := EncryptedText; // возвращаем зашифрованный текст
end;



//*** Шифр Вижнера ***
//Этот метод принимает текст и ключ и возвращает зашифрованный текст.
//Он работает по принципу замены каждой буквы входного текста на букву, находящуюся на расстоянии символа ключа в алфавите.
// true - шифруем, false - расшифровываем
function VigenereCipher(PlainText, Key: string; Encrypt: Boolean): string;
var
  i, j: Integer;
  KeyIndex: Integer;
  EncryptedText: string;
begin
  EncryptedText := '';
  KeyIndex := 1;
  for i := 1 to Length(PlainText) do
  begin
    if not (PlainText[i] in ['a'..'z', 'A'..'Z']) then
    begin
      EncryptedText := EncryptedText + PlainText[i];
      Continue;
    end;

    if Encrypt then
      EncryptedText := EncryptedText + Chr((Ord(UpCase(PlainText[i])) + Ord(UpCase(Key[KeyIndex])) - 2 * Ord('A')) mod 26 + Ord('A'))
    else
      EncryptedText := EncryptedText + Chr((Ord(UpCase(PlainText[i])) - Ord(UpCase(Key[KeyIndex])) + 26) mod 26 + Ord('A'));

    Inc(KeyIndex);
    if KeyIndex > Length(Key) then
      KeyIndex := 1;
  end;
  Result := EncryptedText;
end;


// *** Табличное шифрование ***
// Метод табличного шифрования заключается в замене символов текста на символы из заранее определенной таблицы замен.
// Для шифрования используется таблица, состоящая из строк и столбцов, заполненная произвольными символами.
// Ключом шифрования является сама таблица, которую знает только отправитель и получатель.
function TableEncryption(Text, Key: string): string;
const
  TableSize = 6; // размер таблицы тут статичный, всего 6 ячеек
var
  Table: array[1..TableSize, 1..TableSize] of Char;
  i, j, k: Integer;
  EncryptedText: string;
begin
  // Заполняем таблицу символами алфавита, начиная с символа ключа
  k := Pos(Key[1], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') - 1;
  for i := 1 to TableSize do
    for j := 1 to TableSize do
    begin
      Table[i, j] := Char(Ord('А') + (k mod 32)); // первые 32 символа - русские, потом английские
      Inc(k);
    end;

  // Заменяем символы текста на символы из таблицы
  EncryptedText := '';
  for i := 1 to Length(Text) do
  begin
    for j := 1 to TableSize do
    begin
      for k := 1 to TableSize do
      begin
        if Text[i] = Table[j, k] then
        begin
          EncryptedText := EncryptedText + Table[j, k];
          Break;
        end;
      end;
      if EncryptedText <> '' then Break;
    end;
  end;

  Result := EncryptedText;
end;

//*** Матричный шифр ***
//это метод шифрования, который использует матрицу ключа для перестановки символов в сообщении.

function MatrixCipher(const Text: string; Key: string): string;
var
  Matrix: array[0..4, 0..4] of Char;
  Rows, Columns, Len, KeyLen, Index, RowIndex, ColIndex: Integer;
  ResultText: string;
begin
  // Инициализируем матрицу ключа
  KeyLen := Length(Key);
  Index := 1;
  for Rows := 0 to 4 do
  begin
    for Columns := 0 to 4 do
    begin
      if Index <= KeyLen then
      begin
        Matrix[Rows, Columns] := Key[Index];
        Inc(Index);
      end
      else
      begin
        Matrix[Rows, Columns] := Chr(65); // Дополнительное заполнение символами
      end;
    end;
  end;

  // Шифруем сообщение с помощью матрицы ключа
  Len := Length(Text);
  RowIndex := 0;
  ColIndex := 0;
  for Index := 1 to Len do
  begin
    // Применяем операцию xor для каждого символа в сообщении и соответствующего символа в матрице ключа
    ResultText := ResultText + Chr(Ord(Matrix[RowIndex, ColIndex]) xor Ord(Text[Index]));
    Inc(ColIndex);
    if ColIndex > 4 then
    begin
      Inc(RowIndex);
      ColIndex := 0;
    end;
    if RowIndex > 4 then
    begin
      RowIndex := 0;
    end;
  end;

  Result := ResultText;
end;




// КОНЕЦ МЕТОДОВ ШИФРОВАНИЯ


procedure TForm2.Button1Click(Sender: TObject); // шифрование и занесени в базу, используем методы исходя из выбранного в комбобоксе
var
EncryptionMethod, EncryptedText: string;
begin
// Получаем выбранный метод шифрования
EncryptionMethod := ComboBox1.Text;


// Зашифровываем текст в зависимости от выбранного метода
if EncryptionMethod = 'Цезарь' then
EncryptedText := CaesarCipher(Edit1.Text, StrToInt(numberBox1.Value.ToString)) // Пример использования функции CaesarCipher
else if EncryptionMethod = 'Шифр Атбаша' then
EncryptedText := AtbashCipher(Edit1.Text) // Пример использования функции AtbashCipher
else if EncryptionMethod = 'Шифр Вижнера' then
EncryptedText := VigenereCipher(Edit1.Text,Edit3.Text, true) // Пример использования функции VigenereCipher
else if EncryptionMethod = 'Табличное шифрование' then
EncryptedText := TableEncryption(Edit1.Text, Edit3.Text)
else if EncryptionMethod = 'Матричный шифр' then
EncryptedText := MatrixCipher(Edit1.Text, Edit3.Text)
else
EncryptedText := ''; // Обработка некорректного выбора метода шифрования

// Записываем информацию о шифровании в базу данных
if EncryptedText <> '' then // Если зашифрованный текст получен успешно
begin
ADOQuery1.SQL.Text :=
'INSERT INTO [Text] ([IDUser], [EncryptionText], [EncryptionMethod], [DateAdded]) ' +
'VALUES (:IDUser, :EncryptionText, :EncryptionMethod, :DateAdded)';
ADOQuery1.Parameters.ParamByName('IDUser').Value := FUserID;
ADOQuery1.Parameters.ParamByName('EncryptionText').Value := EncryptedText;
ADOQuery1.Parameters.ParamByName('EncryptionMethod').Value := EncryptionMethod;
ADOQuery1.Parameters.ParamByName('DateAdded').Value := Now;
ADOQuery1.ExecSQL;
// обновляем таблицу (это дубляж кода, он используется по нажатию и отображению панели)
ADOQuery1 := TADOQuery.Create(nil);
ADOQuery1.Connection := ADOConnection1;
ADOQuery1.SQL.Text := 'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID ORDER BY [DateAdded] ASC';
ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
ADOQuery1.Open;

DataSource1 := TDataSource.Create(nil);
DataSource1.DataSet := ADOQuery1;
DBGrid1.DataSource := DataSource1;
DBGrid1.Columns[0].Title.Caption := 'Номер в базе';
DBGrid1.Columns[0].Width := 80;
DBGrid1.Columns[1].Title.Caption := 'Шифрованный текст';
DBGrid1.Columns[1].Width := 215;
DBGrid1.Columns[2].Title.Caption := 'Метод шифрования';
DBGrid1.Columns[2].Width := 150;
DBGrid1.Columns[3].Title.Caption := 'Дата создания';
DBGrid1.Columns[3].Width := 120;

Edit2.Text := EncryptedText;
// —-—
if CheckBox1.Checked then
begin
Clipboard.AsText := EncryptedText;
MessageBox(Handle, 'Зашифрованный текст был успешно добавлен в буфер обмена!', 'Успех', MB_OK or MB_ICONWARNING)
end
else
begin
  MessageBox(Handle, 'Сообщение зашифровано и добавлено в базу!', 'Успех', MB_OK or MB_ICONWARNING);
end;
    EncryptionMethod:='';

end;
end;



procedure TForm2.Button2Click(Sender: TObject);
var
  EncryptionMethod, EncryptedText: string;
begin
  // Получаем значения из выбранной строки в DBGrid1
  if FSelectedRowIndex > 0 then
  begin
    // переходим к выбранной строке
    DBGrid1.DataSource.DataSet.RecNo := FSelectedRowIndex;

    // получаем значения из ячеек выбранной строки
    EncryptionMethod := DBGrid1.Columns[2].Field.AsString;
    EncryptedText := DBGrid1.Columns[1].Field.AsString;

    // Расшифровываем сообщение с помощью выбранного метода
    if EncryptionMethod = 'Цезарь' then
      MessageBox(Handle, PChar(CaesarCipher(EncryptedText, -StrToInt(NumberBox1.Value.ToString))), 'Расшифрованное сообщение', MB_OK)
    else if EncryptionMethod = 'Шифр Атбаша' then
      MessageBox(Handle, PChar(AtbashCipher(EncryptedText)), 'Расшифрованное сообщение', MB_OK)
    else if EncryptionMethod = 'Шифр Вижнера' then
      MessageBox(Handle, PChar(VigenereCipher(EncryptedText,Edit3.Text, false)), 'Расшифрованное сообщение', MB_OK)
    else if EncryptionMethod = 'Табличное шифрование' then
      MessageBox(Handle, PChar(TableEncryption(EncryptedText, Edit3.Text)), 'Расшифрованное сообщение', MB_OK)
    else if EncryptionMethod = 'Матричный шифр' then
      MessageBox(Handle, PChar(MatrixCipher(EncryptedText, Edit3.Text)), 'Расшифрованное сообщение', MB_OK)
    else
      ShowMessage('Неизвестный метод шифрования!');
  end
  else
    ShowMessage('Выберите строку для расшифровки!');
end;

end.
