unit MainForm;

interface

uses
  Winapi.ShellAPI, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
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
  ExePath: string;
  ConnStr: string;

implementation

{$R *.dfm}

// ���������, ���������� ��� ����� �� ������ "AccountShow"
procedure TForm2.AccountShowClick(Sender: TObject);
begin
  // �������� ������ "AccountPanel"
  AccountPanel.Visible := True;
  // ��������� ������ "AccountPanel" �� �������� ����
  AccountPanel.BringToFront;
  // ������ �������� ��� ����� "label5", ���������� ���������� �� �������� ������������
  Label5.Caption := '��� ������������: ' + FUserName + #13#10 +
    '��������� ����: ' + FUserRole + #13#10 + '������������ �������������: ' +
    FUserID.ToString;
  // ������ ������ "ShifrPanel"
  ShifrPanel.Visible := False;
  // ������ ������ "AdminPanel"
  AdminPanel.Visible := False;
end;

// ����������� ����� �������������� ��� ������� �� ��������������� ������
procedure TForm2.AdminShowClick(Sender: TObject);
begin
  // ������������ ������ �������������� � ��� ����������� �� �������� ����
  AdminPanel.Visible := True;
  AdminPanel.BringToFront;

  // ��������� ADOQuery1 ��� ������ � ����� ������
  ADOQuery1 := TADOQuery.Create(nil);
  ADOQuery1.Connection := ADOConnection1;

  // � SQL-������� �����������, ��� ���������� ������� ��� ������ �� ������� "Users"
  ADOQuery1.SQL.Text := 'SELECT * FROM [Users]';

  // ����������� ������ � ���� ������
  ADOQuery1.Open;

  // ��������� ������ DataSource1, ������� ��������� ��������� DBGrid2 � ����� ������
  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;

  // ��������������� ��������� ��� �������� ������� � DBGrid2 � �� ������
  DBGrid2.DataSource := DataSource1;
  DBGrid2.Columns[0].Title.Caption := '����� � ����';
  DBGrid2.Columns[0].Width := 80;
  DBGrid2.Columns[1].Title.Caption := '��� ������������';
  DBGrid2.Columns[1].Width := 215;
  DBGrid2.Columns[2].Title.Caption := '�����';
  DBGrid2.Columns[2].Width := 150;
  DBGrid2.Columns[3].Title.Caption := '������';
  DBGrid2.Columns[3].Width := 85;
  DBGrid2.Columns[4].Title.Caption := '����';
  DBGrid2.Columns[4].Width := 97;

  // ���������� ������ � ��������� � �����������
  ShifrPanel.Visible := False;
  AccountPanel.Visible := False;
end;

procedure TForm2.brnAddShifrClick(Sender: TObject);
begin
  ShifrAdd.Visible := True; // ������ ������ �������
  ShifrAdd.BringToFront; // �������� ������ �� �������� ����
end;

procedure TForm2.btnDeleteShifrClick(Sender: TObject);
var
  IDText: Integer;
begin
  // �������� IDText �� ��������� ������ � DBGrid1
  if FSelectedRowIndex > 0 then
  begin
    // ��������� � ��������� ������
    DBGrid1.DataSource.DataSet.RecNo := FSelectedRowIndex;

    // �������� �������� �� ����� ��������� ������
    IDText := DBGrid1.Columns[0].Field.AsInteger;

    // �������������� ����� ���������
    if MessageBox(Handle,
      PChar('�� �������, ��� ������ ������� ������ � IDText = ' +
      IntToStr(IDText) + '?'), PChar('�������� ������'), MB_ICONWARNING or
      MB_YESNO) = IDYES then
    begin
      // ��������� SQL-������ �� �������� ������
      ADOQuery1.SQL.Text := 'DELETE FROM [Text] WHERE [IDText] = ' +
        IntToStr(IDText);
      ADOQuery1.ExecSQL;

      // ��������� ������� (��� ������ ����, �� ������������ �� ������� � ����������� ������)
      ADOQuery1 := TADOQuery.Create(nil);
      ADOQuery1.Connection := ADOConnection1;
      ADOQuery1.SQL.Text :=
        'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID ORDER BY [DateAdded] ASC';
      ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
      ADOQuery1.Open;

      DataSource1 := TDataSource.Create(nil);
      DataSource1.DataSet := ADOQuery1;
      DBGrid1.DataSource := DataSource1;
      DBGrid1.Columns[0].Title.Caption := '����� � ����';
      DBGrid1.Columns[0].Width := 80;
      DBGrid1.Columns[1].Title.Caption := '����������� �����';
      DBGrid1.Columns[1].Width := 215;
      DBGrid1.Columns[2].Title.Caption := '����� ����������';
      DBGrid1.Columns[2].Width := 150;
      DBGrid1.Columns[3].Title.Caption := '���� ��������';
      DBGrid1.Columns[3].Width := 125;
      // -----

      MessageBox(Handle, '������� �������!', '�����', MB_OK or MB_ICONWARNING);
    end;
  end
  else
    ShowMessage('�������� ������ ��� ��������!');
end;

// ���������� ������� �� ������ "Button3"
procedure TForm2.Button3Click(Sender: TObject);
var
  ExeName: string; // ��������� ��������� ���������� ExeName
begin
  ExeName := Application.ExeName;
  // �������� ������ ���� � ����������� exe-����� � ��������� ��� � ���������� ExeName
  // ��������� ����� ��������� ���������
  // Handle - ���������� ����, ������� ��������� ����� ��������� ���������
  // nil - ��������� �� ������ ���������� ��������� ������ (��� �� ���������)
  // PChar(ExeName) - ��������� �� ��� �����, ������� ����� �������
  // nil - ��������� �� ������� ����� (��� �� ���������)
  // SW_SHOWNORMAL - ����, �����������, ��� ������� ����������
  ShellExecute(Handle, nil, PChar(ExeName), nil, nil, SW_SHOWNORMAL);
  Application.Terminate; // ��������� ������� ��������� ���������
end;

// ���������� ����� �� ������ "Button4"
procedure TForm2.Button4Click(Sender: TObject);
begin
  // �������� ������ ������� ������� � ���� ������
  ADOQuery1 := TADOQuery.Create(nil);
  // ���������� ���������� � ���� ������
  ADOQuery1.Connection := ADOConnection1;
  // ��������� ������ SQL-�������, ������� �������� ��� ������ �� ������� "Text"
  // � ������������ ������� (ASC - �� ����������� ���� ����������)
  ADOQuery1.SQL.Text :=
    'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded], [IDUser] FROM [Text] ORDER BY [DateAdded] ASC';
  // �������� �������
  ADOQuery1.Open;
  // �������� ������ ������� ��������� ������
  DataSource1 := TDataSource.Create(nil);
  // ���������� ������ ������ � ��������� ������
  DataSource1.DataSet := ADOQuery1;
  // ���������� ��������� ������ � ���������� DBGrid1
  DBGrid1.DataSource := DataSource1;
  // ��������� ��������� ������ ������� � DBGrid1
  DBGrid1.Columns[0].Title.Caption := '����� � ����';
  // ��������� ������ ������ ������� � DBGrid1
  DBGrid1.Columns[0].Width := 80;
  // ��������� ��������� ������ ������� � DBGrid1
  DBGrid1.Columns[1].Title.Caption := '����������� �����';
  // ��������� ������ ������ ������� � DBGrid1
  DBGrid1.Columns[1].Width := 215;
  // ��������� ��������� ������� ������� � DBGrid1
  DBGrid1.Columns[2].Title.Caption := '����� ����������';
  // ��������� ������ ������� ������� � DBGrid1
  DBGrid1.Columns[2].Width := 100;
  // ��������� ��������� ��������� ������� � DBGrid1
  DBGrid1.Columns[3].Title.Caption := '���� ��������';
  // ��������� ������ ��������� ������� � DBGrid1
  DBGrid1.Columns[3].Width := 125;
  // ��������� ��������� ����� ������� � DBGrid1
  DBGrid1.Columns[4].Title.Caption := '� ��������';
  // ��������� ������ ����� ������� � DBGrid1
  DBGrid1.Columns[4].Width := 70;
end;

// ���������� ������� ������� �� ������ Button5
procedure TForm2.Button5Click(Sender: TObject);
begin
  // ������� ������ ADOQuery1
  ADOQuery1 := TADOQuery.Create(nil);
  // ����������� ��� ���������� ADOConnection1
  ADOQuery1.Connection := ADOConnection1;
  // ������������� SQL-������, ������� �������� �� ������� Text ������ � �������� ��������� IDUser
  ADOQuery1.SQL.Text :=
    'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID ORDER BY [DateAdded] ASC';
  // ������ �������� ��������� :UserID, ��������� �������� Value ������� Parameters, ���������� ���������� ��������� ��� ���������� ������� � SQL-�������
  ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
  // ��������� ������ ADOQuery1
  ADOQuery1.Open;

  // ������� ������ DataSource1 � ��������� ��� � �������� ADOQuery1
  DataSource1 := TDataSource.Create(nil);
  DataSource1.DataSet := ADOQuery1;
  // ������������� �������� ������ ��� ������� DBGrid1
  DBGrid1.DataSource := DataSource1;
  // ������ ��������� ��� �������� ������� DBGrid1
  DBGrid1.Columns[0].Title.Caption := '����� � ����';
  DBGrid1.Columns[0].Width := 80;
  DBGrid1.Columns[1].Title.Caption := '����������� �����';
  DBGrid1.Columns[1].Width := 215;
  DBGrid1.Columns[2].Title.Caption := '����� ����������';
  DBGrid1.Columns[2].Width := 150;
  DBGrid1.Columns[3].Title.Caption := '���� ��������';
  DBGrid1.Columns[3].Width := 125;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  Login: string;
  Role: string;
begin
  // �������� �������� �� ��������� ������ � DBGrid1
  if FSelectedRowIndex2 > 0 then
  begin
    // ��������� � ��������� ������
    DBGrid2.DataSource.DataSet.RecNo := FSelectedRowIndex2;

    // �������� �������� �� ����� ��������� ������
    Login := DBGrid2.Columns[2].Field.AsString;
    Role := DBGrid2.Columns[4].Field.AsString;

    // ������ ���� ������������
    if Role = 'User' then
      Role := 'Admin'
    else if Role = 'Admin' then
      Role := 'User';

    // ��������� SQL-������ �� ���������� ���� ������������
    ADOQuery1.SQL.Text := 'UPDATE [Users] SET Role = ' + QuotedStr(Role) +
      ' WHERE [Login] = ' + QuotedStr(Login);
    ADOQuery1.ExecSQL;

    // ��������� ���������� DBGrid2

    ADOQuery1 := TADOQuery.Create(nil);
    ADOQuery1.Connection := ADOConnection1;
    ADOQuery1.SQL.Text := 'SELECT * FROM [Users]';
    ADOQuery1.Open;

    DataSource1 := TDataSource.Create(nil);
    DataSource1.DataSet := ADOQuery1;
    DBGrid2.DataSource := DataSource1;
    DBGrid2.Columns[0].Title.Caption := '����� � ����';
    DBGrid2.Columns[0].Width := 80;
    DBGrid2.Columns[1].Title.Caption := '��� ������������';
    DBGrid2.Columns[1].Width := 215;
    DBGrid2.Columns[2].Title.Caption := '�����';
    DBGrid2.Columns[2].Width := 150;
    DBGrid2.Columns[3].Title.Caption := '������';
    DBGrid2.Columns[3].Width := 85;
    DBGrid2.Columns[4].Title.Caption := '����';
    DBGrid2.Columns[4].Width := 97;
    ShowMessage('�������!');
  end
  else
    ShowMessage('�������� ������!');
end;

// ���������� ������� ������ �������� � ComboBox
procedure TForm2.ComboBox1Select(Sender: TObject);
begin
  // ���� ������ ����� "������"
  if ComboBox1.Text = '������' then
  begin
    // ���������� ��������� ��� ����� ������
    NumberBox1.Visible := True;
    // ���������� ����� � ����������
    Label11.Visible := True;
    // �������� ��������� ��� ����� �����
    Edit3.Visible := False;
    // �������� ����� � ���������� ��� �����
    Label12.Visible := False;
  end
  // ���� ������ ����� "���� ������"
  else if ComboBox1.Text = '���� ������' then
  begin
    // �������� ��������� ��� ����� ������
    NumberBox1.Visible := False;
    // �������� ����� � ���������� ��� ������
    Label11.Visible := False;
    // �������� ��������� ��� ����� �����
    Edit3.Visible := False;
    // �������� ����� � ���������� ��� �����
    Label12.Visible := False;
  end
  // � ��������� ������
  else
  begin
    // ���������� ��������� ��� ����� �����
    Edit3.Visible := True;
    // ���������� ����� � ���������� ��� �����
    Label12.Visible := True;
    // �������� ��������� ��� ����� ������
    NumberBox1.Visible := False;
    // �������� ����� � ���������� ��� ������
    Label11.Visible := False;
  end;
end;

// ���������� ������� ����� �� ������ ������� DBGrid1
procedure TForm2.DBGrid1CellClick(Column: TColumn);
begin
  FSelectedRowIndex := DBGrid1.DataSource.DataSet.RecNo;
  // ��������� ����� ��������� ������
end;

// ���������� ������� ����� �� ������ ������� DBGrid2
procedure TForm2.DBGrid2CellClick(Column: TColumn);
begin
  FSelectedRowIndex2 := DBGrid2.DataSource.DataSet.RecNo;
  // ��������� ����� ��������� ������
end;

// ���������� ������� �������� �����
procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Res: Integer;
begin
  Res := MessageBox(Handle, '�� ������������� ������ ������� ����������?',
    // ������� ���������� ���� � �������� � ��������
    '�������', MB_YESNO or MB_ICONQUESTION);
  CanClose := Res = IDYES; // ��������� ����� ������������ �� ������ � ��������
  if CanClose then // ���� ������������ �������� ������� ����������
    Application.Terminate; // ��������� ����������
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  ExePath := ExtractFilePath(ParamStr(0));
  ConnStr := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source="' + ExePath + 'Data\data_clear.mdb";Persist Security Info=False';
  ADOConnection1.ConnectionString := ConnStr;
  inherited;
  FSelectedRowIndex := -1;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  nameUser.Caption := '����� ����������: ' + FUserName;
  if FUserRole = 'Admin' then
  begin
    // ���������� ��� ���� ��������������
    AdminShow.Visible := True;
    statusAdmin.Visible := True;
    Button4.Visible := True;
    Button5.Visible := True;
  end;
end;

// ����������� ������ ��� ���������� ������ � �������� ������ �� ���� ������
procedure TForm2.ShifrShowClick(Sender: TObject);
begin
  ShifrPanel.Visible := True; // �������� ������ ��� ����������
  ShifrPanel.BringToFront; // ����������� ������ ������, ����� ��� ���� �����

  ADOQuery1 := TADOQuery.Create(nil); // ������� ��������� ADOQuery
  ADOQuery1.Connection := ADOConnection1;
  // ���������� ���������� � ����� ������
  ADOQuery1.SQL.Text :=
    'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID';
  // ������� ������ �� ������� [Text], ��� [IDUser] ������������� ��������� ��������
  ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
  // ���������� �������� ��������� :UserID ������ FUserID
  ADOQuery1.Open; // ��������� ������ � ������� ����������

  DataSource1 := TDataSource.Create(nil); // ������� �������� ������
  DataSource1.DataSet := ADOQuery1; // ���������� �������� ������ ��� ADOQuery1
  DBGrid1.DataSource := DataSource1; // ���������� �������� ������ ��� DBGrid1
  DBGrid1.Columns[0].Title.Caption := '����� � ����';
  // ���������� ��������� ��� ������ �������
  DBGrid1.Columns[0].Width := 80; // ���������� ������ ��� ������ �������
  DBGrid1.Columns[1].Title.Caption := '����������� �����';
  // ���������� ��������� ��� ������ �������
  DBGrid1.Columns[1].Width := 215; // ���������� ������ ��� ������ �������
  DBGrid1.Columns[2].Title.Caption := '����� ����������';
  // ���������� ��������� ��� ������� �������
  DBGrid1.Columns[2].Width := 150; // ���������� ������ ��� ������� �������
  DBGrid1.Columns[3].Title.Caption := '���� ��������';
  // ���������� ��������� ��� ��������� �������
  DBGrid1.Columns[3].Width := 125; // ���������� ������ ��� ��������� �������

  AccountPanel.Visible := False; // ������ ������ ��������
  AdminPanel.Visible := False; // ������ ������ ��������������
end;

// ������ ���������� ���� � ���� �������, ������� ��������� � ���������� ������������ ��������

// *** ������ ***
// ���� ����� ��������� ����� � ����� � ���������� ������������� �����.
// �� �������� �� �������� ������ ������ ����� �������� ������ �� �����, ����������� �� ���������� ������ � ��������.

function CaesarCipher(PlainText: string; Shift: Integer): string;
var
  i: Integer;
  EncryptedText: string;
  NumberBox1: TNumberBox;
begin
  NumberBox1 := TNumberBox.Create(nil);
  EncryptedText := '';
  for i := 1 to Length(PlainText) do
    // �������� �� ������� ������� �������� ������
    if PlainText[i] in ['a' .. 'z'] then
      // ���� ������ - ��������� ����� ����������� ��������
      EncryptedText := EncryptedText +
        Chr(Ord('a') + ((Ord(PlainText[i]) - Ord('a') + Shift) mod 26))
      // ������� ������ �� ������� ����� ������ ��� ��������� ����
    else if PlainText[i] in ['A' .. 'Z'] then
      // ���� ������ - ������� ����� ����������� ��������
      EncryptedText := EncryptedText +
        Chr(Ord('A') + ((Ord(PlainText[i]) - Ord('A') + Shift) mod 26))
      // ������� ������ �� ������� ����� ������ ��� ������� ����
    else
      EncryptedText := EncryptedText + PlainText[i];
  // ��������� ������ ����������, ���� �� �� �������� ������
  Result := EncryptedText; // ���������� ������������� ��� �������������� �����
end;

// *** ���� ������ ***
// ���� ����� ��������� ����� � ���������� ��� ������������� ������ � ������� ����� ������.
// ���� ������ �������� ����� �� ������� ������� ������ ��������, ��� ������ ������ ���������� �� ������, ������������� �� ��������������� ����� ��������.
// ����� �������, ������ ����� ���������� �� ���������, ������ �� ������������� � �.�.
// ��� ����������� ������ ���������� ������ ������������ ���� ������ ��� ���.
// ������� ��� ���������� ������ ������� �����
function AtbashCipher(PlainText: string): string;
var
  i: Integer;
  EncryptedText: string; // ���������� ��� �������� �������������� ������
begin
  EncryptedText := ''; // �������������� ����������
  for i := 1 to Length(PlainText) do // ���� �� ���� �������� �������� ������
  begin
    if (PlainText[i] >= 'A') and (PlainText[i] <= 'Z') then
      // ���� ������ - ��������� �����
      EncryptedText := EncryptedText +
        Chr(Ord('Z') - (Ord(PlainText[i]) - Ord('A')))
      // ��������� � ������������� ����� ��������������� ������ �� ��������� ��������
    else if (PlainText[i] >= 'a') and (PlainText[i] <= 'z') then
      // ���� ������ - �������� �����
      EncryptedText := EncryptedText +
        Chr(Ord('z') - (Ord(PlainText[i]) - Ord('a')))
      // ��������� � ������������� ����� ��������������� ������ �� ��������� ��������
    else // ���� ������ �� �������� ������
      EncryptedText := EncryptedText + PlainText[i];
    // ��������� ������ � ������������� ����� ��� ���������
  end;
  Result := EncryptedText; // ���������� ������������� �����
end;

// *** ���� ������� ***
// ���� ����� ��������� ����� � ���� � ���������� ������������� �����.
// �� �������� �� �������� ������ ������ ����� �������� ������ �� �����, ����������� �� ���������� ������� ����� � ��������.
// true - �������, false - ��������������
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
    if not(PlainText[i] in ['a' .. 'z', 'A' .. 'Z']) then
    begin
      EncryptedText := EncryptedText + PlainText[i];
      Continue;
    end;

    if Encrypt then
      EncryptedText := EncryptedText +
        Chr((Ord(UpCase(PlainText[i])) + Ord(UpCase(Key[KeyIndex])) - 2 *
        Ord('A')) mod 26 + Ord('A'))
    else
      EncryptedText := EncryptedText +
        Chr((Ord(UpCase(PlainText[i])) - Ord(UpCase(Key[KeyIndex])) + 26) mod 26
        + Ord('A'));

    Inc(KeyIndex);
    if KeyIndex > Length(Key) then
      KeyIndex := 1;
  end;
  Result := EncryptedText;
end;

// *** ��������� ���������� ***
// ����� ���������� ���������� ����������� � ������ �������� ������ �� ������� �� ������� ������������ ������� �����.
// ��� ���������� ������������ �������, ��������� �� ����� � ��������, ����������� ������������� ���������.
// ������ ���������� �������� ���� �������, ������� ����� ������ ����������� � ����������.
function TableEncryption(Text, Key: string): string;
const
  TableSize = 6; // ������ ������� ��� ���������, ����� 6 �����
var
  Table: array [1 .. TableSize, 1 .. TableSize] of Char;
  i, j, k: Integer;
  EncryptedText: string;
begin
  // ��������� ������� ��������� ��������, ������� � ������� �����
  k := Pos(Key[1], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') - 1;
  for i := 1 to TableSize do
    for j := 1 to TableSize do
    begin
      Table[i, j] := Char(Ord('�') + (k mod 32));
      // ������ 32 ������� - �������, ����� ����������
      Inc(k);
    end;

  // �������� ������� ������ �� ������� �� �������
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
      if EncryptedText <> '' then
        Break;
    end;
  end;

  Result := EncryptedText;
end;

// *** ��������� ���� ***
// ��� ����� ����������, ������� ���������� ������� ����� ��� ������������ �������� � ���������.

function MatrixCipher(const Text: string; Key: string): string;
var
  Matrix: array [0 .. 4, 0 .. 4] of Char;
  Rows, Columns, Len, KeyLen, Index, RowIndex, ColIndex: Integer;
  ResultText: string;
begin
  // �������������� ������� �����
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
        Matrix[Rows, Columns] := Chr(65); // �������������� ���������� ���������
      end;
    end;
  end;

  // ������� ��������� � ������� ������� �����
  Len := Length(Text);
  RowIndex := 0;
  ColIndex := 0;
  for Index := 1 to Len do
  begin
    // ��������� �������� xor ��� ������� ������� � ��������� � ���������������� ������� � ������� �����
    ResultText := ResultText + Chr(Ord(Matrix[RowIndex, ColIndex])
      xor Ord(Text[Index]));
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




// ����� ������� ����������

procedure TForm2.Button1Click(Sender: TObject);
// ���������� � �������� � ����, ���������� ������ ������ �� ���������� � ����������
var
  EncryptionMethod, EncryptedText: string;
begin
  // �������� ��������� ����� ����������
  EncryptionMethod := ComboBox1.Text;

  // ������������� ����� � ����������� �� ���������� ������
  if EncryptionMethod = '������' then
    EncryptedText := CaesarCipher(Edit1.Text,
      StrToInt(NumberBox1.Value.ToString))
    // ������ ������������� ������� CaesarCipher
  else if EncryptionMethod = '���� ������' then
    EncryptedText := AtbashCipher(Edit1.Text)
    // ������ ������������� ������� AtbashCipher
  else if EncryptionMethod = '���� �������' then
    EncryptedText := VigenereCipher(Edit1.Text, Edit3.Text, True)
    // ������ ������������� ������� VigenereCipher
  else if EncryptionMethod = '��������� ����������' then
    EncryptedText := TableEncryption(Edit1.Text, Edit3.Text)
  else if EncryptionMethod = '��������� ����' then
    EncryptedText := MatrixCipher(Edit1.Text, Edit3.Text)
  else
    EncryptedText := ''; // ��������� ������������� ������ ������ ����������

  // ���������� ���������� � ���������� � ���� ������
  if EncryptedText <> '' then // ���� ������������� ����� ������� �������
  begin
    ADOQuery1.SQL.Text :=
      'INSERT INTO [Text] ([IDUser], [EncryptionText], [EncryptionMethod], [DateAdded]) '
      + 'VALUES (:IDUser, :EncryptionText, :EncryptionMethod, :DateAdded)';
    ADOQuery1.Parameters.ParamByName('IDUser').Value := FUserID;
    ADOQuery1.Parameters.ParamByName('EncryptionText').Value := EncryptedText;
    ADOQuery1.Parameters.ParamByName('EncryptionMethod').Value :=
      EncryptionMethod;
    ADOQuery1.Parameters.ParamByName('DateAdded').Value := Now;
    ADOQuery1.ExecSQL;
    // ��������� ������� (��� ������ ����, �� ������������ �� ������� � ����������� ������)
    ADOQuery1 := TADOQuery.Create(nil);
    ADOQuery1.Connection := ADOConnection1;
    ADOQuery1.SQL.Text :=
      'SELECT [IDText], [EncryptionText], [EncryptionMethod], [DateAdded] FROM [Text] WHERE [IDUser] = :UserID ORDER BY [DateAdded] ASC';
    ADOQuery1.Parameters.ParamByName('UserID').Value := FUserID;
    ADOQuery1.Open;

    DataSource1 := TDataSource.Create(nil);
    DataSource1.DataSet := ADOQuery1;
    DBGrid1.DataSource := DataSource1;
    DBGrid1.Columns[0].Title.Caption := '����� � ����';
    DBGrid1.Columns[0].Width := 80;
    DBGrid1.Columns[1].Title.Caption := '����������� �����';
    DBGrid1.Columns[1].Width := 215;
    DBGrid1.Columns[2].Title.Caption := '����� ����������';
    DBGrid1.Columns[2].Width := 150;
    DBGrid1.Columns[3].Title.Caption := '���� ��������';
    DBGrid1.Columns[3].Width := 120;

    Edit2.Text := EncryptedText;
    // �-�
    if CheckBox1.Checked then
    begin
      Clipboard.AsText := EncryptedText;
      MessageBox(Handle,
        '������������� ����� ��� ������� �������� � ����� ������!', '�����',
        MB_OK or MB_ICONWARNING)
    end
    else
    begin
      MessageBox(Handle, '��������� ����������� � ��������� � ����!', '�����',
        MB_OK or MB_ICONWARNING);
    end;
    EncryptionMethod := '';

  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  EncryptionMethod, EncryptedText: string;
begin
  // �������� �������� �� ��������� ������ � DBGrid1
  if FSelectedRowIndex > 0 then
  begin
    // ��������� � ��������� ������
    DBGrid1.DataSource.DataSet.RecNo := FSelectedRowIndex;

    // �������� �������� �� ����� ��������� ������
    EncryptionMethod := DBGrid1.Columns[2].Field.AsString;
    EncryptedText := DBGrid1.Columns[1].Field.AsString;

    // �������������� ��������� � ������� ���������� ������
    if EncryptionMethod = '������' then
      MessageBox(Handle, PChar(CaesarCipher(EncryptedText,
        -StrToInt(NumberBox1.Value.ToString))),
        '�������������� ���������', MB_OK)
    else if EncryptionMethod = '���� ������' then
      MessageBox(Handle, PChar(AtbashCipher(EncryptedText)),
        '�������������� ���������', MB_OK)
    else if EncryptionMethod = '���� �������' then
      MessageBox(Handle, PChar(VigenereCipher(EncryptedText, Edit3.Text, False)
        ), '�������������� ���������', MB_OK)
    else if EncryptionMethod = '��������� ����������' then
      MessageBox(Handle, PChar(TableEncryption(EncryptedText, Edit3.Text)),
        '�������������� ���������', MB_OK)
    else if EncryptionMethod = '��������� ����' then
      MessageBox(Handle, PChar(MatrixCipher(EncryptedText, Edit3.Text)),
        '�������������� ���������', MB_OK)
    else
      ShowMessage('����������� ����� ����������!');
  end
  else
    ShowMessage('�������� ������ ��� �����������!');
end;

end.
