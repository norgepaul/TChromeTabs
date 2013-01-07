program ChromeTabsDemoD7;

uses
  Forms,
  frmMainU in 'frmMainU.pas' {frmMain},
  frameChromeTabStyleU in 'frameChromeTabStyleU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
