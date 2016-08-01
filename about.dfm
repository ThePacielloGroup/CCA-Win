object AboutForm: TAboutForm
  Left = 735
  Top = 159
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'About'
  ClientHeight = 359
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS UI Gothic'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 326
    Width = 350
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 272
      Top = 4
      Width = 73
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 326
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object WB1: TWebBrowser
      Left = 1
      Top = 1
      Width = 348
      Height = 324
      Align = alClient
      TabOrder = 0
      OnBeforeNavigate2 = WB1BeforeNavigate2
      ControlData = {
        4C000000F82300007D2100000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
