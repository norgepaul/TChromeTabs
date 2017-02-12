unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ChromeTabs;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  ct : TChromeTabs;
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

end.

