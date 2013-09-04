object frmSelList: TfrmSelList
  Left = 191
  Top = 223
  Caption = 'Window list'
  ClientHeight = 562
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 260
  Constraints.MinWidth = 277
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
    Left = 167
    Top = 0
    Width = 617
    Height = 562
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
    Width = 167
    Height = 562
    VertScrollBar.Increment = 35
    Align = alLeft
    TabOrder = 0
    TabStop = True
    object ListView1: TListView
      Left = 3
      Top = 21
      Width = 160
      Height = 125
      Columns = <
        item
          Caption = 'Title'
          Width = 104
        end
        item
          AutoSize = True
          Caption = 'Handle'
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = ListView1SelectItem
    end
    object gbSimulation: TGroupBox
      Left = 3
      Top = 153
      Width = 160
      Height = 208
      Caption = 'Simulation'
      TabOrder = 1
      object btnSave: TButton
        Left = 7
        Top = 180
        Width = 70
        Height = 22
        Caption = '&Save'
        Enabled = False
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnPreview: TButton
        Left = 83
        Top = 180
        Width = 70
        Height = 22
        Caption = '&Preview'
        TabOrder = 2
        OnClick = btnPreviewClick
      end
      object GroupBox1: TGroupBox
        Left = 7
        Top = 14
        Width = 146
        Height = 160
        TabOrder = 0
        object RadioButton1: TRadioButton
          Left = 7
          Top = 14
          Width = 133
          Height = 15
          Caption = 'RadioButton1'
          TabOrder = 0
        end
        object RadioButton2: TRadioButton
          Left = 7
          Top = 35
          Width = 133
          Height = 14
          Caption = 'RadioButton1'
          TabOrder = 1
        end
        object RadioButton3: TRadioButton
          Left = 7
          Top = 55
          Width = 133
          Height = 15
          Caption = 'RadioButton1'
          TabOrder = 2
        end
        object RadioButton4: TRadioButton
          Left = 7
          Top = 76
          Width = 133
          Height = 15
          Caption = 'RadioButton1'
          TabOrder = 3
        end
        object RadioButton5: TRadioButton
          Left = 7
          Top = 97
          Width = 133
          Height = 15
          Caption = 'RadioButton1'
          TabOrder = 4
        end
        object RadioButton6: TRadioButton
          Left = 7
          Top = 118
          Width = 133
          Height = 15
          Caption = 'RadioButton1'
          TabOrder = 5
        end
        object RadioButton7: TRadioButton
          Left = 7
          Top = 139
          Width = 133
          Height = 14
          Caption = 'RadioButton1'
          TabOrder = 6
        end
      end
    end
    object gbJPEG: TGroupBox
      Left = 3
      Top = 367
      Width = 160
      Height = 64
      Caption = 'JPEG options'
      TabOrder = 2
      object lblC_Quality: TLabel
        Left = 7
        Top = 17
        Width = 102
        Height = 13
        Caption = 'Compression Quality:'
      end
      object edtC_Quality: TPBSuperSpin
        Left = 111
        Top = 14
        Width = 42
        Height = 22
        Cursor = crDefault
        Alignment = taRightJustify
        Decimals = 0
        MaxValue = 100.000000000000000000
        MinValue = 1.000000000000000000
        NumberFormat = Standard
        TabOrder = 0
        Value = 75.000000000000000000
        Increment = 1.000000000000000000
        RoundValues = False
        Wrap = False
      end
      object chkSmooth: TCheckBox
        Left = 7
        Top = 42
        Width = 146
        Height = 14
        Caption = 'S&moothing'
        TabOrder = 1
      end
    end
    object btnClose: TButton
      Left = 97
      Top = 437
      Width = 63
      Height = 21
      Cancel = True
      Caption = '&Close'
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object Label1: TPanel
      Left = 3
      Top = 5
      Width = 125
      Height = 15
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Label1'
      TabOrder = 4
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
