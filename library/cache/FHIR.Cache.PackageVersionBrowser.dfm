object PackageVersionChooserForm: TPackageVersionChooserForm
  Left = 0
  Top = 0
  Caption = 'Select Version'
  ClientHeight = 472
  ClientWidth = 860
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 860
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 10
      Width = 24
      Height = 13
      Caption = 'Filter'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 432
    Width = 860
    Height = 40
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 434
    DesignSize = (
      860
      40)
    object btnInstall: TButton
      Left = 681
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Install'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object btnClose: TButton
      Left = 771
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 860
    Height = 391
    Align = alClient
    Caption = 'Panel3'
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 2
    object grid: TVirtualStringTree
      Left = 11
      Top = 11
      Width = 838
      Height = 369
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Height = 17
      Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowSortGlyphs, hoVisible]
      TabOrder = 0
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnAddToSelection = gridAddToSelection
      OnDblClick = gridDblClick
      OnGetText = gridGetText
      OnHeaderClick = gridHeaderClick
      OnRemoveFromSelection = gridRemoveFromSelection
      Columns = <
        item
          Position = 0
          Width = 120
          WideText = 'Package Id'
        end
        item
          Position = 1
          Width = 60
          WideText = 'Version'
        end
        item
          Position = 2
          Width = 150
          WideText = 'Description'
        end
        item
          Position = 3
          Width = 350
          WideText = 'Canonical'
        end
        item
          Position = 4
          Width = 60
          WideText = 'FHIR Version'
        end
        item
          Position = 5
          Width = 80
          WideText = 'Date'
        end>
    end
  end
end
