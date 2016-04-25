unit ChromeTabsDesign;

interface

uses
  {$IF CompilerVersion >= 23.0}
  System.SysUtils,System.Classes,System.Types,System.Math,
  Vcl.Controls,Vcl.ExtCtrls,Vcl.Forms,Vcl.GraphUtil,Vcl.ImgList,
  Vcl.Dialogs,Vcl.Menus,
  WinApi.Windows, WinApi.Messages,
  Vcl.Graphics,
  {$ELSE}
  SysUtils,Classes,Math,
  Controls,ExtCtrls,Forms,GraphUtil,ImgList,Dialogs,Menus,
  Windows,Messages,
  Graphics,
  {$ifend}
  DesignIntf,DesignEditors,VclEditors,StrEdit,ColnEdit,
  ChromeTabs;

type
  TChromeTabEditor = class (TDefaultEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

const
  DefaultLookAndFeelExt = '.ctlf';
  DialogLookAndFeelFilter = 'Chrome Tabs Look and Feel (*.ctlf)|*.ctlf|All Files (*.*)|*.*';
  DefaultOptionsExt = '.ctop';
  DialogOptionsFilter = 'Chrome Tabs Options (*.ctop)|*.ctop|All Files (*.*)|*.*';

procedure TChromeTabEditor.Edit;
begin
  ShowCollectionEditor(Designer, Component, TChromeTabs(Component).Tabs, 'Tabs');
end;

procedure TChromeTabEditor.ExecuteVerb(Index: Integer);
var
  ChromeTabs: TChromeTabs;
  OpenDialog: TOpenDialog;
  SaveDialog: TSaveDialog;
begin
  ChromeTabs := TChromeTabs(GetComponent);

  case Index of
    0, 3:
      begin
        OpenDialog := TOpenDialog.Create(nil);
        try
          case Index of
            0:
              begin
                OpenDialog.Title := 'Load Look and Feel';
                OpenDialog.DefaultExt := DefaultLookAndFeelExt;
                OpenDialog.Filter := DialogLookAndFeelFilter;
              end;
            3:
              begin
                OpenDialog.Title := 'Load Options';
                OpenDialog.DefaultExt := DefaultOptionsExt;
                OpenDialog.Filter := DialogOptionsFilter;
              end;
          end;

          if OpenDialog.Execute then
            case Index of
              0: ChromeTabs.LoadLookAndFeel(OpenDialog.FileName);
              3: ChromeTabs.LoadOptions(OpenDialog.FileName);
            end;
        finally
          FreeAndNil(OpenDialog);
        end;
      end;

    1, 4:
      begin
        SaveDialog := TSaveDialog.Create(nil);
        try
          SaveDialog.Options := SaveDialog.Options + [ofOverwritePrompt];

          case Index of
            1:
              begin
                SaveDialog.Title := 'Save Look and Feel';
                SaveDialog.DefaultExt := DefaultLookAndFeelExt;
                SaveDialog.Filter := DialogLookAndFeelFilter;
              end;
            4:
              begin
                SaveDialog.Title := 'Save Options';
                SaveDialog.DefaultExt := DefaultOptionsExt;
                SaveDialog.Filter := DialogOptionsFilter;
              end;
          end;

          if SaveDialog.Execute then
            case Index of
              1: ChromeTabs.SaveLookAndFeel(SaveDialog.FileName);
              4: ChromeTabs.SaveOptions(SaveDialog.FileName);
            end;
        finally
          FreeAndNil(OpenDialog);
        end;
      end;
  end;
end;

function TChromeTabEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Load Chrome Tabs Look and Feel';
    1: Result := 'Save Chrome Tabs Look and Feel';
    2: Result := '-';
    3: Result := 'Load Chrome Tabs Options';
    4: Result := 'Save Chrome Tabs Options';
  end;
end;

function TChromeTabEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

end.
