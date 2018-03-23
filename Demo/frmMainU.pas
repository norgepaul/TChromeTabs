unit frmMainU;

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

{$if CompilerVersion >= 21.0}
  {$DEFINE USE_GLASS_FORM}
{$ifend}

// Fix to workaround compiler bug that re-introduces System.Actions
{$if CompilerVersion >= 28.0}
  {$DEFINE USE_SYSTEM_ACTIONS}
{$endif}

{$if CompilerVersion >= 29.0}
  {$DEFINE USE_SYSTEM_IMAGELIST}
{$ifend}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, ComCtrls, Spin, Contnrs,
  ExtCtrls, ImgList, Types, Menus, ClipBrd, AppEvnts,

  GDIPObj, GDIPAPI,

  frameChromeTabStyleU,

  {$IFDEF USE_GLASS_FORM}ChromeTabsGlassForm,{$ENDIF}

(* NOTE - If you get "unit xxx is redeclared errors", comment out the IFDEF lines
   below. This is due to a Delphi bug with the {$if CompilerVersion .. } *)
  {$IFDEF USE_SYSTEM_ACTIONS}System.Actions,{$ENDIF}
  {$IFDEF USE_SYSTEM_IMAGELIST}System.ImageList,{$ENDIF}

  ChromeTabs,
  ChromeTabsTypes,
  ChromeTabsUtils,
  ChromeTabsControls,
  ChromeTabsClasses,
  ChromeTabsLog;

type
  TFormType = {$IFDEF USE_GLASS_FORM}
              TChromeTabsGlassForm
              {$ELSE}
              TForm
              {$ENDIF};

  TfrmMain = class(TFormType)
    actCopyLookAndFeelAsCode: TAction;
    actCopyOptionsAsCode: TAction;
    ActionList: TActionList;
    actLoadLookAndFeel: TAction;
    actLoadOptions: TAction;
    actSaveLookandFeel: TAction;
    actSaveOptions: TAction;
    ApplicationEvents: TApplicationEvents;
    btnCopyLookAndFeel: TButton;
    btnCopyOptions: TButton;
    btnHideTab: TButton;
    btnLoadLookAndFeel: TButton;
    btnLoadOptions: TButton;
    btnMakeAllTabsVisible: TButton;
    btnOpenForm: TButton;
    btnSaveLookAndFeel: TButton;
    btnSaveOptions: TButton;
    Button1: TButton;
    Button2: TButton;
    cbAddButtonVisibility: TComboBox;
    cbAddTabEase: TComboBox;
    cbBidiMode: TComboBox;
    cbCanvasSmoothingMode: TComboBox;
    cbCloseButtonVisibility: TComboBox;
    cbDeleteTabEase: TComboBox;
    cbDragCursor: TComboBox;
    cbDragType: TComboBox;
    cbExternalDragDisplay: TComboBox;
    cbFontHintMode: TComboBox;
    cbFontName: TComboBox;
    cbModifiedGlowEaseType: TComboBox;
    cbModifiedGlowStyle: TComboBox;
    cbMovementEaseType: TComboBox;
    cbMoveTabEase: TComboBox;
    cbScrollButtons: TComboBox;
    cbSelectTabs: TComboBox;
    cbSpinnerState: TComboBox;
    cbStyleEaseType: TComboBox;
    cbTextAlignment: TComboBox;
    cbTextTrimming: TComboBox;
    cbTextVerticalAlignment: TComboBox;
    chkAddTabDefaults: TCheckBox;
    chkAutoHideScrollButtons: TCheckBox;
    chkBackgroundDoubleClickMaxmise: TCheckBox;
    chkCloseButtonAutoHide: TCheckBox;
    chkContrainDraggedTab: TCheckBox;
    chkCustomTabShapes: TCheckBox;
    chkDebugLog: TCheckBox;
    chkDeleteTabDefaults: TCheckBox;
    chkDisplayTopTabsInTitleBar: TCheckBox;
    chkDraggingBackgoundMovesForm: TCheckBox;
    chkEnableEvents: TCheckBox;
    chkHideClosebutton: TCheckBox;
    chkHideImagesWhenSpinnerActive: TCheckBox;
    chkIgnorePropertyUpdated: TCheckBox;
    chkModified: TCheckBox;
    chkMouseGlowVisible: TCheckBox;
    chkMouseWheelScrolling: TCheckBox;
    chkMoveTabDefaults: TCheckBox;
    chkPinned: TCheckBox;
    chkRightClickSelect: TCheckBox;
    chkScrolling: TCheckBox;
    chkScrollOverlayButtons: TCheckBox;
    chkScrollWhileDragging: TCheckBox;
    chkSeeThroughTabs: TCheckBox;
    chkSetTabWidthsFromCaptions: TCheckBox;
    chkShowPlus: TCheckBox;
    chkShowTextOnPinnedTabs: TCheckBox;
    chkSmartResize: TCheckBox;
    chkSpinnerDownloadReverseDirection: TCheckBox;
    chkSpinnerUploadReverseDirection: TCheckBox;
    chkTabWordWrap: TCheckBox;
    chkTransparentBackground: TCheckBox;
    chkUseGlass: TCheckBox;
    ChromeTabs1: TChromeTabs;
    ChromeTabs2: TChromeTabs;
    edtAddButtonFloatingHorzOffset: TSpinEdit;
    edtAddButtonHeight: TSpinEdit;
    edtAddButtonHorzOffset: TSpinEdit;
    edtAddButtonVerticalOffset: TSpinEdit;
    edtAddButtonWidth: TSpinEdit;
    edtAddTabTime: TSpinEdit;
    edtAnimationStepsMovement: TSpinEdit;
    edtAnimationStepsStyle: TSpinEdit;
    edtAnimationUpdate: TSpinEdit;
    edtCloseButtonAutoHideWidth: TSpinEdit;
    edtCloseButtonHeight: TSpinEdit;
    edtCloseButtonHorzOffset: TSpinEdit;
    edtCloseButtonMouseLeaveDelay: TSpinEdit;
    edtCloseButtonVerticalOffset: TSpinEdit;
    edtCloseButtonWidth: TSpinEdit;
    edtContainerOffsetLeft: TSpinEdit;
    edtContainerOffsetRight: TSpinEdit;
    edtCrossOffset: TSpinEdit;
    edtDeleteTabTime: TSpinEdit;
    edtDragAwayDistance: TSpinEdit;
    edtDragImageAapha: TSpinEdit;
    edtDragImageResize: TEdit;
    edtDragScrollEdge: TSpinEdit;
    edtDragStartPixels: TSpinEdit;
    edtFontAlpha: TSpinEdit;
    edtFontColor: TColorBox;
    edtFontSize: TSpinEdit;
    edtGlassHeightBottom: TSpinEdit;
    edtGlassHeightTop: TSpinEdit;
    edtImageIndex: TSpinEdit;
    edtImageOverlayIndex: TSpinEdit;
    edtLeftScrollButtonHeight: TSpinEdit;
    edtLeftScrollButtonsHorzOffset: TSpinEdit;
    edtLeftScrollButtonsVerticalOffset: TSpinEdit;
    edtLeftScrollButtonWidth: TSpinEdit;
    edtMaxTabWidth: TSpinEdit;
    edtMinTabWidth: TSpinEdit;
    edtModifiedGlowAnimationPeriod: TSpinEdit;
    edtModifiedGlowAnimationUpdate: TSpinEdit;
    edtModifiedGlowHeight: TSpinEdit;
    edtModifiedGlowVerticalOffset: TSpinEdit;
    edtModifiedGlowWidth: TSpinEdit;
    edtMouseGlowHeight: TSpinEdit;
    edtMouseGlowHorzOffset: TSpinEdit;
    edtMouseGlowVerticalOffset: TSpinEdit;
    edtMouseGlowWidth: TSpinEdit;
    edtMoveTabTime: TSpinEdit;
    edtPinnedWidth: TSpinEdit;
    edtRightScrollButtonHeight: TSpinEdit;
    edtRightScrollButtonHorzOffset: TSpinEdit;
    edtRightScrollButtonVerticalOffset: TSpinEdit;
    edtRightScrollButtonWidth: TSpinEdit;
    edtScrollRepeatDelay: TSpinEdit;
    edtScrollSteps: TSpinEdit;
    edtSpinnerAnimationUpdate: TSpinEdit;
    edtSpinnerDownloadAnimationStep: TSpinEdit;
    edtSpinnerDownloadHeight: TSpinEdit;
    edtSpinnerDownloadOffsetX: TSpinEdit;
    edtSpinnerDownloadOffsetY: TSpinEdit;
    edtSpinnerDownloadSweepAngle: TSpinEdit;
    edtSpinnerDownloadWidth: TSpinEdit;
    edtSpinnerUploadAnimationStep: TSpinEdit;
    edtSpinnerUploadHeight: TSpinEdit;
    edtSpinnerUploadOffsetX: TSpinEdit;
    edtSpinnerUploadOffsetY: TSpinEdit;
    edtSpinnerUploadSweepAngle: TSpinEdit;
    edtSpinnerUploadWidth: TSpinEdit;
    edtStates: TEdit;
    edtTabCaption: TEdit;
    edtTabContentMarginLeft: TSpinEdit;
    edtTabContentMarginRight: TSpinEdit;
    edtTabHeight: TSpinEdit;
    edtTabOffsetBottom: TSpinEdit;
    edtTabOffsetLeft: TSpinEdit;
    edtTabOffsetRight: TSpinEdit;
    edtTabOffsetTop: TSpinEdit;
    edtTabOverlap: TSpinEdit;
    gbChange: TGroupBox;
    gbDragOver: TGroupBox;
    gbEvents: TGroupBox;
    gbMouseMove: TGroupBox;
    gbOtherEvents: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ImageList4: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label8: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label9: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    lblMinTabWidth: TLabel;
    lblScrollOffset: TLabel;
    lbTabDragOver: TListBox;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    Panel: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pcButtons: TPageControl;
    pcMain: TPageControl;
    pcOptions: TPageControl;
    pcTabExtras: TPageControl;
    pcTabSpinners: TPageControl;
    pnlDragDisplay: TPanel;
    pnlDragDrop: TPanel;
    pnlLookAndFeelPath: TPanel;
    pnlMouseGlow: TPanel;
    pnlScroll: TPanel;
    pnlTop: TPanel;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    sbScrollOffset: TScrollBar;
    ScrollBox1: TScrollBox;
    Scrolling: TTabSheet;
    Spinners: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    tabDebug: TTabSheet;
    TabSheetEvents: TTabSheet;
    TabSheetGeneral: TTabSheet;
    TabSheetLookAndFeel: TTabSheet;
    TabSheetOptions: TTabSheet;
    tvLookAndFeelItems: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure ChromeTabs1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure CommonTabPropertyChange(Sender: TObject);
    procedure OnCommonControlPropertyChange(Sender: TObject);
    procedure ChromeTabs1DebugLog(Sender: TObject; const Text: string);
    procedure ChromeTabs1NeedDragImageControl(Sender: TObject; ATab: TChromeTab;
      var DragControl: TWinControl);
    procedure ChromeTabs1StateChange(Sender: TObject; PreviousState,
      CurrentState: TChromeTabStates);
    procedure ChromeTabs1BeforeDrawItem(Sender: TObject;
      TargetCanvas: TGPGraphics; ItemRect: TRect; ItemType: TChromeTabItemType;
      TabIndex: Integer; var Handled: Boolean);
    procedure ChromeTabs1ActiveTabChanged(Sender: TObject; ATab: TChromeTab);
    procedure ChromeTabs1ActiveTabChanging(Sender: TObject; AOldTab,
      ANewTab: TChromeTab; var Allow: Boolean);
    procedure ChromeTabs1BeginTabDrag(Sender: TObject; ATab: TChromeTab;
      var Allow: Boolean);
    procedure ChromeTabs1CreateDragForm(Sender: TObject; ATab: TChromeTab;
      var DragForm: TForm);
    procedure ChromeTabs1EndTabDrag(Sender: TObject;
      Destination: TCustomChromeTabs; ATab: TChromeTab; var Cancel: Boolean);
    procedure ChromeTabs1Enter(Sender: TObject);
    procedure ChromeTabs1Exit(Sender: TObject);
    procedure ChromeTabs1MouseEnter(Sender: TObject);
    procedure ChromeTabs1MouseLeave(Sender: TObject);
    procedure ChromeTabs1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChromeTabs1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChromeTabs1ShowHint(Sender: TObject; HitTestResult: THitTestResult;
      var HintText: string; var HintTimeout: Integer);
    procedure ChromeTabs1TabDblClick(Sender: TObject; ATab: TChromeTab);
    procedure ChromeTabs1Change(Sender: TObject; ATab: TChromeTab;
      TabChangeType: TTabChangeType);
    procedure ChromeTabs1ButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
      var Close: Boolean);
    procedure cbTabShapesChange(Sender: TObject);
    procedure ChromeTabs1TabDragOver(Sender: TObject; X, Y: Integer;
      State: TDragState; DragTabObject: IDragTabObject; var Accept: Boolean);
    procedure ChromeTabs1TabDragStart(Sender: TObject; ATab: TChromeTab;
      var Allow: Boolean);
    procedure OnCommonRadioClick(Sender: TObject);
    procedure btnMakeAllTabsVisibleClick(Sender: TObject);
    procedure ChromeTabs1TabDragDropped(Sender: TObject;
      DragTabObject: IDragTabObject; NewTab: TChromeTab);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure sbScrollOffsetChange(Sender: TObject);
    procedure ChromeTabs1TabClientRectChanged(Sender: TObject);
    procedure ChromeTabs1ScrollWidthChanged(Sender: TObject);
    procedure btnOpenFormClick(Sender: TObject);
    procedure ChromeTabs1AfterDrawItem(Sender: TObject;
      const TargetCanvas: TGPGraphics; ItemRect: TRect;
      ItemType: TChromeTabItemType; TabIndex: Integer);
    procedure chkEnableEventsClick(Sender: TObject);
    procedure cbSelectTabsChange(Sender: TObject);
    procedure btnHideTabClick(Sender: TObject);
    procedure tvLookAndFeelItemsChange(Sender: TObject; Node: TTreeNode);
    procedure actLoadLookAndFeelExecute(Sender: TObject);
    procedure actSaveLookandFeelExecute(Sender: TObject);
    procedure actLoadOptionsExecute(Sender: TObject);
    procedure actSaveOptionsExecute(Sender: TObject);
    procedure ChromeTabs2AfterDrawItem(Sender: TObject; const TargetCanvas: TGPGraphics; ItemRect: TRect; ItemType: TChromeTabItemType; TabIndex: Integer);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure actCopyOptionsAsCodeExecute(Sender: TObject);
    procedure actCopyLookAndFeelAsCodeExecute(Sender: TObject);
    procedure ChromeTabs1TabDragDrop(Sender: TObject; X, Y: Integer; DragTabObject: IDragTabObject; Cancelled: Boolean; var TabDropOptions: TTabDropOptions);
    procedure Button1Click(Sender: TObject);
    procedure ChromeTabs1AnimateStyle(Sender: TObject;
      ChromeTabsControl: TBaseChromeTabsControl; NewDrawState: TDrawState;
      var AnimationTimeMS: Cardinal; var EaseType: TChromeTabsEaseType);
    procedure ChromeTabs1AnimateMovement(Sender: TObject;
      ChromeTabsControl: TBaseChromeTabsControl; var AnimationTimeMS: Cardinal;
      var EaseType: TChromeTabsEaseType);
    procedure ChromeTabs1ButtonAddClick(Sender: TObject; var Handled: Boolean);
    procedure ChromeTabs1SetTabWidth(Sender: TObject;
      ATabControl: TChromeTabControl; var TabWidth: Integer);
    procedure ChromeTabs1GetControlPolygons(Sender, ChromeTabsControl: TObject;
      ItemRect: TRect; ItemType: TChromeTabItemType;
      Orientation: TTabOrientation; var Polygons: IChromeTabPolygons);
    procedure Button2Click(Sender: TObject);
    procedure ChromeTabs2TabDragDrop(Sender: TObject; X, Y: Integer;
      DragTabObject: IDragTabObject; Cancelled: Boolean;
      var TabDropOptions: TTabDropOptions);
  private
    FLastMouseX: Integer;
    FLastMouseY: Integer;
    FUpdatingProperties: Boolean;
    FCurrentTabs: TChromeTabs;
    FUpdatingScrollbar: Boolean;
    FCurrentColorPickerFrame: TframeChromeTabStyle;

    FLogMouseMove: TChromeTabsLog;
    FLogDragOver: TChromeTabsLog;
    FLogChange: TChromeTabsLog;
    FLogEvents: TChromeTabsLog;
    FLogOtherEvents: TChromeTabsLog;
    FLogDebug: TChromeTabsLog;

    procedure EndColorPicking(Cancelled: Boolean);
    procedure UpdateControls;
    function AddTab(ChromeTabs: TChromeTabs; const Text: String; ImageIndex: Integer): TChromeTab;
    procedure GUIToTabProperties(Tab: TChromeTab);
    procedure TabPropertiesToGUI(Tab: TChromeTab);
    procedure GUIToChromeTabControlProperties(ChromeTabs: TChromeTabs);
    procedure FillEventList;
    procedure IncrementEventListItemCount(Index: Integer);
    procedure UpdateCurrentControl;
    procedure UpdateScrollBar;
    procedure UpdateScrollbarLabel;
    procedure HookEvents;
    procedure UnHookEvents;
    function CreateLog(AParent: TWinControl; const Columns: Array of String; const ColumnWidths: Array of Integer; AutoSizeIndex: Integer = -1): TChromeTabsLog;
    procedure CreateLogs;
    procedure ChromeTabControlPropertiesToGUI(ChromeTabs: TChromeTabs);
    procedure UpdateLookAndFeelEditors(ChromeTabs: TChromeTabs; Index: Integer);
    procedure OnFrameSelectColorClick(Sender: TObject);
    procedure RefreshLookAndFeelOptions;
    procedure FixControls;
    procedure BuildLookAndFeelTree;
    procedure ProcessDroppedTab(Sender: TObject; X, Y: Integer;
      DragTabObject: IDragTabObject; Cancelled: Boolean;
      var TabDropOptions: TTabDropOptions);
  end;

var
  frmMain: TfrmMain;

implementation

resourcestring
  StrTabContainer = 'Tab Container';
  StrBaseline = 'Baseline';
  StrDefaultFont = 'Default Font';
  StrModifiedGlow = 'Modified Glow';
  StrMouseGlow = 'Mouse Glow';
  StrAddButton = 'Add Button';
  StrButton = 'Button';
  StrPlusSymbol = 'Plus Symbol';
  StrCloseButton = 'Close Button';
  StrCircle = 'Circle';
  StrCross = 'Cross';
  StrScrollButtons = 'Scroll Buttons';
  StrArrow = 'Arrow';
  StrBackground = 'Background';
  StrActive = 'Active';
  StrNotActive = 'Not Active';
  StrHot = 'Hot';
  StrNormal = 'Normal';
  StrDown = 'Down';
  StrDisabled = 'Disabled';
  StrTabBaseline = 'Tab Baseline';
  StrDefaultTabFont = 'Default Tab Font';
  StrPleaseSelectACh = ' [Please select a child property]';
  StrTabIndex = '   Tab Index: ';
  StrMouseX = 'Mouse X';
  StrMouseY = 'Mouse Y';
  StrHitTestArea = 'Hit Test Area';
  StrHitTestTabIndex = 'Hit Test Tab Index';
  StrYes = 'Yes';
  StrNo = 'No';
  StrTabDrawState = 'Tab Draw State';
  StrCloseButtonDrawSt = 'Close Button Draw State';
  StrDragging = 'Dragging';
  StrTabCaption = '   Tab Caption';
  StrHorizontalOffset = '   Horizontal Offset';
  StrVerticalOffset = '   Vertical Offset';
  StrDropTabIndex = '   Drop Tab Index';
  StrSourceControl = '   Source Control';
  StrDockControl = '   Dock Control';
  StrNone = 'None';
  StrDragAndDropTabs = 'Drag and Drop tabs on this tab control.';
  StrSpinners = 'Spinners';
  StrDownload = 'Download';
  StrUpload = 'Upload';

const
  EventNames: Array[0..18] of String = (
    'OnActiveTabChanging',
    'OnChange',
    'OnActiveTabChanged',
    'OnDebugLog',
    'OnButtonAddClick',
    'OnButtonCloseTabClick',
    'OnNeedDragImageControl',
    'OnCreateDragForm',
    'OnStateChange',
    'OnBeforeDrawItem',
    'OnAfterDrawItem',
    'OnGetControlPolygon',
    'OnShowHint',
    'OnTabDblClick',
    'OnTabDragStart',
    'OnTabDragOver',
    'OnTabDragDrop',
    '',
    'Total Repaints'
  );

{$R *.dfm}

procedure TfrmMain.actCopyLookAndFeelAsCodeExecute(Sender: TObject);
begin
  Clipboard.AsText := FCurrentTabs.LookAndFeelToCode;
end;

procedure TfrmMain.actCopyOptionsAsCodeExecute(Sender: TObject);
begin
  Clipboard.AsText := FCurrentTabs.OptionsToCode;
end;

procedure TfrmMain.actLoadLookAndFeelExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ChromeTabs1.LoadLookAndFeel(OpenDialog1.FileName);

    RefreshLookAndFeelOptions;
  end;
end;

procedure TfrmMain.actLoadOptionsExecute(Sender: TObject);
begin
  if OpenDialog2.Execute then
  begin
    FCurrentTabs.LoadOptions(OpenDialog2.FileName);

    ChromeTabControlPropertiesToGUI(FCurrentTabs);

    ChromeTabs2.Options.Display.Tabs.Orientation := toBottom;
  end;
end;

procedure TfrmMain.actSaveLookandFeelExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then
    ChromeTabs1.SaveLookAndFeel(SaveDialog1.FileName);
end;

procedure TfrmMain.actSaveOptionsExecute(Sender: TObject);
begin
  if SaveDialog2.Execute then
    ChromeTabs1.SaveOptions(SaveDialog2.FileName);
end;

function TfrmMain.AddTab(ChromeTabs: TChromeTabs; const Text: String; ImageIndex: Integer): TChromeTab;
begin
  Result := ChromeTabs.Tabs.Add;

  Result.Caption := Text;
  Result.ImageIndex := ImageIndex;
end;

procedure TfrmMain.ApplicationEventsDeactivate(Sender: TObject);
begin
  EndColorPicking(FALSE);
end;

procedure TfrmMain.EndColorPicking(Cancelled: Boolean);
begin
  if FCurrentColorPickerFrame <> nil then
  begin
    FCurrentColorPickerFrame.StopColorPicking(Cancelled);

    FCurrentColorPickerFrame := nil;

    SetFocus;

    BringToFront;

    FormStyle := fsNormal;
  end;
end;

procedure TfrmMain.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  case Msg.message of
    WM_LButtonDown: EndColorPicking(FALSE);
    WM_KEYDOWN:
      if (FCurrentColorPickerFrame <> nil) and (Msg.wParam = 27) then
        EndColorPicking(TRUE);
  end;
end;

procedure TfrmMain.btnMakeAllTabsVisibleClick(Sender: TObject);
var
  i: Integer;
begin
  FCurrentTabs.BeginUpdate;
  try
    for i := 0 to pred(FCurrentTabs.Tabs.Count) do
      FCurrentTabs.Tabs[i].Visible := TRUE;
  finally
    FCurrentTabs.EndUpdate;
  end;
end;

procedure TfrmMain.btnOpenFormClick(Sender: TObject);
begin
  TfrmMain.Create(Application).Show;
end;

procedure TfrmMain.BuildLookAndFeelTree;

  function AddTreeNode(Parent: TTreeNode; const Text: String; ID: Integer): TTreeNode;
  begin
    Result := tvLookAndFeelItems.Items.AddChild(Parent, Text);

    Result.StateIndex := ID;
  end;

var
  TabContainerNode, TabsNode, AddButtonNode, CloseButtonNode, ScrollButtonNode: TTreeNode;
begin
  tvLookAndFeelItems.Items.Clear;

  TabContainerNode := AddTreeNode(nil, StrTabContainer, 0);

  TabsNode := AddTreeNode(TabContainerNode, 'Tabs', 1);

  AddTreeNode(TabsNode, StrBaseline, 11);
  AddTreeNode(TabsNode, StrDefaultFont, 12);
  AddTreeNode(TabsNode, StrModifiedGlow, 14);
  AddTreeNode(TabsNode, StrMouseGlow, 15);
  AddTreeNode(TabsNode, StrSpinners, 16);

  AddButtonNode := AddTreeNode(TabContainerNode, StrAddButton, 2);
  AddTreeNode(AddButtonNode, StrButton, 3);
  AddTreeNode(AddButtonNode, StrPlusSymbol, 4);

  CloseButtonNode := AddTreeNode(TabContainerNode, StrCloseButton, 5);
  AddTreeNode(CloseButtonNode, StrCircle, 6);
  AddTreeNode(CloseButtonNode, StrCross, 7);

  CloseButtonNode := AddTreeNode(TabContainerNode, StrCloseButton, 5);
  AddTreeNode(CloseButtonNode, StrCircle, 6);
  AddTreeNode(CloseButtonNode, StrCross, 7);

  ScrollButtonNode := AddTreeNode(TabContainerNode, StrScrollButtons, 8);
  AddTreeNode(ScrollButtonNode, StrButton, 9);
  AddTreeNode(ScrollButtonNode, StrArrow, 10);

  tvLookAndFeelItems.FullExpand;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if FCurrentTabs.ActiveTab <> nil then
    FCurrentTabs.ScrollIntoView(FCurrentTabs.ActiveTab);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  if FCurrentTabs.ActiveTab <> nil then
    FCurrentTabs.Tabs.DeleteTab(FCurrentTabs.ActiveTab.Index, FALSE);
end;

procedure TfrmMain.btnHideTabClick(Sender: TObject);
begin
  if ChromeTabs1.ActiveTab <> nil then
    ChromeTabs1.ActiveTab.Visible := FALSE;
end;

procedure TfrmMain.cbSelectTabsChange(Sender: TObject);
begin
  if cbSelectTabs.ItemIndex = 0 then
    FCurrentTabs := ChromeTabs1
  else
    FCurrentTabs := ChromeTabs2;

  ChromeTabControlPropertiesToGUI(FCurrentTabs);

  RefreshLookAndFeelOptions;
end;

procedure TfrmMain.cbTabShapesChange(Sender: TObject);
begin
  FCurrentTabs.Refresh;
end;

procedure TfrmMain.chkEnableEventsClick(Sender: TObject);
begin
  if chkEnableEvents.Checked then
    HookEvents
  else
    UnHookEvents;
end;

procedure TfrmMain.CommonTabPropertyChange(Sender: TObject);
begin
  if FCurrentTabs.ActiveTabIndex <> -1 then
    GUIToTabProperties(FCurrentTabs.ActiveTab);
end;

function TfrmMain.CreateLog(AParent: TWinControl; const Columns: array of String;
  const ColumnWidths: array of Integer; AutoSizeIndex: Integer): TChromeTabsLog;
var
  i: Integer;
begin
  Assert(high(Columns) = high(ColumnWidths), 'Columns and ColumnWidths arrays must be the same length');

  Result := TChromeTabsLog.Create(AParent);
  Result.Parent := AParent;
  Result.Align := alClient;

  for i := Low(Columns) to High(Columns) do
    Result.AddColumn(Columns[i], ColumnWidths[i]);

  Result.SetAutoSizeIndex(AutoSizeIndex);
end;

procedure TfrmMain.CreateLogs;
begin
  FLogMouseMove := CreateLog(gbMouseMove, [''], [0], 0);
  FLogDragOver := CreateLog(gbDragOver, [''], [0], 0);
  FLogChange := CreateLog(gbChange, [''], [0], 0);
  FLogEvents := CreateLog(gbEvents, ['', ''], [150, 50], 0);
  FLogOtherEvents := CreateLog(gbOtherEvents, [''], [0], 0);
  FLogDebug := CreateLog(tabDebug, [''], [0], 0);

  FLogDebug.SetAutoScroll(TRUE);
  FLogOtherEvents.SetAutoScroll(TRUE);
  FLogChange.SetAutoScroll(TRUE);
end;

procedure TfrmMain.GUIToTabProperties(Tab: TChromeTab);
begin
  if (Tab <> nil) and (not FUpdatingProperties) then
  begin
    FCurrentTabs.BeginUpdate;
    try
      Tab.Caption := edtTabCaption.Text;
      Tab.ImageIndex := edtImageIndex.Value;
      Tab.ImageIndexOverlay := edtImageOverlayIndex.Value;
      Tab.Pinned := chkPinned.Checked;
      Tab.Modified := chkModified.Checked;
      Tab.SpinnerState := TChromeTabSpinnerState(cbSpinnerState.ItemIndex);
      Tab.HideCloseButton := chkHideClosebutton.Checked;
    finally
      FCurrentTabs.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.TabPropertiesToGUI(Tab: TChromeTab);
begin
  FUpdatingProperties := TRUE;
  try
    if Tab <> nil then
    begin
      edtTabCaption.Text := Tab.Caption;
      edtImageIndex.Value := Tab.ImageIndex;
      edtImageOverlayIndex.Value := Tab.ImageIndexOverlay;
      chkPinned.Checked := Tab.Pinned;
      chkModified.Checked := Tab.Modified;
      cbSpinnerState.ItemIndex := Integer(Tab.SpinnerState);
      chkHideClosebutton.Checked := Tab.HideCloseButton;
    end;
  finally
    FUpdatingProperties := FALSE;
  end;
end;

procedure TfrmMain.tvLookAndFeelItemsChange(Sender: TObject; Node: TTreeNode);
begin
  RefreshLookAndFeelOptions;
end;

procedure TfrmMain.RefreshLookAndFeelOptions;
begin
  if tvLookAndFeelItems.Selected <> nil then
    UpdateLookAndFeelEditors(FCurrentTabs, tvLookAndFeelItems.Selected.StateIndex);
end;

procedure TfrmMain.OnFrameSelectColorClick(Sender: TObject);
begin
  if FCurrentColorPickerFrame <> nil then
    FCurrentColorPickerFrame.StopColorPicking(TRUE);

  if Sender is TframeChromeTabStyle then
    FCurrentColorPickerFrame := TframeChromeTabStyle(Sender);

  {$if CompilerVersion >= 18.0}
    FormStyle := fsStayOnTop; { TODO : This causes an exception in Delphi 7. Why? }
  {$ifend}
end;

procedure TfrmMain.UpdateLookAndFeelEditors(ChromeTabs: TChromeTabs; Index: Integer);

  function NewStyleFrame(const Caption: String): TframeChromeTabStyle;
  var
    GroupBox: TGroupBox;
  begin
    GroupBox := TGroupBox.Create(ScrollBox1);
    GroupBox.Parent := ScrollBox1;
    GroupBox.Left := 65535;
    GroupBox.Align := alLeft;
    GroupBox.Caption := Caption;

    Result := TframeChromeTabStyle.Create(GroupBox, ChromeTabs);
    Result.Parent := GroupBox;
    Result.Align := alClient;
    Result.OnStartColorPicking := OnFrameSelectColorClick;

    {$if CompilerVersion >= 18.0}
      Result.AlignWithMargins := TRUE;
    {$ifend}

    GroupBox.ClientWidth := Result.Width + 6;
  end;

  procedure AddChromeTabLookAndFeelStyle(const Caption: String; ChromeTabLookAndFeelStyle: TChromeTabsLookAndFeelStyle);
  var
    frameChromeTabStyle: TframeChromeTabStyle;
  begin
    frameChromeTabStyle := NewStyleFrame(Caption);

    frameChromeTabStyle.ChromeTabLookAndFeelStyle := ChromeTabLookAndFeelStyle;
  end;

  procedure AddChromeTabLookAndFeelPen(const Caption: String; ChromeTabLookAndFeelPen: TChromeTabsLookAndFeelPen);
  var
    frameChromeTabStyle: TframeChromeTabStyle;
  begin
    frameChromeTabStyle := NewStyleFrame(Caption);

    frameChromeTabStyle.ChromeTabLookAndFeelPen := ChromeTabLookAndFeelPen;
  end;

  procedure AddChromeTabLookAndFeelFont(const Caption: String; ChromeTabLookAndFeelFont: TChromeTabsLookAndFeelBaseFont);
  var
    frameChromeTabStyle: TframeChromeTabStyle;
  begin
    frameChromeTabStyle := NewStyleFrame(Caption);

    frameChromeTabStyle.ChromeTabFont := ChromeTabLookAndFeelFont;
  end;

  procedure AddChromeTabLookAndFeelStyleProperties(const Caption: String; ChromeTabLookAndFeelStyleProperties: TChromeTabsLookAndFeelStyleProperties);
  var
    frameChromeTabStyle: TframeChromeTabStyle;
  begin
    frameChromeTabStyle := NewStyleFrame(Caption);

    frameChromeTabStyle.ChromeTabLookAndFeelStyle := ChromeTabLookAndFeelStyleProperties.Style;
    frameChromeTabStyle.ChromeTabFont := ChromeTabLookAndFeelStyleProperties.Font;
  end;

  procedure AddChromeTabsLookAndFeelTabModified(const Caption: String; ChromeTabsLookAndFeelTabModified: TChromeTabsLookAndFeelGlow);
  var
    frameChromeTabStyle: TframeChromeTabStyle;
  begin
    frameChromeTabStyle := NewStyleFrame(Caption);

    frameChromeTabStyle.ChromeTabsLookAndFeelTabModified := ChromeTabsLookAndFeelTabModified;
  end;

  function GetLookAndFeelPathString: String;
  var
    TreeNode: TTreeNode;
  begin
    Result := '';

    TreeNode := tvLookAndFeelItems.Selected;

    while TreeNode <> nil do
    begin
      if Result <> '' then
        Result := ' > ' + Result;

      Result := TreeNode.Text + Result;

      TreeNode := TreeNode.Parent;
    end;
  end;

var
  i: Integer;
begin
  pnlLookAndFeelPath.Caption := GetLookAndFeelPathString;

  ScrollBox1.Visible := FALSE;

  // Clear the controls
  for i := pred(ScrollBox1.ControlCount) downto 0 do
    ScrollBox1.Controls[i].Free;

  if ChromeTabs <> nil then
  begin
    case Index of
      0: begin
           AddChromeTabLookAndFeelStyle(StrBackground, ChromeTabs.LookAndFeel.TabsContainer);
         end;

      1: begin
           AddChromeTabLookAndFeelStyleProperties(StrActive, ChromeTabs.LookAndFeel.Tabs.Active);
           AddChromeTabLookAndFeelStyleProperties(StrNotActive, ChromeTabs.LookAndFeel.Tabs.NotActive);
           AddChromeTabLookAndFeelStyleProperties(StrHot, ChromeTabs.LookAndFeel.Tabs.Hot);
         end;

      3: begin
           AddChromeTabLookAndFeelStyle(StrNormal, ChromeTabs.LookAndFeel.AddButton.Button.Normal);
           AddChromeTabLookAndFeelStyle(StrDown, ChromeTabs.LookAndFeel.AddButton.Button.Down);
           AddChromeTabLookAndFeelStyle(StrHot, ChromeTabs.LookAndFeel.AddButton.Button.Hot);
         end;

      4: begin
           AddChromeTabLookAndFeelStyle(StrNormal, ChromeTabs.LookAndFeel.AddButton.PlusSign.Normal);
           AddChromeTabLookAndFeelStyle(StrDown, ChromeTabs.LookAndFeel.AddButton.PlusSign.Down);
           AddChromeTabLookAndFeelStyle(StrHot, ChromeTabs.LookAndFeel.AddButton.PlusSign.Hot);
         end;

      6: begin
           AddChromeTabLookAndFeelStyle(StrNormal, ChromeTabs.LookAndFeel.CloseButton.Circle.Normal);
           AddChromeTabLookAndFeelStyle(StrDown, ChromeTabs.LookAndFeel.CloseButton.Circle.Down);
           AddChromeTabLookAndFeelStyle(StrHot, ChromeTabs.LookAndFeel.CloseButton.Circle.Hot);
         end;

      7: begin
           AddChromeTabLookAndFeelPen(StrNormal, ChromeTabs.LookAndFeel.CloseButton.Cross.Normal);
           AddChromeTabLookAndFeelPen(StrDown, ChromeTabs.LookAndFeel.CloseButton.Cross.Down);
           AddChromeTabLookAndFeelPen(StrHot, ChromeTabs.LookAndFeel.CloseButton.Cross.Hot);
         end;

      9: begin
           AddChromeTabLookAndFeelStyle(StrNormal, ChromeTabs.LookAndFeel.ScrollButtons.Button.Normal);
           AddChromeTabLookAndFeelStyle(StrDown, ChromeTabs.LookAndFeel.ScrollButtons.Button.Down);
           AddChromeTabLookAndFeelStyle(StrHot, ChromeTabs.LookAndFeel.ScrollButtons.Button.Hot);
           AddChromeTabLookAndFeelStyle(StrDisabled, ChromeTabs.LookAndFeel.ScrollButtons.Button.Disabled);
         end;

      10: begin
           AddChromeTabLookAndFeelStyle(StrNormal, ChromeTabs.LookAndFeel.ScrollButtons.Arrow.Normal);
           AddChromeTabLookAndFeelStyle(StrDown, ChromeTabs.LookAndFeel.ScrollButtons.Arrow.Down);
           AddChromeTabLookAndFeelStyle(StrHot, ChromeTabs.LookAndFeel.ScrollButtons.Arrow.Hot);
           AddChromeTabLookAndFeelStyle(StrDisabled, ChromeTabs.LookAndFeel.ScrollButtons.Arrow.Disabled);
         end;

      11: begin // Tabs Baseline
            AddChromeTabLookAndFeelPen(StrTabBaseline, ChromeTabs.LookAndFeel.Tabs.BaseLine);
          end;

      12: begin // Default Font
            AddChromeTabLookAndFeelFont(StrDefaultTabFont, ChromeTabs.LookAndFeel.Tabs.DefaultFont);
          end;

      14: begin // Modified Glow
            AddChromeTabsLookAndFeelTabModified(StrModifiedGlow, ChromeTabs.LookAndFeel.Tabs.Modified);
          end;

      15: begin // Mouse Glow
            AddChromeTabsLookAndFeelTabModified(StrMouseGlow, ChromeTabs.LookAndFeel.Tabs.MouseGlow);
          end;

      16: begin // Spinners
            AddChromeTabLookAndFeelPen(StrUpload, ChromeTabs.LookAndFeel.Tabs.Spinners.Upload);
            AddChromeTabLookAndFeelPen(StrDownload, ChromeTabs.LookAndFeel.Tabs.Spinners.Download);
          end;

      else
      begin
        pnlLookAndFeelPath.Caption := pnlLookAndFeelPath.Caption + StrPleaseSelectACh;

        Exit;
      end;
    end;

    ScrollBox1.Visible := TRUE;
    ScrollBox1.Width := ScrollBox1.Width + 1;
  end;
end;

procedure TfrmMain.FillEventList;
var
  i: Integer;
begin
  FLogEvents.Clear;

  for i := Low(EventNames) to High(EventNames) do
    if EventNames[i] = '' then
      FLogEvents.Log([''], i)
    else
      FLogEvents.Log([EventNames[i], '0'], i);
end;

procedure TfrmMain.IncrementEventListItemCount(Index: Integer);
begin
  FLogEvents.Log([FLogEvents.GetColumnText(0, Index), IntToStr(StrToInt(FLogEvents.GetColumnText(1, Index)) + 1)], Index);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  CreateLogs;

  {$IFNDEF USE_GLASS_FORM}
  chkDisplayTopTabsInTitleBar.Enabled := FALSE;
  chkDisplayTopTabsInTitleBar.Checked := FALSE;
  {$ENDIF}

  FUpdatingProperties := TRUE;
  try
    pcMain.ActivePageIndex := 0;
    pcOptions.ActivePageIndex := 0;
    pcButtons.ActivePageIndex := 0;
    pcTabExtras.ActivePageIndex := 0;
    pcTabSpinners.ActivePageIndex := 0;

    cbFontName.Items.Assign(Screen.Fonts);

    UpdateCurrentControl;

    edtDragImageResize.Text := FloatToStr(0.5);

    edtGlassHeightTop.Value := FCurrentTabs.Height;

    edtGlassHeightBottom.MaxValue := ChromeTabs2.Height + 1;
    edtGlassHeightBottom.Value := edtGlassHeightBottom.MaxValue;

    ChromeTabControlPropertiesToGUI(FCurrentTabs);
    TabPropertiesToGUI(FCurrentTabs.ActiveTab);

    ChromeTabs1.LookAndFeel.Tabs.NotActive.Style.StartAlpha := 210;
    ChromeTabs1.LookAndFeel.Tabs.NotActive.Style.StopAlpha := 210;

    FixControls;

    BuildLookAndFeelTree;

    UpdateControls;

    tvLookAndFeelItems.Items[0].Selected := TRUE;
  finally
    FUpdatingProperties := FALSE;
  end;

  ChromeTabControlPropertiesToGUI(FCurrentTabs);

  {$IFDEF USE_GLASS_FORM}
  Self.ChromeTabs := ChromeTabs1;
  {$ENDIF}

  ChromeTabs1.Tabs[0].Active := True;
end;

procedure TfrmMain.FixControls;
begin
  {$if CompilerVersion >= 18.0}
    btnOpenForm.Align := alRight;
    btnOpenForm.AlignWithMargins := TRUE;

    btnLoadOptions.Align := alLeft;
    btnLoadOptions.AlignWithMargins := TRUE;
    btnSaveOptions.Align := alLeft;
    btnSaveOptions.AlignWithMargins := TRUE;
    btnCopyOptions.Align := alLeft;
    btnCopyOptions.AlignWithMargins := TRUE;

    btnLoadLookAndFeel.Align := alLeft;
    btnLoadLookAndFeel.AlignWithMargins := TRUE;
    btnSaveLookAndFeel.Align := alLeft;
    btnSaveLookAndFeel.AlignWithMargins := TRUE;
    btnCopyLookAndFeel.Align := alLeft;
    btnCopyLookAndFeel.AlignWithMargins := TRUE;
  {$ifend}
end;

procedure TfrmMain.OnCommonControlPropertyChange(Sender: TObject);
begin
  GUIToChromeTabControlProperties(FCurrentTabs);

  UpdateControls;
end;

procedure TfrmMain.OnCommonRadioClick(Sender: TObject);
begin
  UpdateCurrentControl;

  UpdateControls;
end;

procedure TfrmMain.sbScrollOffsetChange(Sender: TObject);
begin
  if not FUpdatingScrollbar then
  begin
    FCurrentTabs.ScrollOffset := sbScrollOffset.Position;

    UpdateScrollbarLabel;
  end;
end;

procedure TfrmMain.UpdateCurrentControl;
begin
  if FCurrentTabs <> nil then
    UnHookEvents;

  if cbSelectTabs.ItemIndex = 1 then
    FCurrentTabs := ChromeTabs2
  else
    FCurrentTabs := ChromeTabs1;

  FillEventList;
end;

procedure TfrmMain.HookEvents;
begin
  FCurrentTabs.OnActiveTabChanged := ChromeTabs1ActiveTabChanged;
  FCurrentTabs.OnActiveTabChanging := ChromeTabs1ActiveTabChanging;
  FCurrentTabs.OnAfterDrawItem := ChromeTabs1AfterDrawItem;
  FCurrentTabs.OnBeforeDrawItem := ChromeTabs1BeforeDrawItem;
  FCurrentTabs.OnButtonCloseTabClick := ChromeTabs1ButtonCloseTabClick;
  FCurrentTabs.OnCreateDragForm := ChromeTabs1CreateDragForm;
  FCurrentTabs.OnEnter := ChromeTabs1Enter;
  FCurrentTabs.OnExit := ChromeTabs1Exit;
  FCurrentTabs.OnGetControlPolygons := ChromeTabs1GetControlPolygons;
  FCurrentTabs.OnMouseDown := ChromeTabs1MouseDown;
  FCurrentTabs.OnMouseUp := ChromeTabs1MouseUp;
  FCurrentTabs.OnScroll := ChromeTabs1ScrollWidthChanged;
  FCurrentTabs.OnScrollWidthChanged := ChromeTabs1ScrollWidthChanged;
  FCurrentTabs.OnStateChange := ChromeTabs1StateChange;
  FCurrentTabs.OnTabDblClick := ChromeTabs1TabDblClick;
  FCurrentTabs.OnTabDragDrop := ChromeTabs1TabDragDrop;
  FCurrentTabs.OnTabDragDropped := ChromeTabs1TabDragDropped;
  FCurrentTabs.OnTabDragOver := ChromeTabs1TabDragOver;
  FCurrentTabs.OnTabDragStart := ChromeTabs1TabDragStart;
  FCurrentTabs.OnMouseMove := ChromeTabs1MouseMove;
  FCurrentTabs.OnAnimateStyle := ChromeTabs1AnimateStyle;
  FCurrentTabs.OnAnimateMovement := ChromeTabs1AnimateMovement;
end;

procedure TfrmMain.UnHookEvents;
begin
  FCurrentTabs.OnActiveTabChanged := nil;
  FCurrentTabs.OnActiveTabChanging := nil;
  FCurrentTabs.OnAfterDrawItem := nil;
  FCurrentTabs.OnBeforeDrawItem := nil;
  FCurrentTabs.OnChange := nil;
  FCurrentTabs.OnCreateDragForm := nil;
  FCurrentTabs.OnEnter := nil;
  FCurrentTabs.OnExit := nil;
  FCurrentTabs.OnGetControlPolygons := nil;
  FCurrentTabs.OnMouseDown := nil;
  FCurrentTabs.OnMouseUp := nil;
  FCurrentTabs.OnMouseMove := nil;
  FCurrentTabs.OnResize := nil;
  FCurrentTabs.OnScroll := nil;
  FCurrentTabs.OnScrollWidthChanged := nil;
  FCurrentTabs.OnStateChange := nil;
  FCurrentTabs.OnTabDblClick := nil;
  FCurrentTabs.OnTabDragDrop := nil;
  FCurrentTabs.OnTabDragDropped := nil;
  FCurrentTabs.OnTabDragOver := nil;
  FCurrentTabs.OnTabDragStart := nil;
  FCurrentTabs.OnAnimateStyle := nil;
  FCurrentTabs.OnAnimateMovement := nil;
end;

procedure TfrmMain.ChromeTabControlPropertiesToGUI(ChromeTabs: TChromeTabs);
begin
  if (ChromeTabs <> nil) and (not FUpdatingProperties) then
  try
    FUpdatingProperties := TRUE;

    chkScrollOverlayButtons.Checked := ChromeTabs.Options.Display.TabContainer.OverlayButtons;

    cbCloseButtonVisibility.ItemIndex := Integer(ChromeTabs.Options.Display.CloseButton.Visibility);
    chkCloseButtonAutoHide.Checked := ChromeTabs.Options.Display.CloseButton.AutoHide;
    edtCloseButtonAutoHideWidth.Value := ChromeTabs.Options.Display.CloseButton.AutoHideWidth;
    edtCloseButtonVerticalOffset.Value := ChromeTabs.Options.Display.CloseButton.Offsets.Vertical;
    edtCloseButtonHorzOffset.Value := ChromeTabs.Options.Display.CloseButton.Offsets.Horizontal;
    edtCloseButtonHeight.Value := ChromeTabs.Options.Display.CloseButton.Height;
    edtCloseButtonWidth.Value := ChromeTabs.Options.Display.CloseButton.Width;
    edtCrossOffset.Value := ChromeTabs.Options.Display.CloseButton.CrossRadialOffset;

    cbAddButtonVisibility.ItemIndex := Integer(ChromeTabs.Options.Display.AddButton.Visibility);
    edtAddButtonVerticalOffset.Value := ChromeTabs.Options.Display.AddButton.Offsets.Vertical;
    edtAddButtonHorzOffset.Value := ChromeTabs.Options.Display.AddButton.Offsets.Horizontal;
    edtAddButtonFloatingHorzOffset.Value := ChromeTabs.Options.Display.AddButton.HorizontalOffsetFloating;
    edtAddButtonHeight.Value := ChromeTabs.Options.Display.AddButton.Height;
    edtAddButtonWidth.Value := ChromeTabs.Options.Display.AddButton.Width;

    chkShowPlus.Checked := ChromeTabs.Options.Display.AddButton.ShowPlusSign;

    edtLeftScrollButtonHeight.Value := ChromeTabs.Options.Display.ScrollButtonLeft.Height;
    edtLeftScrollButtonWidth.Value := ChromeTabs.Options.Display.ScrollButtonLeft.Width;
    edtLeftScrollButtonsVerticalOffset.Value := ChromeTabs.Options.Display.ScrollButtonLeft.Offsets.Vertical;
    edtLeftScrollButtonsHorzOffset.Value := ChromeTabs.Options.Display.ScrollButtonLeft.Offsets.Horizontal;

    edtRightScrollButtonHeight.Value := ChromeTabs.Options.Display.ScrollButtonRight.Height;
    edtRightScrollButtonWidth.Value := ChromeTabs.Options.Display.ScrollButtonRight.Width;
    edtRightScrollButtonVerticalOffset.Value := ChromeTabs.Options.Display.ScrollButtonRight.Offsets.Vertical;
    edtRightScrollButtonHorzOffset.Value := ChromeTabs.Options.Display.ScrollButtonRight.Offsets.Horizontal;

    chkTransparentBackground.Checked := ChromeTabs.Options.Display.TabContainer.TransparentBackground;
    edtContainerOffsetLeft.Value := ChromeTabs.Options.Display.TabContainer.PaddingLeft;
    edtContainerOffsetRight.Value := ChromeTabs.Options.Display.TabContainer.PaddingRight;

    cbModifiedGlowStyle.ItemIndex := Integer(ChromeTabs.Options.Display.TabModifiedGlow.Style);
    edtModifiedGlowVerticalOffset.Value := ChromeTabs.Options.Display.TabModifiedGlow.VerticalOffset;
    edtModifiedGlowHeight.Value := ChromeTabs.Options.Display.TabModifiedGlow.Height;
    edtModifiedGlowWidth.Value := ChromeTabs.Options.Display.TabModifiedGlow.Width;
    edtModifiedGlowAnimationPeriod.Value := ChromeTabs.Options.Display.TabModifiedGlow.AnimationPeriodMS;
    edtModifiedGlowAnimationUpdate.Value := ChromeTabs.Options.Display.TabModifiedGlow.AnimationUpdateMS;
    cbModifiedGlowEaseType.ItemIndex := Integer(ChromeTabs.Options.Display.TabModifiedGlow.EaseType);

    chkMouseGlowVisible.Checked := ChromeTabs.Options.Display.TabMouseGlow.Visible;
    edtMouseGlowVerticalOffset.Value := ChromeTabs.Options.Display.TabMouseGlow.Offsets.Vertical;
    edtMouseGlowHeight.Value := ChromeTabs.Options.Display.TabMouseGlow.Height;
    edtMouseGlowWidth.Value := ChromeTabs.Options.Display.TabMouseGlow.Width;
    edtMouseGlowHorzOffset.Value := ChromeTabs.Options.Display.TabMouseGlow.Offsets.Horizontal;

    edtTabContentMarginLeft.Value := ChromeTabs.Options.Display.Tabs.ContentOffsetLeft;
    edtTabContentMarginRight.Value := ChromeTabs.Options.Display.Tabs.ContentOffsetRight;
    cbBidiMode.ItemIndex := Integer(ChromeTabs.BiDiMode);

    edtPinnedWidth.Value := ChromeTabs.Options.Display.Tabs.PinnedWidth;
    edtMaxTabWidth.Value := ChromeTabs.Options.Display.Tabs.MaxWidth;
    edtMinTabWidth.Value := ChromeTabs.Options.Display.Tabs.MinWidth;
    edtTabHeight.Value := ChromeTabs.Height;
    edtTabOffsetTop.Value := ChromeTabs.Options.Display.Tabs.OffsetTop;
    edtTabOffsetLeft.Value := ChromeTabs.Options.Display.Tabs.OffsetLeft;
    edtTabOffsetBottom.Value := ChromeTabs.Options.Display.Tabs.OffsetBottom;
    edtTabOffsetRight.Value := ChromeTabs.Options.Display.Tabs.OffsetRight;
    chkTabWordWrap.Checked := ChromeTabs.Options.Display.Tabs.WordWrap;
    cbTextAlignment.ItemIndex := Integer(ChromeTabs.Options.Display.Tabs.TextAlignmentHorizontal);
    cbTextVerticalAlignment.ItemIndex := Integer(ChromeTabs.Options.Display.Tabs.TextAlignmentVertical);
    cbTextTrimming.ItemIndex := Integer(ChromeTabs.Options.Display.Tabs.TextTrimType);
    chkSetTabWidthsFromCaptions.Checked := ChromeTabs.Options.Display.Tabs.TabWidthFromContent;
    chkSeeThroughTabs.Checked := ChromeTabs.Options.Display.Tabs.SeeThroughTabs;
    edtTabOverlap.Value := ChromeTabs.Options.Display.Tabs.TabOverlap;
    chkShowTextOnPinnedTabs.Checked := ChromeTabs.Options.Display.Tabs.ShowPinnedTabText;

    cbFontHintMode.ItemIndex := Integer(ChromeTabs.LookAndFeel.Tabs.DefaultFont.TextRenderingMode);
    cbCanvasSmoothingMode.ItemIndex := Integer(ChromeTabs.Options.Display.Tabs.CanvasSmoothingMode);
    cbFontName.Text := ChromeTabs.LookAndFeel.Tabs.DefaultFont.Name;
    edtFontSize.Value := ChromeTabs.LookAndFeel.Tabs.DefaultFont.Size;
    edtFontColor.Selected := ChromeTabs.LookAndFeel.Tabs.DefaultFont.Color;
    edtFontAlpha.Value := ChromeTabs.LookAndFeel.Tabs.DefaultFont.Alpha;

    chkBackgroundDoubleClickMaxmise.Checked := ChromeTabs.Options.Behaviour.BackgroundDblClickMaximiseRestoreForm;
    chkDraggingBackgoundMovesForm.Checked := ChromeTabs.Options.Behaviour.BackgroundDragMovesForm;
    chkSmartResize.Checked := ChromeTabs.Options.Behaviour.TabSmartDeleteResizing;
    edtCloseButtonMouseLeaveDelay.Value := ChromeTabs.Options.Behaviour.TabSmartDeleteResizeCancelDelay;
    chkRightClickSelect.Checked := ChromeTabs.Options.Behaviour.TabRightClickSelect;

    edtAnimationStepsMovement.Value := ChromeTabs.Options.Animation.DefaultMovementAnimationTimeMS;
    edtAnimationStepsStyle.Value := ChromeTabs.Options.Animation.DefaultStyleAnimationTimeMS;
    edtAnimationUpdate.Value := ChromeTabs.Options.Animation.AnimationTimerInterval;
    cbMovementEaseType.ItemIndex := Integer(ChromeTabs.Options.Animation.DefaultMovementEaseType);
    cbStyleEaseType.ItemIndex := Integer(ChromeTabs.Options.Animation.DefaultStyleEaseType);

    chkAddTabDefaults.Checked := (ChromeTabs.Options.Animation.MovementAnimations.TabAdd.UseDefaultEaseType) or (ChromeTabs.Options.Animation.MovementAnimations.TabAdd.UseDefaultAnimationTime);
    edtAddTabTime.Value := ChromeTabs.Options.Animation.MovementAnimations.TabAdd.AnimationTimeMS;
    cbAddTabEase.ItemIndex := Integer(ChromeTabs.Options.Animation.MovementAnimations.TabAdd.EaseType);

    chkDeleteTabDefaults.Checked := (ChromeTabs.Options.Animation.MovementAnimations.TabDelete.UseDefaultEaseType) or (ChromeTabs.Options.Animation.MovementAnimations.TabDelete.UseDefaultAnimationTime);
    edtDeleteTabTime.Value := ChromeTabs.Options.Animation.MovementAnimations.TabDelete.AnimationTimeMS;
    cbDeleteTabEase.ItemIndex := Integer(ChromeTabs.Options.Animation.MovementAnimations.TabDelete.EaseType);

    chkMoveTabDefaults.Checked := (ChromeTabs.Options.Animation.MovementAnimations.TabMove.UseDefaultEaseType) or (ChromeTabs.Options.Animation.MovementAnimations.TabMove.UseDefaultAnimationTime);
    edtMoveTabTime.Value := ChromeTabs.Options.Animation.MovementAnimations.TabMove.AnimationTimeMS;
    cbMoveTabEase.ItemIndex := Integer(ChromeTabs.Options.Animation.MovementAnimations.TabMove.EaseType);

    chkScrolling.Checked := ChromeTabs.Options.Scrolling.Enabled;
    cbScrollButtons.ItemIndex := Integer(ChromeTabs.Options.Scrolling.ScrollButtons);
    edtScrollSteps.Value := ChromeTabs.Options.Scrolling.ScrollStep;
    edtScrollRepeatDelay.Value := ChromeTabs.Options.Scrolling.ScrollRepeatDelay;
    chkAutoHideScrollButtons.Checked := ChromeTabs.Options.Scrolling.AutoHideButtons;
    chkScrollWhileDragging.Checked := ChromeTabs.Options.Scrolling.DragScroll;
    edtDragScrollEdge.Value := ChromeTabs.Options.Scrolling.DragScrollOffset;
    chkMouseWheelScrolling.Checked := ChromeTabs.Options.Scrolling.MouseWheelScroll;

    cbDragType.ItemIndex := Integer(ChromeTabs.Options.DragDrop.DragType);
    edtDragImageAapha.Value := ChromeTabs.Options.DragDrop.DragOutsideImageAlpha;
    edtDragAwayDistance.Value := ChromeTabs.Options.DragDrop.DragOutsideDistancePixels;
    edtDragStartPixels.Value := ChromeTabs.Options.DragDrop.DragStartPixels;
    edtDragImageResize.Text := FloatToStr(ChromeTabs.Options.DragDrop.DragControlImageResizeFactor);
    chkContrainDraggedTab.Checked := ChromeTabs.Options.DragDrop.ContrainDraggedTabWithinContainer;
    cbExternalDragDisplay.ItemIndex := Integer(ChromeTabs.Options.DragDrop.DragDisplay);

    edtSpinnerAnimationUpdate.Value := ChromeTabs.Options.Display.TabSpinners.AnimationUpdateMS;
    chkHideImagesWhenSpinnerActive.Checked := ChromeTabs.Options.Display.TabSpinners.HideImagesWhenSpinnerVisible;

    chkSpinnerUploadReverseDirection.Checked := ChromeTabs.Options.Display.TabSpinners.Upload.ReverseDirection;
    edtSpinnerUploadAnimationStep.Value := ChromeTabs.Options.Display.TabSpinners.Upload.RenderedAnimationStep;
    edtSpinnerUploadSweepAngle.Value := ChromeTabs.Options.Display.TabSpinners.Upload.SweepAngle;

    edtSpinnerUploadWidth.Value := ChromeTabs.Options.Display.TabSpinners.Upload.Position.Width;
    edtSpinnerUploadHeight.Value := ChromeTabs.Options.Display.TabSpinners.Upload.Position.Height;
    edtSpinnerUploadOffsetX.Value := ChromeTabs.Options.Display.TabSpinners.Upload.Position.Offsets.Horizontal;
    edtSpinnerUploadOffsetY.Value := ChromeTabs.Options.Display.TabSpinners.Upload.Position.Offsets.Vertical;

    chkSpinnerDownloadReverseDirection.Checked := ChromeTabs.Options.Display.TabSpinners.Download.ReverseDirection;
    edtSpinnerDownloadAnimationStep.Value := ChromeTabs.Options.Display.TabSpinners.Download.RenderedAnimationStep;
    edtSpinnerDownloadSweepAngle.Value := ChromeTabs.Options.Display.TabSpinners.Download.SweepAngle;

    edtSpinnerDownloadWidth.Value := ChromeTabs.Options.Display.TabSpinners.Download.Position.Width;
    edtSpinnerDownloadHeight.Value := ChromeTabs.Options.Display.TabSpinners.Download.Position.Height;
    edtSpinnerDownloadOffsetX.Value := ChromeTabs.Options.Display.TabSpinners.Download.Position.Offsets.Horizontal;
    edtSpinnerDownloadOffsetY.Value := ChromeTabs.Options.Display.TabSpinners.Download.Position.Offsets.Vertical;

    if ChromeTabs.Options.DragDrop.DragCursor = crDrag then
      cbDragCursor.ItemIndex := 1
    else
      cbDragCursor.ItemIndex := 0;
  finally
    FUpdatingProperties := FALSE;
  end;
end;

procedure TfrmMain.GUIToChromeTabControlProperties(ChromeTabs: TChromeTabs);
begin
  if (ChromeTabs <> nil) and (not FUpdatingProperties) then
  begin
    ChromeTabs.BeginUpdate;
    try
      ChromeTabs.Options.Display.TabContainer.OverlayButtons := chkScrollOverlayButtons.Checked;

      ChromeTabs.Options.Display.CloseButton.Visibility := TCloseButtonVisiblity(cbCloseButtonVisibility.ItemIndex);
      ChromeTabs.Options.Display.CloseButton.AutoHide := chkCloseButtonAutoHide.Checked;
      ChromeTabs.Options.Display.CloseButton.AutoHideWidth := edtCloseButtonAutoHideWidth.Value;
      ChromeTabs.Options.Display.CloseButton.Offsets.Vertical := edtCloseButtonVerticalOffset.Value;
      ChromeTabs.Options.Display.CloseButton.Offsets.Horizontal := edtCloseButtonHorzOffset.Value;
      ChromeTabs.Options.Display.CloseButton.Height := edtCloseButtonHeight.Value;
      ChromeTabs.Options.Display.CloseButton.Width := edtCloseButtonWidth.Value;
      ChromeTabs.Options.Display.CloseButton.CrossRadialOffset := edtCrossOffset.Value;

      ChromeTabs.Options.Display.AddButton.Visibility := TAddButtonVisibility(cbAddButtonVisibility.ItemIndex);
      ChromeTabs.Options.Display.AddButton.Offsets.Vertical := edtAddButtonVerticalOffset.Value;
      ChromeTabs.Options.Display.AddButton.Offsets.Horizontal := edtAddButtonHorzOffset.Value;
      ChromeTabs.Options.Display.AddButton.HorizontalOffsetFloating := edtAddButtonFloatingHorzOffset.Value;
      ChromeTabs.Options.Display.AddButton.Height := edtAddButtonHeight.Value;
      ChromeTabs.Options.Display.AddButton.Width := edtAddButtonWidth.Value;

      ChromeTabs.Options.Display.AddButton.ShowPlusSign:= chkShowPlus.Checked;

      ChromeTabs.Options.Display.ScrollButtonLeft.Height := edtLeftScrollButtonHeight.Value;
      ChromeTabs.Options.Display.ScrollButtonLeft.Width := edtLeftScrollButtonWidth.Value;
      ChromeTabs.Options.Display.ScrollButtonLeft.Offsets.Vertical := edtLeftScrollButtonsVerticalOffset.Value;
      ChromeTabs.Options.Display.ScrollButtonLeft.Offsets.Horizontal := edtLeftScrollButtonsHorzOffset.Value;

      ChromeTabs.Options.Display.ScrollButtonRight.Height := edtRightScrollButtonHeight.Value;
      ChromeTabs.Options.Display.ScrollButtonRight.Width := edtRightScrollButtonWidth.Value;
      ChromeTabs.Options.Display.ScrollButtonRight.Offsets.Vertical := edtRightScrollButtonVerticalOffset.Value;
      ChromeTabs.Options.Display.ScrollButtonRight.Offsets.Horizontal := edtRightScrollButtonHorzOffset.Value;

      ChromeTabs.Options.Display.TabContainer.TransparentBackground := chkTransparentBackground.Checked;
      ChromeTabs.Options.Display.TabContainer.PaddingLeft := edtContainerOffsetLeft.Value;
      ChromeTabs.Options.Display.TabContainer.PaddingRight := edtContainerOffsetRight.Value;

      ChromeTabs.Options.Display.TabModifiedGlow.Style := TChromeTabModifiedStyle(cbModifiedGlowStyle.ItemIndex);
      ChromeTabs.Options.Display.TabModifiedGlow.VerticalOffset := edtModifiedGlowVerticalOffset.Value;
      ChromeTabs.Options.Display.TabModifiedGlow.Height := edtModifiedGlowHeight.Value;
      ChromeTabs.Options.Display.TabModifiedGlow.Width := edtModifiedGlowWidth.Value;
      ChromeTabs.Options.Display.TabModifiedGlow.AnimationPeriodMS := edtModifiedGlowAnimationPeriod.Value;
      ChromeTabs.Options.Display.TabModifiedGlow.AnimationUpdateMS := edtModifiedGlowAnimationUpdate.Value;
      ChromeTabs.Options.Display.TabModifiedGlow.EaseType := TChromeTabsEaseType(cbModifiedGlowEaseType.ItemIndex);

      ChromeTabs.Options.Display.TabMouseGlow.Visible := chkMouseGlowVisible.Checked;
      ChromeTabs.Options.Display.TabMouseGlow.Offsets.Vertical := edtMouseGlowVerticalOffset.Value;
      ChromeTabs.Options.Display.TabMouseGlow.Height := edtMouseGlowHeight.Value;
      ChromeTabs.Options.Display.TabMouseGlow.Width := edtMouseGlowWidth.Value;
      ChromeTabs.Options.Display.TabMouseGlow.Offsets.Horizontal := edtMouseGlowHorzOffset.Value;

      ChromeTabs.Options.Display.Tabs.ContentOffsetLeft := edtTabContentMarginLeft.Value;
      ChromeTabs.Options.Display.Tabs.ContentOffsetRight := edtTabContentMarginRight.Value;

      ChromeTabs.Options.Display.Tabs.PinnedWidth := edtPinnedWidth.Value;
      ChromeTabs.Options.Display.Tabs.MaxWidth := edtMaxTabWidth.Value;
      ChromeTabs.Options.Display.Tabs.MinWidth := edtMinTabWidth.Value;
      ChromeTabs.Height := edtTabHeight.Value;
      ChromeTabs.Options.Display.Tabs.OffsetTop := edtTabOffsetTop.Value;
      ChromeTabs.Options.Display.Tabs.OffsetLeft := edtTabOffsetLeft.Value;
      ChromeTabs.Options.Display.Tabs.OffsetBottom := edtTabOffsetBottom.Value;
      ChromeTabs.Options.Display.Tabs.OffsetRight := edtTabOffsetRight.Value;
      ChromeTabs.Options.Display.Tabs.WordWrap := chkTabWordWrap.Checked;
      ChromeTabs.Options.Display.Tabs.TextAlignmentHorizontal := TAlignment(cbTextAlignment.ItemIndex);
      ChromeTabs.Options.Display.Tabs.TextAlignmentVertical := TVerticalAlignment(cbTextVerticalAlignment.ItemIndex);
      ChromeTabs.Options.Display.Tabs.TextTrimType := TTextTrimType(cbTextTrimming.ItemIndex);
      ChromeTabs.Options.Display.Tabs.TabOverlap := edtTabOverlap.Value;
      ChromeTabs.Options.Display.Tabs.SeeThroughTabs := chkSeeThroughTabs.Checked;
      ChromeTabs.Options.Display.Tabs.TabWidthFromContent := chkSetTabWidthsFromCaptions.Checked;
      ChromeTabs.Options.Display.Tabs.ShowPinnedTabText := chkShowTextOnPinnedTabs.Checked;

      ChromeTabs.BiDiMode := TBiDiMode(cbBidiMode.ItemIndex);

      ChromeTabs.LookAndFeel.Tabs.DefaultFont.TextRenderingMode := TTextRenderingHint(cbFontHintMode.ItemIndex);
      ChromeTabs.LookAndFeel.Tabs.DefaultFont.Name := cbFontName.Text;
      ChromeTabs.LookAndFeel.Tabs.DefaultFont.Size := edtFontSize.Value;
      ChromeTabs.LookAndFeel.Tabs.DefaultFont.Color := edtFontColor.Selected;
      ChromeTabs.LookAndFeel.Tabs.DefaultFont.Alpha := edtFontAlpha.Value;

      ChromeTabs.Options.Display.Tabs.CanvasSmoothingMode := TSmoothingMode(cbCanvasSmoothingMode.ItemIndex);

      ChromeTabs.Options.Behaviour.BackgroundDblClickMaximiseRestoreForm := chkBackgroundDoubleClickMaxmise.Checked;
      ChromeTabs.Options.Behaviour.BackgroundDragMovesForm := chkDraggingBackgoundMovesForm.Checked;
      ChromeTabs.Options.Behaviour.TabSmartDeleteResizing := chkSmartResize.Checked;
      ChromeTabs.Options.Behaviour.TabSmartDeleteResizeCancelDelay := edtCloseButtonMouseLeaveDelay.Value;
      ChromeTabs.Options.Behaviour.TabRightClickSelect := chkRightClickSelect.Checked;

      ChromeTabs.Options.Animation.DefaultMovementAnimationTimeMS := edtAnimationStepsMovement.Value;
      ChromeTabs.Options.Animation.DefaultStyleAnimationTimeMS := edtAnimationStepsStyle.Value;
      ChromeTabs.Options.Animation.AnimationTimerInterval := edtAnimationUpdate.Value;
      ChromeTabs.Options.Animation.DefaultMovementEaseType := TChromeTabsEaseType(cbMovementEaseType.ItemIndex);
      ChromeTabs.Options.Animation.DefaultStyleEaseType := TChromeTabsEaseType(cbStyleEaseType.ItemIndex);

      ChromeTabs.Options.Animation.MovementAnimations.TabAdd.UseDefaultEaseType := chkAddTabDefaults.Checked;
      ChromeTabs.Options.Animation.MovementAnimations.TabAdd.UseDefaultAnimationTime := chkAddTabDefaults.Checked;
      ChromeTabs.Options.Animation.MovementAnimations.TabAdd.AnimationTimeMS := edtAddTabTime.Value;
      ChromeTabs.Options.Animation.MovementAnimations.TabAdd.EaseType := TChromeTabsEaseType(cbAddTabEase.ItemIndex);

      ChromeTabs.Options.Animation.MovementAnimations.TabDelete.UseDefaultEaseType := chkDeleteTabDefaults.Checked;
      ChromeTabs.Options.Animation.MovementAnimations.TabDelete.UseDefaultAnimationTime := chkDeleteTabDefaults.Checked;
      ChromeTabs.Options.Animation.MovementAnimations.TabDelete.AnimationTimeMS := edtDeleteTabTime.Value;
      ChromeTabs.Options.Animation.MovementAnimations.TabDelete.EaseType := TChromeTabsEaseType(cbDeleteTabEase.ItemIndex);

      ChromeTabs.Options.Animation.MovementAnimations.TabMove.UseDefaultEaseType := chkMoveTabDefaults.Checked;
      ChromeTabs.Options.Animation.MovementAnimations.TabMove.UseDefaultAnimationTime := chkMoveTabDefaults.Checked;
      ChromeTabs.Options.Animation.MovementAnimations.TabMove.AnimationTimeMS := edtMoveTabTime.Value;
      ChromeTabs.Options.Animation.MovementAnimations.TabMove.EaseType := TChromeTabsEaseType(cbMoveTabEase.ItemIndex);

      ChromeTabs.Options.Scrolling.Enabled := chkScrolling.Checked;
      ChromeTabs.Options.Scrolling.ScrollButtons := TChromeTabScrollButtons(cbScrollButtons.ItemIndex);
      ChromeTabs.Options.Scrolling.ScrollStep := edtScrollSteps.Value;
      ChromeTabs.Options.Scrolling.ScrollRepeatDelay := edtScrollRepeatDelay.Value;
      ChromeTabs.Options.Scrolling.AutoHideButtons := chkAutoHideScrollButtons.Checked;
      ChromeTabs.Options.Scrolling.DragScroll := chkScrollWhileDragging.Checked;
      ChromeTabs.Options.Scrolling.DragScrollOffset := edtDragScrollEdge.Value;
      ChromeTabs.Options.Scrolling.MouseWheelScroll := chkMouseWheelScrolling.Checked;

      ChromeTabs.Options.DragDrop.DragType := TChromeTabDragType(cbDragType.ItemIndex);
      ChromeTabs.Options.DragDrop.DragOutsideImageAlpha := edtDragImageAapha.Value;
      ChromeTabs.Options.DragDrop.DragOutsideDistancePixels := edtDragAwayDistance.Value;
      ChromeTabs.Options.DragDrop.DragStartPixels := edtDragStartPixels.Value;
      ChromeTabs.Options.DragDrop.DragControlImageResizeFactor := StrToFloatDef(edtDragImageResize.Text, 0.5);
      ChromeTabs.Options.DragDrop.DragDisplay := TChromeTabDragDisplay(cbExternalDragDisplay.ItemIndex);
      ChromeTabs.Options.DragDrop.ContrainDraggedTabWithinContainer := chkContrainDraggedTab.Checked;

      ChromeTabs.Options.Display.TabSpinners.AnimationUpdateMS := edtSpinnerAnimationUpdate.Value;
      ChromeTabs.Options.Display.TabSpinners.HideImagesWhenSpinnerVisible := chkHideImagesWhenSpinnerActive.Checked;

      ChromeTabs.Options.Display.TabSpinners.Upload.ReverseDirection := chkSpinnerUploadReverseDirection.Checked;
      ChromeTabs.Options.Display.TabSpinners.Upload.RenderedAnimationStep := edtSpinnerUploadAnimationStep.Value;
      ChromeTabs.Options.Display.TabSpinners.Upload.SweepAngle := edtSpinnerUploadSweepAngle.Value;

      ChromeTabs.Options.Display.TabSpinners.Upload.Position.Width := edtSpinnerUploadWidth.Value;
      ChromeTabs.Options.Display.TabSpinners.Upload.Position.Height := edtSpinnerUploadHeight.Value;
      ChromeTabs.Options.Display.TabSpinners.Upload.Position.Offsets.Horizontal := edtSpinnerUploadOffsetX.Value;
      ChromeTabs.Options.Display.TabSpinners.Upload.Position.Offsets.Vertical := edtSpinnerUploadOffsetY.Value;

      ChromeTabs.Options.Display.TabSpinners.Download.ReverseDirection := chkSpinnerDownloadReverseDirection.Checked;
      ChromeTabs.Options.Display.TabSpinners.Download.RenderedAnimationStep := edtSpinnerDownloadAnimationStep.Value;
      ChromeTabs.Options.Display.TabSpinners.Download.SweepAngle := edtSpinnerDownloadSweepAngle.Value;

      ChromeTabs.Options.Display.TabSpinners.Download.Position.Width := edtSpinnerDownloadWidth.Value;
      ChromeTabs.Options.Display.TabSpinners.Download.Position.Height := edtSpinnerDownloadHeight.Value;
      ChromeTabs.Options.Display.TabSpinners.Download.Position.Offsets.Horizontal := edtSpinnerDownloadOffsetX.Value;
      ChromeTabs.Options.Display.TabSpinners.Download.Position.Offsets.Vertical := edtSpinnerDownloadOffsetY.Value;

      if cbDragCursor.ItemIndex = 0 then
        ChromeTabs.Options.DragDrop.DragCursor := crDefault
      else
        ChromeTabs.Options.DragDrop.DragCursor := crDrag;

      {$IFDEF USE_GLASS_FORM}
      if chkDisplayTopTabsInTitleBar.Checked then
        Self.ChromeTabs := ChromeTabs1
      else
      begin
        Self.ChromeTabs := nil;

        ChromeTabs1.Align := alTop;
        ChromeTabs1.Top := 0;
      end;
      {$ENDIF}

      ChromeTabs.Options.Behaviour.DebugMode := chkDebugLog.Checked;
    finally
      FUpdatingProperties := FALSE;

      ChromeTabs.EndUpdate;
    end;
  end;

  pnlTop.Color := ChromeTabs1.LookAndFeel.Tabs.Active.Style.StopColor;

  {$IFDEF USE_GLASS_FORM}
  if not chkDisplayTopTabsInTitleBar.Checked then
  begin
    GlassFrame.Enabled := chkUseGlass.Checked;
    GlassFrame.Top := edtGlassHeightTop.Value;
  end;

  GlassFrame.Bottom := edtGlassHeightBottom.Value;
  {$ENDIF}
end;

procedure TfrmMain.SpinButton1DownClick(Sender: TObject);
begin
  FCurrentTabs.ScrollOffset := FCurrentTabs.ScrollOffset - 30;
end;

procedure TfrmMain.SpinButton1UpClick(Sender: TObject);
begin
  FCurrentTabs.ScrollOffset := FCurrentTabs.ScrollOffset + 30
end;

procedure TfrmMain.ChromeTabs1ActiveTabChanged(Sender: TObject; ATab: TChromeTab);
begin
  if FCurrentTabs = Sender then
  begin
    TabPropertiesToGUI(FCurrentTabs.ActiveTab);

    FLogOtherEvents.Log('OnActiveTabChanged [TabIndex = %d]', [ATab.Index]);
  end;
end;

procedure TfrmMain.ChromeTabs1ActiveTabChanging(Sender: TObject; AOldTab,
  ANewTab: TChromeTab; var Allow: Boolean);
begin
  if (AOldTab <> nil) and (ANewTab <> nil) then
    FLogOtherEvents.Log('OnActiveTabChanging [OldTabIndex = %d, NewTabIndex = %d]', [AOldTab.Index, ANewTab.Index]);
end;

procedure TfrmMain.ChromeTabs1AfterDrawItem(Sender: TObject;
  const TargetCanvas: TGPGraphics; ItemRect: TRect;
  ItemType: TChromeTabItemType; TabIndex: Integer);
begin
  if (cbSelectTabs.ItemIndex = 0) and (chkEnableEvents.Checked) then
  begin
    IncrementEventListItemCount(8);

    if ItemType = itTabContainer then
      IncrementEventListItemCount(18);
  end;
end;

procedure TfrmMain.ChromeTabs1AnimateMovement(Sender: TObject;
  ChromeTabsControl: TBaseChromeTabsControl; var AnimationTimeMS: Cardinal;
  var EaseType: TChromeTabsEaseType);
begin
  FLogOtherEvents.Log('OnAnimateMovement [Control = %s, AnimationTimeMS = %d, EaseType = %s]', [ChromeTabsControlTypeDescriptions[ChromeTabsControl.ControlType],
                                                                                                AnimationTimeMS,
                                                                                                ChromeTabsEaseTypeDestriptions[EaseType]]);
end;

procedure TfrmMain.ChromeTabs1AnimateStyle(Sender: TObject;
  ChromeTabsControl: TBaseChromeTabsControl; NewDrawState: TDrawState;
  var AnimationTimeMS: Cardinal; var EaseType: TChromeTabsEaseType);
begin
  FLogOtherEvents.Log('OnAnimateStyle [Control = %s, OldState = %s, NewState = %s , AnimationTimeMS = %d, EaseType = %s]', [ChromeTabsControlTypeDescriptions[ChromeTabsControl.ControlType],
                                                                                                 TabDrawStateDescriptions[ChromeTabsControl.DrawState],
                                                                                                 TabDrawStateDescriptions[NewDrawState],
                                                                                                 AnimationTimeMS,
                                                                                                 ChromeTabsEaseTypeDestriptions[EaseType]]);
end;

procedure TfrmMain.ChromeTabs1BeforeDrawItem(Sender: TObject;
  TargetCanvas: TGPGraphics; ItemRect: TRect; ItemType: TChromeTabItemType;
  TabIndex: Integer; var Handled: Boolean);
begin
  //Handled := (not (ItemType in [itTabText, itTabMouseGlow, itTabOutline, itAddButton])) and (TabIndex <> 2);
end;

procedure TfrmMain.ChromeTabs1BeginTabDrag(Sender: TObject; ATab: TChromeTab;
  var Allow: Boolean);
begin
  FLogOtherEvents.Log('OnBeginTabDrag [TabIndex = %d]', [ATab.Index]);
end;

procedure TfrmMain.ChromeTabs1ButtonAddClick(Sender: TObject;
  var Handled: Boolean);
begin
  if chkEnableEvents.Checked then
    FLogOtherEvents.Log('OnButtonAddClick', []);

  GUIToTabProperties(AddTab(TChromeTabs(Sender), edtTabCaption.Text, edtImageIndex.Value));

  Handled := TRUE;
end;

procedure TfrmMain.ChromeTabs1ButtonCloseTabClick(Sender: TObject;
  ATab: TChromeTab; var Close: Boolean);
begin
  FLogOtherEvents.Log('OnButtonCloseTabClick [TabIndex = %d]', [ATab.Index]);
end;

procedure TfrmMain.ChromeTabs1Change(Sender: TObject; ATab: TChromeTab;
  TabChangeType: TTabChangeType);
var
  Text: String;
begin
  if (not (csLoading in ComponentState)) and
     (Sender = FCurrentTabs) then
  begin
    if (TabChangeType = tcAdded) and
       (FCurrentTabs <> nil) then
      GUIToTabProperties(ATab);

    if (chkEnableEvents.Checked) and
       ((not chkIgnorePropertyUpdated.Checked) or
        (TabChangeType <> tcPropertyUpdated)) then
    begin
      Text := TabChangeTypeDescriptions[TabChangeType];

      if ATab <> nil then
        Text := Text + StrTabIndex + IntToStr(ATab.Index);

      FLogChange.Log(Text, []);
    end;
  end;
end;

procedure TfrmMain.UpdateScrollBar;
begin
  if FCurrentTabs <> nil then
  begin
    FUpdatingScrollbar := TRUE;
    try
      sbScrollOffset.Min := 0;

      if FCurrentTabs.MaxScrollOffset > 0 then
        sbScrollOffset.Max := FCurrentTabs.MaxScrollOffset
      else
        sbScrollOffset.Max := 1;

      sbScrollOffset.Position := FCurrentTabs.ScrollOffset;

      UpdateScrollbarLabel;
    finally
      FUpdatingScrollbar := FALSE;
    end;
  end;
end;

procedure TfrmMain.UpdateScrollbarLabel;
begin
  lblScrollOffset.Caption := IntToStr(FCurrentTabs.ScrollOffset) + ' / ' + IntToStr(FCurrentTabs.MaxScrollOffset);
end;

procedure TfrmMain.ChromeTabs1CreateDragForm(Sender: TObject; ATab: TChromeTab;
  var DragForm: TForm);
begin
  FLogOtherEvents.Log('OnCreateDragForm [TabIndex = %d]', [ATab.Index]);
end;

procedure TfrmMain.ChromeTabs1DebugLog(Sender: TObject; const Text: string);
begin
  if (Sender = FCurrentTabs) and (chkDebugLog.Checked) then
    FLogDebug.Log(Text, []);
end;

procedure TfrmMain.ChromeTabs1EndTabDrag(Sender: TObject;
  Destination: TCustomChromeTabs; ATab: TChromeTab; var Cancel: Boolean);
begin
  FLogOtherEvents.Log('OnEndTabDrag [TabIndex = %d]', [ATab.Index]);
end;

procedure TfrmMain.ChromeTabs1Enter(Sender: TObject);
begin
  FLogOtherEvents.Log('OnEnter', []);
end;

procedure TfrmMain.ChromeTabs1Exit(Sender: TObject);
begin
  FLogOtherEvents.Log('OnExit', []);
end;

procedure TfrmMain.ChromeTabs1GetControlPolygons(Sender,
  ChromeTabsControl: TObject; ItemRect: TRect; ItemType: TChromeTabItemType;
  Orientation: TTabOrientation; var Polygons: IChromeTabPolygons);
var
  ChromeTabControl: TBaseChromeTabsControl;
  TabTop: Integer;
begin
  // A very basic demo of how to alter the shape of the tabs
  if (chkCustomTabShapes <> nil) and (chkCustomTabShapes.Checked) then
  begin
    if (ItemType = itTab) and
       (ChromeTabsControl is TBaseChromeTabsControl) then
    begin
      ChromeTabControl := ChromeTabsControl as TBaseChromeTabsControl;

      Polygons := TChromeTabPolygons.Create;

      TabTop := 0;

      if (ChromeTabControl is TChromeTabControl) and
         (not TChromeTabControl(ChromeTabControl).ChromeTab.GetActive) then
        Inc(TabTop, 3);

      Polygons.AddPolygon(ChromeTabControl.NewPolygon(ChromeTabControl.BidiControlRect,
                                                      [Point(0, RectHeight(ItemRect)),
                                                       Point(0, TabTop),
                                                       Point(RectWidth(ItemRect), TabTop),
                                                       Point(RectWidth(ItemRect), RectHeight(ItemRect))],
                                   Orientation),
                                   nil,
                                   nil);
    end;
  end;
end;

procedure TfrmMain.ChromeTabs1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FLogOtherEvents.Log('OnMouseDown', []);
end;

procedure TfrmMain.ChromeTabs1MouseEnter(Sender: TObject);
begin
  FLogOtherEvents.Log('OnMouseEnter', []);
end;

procedure TfrmMain.ChromeTabs1MouseLeave(Sender: TObject);
begin
  FLogOtherEvents.Log('OnMouseLeave', []);
end;

procedure TfrmMain.ChromeTabs1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

  procedure AddLine(const Description: string; const Value: Variant);
  begin
    FLogMouseMove.Log(Description + ': ' + VarToStr(Value), []);
  end;

var
  HitTestResult: THitTestResult;
  TabControl: TChromeTabControl;
  Tabs: TChromeTabs;
begin
  if (X <> FLastMouseX) or (Y <> FLastMouseY) then
  begin
    Tabs := TChromeTabs(Sender);

    FLastMouseX := X;
    FLastMouseY := Y;

    HitTestResult := Tabs.HitTest(Point(X, Y));

    FLogMouseMove.BeginUpdate;
    try
      FLogMouseMove.Clear;

      AddLine(StrMouseX, X);
      AddLine(StrMouseY, Y);
      AddLine(StrHitTestArea, HitTestDescriptions[HitTestResult.HitTestArea]);
      AddLine(StrHitTestTabIndex, HitTestResult.TabIndex);

      TabControl := Tabs.TabControls[HitTestResult.TabIndex];

      if Assigned(TabControl) then
      begin
        AddLine(StrTabDrawState, TabDrawStateDescriptions[TabControl.DrawState]);
        AddLine(StrCloseButtonDrawSt, TabDrawStateDescriptions[TabControl.CloseButtonState]);
      end;
    finally
      FLogMouseMove.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.ChromeTabs1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FLogOtherEvents.Log('OnMouseUp', []);
end;

procedure TfrmMain.ChromeTabs1NeedDragImageControl(Sender: TObject;
  ATab: TChromeTab; var DragControl: TWinControl);
begin
  if chkEnableEvents.Checked then
    FLogOtherEvents.Log('OnNeedDragImageControl [TabIndex = %d]', [ATab.Index]);

  DragControl := pcMain;
end;

procedure TfrmMain.ChromeTabs1ScrollWidthChanged(Sender: TObject);
begin
  UpdateScrollBar;
end;

procedure TfrmMain.ChromeTabs1SetTabWidth(Sender: TObject;
  ATabControl: TChromeTabControl; var TabWidth: Integer);
begin
  FLogOtherEvents.Log('OnSetTabWidth [TabIndex = %d, TabWidth= %d]', [ATabControl.ChromeTab.GetIndex, TabWidth]);
end;

procedure TfrmMain.ChromeTabs1ShowHint(Sender: TObject;
  HitTestResult: THitTestResult; var HintText: string;
  var HintTimeout: Integer);
begin
  FLogOtherEvents.Log('OnShowHint [HitTestArea: %s, TabIndex = %d, HintText = %s, HintTimeout = %d]', [HitTestDescriptions[HitTestResult.HitTestArea],
                                                                                                        HitTestResult.TabIndex,
                                                                                                        HintText,
                                                                                                        HintTimeout]);
end;

procedure TfrmMain.ChromeTabs1StateChange(Sender: TObject; PreviousState,
  CurrentState: TChromeTabStates);
begin
  if CurrentState = [] then
    edtStates.Text := 'None'
  else
    edtStates.Text := ChromeTabStatesToString(CurrentState);
end;

procedure TfrmMain.ChromeTabs1TabClientRectChanged(Sender: TObject);
begin
  UpdateScrollBar;
end;

procedure TfrmMain.ChromeTabs1TabDblClick(Sender: TObject; ATab: TChromeTab);
begin
  FLogOtherEvents.Log('OnTabDblClick [TabIndex = %d]', [ATab.Index]);
end;

procedure TfrmMain.ChromeTabs1TabDragDrop(Sender: TObject; X, Y: Integer;
  DragTabObject: IDragTabObject; Cancelled: Boolean;
  var TabDropOptions: TTabDropOptions);
begin
  FLogOtherEvents.Log('OnTabDragDrop ', []);

  lbTabDragOver.Clear;

  ProcessDroppedTab(Sender, X, Y, DragTabObject, Cancelled, TabDropOptions);
end;

procedure TfrmMain.ProcessDroppedTab(Sender: TObject; X, Y: Integer;
  DragTabObject: IDragTabObject; Cancelled: Boolean;
  var TabDropOptions: TTabDropOptions);
var
  WinX, WinY: Integer;
  NewForm: TfrmMain;
begin
  // Make sure that the drag drop hasn't been cancelled and that
  // we are not dropping on a TChromeTab control
  if (not Cancelled) and
     (DragTabObject.SourceControl <> DragTabObject.DockControl) and
     (DragTabObject.DockControl = nil) then
  begin
    // Find the drop position
    WinX := Mouse.CursorPos.X - DragTabObject.DragCursorOffset.X - ((Width - ClientWidth) div 2);
    WinY := Mouse.CursorPos.Y - DragTabObject.DragCursorOffset.Y - (Height - ClientHeight) + ((Width - ClientWidth) div 2);

    // Create a new form
    NewForm := TfrmMain.Create(Application);

    // Set the new form position
    NewForm.Position := poDesigned;
    NewForm.Left := WinX;
    NewForm.Top := WinY;

    // Show the form
    NewForm.Show;

    // Remove the original tab
    TabDropOptions := [tdDeleteDraggedTab];
  end;
end;

procedure TfrmMain.ChromeTabs1TabDragDropped(Sender: TObject;
  DragTabObject: IDragTabObject; NewTab: TChromeTab);
begin
  FLogOtherEvents.Log('OnTabDragDropped [NewTabIndex = %d]', [NewTab.Index]);
end;

procedure TfrmMain.ChromeTabs1TabDragOver(Sender: TObject; X, Y: Integer;
  State: TDragState; DragTabObject: IDragTabObject; var Accept: Boolean);

  procedure AddLine(const Description: string; const Value: Variant);
  begin
    FLogDragOver.Log(Description + ': ' + VarToStr(Value), []);
  end;

var
  HitTestResult: THitTestResult;
  Tabs: TChromeTabs;
begin
  Tabs := TChromeTabs(Sender);

  HitTestResult := Tabs.HitTest(Point(X, Y));

  FLogDragOver.BeginUpdate;
  try
    FLogDragOver.Clear;

    if Tabs.ActiveDragTabObject <> nil then
    begin
      AddLine(StrDragging, StrActive);
      AddLine(StrTabCaption, Tabs.ActiveDragTabObject.DragTab.Caption);
      AddLine(StrTabIndex, Tabs.ActiveDragTabObject.DragTab.Index);
      AddLine(StrHorizontalOffset, Tabs.ActiveDragTabObject.DragCursorOffset.X);
      AddLine(StrVerticalOffset, Tabs.ActiveDragTabObject.DragCursorOffset.Y);
      AddLine(StrDropTabIndex, Tabs.ActiveDragTabObject.DropTabIndex);

      AddLine(StrSourceControl, Tabs.ActiveDragTabObject.SourceControl.GetControl.Name);

      if Tabs.ActiveDragTabObject.DockControl = nil then
        AddLine(StrDockControl, StrNone)
      else
        AddLine(StrDockControl, Tabs.ActiveDragTabObject.DockControl.GetControl.Name);
    end;
  finally
    FLogDragOver.EndUpdate;
  end;
end;

procedure TfrmMain.ChromeTabs1TabDragStart(Sender: TObject; ATab: TChromeTab;
  var Allow: Boolean);
begin
  FLogOtherEvents.Log('OnTabDragStart [TabIndex = %d]', [ATab.Index]);

  Allow := TRUE;
end;

procedure TfrmMain.ChromeTabs2AfterDrawItem(Sender: TObject;
  const TargetCanvas: TGPGraphics; ItemRect: TRect;
  ItemType: TChromeTabItemType; TabIndex: Integer);
var
  TabsTxtBrush: TGPSolidBrush;
  GPRect: TGPRect;
  TxtFormat: TGPStringFormat;
  TabsFont: TGPFont;
begin
  if (cbSelectTabs.ItemIndex = 1) and (chkEnableEvents.Checked) then
  begin
    IncrementEventListItemCount(8);

    if ItemType = itTabContainer then
      IncrementEventListItemCount(18);
  end;

  if (ChromeTabs2.Tabs.Count = 0) and (ItemType = itTabContainer) and (ChromeTabs2.ActiveDragTabObject = nil) then
  begin
    TabsFont := TGPFont.Create(ChromeTabs2.LookAndFeel.Tabs.DefaultFont.Name, 11);
    TabsTxtBrush := TGPSolidBrush.Create(MakeGDIPColor(clWhite, 255));
    try
      TargetCanvas.SetSmoothingMode(ChromeTabs2.Options.Display.Tabs.CanvasSmoothingMode);

      GPRect.X := ItemRect.Left;
      GPRect.Y := ItemRect.Top;
      GPRect.Width := RectWidth(ItemRect);
      GPRect.Height := RectHeight(ItemRect);

      TxtFormat := TGPStringFormat.Create();
      try
        TargetCanvas.SetTextRenderingHint(ChromeTabs2.LookAndFeel.Tabs.DefaultFont.TextRenderingMode);

        TxtFormat.SetLineAlignment(StringAlignmentCenter);
        TxtFormat.SetAlignment(StringAlignmentCenter);

        // Draw the text
        TargetCanvas.DrawString(PChar(StrDragAndDropTabs),
                              Length(StrDragAndDropTabs),
                              TabsFont,
                              RectToGPRectF(Rect(0, 0, RectWidth(ItemRect), RectHeight(ItemRect))),
                              TxtFormat,
                              TabsTxtBrush);
      finally
        FreeAndNil(TxtFormat);
      end;
    finally
      FreeAndNil(TabsFont);
      FreeAndNil(TabsTxtBrush);
    end;
  end;
end;

procedure TfrmMain.ChromeTabs2TabDragDrop(Sender: TObject; X, Y: Integer;
  DragTabObject: IDragTabObject; Cancelled: Boolean;
  var TabDropOptions: TTabDropOptions);
begin
  ProcessDroppedTab(Sender, X, Y, DragTabObject, Cancelled, TabDropOptions);
end;

procedure TfrmMain.UpdateControls;
begin
  edtGlassHeightTop.Enabled := chkUseGlass.Checked;
  edtGlassHeightBottom.Enabled := chkUseGlass.Checked;

  EnableControlAndChildren(pnlScroll, chkScrolling.Checked);
  EnableControlAndChildren(pnlDragDrop, cbDragType.ItemIndex > 0);
  EnableControlAndChildren(pnlMouseGlow, chkMouseGlowVisible.Checked);

  edtCloseButtonMouseLeaveDelay.Enabled := chkSmartResize.Checked;

  edtDragScrollEdge.Enabled := chkScrolling.Checked and chkScrollWhileDragging.Checked;

  edtAddTabTime.Enabled := not chkAddTabDefaults.Checked;
  cbAddTabEase.Enabled := not chkAddTabDefaults.Checked;

  edtDeleteTabTime.Enabled := not chkDeleteTabDefaults.Checked;
  cbDeleteTabEase.Enabled := not chkDeleteTabDefaults.Checked;

  edtMoveTabTime.Enabled := not chkMoveTabDefaults.Checked;
  cbMoveTabEase.Enabled := not chkMoveTabDefaults.Checked;
end;

end.
