unit ChromeTabsRegister;

interface

{$include versions.inc}

uses
  SysUtils, Controls, ActnList,
  Classes,

  DesignIntf, DesignEditors,

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
  RegisterComponentEditor(TChromeTabs, TChromeTabEditor);
end;

end.
