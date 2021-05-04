object MainForm: TMainForm
  Left = 1008
  Top = 471
  BorderStyle = bsDialog
  Caption = 'Animation'
  ClientHeight = 530
  ClientWidth = 858
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PrintScale = poNone
  SnapBuffer = 12
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Graphics: TTimer
    Interval = 1
    OnTimer = GraphicsTimer
    Left = 8
    Top = 8
  end
  object FPST: TTimer
    Interval = 30000
    OnTimer = FPSTTimer
    Left = 56
    Top = 8
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 104
    Top = 8
  end
  object Phizics: TTimer
    Interval = 10
    OnTimer = PhizicsTimer
    Left = 8
    Top = 432
  end
  object controls: TTimer
    Left = 56
    Top = 432
  end
end
