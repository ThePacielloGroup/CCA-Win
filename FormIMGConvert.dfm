object frmIMGConvert: TfrmIMGConvert
  Left = 287
  Top = 223
  Caption = 'Image file convert'
  ClientHeight = 563
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 325
  Constraints.MinWidth = 336
  ParentFont = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 218
    Top = 0
    Width = 566
    Height = 563
    Align = alClient
    TabOrder = 1
    TabStop = True
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 79
      Height = 96
      AutoSize = True
    end
  end
  object ScrollBox2: TScrollBox
    Left = 0
    Top = 0
    Width = 218
    Height = 563
    Align = alLeft
    TabOrder = 0
    TabStop = True
    object gbSimulation: TGroupBox
      Left = 9
      Top = 95
      Width = 200
      Height = 261
      Caption = 'Simulation'
      TabOrder = 1
      object btnSave: TButton
        Left = 9
        Top = 225
        Width = 87
        Height = 27
        Caption = '&Save'
        Enabled = False
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnPreview: TButton
        Left = 102
        Top = 224
        Width = 88
        Height = 27
        Caption = '&Preview'
        Enabled = False
        TabOrder = 2
        OnClick = btnPreviewClick
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 17
        Width = 183
        Height = 201
        TabOrder = 0
        object RadioButton1: TRadioButton
          Left = 9
          Top = 17
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 0
        end
        object RadioButton2: TRadioButton
          Left = 9
          Top = 43
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 1
        end
        object RadioButton3: TRadioButton
          Left = 9
          Top = 69
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 2
        end
        object RadioButton4: TRadioButton
          Left = 9
          Top = 95
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 3
        end
        object RadioButton5: TRadioButton
          Left = 9
          Top = 121
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 4
        end
        object RadioButton6: TRadioButton
          Left = 9
          Top = 147
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 5
        end
        object RadioButton7: TRadioButton
          Left = 9
          Top = 173
          Width = 165
          Height = 19
          Caption = 'RadioButton1'
          TabOrder = 6
        end
      end
    end
    object gbJPEG: TGroupBox
      Left = 9
      Top = 364
      Width = 200
      Height = 79
      Caption = 'JPEG options'
      TabOrder = 2
      object lblC_Quality: TLabel
        Left = 9
        Top = 22
        Width = 102
        Height = 13
        Caption = 'Compression Quality:'
      end
      object edtC_Quality: TPBSuperSpin
        Left = 130
        Top = 17
        Width = 62
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
        Left = 9
        Top = 52
        Width = 183
        Height = 18
        Caption = 'S&moothing'
        TabOrder = 1
      end
    end
    object btnClose: TButton
      Left = 130
      Top = 451
      Width = 79
      Height = 27
      Cancel = True
      Caption = '&Close'
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object gbSelIMG: TGroupBox
      Left = 9
      Top = 9
      Width = 200
      Height = 79
      Caption = 'Select image file'
      TabOrder = 0
      object edtFileName: TEdit
        Left = 9
        Top = 14
        Width = 183
        Height = 21
        TabOrder = 0
        OnKeyPress = edtFileNameKeyPress
      end
      object btnBrowse: TButton
        Left = 121
        Top = 43
        Width = 71
        Height = 27
        Caption = '&Browse'
        TabOrder = 1
        OnClick = btnBrowseClick
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'BMP File (*.bmp)|*.bmp|JPEG File (*.jpg)|*.jpg'
    FilterIndex = 2
    Left = 208
    Top = 272
  end
  object SaveDialog1: TSaveDialog
    Filter = 'BMP File (*.bmp)|*.bmp|JPEG File (*.jpg)|*.jpg'
    FilterIndex = 2
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 240
    Top = 272
  end
end
