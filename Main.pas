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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Vcl.Forms, Math,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ColorConvert,
  ImgList, Buttons, IniFiles, ActnList, JColorSelect2, ShellAPI, Menus, MultiMon,
  Mask, JPEG, FormIMGConvert, ToolWin, Clipbrd, ShlObj, ComObj, System.Actions, TransCheckBox, PermonitorApi, Funcs;
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
    gbBack: TAccGroupBox;
    gbResNormal: TAccGroupBox;
    ImageList1: TImageList;
    gbResBlind: TAccGroupBox;
    edtProta: TAccLabeledEdit;
    edtDeutera: TAccLabeledEdit;
    edtTrita: TAccLabeledEdit;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    FontDialog1: TFontDialog;
    edtNormal2: TAccLabeledEdit;
    Image5: TImage;
    ActionList1: TActionList;
    acrFColorDrop: TAction;
    actBColorDrop: TAction;
    actFColorPick: TAction;
    actBColorPick: TAction;
    FJColor: TJColorSelect2;
    BColor: TJColorSelect2;
    MainMenu1: TMainMenu;
    mnuOptions: TMenuItem;
    mnuOnTop: TMenuItem;
    mnuFont: TMenuItem;
    mnuHelp: TMenuItem;
    mnuHelp1: TMenuItem;
    mnuAbout: TMenuItem;
    mnuHex: TMenuItem;
    Edit1: TAccMaskEdit;
    Edit2: TAccMaskEdit;
    mnuIMG: TMenuItem;
    mnuSelList: TMenuItem;
    SaveDialog1: TSaveDialog;
    mnuRGB: TMenuItem;
    mnuP_Value: TMenuItem;
    mnuSelIMG: TMenuItem;
    mnuScreen: TMenuItem;
    Panel1: TPanel;
    FREdit: TAccEdit;
    FGEdit: TAccEdit;
    FBEdit: TAccEdit;
    Panel2: TPanel;
    BREdit: TAccEdit;
    BGEdit: TAccEdit;
    BBEdit: TAccEdit;
    tbFR: TAccTrackBar;
    tbFG: TAccTrackBar;
    tbFB: TAccTrackBar;
    tbBR: TAccTrackBar;
    tbBG: TAccTrackBar;
    tbBB: TAccTrackBar;
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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnFore: TAccBitBtn;
    btnBack: TAccBitBtn;
    bbDD1: TAccBitBtn;
    bbDD2: TAccBitBtn;
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
    chkExpand: TTransCheckBox;
    chkExpand2: TTransCheckBox;
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
    lblFR: TLabel;
    lblFB: TLabel;
    lblFG: TLabel;
    lblBR: TLabel;
    lblBG: TLabel;
    lblBB: TLabel;
    gbTextFor: TAccGroupBox;
    rb_least3: TAccRadioButton;
    rb_least5: TAccRadioButton;
    rb_least7: TAccRadioButton;
    lblRatio: TLabel;
    chkblind: TTransCheckBox;
    mnuLang: TMenuItem;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure mnuHexClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FJColorChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    procedure chkExpandClick(Sender: TObject);
    procedure bbFGSCClick(Sender: TObject);
    procedure bbBGSCClick(Sender: TObject);
    procedure bbRNSCClick(Sender: TObject);
    procedure bbRBSCClick(Sender: TObject);
    procedure actExpandAllExecute(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure btnForeClick(Sender: TObject);
    procedure bbDD2Click(Sender: TObject);
    procedure bbDD1Click(Sender: TObject);
    procedure mnuShowBlindClick(Sender: TObject);
    procedure chkExpandEnter(Sender: TObject);
    procedure mnuSliderClick(Sender: TObject);
    procedure rb_least3Click(Sender: TObject);
    procedure rb_least3Enter(Sender: TObject);
    procedure chkblindClick(Sender: TObject);
    procedure mnuHelpMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure mnuHelpDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
  private
    { Private declare }
    Hex, RGB, copied: string;
    frmSelIMG: TfrmIMGConvert;
    bSetValue: Boolean;
    Transpath, APPDir, SPath, TransDir: string;
    LangList: TStringList;
    DefFont: integer;
    ScaleX, ScaleY, DefX, DefY: double;
    procedure SetRGB;
    procedure OnSHint(Sender: TObject);
    procedure SetTBPos;
    procedure FGGroupSizeChange(Large: boolean = True);
    procedure BGGroupSizeChange(Large: boolean = True);
    procedure ResGroupSizeChange(Large: boolean = True);
    procedure ResizeCtrls;
    procedure LoadLang(mnuCreate: boolean = true);
    procedure mnuLangChildClick(Sender: TObject);
    procedure ItemMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure ItemDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure WMDPIChanged(var Message: TMessage); message WM_DPICHANGED;
  public
    { Public declare }
    arSS_HDC: array of HDC;
    SS_bmp: HBITMAP;
    SelFore: Boolean;
    Dither1, Dither2: byte;
    function CalcColor: Extended;
    Procedure SetAbsoluteForegroundWindow(HWND: hWnd);
    function GetTranslation(Key, Default: string): string;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSyscommand(var Message: TWmSysCommand); message WM_SYSCOMMAND;
  end;

var
  MainForm: TMainForm;
implementation

uses Pick, about, SelListForm, ProgressForm, ConvWnd;

var
  SS_HDC: HDC;

{$R *.dfm}

function DoubleToInt(d: double): integer;
begin
  SetRoundMode(rmUP);
  Result := Trunc(SimpleRoundTo(d));
end;

function GetMyDocPath: string;
var
  IIDList: PItemIDList;
  buffer: array [0..MAX_PATH - 1] of char;
begin
  IIDList := nil;

  OleCheck(SHGetSpecialFolderLocation(Application.Handle,
    CSIDL_PERSONAL, IIDList));
  if not SHGetPathFromIDList(IIDList, buffer) then
  begin
    raise Exception.Create('The folder path cannot be acquired, because the folder is a virtual folder.');
  end;
  Result := StrPas(Buffer);
end;

procedure TMainForm.chkExpandClick(Sender: TObject);
begin
    ResGroupSizeChange(ChkExpand.Checked);
    chkExpand2.Checked := True;
end;

procedure TMainForm.ResizeCtrls;
var
  iHeight, sWidth, sHeight, iLeft, tw, mH, iTop, i: integer;
  sz: TSize;
  dc: HDC;
    procedure GetStrSize(Cap: string);
    begin

      sWidth := DoubleToInt(Canvas.TextWidth(Cap));
      sHeight := DoubleToInt(Canvas.TextHeight(Cap));

    end;
begin
  Font.Size := DoubleToInt(DefFont * ScaleY);
  iHeight := DoubleToInt(25 * ScaleX);
  mH := iHeight;

    GetStrSize(Label1.Caption);
    Label1.Width := sWidth;
    Label1.Height := sHeight;
    Label2.Width := sWidth;
    Label2.Height := sHeight;
    tw := Label1.Width + 8;
    mh := MAX(mH, Label1.Height);

    FJColor.ItemHeight := iHeight - 5;
    FJColor.Width := DoubleToInt(70 * ScaleX);
    BColor.ItemHeight := iHeight - 5;
    BColor.Width := DoubleToInt(70 * ScaleX);
    mh := MAX(mH, FJColor.Height);
    tw := tw + FJColor.Width + 3;
    if mnuHex.Checked then
    begin

      GetStrSize(Label3.Caption + ' ');
      Label3.Width := sWidth;
      Label3.Height := sHeight;
      Label4.Width := sWidth;
      Label4.Height := sHeight;
      tw := tw + Label3.Width + 5;

      GetStrSize('255 255 255');

      Edit1.Height := sHeight + 6;
      Edit1.Width := sWidth + 30;
      Edit2.Height := sHeight + 6;
      Edit2.Width := sWidth + 30;
      mh := MAX(mH, Edit1.Height);
      tw := tw + Edit1.Width + 3;


    end
    else if mnuRGB.Checked then
    begin

      GetStrSize(Label3.Caption + ' ');
      Label3.Width := sWidth;
      Label3.Height := sHeight;
      Label4.Width := sWidth;
      Label4.Height := sHeight;
      GetStrSize('255 255 255');
      tw := tw + Label3.Width + 5;

      Panel1.Height := sHeight;
      Panel1.Width := sWidth + 30;
      Panel2.Height := sHeight;
      Panel2.Width := sWidth + 30;
      mh := MAX(mH, Panel1.Height);

      sWidth := (sWidth + 30) div 3;
      FREdit.Height := sHeight + 4;
      FREdit.Width := sWidth;

      FGEdit.Height := sHeight + 4;
      FGEdit.Width := sWidth;

      FBEdit.Height := sHeight + 4;
      FBEdit.Width := sWidth;

      BREdit.Height := sHeight + 4;
      BREdit.Width := sWidth;

      BGEdit.Height := sHeight + 4;
      BGEdit.Width := sWidth;

      BBEdit.Height := sHeight + 4;
      BBEdit.Width := sWidth;

      tw := tw + Panel1.Width + 5;
    end;

    GetStrSize(lblFR.Caption + ' ');
    lblFR.Width := sWidth;
    lblFR.Height := sHeight + 6;
    lblBR.Width := sWidth;
    lblBR.Height := sHeight + 6;


    GetStrSize(lblFG.Caption + ' ');
    lblFG.Width := sWidth;
    lblFG.Height := sHeight + 6;
    lblBG.Width := sWidth;
    lblBG.Height := sHeight + 6;

    GetStrSize(lblFB.Caption + ' ');
    lblFB.Width := sWidth;
    lblFB.Height := sHeight + 6;
    lblBB.Width := sWidth;
    lblBB.Height := sHeight + 6;

    tbFR.Height := iHeight;
    tbFG.Height := iHeight;
    tbFB.Height := iHeight;
    tbBR.Height := iHeight;
    tbBG.Height := iHeight;
    tbBB.Height := iHeight;

    iTop := (mH + 25) div 2;


    btnFore.Width := iHeight;
    btnFore.Height := iHeight;
    bbDD1.Height := iHeight;

    btnBack.Width := iHeight;
    btnBack.Height := iHeight;
    bbDD2.Height := iHeight;
    tw := tw + btnFore.Width + bbDD1.Width + 1;

    if mnuSlider.Checked then
    begin
      gbFore.Height := mH + (sHeight * 3 ) + 45;// + DoubleToInt(5 * ScaleY);
      gbBack.Height := mH + (sHeight * 3 ) + 45;// + DoubleToInt(5 * ScaleY);
    end
    else
    begin
      gbFore.Height :=mH + 15 + DoubleToInt(10 * ScaleY);
      gbBack.Height :=mH + 15 + DoubleToInt(10 * ScaleY);
    end;
    gbFore.Width := tw + 10;
    gbBack.Width := tw + 10;


    ClientWidth := gbFore.Width + 15;


    Label1.Top := iTop - (Label1.Height div 4);
    Label1.Left := 8;

    Label2.Top := iTop - (Label2.Height div 4);
    Label2.Left := 8;

    FJColor.Top := iTop - (FJColor.Height div 4);
    FJColor.Left := Label1.Left + Label1.Width + 3;

    BColor.Top := iTop - (BColor.Height div 4);
    BColor.Left := Label2.Left + Label2.Width + 3;
    iLeft := 0;
    if mnuHex.Checked then
    begin
      Label3.Left := FJColor.Left + FJColor.Width + 5;
      Label3.Top := iTop - (Label3.Height div 4);

      Label4.Left := BColor.Left + BColor.Width + 5;
      Label4.Top := iTop - (Label4.Height div 4);

      Edit1.Left := Label3.Left + Label3.Width + 3;
      Edit1.Top :=  iTop - (Edit1.Height div 4);

      Edit2.Left := Label4.Left + Label4.Width + 3;
      Edit2.Top :=  iTop - (Edit2.Height div 4);

      iLeft := Edit1.Left + Edit1.Width + 5;
    end
    else if mnuRGB.Checked then
    begin
      Label3.Left := FJColor.Left + FJColor.Width + 5;
      Label3.Top := iTop - (Label3.Height div 4);

      Label4.Left := BColor.Left + BColor.Width + 5;
      Label4.Top := iTop - (Label4.Height div 4);

      Panel1.Left := Label3.Left + Label3.Width + 3;
      Panel1.Top :=  iTop - (panel1.Height div 4);

      Panel2.Left := Label3.Left + Label3.Width + 3;
      Panel2.Top :=  iTop - (panel2.Height div 4);

      FREdit.Top := 0;
      FREdit.Left := 0;

      FGEdit.Top := 0;
      FGEdit.Left := FREdit.Left + FREdit.Width;

      FBEdit.Top := 0;
      FBEdit.Left := FGEdit.Left + FGEdit.Width;

      BREdit.Top := 0;
      BREdit.Left := 0;

      BGEdit.Top := 0;
      BGEdit.Left := BREdit.Left + BREdit.Width;

      BBEdit.Top := 0;
      BBEdit.Left := BGEdit.Left + BGEdit.Width;

      iLeft := Panel1.Left + Panel1.Width + 5;
    end;
    btnFore.Left := iLEft;
    btnFore.Top := iTop - (btnFore.Height div 4);
    bbDD1.Top := iTop - (bbDD1.Height div 4);
    bbDD1.Left := btnFore.Left + btnFore.Width + 1;

    btnBack.Left := iLEft;
    btnBack.Top := iTop - (btnBack.Height div 4);
    bbDD2.Top := iTop - (bbDD2.Height div 4);
    bbDD2.Left := btnBack.Left + btnBack.Width + 1;

    lblFR.Left := 8;
    lblFG.Left := 8;
    lblFB.Left := 8;
    lblFR.Top := mh + 25;
    lblFG.Top := lblFR.Top + lblFR.Height;
    lblFB.Top := lblFG.Top + lblFG.Height;

    lblBR.Left := 8;
    lblBG.Left := 8;
    lblBB.Left := 8;
    lblBR.Top := mh + 25;
    lblBG.Top := lblBR.Top + lblBR.Height;
    lblBB.Top := lblBG.Top + lblBG.Height;

    mh := lblFR.Width;
    mh := MAX(mh, lblFG.Width);
    mh := MAX(mh, lblFB.Width);
    tbFR.Left := mh + 5;
    tbFR.Top := lblFR.Top + 5;
    tbFG.Left := mh + 5;
    tbFG.Top := lblFG.Top + 5;
    tbFB.Left := mh + 5;
    tbFB.Top := lblFB.Top + 5;
    tbFR.Width := gbFore.Width -mh - 5;
    tbFG.Width := tbFR.Width;
    tbFB.Width := tbFR.Width;

    tbBR.Left := mh + 5;
    tbBR.Top := lblBR.Top + 5;
    tbBG.Left := mh + 5;
    tbBG.Top := lblBG.Top + 5;
    tbBB.Left := mh + 5;
    tbBB.Top := lblBB.Top + 5;
    tbBR.Width := gbBack.Width -mh - 5;
    tbBG.Width := tbBR.Width;
    tbBB.Width := tbBR.Width;

    gbBack.Top := gbFore.Top + gbFore.Height + 7;

    GetStrSize(chkBlind.Caption + ' ');
    chkBlind.Top := gbBack.Top + gbBack.Height + 10;
    chkBlind.Height := sHeight;
    chkBlind.Width := ClientWidth;



    gbResBlind.Top := chkBlind.Top + chkBlind.Height + 5;
    gbResNormal.Top := gbResBlind.Top;

    GetStrSize(lblRatio.Caption + ' ');

    lblRatio.Height := sHeight + 5;
    lblRatio.Width := (gbResNormal.Width div 2) - 8;

    GetStrSize(chkExpand.Caption + ' ');

    chkExpand.Height := sHeight + 5;
    chkExpand.Width := (gbResNormal.Width div 2) - 10;



    gbText.Width := (gbResNormal.Width div 2) - 8;



    gbLText.Width := (gbResNormal.Width div 2) - 10;




    with edtNormal_T do
    begin
        Font.Size :=  DoubleToInt(DefFont * ScaleY);
    end;
    with edtNormal_T2 do
    begin
        Font.Size :=  DoubleToInt(DefFont * ScaleY);
    end;
    with edtNormal_LT do
    begin
        Font.Size :=  DoubleToInt((DefFont + 5) * ScaleY);
        Font.Style := [fsBold];
    end;
    with edtNormal_LT2 do
    begin
        Font.Size :=  DoubleToInt((DefFont + 5) * ScaleY);
        Font.Style := [fsBold];
    end;


    Font.Size :=  DoubleToInt((DefFont + 5) * ScaleY);
    Font.Style := [fsBold];
    GetStrSize(edtNormal_Lt2.Text + ' ');
    Font.Size :=  DoubleToInt(DefFont * ScaleY);
    Font.Style := [];
    //caption := inttostr(sHeight);
    if sHeight < 15 then
      sHeight := 15;
    edtNormal_t.Height :=  sHeight + 5;


    edtNormal_t2.Height :=  sHeight + 5;


    edtNormal_Lt.Height :=  sHeight + 5;


    edtNormal_Lt2.Height :=  sHeight + 5;




    if edtNormal_T.Height >= DoubleToInt(20 * ScaleY) then
    begin

      Image1.Height := DoubleToInt(20 * ScaleY);
      Image1.Width := DoubleToInt(20 * ScaleX);
      Image7.Height := DoubleToInt(20 * ScaleY);
      Image7.Width := DoubleToInt(20 * ScaleX);
    end
    else
    begin
      Image1.Height := edtNormal_T.Height;
      Image1.Width := edtNormal_T.Height;
      Image7.Height := edtNormal_T.Height;
      Image7.Width := edtNormal_T.Height;
    end;
    if edtNormal_LT.Height >= DoubleToInt(20 * ScaleY) then
    begin

      Image8.Height := DoubleToInt(20 * ScaleY);
      Image8.Width := DoubleToInt(20 * ScaleX);
      Image9.Height := DoubleToInt(20 * ScaleY);
      Image9.Width := DoubleToInt(20 * ScaleX);
    end
    else
    begin
      Image8.Height := edtNormal_LT.Height;
      Image8.Width := edtNormal_LT.Height;
      Image9.Height := edtNormal_LT.Height;
      Image9.Width := edtNormal_LT.Height;
    end;

    with edtNormal_T do
    begin
        Width := gbText.Width - Image1.Width - 18;
    end;
    with edtNormal_T2 do
    begin
        Width := gbText.Width - Image7.Width - 18;
    end;
    with edtNormal_LT do
    begin
        Width := gbLText.Width - Image8.Width - 18;
    end;
    with edtNormal_LT2 do
    begin
        Width := gbLText.Width - Image9.Width - 18;
    end;

    //GetStrSize(gbText.Caption + ' ');
    gbText.Height := sHeight + edtNormal_T.Height + edtNormal_T2.Height;
    gbLText.Height := sHeight + edtNormal_LT.Height + edtNormal_LT2.Height;


    GetStrSize(btnCopyRes.Caption + ' ');
    btnCopyRes.Height := sHeight + 10;
    btnCopyRes.Width := sWidth + 10;

    Memo1.Width := gbResNormal.Width - 15;
    Memo1.Height := sHeight * 10;

    //edtNormal2.Font := Font;
    edtNormal2.Font.Size :=  DoubleToInt(DefFont * ScaleY);
    //edtProta.Font := Font;
    edtProta.Font.Size :=  DoubleToInt(DefFont * ScaleY);
    //edtDeutera.Font := Font;
    edtDeutera.Font.Size :=  DoubleToInt(DefFont * ScaleY);
    //edtTrita.Font := Font;
    edtTrita.Font.Size :=  DoubleToInt(DefFont * ScaleY);

    GetStrSize(edtNormal2.Text + ' ');

    edtNormal2.Height := sHeight + 5;
    edtNormal2.Width := gbResBlind.Width - (edtNormal2.Left * 2);
    edtProta.Height := sHeight + 5;
    edtProta.Width := gbResBlind.Width - (edtProta.Left * 2);
    edtDeutera.Height := sHeight + 5;
    edtDeutera.Width := gbResBlind.Width - (edtDeutera.Left * 2);
    edtTrita.Height := sHeight + 5;
    edtTrita.Width := gbResBlind.Width - (edtTrita.Left * 2);

    gbResBlind.Height := (edtNormal2.Height * 4) + (edtNormal2.EditLabel.Height * 4) + sHeight + 25;

    if not chkExpand.Checked then
    begin
      gbResNormal.Height := lblRatio.Height + gbLText.Height{ + Memo1.Height + btnCopyRes.Height} + 25;
    end
    else
    begin
      gbResNormal.Height := lblRatio.Height + gbText.Height + Memo1.Height + btnCopyRes.Height + 35;
    end;
    if not mnuShowBlind.Checked then
    begin
        ClientHeight := gbResNormal.Top + gbResNormal.Height + StatusBar1.height + 5;
    end
    else
    begin
        ClientHeight := gbResBlind.Top + gbResBlind.Height + StatusBar1.height;
    end;
    GetStrSize(gbResNormal.Caption + ' ');
    lblRatio.Top :=  sHeight;
    lblRatio.Left := 8;
    chkExpand.Top := sHeight - 3;
    chkExpand.Left := (gbResNormal.Width div 2) + 5;
    gbText.Top := chkExpand.Top + chkExpand.Height;
    gbText.Left := 8;
    gbLText.Top := chkExpand.Top + chkExpand.Height;
    gbLText.Left := (gbResNormal.Width div 2) + 5;

    //GetStrSize(gbText.Caption + ' ');

    edtNormal_T.Left := Image1.Left + Image1.Width + 4;
    edtNormal_T.Top := sHeight;

    edtNormal_T2.Left := Image7.Left + Image7.Width + 4;
    edtNormal_T2.Top := edtNormal_T.Top + edtNormal_T.Height;

    edtNormal_LT.Left := Image8.Left + Image8.Width + 4;
    edtNormal_LT.Top := sHeight;

    edtNormal_LT2.Left := Image9.Left + Image9.Width + 4;
    edtNormal_LT2.Top := edtNormal_LT.Top + edtNormal_LT.Height;

    Image1.Top := edtNormal_T.Top + ((edtNormal_T.Height - Image1.Height) div 4);
    Image7.Top := edtNormal_T2.Top + ((edtNormal_T2.Height - Image7.Height) div 4);
    Image8.Top := edtNormal_LT.Top + ((edtNormal_LT.Height - Image8.Height) div 4);
    Image9.Top := edtNormal_LT2.Top + ((edtNormal_LT2.Height - Image9.Height) div 4);

    Memo1.Top := gbText.Top + gbText.Height + 7;

    btnCopyRes.Top := Memo1.Top + Memo1.Height + 5;
    btnCopyRes.Left := gbResNormal.Width - btnCopyRes.Width -5;

    GetStrSize(gbResBlind.Caption + ' ');
    edtNormal2.Top := sHeight + edtNormal2.EditLabel.Height;
    edtProta.Top := edtNormal2.Top + edtNormal2.Height + edtNormal2.EditLabel.Height + 5;
    edtDeutera.Top := edtProta.Top + edtProta.Height + edtProta.EditLabel.Height + 5;
    edtTrita.Top := edtDeutera.Top + edtDeutera.Height + edtDeutera.EditLabel.Height + 5;
     //caption := floattostr(scaley);
    //ClientHeight := DoubleToInt(ClientHeight * ScaleY);

end;

procedure TMainForm.ResGroupSizeChange(Large: boolean = True);
begin
    Memo1.Visible := Large;
    btnCopyRes.Visible := Large;
    {if Large then
    begin

        gbResBlind.Height := DoubleToInt((edtTrita.Top + edtTrita.Height + 8) * ScaleY);
        gbResNormal.Height := DoubleToInt((btnCopyRes.Top + btnCopyRes.Height + 8) * ScaleY);
    end
    else
    begin
        gbResBlind.Height := DoubleToInt((edtTrita.Top + edtTrita.Height + 8) * ScaleY);
        gbResNormal.Height := DoubleToInt((gbText.Top + gbText.Height + 8) * ScaleY);
    end;       }
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
    lblFR.Visible := Large;
    lblFG.Visible := Large;
    lblFB.Visible := Large;
    tbFR.Visible := Large;
    tbFG.Visible := Large;
    tbFB.Visible := Large;
    if Large then
    begin
        gbFore.Height := tbFB.Top + tbFB.Height + 8;
    end
    else
    begin
        gbFore.Height := FJColor.Top + FJColor.Height + 5;
    end;
    ResizeCtrls;
end;

procedure TMainForm.bbFGSCClick(Sender: TObject);
begin
    FGGroupSizeChange(not lblFR.Visible);

end;

procedure TMainForm.BGGroupSizeChange(Large: boolean = True);
begin
    lblBR.Visible := Large;
    lblBG.Visible := Large;
    lblBB.Visible := Large;
    tbBR.Visible := Large;
    tbBG.Visible := Large;
    tbBB.Visible := Large;
    if Large then
    begin
        gbBack.Height := tbBB.Top + tbBB.Height + 8;
    end
    else
    begin
        gbBack.Height := BColor.Top + BColor.Height + 5;
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
begin
    bSetValue := True;
    RGBColor := ColorToRGB(FJColor.ActiveColor);
    tbFR.Position := ($000000FF and RGBColor);
    tbFG.Position := ($0000FF00 and RGBColor) shr 8;
    tbFB.Position := ($00FF0000 and RGBColor) shr 16;

    RGBColor := ColorToRGB(BColor.ActiveColor);
    tbBR.Position := ($000000FF and RGBColor);
    tbBG.Position := ($0000FF00 and RGBColor) shr 8;
    tbBB.Position := ($00FF0000 and RGBColor) shr 16;

end;

procedure TMainForm.SetRGB;
var
    RGBColor: LongInt;
begin
    bSetValue := True;
    RGBColor := ColorToRGB(FJColor.ActiveColor);
    FBEdit.Text := InttoStr(($00FF0000 and RGBColor) shr 16);
    FGEdit.Text := InttoStr(($0000FF00 and RGBColor) shr 8);
    FREdit.Text := InttoStr(($000000FF and RGBColor));


    RGBColor := ColorToRGB(BColor.ActiveColor);
    BBEdit.Text := InttoStr(($00FF0000 and RGBColor) shr 16);
    BGEdit.Text := InttoStr(($0000FF00 and RGBColor) shr 8);
    BREdit.Text := InttoStr(($000000FF and RGBColor));

end;



procedure TMainForm.FJColorChanged(Sender: TObject);
begin
    if not PickForm.Showing then
    begin
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
            ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
            try
                Ini.WriteString('Settings', 'FontName', Font.Name);
                ini.WriteInteger('Settings', 'FontSize', Font.Size);
                Ini.WriteInteger('Settings', 'Charset', Font.Charset);
                Ini.WriteString('Settings', 'LangFile', lf);
                ini.UpdateFile;
            finally
                ini.Free;
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
        ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
        try
            if mnuLang.Visible then
            begin
                d := Ini.ReadString('Settings', 'LangFile', 'Default.ini');
                TransPath := TransDir + d;
            end;
        finally
            ini.Free;

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
        btnFore.Hint := ini.ReadString('Translations', 'pick_forebtn', 'F11|F11 is pick foreground colour.');
        btnBack.Hint := ini.ReadString('Translations', 'pick_backbtn', 'F12|F12 is pick background colour.');
        FJColor.Hint := ini.ReadString('Translations', 'fore_dropdown', 'F9|The dropdown is the F9 key. Afterwards, please select the colour.');
        BColor.Hint := ini.ReadString('Translations', 'back_dropdown', 'F10|The dropdown is the F10 key. Afterwards, please select the colour.');
        Edit1.Hint := ini.ReadString('Translations', 'fore_edit', '|The picked colour is displayed. And, the value can be input.');
        Edit2.Hint := ini.ReadString('Translations', 'back_edit', '|The picked colour is displayed. And, the value can be input.');
        btnCopyRes.Hint := ini.ReadString('Translations', 'Copy_hint', '|The text of the result is copied to the clipboard.');
        edtProta.EditLabel.Caption := ini.ReadString('Translations', 'protanopia', 'Protanopia');
        //edtNormal.EditLabel.Caption := ini.ReadString('Translations', 'normal', 'Normal');
        //edtNormal3.EditLabel.Caption := edtNormal.EditLabel.Caption;
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
        chkExpand.Caption := ini.ReadString('Translations', 'chkExpand_Collapse', 'Short / Full');
        chkExpand.Hint := ini.ReadString('Translations', 'chkExpand_Collapse_Hint', '');
        chkExpand2.Caption := ini.ReadString('Translations', 'chkExpand_Collapse', 'Short / Full');
        chkExpand2.Hint := ini.ReadString('Translations', 'chkExpand_Collapse_Hint', '');
        bbDD1.Hint := ini.ReadString('Translations', 'Dropdown1_Hint', 'pixel range');
        bbDD2.Hint := ini.ReadString('Translations', 'Dropdown2_Hint', 'pixel range');

        mnuSlider.Caption := ini.ReadString('Translations', 'Show_Sliders', 'Show color sliders');


        gbTextFor.Caption := ini.ReadString('Translations', 'Text_for', 'Text for');
        rb_least3.Caption := ini.ReadString('Translations', 'at_least_3', 'Large text AA (at least 3:1)');
        rb_least5.Caption := ini.ReadString('Translations', 'at_least_5', 'Text AA and Large text AAA (at least 5:1)');
        rb_least7.Caption := ini.ReadString('Translations', 'at_least_7', 'Text AAA (at least 7:1)');
        rb_least3.Hint := ini.ReadString('Translations', 'at_least_3_hint', '');
        rb_least5.Hint := ini.ReadString('Translations', 'at_least_5_hint', '');
        rb_least7.Hint := ini.ReadString('Translations', 'at_least_7_hint', '');
    finally
        ini.Free;
    end;
    CalcColor;
    ResizeCtrls;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
    i: Integer;
    ini: TMemIniFile;
    Rec     : TSearchRec;
    dc: HDC;
    monEx: TMonitorInfoEx;
    hm: HMonitor;
begin
    SystemCanSupportPerMonitorDpi(true);
    GetDCap(handle, Defx, Defy);
    GetWindowScale(Handle, DefX, DefY, ScaleX, ScaleY);

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
    i := GetWindowLong(edtNormal_T.Handle, GWL_STYLE);
    i := i or ES_CENTER;
    SetWindowLong(edtNormal_T.Handle, GWL_STYLE, i);
    SetWindowLong(edtNormal_T2.Handle, GWL_STYLE, i);
    SetWindowLong(edtNormal_LT.Handle, GWL_STYLE, i);
    SetWindowLong(edtNormal_LT2.Handle, GWL_STYLE, i);
    SetWindowLong(edtNormal2.Handle, GWL_STYLE, i);
    SetWindowLong(edtDeutera.Handle, GWL_STYLE, i);
    SetWindowLong(edtProta.Handle, GWL_STYLE, i);
    SetWindowLong(edtTrita.Handle, GWL_STYLE, i);
    Application.OnHint := OnSHint;
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        Font.Charset := ini.ReadInteger('Font', 'Charset', 0);
        Font.Name := ini.ReadString('Font', 'Name', 'Arial');
        Font.Size := ini.ReadInteger('Font', 'Size', 9);
        DefFont := Font.Size;
        FJColor.Font := Font;
        BColor.Font := Font;
        Left := ini.ReadInteger('Window', 'Left', (Screen.WorkAreaWidth div 2) - (Width div 2));
        Top := ini.ReadInteger('Window', 'Top', (Screen.WorkAreaHeight div 2) - (Height div 2));
        mnuOnTop.Checked := ini.ReadBool('Options', 'Stayontop', False);
        if ini.ReadBool('Options', 'HexValue', True) then
        begin
            mnuHex.Checked := False;
            mnuRGB.Checked := True;
        end
        else
        begin
            mnuRGB.Checked := False;
            mnuHex.Checked := True;
        end;


        mnuOnTopClick(self);
    finally
        ini.Free;
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
    edtNormal2.Font.Style := [fsBold];
    edtDeutera.Font.Style := [fsBold];
    edtProta.Font.Style := [fsBold];
    edtTrita.Font.Style := [fsBold];
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
    //Num only
    SetWindowLong(FREdit.Handle, GWL_STYLE,
                GetWindowLong(FREdit.Handle, GWL_STYLE)
                or ES_RIGHT
                or ES_NUMBER);
    SetWindowPos(FREdit.Handle, 0, 0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or
               SWP_NOZORDER or SWP_FRAMECHANGED);
    SetWindowLong(FGEdit.Handle, GWL_STYLE,
                GetWindowLong(FGEdit.Handle, GWL_STYLE)
                or ES_RIGHT
                or ES_NUMBER);
    SetWindowPos(FGEdit.Handle, 0, 0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or
               SWP_NOZORDER or SWP_FRAMECHANGED);
    SetWindowLong(FBEdit.Handle, GWL_STYLE,
                GetWindowLong(FBEdit.Handle, GWL_STYLE)
                or ES_RIGHT
                or ES_NUMBER);
    SetWindowPos(FBEdit.Handle, 0, 0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or
               SWP_NOZORDER or SWP_FRAMECHANGED);

    SetWindowLong(BREdit.Handle, GWL_STYLE,
                GetWindowLong(BREdit.Handle, GWL_STYLE)
                or ES_RIGHT
                or ES_NUMBER);
    SetWindowPos(BREdit.Handle, 0, 0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or
               SWP_NOZORDER or SWP_FRAMECHANGED);
    SetWindowLong(BGEdit.Handle, GWL_STYLE,
                GetWindowLong(BGEdit.Handle, GWL_STYLE)
                or ES_RIGHT
                or ES_NUMBER);
    SetWindowPos(BGEdit.Handle, 0, 0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or
               SWP_NOZORDER or SWP_FRAMECHANGED);
    SetWindowLong(BBEdit.Handle, GWL_STYLE,
                GetWindowLong(BBEdit.Handle, GWL_STYLE)
                or ES_RIGHT
                or ES_NUMBER);
    SetWindowPos(BBEdit.Handle, 0, 0, 0, 0, 0,
               SWP_NOMOVE or SWP_NOSIZE or
               SWP_NOZORDER or SWP_FRAMECHANGED);
    CalcColor;

    Dither1 := 1;
    Dither2 := 1;
    //ResGroupSizeChange(False);

end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    ini: TMemIniFile;
    i: integer;
begin
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        ini.WriteBool('Options', 'Stayontop', mnuOnTop.Checked);
        ini.WriteBool('Options', 'HexValue', mnuHex.Checked);
        ini.WriteInteger('Window', 'Left', Left);
        ini.WriteInteger('Window', 'Top', Top);
        ini.UpdateFile;
    finally
        ini.Free;
    end;
    PickForm.Free;
    for i := Low(arSS_HDC) to High(arSS_HDC) do
        	DeleteDC(arSS_HDC[i]);

    if SS_bmp <> 0 then
        DeleteObject(SS_bmp);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
    //mnuOnTopClick(self);
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
    btnForeClick(btnFore);
end;

procedure TMainForm.actBColorPickExecute(Sender: TObject);
begin
    SelFore := False;
    btnForeClick(btnBack);
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
    if mnuHex.Checked then
    begin
        if (Length(Edit1.Text) = 7) and IsHex(Edit1.Text) then
        begin
            FJColor.ActiveColor := HexToColor(Edit1.Text);
        end;
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

    if (mnuRGB.Checked) and (not bSetValue) then
    begin
        i := StrToIntDef(FREdit.Text, 0);
        R := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(FGEdit.Text, 0);
        G := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(FBEdit.Text, 0);
        B := IntToHex(Zeroto255(i), 2);

        FJColor.ActiveColor := StringToColor('$00' + B + G + R);
    end;
end;

procedure TMainForm.BREditChange(Sender: TObject);
var
    R, G, B: String;
    i: integer;

begin
    if (mnuRGB.Checked) and (not bSetValue) then
    begin
        i := StrToIntDef(BREdit.Text, 0);

        R := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(BGEdit.Text, 0);
        G := IntToHex(Zeroto255(i), 2);
        i := StrToIntDef(BBEdit.Text, 0);
        B := IntToHex(Zeroto255(i), 2);

        BColor.ActiveColor := StringToColor('$00' + B + G + R);
    end;
end;

procedure TMainForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #$0D then
    begin
        key := #0;
        if mnuHex.Checked then
        begin
            if (Length(Edit1.Text) = 7) and IsHex(Edit1.Text) then
                FJColor.ActiveColor := HexToColor(Edit1.Text);
        end;
    end;

end;

procedure TMainForm.Edit2Change(Sender: TObject);
begin
    if mnuHex.Checked then
    begin
        if (Length(Edit2.Text) = 7) and IsHex(Edit2.Text) then
            BColor.ActiveColor := HexToColor(Edit2.Text);
    end;
end;

procedure TMainForm.Edit2KeyPress(Sender: TObject; var Key: Char);

begin
    if Key = #$0D then
    begin
        key := #0;
        if mnuHex.Checked then
        begin
            if (Length(Edit2.Text) = 7) and IsHex(Edit2.Text) then
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

procedure TMainForm.ItemDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin

end;

procedure TMainForm.ItemMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin

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
  selected := true;
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

        ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
        try
            ini.WriteInteger('Font', 'Charset', Font.Charset);
            ini.WriteString('Font', 'Name', Font.Name);
            ini.WriteInteger('Font', 'Size', Font.Size);
            ini.UpdateFile;
        finally
            ini.Free;
        end;
        ResizeCtrls;
    end;

end;

procedure TMainForm.mnuAboutClick(Sender: TObject);
var
    AboutForm: TAboutForm;
begin
    AboutForm := TAboutForm.Create(self);
    AboutForm.PopupParent := Self;
    AboutForm.Font := Font;

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
        Panel1.Visible := False;
        Edit1.Visible := True;
        Panel2.Visible := False;
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
        Panel1.Visible := True;
        Edit1.Visible := False;
        Panel2.Visible := True;
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
    eRes: Extended;
    FC, BC: TColor;
    lcr_l4, lcr, lcr_l2, lcr_l3, lcr_note, lcr_note2, lcr_note3, d, latio_is, pass, fail, ratio_short: string;
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
    latio_is := GetTranslation('lcr_ratio_is', 'The contrast ratio is: %s');
    ratio_short := GetTranslation('contrast_ratio', 'Contrast ratio: %s');
    lcr_note := GetTranslation('lcr_note', Luminosity_Contrast_Note);
    lcr_note2 := GetTranslation('lcr_note2', Luminosity_Contrast_Note2);
    lcr_note3 := GetTranslation('lcr_note3', 'Note: Fonts that are extraordinarily thin or decorative are harder to read at lower contrast levels.');
    lcr_note := StringReplace(lcr_note, '%rn', #13#10, [rfReplaceAll, rfIgnoreCase]);
    lcr_note2 := StringReplace(lcr_note2, '%rn', #13#10, [rfReplaceAll, rfIgnoreCase]);
    lcr_note3 := StringReplace(lcr_note3, '%rn', #13#10, [rfReplaceAll, rfIgnoreCase]);

    pass := GetTranslation('passed', 'passed');
    fail := GetTranslation('failed', 'failed');
    Image1.Picture := nil;
    Image2.Picture := nil;
    Image3.Picture := nil;
    Image4.Picture := nil;
    Image5.Picture := nil;
    Back := Calc(BColor.ActiveColor);
    Fore := Calc(FJColor.ActiveColor);
    High := Max(Back, Fore) + 0.05;
    Low := Min(Back, Fore) + 0.05;
    SetRoundMode(rmUP);
    try
        eRes := SimpleRoundTo(High / Low, -1);
    except
        eRes := 0.0;
    end;
    Result := eRes;
    if mnuHex.Checked then
    begin
        Edit1.Text := ColortoHex2(FJColor.ActiveColor);
        Edit2.Text := ColortoHex2(BColor.ActiveColor);
    end
    else
    begin
        SetRGB;
    end;
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
    if eRes >= 3.0 then
    begin
        if (eRes >= 3) and (eRes < 4.5) then
        begin
            Image1.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
            Image7.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
            Image8.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK');
            Image9.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
        end
        else if (eRes >= 4.5) and (eRes < 7) then
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

    edtProta.Text := Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']);
    edtProta.Color := BC;
    edtProta.Font.Color := FC;
    if rb_least3.Checked then
    begin
        if eRes >= 3 then
            Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least5.Checked then
    begin
        if eRes >= 4.5 then
            Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least7.Checked then
    begin
        if eRes >= 7 then
            Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end;

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

    edtDeutera.Text := Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']);
    edtDeutera.Color := BC;
    edtDeutera.Font.Color := FC;
    if rb_least3.Checked then
    begin
        if eRes >= 3 then
            Image3.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image3.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least5.Checked then
    begin
        if eRes >= 4.5 then
            Image3.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image3.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least7.Checked then
    begin
        if eRes >= 7 then
            Image3.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image3.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end;

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

    edtTrita.Text := Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']);
    edtTrita.Color := BC;
    edtTrita.Font.Color := FC;
    if rb_least3.Checked then
    begin
        if eRes >= 3 then
            Image4.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image4.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least5.Checked then
    begin
        if eRes >= 4.5 then
            Image4.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image4.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least7.Checked then
    begin
        if eRes >= 7 then
            Image4.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image4.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end;

    Back := Calc(BColor.ActiveColor);
    Fore := Calc(FJColor.ActiveColor);
    High := Max(Back, Fore) + 0.05;
    Low := Min(Back, Fore) + 0.05;
    try
        eRes := SimpleRoundTo(High / Low, -1);
    except
        eRes := 0.0;
    end;
    if rb_least3.Checked then
    begin
        if eRes >= 3 then
            Image5.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image5.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least5.Checked then
    begin
        if eRes >= 4.5 then
            Image5.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image5.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end
    else if rb_least7.Checked then
    begin
        if eRes >= 7 then
            Image5.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_OK')
        else
            Image5.Picture.Bitmap.LoadFromResourceName(hInstance, 'RES_FAIL');
    end;
    if eRes < 3.0 then
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
    else if (eRes >= 3.0) and (eRes < 4.5) then
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
    else if (eRes >= 4.5) and (eRes < 7.0) then
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
    else if eRes >= 7.0 then
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
    edtNormal2.Text := Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']);
    lblRatio.Caption := Format(ratio_short, [FormatFloat('0.0#', eRes) + ':1']);
    d := gbFore.Caption + ':' + ColortoHex2(FJColor.ActiveColor) + #13#10 + gbBack.Caption + ':' + ColortoHex2(BColor.ActiveColor) + #13#10#13#10 + Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']) + #13#10 + d;
    Memo1.Text := d;// + #13#10#13#10 + lcr_note + #13#10#13#10 + lcr_note2 + #13#10#13#10 + lcr_note3;
    bSetValue := False;
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




procedure TMainForm.tbFRChange(Sender: TObject);
var
    R, G, B: String;
begin
    if (not bSetValue) then
    begin
        R := IntToHex(tbFR.Position, 2);
        G := IntToHex(tbFG.Position, 2);
        B := IntToHex(tbFB.Position, 2);

        FJColor.ActiveColor := StringToColor('$00' + B + G + R);
    end;
end;

procedure TMainForm.tbBRChange(Sender: TObject);
var
    R, G, B: String;
begin
    if (not bSetValue) then
    begin
        R := IntToHex(tbBR.Position, 2);
        G := IntToHex(tbBG.Position, 2);
        B := IntToHex(tbBB.Position, 2);

        BColor.ActiveColor := StringToColor('$00' + B + G + R);
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

procedure TMainForm.actExpandAllExecute(Sender: TObject);
begin
    chkExpand.Checked := not chkExpand.Checked;
    chkExpand2.Checked := not chkExpand2.Checked;
    ChkExpandClick(self);
    chkExpand.Refresh;
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

procedure TMainForm.mnuScreenClick(Sender: TObject);
var
    ConvWndForm: TConvWndForm;
begin
    Hide;
    Sleep(300);


    ConvWndForm := TConvWndForm.Create(self);
    ConvWndForm.Font := Font;
    ConvWndForm.DefFont := DefFont;
    ConvWndForm.Dy := DefY;
    ConvWndForm.Dx := DefX;
    ConvWndForm.ScaleX := ScaleX;
    ConvWndForm.ScaleY := ScaleY;
    ConvWndForm.Exec := False;

    ConvWndForm.ExecCute(1);
    ConvWndForm.ShowModal;
    Show;

end;

procedure TMainForm.mnuSelListClick(Sender: TObject);
var
    frmSelList: TfrmSelList;
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
    frmSelIMG := TfrmIMGConvert.Create(self);
    FormStyle := fsNormal;
    try
      frmSelIMG.Font := Font;
      frmSelIMG.DefFont := DefFont;
      frmSelIMG.Dy := DefY;
      frmSelIMG.Dx := DefX;
      frmSelIMG.ScaleX := ScaleX;
      frmSelIMG.ScaleY := ScaleY;
      frmSelIMG.ResizeCtrls;
        frmSelIMG.ShowModal;
    finally
        FreeAndNil(frmSelIMG);
        mnuOnTopClick(self);
    end;
end;

procedure TMainForm.btnForeClick(Sender: TObject);
var
    SC_hdc: HDC;
    iw, ih, i: Integer;
    pt: TPoint;
    monEx: TMonitorInfoEx;
begin
    if (Sender is TBitBtn) then
    begin
        if (Sender as TBitBtn) = btnFore then
            SelFore := True
        else
            SelFore := False;
        //if SS_hdc <> 0 then
        //begin
        if SS_hdc <> 0 then
        	DeleteDC(SS_hdc);
        //end;
        if SS_bmp <> 0 then
            DeleteObject(SS_bmp);

        SC_hdc := GetDC(0);
        SS_hdc := CreateCompatibleDC(SC_hdc);

        iw := GetDeviceCaps (SC_hdc, HORZRES);
        ih := GetDeviceCaps (SC_hdc, VERTRES);
        SS_bmp := CreateCompatibleBitmap(SC_hdc, iw, ih);
        SelectObject(SS_hdc, SS_bmp);
        BitBlt(SS_hdc, 0,0, Screen.DesktopWidth, Screen.DesktopHeight, SC_hdc, 0, 0, SRCCOPY);
        DeleteObject(SS_bmp);
        ReleaseDC(0, SC_hdc);

        for i := Low(arSS_HDC) to High(arSS_HDC) do
        	DeleteDC(arSS_HDC[i]);

        FillChar(monEx, SizeOf(TMonitorInfoEx), #0);
        monEx.cbSize := SizeOf(monEx);

        SetLength(arSS_HDC, 0);
        SetLength(arSS_HDC, Screen.MonitorCount);
        for i := Low(arSS_HDC) to High(arSS_HDC) do
        begin


    			GetMonitorInfo(Screen.Monitors[i].Handle, @monEx);

    			SC_hdc := CreateDC('DISPLAY', monEx.szDevice, nil, nil);
          arSS_HDC[i] := CreateCompatibleDC(SC_hdc);
        	SS_bmp := CreateCompatibleBitmap(SC_hdc, Monex.rcMonitor.Width , monex.rcMonitor.Height);
        	SelectObject(arSS_HDC[i], SS_bmp);

          try
            //SetStretchBltMode(arSS_HDC[i], HALFTONE );
        	  //StretchBlt(arSS_HDC[i], 0,0, Monex.rcMonitor.Width , monex.rcMonitor.Height, SC_hdc, 0, 0, iw, ih, SRCCOPY);
            BitBlt(arSS_HDC[i], 0,0, iw , ih, SC_hdc, 0, 0, SRCCOPY);
          finally
        	  DeleteObject(SS_bmp);
            DeleteDC(SC_hdc);
          end;
        end;
        PickForm.ScaleX := ScaleX;
        PickForm.ScaleY := ScaleY;

        GetCursorPos(pt);
        MoveWindow(PickForm.Handle, pt.x - (DoubleToInt(200 * ScaleX) div 2 + 1), pt.y - (DoubleToInt(200 * ScaleY) div 2 + 1), DoubleToInt(200 * ScaleX) + 2, DoubleToInt(200 * Scaley) + 2, TRUE);
        ShowCursor(False);
        PickForm.Show;
    end;
end;

procedure TMainForm.bbDD2Click(Sender: TObject);
var
    PO: TPoint;
begin
    PO.X := gbBack.Left + bbDD2.Left;
    PO.Y := gbBack.Top + bbDD2.Top + bbDD2.Height;
    PO := ClientToScreen(PO);
    PopupMenu2.Popup(PO.X, PO.Y);

end;

procedure TMainForm.bbDD1Click(Sender: TObject);
var
    PO: TPoint;
begin
    PO.X := gbFore.Left + bbDD1.Left;
    PO.Y := gbFore.Top + bbDD1.Top + bbDD1.Height;
    PO := ClientToScreen(PO);
    PopupMenu1.Popup(PO.X, PO.Y);

end;

procedure TMainForm.mnuShowBlindClick(Sender: TObject);
begin
    mnuShowBlind.Checked := not mnuShowBlind.Checked;
    chkBlind.Checked := mnuShowBlind.Checked;
    gbResNormal.Visible := False;
    gbResBlind.Visible := False;
    if mnuShowBlind.Checked then
        gbResBlind.Visible := mnuShowBlind.Checked
    else
    begin
        gbResNormal.Visible := True;
    end;
    ResizeCtrls;
    if mnuShowBlind.Checked then
        ResGroupSizeChange(True)
    else
        ResGroupSizeChange(chkExpand.Checked);
end;

procedure TMainForm.chkblindClick(Sender: TObject);
begin
    mnuShowBlind.Checked := chkblind.Checked;
    gbResNormal.Visible := False;
    gbResBlind.Visible := False;
    gbResBlind.Visible := mnuShowBlind.Checked;
    gbResNormal.Visible := not mnuShowBlind.Checked;
    //ResizeCtrls;
    if mnuShowBlind.Checked then
        ResGroupSizeChange(True)
    else
        ResGroupSizeChange(chkExpand.Checked);
end;

procedure TMainForm.chkExpandEnter(Sender: TObject);
begin
    try
    if (Sender is TWinControl) then
        StatusBar1.SimpleText := GetLongHint((Sender as TWinControl).Hint);
    except
    end;
end;

procedure TMainForm.mnuSliderClick(Sender: TObject);
begin
    mnuSlider.Checked := not mnuSlider.Checked;
    BGGroupSizeChange(mnuSlider.Checked);
    FGGroupSizeChange(mnuSlider.Checked);
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
  scaleX := Message.WParamLo / DefX;//96.0;
  scaleY := Message.WParamHi / DefY;//96.0;
  ResizeCtrls;
end;

end.
