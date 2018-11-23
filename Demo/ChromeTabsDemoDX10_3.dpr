program ChromeTabsDemoDX10_3;

uses
  Forms,
  frmMainU in 'frmMainU.pas' {frmMain},
  frameChromeTabStyleU in 'frameChromeTabStyleU.pas' {frameChromeTabStyle: TFrame},
  ChromeTabsClasses in '..\Lib\ChromeTabsClasses.pas',
  ChromeTabsControls in '..\Lib\ChromeTabsControls.pas',
  ChromeTabsGlassForm in '..\Lib\ChromeTabsGlassForm.pas',
  ChromeTabsLog in '..\Lib\ChromeTabsLog.pas',
  ChromeTabsThreadTimer in '..\Lib\ChromeTabsThreadTimer.pas',
  ChromeTabsTypes in '..\Lib\ChromeTabsTypes.pas',
  ChromeTabsUtils in '..\Lib\ChromeTabsUtils.pas',
  ChromeTabs in '..\Lib\ChromeTabs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
