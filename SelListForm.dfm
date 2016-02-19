object frmSelList: TfrmSelList
  Left = 191
  Top = 223
  Caption = 'Window list'
  ClientHeight = 468
  ClientWidth = 1059
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 696
  ParentFont = True
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000040030000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000511581A429B215087194E800E2C81230D6B583B8700
    000000000000000000000000000000000000000000000005115817A8DE19BAFF
    1CB6FF17BAFF0DA5FF1495DE00338011004F3D166B0000000000000000000000
    000000000741D32AC4F817C8FD0696AD005A7B0B7FC20888FB076FF6128DF40F
    67BC0D0A5B1F13550000000000000000000000000511582ADBFF00D4F809EE91
    03C01B05A6A00175FF002ED80006AD0E7EFA118DDB11005E5F2D900000000000
    0000000005115832E9FE1BECFD1CEDFF11D4F324C4FF1AACF70C84F40A59E000
    6DF614ABFF0956A527036A00000000000000000005115838DEFE1C70FD27A5FC
    2CD4FF107ACD322EA52480E618B3FD0E8DFF0584FF209EDA2306580000000000
    0000000005115829ACFF0000FE001BFB27BCFD0A5BAE3300622D1A8E13C1F817
    A9F91AB8F21068B61B0D6E0000000000000000000741D335D4FB2183FE0F56FE
    28D2FF29EBFF0978BC1992C71DA0E5000B640511580001610000000000000000
    0000000000000005115849FFFF3CF3FE38C1EE636EB135B1EF32ECFF0E84D616
    0E5C00000000000000000000000000000000000000000000000005115826EDFE
    9BA5A4FF17127F72A91CCEFC2EE6FF1542940000000000000000000000000000
    000000000000000000000000000511580511587692AF47C9E937E1FF29CBFA1A
    51BC000000000000000000000000000000000000000000000000000000000000
    0000000511580F76E3206DB71054DE595EE60000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    0000FFFF0000F01F0000E0070000C0030000C0010000C0010000C0010000C001
    0000C0030000E00F0000F00F0000F80F0000FE0F0000FFFF0000FFFF0000}
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 73
    Width = 1059
    Height = 395
    Align = alClient
    TabOrder = 1
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 77
      Height = 119
      AutoSize = True
    end
  end
  object ScrollBox2: TScrollBox
    Left = 0
    Top = 0
    Width = 1059
    Height = 73
    VertScrollBar.Increment = 35
    Align = alTop
    TabOrder = 0
    TabStop = True
    object gbSimulation: TAccGroupBox
      Left = 376
      Top = 13
      Width = 569
      Height = 52
      Caption = 'Simulation'
      TabOrder = 0
      TabStop = True
      AccName = 'Simuration Groupbox'
      CtrlLeft = gbWndList
      CtrlFirstChild = ComboBox2
      CtrlLastChicl = btnPreview
      object btnSave: TAccButton
        Left = 351
        Top = 16
        Width = 70
        Height = 22
        Caption = '&Save'
        Enabled = False
        TabOrder = 1
        OnClick = btnSaveClick
        AccName = 'Save Button'
        CtrlNext = btnPreview
        CtrlPrev = ComboBox2
        CtrlRight = btnSave
        CtrlLeft = ComboBox2
      end
      object btnPreview: TAccButton
        Left = 427
        Top = 16
        Width = 70
        Height = 22
        Caption = '&Preview'
        TabOrder = 2
        OnClick = btnPreviewClick
        AccName = 'Preview Button'
        CtrlPrev = btnSave
        CtrlLeft = btnSave
      end
      object ComboBox2: TAccComboBox
        Left = 3
        Top = 16
        Width = 206
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        AccName = 'Simuration Combobox'
        CtrlNext = btnSave
        CtrlPrev = ComboBox1
        CtrlRight = btnSave
        CtrlLeft = ComboBox1
      end
    end
    object gbWndList: TAccGroupBox
      Left = 3
      Top = 13
      Width = 363
      Height = 52
      Caption = 'gbWndList'
      TabOrder = 1
      TabStop = True
      AccName = 'WindowList Groupbox'
      CtrlNext = gbSimulation
      CtrlRight = gbSimulation
      CtrlFirstChild = ComboBox1
      CtrlLastChicl = ComboBox1
      object ComboBox1: TAccComboBox
        Left = 3
        Top = 18
        Width = 350
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        AccName = 'WindowList Combobox'
        CtrlNext = ComboBox2
        CtrlRight = ComboBox2
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'BMP File (*.bmp)|*.bmp|JPEG File (*.jpg)|*.jpg'
    FilterIndex = 2
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 344
  end
end
