unit Autorisation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, Data.Win.ADODB, MainForm, Registration;


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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MainForm: TForm2;      // ������ ������ ������� �����
  Registration: TForm4;      // ������ ������ ������� �����
implementation

{$R *.dfm}


procedure TForm1.btnLoginClick(Sender: TObject);
var
  Query: TADOQuery;         // ������ TADOQuery ��� ���������� ������� � ���� ������
begin
  // ���������, ��� ���� ���������
  if (edtLogin.Text = '') or (edtPassword.Text = '') then
  begin
    MessageBox(Handle, '����������, ������� ������ � ��������� ����!', '��������������', MB_OK or MB_ICONWARNING);
    Exit;
  end;

  // ��������� � ���� ������
  Query := TADOQuery.Create(nil);      // ������� ������ TADOQuery
  try
    Query.Connection := ADOConnection1;   // ������������� ���������� � ����� ������
    Query.SQL.Text := 'SELECT Name, Role, IDUser FROM Users WHERE Login = :Login AND Password = :Password';  // ������������� ����� �������
    Query.Parameters.ParamByName('Login').Value := edtLogin.Text;    // ������������� �������� :Login ��� �������
    Query.Parameters.ParamByName('Password').Value := edtPassword.Text;  // ������������� �������� :Password ��� �������
    Query.Open;   // ��������� ������

    if Query.Eof then    // ���� ������ �� ������ ������� �����, ������ ����� �/��� ������ �� ������
    begin
    MessageBox(Handle, '�������� ����� ��� ������!', '��������������', MB_OK or MB_ICONWARNING);
      Exit;
    end;
// ������� ������ ������ ������� ����� � �������� ������ �� �������
    MainForm := TForm2.Create(nil);
    MainForm.UserName := Query.FieldByName('Name').AsString;
    MainForm.UserRole := Query.FieldByName('Role').AsString;
    MainForm.UserID := Query.Fields[2].AsInteger;
    // ��������� ������� ����� � ��������� �������
    MainForm.Show;
    Hide;
  finally
    Query.Free;    // ����������� ������ TADOQuery
  end;

end;
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
end;

procedure TForm1.btnRegisterClick(Sender: TObject);
begin
Registration := TForm4.Create(nil);
Registration.Show;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    edtPassword.PasswordChar := #0
  else
    edtPassword.PasswordChar := '�';
end;

end.
