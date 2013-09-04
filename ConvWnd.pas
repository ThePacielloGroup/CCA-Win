unit ConvWnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Th_IMGConv;

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
  private
    { Private êÈåæ }
    ThIMG: IMG_Conv2;
    ThFlag: Boolean;
    Xx, Yy: Integer;
    iMode: Integer;
    hRgn1, hRgn2, hRgn: LongWord;
    procedure OnMove(var msg: TWMMove); message WM_MOVE;
    //procedure OnMoving(var msg: TWMMoving); message WM_MOVING;
    procedure ThDone(Sender: TObject);
    procedure WMExitSizeMove(var msg:TMessage);message WM_EXITSIZEMOVE;
    {procedure AppDeActive(Sender: TObject);
    procedure AppActive(Sender: TObject);}

    Procedure SetRGN(Create: Boolean = True);
  public
    { Public êÈåæ }
    Exec, MoveFlag: Boolean;
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
procedure TConvWndForm.ExecCute(Mode: Integer);
begin
    Exec := True;
    iMode := Mode;
end;

Procedure TConvWndForm.SetRGN(Create: Boolean = True);
var
    CapH: Integer;
begin
    if Create then
    begin
        CapH := GetSystemMetrics(SM_CYCAPTION);
        hRgn := CreateRectRgn(0, 0, 1, 1);
        hRgn1 := CreateRectRgn(0, 0, Width, Height);
        hRgn2 := CreateRectRgn(3, 4 + CapH, 303, 304 + CapH);
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

procedure TConvWndForm.WMExitSizeMove(var msg:TMessage);
var
    SC_hdc: HDC;
    iw, ih, Mode: Integer;
begin

    MoveFlag := False;

    BitBlt(BMP.Canvas.Handle, 0, 0, 300, 300, MainForm.SS_hdc, Xx, Yy, SRCCOPY);
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
begin
    if ThIMG <> nil then ThIMG.Terminate;
    BMP.FreeImage;
    BMP.Free;
    DeleteObject(hRgn);
    DeleteObject(hRgn1);
    DeleteObject(hRgn2);
    Action := caFree;
    ConvWndForm := nil;
end;

procedure TConvWndForm.FormCreate(Sender: TObject);
begin
    DoubleBuffered := True;
    MoveFlag := False;
    BMP := TBitmap.Create;
    BMP.Width := 300;
    BMP.Height := 300;
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
    Label1.Caption := MainForm.GetTranslation('wnd_move', WND_Move)
end;

procedure TConvWndForm.CreateParams(var Params: TCreateParams);
begin
    inherited CreateParams(Params);
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
    Params.WndParent := 0;
end;

procedure TConvWndForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    TP: TPoint;
begin
    if (Key = VK_ESCAPE) then
        Close;
end;

procedure TConvWndForm.FormShow(Sender: TObject);
var
    SC_hdc: HDC;
    iw, ih, Mode: Integer;
begin
    SetRGN;
    if MainForm.SS_hdc <> 0 then
        DeleteDC(MainForm.SS_hdc);
    if MainForm.SS_bmp <> 0 then
        DeleteObject(MainForm.SS_bmp);
    SC_hdc := GetDC(0);
    MainForm.SS_hdc := CreateCompatibleDC(SC_hdc);

    iw := GetDeviceCaps (SC_hdc, HORZRES);
    ih := GetDeviceCaps (SC_hdc, VERTRES);
    MainForm.SS_bmp := CreateCompatibleBitmap(SC_hdc, iw, ih);
    SelectObject(MainForm.SS_hdc, MainForm.SS_bmp);
    BitBlt(MainForm.SS_hdc, 0, 0, iw, ih, SC_hdc, 0, 0, SRCCOPY);
    ReleaseDC(0, SC_hdc);
    MoveFlag := False;
end;

procedure TConvWndForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #77) or (key = #109) then
    begin
        SendMessage (Handle, WM_SYSCOMMAND, SC_MOVE, 0);
    end;
end;

procedure TConvWndForm.cmbColorChange(Sender: TObject);
var
    Mode: integer;
begin
    MoveFlag := False;
    BitBlt(BMP.Canvas.Handle, 0, 0, 300, 300, MainForm.SS_hdc, Xx, Yy, SRCCOPY);
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

end.
