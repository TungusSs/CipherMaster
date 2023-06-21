object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1064#1080#1092#1088#1072#1090#1086#1088
  ClientHeight = 504
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Label4: TLabel
    Left = 376
    Top = 232
    Width = 342
    Height = 30
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1091#1085#1082#1090' '#1084#1077#1085#1102' '#1076#1083#1103' '#1088#1072#1073#1086#1090#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object AccountPanel: TPanel
    Left = 217
    Top = 0
    Width = 683
    Height = 504
    Align = alClient
    BiDiMode = bdLeftToRight
    Color = clWhite
    ParentBiDiMode = False
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    Visible = False
    ExplicitWidth = 679
    ExplicitHeight = 503
    object Label3: TLabel
      Left = 14
      Top = 10
      Width = 142
      Height = 15
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1072#1082#1082#1072#1091#1085#1090#1077
    end
    object Label5: TLabel
      Left = 16
      Top = 52
      Width = 62
      Height = 30
      Caption = 'Label5'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object AdminPanel: TPanel
    Left = 217
    Top = 0
    Width = 683
    Height = 504
    Align = alClient
    BiDiMode = bdLeftToRight
    Caption = 'AdminPanel'
    Color = clWhite
    ParentBiDiMode = False
    ParentBackground = False
    ShowCaption = False
    TabOrder = 3
    Visible = False
    ExplicitWidth = 679
    ExplicitHeight = 503
    object Label2: TLabel
      Left = 14
      Top = 10
      Width = 135
      Height = 15
      Caption = #1055#1072#1085#1077#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
    end
    object Label9: TLabel
      Left = 6
      Top = 102
      Width = 98
      Height = 15
      Caption = #1042#1089#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
    end
    object Button6: TButton
      Left = 528
      Top = 92
      Width = 147
      Height = 25
      Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1088#1072#1074#1072' '#1076#1086#1089#1090#1091#1087#1072
      TabOrder = 0
      OnClick = Button6Click
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 123
      Width = 681
      Height = 380
      Align = alBottom
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGrid2CellClick
    end
  end
  object ShifrPanel: TPanel
    Left = 217
    Top = 0
    Width = 683
    Height = 504
    Align = alClient
    Alignment = taLeftJustify
    BiDiMode = bdLeftToRight
    Caption = #1064#1080#1092#1088#1072#1090#1086#1088
    Color = clWhite
    Ctl3D = True
    DoubleBuffered = False
    ParentBiDiMode = False
    ParentBackground = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ShowCaption = False
    TabOrder = 1
    Visible = False
    ExplicitWidth = 679
    ExplicitHeight = 503
    object Label1: TLabel
      Left = 14
      Top = 10
      Width = 125
      Height = 15
      Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1096#1080#1092#1088#1072#1090#1086#1088#1086#1084
    end
    object ShifrAdd: TPanel
      Left = 155
      Top = 57
      Width = 505
      Height = 153
      BevelOuter = bvNone
      Caption = 'Add'
      ShowCaption = False
      TabOrder = 1
      Visible = False
      object Label6: TLabel
        Left = 16
        Top = 8
        Width = 117
        Height = 15
        Caption = #1052#1072#1089#1090#1077#1088' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103
      end
      object Label7: TLabel
        Left = 16
        Top = 29
        Width = 166
        Height = 15
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1084#1077#1090#1086#1076' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103
      end
      object Label8: TLabel
        Left = 16
        Top = 75
        Width = 172
        Height = 15
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090' '#1076#1083#1103' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103
      end
      object Label10: TLabel
        Left = 227
        Top = 75
        Width = 127
        Height = 15
        Caption = #1047#1072#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090
      end
      object Label11: TLabel
        Left = 208
        Top = 29
        Width = 76
        Height = 15
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1089#1076#1074#1080#1075
        Visible = False
      end
      object Label12: TLabel
        Left = 208
        Top = 29
        Width = 138
        Height = 15
        Caption = #1042#1074#1077#1076#1080#1090#1077' '#1089#1077#1082#1088#1077#1090#1085#1086#1077' '#1089#1083#1086#1074#1086
        Visible = False
      end
      object ComboBox1: TComboBox
        Left = 16
        Top = 50
        Width = 169
        Height = 23
        TabOrder = 0
        Text = #1062#1077#1079#1072#1088#1100
        OnSelect = ComboBox1Select
        Items.Strings = (
          #1062#1077#1079#1072#1088#1100
          #1064#1080#1092#1088' '#1040#1090#1073#1072#1096#1072
          #1064#1080#1092#1088' '#1042#1080#1078#1085#1077#1088#1072
          #1052#1072#1090#1088#1080#1095#1085#1099#1081' '#1096#1080#1092#1088)
      end
      object Edit1: TEdit
        Left = 16
        Top = 96
        Width = 169
        Height = 23
        TabOrder = 1
      end
      object Button1: TButton
        Left = 233
        Top = 125
        Width = 113
        Height = 25
        Caption = #1064#1080#1092#1088#1086#1074#1072#1085#1080#1077
        TabOrder = 2
        OnClick = Button1Click
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 125
        Width = 185
        Height = 28
        Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        TabOrder = 3
      end
      object Edit2: TEdit
        Left = 207
        Top = 96
        Width = 169
        Height = 23
        ReadOnly = True
        TabOrder = 4
      end
      object NumberBox1: TNumberBox
        Left = 208
        Top = 50
        Width = 159
        Height = 23
        MinValue = 1.000000000000000000
        MaxValue = 26.000000000000000000
        TabOrder = 5
        Value = 1.000000000000000000
        Visible = False
      end
      object Edit3: TEdit
        Left = 208
        Top = 50
        Width = 169
        Height = 23
        TabOrder = 6
        Visible = False
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 216
      Width = 681
      Height = 287
      Align = alBottom
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
    end
    object brnAddShifr: TButton
      Left = 16
      Top = 48
      Width = 133
      Height = 33
      Caption = #1047#1072#1096#1080#1092#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
      TabOrder = 2
      OnClick = brnAddShifrClick
    end
    object btnDeleteShifr: TButton
      Left = 16
      Top = 126
      Width = 133
      Height = 33
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
      OnClick = btnDeleteShifrClick
    end
    object Button2: TButton
      Left = 16
      Top = 87
      Width = 133
      Height = 33
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 544
      Top = 6
      Width = 133
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1079#1072#1087#1080#1089#1080
      TabOrder = 5
      Visible = False
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 336
      Top = 6
      Width = 202
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1079#1072#1087#1080#1089#1080' '#1042#1072#1096#1077#1075#1086' '#1072#1082#1082#1072#1091#1085#1090#1072
      TabOrder = 6
      Visible = False
      OnClick = Button5Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 504
    Align = alLeft
    ShowCaption = False
    TabOrder = 0
    VerticalAlignment = taAlignBottom
    ExplicitHeight = 503
    object labelLogo: TLabel
      Left = 8
      Top = 8
      Width = 103
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = #1052#1072#1089#1090#1077#1088' '#1064#1080#1092#1088#1086#1074
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object nameUser: TLabel
      Left = 8
      Top = 31
      Width = 53
      Height = 15
      Caption = 'nameUser'
    end
    object statusAdmin: TLabel
      Left = 8
      Top = 52
      Width = 168
      Height = 15
      Caption = #1042#1099' '#1074#1086#1096#1083#1080' '#1082#1072#1082' '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
      Visible = False
    end
    object ShifrShow: TButton
      Left = 8
      Top = 73
      Width = 193
      Height = 41
      Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1096#1080#1092#1088#1072#1090#1086#1088#1086#1084
      TabOrder = 0
      OnClick = ShifrShowClick
    end
    object AccountShow: TButton
      Left = 8
      Top = 135
      Width = 193
      Height = 41
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1072#1082#1082#1072#1091#1085#1090#1077
      TabOrder = 1
      OnClick = AccountShowClick
    end
    object AdminShow: TButton
      Left = 8
      Top = 200
      Width = 193
      Height = 41
      Caption = #1055#1072#1085#1077#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
      TabOrder = 2
      Visible = False
      OnClick = AdminShowClick
    end
    object Button3: TButton
      Left = 76
      Top = 475
      Width = 135
      Height = 24
      Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 809
    Top = 472
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 872
    Top = 472
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\tungu\OneD' +
      'rive\'#1056#1072#1073#1086#1095#1080#1081' '#1089#1090#1086#1083'\CipherMaster-master\Data\data_clear.mdb;Persis' +
      't Security Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 840
    Top = 472
  end
end
