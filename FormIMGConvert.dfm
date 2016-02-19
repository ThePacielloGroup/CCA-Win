object frmIMGConvert: TfrmIMGConvert
  Left = 287
  Top = 223
  Caption = 'Image file convert'
  ClientHeight = 483
  ClientWidth = 777
  Color = clBtnFace
  Constraints.MinHeight = 325
  ParentFont = True
  OldCreateOrder = False
  PopupMode = pmExplicit
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 65
    Width = 777
    Height = 418
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
    Width = 777
    Height = 65
    Align = alTop
    TabOrder = 0
    TabStop = True
    object gbSimulation: TGroupBox
      Left = 408
      Top = 11
      Width = 354
      Height = 47
      Caption = 'Simulation'
      TabOrder = 1
      object btnSave: TButton
        Left = 164
        Top = 17
        Width = 87
        Height = 27
        Caption = '&Save'
        Enabled = False
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object btnPreview: TButton
        Left = 257
        Top = 17
        Width = 88
        Height = 27
        Caption = '&Preview'
        Enabled = False
        TabOrder = 1
        OnClick = btnPreviewClick
      end
      object cmbSimu: TAccComboBox
        Left = 3
        Top = 14
        Width = 155
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        AccName = 'Simuration Combobox'
      end
    end
    object gbSelIMG: TGroupBox
      Left = 3
      Top = 10
      Width = 399
      Height = 47
      Caption = 'Select image file'
      TabOrder = 0
      object edtFileName: TEdit
        Left = 3
        Top = 15
        Width = 310
        Height = 21
        TabOrder = 0
        OnKeyPress = edtFileNameKeyPress
      end
      object btnBrowse: TButton
        Left = 319
        Top = 17
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
