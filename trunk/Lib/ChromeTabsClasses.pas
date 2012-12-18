unit ChromeTabsClasses;

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
  Windows, Classes, SysUtils, ImgList, Controls, Graphics, Forms, Contnrs,

  GDIPObj, GDIPAPI,

  ChromeTabsUtils,
  ChromeTabsTypes;

type
  TChromeTab = class;
  TChromeTabsLookAndFeelStyle = class;
  IChromeTabs = interface;
  IDragTabObject = interface;

  IChromeTab = interface
    ['{B1B1F10B-3E5C-4A9E-B62F-8C322C803902}']
    function GetCaption: TCaption;
    function GetImageIndex: TImageIndex;
    function GetImageIndexOverlay: TImageIndex;
    function GetActive: Boolean;
    function GetPinned: Boolean;
    function GetIndex: Integer;
    function GetModified: Boolean;
    function GetTab: TChromeTab;
    function GetMarkedForDeletion: Boolean;
  end;

  TChromeTabPolygon = class(TObject)
  private
    FPolygon: TPolygon;
    FBrush: TGPBrush;
    FPen: TGPPen;
  public
    property Polygon: TPolygon read FPolygon write FPolygon;
    property Brush: TGPBrush read FBrush write FBrush;
    property Pen: TGPPen read FPen write FPen;
  end;

  IChromeTabPolygons = interface
    ['{F8B75D11-75AE-4871-90CC-EDC298F2CE8D}']
    function GetPolygonCount: Integer;
    function GetPolygons(Index: Integer): TChromeTabPolygon;

    function AddPolygon(Polygon: TPolygon; Brush: TGPBrush; Pen: TGPPen): IChromeTabPolygons;
    procedure DrawTo(TargetCanvas: TGPGraphics; DrawToFunctions: TDrawToFunctions = dfBrushAndPen);

    property PolygonCount: Integer read GetPolygonCount;
    property Polygons[Index: Integer]: TChromeTabPolygon read GetPolygons;
  end;

  TChromeTabPolygons = class(TInterfacedObject, IChromeTabPolygons)
  private
    FPolygons: TObjectList;

    function GetPolygonCount: Integer;
    function GetPolygons(Index: Integer): TChromeTabPolygon;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function AddPolygon(Polygon: TPolygon; Brush: TGPBrush; Pen: TGPPen): IChromeTabPolygons; virtual;
    procedure DrawTo(TargetCanvas: TGPGraphics; DrawToFunctions: TDrawToFunctions = dfBrushAndPen); virtual;

    property PolygonCount: Integer read GetPolygonCount;
    property Polygons[Index: Integer]: TChromeTabPolygon read GetPolygons;
  end;

  TChromeTab = class(TCollectionItem, IChromeTab)
  private
    // These dummy functions are required so we can implement an interface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  private
    FCollection: TCollection;
    FCaption: TCaption;
    FData: Pointer;
    FImageIndex: TImageIndex;
    FImageIndexOverlay: TImageIndex;
    FTag: integer;
    FPinned: Boolean;
    FTabControl: TObject;
    FActive: Boolean;
    FVisible: Boolean;
    FModified: Boolean;
    FMarkedForDeletion: Boolean;

    procedure SetActive(Value: boolean);
    procedure SetCaption(Value: TCaption);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetTag(const Value: integer);
    procedure SetPinned(const Value: Boolean);
    procedure SetImageIndexOverlay(const Value: TImageIndex);
    procedure SetVisible(const Value: Boolean);
    procedure SetModified(const Value: Boolean);

    function GetDisplayCaption: String;
    function GetCaption: TCaption;
    function GetImageIndex: TImageIndex;
    function GetImageIndexOverlay: TImageIndex;
    function GetActive: boolean;
    function GetPinned: Boolean;
    function GetIndex: Integer;
    function GetTag: integer;
    function GetVisible: Boolean;
    function GetModified: Boolean;
    function GetTab: TChromeTab;
    function GetMarkedForDeletion: Boolean;
  protected
    procedure DoChanged(ChangeType: TTabChangeType = tcPropertyUpdated); virtual;
    function GetDisplayName: string; override;
    function GetChromeTabInterface: IChromeTabs;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function ImageIsVisible: Boolean;

    property Data: Pointer read FData write FData;
    property DisplayCaption: String read GetDisplayCaption;

    property TabControl: TObject read FTabControl write FTabControl;
  published
    property Caption: TCaption read GetCaption write SetCaption;
    property Active: boolean read GetActive write SetActive;
    property Tag: integer read GetTag write SetTag;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex;
    property ImageIndexOverlay: TImageIndex read GetImageIndexOverlay write SetImageIndexOverlay;
    property Pinned: Boolean read GetPinned write SetPinned;
    property Visible: Boolean read GetVisible write SetVisible;
    property Modified: Boolean read GetModified write SetModified;
    property MarkedForDeletion: Boolean read GetMarkedForDeletion;
  end;

  TChromeTabClass = class of TChromeTab;

  TChromeTabsList = class(TOwnedCollection)
  private
    function GetActiveTab: TChromeTab;
    procedure SetActiveTab(const Value: TChromeTab);
  protected
    procedure SetItem(Index: Integer; Value: TChromeTab);
    function GetItem(Index: Integer): TChromeTab;
    procedure InternalDelete(Index: Integer; DeleteNow: Boolean);

    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;

    function GetChromeTabInterface: IChromeTabs; virtual;
  public
    constructor Create(AOwner: TComponent);

    function IndexOf(ATab: TChromeTab): integer;
    property Items[Index: Integer]: TChromeTab read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
    procedure DeleteNow(Index: Integer);
    procedure Move(OldIndex, NewIndex: Integer);
    procedure Assign(Source: TPersistent); override;
    function Add: TChromeTab; virtual;

    property ActiveTab: TChromeTab read GetActiveTab write SetActiveTab;
  end;

  TChromeTabsPersistent = class(TPersistent)
  private
    FOwner: TPersistent;
  protected
    FInvalidated: Boolean;

    function GetOwner: TPersistent; override;
    procedure DoChanged; virtual;
  public
    constructor Create(AOwner: TPersistent); virtual;

    procedure Invalidate; virtual;

    property Owner: TPersistent read FOwner;
  end;

  TChromeTabsLookAndFeelStyle = class(TChromeTabsPersistent)
  private
    FStartColor: TColor;
    FStopColor: TColor;
    FStartAlpha: Byte;
    FStopAlpha: Byte;
    FBrush: TGPLinearGradientBrush;
    FPen: TGPPen;
    FOutlineColor: TColor;
    FOutlineAlpha: Byte;
    FOutlineSize: Single;
    FPenInvalidated: Boolean;

    procedure SetStartColor(const Value: TColor);
    procedure SetStopColor(const Value: TColor);
    procedure SetStartAlpha(const Value: Byte);
    procedure SetOutlineColor(const Value: TColor);
    procedure SetOutlineSize(const Value: Single);
    procedure SetStopAlpha(const Value: Byte);
    procedure SetOutlineAlpha(const Value: Byte);
  public
    function GetBrush(ClientRect: TRect): TGPLinearGradientBrush;
    function GetPen: TGPPen;

    procedure Invalidate; override;
  published
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    property StartColor: TColor read FStartColor write SetStartColor;
    property StopColor: TColor read FStopColor write SetStopColor;
    property StartAlpha: Byte read FStartAlpha write SetStartAlpha;
    property StopAlpha: Byte read FStopAlpha write SetStopAlpha;
    property OutlineColor: TColor read FOutlineColor write SetOutlineColor;
    property OutlineSize: Single read FOutlineSize write SetOutlineSize;
    property OutlineAlpha: Byte read FOutlineAlpha write SetOutlineAlpha;
  end;

  TChromeTabsLookAndFeelPen = class(TChromeTabsPersistent)
  private
    FColor: TColor;
    FThickness: Single;
    FAlpha: Integer;
    FPen: TGPPen;
  private
    procedure SetColor(const Value: TColor);
    procedure SetThickness(const Value: Single);
    procedure SetAlpha(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;

    function GetPen: TGPPen;

    procedure Invalidate; override;
  published
    property Color: TColor read FColor write SetColor;
    property Thickness: Single read FThickness write SetThickness;
    property Alpha: Integer read FAlpha write SetAlpha;
  end;

  TChromeTabsLookAndFeelBaseFont = class(TChromeTabsPersistent)
  private
    FName: TFontName;
    FColor: TColor;
    FSize: Integer;
    FAlpha: Byte;
    FTextRendoringMode: TTextRenderingHint;

    procedure SetAlpha(const Value: Byte);
    procedure SetColor(const Value: TColor);
    procedure SetName(const Value: TFontName);
    procedure SetSize(const Value: Integer);
    procedure SetTextRendoringMode(const Value: TTextRenderingHint);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property Name: TFontName read FName write SetName;
    property Color: TColor read FColor write SetColor;
    property Size: Integer read FSize write SetSize;
    property Alpha: Byte read FAlpha write SetAlpha;
    property TextRendoringMode: TTextRenderingHint read FTextRendoringMode write SetTextRendoringMode;
  end;

  TChromeTabsLookAndFeelFont = class(TChromeTabsLookAndFeelBaseFont)
  private
    FUseDefaultFont: Boolean;

    procedure SetUseDefaultFont(const Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property UseDefaultFont: Boolean read FUseDefaultFont write SetUseDefaultFont;
  end;

  TChromeTabsLookAndFeelStyleProperties = class(TChromeTabsPersistent)
  private
    FFont: TChromeTabsLookAndFeelFont;
    FStyle: TChromeTabsLookAndFeelStyle;

    procedure SetFont(const Value: TChromeTabsLookAndFeelFont);
    procedure SetStyle(const Value: TChromeTabsLookAndFeelStyle);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Font: TChromeTabsLookAndFeelFont read FFont write SetFont;
    property Style: TChromeTabsLookAndFeelStyle read FStyle write SetStyle;
  end;

  TChromeTabsCustomLookAndFeelStylePropertyItems = class(TChromeTabsPersistent)
  private
    FStyleProperty1: TChromeTabsLookAndFeelStyleProperties;
    FStyleProperty2: TChromeTabsLookAndFeelStyleProperties;
    FStyleProperty3: TChromeTabsLookAndFeelStyleProperties;
  protected
    procedure SetStyleProperty2(const Value: TChromeTabsLookAndFeelStyleProperties);
    procedure SetStyleProperty3(const Value: TChromeTabsLookAndFeelStyleProperties);
    procedure SetStyleProperty1(const Value: TChromeTabsLookAndFeelStyleProperties);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  protected
    property Active: TChromeTabsLookAndFeelStyleProperties read FStyleProperty1 write SetStyleProperty1;
    property NotActive: TChromeTabsLookAndFeelStyleProperties read FStyleProperty2 write SetStyleProperty2;
    property Hot: TChromeTabsLookAndFeelStyleProperties read FStyleProperty3 write SetStyleProperty3;
  end;

  TChromeTabsLookAndFeelGlow = class(TChromeTabsPersistent)
  private
    FCentreColor: TColor;
    FOutsideColor: TColor;
    FCentreAlpha: Byte;
    FOutsideAlpha: Byte;

    procedure SetCentreAlpha(const Value: Byte);
    procedure SetCentreColor(const Value: TColor);
    procedure SetOutsideAlpha(const Value: Byte);
    procedure SetOutsideColor(const Value: TColor);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property CentreColor: TColor read FCentreColor write SetCentreColor;
    property OutsideColor: TColor read FOutsideColor write SetOutsideColor;
    property CentreAlpha: Byte read FCentreAlpha write SetCentreAlpha;
    property OutsideAlpha: Byte read FOutsideAlpha write SetOutsideAlpha;
  end;

  TChromeTabsLookAndFeelTab = class(TChromeTabsCustomLookAndFeelStylePropertyItems)
  private
    FBaseLine: TChromeTabsLookAndFeelPen;
    FModified: TChromeTabsLookAndFeelGlow;
    FDefaultFont: TChromeTabsLookAndFeelBaseFont;
    FMouseGlow: TChromeTabsLookAndFeelGlow;

    procedure SetBaseLine(const Value: TChromeTabsLookAndFeelPen);
    procedure SetModified(const Value: TChromeTabsLookAndFeelGlow);
    procedure SetDefaultFont(const Value: TChromeTabsLookAndFeelBaseFont);
    procedure SetMouseGlow(const Value: TChromeTabsLookAndFeelGlow);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property BaseLine: TChromeTabsLookAndFeelPen read FBaseLine write SetBaseLine;
    property Modified: TChromeTabsLookAndFeelGlow read FModified write SetModified;
    property DefaultFont: TChromeTabsLookAndFeelBaseFont read FDefaultFont write SetDefaultFont;
    property MouseGlow: TChromeTabsLookAndFeelGlow read FMouseGlow write SetMouseGlow;
    property Active;
    property NotActive;
    property Hot;
  end;

  TChromeTabsLookAndFeelCustomStyleItems = class(TChromeTabsPersistent)
  protected
    FStyleProperty1: TChromeTabsLookAndFeelStyle;
    FStyleProperty2: TChromeTabsLookAndFeelStyle;
    FStyleProperty3: TChromeTabsLookAndFeelStyle;

    procedure SetStyleProperty1(const Value: TChromeTabsLookAndFeelStyle);
    procedure SetStyleProperty2(const Value: TChromeTabsLookAndFeelStyle);
    procedure SetStyleProperty3(const Value: TChromeTabsLookAndFeelStyle);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  protected
    property Normal: TChromeTabsLookAndFeelStyle read FStyleProperty1 write SetStyleProperty1;
    property Down: TChromeTabsLookAndFeelStyle read FStyleProperty2 write SetStyleProperty2;
    property Hot: TChromeTabsLookAndFeelStyle read FStyleProperty3 write SetStyleProperty3;
  end;

  TChromeTabsCustomLookAndFeelPenItem = class(TChromeTabsPersistent)
  protected
    FPen1: TChromeTabsLookAndFeelPen;
    FPen2: TChromeTabsLookAndFeelPen;
    FPen3: TChromeTabsLookAndFeelPen;

    procedure SetPen1(const Value: TChromeTabsLookAndFeelPen);
    procedure SetPen2(const Value: TChromeTabsLookAndFeelPen);
    procedure SetPen3(const Value: TChromeTabsLookAndFeelPen);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  protected
    property Pen1: TChromeTabsLookAndFeelPen read FPen1 write SetPen1;
    property Pen2: TChromeTabsLookAndFeelPen read FPen2 write SetPen2;
    property Pen3: TChromeTabsLookAndFeelPen read FPen3 write SetPen3;
  end;

  TChromeTabsLookAndFeelPenItem = class(TChromeTabsCustomLookAndFeelPenItem)
  published
    property Normal: TChromeTabsLookAndFeelPen read FPen1 write SetPen1;
    property Down: TChromeTabsLookAndFeelPen read FPen2 write SetPen2;
    property Hot: TChromeTabsLookAndFeelPen read FPen3 write SetPen3;
  end;

  TChromeTabsLookAndFeelButtonItems = class(TChromeTabsLookAndFeelCustomStyleItems)
  published
    property Normal;
    property Down;
    property Hot;
  end;

  TChromeTabsLookAndFeelDisabledButton = class(TChromeTabsLookAndFeelButtonItems)
  private
    FDisabled: TChromeTabsLookAndFeelStyle;
  protected
    procedure SetDisabled(const Value: TChromeTabsLookAndFeelStyle);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Disabled: TChromeTabsLookAndFeelStyle read FDisabled write SetDisabled;
  end;

  TChromeTabsLookAndFeelAddButton = class(TChromeTabsPersistent)
  private
    FButton: TChromeTabsLookAndFeelButtonItems;
    FPlusSign: TChromeTabsLookAndFeelButtonItems;
  private
    procedure SetButton(const Value: TChromeTabsLookAndFeelButtonItems);
    procedure SetPlusSign(const Value: TChromeTabsLookAndFeelButtonItems);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Button: TChromeTabsLookAndFeelButtonItems read FButton write SetButton;
    property PlusSign: TChromeTabsLookAndFeelButtonItems read FPlusSign write SetPlusSign;
  end;

  TChromeTabsLookAndFeelCloseButton = class(TChromeTabsPersistent)
  private
    FCross: TChromeTabsLookAndFeelPenItem;
    FCircle: TChromeTabsLookAndFeelButtonItems;

    procedure SetCircle(const Value: TChromeTabsLookAndFeelButtonItems);
    procedure SetCross(const Value: TChromeTabsLookAndFeelPenItem);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Cross: TChromeTabsLookAndFeelPenItem read FCross write SetCross;
    property Circle: TChromeTabsLookAndFeelButtonItems read FCircle write SetCircle;
  end;

  TChromeTabsLookAndFeelScrollButton = class(TChromeTabsPersistent)
  private
    FButton: TChromeTabsLookAndFeelDisabledButton;
    FArrow: TChromeTabsLookAndFeelDisabledButton;

    procedure SetArrow(const Value: TChromeTabsLookAndFeelDisabledButton);
    procedure SetButton(const Value: TChromeTabsLookAndFeelDisabledButton);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Button: TChromeTabsLookAndFeelDisabledButton read FButton write SetButton;
    property Arrow: TChromeTabsLookAndFeelDisabledButton read FArrow write SetArrow;
  end;

  TChromeTabsLookAndFeel = class(TChromeTabsPersistent)
  private
    FTabs: TChromeTabsLookAndFeelTab;
    FTabsContainer: TChromeTabsLookAndFeelStyle;
    FCloseButton: TChromeTabsLookAndFeelCloseButton;
    FAddButton: TChromeTabsLookAndFeelAddButton;
    FScrollButtons: TChromeTabsLookAndFeelScrollButton;
    FTabSkin: TTabSkin;

    procedure SetTabSkin(const Value: TTabSkin);
    procedure SetTabsContainer(const Value: TChromeTabsLookAndFeelStyle);
    procedure SetTabSkinValues(TabSkin: TTabSkin);
    procedure SetScrollButtons(const Value: TChromeTabsLookAndFeelScrollButton);
    procedure SetAddButton(const Value: TChromeTabsLookAndFeelAddButton);
    procedure SetCloseButton(const Value: TChromeTabsLookAndFeelCloseButton);
    procedure SetTabs(const Value: TChromeTabsLookAndFeelTab);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Skin: TTabSkin read FTabSkin write SetTabSkin;
    property TabsContainer: TChromeTabsLookAndFeelStyle read FTabsContainer write SetTabsContainer;
    property Tabs: TChromeTabsLookAndFeelTab read FTabs write SetTabs;
    property CloseButton: TChromeTabsLookAndFeelCloseButton read FCloseButton write SetCloseButton;
    property AddButton: TChromeTabsLookAndFeelAddButton read FAddButton write SetAddButton;
    property ScrollButtons: TChromeTabsLookAndFeelScrollButton read FScrollButtons write SetScrollButtons;
  end;

  IChromeTabDockControl = interface
    ['{CFC0D4E4-C0AE-4713-B424-2D5DE4FC5EF9}']
    function GetControl: TWinControl;
    procedure TabDragOver(Sender: TObject; X, Y: Integer; State: TDragState; DragTabObject: IDragTabObject; var Accept: Boolean);
    procedure TabDragDrop(Sender: TObject; X, Y: Integer; DragTabObject: IDragTabObject; Cancelled: Boolean; var TabDropOptions: TTabDropOptions);
    function InsertDroppedTab: TChromeTab;
    procedure FireScrollTimer;
    procedure DragCompleted;
    function GetBidiMode: TBiDiMode;
  end;

  IDragTabObject = interface
    ['{688BB6B4-6286-4488-815A-920D32E60B1F}']
    function GetDragCursorOffset: TPoint;
    function GetDragForm: TForm;
    function GetDragFormOffset: TPoint;
    function GetDragPoint: TPoint;
    function GetDragTab: TChromeTab;
    function GetDropTabIndex: Integer;
    function GetHideAddButton: Boolean;
    function GetOriginalControlRect: TRect;
    function GetSourceControl: IChromeTabDockControl;
    function GetDockControl: IChromeTabDockControl;
    function GetOriginalCursor: TCursor;

    procedure SetDragCursorOffset(const Value: TPoint);
    procedure SetDragForm(const Value: TForm);
    procedure SetDragFormOffset(const Value: TPoint);
    procedure SetDragPoint(const Value: TPoint);
    procedure SetDragTab(const Value: TChromeTab);
    procedure SetDropTabIndex(const Value: Integer);
    procedure SetHideAddButton(const Value: Boolean);
    procedure SetOriginalControlRect(const Value: TRect);
    procedure SetSourceControl(const Value: IChromeTabDockControl);
    procedure SetDockControl(const Value: IChromeTabDockControl);
    procedure SetOriginalCursor(const Value: TCursor);

    property DragTab: TChromeTab read GetDragTab write SetDragTab;
    property DragCursorOffset: TPoint read GetDragCursorOffset write SetDragCursorOffset;
    property DragFormOffset: TPoint read GetDragFormOffset write SetDragFormOffset;
    property DragPoint: TPoint read GetDragPoint write SetDragPoint;
    property HideAddButton: Boolean read GetHideAddButton write SetHideAddButton;
    property OriginalControlRect: TRect read GetOriginalControlRect write SetOriginalControlRect;
    property DropTabIndex: Integer read GetDropTabIndex write SetDropTabIndex;
    property DragForm: TForm read GetDragForm write SetDragForm;
    property SourceControl: IChromeTabDockControl read GetSourceControl write SetSourceControl;
    property DockControl: IChromeTabDockControl read GetDockControl write SetDockControl;
    property OriginalCursor: TCursor read GetOriginalCursor write SetOriginalCursor;
  end;

  TDragTabObject = class(TInterfacedObject, IDragTabObject)
  private
    FDragTab: TChromeTab;
    FDragCursorOffset: TPoint;
    FDragFormOffset: TPoint;
    FDragPoint: TPoint;
    FHideAddButton: Boolean;
    FOriginalControlRect: TRect;
    FDropTabIndex: Integer;
    FDragForm: TForm;
    FSourceControl: IChromeTabDockControl;
    FDockControl: IChromeTabDockControl;
    FOriginalCursor: TCursor;

    function GetDragCursorOffset: TPoint;
    function GetDragForm: TForm;
    function GetDragFormOffset: TPoint;
    function GetDragPoint: TPoint;
    function GetDragTab: TChromeTab;
    function GetDropTabIndex: Integer;
    function GetHideAddButton: Boolean;
    function GetOriginalControlRect: TRect;
    function GetSourceControl: IChromeTabDockControl;
    function GetDockControl: IChromeTabDockControl;
    function GetOriginalCursor: TCursor;

    procedure SetDragCursorOffset(const Value: TPoint);
    procedure SetDragForm(const Value: TForm);
    procedure SetDragFormOffset(const Value: TPoint);
    procedure SetDragPoint(const Value: TPoint);
    procedure SetDragTab(const Value: TChromeTab);
    procedure SetDropTabIndex(const Value: Integer);
    procedure SetHideAddButton(const Value: Boolean);
    procedure SetOriginalControlRect(const Value: TRect);
    procedure SetSourceControl(const Value: IChromeTabDockControl);
    procedure SetDockControl(const Value: IChromeTabDockControl);
    procedure SetOriginalCursor(const Value: TCursor);
  public
    destructor Destroy; override;

    property DragTab: TChromeTab read GetDragTab write SetDragTab;
    property DragCursorOffset: TPoint read GetDragCursorOffset write SetDragCursorOffset;
    property DragFormOffset: TPoint read GetDragFormOffset write SetDragFormOffset;
    property DragPoint: TPoint read GetDragPoint write SetDragPoint;
    property HideAddButton: Boolean read GetHideAddButton write SetHideAddButton;
    property OriginalControlRect: TRect read GetOriginalControlRect write SetOriginalControlRect;
    property DropTabIndex: Integer read GetDropTabIndex write SetDropTabIndex;
    property DragForm: TForm read GetDragForm write SetDragForm;
    property SourceControl: IChromeTabDockControl read GetSourceControl write SetSourceControl;
    property DockControl: IChromeTabDockControl read GetDockControl write SetDockControl;
    property OriginalCursor: TCursor read GetOriginalCursor write SetOriginalCursor;
  end;

  TChromeTabsOffsets = class(TChromeTabsPersistent)
  private
    FVertical: Integer;
    FHorizontal: Integer;
  private
    procedure SetHorizontal(const Value: Integer);
    procedure SetVertical(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property Vertical: Integer read FVertical write SetVertical;
    property Horizontal: Integer read FHorizontal write SetHorizontal;
  end;

  TChromeTabsAddButtonOffsets = class(TChromeTabsOffsets)
  private
    FHorizontalFloating: Integer;

    procedure SetHorizontalFloating(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property HorizontalFloating: Integer read FHorizontalFloating write SetHorizontalFloating;
  end;

  TChromeTabsControlPosition = class(TChromeTabsPersistent)
  private
    FOffsets: TChromeTabsAddButtonOffsets;
    FHeight: Integer;
    FWidth: Integer;
  private
    procedure SetHeight(const Value: Integer);
    procedure SetOffsets(const Value: TChromeTabsAddButtonOffsets);
    procedure SetWidth(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property Offsets: TChromeTabsAddButtonOffsets read FOffsets write SetOffsets;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
  end;

  TChromeTabsControlPropertiesEx = class(TChromeTabsControlPosition)
  private
    FVisible: Boolean;
  private
    procedure SetVisible(const Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TChromeTabsAddButtonProperties = class(TChromeTabsControlPosition)
  private
    FShowPlusSign: Boolean;
    FVisibility: TAddButtonVisibility;
  private
    procedure SetShowPlusSign(const Value: Boolean);
    procedure SetVisibility(const Value: TAddButtonVisibility);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property ShowPlusSign: Boolean read FShowPlusSign write SetShowPlusSign;
    property Visibility: TAddButtonVisibility read FVisibility write SetVisibility;
  end;

  TChromeTabsCloseButtonProperties = class(TChromeTabsControlPosition)
  private
    FAutoHide: Boolean;
    FVisibility: TCloseButtonVisiblity;
    FAutoHideWidth: Integer;
    FCrossRadialOffset: Integer;
  private
    procedure SetAutoHide(const Value: Boolean);
    procedure SetVisibility(const Value: TCloseButtonVisiblity);
    procedure SetAutoHideWidth(const Value: Integer);
    procedure SetCrossRadialOffset(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property AutoHide: Boolean read FAutoHide write SetAutoHide;
    property Visibility: TCloseButtonVisiblity read FVisibility write SetVisibility;
    property AutoHideWidth: Integer read FAutoHideWidth write SetAutoHideWidth;
    property CrossRadialOffset: Integer read FCrossRadialOffset write SetCrossRadialOffset;
  end;

  TChromeTabModifiedDisplayOptions = class(TChromeTabsPersistent)
  private
    FStyle: TChromeTabModifiedStyle;
    FVerticalOffset: Integer;
    FHeight: Integer;
    FWidth: Integer;
    FAnimationSteps: Integer;

    procedure SetHeight(const Value: Integer);
    procedure SetStyle(const Value: TChromeTabModifiedStyle);
    procedure SetVerticalOffset(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetAnimationSteps(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property Style: TChromeTabModifiedStyle read FStyle write SetStyle;
    property VerticalOffset: Integer read FVerticalOffset write SetVerticalOffset;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
    property AnimationSteps: Integer read FAnimationSteps write SetAnimationSteps;
  end;

  TChromeTabsDragOptions = class(TChromeTabsPersistent)
  private
    FDragType: TChromeTabDragType;
    FDragOutsideImageAlpha: Byte;
    FDragOutsideDistancePixels: Integer;
    FDragStartPixels: Integer;
    FDragControlImageResizeFactor: Real;
    FDragCursor: TCursor;
    FDragDisplay: TChromeTabDragDisplay;
    FDragFormBorderWidth: Integer;
    FDragFormBorderColor: Integer;

    procedure SetDragOutsideDistancePixels(const Value: Integer);
    procedure SetDragOutsideImageAlpha(const Value: Byte);
    procedure SetDragStartPixels(const Value: Integer);
    procedure SetDragControlImageResizeFactor(const Value: Real);
    procedure SetDragType(const Value: TChromeTabDragType);
    procedure SetDragCursor(const Value: TCursor);
    procedure SetDragDisplay(const Value: TChromeTabDragDisplay);
    procedure SetDragFormBorderColor(const Value: Integer);
    procedure SetDragFormBorderWidth(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property DragType: TChromeTabDragType read FDragType write SetDragType;
    property DragOutsideImageAlpha: Byte read FDragOutsideImageAlpha write SetDragOutsideImageAlpha;
    property DragOutsideDistancePixels: Integer read FDragOutsideDistancePixels write SetDragOutsideDistancePixels;
    property DragStartPixels: Integer read FDragStartPixels write SetDragStartPixels;
    property DragControlImageResizeFactor: Real read FDragControlImageResizeFactor write SetDragControlImageResizeFactor;
    property DragCursor: TCursor read FDragCursor write SetDragCursor;
    property DragDisplay: TChromeTabDragDisplay read FDragDisplay write SetDragDisplay;
    property DragFormBorderWidth: Integer read FDragFormBorderWidth write SetDragFormBorderWidth;
    property DragFormBorderColor: Integer read FDragFormBorderColor write SetDragFormBorderColor;
  end;

  TChromeTabsAnimationOptions = class(TChromeTabsPersistent)
  private
    FAnimationMovement: TChromeTabsAnimationMovementTypes;
    FAnimationMovementIncrement: Integer;
    FAnimationStyleIncrement: Integer;
    FAnimationTimerInterval: Integer;
    FMinimumTabAnimationWidth: Integer;
  private
    procedure SetAnimationMovementIncrement(const Value: Integer);
    procedure SetAnimationStyleIncrement(const Value: Integer);
    procedure SetAnimationTimerInterval(const Value: Integer);
    procedure SetAnimationMovement(const Value: TChromeTabsAnimationMovementTypes);
    procedure SetMinimumTabAnimationWidth(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property AnimationMovement: TChromeTabsAnimationMovementTypes read FAnimationMovement write SetAnimationMovement;
    property AnimationMovementIncrement: Integer read FAnimationMovementIncrement write SetAnimationMovementIncrement;
    property AnimationStyleIncrement: Integer read FAnimationStyleIncrement write SetAnimationStyleIncrement;
    property AnimationTimerInterval: Integer read FAnimationTimerInterval write SetAnimationTimerInterval;
    property MinimumTabAnimationWidth: Integer read FMinimumTabAnimationWidth write SetMinimumTabAnimationWidth;
  end;

  TChromeTabsBehaviourOptions = class(TChromeTabsPersistent)
  private
    FBackgroundDblClickMaximiseRestoreForm: Boolean;
    FBackgroundDragMovesForm: Boolean;
    FTabSmartDeleteResizing: Boolean;
    FTabSmartDeleteResizeCancelDelay: Integer;
    FUseBuiltInPopupMenu: Boolean;
    FTabRightClickSelect: Boolean;
    FActivateNewTab: Boolean;
    FDebugMode: Boolean;
  private
    procedure SetTabRightClickSelect(const Value: Boolean);
    procedure SetTabSmartDeleteResizeCancelDelay(const Value: Integer);
    procedure SetTabSmartDeleteResizing(const Value: Boolean);
    procedure SetBackgroundDblClickMaximiseRestoreForm(const Value: Boolean);
    procedure SetUseBuiltInPopupMenu(const Value: Boolean);
    procedure SetActivateNewTab(const Value: Boolean);
    procedure SetDebugMode(const Value: Boolean);
    procedure SetBackgroundDragMovesForm(const Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property BackgroundDblClickMaximiseRestoreForm: Boolean read FBackgroundDblClickMaximiseRestoreForm write SetBackgroundDblClickMaximiseRestoreForm;
    property BackgroundDragMovesForm: Boolean read FBackgroundDragMovesForm write SetBackgroundDragMovesForm;
    property TabSmartDeleteResizing: Boolean read FTabSmartDeleteResizing write SetTabSmartDeleteResizing;
    property TabSmartDeleteResizeCancelDelay: Integer read FTabSmartDeleteResizeCancelDelay write SetTabSmartDeleteResizeCancelDelay;
    property UseBuiltInPopupMenu: Boolean read FUseBuiltInPopupMenu write SetUseBuiltInPopupMenu;
    property TabRightClickSelect: Boolean read FTabRightClickSelect write SetTabRightClickSelect;
    property ActivateNewTab: Boolean read FActivateNewTab write SetActivateNewTab;
    property DebugMode: Boolean read FDebugMode write SetDebugMode;
  end;

  TChromeTabsOptions = class(TChromeTabsPersistent)
  private
    FSeeThroughTabs: Boolean;
    FTabOverlap: Integer;
    FOffsetLeft: Integer;
    FOffsetTop: Integer;
    FOffsetRight: Integer;
    FOffsetBottom: Integer;
    FMinWidth: Integer;
    FMaxWidth: Integer;
    FPinnedWidth: Integer;
    FImageOffsetLeft: Integer;
    FTextTrimType: TTextTrimType;
    FOrientation: TTabOrientation;
    FContentOffsetLeft: Integer;
    FContentOffsetRight: Integer;
    FCanvasSmoothingMode: TSmoothingMode;
    FBaseLineTabRegionOnly: Boolean;
    FWordWrap: Boolean;
    FTextHorizontalAlignment: TAlignment;
    FTextAlignmentVertical: TVerticalAlignment;
    FShowImages: Boolean;
  private
    procedure SetSeeThroughTabs(const Value: Boolean);
    procedure SetOverlap(const Value: Integer);
    procedure SetContentOffsetLeft(const Value: Integer);
    procedure SetOffsetLeft(const Value: Integer);
    procedure SetOffsetTop(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);
    procedure SetMinWidth(const Value: Integer);
    procedure SetPinnedWidth(const Value: Integer);
    procedure SetImageOffsetLeft(const Value: Integer);
    procedure SetTextTrimType(const Value: TTextTrimType);
    procedure SetOrientation(const Value: TTabOrientation);
    procedure SetOffsetBottom(const Value: Integer);
    procedure SetContentOffsetRight(const Value: Integer);
    procedure SetOffsetRight(const Value: Integer);
    procedure SetCanvasSmoothingMode(const Value: TSmoothingMode);
    procedure SetBaseLineTabRegionOnly(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetTextAlignmentHorizontal(const Value: TAlignment);
    procedure SetTextAlignmentVertical(const Value: TVerticalAlignment);
    procedure SetShowImages(const Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property SeeThroughTabs: Boolean read FSeeThroughTabs write SetSeeThroughTabs;
    property TabOverlap: Integer read FTabOverlap write SetOverlap;
    property ContentOffsetLeft: Integer read FContentOffsetLeft write SetContentOffsetLeft;
    property ContentOffsetRight: Integer read FContentOffsetRight write SetContentOffsetRight;
    property OffsetLeft: Integer read FOffsetLeft write SetOffsetLeft;
    property OffsetTop: Integer read FOffsetTop write SetOffsetTop;
    property OffsetRight: Integer read FOffsetRight write SetOffsetRight;
    property OffsetBottom: Integer read FOffsetBottom write SetOffsetBottom;
    property MinWidth: Integer read FMinWidth write SetMinWidth;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth;
    property PinnedWidth: Integer read FPinnedWidth write SetPinnedWidth;
    property ImageOffsetLeft: Integer read FImageOffsetLeft write SetImageOffsetLeft;
    property TextTrimType: TTextTrimType read FTextTrimType write SetTextTrimType;
    property Orientation: TTabOrientation read FOrientation write SetOrientation;
    property CanvasSmoothingMode: TSmoothingMode read FCanvasSmoothingMode write SetCanvasSmoothingMode;
    property BaseLineTabRegionOnly: Boolean read FBaseLineTabRegionOnly write SetBaseLineTabRegionOnly;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property TextAlignmentHorizontal: TAlignment read FTextHorizontalAlignment write SetTextAlignmentHorizontal;
    property TextAlignmentVertical: TVerticalAlignment read FTextAlignmentVertical write SetTextAlignmentVertical;
    property ShowImages: Boolean read FShowImages write SetShowImages;
  end;

  TChromeTabsScrollOptions = class(TChromeTabsPersistent)
  private
    FEnabled: Boolean;
    FScrollButtons: TChromeTabScrollButtons;
    FScrollStep: Integer;
    FScrollRepeatDelay: Integer;
    FAutoHideButtons: Boolean;
    FDragScroll: Boolean;
    FDragScrollOffset: Integer;
    FMouseWheelScroll: Boolean;
  private
    procedure SetEnabled(const Value: Boolean);
    procedure SetScrollButtons(const Value: TChromeTabScrollButtons);
    procedure SetScrollStep(const Value: Integer);
    procedure SetScrollRepeatDelay(const Value: Integer);
    procedure SetAutoHideButtons(const Value: Boolean);
    procedure SetDragScroll(const Value: Boolean);
    procedure SetDragScrollOffset(const Value: Integer);
    procedure SetMouseWheelScroll(const Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property ScrollButtons: TChromeTabScrollButtons read FScrollButtons write SetScrollButtons;
    property ScrollStep: Integer read FScrollStep write SetScrollStep;
    property ScrollRepeatDelay: Integer read FScrollRepeatDelay write SetScrollRepeatDelay;
    property AutoHideButtons: Boolean read FAutoHideButtons write SetAutoHideButtons;
    property DragScroll: Boolean read FDragScroll write SetDragScroll;
    property DragScrollOffset: Integer read FDragScrollOffset write SetDragScrollOffset;
    property MouseWheelScroll: Boolean read FMouseWheelScroll write SetMouseWheelScroll;
  end;

  TChromeTabsContainerOptions = class(TChromeTabsPersistent)
  private
    FPaddingLeft: Integer;
    FPaddingRight: Integer;
    FTransparentBackground: Boolean;
    FOverlayButtons: Boolean;

    procedure SetOverlayButtons(const Value: Boolean);
    procedure SetTransparentBackground(const Value: Boolean);
    procedure SetPaddingLeft(const Value: Integer);
    procedure SetPaddingRight(const Value: Integer);
  public
    constructor Create(AOwner: TPersistent); override;
  published
    property TransparentBackground: Boolean read FTransparentBackground write SetTransparentBackground;
    property OverlayButtons: Boolean read FOverlayButtons write SetOverlayButtons;
    property PaddingLeft: Integer read FPaddingLeft write SetPaddingLeft;
    property PaddingRight: Integer read FPaddingRight write SetPaddingRight;
  end;

  TChromeTabsDisplayOptions = class(TChromeTabsPersistent)
  private
    FCloseButton: TChromeTabsCloseButtonProperties;
    FAddButton: TChromeTabsAddButtonProperties;
    FScrollButtonLeft: TChromeTabsControlPosition;
    FScrollButtonRight: TChromeTabsControlPosition;
    FTabModifiedGlow: TChromeTabModifiedDisplayOptions;
    FTabs: TChromeTabsOptions;
    FTabContainer: TChromeTabsContainerOptions;
    FTabMouseGlow: TChromeTabsControlPropertiesEx;
  private
    procedure SetCloseButton(const Value: TChromeTabsCloseButtonProperties);
    procedure SetAddButton(const Value: TChromeTabsAddButtonProperties);
    procedure SetScrollButtonLeft(const Value: TChromeTabsControlPosition);
    procedure SetScrollButtonRight(const Value: TChromeTabsControlPosition);
    procedure SetTabModifiedGlow(const Value: TChromeTabModifiedDisplayOptions);
    procedure SetTabs(const Value: TChromeTabsOptions);
    procedure SetTabContainer(const Value: TChromeTabsContainerOptions);
    procedure SetTabMouseGlow(const Value: TChromeTabsControlPropertiesEx);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property CloseButton: TChromeTabsCloseButtonProperties read FCloseButton write SetCloseButton;
    property AddButton: TChromeTabsAddButtonProperties read FAddButton write SetAddButton;
    property ScrollButtonLeft: TChromeTabsControlPosition read FScrollButtonLeft write SetScrollButtonLeft;
    property ScrollButtonRight: TChromeTabsControlPosition read FScrollButtonRight write SetScrollButtonRight;
    property TabModifiedGlow: TChromeTabModifiedDisplayOptions read FTabModifiedGlow write SetTabModifiedGlow;
    property Tabs: TChromeTabsOptions read FTabs write SetTabs;
    property TabContainer: TChromeTabsContainerOptions read FTabContainer write SetTabContainer;
    property TabMouseGlow: TChromeTabsControlPropertiesEx read FTabMouseGlow write SetTabMouseGlow;
  end;

  TOptions = class(TChromeTabsPersistent)
  private
    FDisplay: TChromeTabsDisplayOptions;
    FDragDrop: TChromeTabsDragOptions;
    FAnimation: TChromeTabsAnimationOptions;
    FBehaviour: TChromeTabsBehaviourOptions;
    FScrolling: TChromeTabsScrollOptions;
  private
    function GetDisplay: TChromeTabsDisplayOptions;
    procedure SetDisplay(const Value: TChromeTabsDisplayOptions);
    function GetDragDrop: TChromeTabsDragOptions;
    procedure SetDragDrop(const Value: TChromeTabsDragOptions);
    procedure SetAnimation(const Value: TChromeTabsAnimationOptions);
    function GetAnimation: TChromeTabsAnimationOptions;
    function GetBehaviour: TChromeTabsBehaviourOptions;
    procedure SetBehaviour(const Value: TChromeTabsBehaviourOptions);
    procedure SetScrolling(const Value: TChromeTabsScrollOptions);
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
  published
    property Display: TChromeTabsDisplayOptions read GetDisplay write SetDisplay;
    property DragDrop: TChromeTabsDragOptions read GetDragDrop write SetDragDrop;
    property Animation: TChromeTabsAnimationOptions read GetAnimation write SetAnimation;
    property Behaviour: TChromeTabsBehaviourOptions read GetBehaviour write SetBehaviour;
    property Scrolling: TChromeTabsScrollOptions read FScrolling write SetScrolling;
  end;

  IChromeTabs = interface
    ['{7392951B-B33C-4ECD-8255-9A746F5E0901}']
    function GetLastPinnedIndex: Integer;
    function GetActiveTab: TChromeTab;

    procedure DoOnBeforeDrawItem(TargetCanvas: TGPGraphics; ItemRect: TRect; ItemType: TChromeTabItemType; TabIndex: Integer; var Handled: Boolean);
    procedure DoOnAfterDrawItem(const TargetCanvas: TGPGraphics; ItemRect: TRect; ItemType: TChromeTabItemType; TabIndex: Integer);
    procedure DoOnGetControlPolygons(ItemRect: TRect; ItemType: TChromeTabItemType; Orientation: TTabOrientation; var Polygons: IChromeTabPolygons);
    procedure DoOnDebugLog(const Text: String; Args: Array of const);
    procedure DoOnActiveTabChanging(AOldTab, ANewTab: TChromeTab; var Allow: Boolean);
    procedure DoOnChange(ATab: TChromeTab; TabChangeType: TTabChangeType);
    function ScrollRect(ALeft, ATop, ARight, ABottom: Integer): TRect; overload;
    function ScrollRect(ARect: TRect): TRect; overload;
    function BidiRect(ARect: TRect): TRect;
    function GetBiDiMode: TBiDiMode;

    function GetLookAndFeel: TChromeTabsLookAndFeel;
    function GetOptions: TOptions;

    function GetImages: TCustomImageList;
    function GetImagesOverlay: TCustomImageList;
  end;

  TTabsLookAndFeel = class(TComponent)
  private
    FLookAndFeel: TPersistent;
  published
    property LookAndFeel: TPersistent read FLookAndFeel write FLookAndFeel;
  end;

  TTabsOptions = class(TComponent)
  private
    FOptions: TPersistent;
  published
    property Options: TPersistent read FOptions write FOptions;
  end;

implementation

{ TChromeTab }

constructor TChromeTab.Create(Collection: TCollection);
begin
  FCollection := Collection;
  FImageIndex := -1;
  FImageIndexOverlay := -1;
  FVisible := TRUE;

  // Inherited needs to be here so the property values are
  // set before it is called
  inherited;
end;

destructor TChromeTab.Destroy;
begin
  inherited;

  if FTabControl <> nil then
    FTabControl.Free;
end;

procedure TChromeTab.SetPinned(const Value: Boolean);
var
  LastPinned: Integer;
begin
  if FPinned <> Value then
  begin
    LastPinned := GetChromeTabInterface.GetLastPinnedIndex;

    if Value then
      Index := LastPinned + 1
    else
      Index := LastPinned;

    FPinned := Value;

    DoChanged(tcPinned);

    Active := TRUE;
  end;
end;

procedure TChromeTab.SetActive(Value: boolean);
var
  i: integer;
  Allow: Boolean;
begin
  if FActive <> Value then
  begin
    Allow := TRUE;

    if Value then
    begin
      GetChromeTabInterface.DoOnActiveTabChanging(GetChromeTabInterface.GetActiveTab, Self, Allow);

      FModified := FALSE;
    end;

    if Allow then
    begin
      FActive := Value;

      if FActive then
      begin
        with (GetOwner as TChromeTabsList) do
        begin
          for i := 0 to Count - 1 do
          begin
            // Only one can be selected
            if (Items[i] <> Self) and
               (Items[i].Active) then
            begin
              Items[i].Active := FALSE;
            end;
          end;
        end;

        GetChromeTabInterface.DoOnChange(Self, tcActivated);
      end
      else
      begin
        GetChromeTabInterface.DoOnChange(Self, tcDeactivated);
      end;

      DoChanged;
    end;
  end;
end;

procedure TChromeTab.SetTag(const Value: integer);
begin
  FTag := Value;
end;

procedure TChromeTab.SetVisible(const Value: Boolean);
begin
  FVisible := Value;

  if (not Value) and (Active) then
    Active := FALSE;

  DoChanged;
end;

function TChromeTab._AddRef: Integer;
begin
  // Do nothing
  Result := 0;
end;

function TChromeTab._Release: Integer;
begin
  // Do nothing
  Result := 0;
end;

function TChromeTab.GetCaption: TCaption;
begin
  Result := FCaption;
end;

function TChromeTab.GetDisplayCaption: String;
begin
  if FPinned then
    Result := ''
  else
    Result := FCaption;
end;

function TChromeTab.GetDisplayName: string;
begin
  if FCaption <> '' then
    Result := FCaption
  else
    Result := inherited GetDisplayName;
end;

function TChromeTab.GetImageIndex: TImageIndex;
begin
  Result := FImageIndex;
end;

function TChromeTab.GetImageIndexOverlay: TImageIndex;
begin
  Result := FImageIndexOverlay;
end;

function TChromeTab.GetIndex: Integer;
begin
  Result := Index;
end;

function TChromeTab.GetMarkedForDeletion: Boolean;
begin
  Result := FMarkedForDeletion;
end;

function TChromeTab.GetModified: Boolean;
begin
  Result := FModified;
end;

function TChromeTab.GetPinned: Boolean;
begin
  Result := FPinned;
end;

function TChromeTab.GetTab: TChromeTab;
begin
  Result := Self;
end;

function TChromeTab.GetTag: integer;
begin
  Result := FTag;
end;

function TChromeTab.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function TChromeTab.GetActive: boolean;
begin
  Result := FActive;
end;

function TChromeTab.GetChromeTabInterface: IChromeTabs;
begin
  if FCollection <> nil then
    Supports(FCollection.Owner, IChromeTabs, Result)
  else
    Result := nil;
end;

function TChromeTab.ImageIsVisible: Boolean;
begin
  Result := (FImageIndex <> -1) or (FImageIndexOverlay <> -1);
end;

function TChromeTab.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  // Do nothing
  Result := 0;
end;

procedure TChromeTab.DoChanged(ChangeType: TTabChangeType);
begin
  GetChromeTabInterface.DoOnChange(Self, ChangeType);
end;

procedure TChromeTab.SetCaption(Value: TCaption);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;

    DoChanged;
  end;
end;

procedure TChromeTab.SetImageIndex(Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;

    DoChanged;
  end;
end;

procedure TChromeTab.SetImageIndexOverlay(const Value: TImageIndex);
begin
  if FImageIndexOverlay <> Value then
  begin
    FImageIndexOverlay := Value;

    DoChanged;
  end;
end;

procedure TChromeTab.SetModified(const Value: Boolean);
begin
  if FModified <> Value then
  begin
    FModified := Value;

    DoChanged;
  end;
end;


{ TChromeTabsList }

function TChromeTabsList.Add: TChromeTab;
begin
  Result := TChromeTab(inherited Add);
end;

procedure TChromeTabsList.Assign(Source: TPersistent);
begin
  inherited;

  GetChromeTabInterface.DoOnChange(nil, tcPropertyUpdated);
end;

constructor TChromeTabsList.Create(AOwner: TComponent);
var
  ChromeTabClass: TChromeTabClass;
begin
  ChromeTabClass := TChromeTab;

  inherited Create(AOwner, ChromeTabClass);
end;

procedure TChromeTabsList.Delete(Index: Integer);
begin
  InternalDelete(Index, FALSE);
end;

procedure TChromeTabsList.DeleteNow(Index: Integer);
begin
  InternalDelete(Index, TRUE);
end;

procedure TChromeTabsList.InternalDelete(Index: Integer; DeleteNow: Boolean);
var
  NewIdx: Integer;
begin
  // Has this tab already been marked for deletion? If so, remove it now
  if (DeleteNow) or (Items[Index].FMarkedForDeletion) then
    inherited Delete(Index)
  else
  begin
    if not Items[Index].Active then
      NewIdx := -1 else

    if Index < pred(Count) then
    begin
      NewIdx := Index;

      if aeTabDelete in GetChromeTabInterface.GetOptions.Animation.AnimationMovement then
      begin
        if NewIdx < pred(Count) then
          Inc(NewIdx)
        else
          Dec(NewIdx);
      end;
    end else

    if Index > 0 then
      NewIdx := Index - 1
    else
      NewIdx := -1;

    GetChromeTabInterface.DoOnChange(Items[Index], tcDeleting);

    if aeTabDelete in GetChromeTabInterface.GetOptions.Animation.AnimationMovement then
    begin
      Items[Index].FMarkedForDeletion := TRUE;

      GetChromeTabInterface.DoOnChange(Items[Index], tcDeleted);
    end
    else
    begin
      inherited Delete(Index);

      GetChromeTabInterface.DoOnChange(nil, tcDeleted);
    end;

    if NewIdx <> -1 then
      Items[NewIdx].Active := TRUE;
  end;
end;

procedure TChromeTabsList.SetActiveTab(const Value: TChromeTab);
var
  i: Integer;
begin
  for i := 0 to pred(Count) do
    if Items[i] = Value then
    begin
      Items[i].Active := TRUE;

      Break;
    end;
end;

procedure TChromeTabsList.SetItem(Index: Integer; Value: TChromeTab);
begin
  inherited SetItem(Index, Value);

  GetChromeTabInterface.DoOnChange(Value, tcAdded);
end;

function TChromeTabsList.GetActiveTab: TChromeTab;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to pred(Count) do
    if Items[i].Active then
    begin
     Result := Items[i];

      Break;
    end;
end;

function TChromeTabsList.GetItem(Index: Integer): TChromeTab;
begin
  Result := inherited GetItem(Index) as TChromeTab;
end;

function TChromeTabsList.GetChromeTabInterface: IChromeTabs;
begin
  Assert(Supports(Owner, IChromeTabs, Result), 'Collection owner must support IChromeTabInterface');
end;

function TChromeTabsList.IndexOf(ATab: TChromeTab): integer;
var
  i, c: integer;
begin
  c := Count;
  for i := 0 to c - 1 do
    if Items[i] = ATab then begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

procedure TChromeTabsList.Move(OldIndex, NewIndex: Integer);
begin
  Items[OldIndex].Index := NewIndex;

  GetChromeTabInterface.DoOnChange(Items[NewIndex], tcMoved);
end;

procedure TChromeTabsList.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited;

  if (Action in [cnAdded]) and
     (GetChromeTabInterface <> nil) then
    GetChromeTabInterface.DoOnChange(TChromeTab(Item), tcAdded);
end;


{ TChromeTabsOptions }

constructor TChromeTabsOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FSeeThroughTabs := FALSE;
  FTabOverlap := 12;
  FContentOffsetLeft := 13;
  FContentOffsetRight := 13;
  FOffsetLeft := 0;
  FOffsetTop := 0;
  FMinWidth := 20;
  FMaxWidth := 200;
  FPinnedWidth := 39;
  FImageOffsetLeft := 13;
  FTextHorizontalAlignment := taLeftJustify;
  FTextAlignmentVertical := taVerticalCenter;
  FShowImages := TRUE;

  FTextTrimType := tttFade;

  FCanvasSmoothingMode := SmoothingModeHighQuality;
  FOffsetRight := 0;
end;

destructor TChromeTabsOptions.Destroy;
begin

  inherited;
end;

procedure TChromeTabsOptions.SetOffsetRight(const Value: Integer);
begin
  FOffsetRight := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetSeeThroughTabs(const Value: Boolean);
begin
  FSeeThroughTabs := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetShowImages(const Value: Boolean);
begin
  FShowImages := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetBaseLineTabRegionOnly(const Value: Boolean);
begin
  FBaseLineTabRegionOnly := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetCanvasSmoothingMode(const Value: TSmoothingMode);
begin
  FCanvasSmoothingMode := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetContentOffsetLeft(const Value: Integer);
begin
  FContentOffsetLeft := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetContentOffsetRight(const Value: Integer);
begin
  FContentOffsetRight := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetImageOffsetLeft(const Value: Integer);
begin
  FImageOffsetLeft := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetMaxWidth(const Value: Integer);
begin
  if Value < FMinWidth then
    FMaxWidth := FMinWidth
  else
    FMaxWidth := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetMinWidth(const Value: Integer);
begin
  FMinWidth := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetOffsetBottom(const Value: Integer);
begin
  FOffsetBottom := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetOffsetLeft(const Value: Integer);
begin
  FOffsetLeft := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetOffsetTop(const Value: Integer);
begin
  FOffsetTop := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetOrientation(const Value: TTabOrientation);
begin
  FOrientation := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetOverlap(const Value: Integer);
begin
  FTabOverlap := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetPinnedWidth(const Value: Integer);
begin
  FPinnedWidth := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetTextAlignmentHorizontal(const Value: TAlignment);
begin
  FTextHorizontalAlignment := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetTextTrimType(const Value: TTextTrimType);
begin
  FTextTrimType := Value;

  DoChanged;
end;


procedure TChromeTabsOptions.SetTextAlignmentVertical(
  const Value: TVerticalAlignment);
begin
  FTextAlignmentVertical := Value;

  DoChanged;
end;

procedure TChromeTabsOptions.SetWordWrap(const Value: Boolean);
begin
  FWordWrap := Value;

  DoChanged;
end;

{ TChromeTabsPersistent }

constructor TChromeTabsPersistent.Create(AOwner: TPersistent);
begin
  inherited Create;

  FOwner := AOwner;
end;

procedure TChromeTabsPersistent.DoChanged;
var
  ChromeTabInterface: IChromeTabs;
  Owner: TPersistent;
begin
  Owner := FOwner;

  while Owner <> nil do
  begin
    if Supports(Owner, IChromeTabs, ChromeTabInterface) then
    begin
      ChromeTabInterface.DoOnChange(nil, tcPropertyUpdated);

      Break;
    end
    else
    if Owner is TChromeTabsPersistent then
      Owner := TChromeTabsPersistent(Owner).Owner else
    if Owner is TComponent then
      Owner := TChromeTabsPersistent(Owner).Owner
    else
      Owner := nil;
  end;
end;

function TChromeTabsPersistent.GetOwner: TPersistent;
begin
  if FOwner is TPersistent then
    Result := TPersistent(FOwner)
  else
    Result := nil;
end;

procedure TChromeTabsPersistent.Invalidate;
begin
  FInvalidated := TRUE;
end;

{ TOptions }

constructor TOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FDisplay := TChromeTabsDisplayOptions.Create(Self);
  FDragDrop := TChromeTabsDragOptions.Create(Self);
  FAnimation := TChromeTabsAnimationOptions.Create(Self);
  FBehaviour := TChromeTabsBehaviourOptions.Create(Self);
  FScrolling := TChromeTabsScrollOptions.Create(Self);
end;

destructor TOptions.Destroy;
begin
  FreeAndNil(FDisplay);
  FreeAndNil(FDragDrop);
  FreeAndNil(FAnimation);
  FreeAndNil(FBehaviour);
  FreeAndNil(FScrolling);

  inherited;
end;

function TOptions.GetAnimation: TChromeTabsAnimationOptions;
begin
  Result := FAnimation;
end;

function TOptions.GetBehaviour: TChromeTabsBehaviourOptions;
begin
  Result := FBehaviour;
end;

function TOptions.GetDragDrop: TChromeTabsDragOptions;
begin
  Result := FDragDrop;
end;

function TOptions.GetDisplay: TChromeTabsDisplayOptions;
begin
  Result := FDisplay;
end;

procedure TOptions.SetAnimation(const Value: TChromeTabsAnimationOptions);
begin
  FAnimation.Assign(Value);
end;

procedure TOptions.SetBehaviour(const Value: TChromeTabsBehaviourOptions);
begin
  FBehaviour.AssignTo(Value);
end;

procedure TOptions.SetDragDrop(const Value: TChromeTabsDragOptions);
begin
  FDragDrop.Assign(Value);
end;

procedure TOptions.SetDisplay(const Value: TChromeTabsDisplayOptions);
begin
  FDisplay.Assign(Value);
end;

procedure TOptions.SetScrolling(const Value: TChromeTabsScrollOptions);
begin
  FScrolling.Assign(Value);
end;

{ TChromeTabsLookAndFeelStyleProperties }

constructor TChromeTabsLookAndFeelStyleProperties.Create(AOwner: TPersistent);
begin
  inherited;

  FFont := TChromeTabsLookAndFeelFont.Create(Self);
  FStyle := TChromeTabsLookAndFeelStyle.Create(AOwner);
end;

destructor TChromeTabsLookAndFeelStyleProperties.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FStyle);

  inherited;
end;

procedure TChromeTabsLookAndFeelStyleProperties.Invalidate;
begin
  inherited;

  FStyle.Invalidate;
end;

procedure TChromeTabsLookAndFeelStyleProperties.SetFont(const Value: TChromeTabsLookAndFeelFont);
begin
  FFont.Assign(Value);

  DoChanged;
end;


procedure TChromeTabsLookAndFeelStyleProperties.SetStyle(const Value: TChromeTabsLookAndFeelStyle);
begin
  FStyle.Assign(Value);

  DoChanged;
end;

{ TChromeTabLookAndFeelStyle }

constructor TChromeTabsLookAndFeelStyle.Create(AOwner: TPersistent);
begin
  inherited;

  FStartAlpha := 255;
  FStopAlpha := 255;
  FOutlineAlpha := 255;

  FOutlineSize := 1;

  FOutlineColor := clGray;
  FStartColor := clWhite;
  FStopColor := clWhite;
end;

destructor TChromeTabsLookAndFeelStyle.Destroy;
begin
  inherited;
end;

function TChromeTabsLookAndFeelStyle.GetBrush(
  ClientRect: TRect): TGPLinearGradientBrush;
begin
  // Make sure thst the last brush wasn't broken
  if (FInvalidated) or
     ((FBrush <> nil) and
      (FBrush.GetLastStatus <> Ok)) then
  begin
    FreeAndNil(FBrush);

    FInvalidated := FALSE;
  end;

  if FBrush = nil then
    FBrush := TGPLinearGradientBrush.Create(MakePoint(0, ClientRect.Top),
                                            MakePoint(0, ClientRect.Bottom),
                                            MakeGDIPColor(StartColor, StartAlpha),
                                            MakeGDIPColor(StopColor, StopAlpha));

  Result := FBrush;
end;

function TChromeTabsLookAndFeelStyle.GetPen: TGPPen;
begin
  if FPenInvalidated then
  begin
    FreeAndNil(FPen);

    FPenInvalidated := FALSE;
  end;

  if FPen = nil then
    FPen := TGPPen.Create(MakeGDIPColor(FOutlineColor, FOutlineAlpha), FOutlineSize);

  Result := FPen;
end;

procedure TChromeTabsLookAndFeelStyle.Invalidate;
begin
  inherited;

  FPenInvalidated := TRUE;
end;

procedure TChromeTabsLookAndFeelStyle.SetStartAlpha(const Value: Byte);
begin
  FStartAlpha := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelStyle.SetOutlineAlpha(const Value: Byte);
begin
  FOutlineAlpha := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelStyle.SetOutlineColor(const Value: TColor);
begin
  FOutlineColor := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelStyle.SetOutlineSize(const Value: Single);
begin
  FOutlineSize := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelStyle.SetStartColor(const Value: TColor);
begin
  FStartColor := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelStyle.SetStopAlpha(const Value: Byte);
begin
  FStopAlpha := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelStyle.SetStopColor(const Value: TColor);
begin
  FStopColor := Value;

  Invalidate;

  DoChanged;
end;

{ TChromeTabsLookAndFeelCloseButton }

constructor TChromeTabsLookAndFeelCloseButton.Create(AOwner: TPersistent);
begin
  Inherited;

  FCircle := TChromeTabsLookAndFeelButtonItems.Create(Self);
  FCross := TChromeTabsLookAndFeelPenItem.Create(Self);

  FCross.Normal.Color := $00B8AFA9;
  FCross.Hot.Color := clWhite;
  FCross.Hot.Alpha := 240;
  FCross.Down.Color := clRed;

  FCircle.Normal.StartColor := clWhite;
  FCircle.Normal.StopColor := FCircle.Normal.StartColor;
  FCircle.Normal.OutlineAlpha := 0;

  FCircle.Hot.StartColor := $003535c1;
  FCircle.Hot.StopColor := FCircle.Hot.StartColor;
  FCircle.Hot.OutlineAlpha := 0;

  FCircle.Down.StartColor := $003535c1;
  FCircle.Down.StopColor := FCircle.Down.StartColor;
  FCircle.Down.OutlineAlpha := 0;
end;

destructor TChromeTabsLookAndFeelCloseButton.Destroy;
begin
  FreeAndNil(FCircle);
  FreeAndNil(FCross);

  inherited;
end;

procedure TChromeTabsLookAndFeelCloseButton.SetCircle(const Value: TChromeTabsLookAndFeelButtonItems);
begin
  FCircle.Assign(Value);

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelCloseButton.SetCross(
  const Value: TChromeTabsLookAndFeelPenItem);
begin
  FCross := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelCloseButton.Invalidate;
begin
  FCross.Invalidate;
  FCircle.Invalidate;
end;

{ TChromeTabsLookAndFeelAddButton }

constructor TChromeTabsLookAndFeelAddButton.Create(AOwner: TPersistent);
begin
  inherited;

  FButton := TChromeTabsLookAndFeelButtonItems.Create(Self);
  FPlusSign := TChromeTabsLookAndFeelButtonItems.Create(Self);
end;

destructor TChromeTabsLookAndFeelAddButton.Destroy;
begin
  FreeAndNil(FButton);
  FreeAndNil(FPlusSign);

  inherited;
end;


procedure TChromeTabsLookAndFeelAddButton.SetButton(
  const Value: TChromeTabsLookAndFeelButtonItems);
begin
  FButton.Assign(Value);
end;

procedure TChromeTabsLookAndFeelAddButton.SetPlusSign(
  const Value: TChromeTabsLookAndFeelButtonItems);
begin
  FPlusSign.Assign(Value);
end;

procedure TChromeTabsLookAndFeelAddButton.Invalidate;
begin
  inherited;

  FButton.Invalidate;
  FPlusSign.Invalidate;
end;

// TChromeTabsLookAndFeel

constructor TChromeTabsLookAndFeel.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);

  FTabs := TChromeTabsLookAndFeelTab.Create(Self);
  FTabsContainer := TChromeTabsLookAndFeelStyle.Create(Self);
  FCloseButton := TChromeTabsLookAndFeelCloseButton.Create(Self);
  FAddButton := TChromeTabsLookAndFeelAddButton.Create(Self);
  FScrollButtons := TChromeTabsLookAndFeelScrollButton.Create(Self);

  FTabsContainer.OutlineSize := 0;

  SetTabSkin(isChrome);
end;

destructor TChromeTabsLookAndFeel.Destroy;
begin
  FreeAndNil(FCloseButton);
  FreeAndNil(FTabsContainer);
  FreeAndNil(FAddButton);
  FreeAndNil(FTabs);
  FreeAndNil(FScrollButtons);

  inherited;
end;

procedure TChromeTabsLookAndFeel.Invalidate;
begin
  inherited;

  FScrollButtons.Invalidate;
  FTabs.Invalidate;
  FTabsContainer.Invalidate;
  FCloseButton.Invalidate;
  FAddButton.Invalidate;
end;

procedure TChromeTabsLookAndFeel.SetTabsContainer(const Value: TChromeTabsLookAndFeelStyle);
begin
  FTabsContainer.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeel.SetCloseButton(const Value: TChromeTabsLookAndFeelCloseButton);
begin
  FCloseButton.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeel.SetScrollButtons(
  const Value: TChromeTabsLookAndFeelScrollButton);
begin
  FScrollButtons.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeel.SetTabs(
  const Value: TChromeTabsLookAndFeelTab);
begin
  FTabs.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeel.SetAddButton(
  const Value: TChromeTabsLookAndFeelAddButton);
begin
  FAddButton.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeel.SetTabSkin(const Value: TTabSkin);
begin
  SetTabSkinValues(Value);

  FTabSkin := Value;
end;

procedure TChromeTabsLookAndFeel.SetTabSkinValues(TabSkin: TTabSkin);
begin
  case TabSkin of
    isDefault:
      begin
        FTabs.Active.Font.Color := clBlack;
        FTabs.Active.Style.StartColor := $00FBF9F7;
        FTabs.Active.Style.StopColor := $00EAE6E1;
        FTabs.Active.Style.OutlineColor := $00706453;

        FTabs.NotActive.Font.Color := clWhite;
        FTabs.NotActive.Style.StartColor := $00A19078;
        FTabs.NotActive.Style.StopColor := $00A19078;
        FTabs.NotActive.Style.OutlineColor := $00706453;

        FTabs.Hot.Font.Color := clWhite;
        FTabs.Hot.Style.StartColor := $00A19078;
        FTabs.Hot.Style.StopColor := $00A19078;
        FTabs.Hot.Style.OutlineColor := $00706453;

        FAddButton.Button.Normal.StartColor := $00f3c5a1;
        FAddButton.Button.Normal.StopColor := $00f0c19c;

        FTabsContainer.StartColor := $00C8BDB0;
        FTabsContainer.StopColor := $00C8BDB0;

        FCloseButton.Cross.Normal.Color := $00B8AFA9;
        FCloseButton.Cross.Hot.Color := clRed;
        FCloseButton.Circle.Normal.StartColor := clNone;
        FCloseButton.Circle.Normal.StopColor := clNone;
        FCloseButton.Circle.Hot.StartColor := $003535c1;
        FCloseButton.Circle.Hot.StopColor := $003535c1;
      end;

    isChrome:
      begin
        FTabs.Active.Font.Color := $00404040;
        FTabs.Active.Style.StartColor := $00ffffff;
        FTabs.Active.Style.StopColor := $00f7f7f8;
        FTabs.Active.Style.OutlineColor := $00988b81;

        FTabs.NotActive.Font.Color := $003A0066;
        FTabs.NotActive.Style.StartColor := $00cbbbac;
        FTabs.NotActive.Style.StopColor := $00dccfc3;
        FTabs.NotActive.Style.OutlineColor := $00b2a79d;

        FTabs.Hot.Font.Color := $00404040;
        FTabs.Hot.Style.StartColor := $00e9e0d6;
        FTabs.Hot.Style.StopColor := $00ebe0d8;
        FTabs.Hot.Style.OutlineColor := $00b2a79d;

        FAddButton.Button.Normal.StartColor := $00f3c5a1;
        FAddButton.Button.Normal.StopColor := $00f0c19c;

        FScrollButtons.Button.Normal.StartColor := $00f3c5a1;
        FScrollButtons.Button.Normal.StopColor := $00f0c19c;
        FScrollButtons.Button.Disabled.StartColor := clGray;
        FScrollButtons.Button.Disabled.StopColor := clGray;
        FScrollButtons.Button.Disabled.StartAlpha := 150;
        FScrollButtons.Button.Disabled.StopAlpha := 150;

        FScrollButtons.Button.Normal.StartAlpha := 200;
        FScrollButtons.Button.Normal.StopAlpha := 200;

        FScrollButtons.Arrow.Normal.StartColor := clWhite;
        FScrollButtons.Arrow.Normal.StopColor := clWhite;
        FScrollButtons.Arrow.Disabled.StartColor := clSilver;
        FScrollButtons.Arrow.Disabled.StopColor := clSilver;
        FScrollButtons.Arrow.Disabled.StartAlpha := 150;
        FScrollButtons.Arrow.Disabled.StopAlpha := 150;

        FTabsContainer.StartColor := $00DD9362;
        FTabsContainer.StopColor := $00D68656;

        FCloseButton.Cross.Normal.Color := $00AEAEAE;
        FCloseButton.Cross.Hot.Color := $ebebf9;
        FCloseButton.Cross.Down.Color := $ebebf9;
        FCloseButton.Circle.Normal.StartColor := clNone;
        FCloseButton.Circle.Normal.StopColor := clNone;
        FCloseButton.Circle.Hot.StartColor := $003535c1;
        FCloseButton.Circle.Hot.StopColor := $003535c1;
        FCloseButton.Circle.Down.StartColor := $003535c1;
        FCloseButton.Circle.Down.StopColor := $003535c1;
      end;

    isCustom:
      begin
        // Do nothing as we will use the current settings
      end;
  end;
end;


{ TChromeTabsAnimationOptions }

constructor TChromeTabsAnimationOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FAnimationMovement := [aeTabAdd,
                         aeTabMove,
                         aeTabDragCancelled,
                         aeAddButtonMove];

  FAnimationMovementIncrement := 7;
  FAnimationStyleIncrement := 10;
  FAnimationTimerInterval := 15;
  FMinimumTabAnimationWidth := 40;
end;

procedure TChromeTabsAnimationOptions.SetAnimationMovementIncrement(const Value: Integer);
begin
  FAnimationMovementIncrement := Value;
end;

procedure TChromeTabsAnimationOptions.SetAnimationStyleIncrement(const Value: Integer);
begin
  FAnimationStyleIncrement := Value;
end;

procedure TChromeTabsAnimationOptions.SetAnimationTimerInterval(const Value: Integer);
begin
  FAnimationTimerInterval := Value;
end;

procedure TChromeTabsAnimationOptions.SetMinimumTabAnimationWidth(
  const Value: Integer);
begin
  FMinimumTabAnimationWidth := Value;
end;

procedure TChromeTabsAnimationOptions.SetAnimationMovement(
  const Value: TChromeTabsAnimationMovementTypes);
begin
  FAnimationMovement := Value;
end;

{ TChromeTabsDragOptions }

constructor TChromeTabsDragOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FDragType := dtBetweenContainers;
  FDragOutsideImageAlpha := 120;
  FDragOutsideDistancePixels := 30;
  FDragStartPixels := 2;
  FDragControlImageResizeFactor := 0.5;
  FDragCursor := crDefault;
  FDragDisplay := ddTabAndControl;
  FDragFormBorderWidth := 2;
  FDragFormBorderColor := clGray;
end;

procedure TChromeTabsDragOptions.SetDragType(
  const Value: TChromeTabDragType);
begin
  FDragType := Value;
end;

procedure TChromeTabsDragOptions.SetDragControlImageResizeFactor(
  const Value: Real);
begin
  FDragControlImageResizeFactor := Value;
end;

procedure TChromeTabsDragOptions.SetDragCursor(const Value: TCursor);
begin
  FDragCursor := Value;
end;

procedure TChromeTabsDragOptions.SetDragDisplay(
  const Value: TChromeTabDragDisplay);
begin
  FDragDisplay := Value;
end;

procedure TChromeTabsDragOptions.SetDragFormBorderColor(const Value: Integer);
begin
  FDragFormBorderColor := Value;
end;

procedure TChromeTabsDragOptions.SetDragFormBorderWidth(const Value: Integer);
begin
  FDragFormBorderWidth := Value;
end;

procedure TChromeTabsDragOptions.SetDragOutsideDistancePixels(const Value: Integer);
begin
  FDragOutsideDistancePixels := Value;
end;

procedure TChromeTabsDragOptions.SetDragOutsideImageAlpha(const Value: Byte);
begin
  FDragOutsideImageAlpha := Value;
end;

procedure TChromeTabsDragOptions.SetDragStartPixels(const Value: Integer);
begin
  FDragStartPixels := Value;
end;


{ TDragTabObject }

destructor TDragTabObject.Destroy;
begin
  if FDragForm <> nil then
    FDragForm.Release;

  inherited;
end;

function TDragTabObject.GetDockControl: IChromeTabDockControl;
begin
  Result := FDockControl;
end;

function TDragTabObject.GetDragCursorOffset: TPoint;
begin
  Result := FDragCursorOffset;
end;

function TDragTabObject.GetDragForm: TForm;
begin
  Result := FDragForm;
end;

function TDragTabObject.GetDragFormOffset: TPoint;
begin
  Result := FDragFormOffset;
end;

function TDragTabObject.GetDragPoint: TPoint;
begin
  Result := FDragPoint;
end;

function TDragTabObject.GetDragTab: TChromeTab;
begin
  Result := FDragTab;
end;

function TDragTabObject.GetDropTabIndex: Integer;
begin
  Result := FDropTabIndex;
end;

function TDragTabObject.GetHideAddButton: Boolean;
begin
  Result := FHideAddButton;
end;

function TDragTabObject.GetOriginalControlRect: TRect;
begin
  Result := FOriginalControlRect;
end;

function TDragTabObject.GetOriginalCursor: TCursor;
begin
  Result := FOriginalCursor;
end;

function TDragTabObject.GetSourceControl: IChromeTabDockControl;
begin
  Result := FSourceControl;
end;

procedure TDragTabObject.SetDockControl(const Value: IChromeTabDockControl);
begin
  FDockControl := Value;
end;

procedure TDragTabObject.SetDragCursorOffset(const Value: TPoint);
begin
  FDragCursorOffset := Value;
end;

procedure TDragTabObject.SetDragForm(const Value: TForm);
begin
  FDragForm := Value;
end;

procedure TDragTabObject.SetDragFormOffset(const Value: TPoint);
begin
  FDragFormOffset := Value;
end;

procedure TDragTabObject.SetDragPoint(const Value: TPoint);
begin
  FDragPoint := Value;
end;

procedure TDragTabObject.SetDragTab(const Value: TChromeTab);
begin
  FDragTab := Value;
end;

procedure TDragTabObject.SetDropTabIndex(const Value: Integer);
begin
  FDropTabIndex := Value;
end;

procedure TDragTabObject.SetHideAddButton(const Value: Boolean);
begin
  FHideAddButton := Value;
end;

procedure TDragTabObject.SetOriginalControlRect(const Value: TRect);
begin
  FOriginalControlRect := Value;
end;

procedure TDragTabObject.SetOriginalCursor(const Value: TCursor);
begin
  FOriginalCursor := Value;
end;

procedure TDragTabObject.SetSourceControl(const Value: IChromeTabDockControl);
begin
  FSourceControl := Value;
end;

{ TChromeTabsDisplayOptions }

constructor TChromeTabsDisplayOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FCloseButton := TChromeTabsCloseButtonProperties.Create(Self);
  FAddButton := TChromeTabsAddButtonProperties.Create(Self);
  FScrollButtonLeft := TChromeTabsControlPosition.Create(Self);
  FScrollButtonRight := TChromeTabsControlPosition.Create(Self);
  FTabModifiedGlow := TChromeTabModifiedDisplayOptions.Create(Self);
  FTabs := TChromeTabsOptions.Create(Self);
  FTabContainer := TChromeTabsContainerOptions.Create(Self);
  FTabMouseGlow := TChromeTabsControlPropertiesEx.Create(Self);

  FScrollButtonLeft.Height := 15;
  FScrollButtonLeft.Width := 15;
  FScrollButtonLeft.Offsets.Vertical := 10;

  FScrollButtonRight.Height := 15;
  FScrollButtonRight.Width := 15;
  FScrollButtonRight.Offsets.Vertical := 10;

  FTabMouseGlow.Height := 70;
  FTabMouseGlow.Width := 70;
end;

destructor TChromeTabsDisplayOptions.Destroy;
begin
  FreeAndNil(FAddButton);
  FreeAndNil(FCloseButton);
  FreeAndNil(FScrollButtonLeft);
  FreeAndNil(FScrollButtonRight);
  FreeAndNil(FTabModifiedGlow);
  FreeAndNil(FTabs);
  FreeAndNil(FTabContainer);
  FreeAndNil(FTabMouseGlow);

  inherited;
end;

procedure TChromeTabsDisplayOptions.SetAddButton(
  const Value: TChromeTabsAddButtonProperties);
begin
  FAddButton.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsDisplayOptions.SetScrollButtonLeft(
  const Value: TChromeTabsControlPosition);
begin
  FScrollButtonLeft.Assign(Value);
end;

procedure TChromeTabsDisplayOptions.SetScrollButtonRight(
  const Value: TChromeTabsControlPosition);
begin
  FScrollButtonRight.Assign(Value);
end;

procedure TChromeTabsDisplayOptions.SetCloseButton(
  const Value: TChromeTabsCloseButtonProperties);
begin
  FCloseButton.Assign(Value);
end;

procedure TChromeTabsDisplayOptions.SetTabModifiedGlow(
  const Value: TChromeTabModifiedDisplayOptions);
begin
  FTabModifiedGlow.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsDisplayOptions.SetTabMouseGlow(
  const Value: TChromeTabsControlPropertiesEx);
begin
  FTabMouseGlow.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsDisplayOptions.SetTabContainer(
  const Value: TChromeTabsContainerOptions);
begin
  FTabContainer.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsDisplayOptions.SetTabs(const Value: TChromeTabsOptions);
begin
  FTabs.Assign(Value);

  DoChanged;
end;


{ TChromeTabsBehaviourOptions }

constructor TChromeTabsBehaviourOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FBackgroundDblClickMaximiseRestoreForm := FALSE;
  FBackgroundDragMovesForm := FALSE;
  FTabSmartDeleteResizing := TRUE;
  FTabSmartDeleteResizeCancelDelay := 700;
  FUseBuiltInPopupMenu := TRUE;
  FTabRightClickSelect := TRUE;
  FActivateNewTab := TRUE;
end;

procedure TChromeTabsBehaviourOptions.SetActivateNewTab(const Value: Boolean);
begin
  FActivateNewTab := Value;
end;

procedure TChromeTabsBehaviourOptions.SetDebugMode(const Value: Boolean);
begin
  FDebugMode := Value;
end;

procedure TChromeTabsBehaviourOptions.SetTabRightClickSelect(
  const Value: Boolean);
begin
  FTabRightClickSelect := Value;
end;

procedure TChromeTabsBehaviourOptions.SetTabSmartDeleteResizeCancelDelay(
  const Value: Integer);
begin
  FTabSmartDeleteResizeCancelDelay := Value;
end;

procedure TChromeTabsBehaviourOptions.SetTabSmartDeleteResizing(
  const Value: Boolean);
begin
  FTabSmartDeleteResizing := Value;
end;

procedure TChromeTabsBehaviourOptions.SetBackgroundDblClickMaximiseRestoreForm(
  const Value: Boolean);
begin
  FBackgroundDblClickMaximiseRestoreForm := Value;
end;

procedure TChromeTabsBehaviourOptions.SetBackgroundDragMovesForm(
  const Value: Boolean);
begin
  FBackgroundDragMovesForm := Value;
end;

procedure TChromeTabsBehaviourOptions.SetUseBuiltInPopupMenu(
  const Value: Boolean);
begin
  FUseBuiltInPopupMenu := Value;
end;

{ TChromeTabsScrollOptions }

constructor TChromeTabsScrollOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FScrollStep := 20;
  FScrollRepeatDelay := 20;
  FAutoHideButtons := TRUE;

  FDragScroll := TRUE;
  FDragScrollOffset := 50;

  FMouseWheelScroll := TRUE;

  FScrollButtons := csbRight;
end;

destructor TChromeTabsScrollOptions.Destroy;
begin
  inherited;
end;

procedure TChromeTabsScrollOptions.SetAutoHideButtons(const Value: Boolean);
begin
  FAutoHideButtons := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetDragScroll(const Value: Boolean);
begin
  FDragScroll := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetDragScrollOffset(const Value: Integer);
begin
  FDragScrollOffset := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetMouseWheelScroll(const Value: Boolean);
begin
  FMouseWheelScroll := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetScrollButtons(
  const Value: TChromeTabScrollButtons);
begin
  FScrollButtons := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetScrollRepeatDelay(const Value: Integer);
begin
  FScrollRepeatDelay := Value;

  DoChanged;
end;

procedure TChromeTabsScrollOptions.SetScrollStep(const Value: Integer);
begin
  FScrollStep := Value;

  DoChanged;
end;

{ TChromeTabsControlPosition }

constructor TChromeTabsControlPosition.Create(AOwner: TPersistent);
begin
  FOffsets := TChromeTabsAddButtonOffsets.Create(Self);

  inherited;
end;

destructor TChromeTabsControlPosition.Destroy;
begin
  FreeAndNil(FOffsets);

  inherited;
end;

procedure TChromeTabsControlPosition.SetHeight(const Value: Integer);
begin
  FHeight := Value;

  DoChanged;
end;

procedure TChromeTabsControlPosition.SetOffsets(const Value: TChromeTabsAddButtonOffsets);
begin
  FOffsets.Assign(Value);
end;

procedure TChromeTabsControlPosition.SetWidth(const Value: Integer);
begin
  FWidth := Value;

  DoChanged;
end;

{ TChromeTabsOffsets }

constructor TChromeTabsOffsets.Create(AOwner: TPersistent);
begin
  inherited;

  FVertical := 0;
  FHorizontal := 0;
end;

procedure TChromeTabsOffsets.SetHorizontal(const Value: Integer);
begin
  FHorizontal := Value;

  DoChanged;
end;

procedure TChromeTabsOffsets.SetVertical(const Value: Integer);
begin
  FVertical := Value;

  DoChanged;
end;

{ TChromeTabsControlPropertiesEx }

constructor TChromeTabsControlPropertiesEx.Create(AOwner: TPersistent);
begin
  inherited;

  FVisible := TRUE;
end;

procedure TChromeTabsControlPropertiesEx.SetVisible(const Value: Boolean);
begin
  FVisible := Value;

  DoChanged;
end;

{ TChromeTabsCloseButtonProperties }

constructor TChromeTabsCloseButtonProperties.Create(AOwner: TPersistent);
begin
  inherited;

  FAutoHide := TRUE;
  FVisibility := bvAll;

  FAutoHideWidth := 20;
  Offsets.Vertical := 6;
  Width := 13;
  Height := 13;
  FCrossRadialOffset := 4
end;

destructor TChromeTabsCloseButtonProperties.Destroy;
begin
  inherited;
end;

procedure TChromeTabsCloseButtonProperties.SetAutoHide(const Value: Boolean);
begin
  FAutoHide := Value;

  DoChanged;
end;

procedure TChromeTabsCloseButtonProperties.SetAutoHideWidth(
  const Value: Integer);
begin
  FAutoHideWidth := Value;

  DoChanged;
end;

procedure TChromeTabsCloseButtonProperties.SetCrossRadialOffset(
  const Value: Integer);
begin
  FCrossRadialOffset := Value;

  DoChanged;
end;

procedure TChromeTabsCloseButtonProperties.SetVisibility(
  const Value: TCloseButtonVisiblity);
begin
  FVisibility := Value;

  DoChanged;
end;

{ TChromeTabsAddButtonProperties }

constructor TChromeTabsAddButtonProperties.Create(AOwner: TPersistent);
begin
  inherited;

  FShowPlusSign := TRUE;
  FVisibility := avRightFloating;

  Offsets.Vertical := 9;
  Height := 14;
  Width := 25;
end;

destructor TChromeTabsAddButtonProperties.Destroy;
begin

  inherited;
end;

procedure TChromeTabsAddButtonProperties.SetShowPlusSign(
  const Value: Boolean);
begin
  FShowPlusSign := Value;

  DoChanged;
end;

procedure TChromeTabsAddButtonProperties.SetVisibility(
  const Value: TAddButtonVisibility);
begin
  FVisibility := Value;

  DoChanged;
end;

{ TChromeTabsLookAndFeelCustomStyleItems }

constructor TChromeTabsLookAndFeelCustomStyleItems.Create(AOwner: TPersistent);
begin
  inherited;

  FStyleProperty1 := TChromeTabsLookAndFeelStyle.Create(Self);
  FStyleProperty2 := TChromeTabsLookAndFeelStyle.Create(Self);
  FStyleProperty3 := TChromeTabsLookAndFeelStyle.Create(Self);
end;

destructor TChromeTabsLookAndFeelCustomStyleItems.Destroy;
begin
  FreeAndNil(FStyleProperty1);
  FreeAndNil(FStyleProperty2);
  FreeAndNil(FStyleProperty3);

  inherited;
end;

procedure TChromeTabsLookAndFeelCustomStyleItems.SetStyleProperty2(
  const Value: TChromeTabsLookAndFeelStyle);
begin
  FStyleProperty2.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelCustomStyleItems.SetStyleProperty3(
  const Value: TChromeTabsLookAndFeelStyle);
begin
  FStyleProperty3.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelCustomStyleItems.SetStyleProperty1(
  const Value: TChromeTabsLookAndFeelStyle);
begin
  FStyleProperty1.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelCustomStyleItems.Invalidate;
begin
  FStyleProperty1.Invalidate;
  FStyleProperty2.Invalidate;
  FStyleProperty3.Invalidate;
end;

{ TChromeTabsCustomLookAndFeelStylePropertyItems }

constructor TChromeTabsCustomLookAndFeelStylePropertyItems.Create(AOwner: TPersistent);
begin
  inherited;

  FStyleProperty1 := TChromeTabsLookAndFeelStyleProperties.Create(Self);
  FStyleProperty2 := TChromeTabsLookAndFeelStyleProperties.Create(Self);
  FStyleProperty3 := TChromeTabsLookAndFeelStyleProperties.Create(Self);
end;

destructor TChromeTabsCustomLookAndFeelStylePropertyItems.Destroy;
begin
  FreeAndNil(FStyleProperty1);
  FreeAndNil(FStyleProperty2);
  FreeAndNil(FStyleProperty3);

  inherited;
end;

procedure TChromeTabsCustomLookAndFeelStylePropertyItems.SetStyleProperty1(
  const Value: TChromeTabsLookAndFeelStyleProperties);
begin
  FStyleProperty1.AssignTo(Value);
end;

procedure TChromeTabsCustomLookAndFeelStylePropertyItems.SetStyleProperty2(
  const Value: TChromeTabsLookAndFeelStyleProperties);
begin
  FStyleProperty2.AssignTo(Value);
end;

procedure TChromeTabsCustomLookAndFeelStylePropertyItems.Invalidate;
begin
  FStyleProperty1.Invalidate;
  FStyleProperty2.Invalidate;
  FStyleProperty3.Invalidate;
end;

procedure TChromeTabsCustomLookAndFeelStylePropertyItems.SetStyleProperty3(
  const Value: TChromeTabsLookAndFeelStyleProperties);
begin
  FStyleProperty3.AssignTo(Value);
end;

{ TChromeTabsLookAndFeelPen }

constructor TChromeTabsLookAndFeelPen.Create(AOwner: TPersistent);
begin
  inherited;

  FThickness := 1;
  FAlpha := 255;
  FColor := clBlack;
end;

function TChromeTabsLookAndFeelPen.GetPen: TGPPen;
begin
  if FInvalidated then
  begin
    FreeAndNil(FPen);

    FInvalidated := FALSE;
  end;

  if FPen = nil then
    FPen := TGPPen.Create(MakeGDIPColor(FColor, FAlpha), FThickness);

  Result := FPen;
end;

procedure TChromeTabsLookAndFeelPen.Invalidate;
begin
  inherited;

  FreeAndNil(FPen);
end;

procedure TChromeTabsLookAndFeelPen.SetAlpha(const Value: Integer);
begin
  FAlpha := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelPen.SetColor(const Value: TColor);
begin
  FColor := Value;

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelPen.SetThickness(const Value: Single);
begin
  FThickness := Value;

  Invalidate;

  DoChanged;
end;

{ TChromeTabsCustomLookAndFeelPenItem }

constructor TChromeTabsCustomLookAndFeelPenItem.Create(AOwner: TPersistent);
begin
  inherited;

  FPen1 := TChromeTabsLookAndFeelPen.Create(Self);
  FPen2 := TChromeTabsLookAndFeelPen.Create(Self);
  FPen3 := TChromeTabsLookAndFeelPen.Create(Self);
end;

destructor TChromeTabsCustomLookAndFeelPenItem.Destroy;
begin
  FreeAndNil(FPen1);
  FreeAndNil(FPen2);
  FreeAndNil(FPen3);

  inherited;
end;

procedure TChromeTabsCustomLookAndFeelPenItem.SetPen1(
  const Value: TChromeTabsLookAndFeelPen);
begin
  FPen1.Assign(Value);

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsCustomLookAndFeelPenItem.SetPen2(
  const Value: TChromeTabsLookAndFeelPen);
begin
  FPen2.Assign(Value);

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsCustomLookAndFeelPenItem.SetPen3(
  const Value: TChromeTabsLookAndFeelPen);
begin
  FPen3.Assign(Value);

  Invalidate;

  DoChanged;
end;

procedure TChromeTabsCustomLookAndFeelPenItem.Invalidate;
begin
  FPen1.Invalidate;
  FPen2.Invalidate;
  FPen3.Invalidate;
end;

{ TChromeTabsLookAndFeelDisabledButton }

constructor TChromeTabsLookAndFeelDisabledButton.Create(
  AOwner: TPersistent);
begin
  inherited;

  FDisabled := TChromeTabsLookAndFeelStyle.Create(Self);
end;

destructor TChromeTabsLookAndFeelDisabledButton.Destroy;
begin
  FreeAndNil(FDisabled);

  inherited;
end;

procedure TChromeTabsLookAndFeelDisabledButton.SetDisabled(
  const Value: TChromeTabsLookAndFeelStyle);
begin
  FDisabled.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelDisabledButton.Invalidate;
begin
  inherited;

  FDisabled.Invalidate;
end;

{ TChromeTabsLookAndFeelTab }

constructor TChromeTabsLookAndFeelTab.Create(AOwner: TPersistent);
begin
  inherited;

  FBaseLine := TChromeTabsLookAndFeelPen.Create(Self);
  FModified := TChromeTabsLookAndFeelGlow.Create(Self);
  FDefaultFont := TChromeTabsLookAndFeelBaseFont.Create(Self);
  FMouseGlow := TChromeTabsLookAndFeelGlow.Create(Self);

  FBaseLine.Color := clGray;
  FBaseLine.Thickness := 2;
  FBaseLine.Alpha := 255;
end;

destructor TChromeTabsLookAndFeelTab.Destroy;
begin
  FreeAndNil(FBaseLine);
  FreeAndNil(FModified);
  FreeandNil(FMouseGlow);
  FreeandNil(FDefaultFont);

  inherited;
end;

procedure TChromeTabsLookAndFeelTab.SetBaseLine(
  const Value: TChromeTabsLookAndFeelPen);
begin
  FBaseLine.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelTab.SetDefaultFont(
  const Value: TChromeTabsLookAndFeelBaseFont);
begin
  FDefaultFont.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelTab.SetModified(
  const Value: TChromeTabsLookAndFeelGlow);
begin
  FModified.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelTab.SetMouseGlow(
  const Value: TChromeTabsLookAndFeelGlow);
begin
  FMouseGlow.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelTab.Invalidate;
begin
  FBaseLine.Invalidate;
end;

{ TChromeTabPolygons }

function TChromeTabPolygons.AddPolygon(Polygon: TPolygon;
  Brush: TGPBrush; Pen: TGPPen): IChromeTabPolygons;
var
  ChromeTabPolygon: TChromeTabPolygon;
begin
  Result := Self;

  ChromeTabPolygon := TChromeTabPolygon.Create;
  FPolygons.Add(ChromeTabPolygon);

  ChromeTabPolygon.Polygon := Polygon;
  ChromeTabPolygon.Brush := Brush;
  ChromeTabPolygon.Pen := Pen;
end;

constructor TChromeTabPolygons.Create;
begin
  FPolygons := TObjectList.Create(TRUE);
end;

destructor TChromeTabPolygons.Destroy;
begin
  FreeAndNil(FPolygons);

  inherited;
end;

procedure TChromeTabPolygons.DrawTo(TargetCanvas: TGPGraphics; DrawToFunctions: TDrawToFunctions);
var
  i: Integer;
begin
  for i := 0 to pred(FPolygons.Count) do
  begin
    if (Polygons[i].Brush <> nil) and (DrawToFunctions in [dfBrush, dfBrushAndPen]) then
      TargetCanvas.FillPolygon(Polygons[i].Brush, PGPPoint(@Polygons[i].Polygon[0]), Length(Polygons[i].Polygon));

    if (Polygons[i].Pen <> nil) and (DrawToFunctions in [dfPen, dfBrushAndPen]) then
      TargetCanvas.DrawPolygon(Polygons[i].Pen, PGPPoint(@Polygons[i].Polygon[0]), Length(Polygons[i].Polygon));
  end;
end;

function TChromeTabPolygons.GetPolygonCount: Integer;
begin
  Result := FPolygons.Count;
end;

function TChromeTabPolygons.GetPolygons(Index: Integer): TChromeTabPolygon;
begin
  Result := TChromeTabPolygon(FPolygons[Index]);
end;

{ TChromeTabsLookAndFeelScrollButton }

constructor TChromeTabsLookAndFeelScrollButton.Create(AOwner: TPersistent);
begin
  inherited;

  FButton := TChromeTabsLookAndFeelDisabledButton.Create(Self);
  FArrow := TChromeTabsLookAndFeelDisabledButton.Create(Self);
end;

destructor TChromeTabsLookAndFeelScrollButton.Destroy;
begin
  FreeAndNil(FButton);
  FreeAndNil(FArrow);

  inherited;
end;

procedure TChromeTabsLookAndFeelScrollButton.Invalidate;
begin
  inherited;

  FButton.Invalidate;
  FArrow.Invalidate;
end;

procedure TChromeTabsLookAndFeelScrollButton.SetArrow(
  const Value: TChromeTabsLookAndFeelDisabledButton);
begin
  FArrow.Assign(Value);

  DoChanged;
end;

procedure TChromeTabsLookAndFeelScrollButton.SetButton(
  const Value: TChromeTabsLookAndFeelDisabledButton);
begin
  FButton.Assign(Value);

  DoChanged;
end;

{ TChromeTabModifiedDisplayOptions }

constructor TChromeTabModifiedDisplayOptions.Create(AOwner: TPersistent);
begin
  inherited;

  FStyle := msRightToLeft;
  FVerticalOffset := -2;
  FHeight := 20;
  FWidth := 50;
  FAnimationSteps := 150;
end;

procedure TChromeTabModifiedDisplayOptions.SetHeight(const Value: Integer);
begin
  FHeight := Value;

  DoChanged;
end;

procedure TChromeTabModifiedDisplayOptions.SetAnimationSteps(const Value: Integer);
begin
  FAnimationSteps := Value;

  DoChanged;
end;

procedure TChromeTabModifiedDisplayOptions.SetStyle(
  const Value: TChromeTabModifiedStyle);
begin
  FStyle := Value;

  DoChanged;
end;

procedure TChromeTabModifiedDisplayOptions.SetVerticalOffset(const Value: Integer);
begin
  FVerticalOffset := Value;

  DoChanged;
end;

procedure TChromeTabModifiedDisplayOptions.SetWidth(const Value: Integer);
begin
  FWidth := Value;

  DoChanged;
end;

{ TChromeTabsLookAndFeelTabModified }

constructor TChromeTabsLookAndFeelGlow.Create(AOwner: TPersistent);
begin
  inherited;

  FCentreColor := clWhite;
  FOutsideColor := clWhite;
  FCentreAlpha := 180;
  FOutsideAlpha := 0;
end;

procedure TChromeTabsLookAndFeelGlow.SetCentreAlpha(const Value: Byte);
begin
  FCentreAlpha := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelGlow.SetCentreColor(const Value: TColor);
begin
  FCentreColor := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelGlow.SetOutsideAlpha(const Value: Byte);
begin
  FOutsideAlpha := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelGlow.SetOutsideColor(const Value: TColor);
begin
  FOutsideColor := Value;

  DoChanged;
end;

{ TChromeTabsContainerOptions }

constructor TChromeTabsContainerOptions.Create(AOwner: TPersistent);
begin
  inherited;

end;

procedure TChromeTabsContainerOptions.SetOverlayButtons(const Value: Boolean);
begin
  FOverlayButtons := Value;

  DoChanged;
end;

procedure TChromeTabsContainerOptions.SetPaddingLeft(const Value: Integer);
begin
  FPaddingLeft := Value;

  DoChanged;
end;

procedure TChromeTabsContainerOptions.SetPaddingRight(const Value: Integer);
begin
  FPaddingRight := Value;

  DoChanged;
end;

procedure TChromeTabsContainerOptions.SetTransparentBackground(
  const Value: Boolean);
begin
  FTransparentBackground := Value;

  DoChanged;
end;

{ TChromeTabsLookAndFeelBaseFont }

constructor TChromeTabsLookAndFeelBaseFont.Create(AOwner: TPersistent);
begin
  inherited;

  FName := 'Segoe UI';
  FColor := clBlack;
  FSize := 9;
  FAlpha := 255;
  FTextRendoringMode := TextRenderingHintClearTypeGridFit;
end;

procedure TChromeTabsLookAndFeelBaseFont.SetAlpha(const Value: Byte);
begin
  FAlpha := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelBaseFont.SetColor(const Value: TColor);
begin
  FColor := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelBaseFont.SetName(const Value: TFontName);
begin
  FName := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelBaseFont.SetSize(const Value: Integer);
begin
  FSize := Value;

  DoChanged;
end;

procedure TChromeTabsLookAndFeelBaseFont.SetTextRendoringMode(const Value: TTextRenderingHint);
begin
  FTextRendoringMode := Value;

  DoChanged;
end;


{ TChromeTabsLookAndFeelFont }

constructor TChromeTabsLookAndFeelFont.Create(AOwner: TPersistent);
begin
  inherited;

  FUseDefaultFont := TRUE;
end;

procedure TChromeTabsLookAndFeelFont.SetUseDefaultFont(const Value: Boolean);
begin
  FUseDefaultFont := Value;

  DoChanged;
end;

{ TChromeTabsAddButtonOffsets }

constructor TChromeTabsAddButtonOffsets.Create(AOwner: TPersistent);
begin
  inherited;

  FHorizontalFloating := 0;
end;

procedure TChromeTabsAddButtonOffsets.SetHorizontalFloating(
  const Value: Integer);
begin
  FHorizontalFloating := Value;

  DoChanged;
end;

end.
