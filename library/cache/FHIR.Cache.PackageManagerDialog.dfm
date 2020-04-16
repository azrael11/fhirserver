object PackageCacheForm: TPackageCacheForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'FHIR Package Cache Manager'
  ClientHeight = 597
  ClientWidth = 916
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 549
    Width = 916
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    OnClick = Panel1Click
    DesignSize = (
      916
      48)
    object lblFolder: TLabel
      Left = 16
      Top = 14
      Width = 40
      Height = 13
      Cursor = crHandPoint
      Caption = 'lblFolder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblFolderClick
    end
    object lblDownload: TLabel
      Left = 16
      Top = 6
      Width = 57
      Height = 13
      Caption = 'lblDownload'
      Visible = False
    end
    object Button1: TButton
      Left = 835
      Top = 18
      Width = 74
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ModalResult = 8
      TabOrder = 0
      OnClick = Button1Click
    end
    object pbDownload: TProgressBar
      Left = 16
      Top = 21
      Width = 489
      Height = 17
      TabOrder = 1
      Visible = False
    end
    object btnCancel: TButton
      Left = 527
      Top = 18
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      Visible = False
      OnClick = btnCancelClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 916
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 35
      Height = 13
      Caption = 'Files in '
    end
    object RadioButton1: TRadioButton
      Left = 72
      Top = 13
      Width = 106
      Height = 17
      Caption = 'User Cache'
      TabOrder = 0
      OnClick = RadioButton2Click
    end
    object RadioButton2: TRadioButton
      Left = 184
      Top = 13
      Width = 113
      Height = 17
      Caption = 'System Cache'
      TabOrder = 1
      OnClick = RadioButton2Click
    end
  end
  object Panel3: TPanel
    Left = 804
    Top = 41
    Width = 112
    Height = 508
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      112
      508)
    object Button2: TButton
      Left = 6
      Top = 31
      Width = 99
      Height = 25
      Caption = 'Import File'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 6
      Top = 62
      Width = 99
      Height = 25
      Caption = 'Import URL'
      TabOrder = 1
      OnClick = Button3Click
    end
    object btnDelete: TButton
      Left = 6
      Top = 136
      Width = 99
      Height = 25
      Caption = 'Delete'
      Enabled = False
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object Button4: TButton
      Left = 6
      Top = 0
      Width = 99
      Height = 25
      Caption = 'Find Packages'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 6
      Top = 93
      Width = 99
      Height = 25
      Caption = 'Common'
      TabOrder = 4
      OnClick = Button5Click
    end
    object btnReload: TButton
      Left = 6
      Top = 451
      Width = 99
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = 'Reload'
      TabOrder = 5
      OnClick = btnReloadClick
    end
    object Button7: TButton
      Left = 6
      Top = 478
      Width = 99
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = 'Copy Report'
      TabOrder = 6
      OnClick = Button7Click
    end
  end
  object vtPackages: TVirtualStringTree
    Left = 0
    Top = 41
    Width = 804
    Height = 508
    Align = alClient
    Header.AutoSizeIndex = 5
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Height = 20
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 0
    Images = ImageList1
    TabOrder = 3
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnAddToSelection = vtPackagesAddToSelection
    OnDblClick = vtPackagesDblClick
    OnGetText = vtPackagesGetText
    OnGetImageIndex = vtPackagesGetImageIndex
    OnHeaderClick = vtPackagesHeaderClick
    OnInitNode = vtPackagesInitNode
    OnKeyDown = vtPackagesKeyDown
    OnRemoveFromSelection = vtPackagesRemoveFromSelection
    Columns = <
      item
        Position = 0
        Width = 220
        WideText = 'ID'
      end
      item
        Position = 1
        Width = 100
        WideText = 'Version'
      end
      item
        Position = 2
        Width = 100
        WideText = 'FHIR V'
      end
      item
        Position = 3
        Width = 180
        WideText = 'Age'
      end
      item
        Position = 4
        Width = 100
        WideText = 'Size'
      end
      item
        Position = 5
        Width = 100
        WideText = 'Dependencies'
      end>
  end
  object ImageList1: TImageList
    Left = 120
    Top = 393
    Bitmap = {
      494C01010800B800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DCFCFF00A4F5FF009CF3FF006FEFFF00ECFDFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000B0DF
      F200000000000000000000000000000000000000000000000000000000000000
      0000AAD1EC00F9FBFD0000000000000000000000000000000000000000000000
      0000B2817800AD7E7600AD7E7600AD7E7600AD7E7600A7787400A7787400A778
      7400A7787400A7787400A778740000000000000000006C9BC5006C9CC5006C9B
      C5006C9BC5006C9BC5006B99C4006C9AC4006A98C33867A1CA9E6097BD83608B
      B6006896C0006B9AC4006695BF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FCFFFF00A6F4FF00A0F5FF0062EDFF00E2FBFF0096F3FF0009E3FF00D6FA
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000032AF
      DF0030ACDD0087CEEB000000000000000000000000000000000099CDEB00218F
      D2000C81CC000000000000000000000000000000000000000000000000000000
      0000B2817800FFE4B900FFE4B900FFE4B900FFE4B900FFE4B900FFE4B900FFE4
      B900FFE4B900FFE4B900A778740000000000000000006C9BC5006B9AC4006B99
      C4006B99C3086695C05C5D90BCAF568FBBE34C8AB2FF57A5CAFF457BA9FF446C
      9BD85F8CB6556D9DC8006797C10000000000FFFFFF00FFFFFF00FFFFFF00D8FC
      FF008EEDFE0036E0FE00ADF2FF0050E6FF00C3F7FF004EE6FE0000D9FE0030E0
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000043B8
      E20050CBEF0039B7E5002AA9DC0073C4E70081C9E900259DD8002AA3DD0039AE
      E500198CD0000000000000000000000000000000000000000000000000000000
      00007E5D5500B2A08500B2A08500B2A08500B2A08500B2A08500B2A08500B2A0
      8500B2A08500FFE4B900A778740000000000000000006998C3286293BF88598B
      B9CA4D80B1F14779ACFF4A7EAFFF4E88B8FF43789CFF4E91B5FF4C88B7FF3D69
      9BFF396393FF4D7AA8C9608FBA3C00000000FFFFFF00FFFFFF00FFFFFF0078EB
      FE0010C5FB007DE7FE00A8EBFD0008C9FB0099F1FF008FEFFF0003C8FB0022CF
      FC00C4F2FE00FFFFFF00FFFFFF00FFFFFF000000000000000000000000005BC2
      E6004DCAEE0054CEF10050C8EF0040BAE80039B5E50046BDEB0044BAEB003EB3
      E8002B99D600000000000000000000000000000000009A666600FFFFFF009A66
      6600FFFFFF009A666600FFFFFF009A666600FFFFFF009A666600FFFFFF009A66
      6600B2A28900FFE8C500A778740000000000000000005B8FBCC5508EBBFF4D87
      B7FF4A80B1FF467AA9FF4475A6FF4372A0FF3D6890FF4C88B1FF5192BFFF4A7F
      B1FF4270A3FF396494FF3A6594F800000000FFFFFF00FFFFFF00C9F1FE003FCE
      FB001FB0F50066EAFF007FD7FA0048C8F9002EC8FA0072EFFF0008B6F7009ADE
      FB00AFE8FD00FFFFFF00FFFFFF00FFFFFF000000000000000000000000007ACF
      EC0049C8EC0049CCF10031C3ED0042C4EE0046C3ED002CB6EA0026B1E8003CB4
      E70045AADC0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2A28900FFEACB00AD7E760000000000000000005C92BEC95499C3FF4F8E
      BBFF4B85B3FF4577A3FF406E9AFF3B6690FF365D84FF477FACFF58A1CEFF5191
      C1FF4A7EB1FF4472A6FF406B9DFC00000000FFFFFF00FFFFFF0079CAF8005FBD
      F7002592F0004BF1FF0007A2F300DBEFFD001D9CF10029C4F90010A9F40062B9
      F600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000009ADC
      F10044C6EA0057D2F20027C2ED0023BDEC001FB7EA001BB3E90036B9EA003AB3
      E60066BDE400000000000000000000000000000000009A666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A66
      6600B2A89800FFEED200AD7E760000000000000000005E96C0C357A3CCFF5295
      C0FF4A86AFFF4579A3FF3F6E95FF396288FF375E86FF467EAFFF60B7E3FF58A2
      CEFF4D88B8FF497DB0FF4978ABF600000000FFFFFF00FFFFFF0085B8F50074AB
      F300286DEA0056E0FD0000C7FB004584ED00AACDF8001373EB000C85EE005E9F
      F200FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000F5FBFD0045C1
      E60059D5F20046D0F20029C4EE0025C0ED0022BBEB001DB6E90021B4E90046BD
      EB0029A6DB00E5F4FA00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2A89800FFF0DA00AD7E760000000000000000006098C2C35CADD2FF539B
      C1FF4883A8FF457FA4FF447AA4FF4780ADFF487DAEFF5588B8FF6AC0E9FF69CE
      FAFF5399C5FF4C85B4FF4D7FB1F600000000FFFFFF00FFFFFF00E0E7FC005D72
      EC006578EC002E7BEE0012E0FF00079AF500999CF100416DEA001448E4007897
      F000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FAFDFE004CC7E8004ACE
      ED005EDBF50030CDF1002CC8EF0027C2ED0024BEEC0020B8EA001CB4E90049C0
      EC0037B2E4002DA7DC00EBF6FB0000000000000000009A666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A66
      6600B2AA9E00FFF4E200B18177000000000000000000619AC4C35FB9DBFF58AC
      D0FF4E9DC2FF529AC0FE5591B8FE5081ACFF4C79A3FE3F6289FF466F8AFF4787
      B5FF49A4E1FF5EADDAFF528DBDF800000000FFFFFF00FFFFFF00FEFEFF00716B
      EC00D2D0F9001718E2001FB6F90000B6FB002E58EB00AEAEF5000A0BDF00ABAC
      F400FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000054CDEB004CD2EE0063E1
      F60041D6F40032CFF2002ECBF0002AC6EF0026C1ED0022BCEB001FB7EA0020B4
      E90047BEEC0036B2E40031AADD00EFF8FC0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2ACA300FFF7E900B281780000000000000000005F9EC5D770D8EDFF5AAE
      D3FD5D9FC2FB5E8BB1FB4675A0FD4A81A7FF3C7096FF265081FF25634FFF566E
      39FF656060FE3A6FA0FF5A98C3FF00000000FFFFFF00FFFFFF00FFFFFF00E8E7
      FC007771ED009991F1001442E80002B9F9000156EA00B9B6F6002F24E300D5D3
      FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF005DD2ED004DD5EF0058DCF2005EDE
      F50060DEF5005FDCF60048D4F3002DC9EF0029C4EE0035C4ED0050C8EF004CC4
      EE0045BEEB003DB7E70033B0E20036ACDD00000000009A666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A66
      6600B2AEA800FFF9F000B9887B0000000000000000005B96C57D5697C9E57794
      B3F7C3B8B8FF4C6588FF2E659BFF56B1D2FF519FC1FF3F74ADFF267958FF5E91
      37FFFF7423FF302C39DF174E838800000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F1F0FD00B3AFF5005F53E900123DE800077AF0006965EC00908BF000FCFC
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F5FCFE00B5EBF7007FDBF0005AD0
      EC0041C7E80049CEED005BD9F40047D3F2003ACBF00055CFF1003EBFE80035B6
      E2004ABCE4006EC7E900A2DBF000E6F5FB0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2AEA800FFFFFF00B9887B0000000000000000008CAAC900708DAE00CAC7
      C9DBDAD1C9FA3B6291F0477DACFF61A8CAFF477DA1FF2D5B90E437606DE45871
      5FAFC07A4DD8A973543C17426E0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F9F8FE003D34E6000B3BE9005150E900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000009CE1F30049CEED005DD9F40059D6F30043C5EA0078D1EC000000
      000000000000000000000000000000000000000000009A666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A66
      6600B2B1AF00FFFFFF00C3917D000000000000000000E0D9D40AD0C5BEC1D0CC
      C5FFBBBABAFD7790A9604272A19E466E9AA83C65924A30608E006D7184848778
      7A537F8A947197938E957272720000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAE9FC001A20E4007584F100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000047C9E90056D6F20059D6F30039C0E500FAFDFE000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B2B2B200FFFFFF00C3917D000000000000000000D4D2D2CDCCC8C8FF8384
      86D1C4C1BEFADACFC4DE7B91A4003F73A400366DA100697C8E008A80779F7878
      7884898A8A21838586C97B78740000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FDFDFF005F55EB00A0B5F600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000BCECF70048CEED0048CDED009BE0F200000000000000
      000000000000000000000000000000000000000000009A666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A66
      6600906C5B00CE9B8200CE9B82000000000000000000BDBCBCFFDFDCDCE60000
      0000AFB0B1A9C7C5C3C5C4B9B000698CAC0050739500918A85007C7A78AE7878
      78A678787800999999FC9A9A9A9200000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFF009B95F200DCE8FD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000057D0EC0047CAEA0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000B8B8B87ED9D7D7EB0000
      0000A0A09F27A1A2A205B1ACA800979DA100818386008E8A86007E7F80717F7F
      7F75787878008C8C8CA49494948600000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFF00E6E5FC00FAFCFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000D8F4FA00C0EDF80000000000000000000000
      000000000000000000000000000000000000000000009A666600FFFFFF009A66
      6600FFFFFF009A666600FFFFFF009A666600FFFFFF009A666600FFFFFF009A66
      6600000000000000000000000000000000000000000000000000000000000000
      0000A1A1A100A0A0A000A9AAAA009E9D9B008885830088888800878787128888
      881981818100787878007C7C7C16000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C4DFEF005EA7D30058A2D200BCDAED00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD0080877E003D4B34001D320F001F3210003A442E006D716900E0E0
      E000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F4F4F40079797B003737460016163000181834003737430067676600D4D4
      D400000000000000000000000000000000000000000000000000000000000000
      0000DCECF60077B7DC002C8EC8008FCDEB006FB7E200408EC8006BACD700D4E7
      F30000000000000000000000000000000000000000000000000000000000ACAE
      AC00263D1E00173E10001E602100276E36002A7540002675350024512000293A
      1B008D8F8D000000000000000000000000000000000082808000261919002117
      17002118180021181800211818001F1C1B001E1A1900201818001F1818001E18
      18001C1717001D161600504C4B0000000000000000000000000000000000A5A5
      A6001F1F35000A0A5B00040493000000B2000000C6000D0DCA00161686002222
      3200838382000000000000000000000000000000000000000000EDF6FA0095C9
      E4003E9BCE0082C4E500CCF4FF00C4EFFF008BD2F1008ACEF0005FA4D7002F8B
      C60085BADD00E7F1F80000000000000000000000000000000000B3B5B300102D
      07001C4B16001260200009672300118637001FA756001DA7600021A464002C75
      3E001D350E008C8F8C0000000000000000000000000013272F000977AF00086D
      9D00076B9600076B9600067E9F0003455A00034C5E000482930003758D000377
      8B00027A8B0001959D0007242700000000000000000000000000A8A8A9000A0A
      2100040466000000B2000202CC005F5FE0004848C6000000E8000000FF001111
      BE001A1A2E00848482000000000000000000FAFCFD00B1D9EB0054AAD4007DC0
      E000C7EEFC00CCF2FF00A8E8FF0094E0FE0041BAE70045B1E4008ACAEF0082C1
      EB005397D0003D92CA00A0C9E400F6FAFC0000000000F2F2F2001B3213001A46
      130008520F00277E36008EB89C00377A4F000A74300023A25A0024B86A001CB3
      6D002B703B001B2E0E00D8D8D80000000000000000002727290002AAFF0000DD
      FF0000C7FF0000F4FF0000A4E90002A0E30001A1E30000CAF50000FFFF0000FF
      FF0000FFFF0001F5FF00192224000000000000000000ECECEC00101021000202
      54000000A10000008E002B2BBC0000000000000000000D0DBC000000E8000000
      FF000D0D980017171D00CFCFCF000000000072BDDE0077BDDC00BFE5F600DBF6
      FF00C1EEFF00A5E4FF009FE3FF0094E0FE0046C1EA003AB5E60037AAE20056AF
      E50087C6ED0074B3E4004A90CA0057A1D100000000007B827A00173E0F00053D
      030017601B00B5C2BA00FFF4FF00E9DBE6002F794A000A79320022A1590023AE
      62001D975700275723005C6255000000000000000000B0ACAC00173B4B0000BA
      FF0000A9FD0000B8FC0000A2E600382623003826230000C0EC0000CEFC0000D7
      FF0000FCFF000D303700A6A3A300000000000000000070707400030332000000
      79000000860000008E000404A0007474CE005B5CC2000000BD000000D2000000
      E0000000E80011115500555553000000000046AAD400E7FBFE00DDF6FF00C1EE
      FF00B7EBFF00ABE8FF00A4E4FF0096E1FE0048C6EB0040BDE9003DB4E60038A9
      E200329FDE006BB6E60083C4ED002A88C5000000000038483300295B1F001C59
      1700A5B1A600EFD2F100DFD2E000FDE8FA00E1DAE0002A7446000A7630002097
      4F001C9F5200277437002B381F0000000000000000000000000045332E00107E
      B90000BEFF0000A7FC0005C0FF000AC7F0000AC9F3000BD4FF0013CEFD000FFF
      FF000E82A0003F3131000000000000000000000000002929380015155D000202
      810000007200000082000F0FA0008888CE007171B8000404A0000000C1000000
      C1000000E400070776001F1F2400000000004FAFD600E2F6FC00D4F3FF00C9F0
      FF00BEEDFF00B3EAFF00ADE7FF007CD9FE0048C7EF0043C4EA0043BEE8003FB5
      E6003AABE30040A7E10083C4ED00328EC800000000001E3B170035642900C7DB
      C300000000008DA68F002B733400AFC8B800FFEFFF00DAD4D80027703F000B70
      2A001A91410021763A001F3B1700000000000000000000000000C9C8C8002730
      340015BDFF0008C7FF00079CDD003F262200432E2B0020C8F90029F7FF0029D4
      F5001E1C1C00E0E0E0000000000000000000000000000C0C1F002B2B7E001F1F
      8E000707760000006B003434AA00FFFFF400FFFFE0001A1AA0000000A6000000
      AE000000BD00030395000D0D1E000000000051B1D700E2F6FC00D7F4FF00CEF2
      FF00C8EFFF00BAEBFF0092DBFB0056C1F10048C2F9003BBDF00047C5EC0045BD
      E90042B5E60047B1E60088CAEE003490C900000000002A4821003B642A007AA1
      6E00CCDFCA003B743A00074D0B00418A4D00EDECF200FFF7FF00D6D4D4003579
      48001A7C33001E6E30001F3D1700000000000000000000000000000000005746
      4400387A980022EBFF0022A9DF00402A26003E312F001DC6FC0020FDFF002857
      650071696900000000000000000000000000000000000F0F2000262679002727
      8A0024248A0008087B004848AD00FFFFE000E4E4D4003D3DAA001111A6001A1A
      AF000A0AB20000008A000A0A1C000000000053B4D800E2F6FC00DAF4FF00D5F3
      FF00BDEBFF0089D5F70069C9F5004CB4E9008DDAFB008CDCFF0048C4F90038B6
      EC0048BFE8004FBBE8008CD0F0003793CA0000000000384B3600476F35002E5F
      200033652A00366F3200478048002B7030005A996300F1EDF500FFF4FF00CCCA
      CD00498B580031713500273C2000F9F9F900000000000000000000000000E9E9
      E9002B2B2B002AD2FF001CA6E4003D262300313C3F001CE0FF002BB1E1002F21
      1F000000000000000000000000000000000000000000202035001F1F63002424
      8D0023238200131382006A6AB600F5F5DA00E3E3D2004A4AA70015159A002727
      A9002727C20018186F00151523000000000055B6D900E2F8FD00D4F3FF00B0E4
      FA0086CFF1007FD0F50078D0F5004CB1E400B0E4FA00B6E9FF009BE1FF0078D6
      FE0040BDF5003DB5E90090D5F1003995CB00000000006771660041693500385F
      2600356325003A6A30003B7036003B743A0026682900619A6600F4EFFA000000
      00009CB6A1002A59240056615300000000000000000000000000000000000000
      00006D626200387FA1001F9FDA00391F1B00322D2D0024CEFF002E424A00A8A6
      A60000000000000000000000000000000000000000005959630018184D002727
      8A0020207A00111177006B6BAF00E6E6CD00DFDFCC004C4CA00011118B002020
      98002626B1002020590048484E00000000004FB5D800E1F8FE00CDEBF90092D2
      ED0084CCEB006FBFE50056B1DB003B94C800CEECFA00D9F5FF00B9EAFF0095DF
      FE0077D5FF00A5E4FF0084DCFB003293C90000000000E0E0E000294725004D70
      3A00345F200039662A003A692F003B6D33003A703500256123007BAA7B00C8E1
      C800527B4B001B391500D6D6D600000000000000000000000000000000000000
      0000FAFAFA00332C2B003497C4001DA5E3001DA5E300377C9C00473A37000000
      00000000000000000000000000000000000000000000D8D8D8000B0B24002222
      690026268B00121270008282B300E9E9C300EDEDCA005A5A9F000E0E7A002626
      A700232379000C0C2500CCCCCD000000000091D2E7004DB5D900A5D9ED00D2EB
      F500BEDEED0095C9DE0089C3DB0070B8D60069B9DD0090D7F5007FCFF5009DDB
      F800AAE3FA0084CAEC0051A6D50079B9DD0000000000000000008A908A003A5F
      33004D6E3A00365D23003563250037662900396A2D00386E2D0034682B003E69
      3600284E200080857F0000000000000000000000000000000000000000000000
      00000000000095929200394C540026E9FF0030BCFF0029201D00E0E0E0000000
      00000000000000000000000000000000000000000000000000007F7F86001111
      3800212171001A1A83006363AA00CECECC00CACACC0048489F0019198E002020
      7F00111136006F6F7600000000000000000000000000CEEBF40078C6E2007EC6
      E000D1EEF700F6FFFF00F0FEFF00CBEDFB0050ADDA008BD7F700AAE1F90095D6
      F20062B2DB0063B2D800C2E0EF00000000000000000000000000000000008187
      8100355231004C733E004C733900476B3400456B3500487139003E6733002744
      2000737B73000000000000000000000000000000000000000000000000000000
      00000000000000000000433A3700476B7B003A535E00736F6F00000000000000
      0000000000000000000000000000000000000000000000000000000000007575
      80000C0C2E00171759001A1A6E002E2E8F002A2A8E001B1B720018185D000C0C
      2E00686872000000000000000000000000000000000000000000FBFDFE00B8E2
      EF0065BEDD0092CFE500E6F8FC00E3F6FE00AFDDF200B2E4F70072C0E10056AF
      D600ACD7EB00F8FBFD0000000000000000000000000000000000000000000000
      0000CACACA005F6B5E003C5139003D5A35003B5832003549320057645500C1C1
      C100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000070676700837E7E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BEBEC1004949590018183F0009092F000A0A2F0017173C0046465500B9B9
      BC00000000000000000000000000000000000000000000000000000000000000
      0000EFF8FB00A2D8EA0056B6D9009CD5EA0088CCE7004DAFD60098D0E700EBF6
      FA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E0F2F80083CAE40079C4E100DBEFF700000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFF3F00180010000E3C7F0018001
      0000E007F00180010000E007800180010000E007800180010000E00780018001
      0000C00380018001000080018001800100008000800180010000000080018001
      00000000800180010000F81F800180010000FC1F800180010000FC3F80019001
      0000FE7F800F90010000FE7F800FF001FFFFFFFFFFFFFC3FF00FFFFFF00FF00F
      E0078001E007C003C0038001C003000080018001818100008001800180010000
      8001C003800100008801C003800100008001E007800100008000E00F80010000
      8011F00F800100008001F01F80010000C003F81FC0038001E007FC3FE007C003
      F00FFE7FF00FF00FFFFFFFFFFFFFFC3F00000000000000000000000000000000
      000000000000}
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '.tgz'
    FileName = 'package.tgz'
    Filter = 'FHIR Packages|*.tgz|All Files|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Choose FHIR Package'
    Left = 64
    Top = 393
  end
  object pmImport: TPopupMenu
    Left = 192
    Top = 392
    object FHIRR21: TMenuItem
      Caption = 'FHIR R2'
      OnClick = FHIRR21Click
    end
    object FHIRR31: TMenuItem
      Caption = 'FHIR R3'
      OnClick = FHIRR31Click
    end
    object FHIRR41: TMenuItem
      Caption = 'FHIR R4'
      OnClick = FHIRR41Click
    end
    object USCoreCurrentStable1: TMenuItem
      Caption = 'US Core (Current Stable)'
      OnClick = USCoreCurrentStable1Click
    end
  end
end
