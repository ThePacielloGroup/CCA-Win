unit ConvWnd;
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, JPEG, ColorConvert,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Th_IMGConv, Multimon, System.Math, Funcs, ShlObj, ComObj, IniFiles;


type
  TConvWndForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    cmbColor: TComboBox;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cmbColorChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private 宣言 }
    ThIMG: IMG_Conv2;
    ThFlag: Boolean;
    Xx, Yy: Integer;
    iMode: Integer;
    hRgn1, hRgn2, hRgn: LongWord;

    procedure OnMove(var msg: TWMMove); message WM_MOVE;
    //procedure OnMoving(var msg: TWMMoving); message WM_MOVING;
    procedure ThDone(Sender: TObject);
    procedure WMExitSizeMove(var msg:TMessage);message WM_EXITSIZEMOVE;

    procedure WMDPIChanged(var Message: TMessage); message WM_DPICHANGED;
    {procedure AppDeActive(Sender: TObject);
    procedure AppActive(Sender: TObject);}

    Procedure SetRGN(Create: Boolean = True);
    procedure ResizeCtrls;
  public
    { Public 宣言 }
    ScaleY, ScaleX, Dx, Dy: double;
    DefFont: integer;
    Exec, MoveFlag: Boolean;
    SPath: string;
    procedure ExecCute(Mode: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  ConvWndForm: TConvWndForm;
  BMP: TBitMap;
implementation

uses Main;

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
    raise Exception.Create('仮想フォルダのため取得できません');
  end;
  Result := StrPas(Buffer);
end;

function DoubleToInt(d: double): integer;
begin
  SetRoundMode(rmUP);
  Result := Trunc(SimpleRoundTo(d));
end;

procedure TConvWndForm.ExecCute(Mode: Integer);
begin
    Exec := True;
    ResizeCtrls;
    iMode := Mode;
end;

Procedure TConvWndForm.SetRGN(Create: Boolean = True);
var
    CapH, FrmX, FrmY: Integer;
begin
    if Create then
    begin
        CapH := GetSystemMetrics(SM_CYCAPTION);
        FrmX := GetSystemMetrics(SM_CXSIZEFRAME);
        FrmY := GetSystemMetrics(SM_CYSIZEFRAME);
        hRgn := CreateRectRgn(0, 0, 1, 1);
        hRgn1 := CreateRectRgn(0, 0, Width, Height);
        hRgn2 := CreateRectRgn(3, 4 + CapH, Image1.Width + FrmX, Image1.Height + FrmY + CapH);
        CombineRgn(hRgn, hRgn1, hRgn2, RGN_DIFF);
        SetWindowRgn(Handle, hRgn, TRUE);
    end
    else
    begin
        DeleteObject(hRgn);
        DeleteObject(hRgn1);
        DeleteObject(hRgn2);
        hRgn := CreateRectRgn(0, 0, Width, Height);
        SetWindowRgn(Handle, hRgn, False);
        InvalidateRect(Handle, nil, false);
    end;
end;

function ChangeColorPalette( Tone: Byte ; Mode: integer; hPal: HPALETTE): HPALETTE;
var
  Palette: TMaxLogPalette;
  i: Integer;
begin
  result := 0;
   Palette.palNumEntries := Tone + 1;
   Palette.palVersion := $0300;
   if Mode = 0 then
   begin
    for i := 0 to Tone do
    begin
      Palette.palPalEntry[ i ].peRed   := Tone - i;
      Palette.palPalEntry[ i ].peGreen := Tone - i;
      Palette.palPalEntry[ i ].peBlue  := Tone - i;
      Palette.palPalEntry[ i ].peFlags := 0;

    end;
    Result := CreatePalette( PLogPalette( @Palette )^ );
   end
   else if Mode = 1 then
   begin
    GetPaletteEntries(hPal, 0, 256, Palette.palPalEntry);
    for i := 0 to Tone do
    begin
      Convert_P(Palette.palPalEntry[ i ].peRed, Palette.palPalEntry[ i ].peGreen, Palette.palPalEntry[ i ].peBlue);
      {Palette.palPalEntry[ i ].peRed   := not Palette.palPalEntry[ i ].peRed;
      Palette.palPalEntry[ i ].peGreen := not Palette.palPalEntry[ i ].peGreen;
      Palette.palPalEntry[ i ].peBlue  := not Palette.palPalEntry[ i ].peBlue;  }
      Palette.palPalEntry[ i ].peFlags := 0;
    end;
    Result := CreatePalette( PLogPalette( @Palette )^ );
   end
   else if Mode = 4 then //invert
   begin
    GetPaletteEntries(hPal, 0, 256, Palette.palPalEntry);
    for i := 0 to Tone do
    begin


      Palette.palPalEntry[ i ].peRed   := not Palette.palPalEntry[ i ].peRed;
      Palette.palPalEntry[ i ].peGreen := not Palette.palPalEntry[ i ].peGreen;
      Palette.palPalEntry[ i ].peBlue  := not Palette.palPalEntry[ i ].peBlue;
      Palette.palPalEntry[ i ].peFlags := 0;
    end;
    Result := CreatePalette( PLogPalette( @Palette )^ );
   end;

end;

procedure TConvWndForm.WMExitSizeMove(var msg:TMessage);
var
	Mode, i: integer;
  TP: TPoint;
  SC_hdc: HDC;
    monEx: TMonitorInfoEx;
    hm: HMonitor;
    JPG: TJpegImage;
begin

    MoveFlag := False;
    TP.X := Xx;
    TP.Y := Yy;
    FillChar(monEx, SizeOf(TMonitorInfoEx), #0);
    monEx.cbSize := SizeOf(monEx);
    for i := 0 to Screen.MonitorCount - 1 do
    begin
    	GetMonitorInfo(Screen.Monitors[i].Handle, @monEx);
      hm := MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST);
    	//if PtInRect(monEx.rcMonitor , TP) then
      if hm = Screen.Monitors[i].Handle then
      begin
        SC_hdc := CreateDC('DISPLAY', monEx.szDevice, nil, nil);
        try
          TP.X := TP.X - Screen.Monitors[i].Left;
          TP.Y := TP.Y - Screen.Monitors[i].Top;

          BitBlt(BMP.Canvas.Handle, 0, 0, Image1.Width, Image1.Height, SC_hdc, TP.X, TP.Y, SRCCOPY);

          break;
        finally
          DeleteDC(SC_HDC);
        end;
      end;
    end;
    //BitBlt(BMP.Canvas.Handle, 0, 0, 300, 300, MainForm.SS_hdc, Xx, Yy, SRCCOPY);

    //BitBlt(BMP.Canvas.Handle, 0, 0, 300, 300, MainForm.SS_hdc, Xx, Yy, SRCCOPY);
    ThFlag := True;
    if cmbColor.ItemIndex = 0 then  //protanopia
    begin
        Mode := 1;

    end
    else if cmbColor.ItemIndex = 1 then  //deuteranopia
    begin
        Mode := 2;
    end
    else if cmbColor.ItemIndex = 2 then  //tritanopia
    begin
        Mode := 3;
    end
    else if cmbColor.ItemIndex = 3 then  //grayscale
    begin
        Mode := 0;
       JPG := TJpegImage.Create;
       try

        JPG.Assign(BMP);
        JPG.CompressionQuality := 100;
        JPG.Compress;
        JPG.PixelFormat := jf8bit;
        JPG.Palette :=  ChangeColorPalette( 255 , 0, JPG.Palette);
        image1.Picture.Bitmap.Assign(JPG);

        ThFlag := False;
        SetRGN(False);
        finally
          JPG.Free;
        end;
        exit;
    end
    else if cmbColor.ItemIndex = 4 then  //invert
    begin
        Mode := 4 ;

    end
    else if cmbColor.ItemIndex = 5 then  //cataracts
        Mode := 5
    else
        Mode := 1;
    ThIMG := IMG_Conv2.Create(BMP.ReleaseHandle, Mode, Image1);
    ThIMG.OnTerminate := ThDone;
end;
procedure TConvWndForm.OnMove(var msg: TWMMove);
begin
    inherited;
    Xx := Msg.XPos;
    Yy := Msg.YPos;
    if not MoveFlag then
    begin
        if ThIMG <> nil then ThIMG.Terminate;
        SetRGN;
    end;
    MoveFlag := True;

end;

procedure TConvWndForm.ThDone(Sender: TObject);
begin
    if not (Sender is IMG_Conv2) then Exit;
    ThIMG := nil;
    ThFlag := False;
    SetRGN(False);
end;

procedure TConvWndForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    ini: TMemIniFile;
begin
    if ThIMG <> nil then ThIMG.Terminate;
    BMP.FreeImage;
    BMP.Free;
    DeleteObject(hRgn);
    DeleteObject(hRgn1);
    DeleteObject(hRgn2);
    Action := caFree;
    ConvWndForm := nil;
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        ini.WriteInteger('Window', 'ConVWnd_Left', Left);
        ini.WriteInteger('Window', 'ConVWnd_Top', Top);
        ini.WriteInteger('Window', 'ConVWnd_Width', Width);
        ini.WriteInteger('Window', 'ConVWnd_Height', Height);
        ini.UpdateFile;
    finally
        ini.Free;
    end;
end;

procedure TConvWndForm.FormCreate(Sender: TObject);
var
    ini: TMemIniFile;
begin
    DoubleBuffered := True;

    SPath := IncludeTrailingPathDelimiter(GetMyDocPath) + 'CCA.ini';
    ScaleX := 1.0;
    ScaleY := 1.0;
    MoveFlag := False;
    BMP := TBitmap.Create;
    BMP.Width := 300;
    BMP.Height := 300;
    BMP.PixelFormat := pf24bit;
    ThIMG := nil;
    ThFlag := False;
    Label2.Caption := MainForm.GetTranslation('simulation', 'Simulation');
    cmbColor.Items.Add(MainForm.GetTranslation('protanopia', 'Protanopia'));
    cmbColor.Items.Add(MainForm.GetTranslation('deuteranopia', 'Deuteranopia'));
    cmbColor.Items.Add(MainForm.GetTranslation('tritanopia', 'Tritanopia'));
    cmbColor.Items.Add(MainForm.GetTranslation('grayscale', 'Grayscale'));
    cmbColor.Items.Add(MainForm.GetTranslation('invert', 'Invert'));
    cmbColor.Items.Add(MainForm.GetTranslation('cataracts', 'Cataracts'));
    cmbColor.ItemIndex := 0;
    Label1.Caption := MainForm.GetTranslation('wnd_move', WND_Move);
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        Left := ini.ReadInteger('Window', 'ConVWnd_Left', (Screen.WorkAreaWidth div 2) - (Width div 2));
        Top := ini.ReadInteger('Window', 'ConVWnd_Top', (Screen.WorkAreaHeight div 2) - (Height div 2));
        Width := ini.ReadInteger('Window', 'ConVWnd_Width', 800);
        Height := ini.ReadInteger('Window', 'ConVWnd_Height', 600);
    finally
        ini.Free;
    end;
end;

procedure TConvWndForm.CreateParams(var Params: TCreateParams);
begin
    inherited CreateParams(Params);
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
    Params.WndParent := 0;
end;

procedure TConvWndForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
    if (Key = VK_ESCAPE) then
        Close;
end;

procedure TConvWndForm.FormShow(Sender: TObject);
begin
    SetRGN;
    
    MoveFlag := False;
end;

procedure TConvWndForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #77) or (key = #109) then
    begin
        SendMessage (Handle, WM_SYSCOMMAND, SC_MOVE, 0);
    end;
end;

procedure TConvWndForm.FormResize(Sender: TObject);
begin
  Label2.Left := Image1.Left + Image1.Width + 5;
  Label2.Top := 0;
  cmbColor.Left := Label2.Left;
  cmbColor.Top := Label2.Height + 1;
  Label1.Left := Label2.Left;;
  Label1.Top := cmbColor.Top + cmbColor.Height + 3;
  Label1.Width := ClientWidth - Image1.Width - 5;
  Label1.Height := ClientHeight - Label2.Height - cmbColor.Height - 4;
  BMP.Width := Image1.Width;
    BMP.Height := Image1.Height;
    SetRGN(False);
    SetRGN(True);
end;

procedure TConvWndForm.cmbColorChange(Sender: TObject);
var
    Mode, i: integer;
    TP: TPoint;
    SC_hdc: HDC;
    monEx: TMonitorInfoEx;
    hm: HMonitor;
begin
    MoveFlag := False;
    //BitBlt(BMP.Canvas.Handle, 0, 0, 300, 300, MainForm.SS_hdc, Xx, Yy, SRCCOPY);
    TP.X := Xx;
    TP.Y := Yy;
    FillChar(monEx, SizeOf(TMonitorInfoEx), #0);
    monEx.cbSize := SizeOf(monEx);
    for i := 0 to Screen.MonitorCount - 1 do
    begin
    	GetMonitorInfo(Screen.Monitors[i].Handle, @monEx);
      hm := MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST);
    	//if PtInRect(monEx.rcMonitor , TP) then
      if hm = Screen.Monitors[i].Handle then
      begin
        SC_hdc := CreateDC('DISPLAY', monEx.szDevice, nil, nil);
        try
          TP.X := TP.X - Screen.Monitors[i].Left;
          TP.Y := TP.Y - Screen.Monitors[i].Top;
          SetRGN(False);
          SetRGN(True);
          BitBlt(BMP.Canvas.Handle, 0, 0, Image1.Width, Image1.Height, {MainForm.arSS_hdc[i]}SC_hdc, TP.X, TP.Y, SRCCOPY);
        finally
          DeleteDC(SC_HDC);
        end;
        break;
      end;
    end;
    //BitBlt(BMP.Canvas.Handle, 0, 0, 300, 300, MainForm.SS_hdc, Xx, Yy, SRCCOPY);
    ThFlag := True;
    if cmbColor.ItemIndex = 0 then
        Mode := 1
    else if cmbColor.ItemIndex = 1 then
        Mode := 2
    else if cmbColor.ItemIndex = 2 then
        Mode := 3
    else if cmbColor.ItemIndex = 3 then
        Mode := 0
    else if cmbColor.ItemIndex = 4 then
        Mode := 4
    else if cmbColor.ItemIndex = 5 then
        Mode := 5
    else
        Mode := 1;
    ThIMG := IMG_Conv2.Create(BMP.ReleaseHandle, Mode, Image1);
    ThIMG.OnTerminate := ThDone;

end;

procedure TConvWndForm.WMDPIChanged(var Message: TMessage);
begin
  if (Dx > 0) and (Dy > 0) then
  begin
    scaleX := Message.WParamLo / Dx;
    scaleY := Message.WParamHi / Dy;
    ResizeCtrls;
  end;
end;

procedure TConvWndForm.ResizeCtrls;
var
  sHeight, sWidth, mw: integer;
    procedure GetStrSize(Cap: string);
    begin

      sWidth := DoubleToInt(Canvas.TextWidth(Cap));
      sHeight := DoubleToInt(Canvas.TextHeight(Cap));

    end;
begin
  //GetWindowScale(Handle, Dx, Dy, ScaleX, ScaleY);
  Font.Size := DoubleToInt(DefFont * ScaleX);
  GetStrSize(Label2.Caption + ' ');
  Label2.Width := sWidth + 5;
  Label2.Height := sHeight + 2;
  cmbColor.Width := 150;
  cmbColor.ItemHeight := sHeight + 2;
  mw := MAX(Label2.Width, cmbColor.Width);
  ClientWidth := Image1.Width + mw + 20;

  Label2.Left := Image1.Left + Image1.Width + 5;
  Label2.Top := 0;
  cmbColor.Left := Label2.Left;
  cmbColor.Top := Label2.Height + 1;
  Label1.Left := Label2.Left;;
  Label1.Top := cmbColor.Top + cmbColor.Height + 3;
  Label1.Width := ClientWidth - Image1.Width - 5;
  Label1.Height := ClientHeight - Label2.Height - cmbColor.Height - 4;

end;

end.
