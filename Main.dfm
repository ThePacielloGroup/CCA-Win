object MainForm: TMainForm
  Left = 1007
  Top = 526
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Colour Contrast Analyser'
  ClientHeight = 658
  ClientWidth = 868
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
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
  Menu = MainMenu1
  OldCreateOrder = False
  Scaled = False
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 639
    Width = 868
    Height = 19
    Panels = <>
    ParentFont = True
    SimplePanel = True
    UseSystemFont = False
  end
  object gbFore: TAccGroupBox
    Left = 8
    Top = 1
    Width = 317
    Height = 380
    Caption = 'Foreground'
    Padding.Top = 5
    Padding.Bottom = 5
    TabOrder = 0
    AccName = 'Foreground Group'
    object grdFRGB: TGridPanel
      Left = 5
      Top = 69
      Width = 300
      Height = 152
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 83.009595909287110000
        end
        item
          Value = 16.990404090712890000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lblFR
          Row = 0
        end
        item
          Column = 0
          Control = tbFR
          Row = 1
        end
        item
          Column = 1
          Control = FREdit
          Row = 1
        end
        item
          Column = 0
          Control = lblFG
          Row = 2
        end
        item
          Column = 0
          Control = tbFG
          Row = 3
        end
        item
          Column = 1
          Control = FGEdit
          Row = 3
        end
        item
          Column = 0
          Control = lblFB
          Row = 4
        end
        item
          Column = 0
          Control = tbFB
          Row = 5
        end
        item
          Column = 1
          Control = FBEdit
          Row = 5
        end>
      RowCollection = <
        item
          Value = 16.650862524577660000
        end
        item
          Value = 16.660336061541940000
        end
        item
          Value = 16.669273298616170000
        end
        item
          Value = 16.677266999896820000
        end
        item
          Value = 16.682698883786330000
        end
        item
          Value = 16.659562231581070000
        end>
      TabOrder = 1
      TabStop = True
      object lblFR: TLabel
        Left = 0
        Top = 0
        Width = 249
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Red:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 124
        ExplicitTop = 7
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object tbFR: TAccTrackBar
        Left = 0
        Top = 25
        Width = 249
        Height = 25
        Align = alClient
        Max = 255
        Frequency = 16
        PositionToolTip = ptBottom
        TabOrder = 0
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbFRChange
        AccName = 'Fore Red Slider'
        CtrlNext = tbFG
        CtrlPrev = sbtnFore
        CtrlRight = FREdit
        CtrlUp = FJColor
        CtrlDown = tbFG
      end
      object FREdit: TAccEdit
        Left = 249
        Top = 25
        Width = 51
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 3
        OnChange = FREditChange
        OnEnter = chkExpandEnter
        AccName = 'Fore Red Value Edit'
        CtrlNext = FGEdit
        CtrlPrev = tbFR
        CtrlRight = tbBR
        CtrlLeft = tbFR
        CtrlUp = sbtnFore
        CtrlDown = FGEdit
      end
      object lblFG: TLabel
        Left = 0
        Top = 50
        Width = 249
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Green:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 124
        ExplicitTop = 55
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object tbFG: TAccTrackBar
        Left = 0
        Top = 75
        Width = 249
        Height = 25
        Align = alClient
        Max = 255
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 1
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbFRChange
        AccName = 'Fore Green Slider'
        CtrlNext = tbFB
        CtrlPrev = tbFR
        CtrlRight = FGEdit
        CtrlUp = tbFR
        CtrlDown = tbFB
      end
      object FGEdit: TAccEdit
        Left = 249
        Top = 75
        Width = 51
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 4
        OnChange = FREditChange
        OnEnter = chkExpandEnter
        AccName = 'Fore Green Value Edit'
        CtrlNext = FBEdit
        CtrlPrev = FREdit
        CtrlRight = tbBG
        CtrlLeft = tbFG
        CtrlUp = FREdit
        CtrlDown = FBEdit
      end
      object lblFB: TLabel
        Left = 0
        Top = 100
        Width = 249
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Blue:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 1
        ExplicitTop = 104
      end
      object tbFB: TAccTrackBar
        Left = 0
        Top = 125
        Width = 249
        Height = 27
        Align = alClient
        Max = 255
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 2
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbFRChange
        AccName = 'Fore Blue Slider'
        CtrlNext = FREdit
        CtrlPrev = tbFG
        CtrlRight = FGEdit
        CtrlUp = tbFG
        CtrlDown = tbFH
      end
      object FBEdit: TAccEdit
        Left = 249
        Top = 125
        Width = 51
        Height = 27
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 5
        OnChange = FREditChange
        OnEnter = chkExpandEnter
        AccName = 'Fore Blue Value Edit'
        CtrlNext = tbFH
        CtrlPrev = FGEdit
        CtrlRight = tbBB
        CtrlLeft = tbFB
        CtrlUp = FGEdit
        CtrlDown = FHEdit
      end
    end
    object grdFHSV: TGridPanel
      Left = 5
      Top = 221
      Width = 300
      Height = 152
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 82.977129901540520000
        end
        item
          Value = 17.022870098459470000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lblFH
          Row = 0
        end
        item
          Column = 0
          Control = tbFH
          Row = 1
        end
        item
          Column = 1
          Control = FHEdit
          Row = 1
        end
        item
          Column = 0
          Control = lblFS
          Row = 2
        end
        item
          Column = 0
          Control = tbFS
          Row = 3
        end
        item
          Column = 1
          Control = FSEdit
          Row = 3
        end
        item
          Column = 0
          Control = lblFV
          Row = 4
        end
        item
          Column = 0
          Control = tbFV
          Row = 5
        end
        item
          Column = 1
          Control = FVEdit
          Row = 5
        end>
      RowCollection = <
        item
          Value = 16.728283398431300000
        end
        item
          Value = 16.717239971947860000
        end
        item
          Value = 16.588096198496430000
        end
        item
          Value = 16.632428794061340000
        end
        item
          Value = 16.696161983231520000
        end
        item
          Value = 16.637789653831540000
        end>
      TabOrder = 2
      object lblFH: TLabel
        Left = 0
        Top = 0
        Width = 248
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Hue:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 20
        ExplicitTop = -6
        ExplicitWidth = 249
      end
      object tbFH: TAccTrackBar
        Left = 0
        Top = 25
        Width = 248
        Height = 25
        Align = alClient
        Max = 360
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 0
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbFHChange
        AccName = 'Fore Red Slider'
        CtrlNext = tbFS
        CtrlPrev = FBEdit
        CtrlRight = FHEdit
        CtrlUp = tbFB
        CtrlDown = tbFS
      end
      object FHEdit: TAccEdit
        Left = 248
        Top = 25
        Width = 52
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 3
        OnChange = FHEditChange
        CtrlNext = FSEdit
        CtrlPrev = tbFV
        CtrlRight = tbBH
        CtrlLeft = tbFH
        CtrlUp = FBEdit
        CtrlDown = FSEdit
        ExplicitHeight = 21
      end
      object lblFS: TLabel
        Left = 0
        Top = 50
        Width = 248
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Saturation:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 4
        ExplicitTop = 54
        ExplicitWidth = 249
      end
      object tbFS: TAccTrackBar
        Left = 0
        Top = 75
        Width = 248
        Height = 25
        Align = alClient
        Max = 100
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 1
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbFHChange
        AccName = 'Fore Red Slider'
        CtrlNext = tbFV
        CtrlPrev = tbFH
        CtrlRight = FSEdit
        CtrlUp = tbFH
        CtrlDown = tbFV
      end
      object FSEdit: TAccEdit
        Left = 248
        Top = 75
        Width = 52
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 4
        OnChange = FSEditChange
        CtrlNext = FVEdit
        CtrlPrev = FSEdit
        CtrlRight = tbBS
        CtrlLeft = tbFS
        CtrlUp = FSEdit
        CtrlDown = FVEdit
        ExplicitHeight = 21
      end
      object lblFV: TLabel
        Left = 0
        Top = 100
        Width = 248
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Value:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 4
        ExplicitTop = 104
        ExplicitWidth = 249
      end
      object tbFV: TAccTrackBar
        Left = 0
        Top = 125
        Width = 248
        Height = 27
        Align = alClient
        Max = 100
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 2
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbFHChange
        AccName = 'Fore Red Slider'
        CtrlNext = FHEdit
        CtrlPrev = tbFS
        CtrlRight = FVEdit
        CtrlUp = tbFS
      end
      object FVEdit: TAccEdit
        Left = 248
        Top = 125
        Width = 52
        Height = 27
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 5
        OnChange = FVEditChange
        CtrlPrev = FSEdit
        CtrlRight = tbBV
        CtrlLeft = tbFV
        CtrlUp = FSEdit
        ExplicitHeight = 21
      end
    end
    object grdFHex: TGridPanel
      Left = 5
      Top = 15
      Width = 300
      Height = 51
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 41.861586865913780000
        end
        item
          Value = 16.989331912442960000
        end
        item
          Value = 41.149081221643260000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = Label1
          Row = 0
        end
        item
          Column = 0
          Control = FJColor
          Row = 1
        end
        item
          Column = 2
          Control = Label3
          Row = 0
        end
        item
          Column = 1
          Control = sbtnFore
          Row = 1
        end
        item
          Column = 2
          Control = Edit1
          Row = 1
        end>
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      TabOrder = 0
      DesignSize = (
        300
        51)
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 125
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Colour select:'
        Layout = tlBottom
        ExplicitLeft = 59
        ExplicitTop = 6
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object FJColor: TColorDrop
        AlignWithMargins = True
        Left = 1
        Top = 28
        Width = 119
        Height = 22
        Hint = 'F9|F9 is dropdown'
        Margins.Left = 1
        Margins.Right = 5
        ActiveColor = clBlack
        OnChanged = FJColorChanged
        OnEnter = chkExpandEnter
        DropDnColor = clBtnFace
        TabOrder = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Other = '&Others...'
        AccName = 'Foreground Colour'
        CtrlNext = sbtnFore
        CtrlRight = sbtnFore
        CtrlDown = tbFR
      end
      object Label3: TLabel
        Left = 175
        Top = 0
        Width = 125
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Hex:'
        Layout = tlBottom
        ExplicitLeft = 236
        ExplicitTop = 6
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object sbtnFore: TAccButton
        AlignWithMargins = True
        Left = 128
        Top = 28
        Width = 44
        Height = 20
        Align = alClient
        DropDownMenu = PopupMenu1
        ImageAlignment = iaCenter
        ImageIndex = 0
        Images = ImageList2
        Style = bsSplitButton
        TabOrder = 1
        OnClick = btnForeClick
        AccName = 'Foreground Colour picker'
        AccActionDesc = 'Button Click'
        AccShortCut = 'F11'
        CtrlNext = Edit1
        CtrlPrev = FJColor
        CtrlRight = Edit1
        CtrlLeft = FJColor
        CtrlDown = tbFR
      end
      object Edit1: TAccMaskEdit
        AlignWithMargins = True
        Left = 178
        Top = 28
        Width = 119
        Height = 20
        Hint = '|The picked colour is displayed. And, the value can be input.'
        Align = alClient
        AutoSize = False
        EditMask = '\#aaaaaa;1;_'
        MaxLength = 7
        TabOrder = 2
        Text = '#000000'
        OnChange = Edit1Change
        OnKeyPress = Edit1KeyPress
        AccName = 'Foreground Hex Edit'
        CtrlNext = tbFR
        CtrlPrev = sbtnFore
        CtrlLeft = sbtnFore
        CtrlDown = tbFR
      end
    end
  end
  object gbResNormal: TAccGroupBox
    Left = 8
    Top = 387
    Width = 640
    Height = 245
    Caption = 'Result'
    TabOrder = 2
    AccName = 'Result Group'
    object lblRatio: TLabel
      Left = 9
      Top = 25
      Width = 161
      Height = 17
      AutoSize = False
      Transparent = True
      Visible = False
    end
    object gbResBlind: TAccGroupBox
      Left = 220
      Top = 15
      Width = 414
      Height = 190
      Caption = 'Result'
      TabOrder = 3
      TabStop = True
      Visible = False
      AccName = 'Result Blindness Group '
      object edtProta: TAccLabeledEdit
        Left = 8
        Top = 76
        Width = 393
        Height = 17
        Alignment = taCenter
        AutoSize = False
        BorderStyle = bsNone
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Protanopia:'
        ReadOnly = True
        TabOrder = 1
        OnEnter = chkExpandEnter
        OnKeyDown = edtProtaKeyDown
        AccName = 'Prota Edit'
        CtrlNext = edtDeutera
        CtrlPrev = edtNormal2
        CtrlUp = edtNormal2
        CtrlDown = edtDeutera
      end
      object edtDeutera: TAccLabeledEdit
        Left = 8
        Top = 120
        Width = 393
        Height = 17
        Alignment = taCenter
        AutoSize = False
        BorderStyle = bsNone
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Deuteranopia:'
        ReadOnly = True
        TabOrder = 2
        OnEnter = chkExpandEnter
        OnKeyDown = edtDeuteraKeyDown
        AccName = 'Deutera Edit'
        CtrlNext = edtTrita
        CtrlPrev = edtProta
        CtrlUp = edtProta
        CtrlDown = edtTrita
      end
      object edtTrita: TAccLabeledEdit
        Left = 8
        Top = 160
        Width = 393
        Height = 17
        Alignment = taCenter
        AutoSize = False
        BorderStyle = bsNone
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'Tritanopia:'
        ReadOnly = True
        TabOrder = 3
        OnEnter = chkExpandEnter
        OnKeyDown = edtTritaKeyDown
        AccName = 'Trita Edit'
        CtrlPrev = edtDeutera
        CtrlUp = edtDeutera
      end
      object edtNormal2: TAccLabeledEdit
        Left = 8
        Top = 36
        Width = 393
        Height = 17
        Alignment = taCenter
        AutoSize = False
        BorderStyle = bsNone
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Normal:'
        ReadOnly = True
        TabOrder = 0
        OnEnter = chkExpandEnter
        OnKeyDown = edtNormal2KeyDown
        AccName = 'Normal Edit'
        CtrlNext = edtProta
        CtrlDown = edtProta
      end
    end
    object Memo1: TAccMemo
      Left = 213
      Top = 19
      Width = 419
      Height = 186
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 2
      OnEnter = chkExpandEnter
      AccName = 'Result Memo'
      CtrlNext = btnCopyRes
      CtrlPrev = edtNormal_LT2
      CtrlUp = edtNormal_LT2
      CtrlDown = btnCopyRes
    end
    object btnCopyRes: TAccButton
      Left = 543
      Top = 211
      Width = 89
      Height = 25
      Caption = 'Copy results'
      TabOrder = 5
      OnClick = btnCopyResClick
      AccName = 'CopyButton'
      CtrlPrev = Memo1
      CtrlUp = Memo1
    end
    object gbText: TAccGroupBox
      Left = 8
      Top = 16
      Width = 203
      Height = 81
      Caption = 'Text'
      TabOrder = 0
      TabStop = True
      AccName = 'Normal Text Group'
      object Image1: TImage
        Left = 8
        Top = 21
        Width = 20
        Height = 20
        Stretch = True
        Transparent = True
      end
      object Image7: TImage
        Left = 8
        Top = 49
        Width = 20
        Height = 20
        Stretch = True
        Transparent = True
      end
      object edtNormal_T: TAccEdit
        Left = 32
        Top = 20
        Width = 161
        Height = 21
        Alignment = taCenter
        AutoSize = False
        ReadOnly = True
        TabOrder = 0
        AccName = 'LevelAA Textbox'
        CtrlNext = edtNormal_T2
        CtrlRight = Memo1
        CtrlDown = edtNormal_T2
      end
      object edtNormal_T2: TAccEdit
        Left = 32
        Top = 48
        Width = 161
        Height = 21
        Alignment = taCenter
        AutoSize = False
        ReadOnly = True
        TabOrder = 1
        AccName = 'LevelAAA Textbox'
        CtrlNext = edtNormal_LT
        CtrlPrev = edtNormal_T
        CtrlRight = Memo1
        CtrlUp = edtNormal_T
      end
    end
    object gbLText: TAccGroupBox
      Left = 8
      Top = 103
      Width = 203
      Height = 102
      Caption = 'Large text'
      TabOrder = 1
      TabStop = True
      AccName = 'Large Text Group'
      object Image8: TImage
        Left = 6
        Top = 25
        Width = 20
        Height = 20
        Stretch = True
        Transparent = True
      end
      object Image9: TImage
        Left = 6
        Top = 65
        Width = 20
        Height = 20
        Stretch = True
        Transparent = True
      end
      object edtNormal_LT: TAccEdit
        Left = 32
        Top = 20
        Width = 161
        Height = 33
        Alignment = taCenter
        AutoSize = False
        ReadOnly = True
        TabOrder = 0
        AccName = 'LevelAA LargeTextbox'
        CtrlNext = edtNormal_LT2
        CtrlRight = Memo1
        CtrlDown = edtNormal_LT2
      end
      object edtNormal_LT2: TAccEdit
        Left = 32
        Top = 59
        Width = 161
        Height = 34
        Alignment = taCenter
        AutoSize = False
        ReadOnly = True
        TabOrder = 1
        AccName = 'LevelAAA LargeTextbox'
        CtrlPrev = edtNormal_LT
        CtrlRight = Memo1
        CtrlUp = edtNormal_LT
      end
    end
    object chkblind: TTransCheckBox
      Left = 8
      Top = 211
      Width = 518
      Height = 17
      Caption = 'Show contrast result for colour blindness'
      TabOrder = 4
      OnClick = chkblindClick
      AccName = 'chkShowBlindness'
    end
  end
  object gbBack: TAccGroupBox
    Left = 331
    Top = 1
    Width = 317
    Height = 380
    Caption = 'Background'
    TabOrder = 1
    AccName = 'Background Group'
    object grdBRGB: TGridPanel
      Left = 5
      Top = 69
      Width = 300
      Height = 152
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 83.001353874969620000
        end
        item
          Value = 16.998646125030380000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lblBR
          Row = 0
        end
        item
          Column = 0
          Control = tbBR
          Row = 1
        end
        item
          Column = 1
          Control = BREdit
          Row = 1
        end
        item
          Column = 0
          Control = lblBG
          Row = 2
        end
        item
          Column = 0
          Control = tbBG
          Row = 3
        end
        item
          Column = 1
          Control = BGEdit
          Row = 3
        end
        item
          Column = 0
          Control = lblBB
          Row = 4
        end
        item
          Column = 0
          Control = tbBB
          Row = 5
        end
        item
          Column = 1
          Control = BBEdit
          Row = 5
        end>
      RowCollection = <
        item
          Value = 16.647972651613370000
        end
        item
          Value = 16.641536260592020000
        end
        item
          Value = 16.661443957027940000
        end
        item
          Value = 16.677825648201110000
        end
        item
          Value = 16.689389156241080000
        end
        item
          Value = 16.681832326324490000
        end>
      TabOrder = 1
      TabStop = True
      object lblBR: TLabel
        Left = 0
        Top = 0
        Width = 249
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Red:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 124
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object tbBR: TAccTrackBar
        Left = 0
        Top = 25
        Width = 249
        Height = 25
        Align = alClient
        Max = 255
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 0
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbBRChange
        AccName = 'Back Red Slider'
        CtrlNext = tbBG
        CtrlPrev = sbtnBack
        CtrlRight = BREdit
        CtrlLeft = FREdit
        CtrlUp = BColor
        CtrlDown = tbBG
      end
      object BREdit: TAccEdit
        Left = 249
        Top = 25
        Width = 51
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 3
        OnChange = BREditChange
        OnEnter = chkExpandEnter
        AccName = 'Back Red Colour Edit'
        CtrlNext = BGEdit
        CtrlPrev = tbBV
        CtrlLeft = tbBR
        CtrlUp = sbtnBack
        CtrlDown = BGEdit
        ExplicitHeight = 21
      end
      object lblBG: TLabel
        Left = 0
        Top = 50
        Width = 249
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Green:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 124
        ExplicitTop = 58
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object tbBG: TAccTrackBar
        Left = 0
        Top = 75
        Width = 249
        Height = 25
        Align = alClient
        Max = 255
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 1
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbBRChange
        AccName = 'Back Green Slider'
        CtrlNext = tbBB
        CtrlPrev = tbBR
        CtrlRight = BGEdit
        CtrlLeft = FGEdit
        CtrlUp = tbBR
        CtrlDown = tbBB
      end
      object BGEdit: TAccEdit
        Left = 249
        Top = 75
        Width = 51
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 4
        OnChange = BREditChange
        OnEnter = chkExpandEnter
        AccName = 'Back GreenColour Edit'
        CtrlNext = BBEdit
        CtrlPrev = BREdit
        CtrlLeft = tbBG
        CtrlUp = BREdit
        CtrlDown = BBEdit
        ExplicitHeight = 21
      end
      object lblBB: TLabel
        Left = 0
        Top = 100
        Width = 249
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Blue:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 124
        ExplicitTop = 116
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object tbBB: TAccTrackBar
        Left = 0
        Top = 125
        Width = 249
        Height = 27
        Align = alClient
        Max = 255
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 2
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbBRChange
        AccName = 'Back Blue Slider'
        CtrlNext = BREdit
        CtrlPrev = tbBG
        CtrlRight = BBEdit
        CtrlLeft = FBEdit
        CtrlUp = tbBG
        CtrlDown = tbBH
      end
      object BBEdit: TAccEdit
        Left = 249
        Top = 125
        Width = 51
        Height = 27
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 5
        OnChange = BREditChange
        OnEnter = chkExpandEnter
        AccName = 'Back Blue Colour Edit'
        CtrlNext = tbBH
        CtrlPrev = BGEdit
        CtrlLeft = tbBB
        CtrlUp = BGEdit
        CtrlDown = BHEdit
        ExplicitHeight = 21
      end
    end
    object grdBHSV: TGridPanel
      Left = 5
      Top = 221
      Width = 300
      Height = 152
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 82.942241571327300000
        end
        item
          Value = 17.057758428672690000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lblBH
          Row = 0
        end
        item
          Column = 0
          Control = tbBH
          Row = 1
        end
        item
          Column = 1
          Control = BHEdit
          Row = 1
        end
        item
          Column = 0
          Control = lblBS
          Row = 2
        end
        item
          Column = 0
          Control = tbBS
          Row = 3
        end
        item
          Column = 1
          Control = BSEdit
          Row = 3
        end
        item
          Column = 0
          Control = lblBV
          Row = 4
        end
        item
          Column = 0
          Control = tbBV
          Row = 5
        end
        item
          Column = 1
          Control = BVEdit
          Row = 5
        end>
      RowCollection = <
        item
          Value = 16.822327070703880000
        end
        item
          Value = 16.878214153163640000
        end
        item
          Value = 16.524607198656490000
        end
        item
          Value = 16.447332891600010000
        end
        item
          Value = 16.598934284231630000
        end
        item
          Value = 16.728584401644360000
        end>
      TabOrder = 2
      object lblBH: TLabel
        Left = 0
        Top = 0
        Width = 248
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Hue:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitWidth = 251
      end
      object tbBH: TAccTrackBar
        Left = 0
        Top = 25
        Width = 248
        Height = 25
        Align = alClient
        Max = 360
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 0
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbBHChange
        AccName = 'Fore Red Slider'
        CtrlNext = tbBS
        CtrlPrev = BBEdit
        CtrlRight = BHEdit
        CtrlLeft = FHEdit
        CtrlUp = tbBB
        CtrlDown = tbBS
      end
      object BHEdit: TAccEdit
        Left = 248
        Top = 25
        Width = 52
        Height = 25
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 3
        OnChange = BHEditChange
        CtrlNext = BSEdit
        CtrlPrev = tbBV
        CtrlLeft = tbBH
        CtrlUp = BBEdit
        CtrlDown = BSEdit
        ExplicitHeight = 21
      end
      object lblBS: TLabel
        Left = 0
        Top = 50
        Width = 248
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Saturation:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 4
        ExplicitTop = 54
        ExplicitWidth = 251
      end
      object tbBS: TAccTrackBar
        Left = 0
        Top = 75
        Width = 248
        Height = 24
        Align = alClient
        Max = 100
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 1
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbBHChange
        AccName = 'Fore Red Slider'
        CtrlNext = tbBV
        CtrlPrev = tbBH
        CtrlRight = BSEdit
        CtrlLeft = FSEdit
        CtrlUp = tbBH
        CtrlDown = tbBV
      end
      object BSEdit: TAccEdit
        Left = 248
        Top = 75
        Width = 52
        Height = 24
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 4
        OnChange = BSEditChange
        CtrlNext = BVEdit
        CtrlPrev = BHEdit
        CtrlLeft = tbBS
        CtrlUp = BHEdit
        CtrlDown = BVEdit
        ExplicitHeight = 21
      end
      object lblBV: TLabel
        Left = 0
        Top = 99
        Width = 248
        Height = 25
        Align = alClient
        AutoSize = False
        Caption = 'Value:'
        Transparent = True
        Layout = tlBottom
        ExplicitLeft = 124
        ExplicitTop = 290
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object tbBV: TAccTrackBar
        Left = 0
        Top = 124
        Width = 248
        Height = 28
        Align = alClient
        Max = 100
        Frequency = 20
        PositionToolTip = ptBottom
        TabOrder = 2
        ThumbLength = 18
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = tbBHChange
        AccName = 'Fore Red Slider'
        CtrlNext = BHEdit
        CtrlPrev = tbBS
        CtrlRight = BVEdit
        CtrlLeft = FVEdit
        CtrlUp = tbBS
      end
      object BVEdit: TAccEdit
        Left = 248
        Top = 124
        Width = 52
        Height = 28
        Align = alClient
        Alignment = taRightJustify
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 5
        OnChange = BVEditChange
        CtrlPrev = BSEdit
        CtrlLeft = tbBV
        CtrlUp = BSEdit
        ExplicitHeight = 21
      end
    end
    object grdBHex: TGridPanel
      Left = 5
      Top = 15
      Width = 300
      Height = 51
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 41.375162014215150000
        end
        item
          Value = 17.271941478039070000
        end
        item
          Value = 41.352896507745780000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = Label2
          Row = 0
        end
        item
          Column = 0
          Control = BColor
          Row = 1
        end
        item
          Column = 2
          Control = Label4
          Row = 0
        end
        item
          Column = 1
          Control = sbtnBack
          Row = 1
        end
        item
          Column = 2
          Control = Edit2
          Row = 1
        end>
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      TabOrder = 0
      DesignSize = (
        300
        51)
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 124
        Height = 25
        Align = alClient
        Caption = 'Colour select:'
        Layout = tlBottom
        ExplicitWidth = 66
        ExplicitHeight = 13
      end
      object BColor: TColorDrop
        AlignWithMargins = True
        Left = 2
        Top = 28
        Width = 116
        Height = 22
        Hint = 'F10|F10 is Dropdown.'
        Margins.Left = 1
        Margins.Right = 5
        ActiveColor = clWhite
        OnChanged = FJColorChanged
        OnEnter = chkExpandEnter
        DropDnColor = clBtnFace
        TabOrder = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Other = '&Others...'
        AccName = 'Background Colour'
        CtrlNext = sbtnBack
        CtrlPrev = FVEdit
        CtrlRight = sbtnBack
        CtrlLeft = Edit1
        CtrlDown = tbBR
      end
      object Label4: TLabel
        Left = 175
        Top = 0
        Width = 125
        Height = 25
        Align = alClient
        Caption = 'Hex:'
        Layout = tlBottom
        ExplicitWidth = 23
        ExplicitHeight = 13
      end
      object sbtnBack: TAccButton
        AlignWithMargins = True
        Left = 127
        Top = 28
        Width = 45
        Height = 20
        Align = alClient
        DropDownMenu = PopupMenu2
        ImageAlignment = iaCenter
        ImageIndex = 0
        Images = ImageList2
        Style = bsSplitButton
        TabOrder = 1
        OnClick = btnForeClick
        AccName = 'Background Colour picker'
        AccActionDesc = 'Button Click'
        AccShortCut = 'F12'
        CtrlNext = Edit2
        CtrlPrev = BColor
        CtrlLeft = BColor
        CtrlDown = tbBR
      end
      object Edit2: TAccMaskEdit
        AlignWithMargins = True
        Left = 178
        Top = 28
        Width = 119
        Height = 20
        Hint = '|The picked colour is displayed. And, the value can be input.'
        Align = alClient
        AutoSize = False
        EditMask = '\#aaaaaa;1;_'
        MaxLength = 7
        TabOrder = 2
        Text = '#ffffff'
        OnChange = Edit2Change
        OnKeyPress = Edit2KeyPress
        AccName = 'Background Hex Edit'
        CtrlNext = tbBR
        CtrlPrev = sbtnBack
        CtrlLeft = sbtnBack
        CtrlDown = tbBR
      end
    end
  end
  object ImageList1: TImageList
    Height = 20
    Width = 20
    Left = 448
    Top = 396
    Bitmap = {
      494C010102000400840114001400FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
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
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000084000000
      0000848484000000000000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000084000000840000FF000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000084000000
      0000848484008484840000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000840000008400000084000000840000FF0000008484
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000084000000
      8400000000008484840084848400000000000000FF0000008400000084000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF0000008400000084000000840000008400000084000000840000FF00
      0000848484008484840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      84000000840000000000848484000000FF000000840000008400000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000840000008400000084000000FF000000840000008400000084
      0000FF0000008484840084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      840000008400000084000000FF00000084000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000840000FF0000008484840000FF0000008400000084
      000000840000FF00000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000840000FF000000848484000000000000FF00000084
      000000840000FF00000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000840000008400000084000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000840000FF00000000000000000000000000000000FF
      00000084000000840000FF000000848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000840000008400000084000000840000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF000000FF00000000000000000000000000000000
      000000FF00000084000000840000FF0000008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000084000000840000000000000084000000840000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF00000084000000840000FF00000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000840000000000000000000000FF000000840000008400000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF00000084000000840000FF000000848484000000
      00000000000000000000000000000000000000000000000000000000FF000000
      8400000000000000000000000000000000000000FF0000008400000084000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000840000FF000000848484000000
      00000000000000000000000000000000000000000000000000000000FF000000
      840000000000000000000000000000000000000000000000FF00000084000000
      8400000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF0000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000140000000100010000000000F00000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFF00000000000000FFFFFFEF
      FF00000000000000FF3FFFC7FF00000000000000FE1FFF87CF00000000000000
      FC0FFF838700000000000000F807FF810700000000000000F003FFC00F000000
      00000000F001FFC01F00000000000000F001FFE03F00000000000000F040FFF0
      1F00000000000000F8E07FF01F00000000000000FCF03FE00F00000000000000
      FFF81FE20700000000000000FFFC1FC70300000000000000FFFE1FC783000000
      00000000FFFF3FEFC700000000000000FFFFFFFFEF00000000000000FFFFFFFF
      FF00000000000000FFFFFFFFFF00000000000000FFFFFFFFFF00000000000000
      00000000000000000000000000000000000000000000}
  end
  object FontDialog1: TFontDialog
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
    Font.Style = []
    Options = [fdTrueTypeOnly, fdEffects, fdNoOEMFonts]
    Left = 392
    Top = 352
  end
  object ActionList1: TActionList
    Left = 304
    Top = 364
    object acrFColorDrop: TAction
      ShortCut = 120
      OnExecute = acrFColorDropExecute
    end
    object actBColorDrop: TAction
      Caption = 'actBColorDrop'
      ShortCut = 121
      OnExecute = actBColorDropExecute
    end
    object actFColorPick: TAction
      Caption = 'actFColorPick'
      ShortCut = 122
      OnExecute = actFColorPickExecute
    end
    object actBColorPick: TAction
      Caption = 'actBColorPick'
      ShortCut = 123
      OnExecute = actBColorPickExecute
    end
    object actExpandAll: TAction
      Caption = 'actExpandAll'
      ShortCut = 116
    end
    object actExpandFore: TAction
      Caption = 'actExpandFore'
      ShortCut = 117
    end
    object actExpandBack: TAction
      Caption = 'actExpandBack'
      ShortCut = 118
    end
    object actExpandResult: TAction
      Caption = 'actExpandResult'
      ShortCut = 119
    end
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 328
    Top = 344
    object mnuOptions: TMenuItem
      Caption = '&Options'
      OnDrawItem = mnuHelpDrawItem
      OnMeasureItem = mnuHelpMeasureItem
      object mnuOnTop: TMenuItem
        AutoCheck = True
        Caption = '&Stay On Top'
        ShortCut = 16467
        OnClick = mnuOnTopClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
      object mnuFont: TMenuItem
        Caption = '&Font'
        GroupIndex = 1
        ShortCut = 16454
        OnClick = mnuFontClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
      object mnuP_Value: TMenuItem
        Caption = '&Displayed color value'
        GroupIndex = 2
        Visible = False
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
        object mnuHex: TMenuItem
          Caption = '&Hex value'
          Enabled = False
          GroupIndex = 1
          RadioItem = True
          ShortCut = 16453
          OnClick = mnuHexClick
          OnDrawItem = mnuHelpDrawItem
          OnMeasureItem = mnuHelpMeasureItem
        end
        object mnuRGB: TMenuItem
          Caption = '&RGB'
          Enabled = False
          GroupIndex = 1
          RadioItem = True
          ShortCut = 16466
          OnClick = mnuRGBClick
          OnDrawItem = mnuHelpDrawItem
          OnMeasureItem = mnuHelpMeasureItem
        end
      end
      object mnuShowBlind: TMenuItem
        Caption = 'Show contrast result for colour blindeness'
        GroupIndex = 3
        ShortCut = 117
        OnClick = mnuShowBlindClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
      object mnuSlider: TMenuItem
        Caption = 'Show color sliders'
        GroupIndex = 4
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
        object mnuRGBSlider: TMenuItem
          Caption = '&RGB'
          ShortCut = 118
          OnClick = mnuRGBSliderClick
        end
        object mnuHSVSlider: TMenuItem
          Caption = '&HSV'
          ShortCut = 119
          OnClick = mnuHSVSliderClick
        end
      end
      object mnuLang: TMenuItem
        Caption = '&Language'
        GroupIndex = 4
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
    end
    object mnuIMG: TMenuItem
      Caption = '&Image'
      OnDrawItem = mnuHelpDrawItem
      OnMeasureItem = mnuHelpMeasureItem
      object mnuSelList: TMenuItem
        Caption = '&Select window(List)...'
        ShortCut = 16457
        OnClick = mnuSelListClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
      object mnuSelIMG: TMenuItem
        Caption = 'Select &image file'
        OnClick = mnuSelIMGClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
      object mnuScreen: TMenuItem
        Caption = 'S&creen'
        OnClick = mnuScreenClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
    end
    object mnuHelp: TMenuItem
      Caption = '&Help'
      OnDrawItem = mnuHelpDrawItem
      OnMeasureItem = mnuHelpMeasureItem
      object mnuHelp1: TMenuItem
        Caption = '&Help'
        ShortCut = 16456
        OnClick = mnuHelp1Click
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
      object mnuAbout: TMenuItem
        Caption = '&About...'
        OnClick = mnuAboutClick
        OnDrawItem = mnuHelpDrawItem
        OnMeasureItem = mnuHelpMeasureItem
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'BMP file (*.bmp)|*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 344
    Top = 416
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 368
    Top = 316
    object mnufg1px: TMenuItem
      Caption = '1pixel'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg2px: TMenuItem
      Caption = '2 x 2 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg3px: TMenuItem
      Caption = '3 x 3 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg4px: TMenuItem
      Caption = '4 x 4 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg5px: TMenuItem
      Caption = '5 x 5 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg6px: TMenuItem
      Caption = '6 x 6 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg7px: TMenuItem
      Caption = '7 x 7 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
    object mnufg8px: TMenuItem
      Caption = '8 x 8 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnufg1pxClick
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 512
    Top = 420
    object mnubg1px: TMenuItem
      Caption = '1pixel'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg2px: TMenuItem
      Caption = '2 x 2 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg3px: TMenuItem
      Caption = '3 x 3 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg4px: TMenuItem
      Caption = '4 x 4 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg5px: TMenuItem
      Caption = '5 x 5 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg6px: TMenuItem
      Caption = '6 x 6 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg7px: TMenuItem
      Caption = '7 x 7 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
    object mnubg8px: TMenuItem
      Caption = '8 x 8 pixels'
      GroupIndex = 1
      RadioItem = True
      OnClick = mnubg1pxClick
    end
  end
  object ImageList2: TImageList
    Left = 312
    Top = 408
    Bitmap = {
      494C010101000400840110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      00000000000000000000000000000000000000000000BFBF0000BFBF0000BFBF
      0000BFBF0000BFBF0000BFBF0000BFBF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBF0000BFBF0000000000000000
      000000000000BFBF0000BFBF0000BFBF0000BFBF0000BFBF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBF000000000000BFBF
      0000BFBF000000000000BFBF0000BFBF0000BFBF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00BFBF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00BFBF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00BFBF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0080FF000000000000003F000000000000
      807F000000000000C1FF000000000000E0FF000000000000F07F000000000000
      F83F000000000000FC17000000000000FE07000000000000FF03000000000000
      FF81000000000000FF00000000000000FFC0000000000000FFE8000000000000
      FFF1000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
end
