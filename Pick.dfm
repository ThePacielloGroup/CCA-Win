object PickForm: TPickForm
  Left = 878
  Top = 219
  BorderStyle = bsNone
  ClientHeight = 202
  ClientWidth = 202
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 202
    Height = 202
    Align = alClient
    Brush.Style = bsClear
    OnMouseDown = FormMouseDown
    OnMouseMove = FormMouseMove
  end
end
