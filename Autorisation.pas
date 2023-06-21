// ��������� ������ � ������ ������������ ��������� � �����������
unit Autorisation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, MainForm, Registration;

// ��������� ����� �����
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

  // ��������� ���������� �����
var
  Form1: TForm1;
  MainForm: TForm2; // ������ ������ ������� �����
  Registration: TForm4; // ������ ������ ������� �����

  // ��������� ������ ������ �����
implementation

// ���������� ���� � ��������� �����
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

// �����, ������� ���������� ��� ������� �� ������ "����"
procedure TForm1.btnLoginClick(Sender: TObject);
var
  Query: TADOQuery; // ������ TADOQuery ��� ���������� ������� � ���� ������
begin
  // ���������, ��� ���� ���������
  if (edtLogin.Text = '') or (edtPassword.Text = '') then
  begin
    // ������� ��������� �� ������
    MessageBox(Handle, '����������, ������� ������ � ��������� ����!',
      '��������������', MB_OK or MB_ICONWARNING);
    Exit; // ������� �� ���������
  end;

  // ��������� � ���� ������
  Query := TADOQuery.Create(nil); // ������� ������ TADOQuery
  try
    Query.Connection := ADOConnection1;
    // ������������� ���������� � ����� ������
    Query.SQL.Text :=
      'SELECT Name, Role, IDUser FROM Users WHERE Login = :Login AND Password = :Password';
    // ������������� ����� �������
    Query.Parameters.ParamByName('Login').Value := edtLogin.Text;
    // ������������� �������� :Login ��� �������
    Query.Parameters.ParamByName('Password').Value := edtPassword.Text;
    // ������������� �������� :Password ��� �������
    Query.Open; // ��������� ������

    if Query.Eof then
    // ���� ������ �� ������ ������� �����, ������ ����� �/��� ������ �� ������
    begin
      MessageBox(Handle, '�������� ����� ��� ������!', '��������������',
        MB_OK or MB_ICONWARNING);
      Exit;
    end;

    // ������� ������ ������ ������� ����� � �������� ������ �� �������
    MainForm := TForm2.Create(nil);
    // ������� ����� ����� ���� TForm2 � �������� nil ��� ������������ ���������
    MainForm.UserName := Query.FieldByName('Name').AsString;
    // ����������� ���� UserName �������� ���� Name �� ������� ������� Query
    MainForm.UserRole := Query.FieldByName('Role').AsString;
    // ����������� ���� UserRole �������� ���� Role �� ������� ������� Query
    MainForm.UserID := Query.Fields[2].AsInteger;
    // ����������� ���� UserID �������� �������� ���� �� ������� ������� Query, ����������� � �������������� ����
    // ��������� ������� ����� � ��������� �������
    MainForm.Show; // ���������� ��������� ����� MainForm
    Hide; // �������� ������� ����� (������ ����� ��� ������� �����, �� ��� �� ������� � ������ ����)
  finally
    Query.Free; // ����������� ������ TADOQuery, ����� �������� ������ ������
  end;
end;

// ���������� ������� ������� ������ ���� �� �����
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
  // ����������� ������ ����, ������� ��� ���������� � ��������� OnMouseDown
  Perform(WM_SYSCOMMAND, $F012, 0);
  // ��������� ������� ���������� ���� "��������������"
end;

// ���������� ������� ���������� ������ ���� �� �����
procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  // ����������� ������ ����, ������� ��� ���������� � ��������� OnMouseDown
end;

// ���������� ������� ������� �� ������ "������������������"
procedure TForm1.btnRegisterClick(Sender: TObject);
begin
  Registration := TForm4.Create(nil);
  // ������� ����� ����� ���� TForm4 � �������� nil ��� ������������ ���������
  Registration.Show; // ���������� ��������� ����� Registration
end;

// ���������� ������� ��������� ��������� ��������
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    edtPassword.PasswordChar := #0
    // ���� ������� ������, �� ���������� ������ � �������� ����
  else
    edtPassword.PasswordChar := '�';
  // ���� ������� �� ������, �� ���������� ������� ������ � ���� ���������
end;

end. // ����� �������� ������ ����� (TForm1)
