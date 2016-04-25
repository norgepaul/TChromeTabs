unit ChromeTabsThreadTimer;

// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
//
// Alternatively, you may redistribute this library, use and/or modify it under the terms of the
// GNU Lesser General Public License as published by the Free Software Foundation;
// either version 2.1 of the License, or (at your option) any later version.
// You may obtain a copy of the LGPL at http://www.gnu.org/copyleft/.
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for the
// specific language governing rights and limitations under the License.
//
// The original code is ChromeTabs.pas, released December 2012.
//
// The initial developer of the original code is Easy-IP AS (Oslo, Norway, www.easy-ip.net),
// written by Paul Spencer Thornton (paul.thornton@easy-ip.net, www.easy-ip.net).
//
// Portions created by Easy-IP AS are Copyright
// (C) 2012 Easy-IP AS. All Rights Reserved.

interface

uses
  {$IF CompilerVersion >= 23.0}
  System.SysUtils,System.Classes,System.Types,System.Math,
  Vcl.Graphics,Vcl.Controls,Vcl.ExtCtrls,Vcl.Forms,Vcl.GraphUtil,Vcl.ImgList,
  Vcl.Dialogs,
  WinApi.Windows, WinApi.Messages,WinApi.MMSystem;
  {$ELSE}
  SysUtils,Classes,Math,
  Graphics,Controls,ExtCtrls,Forms,GraphUtil,ImgList,Dialogs,
  Windows,Messages,MMSystem;
  {$ifend}

type
  TThreadTimer = class;

  TTimerThread = class(TThread)
  private
    FTimer: TThreadTimer;
  protected
    procedure DoExecute;
  public
    constructor CreateTimerThread(Timer: TThreadTimer);
    procedure Execute; override;
  end;

  TThreadTimer = class(TComponent)
  private
    FInterval: Integer;
    FOnTimer: TNotifyEvent;
    FContinue: Boolean;
    FRunning: Boolean;
    FEnabled: Boolean;
    FTimerThread: TTimerThread;

    procedure SetEnabled(Value: Boolean);
  protected
    procedure StartTimer;
    procedure StopTimer;
    property Continue: Boolean read FContinue write FContinue;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  published
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;

    property Enabled: Boolean read FEnabled write SetEnabled;
    property Interval: Integer read FInterval write FInterval;
  end;

implementation

{ TTimerThread }

constructor TTimerThread.CreateTimerThread(Timer: TThreadTimer);
begin
  inherited Create(TRUE);

  FTimer := Timer;
end;

procedure TTimerThread.Execute;
var
  SleepTime: Integer;
  Last: DWORD;
begin
  while (FTimer.Continue) and (not Terminated) do
  begin
    Last := timeGetTime;

    try
      Synchronize(DoExecute);
    except
      // Just in case
    end;

    SleepTime := FTimer.FInterval - Integer(timeGetTime - Last);

    if SleepTime < 10 then
      SleepTime := 10;

    Sleep(SleepTime);
  end;
end;

procedure TTimerThread.DoExecute;
begin
  if Assigned(FTimer.OnTimer) then
    FTimer.OnTimer(FTimer);
end;


{ TThreadTimer }

constructor TThreadTimer.Create(Owner: TComponent);
begin
  inherited;

end;

destructor TThreadTimer.Destroy;
begin
  StopTimer;

  inherited;
end;

procedure TThreadTimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;

    if FEnabled then
      StartTimer
    else
      StopTimer;
  end;
end;

procedure TThreadTimer.StartTimer;
begin
  if FRunning then
    Exit;

  FContinue := TRUE;

  if not (csDesigning in ComponentState) then
  begin
    FTimerThread := TTimerThread.CreateTimerThread(Self);
    FTimerThread.FreeOnTerminate := FALSE;

    {$if CompilerVersion >= 18.0}
      FTimerThread.Start;
    {$else}
      FTimerThread.Resume;
    {$ifend}
  end;

  FRunning := TRUE;
end;

procedure TThreadTimer.StopTimer;
begin
  if FTimerThread <> nil then
  begin
    FContinue := FALSE;
    FRunning := FALSE;

    FTimerThread.WaitFor;

    FreeAndNil(FTimerThread);
  end;
end;

end.
