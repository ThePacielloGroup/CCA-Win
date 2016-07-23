unit about;
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
  Dialogs, StdCtrls, ExtCtrls, Buttons, ShellAPI, IniFIles, OleCtrls,
  SHDocVw, MSHTML_TLB, Activex;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    WB1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure WB1BeforeNavigate2(Sender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
  private
    { Private êÈåæ }

  public
    { Public êÈåæ }
  end;

var
  AboutForm: TAboutForm;
implementation

uses Main;





{$R *.dfm}

procedure TAboutForm.FormCreate(Sender: TObject);
var
    ini: TIniFile;
    Charset, Lang, EN, JP, s, WATC, EN_Mail, EN_Address, JP_Mail, JP_Address: widestring;
    T_Site, T_Mail, T_Name: widestring;
    VTxt, Add, Note, IconPath: widestring;
    List: TStringList;
    RS:TResourceStream;
    bTrans: Boolean;
    v: Variant;
    iDoc: IHTMLDocument2;
begin
    WB1.Navigate('about:blank');
    IconPath := ChangeFileExt(Application.ExeName, '.ico');
    ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    List := TStringList.Create;
    try
        Charset := ini.ReadString('HTML', 'Charset', 'utf-8');
        Lang := ini.ReadString('HTML', 'Lang', 'en');
        EN := ini.ReadString('Translations', 'en_ver', 'Steven Faulkner (English version):');
        JP := ini.ReadString('Translations', 'jp_ver', '');
        EN_Mail := ini.ReadString('Translations', 'en_mail', 'sfaulkner@paciellogroup.com');
        JP_Mail := ini.ReadString('Translations', 'jp_mail', '');
        EN_Address := ini.ReadString('Translations', 'en_website', 'http://www.paciellogroup.com/resources/contrast-analyser.html');
        JP_Address := ini.ReadString('Translations', 'jp_website', '');
        Caption := ini.ReadString('Translations', 'aboutwnd', 'About');
        T_Name := ini.ReadString('Translations', 'translator_name', '');
        T_Site := ini.ReadString('Translations', 'translator_site', '');
        T_Mail := ini.ReadString('Translations', 'translator_mail', '');
        VTxt := ini.ReadString('Translations', 'versiontext', 'Colour Contrast Analyser version 2.2a');
        Add := ini.ReadString('Translations', 'address_group', 'E-Mail & Web site address');
        Note := ini.ReadString('Translations', 'abouttext', 'The Colour Contrast Analyser was developed by Jun in collaboration with Steve Faulkner.');
        RS := TResourceStream.Create(hInstance,'ABOUT',PChar('TEXT'));
        WATC := ini.ReadString('Translations', 'WATC', 'http://www.wat-c.org/');

        try
            List.LoadFromStream(RS);
            List.Text := StringReplace(List.Text, '%charset%', Charset, [rfReplaceAll, rfIgnoreCase]);
            List.Text := StringReplace(List.Text, '%lang%', Lang, [rfReplaceAll, rfIgnoreCase]);
            s := List.Text;
            //s := s + #13#10 + '<h1><img src="' + IconPath + '" height="32" width="32" alt="CCA Icon" />' + VTxt + '</h1>';
            s := s + #13#10 + '<h1><img src="res://' + Application.ExeName + '/CCA" height="32" width="32" alt="CCA Icon" />' + VTxt + '</h1>';
            //s := '<h1>' + VTxt + '</h1>';
            s := s + #13#10 + '<hr />';
            s := s + #13#10 + '<p>' +  Note + '</p>';
            s := s + #13#10 + '<h2>' + Add + '</h2>';

            s := s + #13#10 + '<dl>';
            s := s + #13#10 + '<dt>' + EN + '</dt><dd>' + 'Mail: <a href="mailto:' + EN_Mail + '">' + EN_Mail + '</a></dd>';
            s := s + '<dd>' + 'Website: <a href="' + EN_Address + '">' + EN_Address + '</a></dd>';
            {s := s + #13#10 + '<dt>' + JP + '</dt>';
            if JP_Mail <> '' then
                s := s + '<dd>' + 'Mail: <a href="mailto:' + JP_Mail + '">' + JP_Mail + '</a></dd>';
            if JP_Address <> '' then
                s := s + '<dd>' + 'Website: <a href="' + JP_Address + '">' + JP_Address + '</a></dd>';  }

            s := s + #13#10 + '<dt>WAT-C</dt>';
            s := s + '<dd>' + 'Website: <a href="' + WATC + '">' + WATC + '</a></dd>';
            bTrans := False;
            if T_Name <> '' then
            begin
                s := s + #13#10 + '<dt>' + T_Name + '</dt>';
                bTrans := True;
            end;
            if T_Mail <> '' then
            begin
                s := s + '<dd>' + 'Mail: <a href="mailto:' + T_Mail + '">' + T_Mail + '</a></dd>';
                bTrans := True;
            end;
            if T_Site <> '' then
            begin
                s := s + '<dd>' + 'Website: <a href="' + T_Site + '">' + T_Site + '</a></dd>';
                bTrans := True;
            end;
            if bTrans then s := s + '</dt>';
            s := s + #13#10 + '</dl></body></html>';
            List.Add(s);
            if SUCCEEDED(WB1.Document.QueryInterface(IID_IHTMLDocument2, iDoc)) then
            begin
                v := VarArrayCreate([0, 0], varVariant);
                v[0] := s;//List.Text;
                iDoc.write(PSafeArray(TVarData(v).VArray));
                iDoc.close;
            end;
        finally
            RS.Free;
        end;
    finally
        ini.Free;
        List.Free;
    end;

end;

procedure TAboutForm.WB1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
    s: string;
begin
    if LowerCase(URL) <> 'about:blank' then
    begin
        Cancel := True;
        s := URl;
        ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_SHOW);
    end;
end;

end.
