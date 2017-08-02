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
  Dialogs, StdCtrls, Buttons, ExtCtrls, Th_IMGConv, Multimon, Math, Funcs, ShlObj, ComObj, IniFiles, frmPV;


type
  TConvWndForm = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    cmbColor: TComboBox;
    Label2: TLabel;
    btnPV: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cmbColorChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnPVClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private 宣言 }
    ThIMG, ThIMG2: IMG_Conv2;
    ThFlag, thFlag2: Boolean;
    ThCnt, ThCnt2: integer;
    Xx, Yy, OriW, CurW: Integer;
    iMode: Integer;
    hRgn1, hRgn2, hRgn: LongWord;
    BMP1, BMP2: TBitmap;
    SrcBMP: TBitmap;
    sNormal: string;
    //procedure OnMoving(var msg: TWMMoving); message WM_MOVING;
    procedure ThDone(Sender: TObject);

    procedure ThDone_PV(Sender: TObject);
    procedure ThDone2_PV(Sender: TObject);
    {procedure AppDeActive(Sender: TObject);
    procedure AppActive(Sender: TObject);}

    Procedure SetRGN(Create: Boolean = True);

    procedure DrawImageName(Mode: integer; RC: TRect);
  public
    { Public 宣言 }
    ScaleY, ScaleX, Dx, Dy: double;
    DefFont: integer;
    Exec, MoveFlag: Boolean;
    SPath: string;
    procedure Execute(Mode: Integer);
    procedure ResizeCtrls;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMExitSizeMove(var msg:TMessage);message WM_EXITSIZEMOVE;
    procedure OnMove(var msg: TWMMove); message WM_MOVE;
    procedure WMDPIChanged(var Message: TMessage); message WM_DPICHANGED;
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

procedure TConvWndForm.Execute(Mode: Integer);
begin
    Exec := True;
    ResizeCtrls;
    OriW := Width;
    CurW := Width;
    self.ScaleBy(DoubleToInt(OriW * ScaleX), OriW);
    CurW := DoubleToInt(OriW * ScaleX);
    iMode := Mode;
end;

Procedure TConvWndForm.SetRGN(Create: Boolean = True);
var
    CapH, FrmX, FrmY: Integer;
begin
    if Create and (assigned(Image1)) then
    begin
        CapH := GetSystemMetrics(SM_CYCAPTION);
        FrmX := GetSystemMetrics(SM_CXSIZEFRAME);
        FrmY := GetSystemMetrics(SM_CYSIZEFRAME);
        hRgn := CreateRectRgn(0, 0, 1, 1);
        hRgn1 := CreateRectRgn(0, 0, Width, Height);
        hRgn2 := CreateRectRgn(FrmX, FrmY + CapH, Image1.Width + FrmX, Image1.Height + FrmY + CapH);
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

function ChangeColorPalette( Tone: Byte ; Mode: integer; hPal: HPALETTE): HPALETTE;//for 8bit bitmap
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
      Convert_P(Palette.palPalEntry[ i ].peRed, Palette.palPalEntry[ i ].peGreen, Palette.palPalEntry[ i ].peBlue, Palette.palPalEntry[ i ].peRed, Palette.palPalEntry[ i ].peGreen, Palette.palPalEntry[ i ].peBlue);
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
begin
  cmbColorChange(self);
end;

procedure TConvWndForm.cmbColorChange(Sender: TObject);
var
    Mode, i: integer;
    TP: TPoint;
    SC_hdc, Comp_HDC: HDC;
    hm: HMonitor;
    hBMP: hBitmap;
    FMonitor: TMonitor;
begin
    MoveFlag := False;
    TP.X := Xx;
    TP.Y := Yy;
    //FillChar(monEx, SizeOf(TMonitorInfoEx), #0);
    //monEx.cbSize := SizeOf(monEx);
    {for i := 0 to Screen.MonitorCount - 1 do
  	begin
  		hm := MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST);


    	if hm = Screen.Monitors[i].Handle then
    	begin
    		GetMonitorInfo(Screen.Monitors[i].Handle, @monEx);

    		try
    			SC_hdc := CreateDC('DISPLAY', monEx.szDevice, nil, nil);
      		BitBlt(BMP.Canvas.Handle, 0, 0, Image1.Width, Image1.Height, SC_hdc, TP.X, TP.Y, SRCCOPY);
    		finally
      		DeleteDC(SC_HDC);
    		end;
        Break;
      end;
    end;   }

    MainForm.GetSS;
    //FMonitor := Screen.MonitorFromWindow(Handle);
    hm := MonitorFromWindow(Handle , MONITOR_DEFAULTTONEAREST);
    for i := 0 to Screen.MonitorCount - 1 do
    begin
    	//if PtInRect(monEx.rcMonitor , TP) then
      if hm = Screen.Monitors[i].Handle then
      begin
        TP.X := TP.X - Screen.Monitors[i].Left;// * lx;
        TP.Y := TP.Y - Screen.Monitors[i].Top;// * ly;
       	BitBlt(BMP.Canvas.Handle, 0, 0, Image1.Width, Image1.Height, MainForm.arSS_hdc[i], TP.X, TP.Y, SRCCOPY);
        break;
      end;
    end;
    {GetMonitorInfo(hm, @monEx);
    try
    			SC_hdc := CreateDC('DISPLAY', monEx.szDevice, nil, nil);
      		BitBlt(BMP.Canvas.Handle, 0, 0, Image1.Width, Image1.Height, SC_hdc, TP.X, TP.Y, SRCCOPY);
    		finally
      		DeleteDC(SC_HDC);
    		end; }
    try

      BMP1.Assign(BMP);
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

    ThFlag := True;
    ThFlag2 := False;
    Image1.Picture.Bitmap.Width := image1.Width;
    Image1.Picture.Bitmap.Height := image1.Height;
    btnPV.Enabled := False;
    if Assigned(ThImg) then
    begin
      ThImg.Terminate;
      while ThFlag do
        Application.ProcessMessages;
    end;

    ThIMG := IMG_Conv2.Create(BMP1.ReleaseHandle, Mode, bmp1);
    ThIMG.OnTerminate := ThDone;
    ThIMG.Start;

    finally

    end;
end;


procedure TConvWndForm.OnMove(var msg: TWMMove);
begin
    inherited;
    Xx := Msg.XPos;
    Yy := Msg.YPos;
    if not MoveFlag then
    begin
        if Assigned(ThImg) then ThIMG.Terminate;
        if Assigned(ThImg2) then ThIMG2.Terminate;
        SetRGN;
    end;
    MoveFlag := True;

end;

procedure TConvWndForm.ThDone(Sender: TObject);
begin
    if Sender is IMG_Conv2 then
      ThIMG := nil;

    if (THImg = nil) then
    begin
      ThFlag := False;
    end;
    if (not ThFlag ) then
    begin
      SetRGN(False);
      Image1.Picture.Bitmap.Canvas.Draw(0, 0, BMP1);
      btnPV.Enabled := True;
    end;
end;


procedure TConvWndForm.FormClose(Sender: TObject;
  var Action: TCloseAction);

begin

    Action := caFree;
    ConvWndForm := nil;

end;

procedure TConvWndForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    ini: TMemIniFile;
begin

    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        ini.WriteInteger('Window', 'ConVWnd_Left', Left);
        ini.WriteInteger('Window', 'ConVWnd_Top', Top);
        ini.WriteInteger('Window', 'ConVWnd_Width', DoubleToInt(Width / ScaleX));
        ini.WriteInteger('Window', 'ConVWnd_Height', DoubleToInt(Height / ScaleY));
        ini.UpdateFile;
    finally
        ini.Free;
    end;
    CanClose := True;
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
    BMP1 := TBitmap.Create;
    BMP2 := TBitmap.Create;
    SrcBMP := TBitmap.Create;
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
    btnPV.Caption := MainForm.GetTranslation('Parallelview', 'Parallel view');
    sNormal := MainForm.GetTranslation('normal', 'Normal');
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

procedure TConvWndForm.FormDestroy(Sender: TObject);
begin
  if ThIMG <> nil then ThIMG.Terminate;
    if Assigned(pvForm) then
    begin
      FreeAndNil(pvForm);
    end;
    BMP.Free;
    BMP1.Free;
    BMP2.Free;
    SrcBMP.Free;
    DeleteObject(hRgn);
    DeleteObject(hRgn1);
    DeleteObject(hRgn2);
end;

procedure TConvWndForm.CreateParams(var Params: TCreateParams);
begin
    inherited;
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
    Params.WndParent := GetDesktopWindow;
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
  btnPV.Left := Label2.Left;
  Label1.Left := Label2.Left;;
  Label1.Width := ClientWidth - Image1.Width - 5;
  Label1.Height := ClientHeight - Label2.Height - cmbColor.Height - 4;

  BMP.Width := Image1.Width;
    BMP.Height := Image1.Height;

    BMP1.Width := (BMP.Width div 2);
      BMP2.Width := BMP.Width - BMP1.Width;
      BMP1.Height := BMP.Height;
      BMP2.Height := BMP.Height;
    SetRGN(False);
    SetRGN(True);
end;

procedure TConvWndForm.btnPVClick(Sender: TObject);
var
  iWidth, iHeight, pvm, i, t, w, h: integer;
  monEx: TMonitorInfoEx;
  hm: HMonitor;

begin
  if not Assigned(pvForm) then
  begin
    pvForm := TpvForm.Create(nil);
    pvForm.Font := Font;
    pvForm.Caption := btnPV.Caption;
  end;
  pvForm.Show;
  pvForm.WindowState := wsMaximized;
  //for i := 0 to Screen.MonitorCount - 1 do
  //begin
  	//hm := MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST);


    //if hm = Screen.Monitors[i].Handle then
    //begin
    	//GetMonitorInfo(Screen.Monitors[i].Handle, @monEx);
    	monEx.cbSize := SizeOf(monEx);
      hm := MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST);
    	GetMonitorInfo(hm, @monEx);


      
      if monEx.rcMonitor.Right >= monEx.rcMonitor.Bottom then
      begin
        iWidth := pvForm.ClientWidth div 3;// Screen.Monitors[i].Width div 3;
        iHeight := pvForm.ClientHeight div 2;//Screen.Monitors[i].Height div 2;
        pvm := 0;
      end
      else
      begin
        //iWidth := Screen.Monitors[i].Width div 2;
        //iHeight := Screen.Monitors[i].Height div 3;
        iWidth := pvForm.ClientWidth div 2;// Screen.Monitors[i].Width div 3;
        iHeight := pvForm.ClientHeight div 3;//Screen.Monitors[i].Height div 2;
        pvm := 1;
      end;

      if (Image1.Width > iWidth) or (Image1.Height > iHeight) then
      begin

        for t := 99 downto 10 do
        begin
          w := Image1.Width * t div 100;
          h := Image1.Height * t div 100;
          if (w <= iWidth) and (h <= iHeight) then
          begin
            iWidth := w;
            iHeight := h;
            Break;
          end;

        end;
      end
      else
      begin

        iWidth := Image1.Width;
        iHeight := Image1.Height;
      end;
      if pvm = 0 then
      begin
        pvForm.Image1.Width := iWidth * 3;
        pvForm.Image1.Height := iHeight * 2;
        pvForm.Image1.Picture.Bitmap.Width := iWidth * 3;
        pvForm.Image1.Picture.Bitmap.Height := iHeight * 2;
      end
      else
      begin
        pvForm.Image1.Width := iWidth * 2;
        pvForm.Image1.Height := iHeight * 3;
        pvForm.Image1.Picture.Bitmap.Width := iWidth * 2;
        pvForm.Image1.Picture.Bitmap.Height := iHeight * 3;
      end;
      iWidth := iWidth - 1;
      iHeight := iHeight - 1;
      try
        SrcBMP.Width := iWidth;
        SrcBMP.Height := iHeight;
        SetStretchBltMode(SrcBMP.Canvas.Handle, HALFTONE);
        StretchBlt(SrcBMP.Canvas.Handle, 0, 0, SrcBMP.Width, SrcBMP.Height, BMP.Canvas.Handle, 0, 0, BMP.Width, BMP.Height, SRCCOPY);
        //pvForm.Image1.Picture.Bitmap.Assign(SrcBMP);
        ThFlag := True;
        ThFlag2 := True;
        ThCnt := 0;
        ThCnt2 := 0;
        BMP1.Assign(SrcBMP);
        BMP2.Assign(SrcBMP);

        pvForm.Image1.Picture.Bitmap.Canvas.Brush.Color := clBtnFace;
        pvForm.Image1.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
        pvForm.Image1.Picture.Bitmap.Canvas.FillRect(Rect(0, 0, pvForm.Image1.Width, pvForm.Image1.Height));
        pvForm.Image1.Picture.Bitmap.Canvas.Draw(0, 0, SrcBMP);
        DrawImageName(6, Rect(0, 0, SrcBMP.Width, SrcBMP.Height));
        if Assigned(ThImg) then
        begin
          ThIMG.Terminate;
          while ThFlag do
            Application.ProcessMessages;
        end;
        if Assigned(ThIMG2) then
        begin
          ThIMG2.Terminate;
          while thFlag2 do
            Application.ProcessMessages;
        end;

        ThIMG := IMG_Conv2.Create(BMP1.ReleaseHandle, 1, BMP1);
        ThIMG.OnTerminate := ThDone_PV;
        ThIMG.Start;
        ThIMG2 := IMG_Conv2.Create(BMP2.ReleaseHandle, 3, BMP2);
        ThIMG2.OnTerminate := ThDone2_PV;
        ThIMG2.Start;
      finally

      end;

      //Break;
    //end;
  //end;
end;

procedure TConvWndForm.DrawImageName(Mode: integer; RC: TRect);
var
  nBMP: TBitmap;
  sName: string;
  sz: TSize;
  nRC: Trect;
begin
  if not Assigned(pvForm) then
    Exit;

  nBMP := TBitmap.Create;
  try

    if Mode > 6 then
      Exit;
    if Mode = 6 then
      sName := sNormal
    else
      sName := cmbColor.Items[Mode];



    nBMP.Canvas.Font := Font;
    sz := nBMP.Canvas.TextExtent(sName);
    nBMP.Width := sz.cx + 20;
    nBMP.Height := sz.cy + 10;
    nBMP.Canvas.Brush.Color := clBlack;

    nBMP.Canvas.Brush.Color := clWhite;
    nBMP.Canvas.Brush.Style := bsSolid;
    nBMP.Canvas.FillRect(Rect(0, 0, nBMP.Width, nBMP.Height));

    nBMP.Canvas.Brush.Color := clBlack;
    nBMP.Canvas.frameRect(Rect(0, 0, nBMP.Width, nBMP.Height));

    nBMP.Canvas.Brush.Color := clWhite;
    nRC := Rect(0, 0, nBMP.Width, nBMP.Height);
    nBMP.Canvas.TextRect(nRC, sName, [tfCenter, tfSingleLine, tfVerticalCenter]);
    pvForm.Image1.Picture.Bitmap.Canvas.Draw(RC.Left, RC.Top, nBMP);
  finally
    nBMP.Free;
  end;
end;

procedure TConvWndForm.ThDone_PV(Sender: TObject);
begin
    if Sender is IMG_Conv2 then
      ThIMG := nil;

    if (THImg = nil) then
    begin
      ThFlag := False;
    end;
    if (not ThFlag ) and (Assigned(pvForm)) then
    begin
      pvForm.Image1.Picture.Bitmap.Canvas.Draw(BMP1.Width * ((ThCnt + 1) * 1) + (ThCnt + 1), 0, BMP1);

      if (ThCnt = 0) then
      begin
        DrawImageName(0, Rect(BMP1.Width * ((ThCnt + 1) * 1) + (ThCnt + 1), 0, SrcBMP.Width, SrcBMP.Height));
        Inc(ThCnt);
        ThFlag := True;
        BMP1.Assign(SrcBMP);
        ThIMG := IMG_Conv2.Create(BMP1.ReleaseHandle, 2, BMP1);
        ThIMG.OnTerminate := ThDone_PV;
        ThIMG.Start;
      end
      else if ThCnt = 1 then
      begin
        DrawImageName(1, Rect(BMP1.Width * ((ThCnt + 1) * 1) + (ThCnt + 1), 0, SrcBMP.Width, SrcBMP.Height));
        Inc(ThCnt);
      end;
    end;
end;
procedure TConvWndForm.ThDone2_PV(Sender: TObject);
begin
    //if not (Sender is IMG_Conv2) then Exit;
    if Sender is IMG_Conv2 then
      ThIMG2 := nil;

    if (ThIMG2 = nil) then
    begin
      ThFlag2 := False;
    end;
    if (not ThFlag2) and (Assigned(pvForm)) then
    begin
      pvForm.Image1.Picture.Bitmap.Canvas.Draw((BMP2.Width * ThCnt2) + ThCnt2, BMP2.Height + 1, BMP2);
      if (ThCnt2 = 0) then
      begin
        DrawImageName(2, Rect((BMP2.Width * ThCnt2) + ThCnt2, BMP2.Height + 1, SrcBMP.Width, SrcBMP.Height));
        Inc(ThCnt2);
        ThFlag2 := True;
        BMP2.Assign(SrcBMP);
        ThIMG2 := IMG_Conv2.Create(BMP2.ReleaseHandle, 5, BMP2);
        ThIMG2.OnTerminate := ThDone2_PV;
        ThIMG2.Start;
      end
      else if ThCnt2 = 1 then
      begin
        DrawImageName(5, Rect((BMP2.Width * ThCnt2) + ThCnt2, BMP2.Height + 1, SrcBMP.Width, SrcBMP.Height));
        Inc(ThCnt2);
        ThFlag2 := True;
        BMP2.Assign(SrcBMP);
        ThIMG2 := IMG_Conv2.Create(BMP2.ReleaseHandle, 0, BMP2);
        ThIMG2.OnTerminate := ThDone2_PV;
        ThIMG2.Start;
      end
      else if ThCnt2 = 2 then
      begin
        DrawImageName(3, Rect((BMP2.Width * ThCnt2) + ThCnt2, BMP2.Height + 1, SrcBMP.Width, SrcBMP.Height));
      end;

    end;
end;

procedure TConvWndForm.WMDPIChanged(var Message: TMessage);
begin
  if (Dx > 0) and (Dy > 0) then
  begin
    scaleX := Message.WParamLo / Dx;
    scaleY := Message.WParamHi / Dy;
    self.ScaleBy(OriW, CurW);
    self.ScaleBy(DoubleToInt(OriW * ScaleX), OriW);
    CurW := DoubleToInt(OriW * ScaleX);
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
  if Assigned(pvForm) then
    pvForm.Font := Font;
  Canvas.Font := Font;
  GetStrSize(Label2.Caption + ' ');
  Label2.Width := sWidth + 10;
  Label2.Height := sHeight + 2;
  cmbColor.Width := 150;
  cmbColor.ItemHeight := sHeight + 2;
  GetStrSize(btnPV.Caption + ' ');
  btnPV.Height := sHeight + 5;
  btnPV.Width := sWidth + 10;
  mw := MAX(Label2.Width, cmbColor.Width);
  mw := MAX(mw, btnPV.Width);
  btnPV.Width := mw;
  cmbColor.Width := mw;
  Image1.Width := ClientWidth - mw - 5;
  //ClientWidth := Image1.Width + mw +50;

  Label2.Left := Image1.Left + Image1.Width + 5;
  Label2.Top := 0;
  cmbColor.Left := Label2.Left;
  cmbColor.Top := Label2.Height + 1;
  btnPV.Left := Label2.Left;
  btnPV.Top := cmbColor.Top + cmbColor.Height + 2;
  Label1.Left := Label2.Left;;
  Label1.Top := btnPV.Top + btnPV.Height + 3;
  Label1.Width := ClientWidth - Image1.Width - 5;
  Label1.Height := ClientHeight - Label2.Height - cmbColor.Height - btnPV.Height - 4;
end;

end.
