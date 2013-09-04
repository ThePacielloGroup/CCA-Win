object ConvWndForm: TConvWndForm
  Left = 354
  Top = 322
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Screen convert'
  ClientHeight = 326
  ClientWidth = 463
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 325
    Height = 325
  end
  object Label1: TLabel
    Left = 329
    Top = 182
    Width = 131
    Height = 140
    AutoSize = False
    Caption = 
      #39'M'#39' key is window move mode. The window can be moved by pushing ' +
      'the arrow key.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 329
    Top = 0
    Width = 52
    Height = 13
    Caption = 'Simulation:'
  end
  object cmbColor: TComboBox
    Left = 329
    Top = 17
    Width = 131
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = cmbColorChange
  end
end
