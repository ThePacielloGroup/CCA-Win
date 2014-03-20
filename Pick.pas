unit Pick;
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, System.Math;

type
  TPickForm = class(TForm)
    Shape1: TShape;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private êÈåæ }
    procedure WMCaptureChanged(var Message: TMessage); message WM_CaptureChanged;
  public
    { Public êÈåæ }
  end;

var
  PickForm: TPickForm;

implementation

uses Main;

{$R *.dfm}

procedure TPickForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
    pt: TPoint;
    ArPTClr: array of TColor;
    i, t, p, dit: integer;
    function GetAverageColor: TColor;
    var
        R, G, B, i: integer;
        RGBColor : LongInt;
    begin
        R := 0;
        G := 0;
        B := 0;
        for i := 0 to Length(ArPTClr) - 1 do
        begin
            RGBColor := ArPTClr[i];
            R := R + ($000000FF and RGBColor);
            G := G + ($0000FF00 and RGBColor) shr 8;
            B := B + ($00FF0000 and RGBColor) shr 16;
        end;

        R := R div Length(ArPTClr);
        G := G div Length(ArPTClr);
        B := B div Length(ArPTClr);

        Result := StringToColor('$00' + IntToHex(B, 2) + IntToHex(G, 2) + IntToHex(R, 2));
    end;
begin
    if GetCapture <> Handle then
        SetCapture(Handle);

    GetCursorPos(pt);
    MoveWindow(Handle, pt.x - 101, pt.y - 101, 202, 202, TRUE);
    StretchBlt(Canvas.Handle, 1, 1, 200, 200, MainForm.SS_hdc, pt.x - 20, pt.y - 20, 40, 40, SRCCOPY);
    Canvas.Brush.Color := clBlack;


    if MainForm.SelFore then
        dit := MainForm.Dither1
    else
        dit := MainForm.Dither2;

    Canvas.FrameRect(Rect(100, 100, 100+(dit * 5)+2, 100+(dit * 5)+2));
    if dit = 1 then
    begin
        SetLength(ArPTClr, 1);
        ArPTClr[0] := Canvas.Pixels[101, 101];
    end
    else
    begin
        SetLength(ArPTClr, Sqr(dit));
        p := 0;
        for i := 0 to dit - 1 do
        begin
            for t := 0 to dit - 1 do
            begin
                ArPTClr[p] := Canvas.Pixels[101 + (i * 5), 101 + (t * 5)];
                Inc(p);
            end;
        end;
    end;
    if MainForm.SelFore then
        MainForm.FJColor.ActiveColor := GetAverageColor
    else
        MainForm.BColor.ActiveColor := GetAverageColor;


end;

procedure TPickForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbLeft then
    begin
        ReleaseCapture;
        ShowCursor(True);
        MainForm.CalcColor;
        Hide;
    end;
end;

procedure TPickForm.WMCaptureChanged(var Message: TMessage);
begin
    inherited;
    OnMouseDown(self, mbLeft, [], 0, 0);
end;

procedure TPickForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    pt: TPoint;
begin
    GetCursorPos(pt);
    if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
        OnMouseDown(self, mbLeft, [], 0, 0)
    else if Key = VK_UP then
        Dec(PT.Y)
    else if Key = VK_DOWN then
        Inc(PT.Y)
    else if Key = VK_LEFT then
        Dec(PT.X)
    else if Key = VK_RIGHT then
        Inc(PT.X);
    SetCursorPos(PT.X, PT.Y);
end;

procedure TPickForm.FormShow(Sender: TObject);
begin
    SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_SHOWWINDOW);
    ShowCursor(False);
end;

procedure TPickForm.FormCreate(Sender: TObject);
begin
    //Screen.Cursors[1] := LoadCursor(MainInstance, 'CROSS');
    //Self.Cursor := 1;

end;

procedure TPickForm.FormDestroy(Sender: TObject);
begin
    //Self.Cursor :=  crDefault;
    ShowCursor(True);
end;

end.
