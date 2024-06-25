object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 647
  ClientWidth = 1111
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object lblEntrada: TLabel
    Left = 8
    Top = 187
    Width = 38
    Height = 13
    Caption = 'Entrada'
  end
  object lbl_Fim: TLabel
    Left = 375
    Top = 192
    Width = 32
    Height = 24
    Caption = 'Fim'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 170
    Top = 24
    Width = 332
    Height = 46
    Caption = 'Analisador Sint'#225'tico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -38
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 200
    Top = 76
    Width = 250
    Height = 21
    Caption = 'Autor: Vicente Chinazzo Lorenzon'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edt_Entrada: TEdit
    Left = 8
    Top = 206
    Width = 246
    Height = 21
    TabOrder = 0
    OnChange = edt_EntradaChange
    OnKeyPress = edt_EntradaKeyPress
  end
  object btn_Gerar: TButton
    Left = 89
    Top = 237
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = btn_GerarClick
  end
  object btn_Avancar: TButton
    Left = 8
    Top = 237
    Width = 75
    Height = 25
    Caption = 'Avan'#231'ar'
    TabOrder = 2
    OnClick = btn_AvancarClick
  end
  object dbg_Derivacao: TDBGrid
    Left = 8
    Top = 268
    Width = 1095
    Height = 371
    DataSource = src_Derivacao
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btn_Limpar: TButton
    Left = 469
    Top = 237
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 4
    OnClick = btn_LimparClick
  end
  object sg_Tabela: TStringGrid
    Left = 702
    Top = 8
    Width = 401
    Height = 133
    ColCount = 6
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 767
    Top = 152
    Width = 150
    Height = 113
    Color = clWindow
    ParentBackground = False
    TabOrder = 6
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 148
      Height = 111
      Align = alClient
      Caption = 
        ' Gram'#225'tica:'#13#10#13#10' S -> aCb'#13#10' A -> bBd | aSa'#13#10' B -> cAd | '#949#13#10' C -> ' +
        'aSb | cBa'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitLeft = 0
    end
  end
  object Panel4: TPanel
    Left = 923
    Top = 152
    Width = 82
    Height = 112
    Color = clWindow
    ParentBackground = False
    TabOrder = 7
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 80
      Height = 110
      Align = alClient
      Caption = ' First:'#13#10#13#10' S = {a}'#13#10' A = {b, a}'#13#10' B = {c, '#949'}'#13#10' C = {a, c}'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 63
      ExplicitHeight = 96
    end
  end
  object Panel3: TPanel
    Left = 1011
    Top = 152
    Width = 92
    Height = 111
    Color = clWindow
    ParentBackground = False
    TabOrder = 8
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 90
      Height = 109
      Align = alClient
      Caption = ' Follow:'#13#10#13#10' S = {$, b, a}'#13#10' A = {d}'#13#10' B = {d, a}'#13#10' C = {b}'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 78
      ExplicitHeight = 96
    end
  end
  object rdg_Exemplos: TRadioGroup
    Left = 550
    Top = 184
    Width = 211
    Height = 78
    Caption = 'Exemplos'
    Columns = 2
    Items.Strings = (
      'accbddab'
      'aaacabbb'
      'acab'
      'accbcbddddab'
      'ab'
      'aaaccb')
    TabOrder = 9
    OnClick = rdg_ExemplosClick
  end
  object btn_TokenAleatorio: TButton
    Left = 170
    Top = 237
    Width = 129
    Height = 25
    Caption = 'Token aleat'#243'rio'
    TabOrder = 10
    OnClick = btn_TokenAleatorioClick
  end
  object btn_GeraTokenValido: TButton
    Left = 305
    Top = 237
    Width = 158
    Height = 25
    Caption = 'Token aleat'#243'rio v'#225'lido'
    TabOrder = 11
    OnClick = btn_GeraTokenValidoClick
  end
  object src_Derivacao: TDataSource
    DataSet = cds_Derivacao
    Left = 936
    Top = 552
  end
  object cds_Derivacao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 896
    Top = 552
  end
end
