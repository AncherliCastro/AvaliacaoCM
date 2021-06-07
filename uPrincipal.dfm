object frm_Principal: Tfrm_Principal
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o T'#233'cnica CM'
  ClientHeight = 483
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    Left = 6
    Top = 3
    Width = 561
    Height = 481
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '1'
      object Label5: TLabel
        Left = 3
        Top = 12
        Width = 40
        Height = 13
        Caption = 'Servidor'
      end
      object Label4: TLabel
        Left = 3
        Top = 59
        Width = 65
        Height = 13
        Caption = 'Banco (Novo)'
      end
      object Label6: TLabel
        Left = 170
        Top = 12
        Width = 36
        Height = 13
        Caption = 'Usuario'
      end
      object btnConsultaPostagens: TButton
        Left = 3
        Top = 117
        Width = 126
        Height = 36
        Caption = 'Consulta Postagens'
        TabOrder = 0
        OnClick = btnConsultaPostagensClick
      end
      object mmoListarPostagens: TMemo
        Left = 3
        Top = 159
        Width = 547
        Height = 247
        Lines.Strings = (
          '')
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object btnGravar: TButton
        Left = 437
        Top = 415
        Width = 113
        Height = 35
        Caption = 'Gravar'
        TabOrder = 2
        OnClick = btnGravarClick
      end
      object edtServidor: TEdit
        Left = 3
        Top = 28
        Width = 161
        Height = 21
        TabOrder = 3
      end
      object edtBanco: TEdit
        Left = 3
        Top = 74
        Width = 121
        Height = 21
        TabOrder = 4
      end
      object edtUsuarioBanco: TEdit
        Left = 170
        Top = 28
        Width = 87
        Height = 21
        TabOrder = 5
      end
      object Button1: TButton
        Left = 263
        Top = 26
        Width = 66
        Height = 25
        Caption = 'Conectar'
        TabOrder = 6
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 130
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Criar Banco'
        TabOrder = 7
        OnClick = Button2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = '2'
      ImageIndex = 1
      object Label2: TLabel
        Left = 3
        Top = 2
        Width = 49
        Height = 13
        Caption = 'Id Usu'#225'rio'
      end
      object Label1: TLabel
        Left = 3
        Top = 40
        Width = 60
        Height = 13
        Caption = 'Id Postagem'
      end
      object Label3: TLabel
        Left = 3
        Top = 78
        Width = 76
        Height = 13
        Caption = 'T'#237'tulo Postagem'
      end
      object Label7: TLabel
        Left = 3
        Top = 116
        Width = 47
        Height = 13
        Caption = 'Postagem'
      end
      object edtCodigoUsuario: TEdit
        Left = 3
        Top = 16
        Width = 62
        Height = 21
        TabOrder = 0
      end
      object dbgListaPostagens: TDBGrid
        Left = 0
        Top = 257
        Width = 545
        Height = 193
        Hint = 'Clique duas vezes para editar um registro'
        DataSource = dsPostagens
        DrawingStyle = gdsGradient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = dbgListaPostagensDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_USER'
            Title.Caption = 'Id Usu'#225'rio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID'
            Title.Caption = 'Id Postagem'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TITULO_POSTAGEM'
            Title.Caption = 'T'#237'tulo Postagem'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'POSTAGEM'
            Title.Caption = 'Postagem'
            Width = 500
            Visible = True
          end>
      end
      object btnExibir: TButton
        Left = 3
        Top = 226
        Width = 75
        Height = 25
        Caption = 'Exibir'
        TabOrder = 2
        OnClick = btnExibirClick
      end
      object edtCodigo: TEdit
        Left = 3
        Top = 55
        Width = 62
        Height = 21
        Enabled = False
        TabOrder = 3
      end
      object btnAlterar: TButton
        Left = 103
        Top = 226
        Width = 82
        Height = 25
        Caption = 'Alterar'
        TabOrder = 4
        OnClick = btnAlterarClick
      end
      object btnExcluir: TButton
        Left = 200
        Top = 226
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 5
        OnClick = btnExcluirClick
      end
      object edtTituloPostagem: TEdit
        Left = 3
        Top = 94
        Width = 542
        Height = 21
        TabOrder = 6
      end
      object mmoPostagem: TMemo
        Left = 3
        Top = 132
        Width = 542
        Height = 89
        Lines.Strings = (
          '')
        TabOrder = 7
      end
    end
    object TabSheet3: TTabSheet
      Caption = '3'
      ImageIndex = 2
      object mmoLog: TMemo
        Left = 0
        Top = 0
        Width = 553
        Height = 453
        Align = alClient
        Enabled = False
        TabOrder = 0
      end
    end
  end
  object dsPostagens: TDataSource
    DataSet = FDQuery
    Left = 648
    Top = 160
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 688
    Top = 48
  end
  object FDQuery: TFDQuery
    SQL.Strings = (
      'SELECT ID_USER, ID, TITULO_POSTAGEM, POSTAGEM FROM POSTS')
    Left = 644
    Top = 104
  end
end
