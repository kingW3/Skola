object Form2: TForm2
  Left = 228
  Top = 134
  Width = 1044
  Height = 780
  HorzScrollBar.Position = 63
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 673
    Top = 256
    Width = 71
    Height = 13
    Caption = 'Dodaj predmet'
  end
  object StringGrid1: TStringGrid
    Left = 1
    Top = 8
    Width = 609
    Height = 721
    RowCount = 20
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnKeyPress = StringGrid1KeyPress
  end
  object Predmeti: TListBox
    Left = 673
    Top = 72
    Width = 153
    Height = 153
    ItemHeight = 13
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 673
    Top = 280
    Width = 153
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 857
    Top = 280
    Width = 81
    Height = 25
    Caption = 'Dodaj'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 953
    Top = 280
    Width = 89
    Height = 25
    Caption = 'Izbaci'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 865
    Top = 120
    Width = 105
    Height = 25
    Caption = 'Ubaci predmete'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Ucenici: TListBox
    Left = 681
    Top = 344
    Width = 153
    Height = 161
    ItemHeight = 13
    TabOrder = 6
  end
  object Button4: TButton
    Left = 857
    Top = 392
    Width = 113
    Height = 33
    Caption = 'Ubaci ucenike'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Edit2: TEdit
    Left = 681
    Top = 528
    Width = 145
    Height = 21
    TabOrder = 8
    Text = 'Edit2'
  end
  object Button5: TButton
    Left = 857
    Top = 480
    Width = 81
    Height = 25
    Caption = 'Dodaj'
    TabOrder = 9
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 945
    Top = 480
    Width = 89
    Height = 25
    Caption = 'Izbaci'
    TabOrder = 10
    OnClick = Button6Click
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object asd1: TMenuItem
      Caption = 'Ucenik'
      object sad1: TMenuItem
        Caption = 'Prebroj'
        OnClick = sad1Click
      end
      object asd: TMenuItem
        Caption = 'Ispisi neocenjene ucenike'
        OnClick = asdClick
      end
      object Izracunajprosek1: TMenuItem
        Caption = 'Izracunaj uspeh'
        OnClick = Izracunajprosek1Click
      end
      object Izracunajprosekodeljenja1: TMenuItem
        Caption = 'Izracunaj prosek odeljenja'
        OnClick = Izracunajprosekodeljenja1Click
      end
      object IzracunajProsek2: TMenuItem
        Caption = 'Izracunaj prosek'
        OnClick = IzracunajProsek2Click
      end
    end
    object TMenuItem
    end
  end
end
