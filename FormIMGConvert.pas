unit FormIMGConvert;
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.Math,
  Dialogs, {MSGSnatchers, OleDnD,} ExtCtrls, StdCtrls, JPEG, iniFiles, ComObj, ShlObj, AccCTRLs, Funcs;


type
  TBMPs = record
    IMG: string;
    N_BMP, P_BMP, D_BMP, T_BMP, G_BMP, I_BMP, C_BMP: TBitmap;
  end;
  TfrmIMGConvert = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    //FileDropTarget1: TFileDropTarget;
    ScrollBox2: TScrollBox;
    gbSimulation: TGroupBox;
    btnSave: TButton;
    btnPreview: TButton;
    gbSelIMG: TGroupBox;
    edtFileName: TEdit;
    btnBrowse: TButton;
    cmbSimu: TAccComboBox;
    procedure btnCloseClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    {procedure FileDropTarget1FileDrop(aSender: TObject;
      var aContext: TDragContext);  }
    procedure btnSaveClick(Sender: TObject);
    procedure edtFileNameKeyPress(Sender: TObject; var Key: Char);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private 宣言 }
    FBMPs: TBMPs;

    procedure LoadNormalImage;
    procedure ShowProg(Mode: integer);

    procedure WMDPIChanged(var Message: TMessage); message WM_DPICHANGED;
  public
    { Public 宣言 }
    ScaleY, ScaleX, Dx, Dy: double;
    SPath: string;
    DefFont: integer;
    procedure ResizeCtrls;
  end;

var
  frmIMGConvert: TfrmIMGConvert;

implementation

uses ProgressForm, Main;

{$R *.dfm}

procedure TfrmIMGConvert.btnCloseClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmIMGConvert.btnBrowseClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
    begin
        edtFileName.Text := OpenDialog1.FileName;
        FBMPs.IMG := OpenDialog1.FileName;
        LoadNormalImage;
    end;
end;

procedure TfrmIMGConvert.LoadNormalImage;
var
    JPG: TJPEGImage;
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
    if Assigned(FBMPs.N_BMP) then
        FreeAndNil(FBMPs.N_BMP);
    if Assigned(FBMPs.C_BMP) then
        FreeAndNil(FBMPs.C_BMP);
    Image1.Picture.LoadFromFile(FBMPs.IMG);
    btnSave.Enabled := True;
    btnPreview.Enabled := True;
    cmbSImu.ItemIndex := 6;
    if not Assigned(FBMPs.N_BMP) then
        FBMPs.N_BMP := TBitMap.Create;
    if LowerCase(ExtractFileExt(FBMPs.IMG)) = '.jpg' then
    begin
        JPG := TJPEGImage.Create;
        try
            JPG.LoadFromFile(FBMPs.IMG);
            FBMPs.N_BMP.Assign(JPG);
        finally
            JPG.Free;
        end;
    end
    else
        FBMPs.N_BMP.LoadFromFile(FBMPs.IMG);
end;

{procedure TfrmIMGConvert.FileDropTarget1FileDrop(aSender: TObject;
  var aContext: TDragContext);
var
    i: integer;
    d: string;
begin
    if FileDropTarget1.DroppedFiles.Count > 0 then
    begin
        for i := 0 to FileDropTarget1.DroppedFiles.Count - 1 do
        begin
            d := LowerCase(ExtractFileExt(FileDropTarget1.DroppedFiles[i]));
            if ((d = '.jpg') or (d = '.bmp')) and (FileExists(FileDropTarget1.DroppedFiles[i])) then
            begin
                edtFileName.Text := FileDropTarget1.DroppedFiles[i];
                FBMPs.IMG := FileDropTarget1.DroppedFiles[i];
                LoadNormalImage;
                Break;
            end;
        end;
    end;
end;  }

procedure TfrmIMGConvert.btnSaveClick(Sender: TObject);
var
    JPG: TJPEGImage;
    FN: string;
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

procedure TfrmIMGConvert.edtFileNameKeyPress(Sender: TObject;
  var Key: Char);
var
    d: string;
begin
    if Key = #$0D then
    begin
        key := #0;
        d := LowerCase(ExtractFileExt(edtFileName.Text));
        if ((d = '.jpg') or (d = '.bmp')) and (FileExists(edtFileName.Text)) then
        begin
            FBMPs.IMG := edtFileName.Text;
            LoadNormalImage;
        end;
    end;
end;

procedure TfrmIMGConvert.ShowProg(Mode: integer);
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

procedure TfrmIMGConvert.btnPreviewClick(Sender: TObject);
begin
    if cmbSimu.ItemIndex = 0 then
    begin
        if not Assigned(FBMPs.P_BMP) then
            ShowProg(1)
        else
            Image1.Picture.Assign(FBMPs.P_BMP);
    end
    else if cmbSimu.ItemIndex = 1 then
    begin
        if not Assigned(FBMPs.D_BMP) then
            ShowProg(2)
        else
            Image1.Picture.Assign(FBMPs.D_BMP);
    end
    else if cmbSimu.ItemIndex = 2 then
    begin
        if not Assigned(FBMPs.T_BMP) then
            ShowProg(3)
        else
            Image1.Picture.Assign(FBMPs.T_BMP);
    end
    else if cmbSimu.ItemIndex = 3 then
    begin
        if not Assigned(FBMPs.G_BMP) then
            ShowProg(0)
        else
            Image1.Picture.Assign(FBMPs.G_BMP);
    end
    else if cmbSimu.ItemIndex = 4 then
    begin
        if not Assigned(FBMPs.I_BMP) then
            ShowProg(4)
        else
            Image1.Picture.Assign(FBMPs.I_BMP);
    end
    else if cmbSimu.ItemIndex = 5 then
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
    {if (cmbColor.ItemIndex = 0) then
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
    else
    begin
        Image1.Picture.Assign(FBMPs.N_BMP);
        btnSave.Enabled := True;
    end;}
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
    raise Exception.Create('仮想フォルダのため取得できません');
  end;
  Result := StrPas(Buffer);
end;

procedure TfrmIMGConvert.FormCreate(Sender: TObject);
var
    ini: TMemIniFile;
begin

    SPath := IncludeTrailingPathDelimiter(GetMyDocPath) + 'CCA.ini';
    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        //edtC_Quality.Value := ini.ReadInteger('JPEG', 'Compression', 75);
        //chkSmooth.Checked := ini.ReadBool('JPEG', 'Smooth', False);
        Left := ini.ReadInteger('Window', 'SelImg_Left', (Screen.WorkAreaWidth div 2) - (Width div 2));
        Top := ini.ReadInteger('Window', 'SelImg_Top', (Screen.WorkAreaHeight div 2) - (Height div 2));
        Width := ini.ReadInteger('Window', 'SelImg_Width', 800);
        Height := ini.ReadInteger('Window', 'SelImg_Height', 600);
    finally
        ini.Free;
    end;
    Caption := MainForm.GetTranslation('wnd_imgsel', 'Image file convert');
    gbSelIMG.Caption := MainForm.GetTranslation('sel_img', 'Select image file');
    btnBrowse.Caption := MainForm.GetTranslation('browse', '&Browse');
    gbSimulation.Caption := MainForm.GetTranslation('simulation', 'Simulation');
    //gbJPEG.Caption := MainForm.GetTranslation('jpeg_options', 'JPEG options');
    btnSave.Caption := MainForm.GetTranslation('save', '&Save');
    btnPreview.Caption := MainForm.GetTranslation('preview', '&Preview');
    //lblC_Quality.Caption := MainForm.GetTranslation('compression_quality', 'Compression Quality:');
    //chkSmooth.Caption := MainForm.GetTranslation('smoothing', 'S&moothing');
    //btnClose.Caption := MainForm.GetTranslation('close', '&Close');
    cmbSimu.Items.Add(MainForm.GetTranslation('protanopia', 'Protanopia'));
    cmbSimu.Items.Add(MainForm.GetTranslation('deuteranopia', 'Deuteranopia'));
    cmbSimu.Items.Add(MainForm.GetTranslation('tritanopia', 'Tritanopia'));
    cmbSimu.Items.Add(MainForm.GetTranslation('grayscale', 'Grayscale'));
    cmbSimu.Items.Add(MainForm.GetTranslation('invert', 'Invert'));
    cmbSimu.Items.Add(MainForm.GetTranslation('cataracts', 'Cataracts'));
    cmbSimu.Items.Add(MainForm.GetTranslation('normal', 'Nromal'));
    cmbSimu.ItemIndex := 0;
    //ResizeCtrls;
end;

procedure TfrmIMGConvert.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    ini: TMemIniFile;
begin
    if Assigned(FBMPs.P_BMP) then
    begin
        FBMPs.P_BMP.FreeImage;
        FreeAndNil(FBMPs.P_BMP);
    end;
    if Assigned(FBMPs.D_BMP) then
    begin
        FBMPs.D_BMP.FreeImage;
        FreeAndNil(FBMPs.D_BMP);
    end;
    if Assigned(FBMPs.T_BMP) then
    begin
        FBMPs.T_BMP.FreeImage;
        FreeAndNil(FBMPs.T_BMP);
    end;
    if Assigned(FBMPs.I_BMP) then
    begin
        FBMPs.I_BMP.FreeImage;
        FreeAndNil(FBMPs.I_BMP);
    end;
    if Assigned(FBMPs.G_BMP) then
    begin
        FBMPs.G_BMP.FreeImage;
        FreeAndNil(FBMPs.G_BMP);
    end;
    if Assigned(FBMPs.N_BMP) then
    begin
        FBMPs.N_BMP.FreeImage;
        FreeAndNil(FBMPs.N_BMP);
    end;
    if Assigned(FBMPs.C_BMP) then
    begin
        FBMPs.C_BMP.FreeImage;
        FreeAndNil(FBMPs.C_BMP);
    end;

    ini := TMemIniFile.Create(SPath, TEncoding.Unicode);
    try
        //ini.WriteInteger('JPEG', 'Compression', edtC_Quality.AsInteger);
        //ini.WriteBool('JPEG', 'Smooth', chkSmooth.Checked);
        ini.WriteInteger('Window', 'SelImg_Left', Left);
        ini.WriteInteger('Window', 'SelImg_Top', Top);
        ini.WriteInteger('Window', 'SelImg_Width', Width);
        ini.WriteInteger('Window', 'SelImg_Height', Height);
        ini.UpdateFile;
    finally
        ini.Free;
    end;
end;

function DoubleToInt(d: double): integer;
begin
  SetRoundMode(rmUP);
  Result := Trunc(SimpleRoundTo(d));
end;

procedure TfrmIMGConvert.WMDPIChanged(var Message: TMessage);
begin
  if (Dx > 0) and (Dy > 0) then
  begin
    scaleX := Message.WParamLo / Dx;
    scaleY := Message.WParamHi / Dy;
    ResizeCtrls;
  end;
end;

procedure TfrmIMGConvert.ResizeCtrls;
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
  GetStrSize('C:\Dummy');
  edtFileName.Height := sHeight + 2;
  GetStrSize(btnBrowse.Caption + ' ');
  btnBrowse.Height := edtFilename.Height;
  btnBrowse.Width := sWidth + 5;
  gbSelImg.Height := DoubleToInt(sHeight * 1.3) + edtFilename.Height + 5;
  gbSelImg.Width := edtFilename.Width + btnBrowse.Width + 9;
  cmbSimu.Width := DoubleToInt(150 * ScaleX);
  cmbSimu.ItemHeight := sHeight;
  GetStrSize(btnPreview.Caption + ' ');
  mw := swidth;
  GetStrSize(btnSave.Caption + ' ');
  mw := MAX(mw, sWidth);
  btnPreview.Height := btnBrowse.Height;
  btnPreview.Width := mw;
  btnSave.Height := btnBrowse.Height;
  btnSave.Width := mw;
  gbSimulation.Height := gbSelImg.Height;
  gbSimulation.Width := cmbSimu.Width + btnSave.Width + btnPreview.Width + 12;

  gbSelImg.Top := 0;
  gbSimulation.Top := 0;
  Scrollbox2.Height := gbSelImg.Height + 8;
  edtFilename.Top := sHeight;
  edtFileName.Left := 3;
  btnBrowse.Top := sHeight;
  btnBrowse.Left := edtFilename.Width + 6;

  gbSimulation.Left := gbSelImg.Left + gbSelImg.Width + 3;
  cmbSimu.Top := sHeight;
  cmbSimu.Left := 3;
  btnSave.Top := sHeight;
  btnSave.Left := cmbSimu.Width + 6;
  btnPreview.Top := sHeight;
  btnPreview.Left := btnSave.Left + btnSave.Width + 3;
  Constraints.MinWidth := gbSelIMG.Width + gbSimulation.Width + 50;
end;

end.
