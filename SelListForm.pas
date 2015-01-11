unit SelListForm;
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.Types,
  Vcl.Dialogs, StdCtrls, ComCtrls, ExtCtrls, JPEG, iniFiles, ShlObj , AccCTRLs,
  TransCheckBox, ComObj;

type
  TBMPs = record
    Title: String;
    hWindow: THandle;
    N_BMP, P_BMP, D_BMP, T_BMP, G_BMP, I_BMP, C_BMP: TBitmap;
  end;
  PWnd = ^TWnd;
  TWnd = record
    Title: String;
    hWindow: THandle;
  end;
  TfrmSelList = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    SaveDialog1: TSaveDialog;
    ScrollBox2: TScrollBox;
    gbSimulation: TAccGroupBox;
    btnSave: TAccButton;
    btnPreview: TAccButton;
    ComboBox2: TAccComboBox;
    gbWndList: TAccGroupBox;
    ComboBox1: TAccComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private êÈåæ }

    function ScreenShot:Boolean;
    procedure ShowProg(Mode: integer);
  public
    { Public êÈåæ }
    SPath:string;
    FBMPs: TBMPs;
  end;

var
  frmSelList: TfrmSelList;
  WList: TList;
implementation

uses Main, ProgressForm;

{$R *.dfm}

function EnumWnd(hWindow:HWND; lPar:LPARAM):Boolean; stdcall;
var
    Buf, s: array [0..255] of Char;
    FWnd: PWnd;
    i: Integer;
    TA: Boolean;
begin
    if IsWindowVisible(hWindow) then
    begin
        TA := False;
        i := GetWindowText(hWindow, Buf, 255);
        New(FWnd);
        if i <> 0 then
        begin
            StrLCopy(s, buf, i);

            FWnd.Title := s;
        end
        else
            FWnd.Title := '';
        FWnd.hWindow := hWindow;

        i := GetClassName(hWindow, Buf, 255);
        if i <> 0 then
        begin
            StrLCopy(s, buf, i);
            if FWnd.Title = '' then
                FWnd.Title := s;// + '(ClassName)';
            if (LowerCase(s) <> 'progman') and (LowerCase(s) <> 'tapplication') then
            begin
                if (hWindow = MainForm.Handle) or (Application.Handle = hWindow) then
                begin
                    TA := True;
                end;
            end
            else
            TA := True;
        end;

        if (not TA) then WList.Add(FWnd)
        else Dispose(FWnd);

    end;
    Result := True;

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

procedure TfrmSelList.FormCreate(Sender: TObject);
var
    i: Integer;
    ListI: TListItem;
    DWnd: HWND;
    FWnd: PWnd;
    ini: TMemIniFile;
begin
    WList := TList.Create;
    DWnd := GetDesktopWindow;
    SPath := IncludeTrailingPathDelimiter(GetMyDocPath) + 'CCA.ini';
    if DWnd <> 0 then
    begin
        New(FWnd);
        FWnd.Title := 'Desktop';
        FWnd.hWindow := DWnd;
        WList.Add(FWnd);
    end;
    EnumWindows(@EnumWnd, LPARAM(0));
    if WList.Count > 0 then
    begin
        for i := 0 to WList.Count - 1 do
        begin
        		ComboBox1.Items.Add(PWnd(WList.Items[i])^.Title + '(' + IntToHEX(PWnd(WList.Items[i])^.hWindow, 2) + ')');

        end;
        ComboBox1.ItemIndex := 0;
    end
    else
    begin
        btnSave.Enabled := False;
        btnPreview.Enabled := False;
    end;
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        //edtC_Quality.Value := ini.ReadInteger('JPEG', 'Compression', 75);
        //chkSmooth.Checked := ini.ReadBool('JPEG', 'Smooth', False);
        Left := ini.ReadInteger('Window', 'SelList_Left', (Screen.WorkAreaWidth div 2) - (Width div 2));
        Top := ini.ReadInteger('Window', 'SelList_Top', (Screen.WorkAreaHeight div 2) - (Height div 2));
        Width := ini.ReadInteger('Window', 'SelList_Width', 800);
        Height := ini.ReadInteger('Window', 'SelList_Height', 600);
    finally
        ini.Free;
    end;
    if Width < Constraints.MinWidth then
    	Width := Constraints.MinWidth;
    if Height < Constraints.MinHeight then
    	Height := Constraints.MinHeight;

    Caption := MainForm.GetTranslation('wnd_list', 'Window list');
    gbWndList.Caption := MainForm.GetTranslation('sel_wnd', 'Select window');
    gbSimulation.Caption := MainForm.GetTranslation('simulation', 'Simulation');
    //gbJPEG.Caption := MainForm.GetTranslation('jpeg_options', 'JPEG options');
    btnSave.Caption := MainForm.GetTranslation('save', '&Save');
    btnPreview.Caption := MainForm.GetTranslation('preview', '&Preview');
    //lblC_Quality.Caption := MainForm.GetTranslation('compression_quality', 'Compression Quality:');
    //chkSmooth.Caption := MainForm.GetTranslation('smoothing', 'S&moothing');
    //btnClose.Caption := MainForm.GetTranslation('close', '&Close');

    ComboBox2.Items.Add(MainForm.GetTranslation('protanopia', 'Protanopia'));
    ComboBox2.Items.Add(MainForm.GetTranslation('deuteranopia', 'Deuteranopia'));
    ComboBox2.Items.Add(MainForm.GetTranslation('tritanopia', 'Tritanopia'));
    ComboBox2.Items.Add(MainForm.GetTranslation('grayscale', 'Grayscale'));
    ComboBox2.Items.Add(MainForm.GetTranslation('invert', 'Invert'));
    ComboBox2.Items.Add(MainForm.GetTranslation('cataracts', 'Cataracts'));
    ComboBox2.Items.Add(MainForm.GetTranslation('normal', 'Normal'));
    ComboBox2.ItemIndex := 0;

end;

procedure TfrmSelList.FormClose(Sender: TObject; var Action: TCloseAction);
var
    i: integer;
    ini: TMemIniFile;
begin
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        //ini.WriteInteger('JPEG', 'Compression', edtC_Quality.AsInteger);
        //ini.WriteBool('JPEG', 'Smooth', chkSmooth.Checked);
        ini.WriteInteger('Window', 'SelList_Left', Left);
        ini.WriteInteger('Window', 'SelList_Top', Top);
        ini.WriteInteger('Window', 'SelList_Width', Width);
        ini.WriteInteger('Window', 'SelList_Height', Height);
        ini.UpdateFile;
    finally
        ini.Free;
    end;
    for i := 0 to WList.Count - 1 do
    begin
        DisPose(PWnd(WList.Items[i]));
    end;
    if Assigned(FBMPs.P_BMP) then
        FreeAndNil(FBMPs.P_BMP);
    if Assigned(FBMPs.D_BMP) then
        FreeAndNil(FBMPs.D_BMP);
    if Assigned(FBMPs.T_BMP) then
        FreeAndNil(FBMPs.T_BMP);
    if Assigned(FBMPs.I_BMP) then
        FreeAndNil(FBMPs.I_BMP);
    if Assigned(FBMPs.G_BMP) then
        FreeAndNil(FBMPs.G_BMP);
    if Assigned(FBMPs.C_BMP) then
        FreeAndNil(FBMPs.C_BMP);
    if Assigned(FBMPs.N_BMP) then
        FreeAndNil(FBMPs.N_BMP);
    WList.Free;
end;

procedure TfrmSelList.btnPreviewClick(Sender: TObject);
begin
    if (FBMPs.hWindow <> THandle(PWnd(WList.Items[ComboBox1.ItemIndex])^.hWindow)) then
    begin
        if Assigned(FBMPs.P_BMP) then
            FreeAndNil(FBMPs.P_BMP);
        if Assigned(FBMPs.D_BMP) then
            FreeAndNil(FBMPs.D_BMP);
        if Assigned(FBMPs.T_BMP) then
            FreeAndNil(FBMPs.T_BMP);
        if Assigned(FBMPs.I_BMP) then
            FreeAndNil(FBMPs.I_BMP);
        if Assigned(FBMPs.G_BMP) then
            FreeAndNil(FBMPs.G_BMP);
        if Assigned(FBMPs.C_BMP) then
            FreeAndNil(FBMPs.C_BMP);
        if Assigned(FBMPs.N_BMP) then
            FreeAndNil(FBMPs.N_BMP);
        FBMPs.Title := PWnd(WList.Items[ComboBox1.ItemIndex])^.Title;
        FBMPs.hWindow := PWnd(WList.Items[ComboBox1.ItemIndex])^.hWindow;
        if not ScreenShot then exit;
        
    end
    else
    begin

        if not Assigned(FBMPs.N_BMP) then
            if not ScreenShot then exit;

    end;
    if ComboBox2.ItemIndex = 0 then
    begin
        if not Assigned(FBMPs.P_BMP) then
            ShowProg(1)
        else
            Image1.Picture.Assign(FBMPs.P_BMP);
    end
    else if ComboBox2.ItemIndex = 1 then
    begin
        if not Assigned(FBMPs.D_BMP) then
            ShowProg(2)
        else
            Image1.Picture.Assign(FBMPs.D_BMP);
    end
    else if ComboBox2.ItemIndex = 2 then
    begin
        if not Assigned(FBMPs.T_BMP) then
            ShowProg(3)
        else
            Image1.Picture.Assign(FBMPs.T_BMP);
    end
    else if ComboBox2.ItemIndex = 3 then
    begin
        if not Assigned(FBMPs.G_BMP) then
            ShowProg(0)
        else
            Image1.Picture.Assign(FBMPs.G_BMP);
    end
    else if ComboBox2.ItemIndex = 4 then
    begin
        if not Assigned(FBMPs.I_BMP) then
            ShowProg(4)
        else
            Image1.Picture.Assign(FBMPs.I_BMP);
    end
    else if ComboBox2.ItemIndex = 5 then
    begin
        if not Assigned(FBMPs.C_BMP) then
            ShowProg(5)
        else
            Image1.Picture.Assign(FBMPs.C_BMP);
    end
    else
    begin
        Image1.Picture.Assign(FBMPs.N_BMP);
        btnSave.Enabled := True;
    end;
    {if cmbColor.ItemIndex = 0 then
        Mode := 2
    else if cmbColor.ItemIndex = 1 then
        Mode := 3
    else if cmbColor.ItemIndex = 2 then
        Mode := 4
    else if cmbColor.ItemIndex = 3 then
        Mode := 1
    else if cmbColor.ItemIndex = 4 then
        Mode := 5
    else if cmbColor.ItemIndex = 5 then
        Mode := 6
    else
        Mode := 0;
    if (cmbColor.ItemIndex = 0) then
    begin
        if not Assigned(FBMPs.P_BMP) then
            ShowProg(Mode - 1)
        else
            Image1.Picture.Assign(FBMPs.P_BMP);
    end
    else if (cmbColor.ItemIndex = 1) then
    begin
        if not Assigned(FBMPs.D_BMP) then
            ShowProg(Mode - 1)
        else
            Image1.Picture.Assign(FBMPs.D_BMP);
    end
    else if (cmbColor.ItemIndex = 2) then
    begin
        if not Assigned(FBMPs.T_BMP) then
            ShowProg(Mode - 1)
        else
            Image1.Picture.Assign(FBMPs.T_BMP);
    end
    else if (cmbColor.ItemIndex = 3) then
    begin
        if not Assigned(FBMPs.G_BMP) then
            ShowProg(Mode - 1)
        else
            Image1.Picture.Assign(FBMPs.G_BMP);
    end
    else if (cmbColor.ItemIndex = 4) then
    begin
        if not Assigned(FBMPs.I_BMP) then
            ShowProg(Mode - 1)
        else
            Image1.Picture.Assign(FBMPs.I_BMP);
    end
    else if (cmbColor.ItemIndex = 5) then
    begin
        if not Assigned(FBMPs.C_BMP) then
            ShowProg(Mode - 1)
        else
            Image1.Picture.Assign(FBMPs.C_BMP);
    end
    else
    begin
        Image1.Picture.Assign(FBMPs.N_BMP);
        btnSave.Enabled := True;
    end;}
end;

function TfrmSelList.ScreenShot: boolean;
var
    DC: HDC;
    RC: TRect;
    PT: TPoint;
    c:Cardinal;
    ires: integer;
begin
    Result := False;
    try
        if GetWindowLong(FBMPs.hWindow, GWL_STYLE) = 0 then
        begin
            Showmessage(MainForm.GetTranslation('wnd_notfound', 'The selected window cannot be found.'));
            ComboBox1.DeleteSelected;
            ComboBox1.ItemIndex := 0;
            //ListView1.DeleteSelected;
            //ListView1.ItemIndex := 0;
            Exit;
        end;
        DC := 0;
        if LowerCase(FBMPs.Title) = 'desktop' then
        begin
            if GetWindowRect(FBMPs.hWindow, RC) then
            begin
                Hide;
                Application.Minimize;
                Keybd_event(VK_LWIN,   0, 0, 0);
                Keybd_event(Byte('D'), 0, 0, 0);
                Keybd_event(Byte('D'), 0, KEYEVENTF_KEYUP, 0);
                Keybd_event(VK_LWIN,   0, KEYEVENTF_KEYUP, 0);
                c := GetTickCount;
                while True do
                begin
                    Application.ProcessMessages;
                    if GetTickCount - c > 2000 then Break;
                end;
                DC := GetDC(FBMPs.hWindow);
                if DC <> 0 then
                begin
                    try
                        PT := ScreenToClient(Point(RC.Right, RC.Bottom));
                        FBMPs.N_BMP := TBitmap.Create;
                        FBMPs.N_BMP.Width := RC.right-RC.left;
                        FBMPs.N_BMP.Height := RC.bottom-RC.top;
                        PT := ScreenToClient(Point(RC.Left, RC.Top));
                        BitBlt(FBMPs.N_BMP.Canvas.Handle, 0, 0, FBMPs.N_BMP.Width, FBMPs.N_BMP.Height, DC, 0, 0, SRCCOPY);
                    finally
                        ReleaseDC(FBMPs.hWindow, DC);
                    end;
                end
                else
                begin
                    Application.Restore;
                    Show;
                    Showmessage(MainForm.GetTranslation('fail_getdc', Fail_GetDC));
                    ComboBox1.DeleteSelected;
            				ComboBox1.ItemIndex := 0;
                end;
                Keybd_event(VK_LWIN,   0, 0, 0);
                Keybd_event(Byte('D'), 0, 0, 0);
                Keybd_event(Byte('D'), 0, KEYEVENTF_KEYUP, 0);
                Keybd_event(VK_LWIN,   0, KEYEVENTF_KEYUP, 0);
            end;
        end
        else
        begin
            iRes := GetWindowLong(FBMPs.hWindow, GWL_STYLE);
            if (iRes and WS_MINIMIZE) <> 0 then
            begin
                ShowWindow(FBMPs.hWindow, SW_RESTORE);
            end
            else
                ShowWindow(FBMPs.hWindow, SW_SHOWNA);
            MainForm.SetAbsoluteForegroundWindow(FBMPs.hWindow);
            Hide;
            Application.Minimize;
            c := GetTickCount;
            while True do
            begin
                Application.ProcessMessages;
                if GetTickCount - c > 1000 then Break;
            end;
            if GetWindowRect(FBMPs.hWindow, RC) then
            begin
                if (RC.Right > 0) and (RC.Bottom > 0) then
                begin

                    DC := GetWindowDC(FBMPs.hWindow);
                    if DC <> 0 then
                    begin
                        try
                            PT := ScreenToClient(Point(RC.Right, RC.Bottom));
                            FBMPs.N_BMP := TBitmap.Create;
                            FBMPs.N_BMP.Width := RC.right-RC.left;
                            FBMPs.N_BMP.Height := RC.bottom-RC.top;
                            PT := ScreenToClient(Point(RC.Left, RC.Top));
                            BitBlt(FBMPs.N_BMP.Canvas.Handle, 0, 0, FBMPs.N_BMP.Width, FBMPs.N_BMP.Height, DC, 0, 0, SRCCOPY);
                        finally
                            ReleaseDC(FBMPs.hWindow, DC);
                        end;
                    end
                    else
                    begin
                        Application.Restore;
                        Show;
                        Showmessage(MainForm.GetTranslation('fail_getdc', Fail_GetDC));
                        ComboBox1.DeleteSelected;
            						ComboBox1.ItemIndex := 0;
                    end;
                end
                else
                begin
                    Application.Restore;
                    Show;
                    ShowMessage(MainForm.GetTranslation('fail_wndsize', Fail_WndSize));
                    ComboBox1.DeleteSelected;
            				ComboBox1.ItemIndex := 0;
                end;
            end;
        end;
        Application.Restore;
        Show;
        MainForm.SetAbsoluteForegroundWindow(Handle);
        if DC <> 0 then Result := True;
    except
        on E:Exception do
            ShowMessage(E.Message);
    end;
end;

procedure TfrmSelList.ShowProg(Mode: integer);
var
    frmProg: TfrmProgress;
begin
    frmProg := TfrmProgress.Create(self);
    try
        frmProg.Mode := Mode;
        frmProg.BMP.Assign(FBMPs.N_BMP);

        if frmProg.ShowModal = mrOK then
        begin
            Inc(Mode);
            if Mode = 1 then
            begin
                if not Assigned(FBMPs.G_BMP) then
                    FBMPs.G_BMP := TBitMap.Create;
                FBMPs.G_BMP.Handle := frmProg.BMP.ReleaseHandle;
                Image1.Picture.Assign(FBMPs.G_BMP);
            end
            else if Mode = 2 then
            begin
                if not Assigned(FBMPs.P_BMP) then
                    FBMPs.P_BMP := TBitMap.Create;
                FBMPs.P_BMP.Handle := frmProg.BMP.ReleaseHandle;
                Image1.Picture.Assign(FBMPs.P_BMP);
            end
            else if Mode = 3 then
            begin
                if not Assigned(FBMPs.D_BMP) then
                    FBMPs.D_BMP := TBitMap.Create;
                FBMPs.D_BMP.Handle := frmProg.BMP.ReleaseHandle;
                Image1.Picture.Assign(FBMPs.D_BMP);
            end
            else if Mode = 4 then
            begin
                if not Assigned(FBMPs.T_BMP) then
                    FBMPs.T_BMP := TBitMap.Create;
                FBMPs.T_BMP.Handle := frmProg.BMP.ReleaseHandle;
                Image1.Picture.Assign(FBMPs.T_BMP);
            end
            else if Mode = 5 then
            begin
                if not Assigned(FBMPs.I_BMP) then
                    FBMPs.I_BMP := TBitMap.Create;
                FBMPs.I_BMP.Handle := frmProg.BMP.ReleaseHandle;
                Image1.Picture.Assign(FBMPs.I_BMP);
            end
            else if Mode = 6 then
            begin
                if not Assigned(FBMPs.C_BMP) then
                    FBMPs.C_BMP := TBitMap.Create;
                FBMPs.C_BMP.Handle := frmProg.BMP.ReleaseHandle;
                Image1.Picture.Assign(FBMPs.C_BMP);
            end;
            btnSave.Enabled := True;
        end;
    finally
        frmProg.BMP.Free;
        frmProg.Free;
    end;
end;

procedure TfrmSelList.btnCloseClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmSelList.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
    if Selected then
    begin
        if (FBMPs.Title = PWnd(WList.Items[ComboBox1.ItemIndex])^.Title) and (FBMPs.hWindow = THandle(PWnd(WList.Items[ComboBox1.ItemIndex])^.hWindow)) then
        begin
            if (Assigned(FBMPs.N_BMP)) or (Assigned(FBMPs.P_BMP)) or (Assigned(FBMPs.D_BMP)) or (Assigned(FBMPs.T_BMP)) or
                (Assigned(FBMPs.G_BMP)) or (Assigned(FBMPs.I_BMP)) then
                btnSave.Enabled := True
            else
                btnSave.Enabled := False;
        end
        else
            btnSave.Enabled := False;
    end;
end;

procedure TfrmSelList.btnSaveClick(Sender: TObject);
var
    FN: String;
    JPG: TJPEGImage;
begin
    if SaveDialog1.Execute then
    begin
        FN := SaveDialog1.FileName;
        if ExtractFileExt(FN) = '' then
        begin
            if SaveDialog1.FilterIndex = 1 then
                FN := FN + '.bmp'
            else
                FN := FN + '.jpg';
        end;
        if SaveDialog1.FilterIndex = 1 then
            Image1.Picture.Bitmap.SaveToFile(FN)
        else
        begin
            JPG := TJPEGImage.Create;
            try
                JPG.Smoothing := True;//chkSmooth.Checked;
                JPG.Assign(Image1.Picture.Bitmap);
                JPG.CompressionQuality := 75;//edtC_Quality.AsInteger;

                JPG.SaveToFile(FN);
                Application.ProcessMessages;
            finally
                JPG.Free;
            end;
        end;
    end;
end;

end.
