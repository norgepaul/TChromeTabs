unit ChromeTabsRegister;

interface

{$include versions.inc}

uses
  SysUtils, Controls, ActnList,
  Classes,

  {$IFDEF DELPHI2006_UP}
    DesignIntf, DesignEditors,
  {$ENDIF}

  ChromeTabs,
  ChromeTabsDesign;

  procedure Register;

implementation

const
  PropertySection = 'Chrome Tabs';

procedure Register;
begin
  RegisterComponents(PropertySection, [TChromeTabs]);;

  // Property Editors
  {$IFDEF DELPHI2006_UP}
    RegisterComponentEditor(TChromeTabs, TChromeTabEditor);
  {$ENDIF}
end;

end.
