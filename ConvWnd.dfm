object ConvWndForm: TConvWndForm
  Left = 354
  Top = 322
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Screen convert'
  ClientHeight = 414
  ClientWidth = 446
  Color = clBtnFace
  DoubleBuffered = True
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    446
    414)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 293
    Height = 412
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitWidth = 300
    ExplicitHeight = 300
  end
  object Label1: TLabel
    Left = 307
    Top = 75
    Width = 131
    Height = 256
    AutoSize = False
    Caption = 
      #39'M'#39' key is window move mode. The window can be moved by pushing ' +
      'the arrow key.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 306
    Top = -2
    Width = 52
    Height = 13
    AutoSize = False
    Caption = 'Simulation:'
  end
  object cmbColor: TComboBox
    Left = 306
    Top = 17
    Width = 131
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = cmbColorChange
  end
  object btnPV: TButton
    Left = 307
    Top = 44
    Width = 131
    Height = 25
    Caption = 'Parallel view'
    TabOrder = 1
    OnClick = btnPVClick
  end
end
