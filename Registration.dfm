object Form4: TForm4
  Left = 0
  Top = 0
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  ClientHeight = 275
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 96
    Top = 16
    Width = 132
    Height = 21
    Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 140
    Width = 53
    Height = 21
    Caption = #1055#1072#1088#1086#1083#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 128
    Top = 78
    Width = 44
    Height = 21
    Caption = #1051#1086#1075#1080#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtName: TEdit
    Left = 75
    Top = 43
    Width = 169
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtNameKeyPress
  end
  object edtPassword: TEdit
    Left = 75
    Top = 167
    Width = 169
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    PasswordChar = #8226
    TabOrder = 1
    OnKeyPress = edtPasswordKeyPress
  end
  object btnRegister: TButton
    Left = 75
    Top = 236
    Width = 169
    Height = 31
    Caption = #1056#1045#1043#1048#1057#1058#1056#1040#1062#1048#1071
    TabOrder = 2
    OnClick = btnRegisterClick
  end
  object edtLogin: TEdit
    Left = 75
    Top = 105
    Width = 169
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnKeyPress = edtLoginKeyPress
  end
  object CheckBox1: TCheckBox
    Left = 75
    Top = 202
    Width = 118
    Height = 17
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 296
    Top = 248
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\tungu\OneD' +
      'rive\'#1056#1072#1073#1086#1095#1080#1081' '#1089#1090#1086#1083'\CipherMaster-master\Data\data_clear.mdb;Persis' +
      't Security Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 264
    Top = 248
  end
end
