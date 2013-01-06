program ChromeTabsDemoXE2;

uses
  {$IFDEF EUREKALOG_VER6}
  ExceptionLog,
  {$ENDIF}
  {$IFDEF EUREKALOG_VER7}
  EMemLeaks,
  EResLeaks,
  EDialogWinAPIMSClassic,
  EDialogWinAPIEurekaLogDetailed,
  EDialogWinAPIStepsToReproduce,
  EDebugExports,
  EDebugJCL,
  EAppVCL,
  ExceptionLog7,
  {$ENDIF}
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
