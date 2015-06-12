unit ChromeTabsRegister;

interface

uses
  ToolsApi, Windows, SysUtils, Controls, ActnList, Classes,

  DesignIntf, DesignEditors,

  ChromeTabs,
  ChromeTabsDesign;

  procedure Register;

implementation

resourcestring
  StrTChromeTabsEvery = 'TChromeTabs - Every tab you''ll ever need';

{$R 'Icon.dcr'}

const
  PropertySection = 'Chrome Tabs';
  TChromeTabsName = 'TChromeTabs';

procedure Register;
begin
  RegisterComponents(PropertySection, [TChromeTabs]);

  // Property Editors
  RegisterComponentEditor(TChromeTabs, TChromeTabEditor);
end;

procedure RegisterSplashScreen;
var
  ProductImage: HBITMAP;
begin
  if Assigned(SplashScreenServices) then
  begin
    ProductImage := LoadBitmap(
      FindResourceHInstance(HInstance),
      'TCHROMETABS');

    SplashScreenServices.AddPluginBitmap(
      TChromeTabsName,
      ProductImage,
      False,
      StrTChromeTabsEvery);
  end;
end;

initialization
  RegisterSplashScreen;

finalization

end.
