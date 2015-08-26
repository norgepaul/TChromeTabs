program ChromeTabsDemoXE4;

uses
//  EMemLeaks,
//  EResLeaks,
//  EDialogWinAPIMSClassic,
//  EDialogWinAPIEurekaLogDetailed,
//  EDialogWinAPIStepsToReproduce,
//  EDebugExports,
//  EDebugJCL,
//  EAppVCL,
//  ExceptionLog7,
  Forms,
  frmMainU in 'frmMainU.pas' {frmMain},
  ChromeTabsLog in '..\Lib\ChromeTabsLog.pas',
  frameChromeTabStyleU in 'frameChromeTabStyleU.pas' {frameChromeTabStyle: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
