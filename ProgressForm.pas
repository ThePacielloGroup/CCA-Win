unit ProgressForm;

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
