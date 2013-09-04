unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ColorConvert,
  ImgList, Buttons, IniFiles, ActnList, JColorSelect2, ShellAPI, Menus,
  Mask, JPEG, FormIMGConvert, ToolWin, Clipbrd, ShlObj, ComObj, System.Actions;
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
    gbFore: TGroupBox;
    gbBack: TGroupBox;
    gbResNormal: TGroupBox;
    ImageList1: TImageList;
    gbResBlind: TGroupBox;
    edtProta: TLabeledEdit;
    edtDeutera: TLabeledEdit;
    edtTrita: TLabeledEdit;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    FontDialog1: TFontDialog;
    edtNormal2: TLabeledEdit;
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
    Edit1: TMaskEdit;
    Edit2: TMaskEdit;
    mnuIMG: TMenuItem;
    mnuSelList: TMenuItem;
    SaveDialog1: TSaveDialog;
    mnuRGB: TMenuItem;
    mnuP_Value: TMenuItem;
    mnuSelIMG: TMenuItem;
    mnuScreen: TMenuItem;
    Panel1: TPanel;
    FREdit: TEdit;
    FGEdit: TEdit;
    FBEdit: TEdit;
    Panel2: TPanel;
    BREdit: TEdit;
    BGEdit: TEdit;
    BBEdit: TEdit;
    tbFR: TTrackBar;
    tbFG: TTrackBar;
    tbFB: TTrackBar;
    tbBR: TTrackBar;
    tbBG: TTrackBar;
    tbBB: TTrackBar;
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
    Memo1: TMemo;
    btnCopyRes: TButton;
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
    btnFore: TBitBtn;
    btnBack: TBitBtn;
    bbDD1: TBitBtn;
    bbDD2: TBitBtn;
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
    chkExpand: TCheckBox;
    chkExpand2: TCheckBox;
    gbText: TGroupBox;
    gbLText: TGroupBox;
    Image1: TImage;
    edtNormal_T: TEdit;
    Image7: TImage;
    edtNormal_T2: TEdit;
    Image8: TImage;
    Image9: TImage;
    edtNormal_LT: TEdit;
    edtNormal_LT2: TEdit;
    lblFR: TLabel;
    lblFB: TLabel;
    lblFG: TLabel;
    lblBR: TLabel;
    lblBG: TLabel;
    lblBB: TLabel;
    gbTextFor: TGroupBox;
    rb_least3: TRadioButton;
    rb_least5: TRadioButton;
    rb_least7: TRadioButton;
    lblRatio: TLabel;
    chkblind: TCheckBox;
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
  private
    { Private declare }
    Hex, RGB, copied: string;
    frmSelIMG: TfrmIMGConvert;
    bSetValue: Boolean;
    Transpath, APPDir, SPath: string;
    procedure SetRGB;
    procedure OnSHint(Sender: TObject);
    procedure SetTBPos;
    procedure FGGroupSizeChange(Large: boolean = True);
    procedure BGGroupSizeChange(Large: boolean = True);
    procedure ResGroupSizeChange(Large: boolean = True);
    procedure ResizeCtrls;

  public
    { Public declare }
    SS_hdc: HDC;
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

{$R *.dfm}

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
begin
    gbBack.Top := gbFore.Top + gbFore.Height + 7;
    //btnCopyRes.Top := ChkResult.Top;
    chkBlind.Top := gbBack.Top + gbBack.Height + 7;
    gbResBlind.Top := chkBlind.Top + chkBlind.Height + 5;
    gbResNormal.Top := gbResBlind.Top;
    if not mnuShowBlind.Checked then
    begin
        ClientHeight := gbResNormal.Top + gbResNormal.Height + StatusBar1.height;
    end
    else
        ClientHeight := gbResBlind.Top + gbResBlind.Height + StatusBar1.height;


end;

procedure TMainForm.ResGroupSizeChange(Large: boolean = True);
begin
    Memo1.Visible := Large;
    btnCopyRes.Visible := Large;
    if Large then
    begin

        gbResBlind.Height := edtTrita.Top + edtTrita.Height + 8;
        gbResNormal.Height := btnCopyRes.Top + btnCopyRes.Height + 8;
    end
    else
    begin
        gbResBlind.Height := edtTrita.Top + edtTrita.Height + 8;
        gbResNormal.Height := gbText.Top + gbText.Height + 8;
    end;
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
    ini := TMemIniFile.Create(TransPath, TEncoding.Unicode);
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

procedure TMainForm.FormCreate(Sender: TObject);
var
    i: Integer;
    ini: TMemIniFile;
begin
    APPDir :=  IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
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
    ini := TMemIniFile.Create(TransPath, TEncoding.Unicode);

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
    ResGroupSizeChange(False);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
    ini: TMemIniFile;
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
    if SS_hdc <> 0 then
        DeleteDC(SS_hdc);
    if SS_bmp <> 0 then
        DeleteObject(SS_bmp);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
    mnuOnTopClick(self);
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
        SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_SHOWWINDOW)
    else
        SetWindowPos(Handle,HWND_NOTOPMOST,Left,Top,Width,Height,SWP_SHOWWINDOW);
end;

procedure TMainForm.mnuHelp1Click(Sender: TObject);
begin
    if GetTranslation('docurl', 'http://www.nils.org.au/ais/web/resources/contrast_analyser/index.html') <> '' then
        ShellExecute(Handle, 'open', PChar(GetTranslation('docurl', 'http://www.nils.org.au/ais/web/resources/contrast_analyser/index.html')), nil, nil, SW_SHOW);
end;

procedure TMainForm.mnuFontClick(Sender: TObject);
var
    ini: TMemIniFile;
    i: integer;
begin
    FontDialog1.Font := Font;
    if FontDialog1.Execute then
    begin
        Font := FontDialog1.Font;
        edtNormal_T.Font.Name := Font.Name;
        edtNormal_T.Font.Charset := Font.Charset;
        edtNormal_T.Font.Style := [];
        edtNormal_T2.Font.Name := Font.Name;
        edtNormal_T2.Font.Charset := Font.Charset;
        edtNormal_T2.Font.Style := [];
        edtNormal_LT.Font.Name := Font.Name;
        edtNormal_LT.Font.Charset := Font.Charset;
        edtNormal_LT.Font.Style := [fsBold];
        edtNormal_LT2.Font.Name := Font.Name;
        edtNormal_LT2.Font.Charset := Font.Charset;
        edtNormal_LT2.Font.Style := [fsBold];
        edtNormal2.Font := Font;
        edtDeutera.Font := Font;
        edtProta.Font := Font;
        edtTrita.Font := Font;
        //edtNormal_T.Font.Style := [fsBold];
        //edtNormal_T2.Font.Style := [fsBold];
        edtNormal_LT.Font.Style := [fsBold];
        edtNormal_LT2.Font.Style := [fsBold];
        edtNormal2.Font.Style := [fsBold];
        edtDeutera.Font.Style := [fsBold];
        edtProta.Font.Style := [fsBold];
        edtTrita.Font.Style := [fsBold];
        FJColor.Font := Font;
        BColor.Font := Font;
        {FJColor.Left := Label1.Left + Label1.Width + 4;
        BColor.Left := Label2.Left + Label2.Width + 4;
        FJColor.Width := 185 - FJColor.Left;
        BColor.Width := 185 - BColor.Left;
        Edit1.Left := 193 + Label3.Width;
        Edit1.Width := 337 - 193- Label3.Width;
        Edit2.Left := 193 + Label4.Width;
        Edit2.Width := 337 - 193- Label4.Width;
        Panel1.Left := 193 + Label3.Width;
        Panel2.Left := 193 + Label4.Width;
        Panel1.Width := 337 - 193- Label3.Width;
        Panel2.Width := 337 - 193- Label4.Width;
        i := Panel1.Width div 3;
        FREdit.Left := 0;
        FREdit.Width := i;
        FGEdit.Left := i;
        FGEdit.Width := i;
        FBEdit.Left := i * 2;
        FBEdit.Width := i;
        i := Panel2.Width div 3;
        BREdit.Left := 0;
        BREdit.Width := i;
        BGEdit.Left := i;
        BGEdit.Width := i;
        BBEdit.Left := i * 2;
        BBEdit.Width := i; }
        FJColor.Left := Label1.Left + Label1.Width + 4;
        BColor.Left := Label2.Left + Label2.Width + 4;
        FJColor.Width := 150{185} - FJColor.Left;
        BColor.Width := 150{185} - BColor.Left;
        Label3.Left := FJColor.Left + FJColor.Width + 4;
        Label4.Left := BColor.Left + BColor.Width + 4;
        Edit1.Left := Label3.Left + Label3.Width + 4;
        //Edit1.Left := 193 + Label3.Width;
        Edit1.Width := 287{337} - 154{193}- Label3.Width;
        Edit2.Left := Label4.Left + Label4.Width + 4;
        Edit2.Width := 287{337} - 154{193}- Label4.Width;

        Panel1.Left := Label3.Left + Label3.Width + 4;
        Panel1.Width := 287{337} - 154{193}- Label3.Width;
        //Panel1.Left := 193 + Label3.Width;
        //Panel1.Width := 337 - 193- Label3.Width;
        i := Panel1.Width div 3;
        FREdit.Left := 0;
        FREdit.Width := i;
        FGEdit.Left := i;
        FGEdit.Width := i;
        FBEdit.Left := i * 2;
        FBEdit.Width := i;
        Panel2.Left := Label4.Left + Label4.Width + 4;
        Panel2.Width := 287{337} - 154{193}- Label4.Width;
        //Panel2.Left := 193 + Label4.Width;
        //Panel2.Width := 337 - 193- Label4.Width;
        i := Panel2.Width div 3;
        BREdit.Left := 0;
        BREdit.Width := i;
        BGEdit.Left := i;
        BGEdit.Width := i;
        BBEdit.Left := i * 2;
        BBEdit.Width := i;
        ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
        try
            ini.WriteInteger('Font', 'Charset', Font.Charset);
            ini.WriteString('Font', 'Name', Font.Name);
            ini.WriteInteger('Font', 'Size', Font.Size);
            ini.UpdateFile;
        finally
            ini.Free;
        end;
    end;

end;

procedure TMainForm.mnuAboutClick(Sender: TObject);
var
    AboutForm: TAboutForm;
begin
    AboutForm := TAboutForm.Create(self);
    AboutForm.PopupParent := Self;
    AboutForm.Font.Name := Font.Name;
    AboutForm.Font.Charset := Font.Charset;

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
        FJColor.Left := Label1.Left + Label1.Width + 4;
        BColor.Left := Label2.Left + Label2.Width + 4;
        FJColor.Width := 150{185} - FJColor.Left;
        BColor.Width := 150{185} - BColor.Left;
        Label3.Left := FJColor.Left + FJColor.Width + 4;
        Label4.Left := BColor.Left + BColor.Width + 4;
        Edit1.Left := Label3.Left + Label3.Width + 4;
        //Edit1.Left := 193 + Label3.Width;
        Edit1.Width := 287{337} - 154{193}- Label3.Width;
        Edit2.Left := Label4.Left + Label4.Width + 4;
        Edit2.Width := 287{337} - 154{193}- Label4.Width;
    end;
end;

procedure TMainForm.mnuRGBClick(Sender: TObject);
var
    i: integer;
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
        FJColor.Left := Label1.Left + Label1.Width + 4;
        BColor.Left := Label2.Left + Label2.Width + 4;
        FJColor.Width := 150{185} - FJColor.Left;
        BColor.Width := 150{185} - BColor.Left;
        Label3.Left := FJColor.Left + FJColor.Width + 4;
        Label4.Left := BColor.Left + BColor.Width + 4;
        Panel1.Left := Label3.Left + Label3.Width + 4;
        Panel1.Width := 287{337} - 154{193}- Label3.Width;
        //Panel1.Left := 193 + Label3.Width;
        //Panel1.Width := 337 - 193- Label3.Width;
        i := Panel1.Width div 3;
        FREdit.Left := 0;
        FREdit.Width := i;
        FGEdit.Left := i;
        FGEdit.Width := i;
        FBEdit.Left := i * 2;
        FBEdit.Width := i;
        Panel2.Left := Label4.Left + Label4.Width + 4;
        Panel2.Width := 287{337} - 154{193}- Label4.Width;
        //Panel2.Left := 193 + Label4.Width;
        //Panel2.Width := 337 - 193- Label4.Width;
        i := Panel2.Width div 3;
        BREdit.Left := 0;
        BREdit.Width := i;
        BGEdit.Left := i;
        BGEdit.Width := i;
        BBEdit.Left := i * 2;
        BBEdit.Width := i;
        //SetRGB;
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
    try
        eRes := RoundTo(High / Low, -2);
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
        eRes := RoundTo(High / Low, -2);
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
        eRes := RoundTo(High / Low, -2);
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
        eRes := RoundTo(High / Low, -2);
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
        eRes := RoundTo(High / Low, -2);
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
        d := d + #13#10#13#10 + Format(lcr_l2, [fail]);
        d := d + #13#10#13#10 + Format(lcr_l3, [fail]);
        d := d + #13#10#13#10 + Format(lcr_l4, [fail]);
        edtNormal_T.Text := GetTranslation('summary_text_fail_AA', 'Fail(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_fail_AA', 'Fail(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
    end
    else if (eRes >= 3.0) and (eRes < 4.5) then
    begin

        d := d + #13#10 + Format(lcr, [fail]);
        d := d + #13#10#13#10 + Format(lcr_l2, [fail]);
        d := d + #13#10#13#10 + Format(lcr_l3, [pass]);
        d := d + #13#10#13#10 + Format(lcr_l4, [fail]);
        edtNormal_T.Text := GetTranslation('summary_text_fail_AA', 'Fail(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
    end
    else if (eRes >= 4.5) and (eRes < 7.0) then
    begin
        d := d + #13#10 + Format(lcr, [pass]);
        d := d + #13#10#13#10 + Format(lcr_l2, [fail]);
        d := d + #13#10#13#10 + Format(lcr_l3, [pass]);
        d := d + #13#10#13#10 + Format(lcr_l4, [pass]);
        edtNormal_T.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_fail_AAA', 'Fail(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_AAA', 'Pass(AAA)');
    end
    else if eRes >= 7.0 then
    begin
        d := d + #13#10 + Format(lcr, [pass]);
        d := d + #13#10#13#10 + Format(lcr_l2, [pass]);
        d := d + #13#10#13#10 + Format(lcr_l3, [pass]);
        d := d + #13#10#13#10 + Format(lcr_l4, [pass]);
        edtNormal_T.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_T2.Text := GetTranslation('summary_text_AAA', 'Pass(AAA)');
        edtNormal_LT.Text := GetTranslation('summary_text_AA', 'Pass(AA)');
        edtNormal_LT2.Text := GetTranslation('summary_text_AAA', 'Pass(AAA)');
    end;
    edtNormal2.Color := BColor.ActiveColor;
    edtNormal2.Font.Color := FJColor.ActiveColor;
    edtNormal2.Text := Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']);
    lblRatio.Caption := Format(ratio_short, [FormatFloat('0.0#', eRes) + ':1']);
    d := gbFore.Caption + ':' + ColortoHex2(FJColor.ActiveColor) + '  ' + gbBack.Caption + ':' + ColortoHex2(BColor.ActiveColor) + #13#10#13#10 + Format(latio_is, [FormatFloat('0.0#', eRes) + ':1']) + #13#10 + d;
    Memo1.Text := d + #13#10#13#10 + lcr_note + #13#10#13#10 + lcr_note2 + #13#10#13#10 + lcr_note3;
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

procedure TMainForm.mnuSelListClick(Sender: TObject);
var
    frmSelList: TfrmSelList;
begin
    frmSelList := TFrmSelList.Create(self);
    try
        frmSelList.Font.Name := Font.Name;
        frmSelList.Font.Size := Font.Size;
        frmSelList.Font.Charset := Font.Charset;
        frmSelList.ShowModal;
    finally
        frmSelList.Free;
    end;
end;
procedure TMainForm.mnuSelIMGClick(Sender: TObject);
begin
    frmSelIMG := TfrmIMGConvert.Create(self);
    try
        frmSelIMG.ShowModal;
    finally
        FreeAndNil(frmSelIMG);
    end;
end;

procedure TMainForm.mnuScreenClick(Sender: TObject);
var
    SC_hdc: HDC;
    iw, ih: Integer;
    ConvWndForm: TConvWndForm;
begin

    Hide;
    Sleep(300);
    if SS_hdc <> 0 then
        DeleteDC(SS_hdc);
    if SS_bmp <> 0 then
        DeleteObject(SS_bmp);
    SC_hdc := GetDC(0);
    SS_hdc := CreateCompatibleDC(SC_hdc);

    iw := GetDeviceCaps (SC_hdc, HORZRES);
    ih := GetDeviceCaps (SC_hdc, VERTRES);
    SS_bmp := CreateCompatibleBitmap(SC_hdc, iw, ih);
    SelectObject(SS_hdc, SS_bmp);
    BitBlt(SS_hdc, 0, 0, iw, ih, SC_hdc, 0, 0, SRCCOPY);
    ReleaseDC(0, SC_hdc);
    ConvWndForm := TConvWndForm.Create(self);
    ConvWndForm.Exec := False;

    ConvWndForm.ExecCute(1);
    ConvWndForm.ShowModal;
    Show;

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

procedure TMainForm.btnForeClick(Sender: TObject);
var
    SC_hdc: HDC;
    iw, ih: Integer;
    pt: TPoint;
begin
    if (Sender is TBitBtn) then
    begin
        if (Sender as TBitBtn) = btnFore then
            SelFore := True
        else
            SelFore := False;
        if SS_hdc <> 0 then
            DeleteDC(SS_hdc);
        if SS_bmp <> 0 then
            DeleteObject(SS_bmp);
        SC_hdc := GetDC(0);
        SS_hdc := CreateCompatibleDC(SC_hdc);

        iw := GetDeviceCaps (SC_hdc, HORZRES);
        ih := GetDeviceCaps (SC_hdc, VERTRES);
        SS_bmp := CreateCompatibleBitmap(SC_hdc, iw, ih);
        SelectObject(SS_hdc, SS_bmp);
        BitBlt(SS_hdc, 0, 0, iw, ih, SC_hdc, 0, 0, SRCCOPY);
        ReleaseDC(0, SC_hdc);
        GetCursorPos(pt);
        MoveWindow(PickForm.Handle, pt.x - 101, pt.y - 101, 202, 202, TRUE);
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




end.
