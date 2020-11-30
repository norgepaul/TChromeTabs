unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ChromeTabs, ChromeTabsTypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    SomeTestButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SomeTestButtonClick(Sender: TObject);
  private
    { private declarations }
    ct : TChromeTabs;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  ct := TChromeTabs.Create(Self);
  ct.Parent := Self;
  ct.Align := alTop;
  ct.Options.Display.TabContainer.TransparentBackground:= false;
  ct.Options.Scrolling.Enabled := true;
  ct.Options.Behaviour.UseBuiltInPopupMenu:=true;
  ct.Options.Scrolling.AutoHideButtons:=true;
  ct.Options.Scrolling.MouseWheelScroll:=true;
end;

procedure TForm1.SomeTestButtonClick(Sender: TObject);
begin
  if (ct.Tabs.Count > 0) then
  begin
    ct.Tabs.ActiveTab.SpinnerState:=tssRenderedDownload;
  end;
end;

end.

