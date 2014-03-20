unit ProgressForm;
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
  Dialogs, StdCtrls, ComCtrls, th_IMGConv, ShellAPI;

type
  TfrmProgress = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private êÈåæ }
    th_IMG: IMG_Conv;
    procedure ThDone(Sender: TObject);
  public
    { Public êÈåæ }
    FileName: String;
    Mode: Integer;
    BMP: TBitmap;
    bTerminate, bExe: Boolean;
    procedure Execute;
  end;

var
  frmProgress: TfrmProgress;

implementation

uses Main, SelListForm;

{$R *.dfm}

procedure TfrmProgress.FormCreate(Sender: TObject);
begin

    bExe := False;
    BMP := TBitmap.Create;
    Caption := MainForm.GetTranslation('progress', 'Progress');
    Label1.Caption := MainForm.GetTranslation('progress', 'Progress');
    Button1.Caption := MainForm.GetTranslation('abort', '&Abort');
end;

procedure TfrmProgress.Button1Click(Sender: TObject);
begin
    bTerminate := True;
    th_IMG.Terminate;

end;

procedure TfrmProgress.Execute;
begin
    bTerminate := False;
    ProgressBar1.Max := BMP.Height;
    th_IMG := IMG_Conv.Create(BMP.ReleaseHandle, ProgressBar1, Mode, BMP);
    th_IMG.OnTerminate := ThDone;
end;

procedure TfrmProgress.ThDone(Sender: TObject);
begin
    th_IMG := nil;
    if not bTerminate then
        ModalResult := mrok
    else
        ModalResult := mrAbort;
end;

procedure TfrmProgress.FormShow(Sender: TObject);
begin
    if not bExe then
    begin
        bExe := True;
        Execute;
    end;
end;

end.
