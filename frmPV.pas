unit frmPV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls;

type
  TpvForm = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  pvForm: TpvForm;

implementation

{$R *.dfm}

procedure TpvForm.CreateParams(var Params: TCreateParams);
begin
    inherited;
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
    Params.WndParent := GetDesktopWindow;
end;

procedure TpvForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  pvForm := nil;
end;

end.
