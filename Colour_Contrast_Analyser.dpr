program Colour_Contrast_Analyser;

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

uses
  NoMultipleBoot,
  Forms,
  Windows,
  Messages,
  Main in 'Main.pas' {MainForm},
  Pick in 'Pick.pas' {PickForm},
  about in 'about.pas' {AboutForm},
  SelListForm in 'SelListForm.pas' {frmSelList},
  ProgressForm in 'ProgressForm.pas' {frmProgress},
  Th_IMGConv in 'Th_IMGConv.pas',
  FormIMGConvert in 'FormIMGConvert.pas' {frmIMGConvert},
  ConvWnd in 'ConvWnd.pas' {ConvWndForm};

{$R *.res}
{$R res.res}
{$R rc.res}
{$R about.res}
var
    Wnd, AppWnd: HWND;
begin
    if AppPrevInstance then
    begin
        Wnd := FindWindow('TMainForm', 'Colour Contrast Analyser');
        if Wnd <> 0 then
        begin
            AppWnd := GetWindowLong(Wnd, GWL_HWNDPARENT);
            if AppWnd <> 0 then Wnd := AppWnd;
            if IsIconic(Wnd) then
                SendMessage(AppWnd, WM_SYSCOMMAND, SC_RESTORE, -1);

            SetForegroundWindow(Wnd);

        end;
        Application.Terminate;
    end
    else
    begin
        Application.Initialize;
        Application.MainFormOnTaskbar := True;
        Application.CreateForm(TMainForm, MainForm);
        Application.CreateForm(TPickForm, PickForm);
        Application.Run;
    end;
end.
