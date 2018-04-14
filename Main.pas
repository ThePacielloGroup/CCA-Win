unit Main;
(*
 CCA is a tool to evaluate the color visibility and contrast of foreground/background color combinations.
Copyright (C) 2014 The Paciello Group

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ColorConvert,
  ImgList, Buttons, IniFiles, ActnList, AccCtrls, ShellAPI, Menus, MultiMon,
  Mask, FormIMGConvert, ToolWin, Clipbrd, ShlObj, ComObj, Actions, PermonitorApi,
  System.ImageList;
resourcestring
  B_Difference = 'brightness difference :';
  C_Difference = 'colour difference :';
  Bright_Pass = 'The difference in brightness between the two colours is sufficient. The threshold is 125, and the result of the foreground and background colours is %d';
  Color_Pass = 'The difference in colour between the two colours is sufficient. The threshold is 500, and the result of the foreground and background colours is %d';
  Bright_Fail = 'The difference in brightness between the two colours is not sufficient. The threshold is 125, and the result of the foreground and background colours is %d';
  Color_Fail = 'The difference in colour between the two colours is not sufficient. The threshold is 500, and the result of the foreground and background colours is %d';
  Fail_But = 'The difference in colour between the two colours is not sufficient. The threshold is 500, and the result of the foreground and background colours is %d';
  HP_Note = 'Note: Whilst the colour difference doesn''t comply with the W3C specified range, it does comply with the range used by Hewlett Packard. Hewlett Packard recommends a colour difference limit of 400.';
  Luminosity_Contrast='Passed at %s(The contrast ratio is: %f)';
  Luminosity_Contrast_Fail = 'Fail(The contrast ratio is: %f)';
  Luminosity_Contrast_Note = 'Text or diagrams and their background must have a luminosity contrast ratio of at least 5:1 for level 2 conformance to guideline 1.4, ';
  Luminosity_Contrast_Note2 = 'and text or diagrams and their background must have a luminosity contrast ratio of at least 10:1 for level 3 conformance to guideline 1.4.';
  Level2 = 'Level2';
  Level3 = 'Level3';
  IMG_Saved = 'The image was saved(%s).';
  IMG_OPEN_PROMPT = 'Is the saved image opened?';
  Fail_GETDC = 'The device context was not able to be acquired.';
  Fail_WndSize = 'Please change the window to a visible state.';
  Wnd_Move = '''M'' key is window move mode. The window can be moved by pushing the arrow key.';




type



  TMainForm = class(TForm)
    gbFore: TAccGroupBox;
    gbResNormal: TAccGroupBox;
    ImageList1: TImageList;
    FontDialog1: TFontDialog;
    ActionList1: TActionList;
    acrFColorDrop: TAction;
    actBColorDrop: TAction;
    actFColorPick: TAction;
    actBColorPick: TAction;
    MainMenu1: TMainMenu;
    mnuOptions: TMenuItem;
    mnuOnTop: TMenuItem;
    mnuFont: TMenuItem;
    mnuHelp: TMenuItem;
    mnuHelp1: TMenuItem;
    mnuAbout: TMenuItem;
    mnuHex: TMenuItem;
    mnuIMG: TMenuItem;
    mnuSelList: TMenuItem;
    SaveDialog1: TSaveDialog;
    mnuRGB: TMenuItem;
    mnuP_Value: TMenuItem;
    mnuSelIMG: TMenuItem;
    mnuScreen: TMenuItem;
    PopupMenu1: TPopupMenu;
    mnufg1px: TMenuItem;
    mnufg2px: TMenuItem;
    mnufg3px: TMenuItem;
    mnufg4px: TMenuItem;
    PopupMenu2: TPopupMenu;
    mnubg1px: TMenuItem;
    mnubg2px: TMenuItem;
    mnubg3px: TMenuItem;
    mnubg4px: TMenuItem;
    Memo1: TAccMemo;
    btnCopyRes: TAccButton;
    actExpandAll: TAction;
    actExpandFore: TAction;
    actExpandBack: TAction;
    actExpandResult: TAction;
    ImageList2: TImageList;
    StatusBar1: TStatusBar;
    mnufg6px: TMenuItem;
    mnufg8px: TMenuItem;
    mnubg6px: TMenuItem;
    mnubg8px: TMenuItem;
    mnubg5px: TMenuItem;
    mnubg7px: TMenuItem;
    mnufg5px: TMenuItem;
    mnufg7px: TMenuItem;
    mnuShowBlind: TMenuItem;
    mnuSlider: TMenuItem;
    gbText: TAccGroupBox;
    gbLText: TAccGroupBox;
    Image1: TImage;
    edtNormal_T: TAccEdit;
    Image7: TImage;
    edtNormal_T2: TAccEdit;
    Image8: TImage;
    Image9: TImage;
    edtNormal_LT: TAccEdit;
    edtNormal_LT2: TAccEdit;
    mnuLang: TMenuItem;
    chkblind: TTransCheckBox;
    gbResBlind: TAccGroupBox;
    edtProta: TAccLabeledEdit;
    edtDeutera: TAccLabeledEdit;
    edtTrita: TAccLabeledEdit;
    edtNormal2: TAccLabeledEdit;
    grdFRGB: TGridPanel;
    lblFR: TLabel;
    tbFR: TAccTrackBar;
    FREdit: TAccEdit;
    lblFG: TLabel;
    tbFG: TAccTrackBar;
    FGEdit: TAccEdit;
    lblFB: TLabel;
    tbFB: TAccTrackBar;
    FBEdit: TAccEdit;
    gbBack: TAccGroupBox;
    grdBRGB: TGridPanel;
    lblBR: TLabel;
    tbBR: TAccTrackBar;
    BREdit: TAccEdit;
    lblBG: TLabel;
    tbBG: TAccTrackBar;
    BGEdit: TAccEdit;
    lblBB: TLabel;
    tbBB: TAccTrackBar;
    BBEdit: TAccEdit;
    grdFHSV: TGridPanel;
    lblFH: TLabel;
    tbFH: TAccTrackBar;
    FHEdit: TAccEdit;
    lblFS: TLabel;
    tbFS: TAccTrackBar;
    FSEdit: TAccEdit;
    lblFV: TLabel;
    tbFV: TAccTrackBar;
    FVEdit: TAccEdit;
    grdBHSV: TGridPanel;
    lblBH: TLabel;
    tbBH: TAccTrackBar;
    BHEdit: TAccEdit;
    lblBS: TLabel;
    tbBS: TAccTrackBar;
    BSEdit: TAccEdit;
    lblBV: TLabel;
    tbBV: TAccTrackBar;
    BVEdit: TAccEdit;
    grdFHex: TGridPanel;
    Label1: TLabel;
    FJColor: TColorDrop;
    grdBHex: TGridPanel;
    Label2: TLabel;
    BColor: TColorDrop;
    mnuRGBSlider: TMenuItem;
    mnuHSVSlider: TMenuItem;
    Label3: TLabel;
    sbtnFore: TAccButton;
    Edit1: TAccMaskEdit;
    Label4: TLabel;
    sbtnBack: TAccButton;
    Edit2: TAccMaskEdit;
    chkFGSync: TTransCheckBox;
    chkBGSync: TTransCheckBox;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure mnuHexClick(Sender: TObject);
    procedure FJColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acrFColorDropExecute(Sender: TObject);
    procedure actBColorDropExecute(Sender: TObject);
    procedure actFColorPickExecute(Sender: TObject);
    procedure actBColorPickExecute(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure mnuOnTopClick(Sender: TObject);
    procedure mnuHelp1Click(Sender: TObject);
    procedure mnuFontClick(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
    procedure mnuSelListClick(Sender: TObject);
    procedure mnuRGBClick(Sender: TObject);
    procedure mnuSelIMGClick(Sender: TObject);
    procedure mnuScreenClick(Sender: TObject);
    procedure FREditChange(Sender: TObject);
    procedure BREditChange(Sender: TObject);
    procedure tbFRChange(Sender: TObject);
    procedure tbBRChange(Sender: TObject);
    procedure btnCopyResClick(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNormal2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtProtaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDeuteraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTritaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnufg1pxClick(Sender: TObject);
    procedure mnubg1pxClick(Sender: TObject);
    procedure bbFGSCClick(Sender: TObject);
    procedure bbBGSCClick(Sender: TObject);
    procedure bbRNSCClick(Sender: TObject);
    procedure bbRBSCClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure btnForeClick(Sender: TObject);
    procedure mnuShowBlindClick(Sender: TObject);
    procedure chkExpandEnter(Sender: TObject);
    procedure rb_least3Click(Sender: TObject);
    procedure rb_least3Enter(Sender: TObject);
    procedure chkblindClick(Sender: TObject);
    procedure mnuHelpMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure mnuHelpDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tbFHChange(Sender: TObject);
    procedure tbBHChange(Sender: TObject);
    procedure FHEditChange(Sender: TObject);
    procedure BHEditChange(Sender: TObject);
    procedure FSEditChange(Sender: TObject);
    procedure FVEditChange(Sender: TObject);
    procedure BSEditChange(Sender: TObject);
    procedure BVEditChange(Sender: TObject);
    procedure mnuRGBSliderClick(Sender: TObject);
    procedure mnuHSVSliderClick(Sender: TObject);
  private
    { Private declare }
    FR, FG, FB, BR, BG, BB: integer;
    cDPI, sDPI: integer;
    Hex, RGB, copied: string;
    bSetValue: Boolean;
    Transpath, APPDir, SPath, TransDir: string;
    LangList: TStringList;
    DefFont, iEventCtrl: integer; //iEventCtrl  0=none, 1=dropdown, 2=HexEdit, 3=RGBSlider, 4=RGBEdit, 5=HSVSlider, 6=HSVEdit
    ScaleX, ScaleY, DefX, DefY: double;
    bFirstTime: boolean;
    OriBMP: TBitmap;
    procedure OnSHint(Sender: TObject);
    procedure SetTBPos;
    procedure FGGroupSizeChange(Large: boolean = True);
    procedure BGGroupSizeChange(Large: boolean = True);
    procedure ResGroupSizeChange(Large: boolean = True);
    procedure ResizeCtrls;
    procedure LoadLang(mnuCreate: boolean = true);
    procedure mnuLangChildClick(Sender: TObject);
    procedure WMDPIChanged(var Message: TMessage); message WM_DPICHANGED;
    procedure SetThumbHeight;
  public
    { Public declare }
    arSS_HDC: array of HDC;
    SS_bmp: HBITMAP;
    SelFore: Boolean;
    Dither1, Dither2: byte;
    function CalcColor: Extended;
    Procedure SetAbsoluteForegroundWindow(HWND: hWnd);
    procedure GetSS;
    function GetTranslation(Key, Default: string): string;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSyscommand(var Message: TWmSysCommand); message WM_SYSCOMMAND;
  end;

var
  MainForm: TMainForm;
implementation

uses Pick, about, SelListForm, ProgressForm, ConvWnd;


{$R *.dfm}

procedure RGBtoHSV(R, G, B: integer; var Hue, Satu, Value: extended);
var
  iMax, iMin: integer;
  eR, eG, eB: Extended;
begin
  iMax := Max(Max(R, G), B);
  iMin := Min(Min(R, G), B);

  Value := iMax / 255.0;
  if iMax = 0 then
    Satu := 0
  else
    Satu := (iMax - iMin) / iMax;

  if Satu = 0 then
    Hue := 0
  else
  begin
    eR := (iMax - R) / (iMax - iMin);
    eG := (iMax - G) / (iMax - iMin);
    eB := (iMax - B) / (iMax - iMin);
    if R = iMax then
      Hue := eB - eG
    else if G = iMax then
      Hue := 2.0 + eR - eB
    else
      Hue := 4.0 + eG - eR;

    Hue := Hue / 6.0;
    if Hue < 0 then
      Hue := Hue + 1.0;
  end;
end;

procedure HSVtoRGB(Hue, Satu, Value: Extended; var R, G, B:integer);
var
  h, e: Extended;
  j, k, l: integer;
begin
  if Satu = 0 then
  begin
    R := Floor(Value * 255.0 + 0.5);
    G := R;
    B := R;
  end
  else
  begin
    h := (Hue - Floor(Hue)) * 6.0;
    e := h - Floor(h);

    j := Trunc((Value * (1.0 - satu)) * 255.0 + 0.5);
    k := Trunc((Value * (1.0 - satu * e)) * 255.0 + 0.5);
    l := Trunc((Value * (1.0 - (satu * (1.0 - e)))) * 255.0 + 0.5);

    R := Trunc(Value * 255.0 + 0.5);
    G := Trunc(Value * 255.0 + 0.5);
    B := Trunc(Value * 255.0 + 0.5);
    case trunc(h) of
      0:
      begin
        G := l;
        B := j;
      end;
      1:
      begin
        R := k;
        B := j;
      end;
      2:
      begin
        R := j;
        B := l;
      end;
      3:
      begin
        R := j;
        G := k;
      end;
      4:
      begin
        R := l;
        G := j;
      end;
      5:
      begin
        G := j;
        B := k;
      end;
    end;

  end;
end;

function DoubleToInt(d: double): integer;
begin
  SetRoundMode(rmUP);
  Result := Trunc(SimpleRoundTo(d));
end;

function GetMyDocPath: string;
var
  IIDList: PItemIDList;
  hr: hresult;
  buffer: array [0..MAX_PATH - 1] of char;
begin
  IIDList := nil;
  Result := '';
  hr := SHGetSpecialFolderLocation(Application.Handle,
    CSIDL_PERSONAL, IIDList);
  if SHGetPathFromIDList(IIDList, buffer) then
  begin
    Result := StrPas(Buffer);
  end;

end;

procedure TMainForm.ResizeCtrls;
var
  sWidth, sHeight, mH: integer;
  dc: HDC;
  ACanvas: TCanvas;
    procedure GetStrSize(Cap: string; cv: TCanvas);
    begin
      sWidth := cv.TextWidth(Cap);
      sHeight := cv.TextHeight(Cap) + 2;
    end;
begin
	if (not bFirstTime) and (ScaleX <> 1) then
		self.ChangeScale(sDPI, cDPI);
  Font.Size := DefFont;
  Canvas.Font := Font;
  GetStrSize(label1.Caption, Canvas);
  if (ScaleY > 1.0) and (sWidth < 125) then
    sWidth := 130;

  if (sWidth > 125) then
  begin
    grdFHex.Width := (sWidth) * 2 + 50;
  end
  else
    grdFHex.Width := 310;
  if sHeight > 25 then
  begin
    //grdFHex.Height := (sHeight + 10) * 2;
    grdFHex.Top := sHeight;
    grdBHex.Top := sHeight;
  end
  else
  begin
    //grdFHex.Height := 55;
    grdFHex.Top := sHeight {div 2 + 10};
    grdBHex.Top := sHeight {div 2 + 10};
  end;
  grdFHex.Height :=  (sHeight + Font.Size) * 2;


  FJColor.Align := alClient;
  FJColor.ItemHeight := sHeight - 2;

  BColor.Align := alClient;
  BColor.ItemHeight := sHeight - 2;

  grdBHex.Width := grdFHex.Width;
  grdBHex.Height := grdFHex.Height;

  gbFore.Width := grdFHex.Width + 17;
  gbBack.Width := gbFore.Width;
  gbBack.Left := gbFore.BoundsRect.Right + 6;

  grdFRGB.Visible := mnuRGBSlider.Checked;
  grdBRGB.Visible := mnuRGBSlider.Checked;

  grdFRGB.Width := grdFHex.Width;
  grdFRGB.Height := grdFHex.Height * 3;

  grdFHSV.Visible := mnuHSVSlider.Checked;
  grdBHSV.Visible := mnuHSVSlider.Checked;






  gbFore.Height := grdFHex.BoundsRect.Bottom + 10;
  if mnuRGBSlider.Checked then
  begin
    grdFRGB.Top := grdFHex.BoundsRect.Bottom;
    if mnuHSVSlider.Checked then
    begin
      grdFHSV.Top := grdFRGB.BoundsRect.Bottom;
    end;
  end
  else
  begin
    if mnuHSVSlider.Checked then
    begin
      grdFHSV.Top := grdFHex.BoundsRect.Bottom;
    end;
  end;
  grdBRGB.Top := grdFRGB.Top;
  grdBHSV.Top := grdFHSV.Top;
  grdFHSV.Width := grdFRGB.Width;
  grdFHSV.Height := grdFRGB.Height;
  grdBRGB.Width := grdFRGB.Width;
  grdBRGB.Height := grdFRGB.Height;
  grdBHSV.Width := grdBRGB.Width;
  grdBHSV.Height := grdBRGB.Height;

  if mnuRGBSlider.Checked then
  begin
    gbFore.Height := grdFRGB.BoundsRect.Bottom + 10;
    if mnuHSVSlider.Checked then
    begin
      gbFore.Height := grdFHSV.BoundsRect.Bottom + 10;
    end;
  end
  else
  begin
    if mnuHSVSlider.Checked then
    begin
      gbFore.Height := grdFHSV.BoundsRect.Bottom + 10;
    end;
  end;

  gbBack.Height := gbFore.Height;

  gbresNormal.Top := gbFore.BoundsRect.Bottom + 5;
  gbresNormal.Width := gbBack.BoundsRect.Right - gbresNormal.Left;

  edtnormal_lt2.Font.Size := DefFont + 5;//DoubleToInt((DefFont + 5) * ScaleY);
  edtnormal_lt2.Font.Style := [fsBold];
  dc := GetDC(edtnormal_lt2.Handle);
  ACanvas := TCanvas.Create;
  try
    ACanvas.Handle :=DC;
    ACanvas.Font := edtnormal_lt2.Font;
    GetStrSize(edtnormal_lt2.Text, ACanvas);
    edtnormal_lt2.Width := sWidth + 15;
    edtnormal_lt2.Height := sHeight + 5;
  finally
    ACanvas.Free;
    ReleaseDC(edtnormal_lt2.Handle, dc);
  end;

  sHeight := grdFHex.Height div 2;
  if sHeight > 25 then
  begin
    gbText.Top := DoubleToInt(sHeight * 0.75);
    Image1.Top := DoubleToInt(sHeight * 0.75);
    Image8.Top := DoubleToInt(sHeight * 0.75);
  end
  else
  begin
    gbText.Top := sHeight div 2 + 5;
    Image1.Top := sHeight div 2 + 5;
    Image8.Top := Image1.Top;
  end;
  gbText.ClientWidth := edtnormal_lt2.Width + Image1.Width + 20; //sWidth;
  Memo1.Left := gbText.BoundsRect.Right + 8;
  Memo1.Top := gbText.Top;
  Memo1.Width := gbResNormal.ClientWidth - gbText.Width - 24;
  Image1.Width := sHeight;
  Image1.height := sHeight;
  Image7.Width := sHeight;
  Image7.height := sHeight;
  Image8.Width := sHeight;
  Image8.height := sHeight;
  Image9.Width := sHeight;
  Image9.height := sHeight;

  edtnormal_t.Top := Image1.Top;
  edtnormal_t.Left := Image1.BoundsRect.Right + 5;
  edtnormal_t.Height := sHeight;
  edtnormal_t.Width := gbText.ClientWidth - Image1.BoundsRect.Right - 15;
  edtnormal_t.Font.Size :=  DefFont;//DoubleToInt(DefFont * ScaleY);


  Image7.Top := edtnormal_t.BoundsRect.Bottom + 3;
  edtnormal_t2.Top := Image7.Top;
  edtnormal_t2.Left := Image7.BoundsRect.Right + 5;
  edtnormal_t2.Height := sHeight;
  edtnormal_t2.Width := gbText.ClientWidth - Image7.BoundsRect.Right - 15;
  edtnormal_t2.Font.Size := DefFont;// DoubleToInt(DefFont * ScaleY);
  gbTExt.Height := edtNormal_T2.BoundsRect.Bottom + 8;

  gbLText.Top := gbText.BoundsRect.Bottom + 5;
  gbLText.ClientWidth := gbText.ClientWidth;
  edtnormal_lt.Top := Image8.Top;
  edtnormal_lt.Left := Image8.BoundsRect.Right + 5;
  edtnormal_lt.Height := edtnormal_lt2.Height;
  edtnormal_lt.Width := edtnormal_lt2.Width;
  edtnormal_lt.Font.Size :=  DefFont + 5;//DoubleToInt((DefFont + 5) * ScaleY);
  edtnormal_lt.Font.Style := [fsBold];

  Image9.Top := edtnormal_lt.BoundsRect.Bottom + 3;
  edtnormal_lt2.Top := Image9.Top;
  edtnormal_lt2.Left := Image9.BoundsRect.Right + 5;

  gblTExt.Height := edtNormal_lT2.BoundsRect.Bottom + 8;
  if Image1.Height < edtnormal_t.Height then
  begin
    Image1.Top := edtnormal_t.Top + ((edtnormal_t.Height - Image1.Height) div 2);
    Image7.Top := edtnormal_t2.Top + ((edtnormal_t2.Height - Image7.Height) div 2);
  end;

  if Image8.Height < edtnormal_lt.Height then
  begin
    Image8.Top := edtnormal_lt.Top + ((edtnormal_lt.Height - Image8.Height) div 2);
    Image9.Top := edtnormal_lt2.Top + ((edtnormal_lt2.Height - Image9.Height) div 2);
  end;


  chkBlind.Top := gblText.BoundsRect.Bottom + 5;
  chkBlind.Height := sHeight + 7;
  GetStrSize(btnCopyRes.Caption, Canvas);
  if sHeight < 25 then
    sHeight := 25;
  btnCopyRes.Height := sHeight + 7;
  btnCopyRes.Width := sWidth + 10;
  btnCopyRes.Top := gblText.BoundsRect.Bottom + 5;
  btnCopyRes.Left := Memo1.BoundsRect.Right - btnCopyRes.Width;

  chkBlind.Width := gbResnormal.ClientWidth - btnCopyRes.Width - 24;
  gbResNormal.Height := btnCopyRes.BoundsRect.Bottom + 8;
  Memo1.Height := gbLtext.BoundsRect.Bottom - Memo1.Top;

  gbResBlind.Top := Memo1.Top;
  gbResBlind.Left := Memo1.Left;
  gbResBlind.Width := Memo1.Width;
  gbResBlind.Height := Memo1.Height;

  edtNormal2.Top := sHeight * 2;

  mH := (gbResBlind.ClientHeight - edtNormal2.Top) div 8;
  edtNormal2.Height := mH;
  edtNormal2.EditLabel.Height := edtNormal2.Height;
  edtNormal2.Left := 8;
  edtNormal2.Width := gbResBlind.Width - 16;
  edtNormal2.Font.Size := DefFont;//DoubleToInt(DefFont * ScaleY);

  edtProta.Height := mH;
  edtProta.EditLabel.Height := mH;
  edtProta.Left := 8;
  edtProta.Width := gbResBlind.Width - 16;
  edtProta.Top := edtNormal2.BoundsRect.Bottom + 5 + mH;
  edtProta.Font.Size := DefFont;//DoubleToInt(DefFont * ScaleY);

  edtDeutera.Height := mH;
  edtDeutera.EditLabel.Height := mH;
  edtDeutera.Left := 8;
  edtDeutera.Width := gbResBlind.Width - 16;
  edtDeutera.Top := edtProta.BoundsRect.Bottom + 5 + mH;
  edtDeutera.Font.Size := DefFont;//DoubleToInt(DefFont * ScaleY);

  edtTrita.Height := mH;
  edtTrita.EditLabel.Height := mH;
  edtTrita.Left := 8;
  edtTrita.Width := gbResBlind.Width - 16;
  edtTrita.Top := edtDeutera.BoundsRect.Bottom + 5 + mH;
  edtTrita.Font.Size := DefFont;//DoubleToInt(DefFont * ScaleY);


  clientWidth := gbBack.BoundsRect.Right + 10;
  clientHeight := gbResnormal.BoundsRect.Bottom + Statusbar1.Height + 10;

  application.ProcessMessages;
  if not bFirstTime then
		self.ChangeScale(DoubleToInt(width * ScaleX), width);
  SetThumbHeight;

end;


procedure TMainForm.SetThumbHeight;
var
	i, w, iHeight: integer;
  dBMP, mBMP: TBitmap;
  tpColor: TColor;
  dx: double;
begin
	iHeight := (grdfrgb.ClientHeight div 6) - 5;

  FJColor.Itemheight :=  iHeight - DoubletoInt(4 * ScaleX);
  BColor.Itemheight :=  FJColor.Itemheight;
	for i := 0 to grdFRGB.ControlCount - 1 do
  begin
    if grdFRGB.Controls[i] is TAccTrackBar then
    	TAccTrackBar(grdFRGB.Controls[i]).ThumbLength := iHeight;
  end;

  for i := 0 to grdFHSV.ControlCount - 1 do
  begin
    if grdFHSV.Controls[i] is TAccTrackBar then
    	TAccTrackBar(grdFHSV.Controls[i]).ThumbLength := iHeight;
  end;

  for i := 0 to grdBRGB.ControlCount - 1 do
  begin
    if grdBRGB.Controls[i] is TAccTrackBar then
    	TAccTrackBar(grdBRGB.Controls[i]).ThumbLength := iHeight;
  end;

  for i := 0 to grdBHSV.ControlCount - 1 do
  begin
    if grdBHSV.Controls[i] is TAccTrackBar then
    	TAccTrackBar(grdBHSV.Controls[i]).ThumbLength := iHeight;
  end;



  dBMP := TBitmap.Create;
  mBMP := TBitmap.Create;
  try
  	iHeight := DoubleToInt(16 * ScaleX);
  	dBMP.PixelFormat :=pf24bit;
		mBMP.PixelFormat :=pf24bit;
  	dBMP.Width := iHeight;
  	dBMP.Height := iHeight;
  	mBMP.Width := iHeight;
  	mBMP.Height := iHeight;

  	tpColor := OriBMP.Canvas.Pixels[0, 0];

    StretchBlt(dBMP.Canvas.Handle, 0, 0, dBMP.Width, dBMP.Height, OriBMP.Canvas.Handle, 0, 0, OriBMP.Width, OriBMP.Height, SRCCOPY);
  	StretchBlt(mBMP.Canvas.Handle, 0, 0, mBMP.Width, mBMP.Height, OriBMP.Canvas.Handle, 0, 0, OriBMP.Width, OriBMP.Height, SRCCOPY);
  	mBMP.Mask(tpColor);

    ImageList2.Delete(0);

    ImageList2.Height := iHeight;
  	ImageList2.Width := iHeight;
  	ImageList2.Add(dBMP, mBMP);

  finally
 		dBMP.Free;
  	mBMP.Free;
  end;
  if (ScaleX = 1.0) and (cDPI > 96) then
  	dx := cDPI / 96
  else
  	dx := ScaleX;
  i := DoubleToInt(50 * dx);
  if i < 50 then
  	i := 50;
  w := (grdFHex.ClientWidth - i) div 2;
  grdFHex.ColumnCollection.Items[0].SizeStyle := TSizeStyle.ssAbsolute;
  grdFHex.ColumnCollection.Items[1].SizeStyle := TSizeStyle.ssAbsolute;
  grdFHex.ColumnCollection.Items[2].SizeStyle := TSizeStyle.ssAbsolute;
  grdFHex.ColumnCollection.Items[0].Value := w;
  grdFHex.ColumnCollection.Items[1].Value := i;
  grdFHex.ColumnCollection.Items[2].Value := w;

  grdBHex.ColumnCollection.Items[0].SizeStyle := TSizeStyle.ssAbsolute;
  grdBHex.ColumnCollection.Items[1].SizeStyle := TSizeStyle.ssAbsolute;
  grdBHex.ColumnCollection.Items[2].SizeStyle := TSizeStyle.ssAbsolute;
  grdBHex.ColumnCollection.Items[0].Value := w;
  grdBHex.ColumnCollection.Items[1].Value := i;
  grdBHex.ColumnCollection.Items[2].Value := w;
end;

procedure TMainForm.ResGroupSizeChange(Large: boolean = True);
begin
    Memo1.Visible := Large;
    btnCopyRes.Visible := Large;

    ResizeCtrls;
end;

procedure TMainForm.bbRNSCClick(Sender: TObject);
begin
    ResGroupSizeChange(not Memo1.Visible);

end;

procedure TMainForm.bbRBSCClick(Sender: TObject);
begin
    ResGroupSizeChange(not edtProta.Visible);

end;

procedure TMainForm.FGGroupSizeChange(Large: boolean = True);
begin
  grdFHSV.Visible := Large;
  if Large then
  begin
    gbFore.Height := grdFRGB.Height + grdFHSV.Height + grdFHex.Height + 30;
  end
  else
  begin
    gbFore.Height := grdFRGB.Height + grdFHex.Height + 30;
  end;
  ResizeCtrls;
end;



procedure TMainForm.bbFGSCClick(Sender: TObject);
begin
    FGGroupSizeChange(not lblFR.Visible);

end;

procedure TMainForm.BGGroupSizeChange(Large: boolean = True);
begin
  grdBHSV.Visible := Large;
  if Large then
  begin
    gbBack.Height := grdBRGB.Height + grdBHSV.Height + grdBHex.Height + 30;
  end
  else
  begin
    gbBack.Height := grdBRGB.Height + grdBHex.Height + 30;
  end;
  ResizeCtrls;
end;

procedure TMainForm.bbBGSCClick(Sender: TObject);
begin
    BGGroupSizeChange(not lblbR.Visible);

end;

procedure TMainForm.SetTBPos;
var
    RGBColor: LongInt;
    dH, dS, dV: Extended;
    R, G, B: integer;

begin

    bSetValue := True;
    RGBColor := ColorToRGB(FJColor.ActiveColor);
    R := ($000000FF and RGBColor);
    G := ($0000FF00 and RGBColor) shr 8;
    B := ($00FF0000 and RGBColor) shr 16;

    FBEdit.Text := Inttostr(B);
    FGEdit.Text := Inttostr(G);
    FREdit.Text := Inttostr(R);

    tbFR.Position := R;
    tbFG.Position := G;
    tbFB.Position := B;
    if iEventCtrl <> 5 then
    begin
      RGBtoHSV(R, G, B, dH, dS, dV);
      tbFH.Position := Doubletoint(dH * 360);
      tbFS.Position := Doubletoint(dS * 100);
      tbFV.Position := Doubletoint(dV * 100);

    end;


    RGBColor := ColorToRGB(BColor.ActiveColor);
    R := ($000000FF and RGBColor);
    G := ($0000FF00 and RGBColor) shr 8;
    B := ($00FF0000 and RGBColor) shr 16;

    BBEdit.Text := Inttostr(B);
    BGEdit.Text := Inttostr(G);
    BREdit.Text := Inttostr(R);

    tbBR.Position := R;
    tbBG.Position := G;
    tbBB.Position := B;
    if iEventCtrl <> 5 then
    begin
      RGBtoHSV(R, G, B, dH, dS, dV);
      tbBH.Position := Doubletoint(dH * 360);
      tbBS.Position := Doubletoint(dS * 100);
      tbBV.Position := Doubletoint(dV * 100);
    end;

    FHEdit.Text := InttoStr(tbFH.Position);
    FSEdit.Text := InttoStr(tbFS.Position);
    FVEdit.Text := InttoStr(tbFV.Position);

    BHEdit.Text := InttoStr(tbBH.Position);
    BSEdit.Text := InttoStr(tbBS.Position);
    BVEdit.Text := InttoStr(tbBV.Position);
end;



procedure TMainForm.FJColorChanged(Sender: TObject);
begin
    if (not PickForm.Showing) and (not bSetValue) then
    begin
      if iEventCtrl = 0 then iEventCtrl := 1;
      CalcColor;
    end;

end;

function TMainForm.GetTranslation(Key, Default: string): string;
var
    ini: TMemIniFile;
begin
    ini := TMemIniFile.Create(TransPath, TEncoding.UTF8);
    try
        Result := ini.ReadString('Translations', Key, Default);
    finally
        ini.Free;
    end;
end;

procedure TMainForm.OnSHint(Sender: TObject);
begin
    StatusBar1.SimpleText := {TntControls.Wide}GetLongHint(Application.Hint);
end;

procedure TMainForm.WMSyscommand(var Message: TWmSysCommand);
begin

        inherited;
end;


procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
    inherited CreateParams(Params);

end;

procedure TMainForm.mnuLangChildClick(Sender: TObject);
var
    i: integer;
    bChk: boolean;
    lf: string;
    ini: TMemIniFile;
begin
    if not (Sender is TMenuitem) then
        Exit;
    (Sender as TMenuitem).Checked := not (Sender as TMenuitem).Checked;
    if mnuLang.Count > 0 then
    begin
        bChk := False;
        for i := 0 to mnuLang.Count - 1 do
        begin
            if i > LangList.Count - 1 then
                Break;
            if mnuLang.Items[i].Checked then
            begin
                bChk := True;
                lf := LangList[i];
                Break;
            end;
        end;
        if not bChk then
        begin
            if (Sender is TMenuitem) then
            begin
                if (Sender as TMenuitem).MenuIndex > LangList.Count - 1 then
                begin
                    mnuLang.Items[0].Checked := True;
                    lf := LangList[0];
                end
                else
                begin
                    (Sender as TMenuitem).Checked := True;
                    lf := LangList[(Sender as TMenuitem).MenuIndex];
                end;
            end;
        end;
        if LowerCase(TransPath) <> LowerCase(TransDir + lf)  then
        begin
            TransPath := TransDir + lf;
            //showmessage(Transpath);
            LoadLang(False);
            if FileExists(SPath) then
						begin
							ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
							try
								ini.WriteString('Settings', 'FontName', Font.Name);
								ini.WriteInteger('Settings', 'FontSize', Font.Size);
								ini.WriteInteger('Settings', 'Charset', Font.Charset);
								ini.WriteString('Settings', 'LangFile', lf);
								ini.UpdateFile;
							finally
								ini.Free;
							end;
						end;
        end;
    end;
end;

procedure TMainForm.LoadLang(mnuCreate: boolean = true);
var
    ini: TMemIniFile;
    d: string;
    i: integer;
    mItem: TMenuItem;
begin
    if mnuCreate then
    begin
    	if FileExists(SPath) then
			begin
				ini := TMemIniFile.Create(SPath, TEncoding.Unicode);

				try
					if mnuLang.Visible then
					begin
						d := ini.ReadString('Settings', 'LangFile', 'Default.ini');
						Transpath := TransDir + d;
					end;
				finally
					ini.Free;

				end;
			end;
        if mnuLang.Visible then
        begin
            if LangList.Count = 0 then
                mnuLang.Enabled := False;
            for i := 0 to LangList.Count - 1 do
            begin
                if FileExists(TransDir + LangList[i]) then
                begin
                    ini := TMemIniFile.Create(TransDir + LangList[i], TEncoding.UTF8);
                    try
                        mItem := MainMenu1.CreateMenuItem;
                        mItem.Caption := Ini.ReadString('Translations', 'Language', 'English');
                        mItem.RadioItem := True;
                        mItem.GroupIndex := 1;
                        //mItem.AutoCheck := True;
                        mItem.OnClick := mnuLangChildClick;
                        if LowerCase(TransPath) = LowerCase(TransDir + LangList[i])  then
                            mItem.Checked := True
                        else
                            mItem.Checked := False;
                        mnuLang.Add(mItem);
                    finally
                        ini.Free;
                    end;
                end;
            end;
            if LangList.Count = 1 then
                mnuLang.Items[0].Checked := True;
        end;
    end;
    ini := TMemIniFile.Create(TransPath, TEncoding.UTF8);

    try

        caption := ini.ReadString('Translations', 'Caption', 'Colour Contrast Analyser');
        gbResNormal.Caption := ini.ReadString('Translations', 'result_luminosity', 'Result - luminosity');
        gbResBlind.Caption := ini.ReadString('Translations', 'result_cb', 'Result');
        gbFore.Caption := ini.ReadString('Translations', 'Foreground', 'Foreground');
        gbBack.Caption := ini.ReadString('Translations', 'Background', 'Background');
        Hex := ini.ReadString('Translations', 'hex', 'Hex:');
        RGB := ini.ReadString('Translations', 'rgb', 'RGB:');
        mnuHex.Caption := ini.ReadString('Translations', 'hex_menu', 'Hex');
        mnuRGB.Caption := ini.ReadString('Translations', 'rgb_menu', 'RGB');
        sbtnFore.Hint := ini.ReadString('Translations', 'pick_forebtn', 'F11|F11 is pick foreground colour.');
        sbtnBack.Hint := ini.ReadString('Translations', 'pick_backbtn', 'F12|F12 is pick background colour.');
        FJColor.Hint := ini.ReadString('Translations', 'fore_dropdown', 'F9|The dropdown is the F9 key. Afterwards, please select the colour.');
        BColor.Hint := ini.ReadString('Translations', 'back_dropdown', 'F10|The dropdown is the F10 key. Afterwards, please select the colour.');
        Edit1.Hint := ini.ReadString('Translations', 'fore_edit', '|The picked colour is displayed. And, the value can be input.');
        Edit2.Hint := ini.ReadString('Translations', 'back_edit', '|The picked colour is displayed. And, the value can be input.');
        btnCopyRes.Hint := ini.ReadString('Translations', 'Copy_hint', '|The text of the result is copied to the clipboard.');
        edtProta.EditLabel.Caption := ini.ReadString('Translations', 'protanopia', 'Protanopia');
        gbText.Caption := ini.ReadString('Translations', 'Text', 'Text');
        gbLText.Caption := ini.ReadString('Translations', 'Large_Text', 'Large text');
        edtNormal2.EditLabel.Caption := ini.ReadString('Translations', 'normal', 'Normal');
        edtDeutera.EditLabel.Caption := ini.ReadString('Translations', 'deuteranopia', 'Deuteranopia');
        edtTrita.EditLabel.Caption := ini.ReadString('Translations', 'tritanopia', 'Tritanopia');

        mnuOnTop.Caption := ini.ReadString('Translations', 'stayontop', 'Always on top');
        mnuFont.Caption := ini.ReadString('Translations', 'font', 'Font...');
        mnuOptions.Caption := ini.ReadString('Translations', 'optgroup', 'Options');
        mnuShowBlind.Caption := ini.ReadString('Translations', 'show_result', 'Show contrast result for colour blindness');
        chkBlind.Caption := ini.ReadString('Translations', 'show_result', 'Show contrast result for colour blindness');
        Label1.Caption := ini.ReadString('Translations', 'colour_select', 'Colour select:');
        Label2.Caption := ini.ReadString('Translations', 'colour_select', 'Colour select:');
        mnuAbout.Caption := ini.ReadString('Translations', 'about', '&about...');
        mnuHelp.Caption := ini.ReadString('Translations', 'help', '&Help');
        mnuHelp1.Caption := ini.ReadString('Translations', 'help', '&Help');
        FJColor.Other := ini.ReadString('Translations', 'other', '&Others...');
        BColor.Other := ini.ReadString('Translations', 'other', '&Others...');

        mnuIMG.Caption := ini.ReadString('Translations', 'image', '&Image');
        mnuSelList.Caption := ini.ReadString('Translations', 'selwnd_list', '&Select window(List)');
        mnuSelIMG.Caption := ini.ReadString('Translations', 'Select_image', 'Select &image file');
        mnuScreen.Caption := ini.ReadString('Translations', 'Screen', 'S&creen');
        btnCopyRes.Caption := ini.ReadString('Translations', 'Copy_results', 'Copy results');
        mnuP_Value.Caption := ini.ReadString('Translations', 'displayed_color_value_menu', '&Displayed color value');
        lblFR.Caption := ini.ReadString('Translations', 'Red', 'Red:');
        lblBR.Caption := lblFR.Caption;
        lblFG.Caption := ini.ReadString('Translations', 'Green', 'Green:');
        lblBG.Caption := lblFG.Caption;
        lblFB.Caption := ini.ReadString('Translations', 'Blue', 'Blue:');
        lblBB.Caption := lblFB.Caption;

        chkFGSync.Caption := ini.ReadString('Translations', 'Sync', 'Sync');
        chkBGSync.Caption := chkFGSync.Caption;

        copied := ini.ReadString('Translations', 'copied', 'The result was copied to the clipboard.');

        mnufg1px.Caption := ini.ReadString('Translations', '1px', '1pixel');
        mnubg1px.Caption := ini.ReadString('Translations', '1px', '1pixel');

        mnufg2px.Caption := ini.ReadString('Translations', '2px', '2 x 2 pixels');
        mnubg2px.Caption := ini.ReadString('Translations', '2px', '2 x 2 pixels');

        mnufg3px.Caption := ini.ReadString('Translations', '3px', '3 x 3 pixels');
        mnubg3px.Caption := ini.ReadString('Translations', '3px', '3 x 3 pixels');

        mnufg4px.Caption := ini.ReadString('Translations', '4px', '4 x 4 pixels');
        mnubg4px.Caption := ini.ReadString('Translations', '4px', '4 x 4 pixels');


        mnufg5px.Caption := ini.ReadString('Translations', '5px', '5 x 5 pixels');
        mnubg5px.Caption := ini.ReadString('Translations', '5px', '5 x 5 pixels');

        mnufg6px.Caption := ini.ReadString('Translations', '6px', '6 x 6 pixels');
        mnubg6px.Caption := ini.ReadString('Translations', '6px', '6 x 6 pixels');

        mnufg7px.Caption := ini.ReadString('Translations', '7px', '7 x 7 pixels');
        mnubg7px.Caption := ini.ReadString('Translations', '7px', '7 x 7 pixels');

        mnufg8px.Caption := ini.ReadString('Translations', '8px', '8 x 8 pixels');
        mnubg8px.Caption := ini.ReadString('Translations', '8px', '8 x 8 pixels');

        mnuLang.Caption := ini.ReadString('Translations', 'mnuLang', 'English');


        mnuSlider.Caption := ini.ReadString('Translations', 'Show_Sliders', 'Show colour sliders');
        lblFH.Caption := ini.ReadString('Translations', 'Hue', 'Hue:');
        lblBH.Caption := lblFH.Caption;
        lblFS.Caption := ini.ReadString('Translations', 'Saturation', 'Saturation:');
        lblBS.Caption := lblFS.Caption;
        lblFV.Caption := ini.ReadString('Translations', 'Value', 'Value:');
        lblBV.Caption := lblFV.Caption;
        mnuRGBSlider.Caption := ini.ReadString('Translations', 'rgb_menu', '&RGB');
        mnuHSVSlider.Caption := ini.ReadString('Translations', 'hsv_menu', '&HSV');
    finally
        ini.Free;
    end;
    CalcColor;
    ResizeCtrls;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    ini: TMemIniFile;
    Rec     : TSearchRec;
    slist: TStringList;
    enc: TEncoding;
begin
    bFirstTime := True;
    SystemCanSupportPerMonitorDpi(true);
    GetDCap(self.Handle, Defx, Defy);
    GetWindowScale(self.Handle, DefX, DefY, ScaleX, ScaleY);
    cDPI := DoubleToInt(DefY * ScaleY);
    sDPI := cDPI;
    iEventCtrl := 0;
    FJColor.Align := alClient;
    BColor.Align := alClient;

    OriBMP := TBitmap.Create;
    Imagelist2.GetBitmap(0, oriBMP);
    {dc := GetDC(0);
    scaleX := GetDeviceCaps(dc, LOGPIXELSX) / 96.0;
    scaleY := GetDeviceCaps(dc, LOGPIXELSY) / 96.0;
    ReleaseDC(0, dc);   }
    APPDir :=  IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
    TransDir := IncludeTrailingPathDelimiter(AppDir + 'Lang');
    mnuLang.Visible := FileExists(TransDir + 'Default.ini');
    if mnuLang.Visible then
        Transpath := TransDir + 'Default.ini'
    else
        Transpath := APPDir + ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');

    SPath := IncludeTrailingPathDelimiter(GetMyDocPath) + 'CCA.ini';
    bSetValue := False;
    SelFore := True;

    Application.OnHint := OnSHint;
    if FileExists(SPath) then
		begin
			slist := TStringList.Create;
			try
				slist.LoadFromFile(SPath);
				if slist.Encoding <> TEncoding.Unicode then
					slist.SaveToFile(SPath, TEncoding.Unicode);
			finally
				slist.Free;
			end;
    end;
    try
			ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
			try
				Font.Charset := ini.ReadInteger('Font', 'Charset', 0);
				Font.Name := ini.ReadString('Font', 'Name', 'Arial');
				Font.Size := ini.ReadInteger('Font', 'Size', 9);
				DefFont := Font.Size;

				FJColor.Font := Font;
				BColor.Font := Font;
				Left := ini.ReadInteger('Window', 'Left', (Screen.WorkAreaWidth div 2) -
					(Width div 2));
				Top := ini.ReadInteger('Window', 'Top', (Screen.WorkAreaHeight div 2) -
					(Height div 2));
				mnuOnTop.Checked := ini.ReadBool('Options', 'Stayontop', False);
				mnuHSVSlider.Checked := ini.ReadBool('Options', 'HSVSlider', False);
				mnuRGBSlider.Checked := ini.ReadBool('Options', 'RGBSlider', False);
				BGGroupSizeChange(mnuSlider.Checked);
				FGGroupSizeChange(mnuSlider.Checked);

				mnuOnTopClick(self);
			finally
				ini.Free;
			end;
    except
		end;
    Width := DoubleToInt(Width * ScaleX);
    Height := DoubleToInt(Height * ScaleY);
    edtNormal_T.Font.Style := [];
    edtNormal_T.Font.Size := 9;
    edtNormal_T2.Font.Style := [];
    edtNormal_T2.Font.Size := 9;
    edtNormal_LT.Font.Style := [fsBold];
    edtNormal_LT.Font.Size := 14;
    edtNormal_LT2.Font.Style := [fsBold];
    edtNormal_LT2.Font.Size := 14;
    Hex := 'Hex';
    RGB := 'RGB';


    LangList := TStringList.Create;

    if mnuLang.Visible then
    begin
        if  (FindFirst(TransDir + '*.ini', faAnyFile, Rec) = 0) then
        begin
            repeat
                if  ((Rec.Name <> '.') and (Rec.Name <> '..')) then
                begin
                    if  ((Rec.Attr and faDirectory) = 0)  then
                    begin
                    LangList.Add(Rec.Name);
                    end;
                end;
            until (FindNext(Rec) <> 0);
        end;
    end;
    LoadLang;

    if not mnuHEX.Checked then
    begin
        mnuHexClick(self);
    end
    else
    begin
        mnuRGBClick(Self);
    end;
    CalcColor;
    Dither1 := 1;
    Dither2 := 1;
    self.ChangeScale(DoubleToInt(width * ScaleX), width);
    SetThumbHeight;
    cDPI := DoubleToInt(DefY * ScaleY);

    bFirstTime := False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: integer;
begin
	for i := Low(arSS_HDC) to High(arSS_HDC) do
		DeleteDC(arSS_HDC[i]);

	if SS_bmp <> 0 then
		DeleteObject(SS_bmp);

  oriBMP.Free;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ini: TMemIniFile;
begin
	try
		ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
		try

			ini.WriteBool('Options', 'Stayontop', mnuOnTop.Checked);
			ini.WriteInteger('Window', 'Left', Left);
			ini.WriteInteger('Window', 'Top', Top);
			ini.WriteBool('Options', 'HSVSlider', mnuHSVSlider.Checked);
			ini.WriteBool('Options', 'RGBSlider', mnuRGBSlider.Checked);
			ini.UpdateFile;
		finally
			ini.Free;
			CanClose := True;
		end;
	except

	end;
end;

procedure TMainForm.acrFColorDropExecute(Sender: TObject);
begin
    FJColor.Drop;
end;

procedure TMainForm.actBColorDropExecute(Sender: TObject);
begin
    BColor.Drop;
end;

procedure TMainForm.actFColorPickExecute(Sender: TObject);
begin
    SelFore := True;
    btnForeClick(sbtnFore);
end;

procedure TMainForm.actBColorPickExecute(Sender: TObject);
begin
    SelFore := False;
    btnForeClick(sbtnBack);
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
    if (Length(Edit1.Text) = 7) and IsHex(Edit1.Text) then
    begin
      if iEventCtrl = 0 then iEventCtrl := 2;
      FJColor.ActiveColor := HexToColor(Edit1.Text);
    end;
end;

function Zeroto255(Num: Integer): integer;
begin
    result := Num;
    if (Num > 255) then result := 255
    else if (Num < 0) then result := 0;
end;

procedure TMainForm.FREditChange(Sender: TObject);
var
    R, G, B: String;
    i: integer;
begin

    if (not bSetValue) then
    begin
        i := StrToIntDef(FREdit.Text, 0);
        R := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(FGEdit.Text, 0);
        G := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(FBEdit.Text, 0);
        B := IntToHex(Zeroto255(i), 2);
        if iEventCtrl = 0 then iEventCtrl := 4;
        FJColor.ActiveColor := StringToColor('$00' + B + G + R);
    end;
end;

procedure TMainForm.BREditChange(Sender: TObject);
var
    R, G, B: String;
    i: integer;

begin
    if (not bSetValue) then
    begin
        i := StrToIntDef(BREdit.Text, 0);

        R := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(BGEdit.Text, 0);
        G := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(BBEdit.Text, 0);
        B := IntToHex(Zeroto255(i), 2);
        if iEventCtrl = 0 then iEventCtrl := 4;
        BColor.ActiveColor := StringToColor('$00' + B + G + R);
    end;
end;

procedure TMainForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #$0D then
    begin
        key := #0;
        if (Length(Edit1.Text) = 7) and IsHex(Edit1.Text) then
          FJColor.ActiveColor := HexToColor(Edit1.Text);
    end;

end;

procedure TMainForm.Edit2Change(Sender: TObject);
begin

  if (Length(Edit2.Text) = 7) and IsHex(Edit2.Text) then
    BColor.ActiveColor := HexToColor(Edit2.Text);
end;

procedure TMainForm.Edit2KeyPress(Sender: TObject; var Key: Char);

begin
    if Key = #$0D then
    begin
        key := #0;
        if (Length(Edit2.Text) = 7) and IsHex(Edit2.Text) then
        begin
            if iEventCtrl = 0 then iEventCtrl := 1;
            BColor.ActiveColor := HexToColor(Edit2.Text);
        end;

    end;
end;

procedure TMainForm.mnuOnTopClick(Sender: TObject);
begin
    if mnuOnTop.Checked then
        FormStyle := fsStayOnTop
    else
       FormStyle := fsNormal;
end;

procedure TMainForm.mnuHelp1Click(Sender: TObject);
begin
    if GetTranslation('docurl', 'http://www.nils.org.au/ais/web/resources/contrast_analyser/index.html') <> '' then
        ShellExecute(Handle, 'open', PChar(GetTranslation('docurl', 'http://www.nils.org.au/ais/web/resources/contrast_analyser/index.html')), nil, nil, SW_SHOW);
end;

procedure TMainForm.mnuHelpDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  aCanvas.font := Font;
  aCanvas.fillrect(aRect);
  acanvas.textrect(aRect, arect.left+20, arect.top+2, TMenuItem(Sender).caption );
end;

procedure TMainForm.mnuHelpMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  aCanvas.font := Font;
  width := aCanvas.TextWidth(TMenuItem(Sender).caption) + 20;
  height := aCanvas.TextHeight(TMenuItem(Sender).caption) + 10;

end;

procedure TMainForm.mnuFontClick(Sender: TObject);
var
    ini: TMemIniFile;
begin
    FontDialog1.Font := Font;
    FontDialog1.Font.Size := DefFont;
    if FontDialog1.Execute then
    begin
        Font := FontDialog1.Font;
        DefFont := Font.Size;

        edtNormal_LT.Font.Style := [fsBold];
        edtNormal_LT2.Font.Style := [fsBold];
        edtNormal2.Font.Style := [fsBold];
        edtDeutera.Font.Style := [fsBold];
        edtProta.Font.Style := [fsBold];
        edtTrita.Font.Style := [fsBold];
        try
					ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
					try
						ini.WriteInteger('Font', 'Charset', Font.Charset);
						ini.WriteString('Font', 'Name', Font.Name);
						ini.WriteInteger('Font', 'Size', Font.Size);
						ini.UpdateFile;
					finally
						ini.Free;
					end;
        except
				end;
        ResizeCtrls;
        //self.ScaleBy(DoubleToInt(OriW * ScaleX), OriW);
        //CurW := DoubleToInt(OriW * ScaleX);
    end;

end;

procedure TMainForm.mnuAboutClick(Sender: TObject);
var
    AboutForm: TAboutForm;
begin
    AboutForm := TAboutForm.Create(self);
    AboutForm.PopupParent := Self;
    AboutForm.Font := Font;
    AboutForm.TransPath := TransPath;
    AboutForm.LoadINI;
    AboutForm.ShowModal;
    AboutForm.Free;
end;

procedure TMainForm.mnuHexClick(Sender: TObject);
begin
    if mnuHex.Checked then Exit;
    mnuHex.Checked := not mnuHex.Checked;
    mnuRGB.Checked := not mnuHex.Checked;
    if mnuHex.Checked then
    begin
        bSetValue := False;
        Edit1.Visible := True;
        Edit2.Visible := True;
        Label3.Caption := Hex;
        Label4.Caption := Hex;
        Edit1.EditMask := '\#aaaaaa;1;_';
        Edit2.EditMask := '\#aaaaaa;1;_';
        Edit1.Text := ColortoHex2(FJColor.ActiveColor);
        Edit2.Text := ColortoHex2(BColor.ActiveColor);
        ResizeCtrls;

    end;
end;

procedure TMainForm.mnuRGBClick(Sender: TObject);

begin
    if mnuRGB.Checked then Exit;
    mnuRGB.Checked := not mnuRGB.Checked;
    mnuHex.Checked := not mnuRGB.Checked;
    if mnuRGB.Checked then
    begin
        bSetValue := False;
        Edit1.Visible := False;
        Edit2.Visible := False;
        Label3.Caption := RGB;
        Label4.Caption := RGB;
        ResizeCtrls;

        CalcColor;
    end;
end;


function TMainForm.CalcColor: Extended;
var
    Back, Fore, High, Low: Extended;
    eRes, eRaw: Extended;
    FC, BC: TColor;
    lcr_l4, lcr, lcr_l2, lcr_l3, lcr_note, lcr_note2, lcr_note3, d, ratio_is, pass, fail, ratio_below: string;
    function Calc(Color: TColor): Extended;
    var
        R, G, B, RsRGB, GsRGB, BsRGB: Extended;
        RGBColor : LongInt;
    begin
        RGBColor := ColorToRGB(Color);
        R := ($000000FF and RGBColor);
        G := ($0000FF00 and RGBColor) shr 8;
        B := ($00FF0000 and RGBColor) shr 16;
        RsRGB := R / 255;
        GsRGB := G / 255;
        BsRGB := B / 255;
        try
            //R := Power((R / 255), 2.2);
            if RsRGB <= 0.03928 then R := RsRGB / 12.92
            else R := Power(((RsRGB + 0.055) / 1.055), 2.4);
        except
            R := 0;
        end;
        try
            //G := Power((G / 255), 2.2);
            if GsRGB <= 0.03928 then G := GsRGB / 12.92
            else G := Power(((GsRGB + 0.055) / 1.055), 2.4);
        except
            G := 0;
        end;
        try
            //B := Power((B / 255), 2.2);
            if BsRGB <= 0.03928 then B := BsRGB / 12.92
            else B := Power(((BsRGB + 0.055) / 1.055), 2.4);
        except
            B := 0;
        end;
        {R := 0.2126 * R;
        G := 0.7152 * G;
        B := 0.0722 * B;}
        Result := 0.2126 * R + 0.7152 * G + 0.0722 * B;//R + G + B;
    end;
begin
    lcr := GetTranslation('res_text_AA', 'Text %s at Level AA');
    lcr_l2 := GetTranslation('res_text_AAA', 'Text %s at Level AAA');
    lcr_l3 := GetTranslation('res_large_text_AA', 'Large text %s at Level AA');

    lcr_l4 := GetTranslation('res_large_text_AAA', 'Large text %s at Level AAA');
    ratio_is := GetTranslation('lcr_ratio_is', 'The contrast ratio is: %s');
    ratio_below := GetTranslation('just_below', 'The contrast ratio is: just below %s');
    lcr_note := GetTranslation('lcr_note', Luminosity_Contrast_Note);
    lcr_note2 := GetTranslation('lcr_note2', Luminosity_Contrast_Note2);
    lcr_note3 := GetTranslation('lcr_note3', 'Note: Fonts that are extraordinarily thin or decorative are harder to read at lower contrast levels.');
    lcr_note := StringReplace(lcr_note, '%rn', #13#10, [rfReplaceAll, rfIgnoreCase]);
    lcr_note2 := StringReplace(lcr_note2, '%rn', #13#10, [rfReplaceAll, rfIgnoreCase]);
    lcr_note3 := StringReplace(lcr_note3, '%rn', #13#10, [rfReplaceAll, rfIgnoreCase]);

    pass := GetTranslation('passed', 'passed');
    fail := GetTranslation('failed', 'failed');
    Image1.Picture := nil;


    Back := Calc(BColor.ActiveColor);
    Fore := Calc(FJColor.ActiveColor);
    High := Max(Back, Fore) + 0.05;
    Low := Min(Back, Fore) + 0.05;
    eRaw := High / Low;
    SetRoundMode(rmUP);
    try
        eRes := SimpleRoundTo(eRaw, -1);
    except
        eRes := 0.0;
    end;
    Result := eRes;
    Edit1.Text := ColortoHex2(FJColor.ActiveColor);
    Edit2.Text := ColortoHex2(BColor.ActiveColor);
    SetTBPos;

    with edtNormal_T do
    begin
        Color := BColor.ActiveColor;
        Font.Color := FJColor.ActiveColor;
    end;
    with edtNormal_T2 do
    begin
        Color := BColor.ActiveColor;
        Font.Color := FJColor.ActiveColor;
    end;
    with edtNormal_LT do
    begin
        Color := BColor.ActiveColor;
        Font.Color := FJColor.ActiveColor;
    end;
    with edtNormal_LT2 do
    begin
        Color := BColor.ActiveColor;
        Font.Color := FJColor.ActiveColor;
    end;
    if eRaw >= 3.0 then
    begin
        if (eRaw >= 3) and (eRaw < 4.5) then
        begin
            Image1.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
            Image7.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
            Image8.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image9.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
        end
        else if (eRaw >= 4.5) and (eRaw < 7) then
        begin
            Image1.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image7.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
            Image8.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image9.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
        end
        else
        begin
            Image1.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image7.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image8.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image9.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
        end;
    end
    else
    begin
        Image1.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
        Image7.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
        Image8.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
        Image9.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end;

    if eRaw < 3.0 then
    begin
        d := d + #13#10 + Format(lcr, [fail]);
        d := d + #13#10 + Format(lcr_l2, [fail]);
        d := d + #13#10 + Format(lcr_l3, [fail]);
        d := d + #13#10 + Format(lcr_l4, [fail]);
        edtNormal_T.Text := GetTranslation('summary_text_fail_AA', 'Fail(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_fail_AA', 'Fail(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
    end
    else if (eRaw >= 3.0) and (eRaw < 4.5) then
    begin

        d := d + #13#10 + Format(lcr, [fail]);
        d := d + #13#10 + Format(lcr_l2, [fail]);
        d := d + #13#10 + Format(lcr_l3, [pass]);
        d := d + #13#10 + Format(lcr_l4, [fail]);
        edtNormal_T.Text := GetTranslation('summary_text_fail_AA', 'Fail(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
    end
    else if (eRaw >= 4.5) and (eRaw < 7.0) then
    begin
        d := d + #13#10 + Format(lcr, [pass]);
        d := d + #13#10 + Format(lcr_l2, [fail]);
        d := d + #13#10 + Format(lcr_l3, [pass]);
        d := d + #13#10 + Format(lcr_l4, [pass]);
        edtNormal_T.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_AAA', 'Pass(AAA)');
    end
    else if eRaw >= 7.0 then
    begin
        d := d + #13#10 + Format(lcr, [pass]);
        d := d + #13#10 + Format(lcr_l2, [pass]);
        d := d + #13#10 + Format(lcr_l3, [pass]);
        d := d + #13#10 + Format(lcr_l4, [pass]);
        edtNormal_T.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_AAA', 'Pass(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_AAA', 'Pass(AAA)');
    end;
    edtNormal2.Color := BColor.ActiveColor;
    edtNormal2.Font.Color := FJColor.ActiveColor;
    if ((2.95 <= eRaw) and (3 > eRaw)) or ((4.45 <= eRaw) and (4.5 > eRaw)) then
    begin
      edtNormal2.Text := Format(ratio_below, [FormatFloat('0.0#', eRes) + ':1']);
      d := gbFore.Caption + ': ' + ColortoHex2(FJColor.ActiveColor) + #13#10 + gbBack.Caption + ': ' + ColortoHex2(BColor.ActiveColor) + #13#10#13#10 + Format(ratio_below, [FormatFloat('0.0#', eRes) + ':1']) + #13#10 + d;
    end
    else
    begin
      edtNormal2.Text := Format(ratio_is, [FormatFloat('0.0#', eRes) + ':1']);
      d := gbFore.Caption + ': ' + ColortoHex2(FJColor.ActiveColor) + #13#10 + gbBack.Caption + ': ' + ColortoHex2(BColor.ActiveColor) + #13#10#13#10 + Format(ratio_is, [FormatFloat('0.0#', eRes) + ':1']) + #13#10 + d;
    end;

    Memo1.Text := d;// + #13#10#13#10 + lcr_note + #13#10#13#10 + lcr_note2 + #13#10#13#10 + lcr_note3;

    //PROTANOPIA
    FC := ConvertDichromatColors(FJColor.ActiveColor, 0);
    BC := ConvertDichromatColors(BColor.ActiveColor, 0);
    Back := Calc(BC);
    Fore := Calc(FC);
    High := Max(Back, Fore) + 0.05;
    Low := Min(Back, Fore) + 0.05;
    try
        eRes := SimpleRoundTo(High / Low, -1);
    except
        eRes := 0.0;
    end;

    edtProta.Text := Format(ratio_is, [FormatFloat('0.0#', eRes) + ':1']);
    edtProta.Color := BC;
    edtProta.Font.Color := FC;


    //DEUTERANOPIA
    FC := ConvertDichromatColors(FJColor.ActiveColor, 1);
    BC := ConvertDichromatColors(BColor.ActiveColor, 1);
    Back := Calc(BC);
    Fore := Calc(FC);

    High := Max(Back, Fore) + 0.05;
    Low := Min(Back, Fore) + 0.05;
    try
        eRes := SimpleRoundTo(High / Low, -1);
    except
        eRes := 0.0;
    end;

    edtDeutera.Text := Format(ratio_is, [FormatFloat('0.0#', eRes) + ':1']);
    edtDeutera.Color := BC;
    edtDeutera.Font.Color := FC;


    //TRITANOPIA
     FC := ConvertDichromatColors(FJColor.ActiveColor, 2);
    BC := ConvertDichromatColors(BColor.ActiveColor, 2);
    Back := Calc(BC);
    Fore := Calc(FC);

    High := Max(Back, Fore) + 0.05;
    Low := Min(Back, Fore) + 0.05;
    try
        eRes := SimpleRoundTo(High / Low, -1);
    except
        eRes := 0.0;
    end;

    edtTrita.Text := Format(ratio_is, [FormatFloat('0.0#', eRes) + ':1']);
    edtTrita.Color := BC;
    edtTrita.Font.Color := FC;

    iEventCtrl := 0;
    bSetValue := False;

    FR := tbFR.Position;
    FG := tbFG.Position;
    FB := tbFB.Position;
    BR := tbBR.Position;
    BG := tbBG.Position;
    BB := tbBB.Position;

end;

Procedure TMainForm.SetAbsoluteForegroundWindow(HWND: hWnd);
var
    nTargetID, nForegroundID : Integer;
    sp_time: Integer;
begin
    nForegroundID := GetWindowThreadProcessId(GetForegroundWindow, nil);
    nTargetID := GetWindowThreadProcessId(hWnd, nil );
    AttachThreadInput(nTargetID, nForegroundID, TRUE );
    SystemParametersInfo( SPI_GETFOREGROUNDLOCKTIMEOUT,0,@sp_time,0);
    SystemParametersInfo( SPI_SETFOREGROUNDLOCKTIMEOUT,0,Pointer(0),0);
    Application.ProcessMessages;
    SetForegroundWindow(hWnd);
    SystemParametersInfo( SPI_SETFOREGROUNDLOCKTIMEOUT,0,@sp_time,0);
    AttachThreadInput(nTargetID, nForegroundID, FALSE );

end;

function Zeroto100(Num: Integer): integer;
begin
    result := Num;
    if (Num > 100) then result := 100
    else if (Num < 0) then result := 0;
end;

function Zeroto360(Num: Integer): integer;
begin
    result := Num;
    if (Num > 360) then result := 360
    else if (Num < 0) then result := 0;
end;

procedure TMainForm.tbFRChange(Sender: TObject);
var
    R, G, B, tbName: String;
    iDiff, iR, iG, iB: integer;
begin
	if (not bSetValue) then
	begin
		if chkFGSync.Checked then
		begin
			tbFR.OnChange := nil;
			tbFG.OnChange := nil;
			tbFB.OnChange := nil;
			if (Sender is TAccTrackBar) then
			begin
				tbName := (Sender as TAccTrackBar).Name;
				iDiff := 0;
				if tbName = 'tbFR' then
					iDiff := tbFR.Position - FR
				else if tbName = 'tbFG' then
					iDiff := tbFG.Position - FG
				else if tbName = 'tbFB' then
					iDiff := tbFB.Position - FB;
				iR := FR + iDiff;
				iG := FG + iDiff;
				iB := FB + iDiff;

				if iDiff < 0 then
				begin
					if (iR <= -1) or (iG <= -1) or (iB <= -1) then
					begin
						iR := FR;
						iG := FG;
						iB := FB;
					end;
				end
				else if iDiff > 0 then
				begin
					if (iR >= 256) or (iG >= 256) or (iB >= 256) then
					begin
						iR := FR;
						iG := FG;
						iB := FB;
					end;
				end;

				tbFR.Position := Zeroto255(iR);
				tbFG.Position := Zeroto255(iG);
				tbFB.Position := Zeroto255(iB);
			end;
			tbFR.OnChange := tbFRChange;
			tbFG.OnChange := tbFRChange;
			tbFB.OnChange := tbFRChange;
		end;

		R := IntToHex(tbFR.Position, 2);
		G := IntToHex(tbFG.Position, 2);
		B := IntToHex(tbFB.Position, 2);
		if iEventCtrl = 0 then
			iEventCtrl := 3;
		FJColor.ActiveColor := StringToColor('$00' + B + G + R);
	end;
end;

procedure TMainForm.tbBRChange(Sender: TObject);
var
    R, G, B, tbName: String;
    iDiff, iR, iG, iB: integer;
begin
	if (not bSetValue) then
	begin
		if chkBGSync.Checked then
		begin
			tbBR.OnChange := nil;
			tbBG.OnChange := nil;
			tbBB.OnChange := nil;
			if (Sender is TAccTrackBar) then
			begin
				tbName := (Sender as TAccTrackBar).Name;
				iDiff := 0;
				if tbName = 'tbBR' then
					iDiff := tbBR.Position - BR
				else if tbName = 'tbBG' then
					iDiff := tbBG.Position - BG
				else if tbName = 'tbBB' then
					iDiff := tbBB.Position - BB;
				iR := BR + iDiff;
				iG := BG + iDiff;
				iB := BB + iDiff;

				if iDiff < 0 then
				begin
					if (iR <= -1) or (iG <= -1) or (iB <= -1) then
					begin
						iR := BR;
						iG := BG;
						iB := BB;
					end;
				end
				else if iDiff > 0 then
				begin
					if (iR >= 256) or (iG >= 256) or (iB >= 256) then
					begin
						iR := BR;
						iG := BG;
						iB := BB;
					end;
				end;

				tbBR.Position := Zeroto255(iR);
				tbBG.Position := Zeroto255(iG);
				tbBB.Position := Zeroto255(iB);
			end;
			tbBR.OnChange := tbBRChange;
			tbBG.OnChange := tbBRChange;
			tbBB.OnChange := tbBRChange;
		end;

		R := IntToHex(tbBR.Position, 2);
		G := IntToHex(tbBG.Position, 2);
		B := IntToHex(tbBB.Position, 2);
		if iEventCtrl = 0 then
			iEventCtrl := 3;
		BColor.ActiveColor := StringToColor('$00' + B + G + R);
	end;
end;

procedure TMainForm.FHEditChange(Sender: TObject);
begin
  tbFH.Position := Zeroto360(StrtoIntDef(FHEdit.Text, 0));
end;

procedure TMainForm.FSEditChange(Sender: TObject);
begin
  tbFS.Position := Zeroto100(StrtoIntDef(FSEdit.Text, 0));
end;

procedure TMainForm.FVEditChange(Sender: TObject);
begin
  tbFV.Position := Zeroto100(StrtoIntDef(FVEdit.Text, 0));
end;

procedure TMainForm.BHEditChange(Sender: TObject);
begin
  tbBH.Position := Zeroto360(StrtoIntDef(BHEdit.Text, 0));
end;

procedure TMainForm.BSEditChange(Sender: TObject);
begin
  tbBS.Position := Zeroto100(StrtoIntDef(BSEdit.Text, 0));
end;

procedure TMainForm.BVEditChange(Sender: TObject);
begin
  tbBV.Position := Zeroto100(StrtoIntDef(BVEdit.Text, 0));
end;

procedure TMainForm.tbFHChange(Sender: TObject);
var
  dH, dS, dV: extended;
  iR, iG, iB: integer;
  R, G, B: string;
begin
  if (not bSetValue) then
  begin
    dH := tbFH.Position / 360;
    dS := tbFS.Position / 100;
    dV := tbFV.Position / 100;
    HSVtoRGB(dH, dS, dV, iR, iG, iB);


    R := IntToHex(iR, 2);
    G := IntToHex(iG, 2);
    B := IntToHex(iB, 2);
    if iEventCtrl = 0 then iEventCtrl := 5;
    bSetValue := True;
    FJColor.ActiveColor := StringToColor('$00' + B + G + R);
    bSetValue := False;
    CalcColor;
  end;
end;



procedure TMainForm.tbBHChange(Sender: TObject);
var
  dH, dS, dV: extended;
  iR, iG, iB: integer;
  R, G, B: string;
begin
  if (not bSetValue) then
  begin
    dH := tbBH.Position / 360;
    dS := tbBS.Position / 100;
    dV := tbBV.Position / 100;
    HSVtoRGB(dH, dS, dV, iR, iG, iB);


    R := IntToHex(iR, 2);
    G := IntToHex(iG, 2);
    B := IntToHex(iB, 2);

    if iEventCtrl = 0 then iEventCtrl := 5;
    bSetValue := True;
    BColor.ActiveColor := StringToColor('$00' + B + G + R);
    bSetValue := False;
    CalcColor;
  end;

end;

procedure TMainForm.btnCopyResClick(Sender: TObject);
var
    d: string;
    clip: TClipBoard;
begin
    if not mnuShowBlind.Checked then
        d := Memo1.Text
    else
    begin
        d := edtNormal2.EditLabel.Caption + '-' + edtNormal2.Text + #13#10;
        d := d + edtProta.EditLabel.Caption + '-' +  edtProta.Text + #13#10;
        d := d + edtDeutera.EditLabel.Caption + '-' +  edtDeutera.Text + #13#10;
        d := d + edtTrita.EditLabel.Caption + '-' +  edtTrita.Text;

    end;
    clip := TClipBoard.Create;
    try
        clip.Clear;
        clip.SetTextBuf(PChar(d));
        ShowMessage(Copied);
    finally
        clip.Free;
    end;
end;

procedure TMainForm.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Shift = [ssCTRL]) and  (key = Ord('A')) then
    begin
        Memo1.SelectAll;
    end;
end;

procedure TMainForm.edtNormal2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Shift = [ssCTRL]) and  (key = Ord('A')) then
    begin
        edtNormal2.SelectAll;
    end;
end;

procedure TMainForm.edtProtaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Shift = [ssCTRL]) and  (key = Ord('A')) then
    begin
        edtProta.SelectAll;
    end;
end;

procedure TMainForm.edtDeuteraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Shift = [ssCTRL]) and  (key = Ord('A')) then
    begin
        edtDeutera.SelectAll;
    end;
end;

procedure TMainForm.edtTritaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Shift = [ssCTRL]) and  (key = Ord('A')) then
    begin
        edtTrita.SelectAll;
    end;
end;

procedure TMainForm.mnufg1pxClick(Sender: TObject);
begin

    if (Sender is TMenuItem) then
    begin

        if (Sender as TMenuItem) = mnufg2px then
            Dither1 := 2
        else if (Sender as TMenuItem) = mnufg3px then
            Dither1 := 3
        else if (Sender as TMenuItem) = mnufg4px then
            Dither1 := 4
        else if (Sender as TMenuItem) = mnufg5px then
            Dither1 := 5
        else if (Sender as TMenuItem) = mnufg6px then
            Dither1 := 6
        else if (Sender as TMenuItem) = mnufg7px then
            Dither1 := 7
        else if (Sender as TMenuItem) = mnufg8px then
            Dither1 := 8
        else
            Dither1 := 1;
    end;
end;

procedure TMainForm.mnubg1pxClick(Sender: TObject);
begin
    if (Sender is TMenuItem) then
    begin
        if (Sender as TMenuItem) = mnubg2px then
            Dither2 := 2
        else if (Sender as TMenuItem) = mnubg3px then
            Dither2 := 3
        else if (Sender as TMenuItem) = mnubg4px then
            Dither2 := 4
        else if (Sender as TMenuItem) = mnubg5px then
            Dither2 := 5
        else if (Sender as TMenuItem) = mnubg6px then
            Dither2 := 6
        else if (Sender as TMenuItem) = mnubg7px then
            Dither2 := 7
        else if (Sender as TMenuItem) = mnubg8px then
            Dither2 := 8
        else
            Dither2 := 1;
    end;
end;

procedure TMainForm.PopupMenu1Popup(Sender: TObject);
begin
    if Dither1 = 2 then
        mnufg2px.Checked := true
    else if Dither1 = 3 then
        mnufg3px.Checked := true
    else if Dither1 = 4 then
        mnufg4px.Checked := true
    else if Dither1 = 5 then
        mnufg5px.Checked := true
    else if Dither1 = 6 then
        mnufg6px.Checked := true
    else if Dither1 = 7 then
        mnufg7px.Checked := true
    else if Dither1 = 8 then
        mnufg8px.Checked := true
    else
        mnufg1px.Checked := true;
end;

procedure TMainForm.PopupMenu2Popup(Sender: TObject);
begin
    if Dither2 = 2 then
        mnubg2px.Checked := true
    else if Dither2 = 3 then
        mnubg3px.Checked := true
    else if Dither2 = 4 then
        mnubg4px.Checked := true
    else if Dither2 = 5 then
        mnubg5px.Checked := true
    else if Dither2 = 6 then
        mnubg6px.Checked := true
    else if Dither2 = 7 then
        mnubg7px.Checked := true
    else if Dither2 = 8 then
        mnubg8px.Checked := true
    else
        mnubg1px.Checked := true;
end;

// Callback function
function EnumMonitorsProc(hm: HMONITOR; dc: HDC; r: PRect; Data: Pointer): Boolean; stdcall;
begin

  result := true;
end;

procedure TMainForm.mnuSelListClick(Sender: TObject);
begin

    frmSelList := TFrmSelList.Create(self);
    FormStyle := fsNormal;
    try
        frmSelList.Font.Name := Font.Name;
        frmSelList.Font.Size := Font.Size;
        frmSelList.Font.Charset := Font.Charset;
        frmSelList.DefFont := DefFont;
        frmSelList.Dy := DefY;
        frmSelList.Dx := DefX;
        frmSelList.ScaleX := ScaleX;
        frmSelList.ScaleY := ScaleY;
        frmSelList.ResizeCtrls;
        frmSelList.ShowModal;

    finally
        frmSelList.Free;
        mnuOnTopClick(self);
    end;
end;
procedure TMainForm.mnuSelIMGClick(Sender: TObject);
begin
    frmIMGConvert := TfrmIMGConvert.Create(self);
    FormStyle := fsNormal;
    try
      frmIMGConvert.Font := Font;
      frmIMGConvert.DefFont := DefFont;
      frmIMGConvert.Dy := DefY;
      frmIMGConvert.Dx := DefX;
      frmIMGConvert.ScaleX := ScaleX;
      frmIMGConvert.ScaleY := ScaleY;
      frmIMGConvert.ResizeCtrls;
      frmIMGConvert.ShowModal;
    finally
        FreeAndNil(frmIMGConvert);
        mnuOnTopClick(self);
    end;
end;

procedure TMainForm.mnuScreenClick(Sender: TObject);
begin
    Hide;
    Sleep(300);


    ConvWndForm := TConvWndForm.Create(nil);
    try
      ConvWndForm.Font := Font;
      ConvWndForm.Font.Size := DefFont;
      ConvWndForm.DefFont := DefFont;
      ConvWndForm.Dy := DefY;
      ConvWndForm.Dx := DefX;
      ConvWndForm.ScaleX := ScaleX;
      ConvWndForm.ScaleY := ScaleY;
      ConvWndForm.ftime := False;

      ConvWndForm.Execute(1);
      ConvWndForm.ShowModal;
    finally
      Show;
      ConvWndForm.Free;
    end;

end;

procedure TMainForm.GetSS;
var
	SC_hdc: HDC;
  i: Integer;
  pt: TPoint;
  monEx: TMonitorInfoEx;
begin
	for i := Low(arSS_HDC) to High(arSS_HDC) do
  	DeleteDC(arSS_HDC[i]);

  monEx.cbSize := SizeOf(monEx);

	SetLength(arSS_HDC, 0);
	SetLength(arSS_HDC, Screen.MonitorCount);
	for i := Low(arSS_HDC) to High(arSS_HDC) do
	begin

		GetMonitorInfo(Screen.Monitors[i].Handle, @monEx);

		SC_hdc := CreateDC('DISPLAY', monEx.szDevice, nil, nil);
		arSS_HDC[i] := CreateCompatibleDC(SC_hdc);
		SS_bmp := CreateCompatibleBitmap(SC_hdc, monEx.rcMonitor.Width,
			monEx.rcMonitor.Height);
		SelectObject(arSS_HDC[i], SS_bmp);

		try
			BitBlt(arSS_HDC[i], 0, 0, monEx.rcMonitor.Width, monEx.rcMonitor.Height,
				SC_hdc, 0, 0, SRCCOPY);
		finally
			DeleteObject(SS_bmp);
			DeleteDC(SC_hdc);
		end;
	end;
end;

procedure TMainForm.btnForeClick(Sender: TObject);
var
    SC_hdc: HDC;
    i: Integer;
    pt: TPoint;
    monEx: TMonitorInfoEx;
begin
    if (Sender is TButton) then
    begin
        if (Sender as TButton) = sbtnFore then
            SelFore := True
        else
            SelFore := False;

        GetSS;


        PickForm.ScaleX := ScaleX;
        PickForm.ScaleY := ScaleY;

        GetCursorPos(pt);
        MoveWindow(PickForm.Handle, pt.x - (DoubleToInt(200 * ScaleX) div 2 + 1), pt.y - (DoubleToInt(200 * ScaleY) div 2 + 1), DoubleToInt(200 * ScaleX) + 2, DoubleToInt(200 * Scaley) + 2, TRUE);
        ShowCursor(False);
        PickForm.Show;

    end;
end;

procedure TMainForm.mnuShowBlindClick(Sender: TObject);
begin
    mnuShowBlind.Checked := not mnuShowBlind.Checked;
    chkBlind.Checked := mnuShowBlind.Checked;
    gbResBlind.Visible := mnuShowBlind.Checked;
    Memo1.Visible := not mnuShowBlind.Checked;

end;

procedure TMainForm.chkblindClick(Sender: TObject);
begin
    mnuShowBlind.Checked := chkblind.Checked;
    gbResBlind.Visible := chkblind.Checked;
    Memo1.Visible := not chkblind.Checked;
end;

procedure TMainForm.chkExpandEnter(Sender: TObject);
begin
    try
    if (Sender is TWinControl) then
        StatusBar1.SimpleText := GetLongHint((Sender as TWinControl).Hint);
    except
    end;
end;

procedure TMainForm.mnuRGBSliderClick(Sender: TObject);
begin
  mnuRGBSlider.Checked := not mnuRGBSlider.Checked;
  ResizeCtrls;
end;


procedure TMainForm.mnuHSVSliderClick(Sender: TObject);
begin
  mnuHSVSlider.Checked := not mnuHSVSlider.Checked;
  ResizeCtrls;
end;

procedure TMainForm.rb_least3Click(Sender: TObject);
begin
    CalcColor;
end;

procedure TMainForm.rb_least3Enter(Sender: TObject);
begin
    try
    if (Sender is TWinControl) then
        StatusBar1.SimpleText := GetLongHint((Sender as TControl).Hint);
    except
    end;
end;


procedure  TMainForm.WMDPIChanged(var Message: TMessage);
begin
  scaleX := Message.WParamLo / DefX;
  scaleY := Message.WParamHi / DefY;
  if (not bFirstTime) and (cDPI <> Message.WParamLo) then
  begin
		self.ChangeScale(Message.WParamLo, cDPI);
  	cDPI := Message.WParamLo;
  	SetThumbHeight;
  end;
end;

end.
