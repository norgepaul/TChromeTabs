unit ChromeTabsControls;

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
  System.SysUtils, System.Classes, System.Types, System.Math,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.GraphUtil, Vcl.ImgList,
  Vcl.Dialogs,
  WinApi.Windows, WinApi.Messages,
  Vcl.Graphics,
  {$ELSE}
  SysUtils, Classes,Math,
  Controls, ExtCtrls, Forms, GraphUtil, ImgList, Dialogs,
  Windows, Messages, Graphics,
  {$IFEND}

  GDIPObj, GDIPAPI,

  ChromeTabsTypes,
  ChromeTabsUtils,
  ChromeTabsClasses;

type
  TBaseChromeTabsControl = class(TObject)
  private
    FControlRect: TRect;
    FChromeTabs: IChromeTabs;
    FDrawState: TDrawState;
    FStartRect: TRect;
    FStartTicks: Cardinal;
    FCurrentTickCount: Cardinal;
    FEndRect: TRect;
    FPositionInitialised: Boolean;
    FScrollableControl: Boolean;
    FOverrideBidi: Boolean;
    FEaseType: TChromeTabsEaseType;
    FAnimationTime: Cardinal;

    function GetBidiControlRect: TRect;
  protected
    FInvalidated: Boolean;
    FControlType: TChromeTabItemType;

    procedure DoChanged; virtual;

    procedure EndAnimation; virtual;
    procedure Invalidate; virtual;
    function ScrollRect(ARect: TRect): TRect;
    function BidiRect(ARect: TRect): TRect;
    property ChromeTabs: IChromeTabs read FChromeTabs;
  public
    constructor Create(ChromeTabs: IChromeTabs); virtual;

    procedure DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons = nil); virtual; abstract;

    function InternalGetPolygons(ControlType: TChromeTabItemType; DefaultBrush: TGPBrush; DefaultPen: TGPPen): IChromeTabPolygons; virtual;
    function GetPolygons: IChromeTabPolygons; virtual; abstract;
    function AnimateMovement: Boolean; virtual;
    function AnimateStyle: Boolean; virtual;
    function ControlRectScrolled: TRect; virtual;
    function ContainsPoint(Pt: TPoint): Boolean; virtual;

    property ControlRect: TRect read FControlRect;
    property BiDiControlRect: TRect read GetBidiControlRect;
    function NewPolygon(ControlRect: TRect; const Polygon: array of TPoint; Orientation: TTabOrientation): TPolygon; virtual;
    function BidiPolygon(Polygon: TPolygon): TPolygon;

    property StartRect: TRect read FStartRect;
    property EndRect: TRect read FEndRect;

    procedure SetDrawState(const Value: TDrawState; AnimationTimeMS: Integer; EaseType: TChromeTabsEaseType; ForceUpdate: Boolean = FALSE); virtual;
    procedure SetPosition(ARect: TRect; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType); virtual;
    procedure SetHeight(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType); virtual;
    procedure SetWidth(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType); virtual;
    procedure SetLeft(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType); virtual;
    procedure SetTop(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType); virtual;

    property DrawState: TDrawState read FDrawState;
    property ControlType: TChromeTabItemType read FControlType;
    property ScrollableControl: Boolean read FScrollableControl write FScrollableControl;
    property OverrideBidi: Boolean read FOverrideBidi write FOverrideBidi;
  end;

  TChromeTabControlProperties = record
    FontColor: TColor;
    FontAlpha: Byte;
    FontName: String;
    FontSize: Integer;
    TextRenderingMode: TTextRenderingHint;
    StartColor: TColor;
    StopColor: TColor;
    OutlineColor: TColor;
    OutlineSize: Single;
    OutlineAlpha: Integer;
    StartAlpha: Integer;
    StopAlpha: Integer;
  end;

  TChromeTabControlPropertyItems = class
  private
    FStartTickCount: Cardinal;
    FEndTickCount: Cardinal;
    FCurrentTickCount: Cardinal;
    FStartTabProperties: TChromeTabControlProperties;
    FStopTabProperties: TChromeTabControlProperties;
    FCurrentTabProperties: TChromeTabControlProperties;
    FEaseType: TChromeTabsEaseType;
  public
    procedure SetProperties(Style: TChromeTabsLookAndFeelStyle; StyleFont: TChromeTabsLookAndFeelFont; DefaultFont: TChromeTabsLookAndFeelBaseFont; EndTickCount: Cardinal; EaseType: TChromeTabsEaseType);
    function TransformColors(ForceUpdate: Boolean): Boolean;
    procedure EndAnimation;

    property StartTabProperties: TChromeTabControlProperties read FStartTabProperties write FStartTabProperties;
    property StopTabProperties: TChromeTabControlProperties read FStopTabProperties write FStopTabProperties;
    property CurrentTabProperties: TChromeTabControlProperties read FCurrentTabProperties write FCurrentTabProperties;
    property StartTickCount: Cardinal read FStartTickCount;
    property EndTickCount: Cardinal read FEndTickCount;
    property CurrentTickCount: Cardinal read FCurrentTickCount;
  end;

  TChromeTabControl = class(TBaseChromeTabsControl)
  private
    FChromeTab: IChromeTab;
    FBmp: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap;
    FCloseButtonState: TDrawState;
    FChromeTabControlPropertyItems: TChromeTabControlPropertyItems;
    FTabProperties: TChromeTabsLookAndFeelStyleProperties;
    FTabBrush: TGPLinearGradientBrush;
    FTabPen: TGPPen;
    FModifiedPosition: Integer;
    FModifiedMovingLeft: Boolean;
    FPenInvalidated: Boolean;
    FBrushInvalidated: Boolean;
    FCloseButtonInvalidate: Boolean;
    FModifiedStartTicks: Cardinal;
    FSpinnerImageIndex: Integer;
    FSpinnerRenderedDegrees: Integer;

    function CloseButtonVisible: Boolean;
    function GetTabBrush: TGPLinearGradientBrush;
    function GetTabPen: TGPPen;
    function ImageVisible(ImageList: TCustomImageList; ImageIndex: Integer): Boolean;
    procedure CalculateRects(var ImageRect, TextRect, CloseButtonRect,
      CloseButtonCrossRect: TRect; var NormalImageVisible, OverlayImageVisible, SpinnerVisible,
      TextVisible: Boolean);
    function GetSpinnerImageList: TCustomImageList;
  protected
    procedure SetCloseButtonState(const Value: TDrawState); virtual;
    procedure EndAnimation; override;
  public
    constructor Create(ChromeTabs: IChromeTabs; TabInterface: IChromeTab); reintroduce;
    destructor Destroy; override;

    procedure Invalidate; override;
    function AnimateStyle: Boolean; override;
    function AnimateModified: Boolean; virtual;
    function AnimateSpinner: Boolean; virtual;
    procedure DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons = nil); override;
    function GetPolygons: IChromeTabPolygons; override;
    function GetHitTestArea(MouseX, MouseY: Integer): THitTestArea;
    function GetCloseButonRect: TRect;
    function GetCloseButtonCrossRect: TRect;
    procedure SetDrawState(const Value: TDrawState; AnimationTimeMS: Integer; EaseType: TChromeTabsEaseType; ForceUpdate: Boolean = FALSE); override;
    function GetTabWidthByContent: Integer;

    property CloseButtonState: TDrawState read FCloseButtonState write SetCloseButtonState;
    property ChromeTab: IChromeTab read FChromeTab;
  end;

  TBaseChromeButtonControl = class(TBaseChromeTabsControl)
  private
    FButtonBrush: TGPLinearGradientBrush;
    FButtonPen: TGPPen;
    FSymbolBrush: TGPLinearGradientBrush;
    FSymbolPen: TGPPen;
  protected
    FButtonControlPropertyItems: TChromeTabControlPropertyItems;
    FSymbolControlPropertyItems: TChromeTabControlPropertyItems;

    FButtonStyle: TChromeTabsLookAndFeelStyle;
    FSymbolStyle: TChromeTabsLookAndFeelStyle;

    function GetButtonBrush: TGPLinearGradientBrush; virtual;
    function GetButtonPen: TGPPen; virtual;
    function GetSymbolBrush: TGPLinearGradientBrush; virtual;
    function GetSymbolPen: TGPPen; virtual;

    procedure SetStylePropertyClasses; virtual;
  public
    constructor Create(ChromeTabs: IChromeTabs); override;
    destructor Destroy; override;

    function AnimateStyle: Boolean; override;

    procedure Invalidate; override;

    procedure SetDrawState(const Value: TDrawState; AnimationTimeMS: Integer; EaseType: TChromeTabsEaseType; ForceUpdate: Boolean = FALSE); override;
  end;

  TAddButtonControl = class(TBaseChromeButtonControl)
  protected
    procedure SetStylePropertyClasses; override;
  public
    constructor Create(ChromeTabs: IChromeTabs); override;

    procedure DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons = nil); override;
    function GetPolygons: IChromeTabPolygons; override;
  end;

  TScrollButtonControl = class(TBaseChromeButtonControl)
  protected
    procedure SetStylePropertyClasses; override;
    function GetArrowPolygons(Direction: TChromeTabDirection): IChromeTabPolygons;
  public
    procedure DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons = nil); override;
  end;

  TScrollButtonLeftControl = class(TScrollButtonControl)
  public
    constructor Create(ChromeTabs: IChromeTabs); override;

    procedure DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons = nil); override;
    function GetPolygons: IChromeTabPolygons; override;
  end;

  TScrollButtonRightControl = class(TScrollButtonControl)
  public
    constructor Create(ChromeTabs: IChromeTabs); override;

    procedure DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons = nil); override;
    function GetPolygons: IChromeTabPolygons; override;
  end;

implementation

{ TBaseChromeTabControl }

function TBaseChromeTabsControl.ScrollRect(ARect: TRect): TRect;
begin
  if FScrollableControl then
    Result := ChromeTabs.ScrollRect(ARect)
  else
    Result := ARect;
end;

function TBaseChromeTabsControl.BidiPolygon(Polygon: TPolygon): TPolygon;
begin
  if ChromeTabs.GetBiDiMode in BidiRightToLeftTabModes then
    Result := HorzFlipPolygon(BidiControlRect, Polygon)
  else
    Result := Polygon;
end;

function TBaseChromeTabsControl.BidiRect(ARect: TRect): TRect;
begin
  if ChromeTabs.GetBiDiMode in BidiRightToLeftTabModes then
    Result := HorzFlipRect(BidiControlRect, HorzFlipRect(BidiControlRect, ChromeTabs.BidiRect(ARect)))
  else
    Result := ARect;
end;

function TBaseChromeTabsControl.NewPolygon(ControlRect: TRect; const Polygon: Array of TPoint; Orientation: TTabOrientation): TPolygon;
var
  ScrolledRect: TRect;
begin
  ScrolledRect := ScrollRect(ControlRect);

  Result := GeneratePolygon(ScrolledRect, Polygon, Orientation);
end;

function TBaseChromeTabsControl.AnimateMovement: Boolean;
begin
  Result := (FStartTicks > 0) and (FCurrentTickCount < FAnimationTime);

  if Result then
  begin
    FCurrentTickCount := GetTickCount - FStartTicks;

    if FCurrentTickCount > FAnimationTime then
      FCurrentTickCount := FAnimationTime;

    FControlRect := TransformRect(FStartRect,
                                  FEndRect,
                                  FCurrentTickCount,
                                  FAnimationTime,
                                  FEaseType);
  end;
end;

function TBaseChromeTabsControl.AnimateStyle: Boolean;
begin
  Result := FALSE;
end;

function TBaseChromeTabsControl.ContainsPoint(Pt: TPoint): Boolean;
var
  i: Integer;
  ChromeTabPolygons: IChromeTabPolygons;
begin
  Result := FALSE;

  ChromeTabPolygons := GetPolygons;

  for i := 0 to pred(ChromeTabPolygons.PolygonCount) do
    if PointInPolygon(ChromeTabPolygons.Polygons[i].Polygon, Pt.X, Pt.Y) then
    begin
      Result := TRUE;

      Break;
    end;
end;

function TBaseChromeTabsControl.ControlRectScrolled: TRect;
begin
  Result := ChromeTabs.ScrollRect(ControlRect);
end;

constructor TBaseChromeTabsControl.Create(
  ChromeTabs: IChromeTabs);
begin
  FChromeTabs := ChromeTabs;

  FPositionInitialised := FALSE;
  FScrollableControl := FALSE;
end;

procedure TBaseChromeTabsControl.DoChanged;
begin
  FChromeTabs.DoOnChange(nil, tcControlState);
end;

procedure TBaseChromeTabsControl.EndAnimation;
begin
  // Override if required
end;

function TBaseChromeTabsControl.GetBidiControlRect: TRect;
begin
  if FOverrideBidi then
    Result := FControlRect
  else
    Result := ChromeTabs.BidiRect(FControlRect);
end;

function TBaseChromeTabsControl.InternalGetPolygons(ControlType: TChromeTabItemType; DefaultBrush: TGPBrush; DefaultPen: TGPPen): IChromeTabPolygons;
var
  i: Integer;
begin
  Result := nil;

  ChromeTabs.DoOnGetControlPolygons(Self, ControlRect, ControlType, ChromeTabs.GetOptions.Display.Tabs.Orientation, Result);

  if Result <> nil then
  begin
    for i := 0 to pred(Result.PolygonCount) do
    begin
      if Result.Polygons[i].Brush = nil then
        Result.Polygons[i].Brush := DefaultBrush;

      if Result.Polygons[i].Pen = nil then
        Result.Polygons[i].Pen := DefaultPen;
    end;
  end;
end;

procedure TBaseChromeTabsControl.Invalidate;
begin
  FInvalidated := TRUE;
end;

procedure TBaseChromeTabsControl.SetDrawState(const Value: TDrawState; AnimationTimeMS: Integer; EaseType: TChromeTabsEaseType; ForceUpdate: Boolean);
begin
  // Override in descendants if animation is required
  if (ForceUpdate) or (FDrawState <> Value) then
  begin
    FDrawState := Value;

    DoChanged;
  end;
end;

procedure TBaseChromeTabsControl.SetHeight(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType);
begin
  SetPosition(Rect(FControlRect.Left,
                   FControlRect.Top,
                   FControlRect.Right,
                   FControlRect.Top + Value),
              AnimationTime,
              EaseType);
end;

procedure TBaseChromeTabsControl.SetLeft(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType);
begin
  SetPosition(Rect(Value,
                   FControlRect.Top,
                   RectWidth(FControlRect) + Value,
                   FControlRect.Bottom),
              AnimationTime,
              EaseType);
end;

procedure TBaseChromeTabsControl.SetWidth(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType);
begin
  SetPosition(Rect(FControlRect.Left,
                   FControlRect.Top,
                   FControlRect.Left + Value,
                   FControlRect.Bottom),
              AnimationTime,
              EaseType);
end;

procedure TBaseChromeTabsControl.SetTop(const Value: Integer; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType);
begin
  SetPosition(Rect(FControlRect.Left,
                   Value,
                   FControlRect.Right,
                   RectHeight(FControlRect) + Value),
              AnimationTime,
              EaseType);
end;

procedure TBaseChromeTabsControl.SetPosition(ARect: TRect; AnimationTime: Cardinal; EaseType: TChromeTabsEaseType);
begin
  FEaseType := EaseType;
  FAnimationTime := AnimationTime;

  if (FPositionInitialised) and
     (EaseType <> ttNone) then
  begin
    // If we want to animate, or we are curently animating,
    // set the destination Rect and calculate the animation increments
    if not SameRect(FEndRect, ARect) then
    begin
      FEndRect := ARect;
      FStartRect := FControlRect;

      FStartTicks := GetTickCount;
      FCurrentTickCount := 0;
    end;
  end
  else
  begin
    // Set the flag to indicate that we're set the initial position
    FPositionInitialised := TRUE;

    EndAnimation;

    // Otherwise, set the destination Rect
    FControlRect := ARect;
    FStartRect := ARect;
    FEndRect := ARect;

    FStartTicks := FAnimationTime;
    FCurrentTickCount := FStartTicks;
  end;
end;


{ TrkAddButton }

function TAddButtonControl.GetPolygons: IChromeTabPolygons;
var
  LeftOffset, TopOffset: Integer;
begin
  Result := InternalGetPolygons(itAddButton, GetButtonBrush, GetButtonPen);

  if Result = nil then
  begin
    Result := TChromeTabPolygons.Create;

    Result.AddPolygon(BidiPolygon(
                      NewPolygon(BidiControlRect, [Point(7, RectHeight(BidiControlRect)),
                                 Point(4, RectHeight(BidiControlRect) - 2),
                                 Point(0, 2),
                                 Point(1, 0),
                                 Point(RectWidth(BidiControlRect) - 7, 0),
                                 Point(RectWidth(BidiControlRect) - 4, 2),
                                 Point(RectWidth(BidiControlRect), RectHeight(BidiControlRect) - 2),
                                 Point(RectWidth(BidiControlRect), RectHeight(BidiControlRect))],
                      ChromeTabs.GetOptions.Display.Tabs.Orientation)),
                      GetButtonBrush,
                      GetButtonPen);

    if ChromeTabs.GetOptions.Display.AddButton.ShowPlusSign then
    begin
      LeftOffset := (ChromeTabs.GetOptions.Display.AddButton.Width div 2) - 4;
      TopOffset := (ChromeTabs.GetOptions.Display.AddButton.Height div 2) - 4;

      Result.AddPolygon(BidiPolygon(
                        NewPolygon(Rect(BidiControlRect.Left + LeftOffset,
                                   BidiControlRect.Top + TopOffset,
                                   BidiControlRect.Right - LeftOffset,
                                   BidiControlRect.Bottom - TopOffset),
                                  [Point(0, 3),
                                   Point(3, 3),
                                   Point(3, 0),
                                   Point(6, 0),
                                   Point(6, 3),
                                   Point(9, 3),
                                   Point(9, 6),
                                   Point(6, 6),
                                   Point(6, 9),
                                   Point(3, 9),
                                   Point(3, 6),
                                   Point(0, 6),
                                   Point(0, 3)],
                               ChromeTabs.GetOptions.Display.Tabs.Orientation)),
                               GetSymbolBrush,
                               GetSymbolPen);
    end;
  end;
end;

procedure TAddButtonControl.SetStylePropertyClasses;
begin
  case FDrawState of
    dsDown:
      begin
        FButtonStyle := ChromeTabs.GetLookAndFeel.AddButton.Button.Down;
        FSymbolStyle := ChromeTabs.GetLookAndFeel.AddButton.PlusSign.Down;
      end;

    dsHot:
      begin
        FButtonStyle := ChromeTabs.GetLookAndFeel.AddButton.Button.Hot;
        FSymbolStyle := ChromeTabs.GetLookAndFeel.AddButton.PlusSign.Hot;
      end
  else
    begin
      FButtonStyle := ChromeTabs.GetLookAndFeel.AddButton.Button.Normal;
      FSymbolStyle := ChromeTabs.GetLookAndFeel.AddButton.PlusSign.Normal;
    end;
  end;
end;

constructor TAddButtonControl.Create(ChromeTabs: IChromeTabs);
begin
  inherited Create(ChromeTabs);

  FControlType := itAddButton;

  FButtonStyle := ChromeTabs.GetLookAndFeel.AddButton.Button.Normal;
  FSymbolStyle := ChromeTabs.GetLookAndFeel.AddButton.PlusSign.Normal;
end;

procedure TAddButtonControl.DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons);
var
  Handled: Boolean;
begin
  ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itAddButton, -1, Handled);

  if not Handled then
    GetPolygons.DrawTo(TabCanvas);

  ChromeTabs.DoOnAfterDrawItem(TabCanvas, ControlRect, itAddButton, -1);
end;

{ TChromeTabControl }

constructor TChromeTabControl.Create(ChromeTabs: IChromeTabs; TabInterface: IChromeTab);
begin
  inherited Create(ChromeTabs);

  FChromeTabControlPropertyItems := TChromeTabControlPropertyItems.Create;

  FBmp := {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap.Create;
  FBmp.PixelFormat := pf32Bit;

  FControlType := itTab;

  FChromeTab := TabInterface;

  FScrollableControl := TRUE;
end;

destructor TChromeTabControl.Destroy;
begin
  FreeAndNil(FTabBrush);
  FreeAndNil(FTabPen);

  FreeAndNil(FBmp);
  FreeAndNil(FChromeTabControlPropertyItems);

  inherited;
end;

function TChromeTabControl.GetHitTestArea(MouseX, MouseY: Integer): THitTestArea;
var
  TabPolygon: IChromeTabPolygons;
  CloseRect: TRect;
  i: Integer;
begin
  TabPolygon := GetPolygons;

  Result := htBackground;

  if CloseButtonVisible then
  begin
    CloseRect := ChromeTabs.ScrollRect(BidiRect(GetCloseButonRect));

    if PtInRect(CloseRect, Point(MouseX, MouseY)) then
    begin
      Result := htCloseButton;

      Exit;
    end;
  end;

  for i := 0 to pred(TabPolygon.PolygonCount) do
  begin
    if PointInPolygon(TabPolygon.Polygons[i].Polygon, MouseX, MouseY) then
    begin
      Result := htTab;

      Break;
    end;
  end;
end;

function TChromeTabControl.AnimateModified: Boolean;
var
  TickCount: Cardinal;
  LowX, HighX: Integer;
  ScrolledRect: TRect;
  Distance: Integer;
begin
  Result := (FChromeTab.GetModified) and
            (ChromeTabs.GetOptions.Display.TabModifiedGlow.Style <> msNone);

  if Result then
  begin
    TickCount := GetTickCount;

    if (FModifiedStartTicks = 0) or
       (TickCount - FModifiedStartTicks > Cardinal(ChromeTabs.GetOptions.Display.TabModifiedGlow.AnimationPeriodMS)) then
    begin
      if TickCount - FModifiedStartTicks > Cardinal(ChromeTabs.GetOptions.Display.TabModifiedGlow.AnimationPeriodMS) then
        FModifiedMovingLeft := not FModifiedMovingLeft;

      FModifiedStartTicks := TickCount;
    end;

    ScrolledRect := ScrollRect(ControlRect);

    LowX := ScrolledRect.Left - (ChromeTabs.GetOptions.Display.TabModifiedGlow.Width);
    HighX := ScrolledRect.Right;

    Distance := Round(CalculateEase(TickCount - FModifiedStartTicks,
                                    0,
                                    HighX - LowX,
                                    ChromeTabs.GetOptions.Display.TabModifiedGlow.AnimationPeriodMS,
                                    ChromeTabs.GetOptions.Display.TabModifiedGlow.EaseType));

    if (ChromeTabs.GetOptions.Display.TabModifiedGlow.Style = msRightToLeft) or
       ((ChromeTabs.GetOptions.Display.TabModifiedGlow.Style = msKnightRider) and (FModifiedMovingLeft)) then
      FModifiedPosition := LowX + (HighX - LowX) - Distance
    else
      FModifiedPosition := LowX + Distance;
  end
  else
    FModifiedStartTicks := 0;
end;

function TChromeTabControl.GetSpinnerImageList: TCustomImageList;
begin
  case ChromeTab.GetSpinnerState of
    tssImageUpload: Result := ChromeTabs.GetImagesSpinnerUpload;
    tssImageDownload: Result := ChromeTabs.GetImagesSpinnerDownload;
  else
    Result := nil;
  end;
end;

function TChromeTabControl.AnimateSpinner: Boolean;

  procedure UpdateSpinnerAngle(SpinnerOptions: TChromeTabsSpinnerOptions);
  begin
    if SpinnerOptions.ReverseDirection then
    begin
      Dec(FSpinnerRenderedDegrees, SpinnerOptions.RenderedAnimationStep);

      if FSpinnerRenderedDegrees < 0 then
        FSpinnerRenderedDegrees := 360 + FSpinnerRenderedDegrees;
    end
    else
    begin
      Inc(FSpinnerRenderedDegrees, SpinnerOptions.RenderedAnimationStep);

      if FSpinnerRenderedDegrees > 360 then
        FSpinnerRenderedDegrees := FSpinnerRenderedDegrees - 360;
    end;
  end;

var
  Images: TCustomImageList;
begin
  Images := GetSpinnerImageList;

  Result := (Images <> nil) or
            (ChromeTab.GetSpinnerState in [tssRenderedUpload, tssRenderedDownload]);

  if Result then
  begin
    case ChromeTab.GetSpinnerState of
      tssRenderedUpload:
        begin
          UpdateSpinnerAngle(ChromeTabs.GetOptions.Display.TabSpinners.Upload);
        end;

      tssRenderedDownload:
        begin
          UpdateSpinnerAngle(ChromeTabs.GetOptions.Display.TabSpinners.Download);
        end;

      tssImageUpload:
        begin
          Dec(FSpinnerImageIndex);

          if FSpinnerImageIndex < 0 then
            FSpinnerImageIndex := pred(Images.Count);
        end;

      tssImageDownload:
        begin
          Inc(FSpinnerImageIndex);

          if FSpinnerImageIndex >= Images.Count then
            FSpinnerImageIndex := 0;
        end;
    end;
  end;
end;

function TChromeTabControl.AnimateStyle: Boolean;
begin
  Result := FChromeTabControlPropertyItems.TransformColors(FALSE);

  if Result then
    Invalidate;
end;

function TChromeTabControl.CloseButtonVisible: Boolean;
begin
  if (not ChromeTab.GetActive) and
     (RectWidth(ControlRect) -
      ChromeTabs.GetOptions.Display.Tabs.ContentOffsetRight -
      ChromeTabs.GetOptions.Display.Tabs.ContentOffsetLeft <= ChromeTabs.GetOptions.Display.CloseButton.AutoHideWidth) then
    Result := FALSE
  else
  begin
    // Hide the close button on all tabs if we have the hide close button override set
    if ChromeTab.GetHideCloseButton then
    begin
      Result := FALSE;
    end
    else
    begin
      case ChromeTabs.GetOptions.Display.CloseButton.Visibility of
        bvAll: Result := not ChromeTab.GetPinned;
        bvActive: Result := (not ChromeTab.GetPinned) and (FDrawState = dsActive);
      else
        Result := FALSE;
      end;
    end;
  end;
end;

function TChromeTabControl.ImageVisible(ImageList: TCustomImageList; ImageIndex: Integer): Boolean;
begin
  Result := (ChromeTabs.GetOptions.Display.Tabs.ShowImages) and
            (ImageList <> nil) and
            (ImageIndex >= 0) and
            (ImageIndex < ImageList.Count);
end;

procedure TChromeTabControl.Invalidate;
begin
  inherited;

  FPenInvalidated := TRUE;
  FBrushInvalidated := TRUE;
  FCloseButtonInvalidate := TRUE;
end;

function TChromeTabControl.GetPolygons: IChromeTabPolygons;
begin
  Result := InternalGetPolygons(itTab, GetTabBrush, GetTabPen);

  if Result = nil then
  begin
    Result := TChromeTabPolygons.Create;

    Result.AddPolygon(NewPolygon(BidiControlRect, [Point(0, RectHeight(ControlRect)),
                                       Point(4, RectHeight(ControlRect) - 3),
                                       Point(12, 3),
                                       Point(13, 2),
                                       Point(14, 1),
                                       Point(16, 0),
                                       Point(RectWidth(ControlRect) - 16, 0),
                                       Point(RectWidth(ControlRect) - 14, 1),
                                       Point(RectWidth(ControlRect) - 13, 2),
                                       Point(RectWidth(ControlRect) - 12, 3),
                                       Point(RectWidth(ControlRect) - 4, RectHeight(ControlRect) - 3),
                                       Point(RectWidth(ControlRect), RectHeight(ControlRect))],
                                 ChromeTabs.GetOptions.Display.Tabs.Orientation),
                      GetTabBrush,
                      GetTabPen);
  end;
end;

function TChromeTabControl.GetCloseButonRect: TRect;
begin
  Result.Left := ControlRect.Right -
                 ChromeTabs.GetOptions.Display.Tabs.ContentOffsetRight -
                 ChromeTabs.GetOptions.Display.CloseButton.Width -
                 ChromeTabs.GetOptions.Display.CloseButton.Offsets.Horizontal;
  Result.Top := ControlRect.Top +
                ChromeTabs.GetOptions.Display.CloseButton.Offsets.Vertical;
  Result.Right := Result.Left +
                  ChromeTabs.GetOptions.Display.CloseButton.Width;
  Result.Bottom := Result.Top +
                   ChromeTabs.GetOptions.Display.CloseButton.Height;
end;

function TChromeTabControl.GetCloseButtonCrossRect: TRect;
begin
  Result := GetCloseButonRect;

  Result := Rect(Result.Left + ChromeTabs.GetOptions.Display.CloseButton.CrossRadialOffset,
                 Result.Top + ChromeTabs.GetOptions.Display.CloseButton.CrossRadialOffset,
                 Result.Right - ChromeTabs.GetOptions.Display.CloseButton.CrossRadialOffset,
                 Result.Bottom - ChromeTabs.GetOptions.Display.CloseButton.CrossRadialOffset);
end;

function TChromeTabControl.GetTabBrush: TGPLinearGradientBrush;
begin
  if FBrushInvalidated then
  begin
    FBrushInvalidated := FALSE;

    FreeAndNil(FTabBrush);
  end;

  if FTabBrush = nil then
    FTabBrush := TGPLinearGradientBrush.Create(MakePoint(0, ControlRect.Top),
                                               MakePoint(0, ControlRect.Bottom),
                                               MakeGDIPColor(FChromeTabControlPropertyItems.CurrentTabProperties.StartColor, FChromeTabControlPropertyItems.CurrentTabProperties.StartAlpha),
                                               MakeGDIPColor(FChromeTabControlPropertyItems.CurrentTabProperties.StopColor, FChromeTabControlPropertyItems.CurrentTabProperties.StopAlpha));

  Result := FTabBrush;
end;

function TChromeTabControl.GetTabPen: TGPPen;
begin
  if FPenInvalidated then
  begin
    FPenInvalidated := FALSE;

    FreeAndNil(FTabPen);
  end;

  if FTabPen = nil then
    FTabPen := TGPPen.Create(MakeGDIPColor(FChromeTabControlPropertyItems.CurrentTabProperties.OutlineColor,
                                           FChromeTabControlPropertyItems.CurrentTabProperties.OutlineAlpha),
                                           FChromeTabControlPropertyItems.CurrentTabProperties.OutlineSize);

  Result := FTabPen;
end;

function TChromeTabControl.GetTabWidthByContent: Integer;
var
  TabCanvas: TGPGraphics;
  TabsFont: TGPFont;
  TxtFormat: TGPStringFormat;
  GPRectF: TGPRectF;
  Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap;
  ImageRect, TextRect, CloseButtonRect, CloseButtonCrossRect: TRect;
  NormalImageVisible, OverlayImageVisible, SpinnerVisible, TextVisible: Boolean;
  RightOffset: Integer;
  ScrolledRect: TRect;
begin
  Bitmap := {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap.Create;
  try
    Bitmap.Width := ChromeTabs.GetOptions.Display.Tabs.MaxWidth;
    Bitmap.Height := RectHeight(ControlRect);

    TabCanvas := TGPGraphics.Create(Bitmap.Canvas.Handle);
    TabsFont := TGPFont.Create(FChromeTabControlPropertyItems.StopTabProperties.FontName,
                               FChromeTabControlPropertyItems.CurrentTabProperties.FontSize);
    TxtFormat := TGPStringFormat.Create;
    try
      TabCanvas.SetTextRenderingHint(FChromeTabControlPropertyItems.StopTabProperties.TextRenderingMode);
      TxtFormat.SetTrimming(StringTrimmingNone);

      TabCanvas.MeasureString(WideString(ChromeTab.GetCaption),
                              length(ChromeTab.GetCaption),
                              TabsFont,
                              RectToGPRectF(Rect(0, 0, 1000, RectHeight(ControlRect))),
                              TxtFormat,
                              GPRectF);

      CalculateRects(ImageRect, TextRect, CloseButtonRect, CloseButtonCrossRect,
         NormalImageVisible, OverlayImageVisible, SpinnerVisible, TextVisible);

      ScrolledRect := ScrollRect(ControlRect);

      if NormalImageVisible or OverlayImageVisible or SpinnerVisible then
        RightOffset := ImageRect.Right
      else
        RightOffset := ScrolledRect.Left + ChromeTabs.GetOptions.Display.Tabs.ContentOffsetLeft;

      Result :=
        Round(GPRectF.Width) +
        (RightOffset - ScrolledRect.Left) +
        (ScrolledRect.Right - CloseButtonRect.Left) -
        (ChromeTabs.GetOptions.Display.Tabs.TabOverlap);
    finally
      FreeAndNil(TabCanvas);
      FreeAndNil(TabsFont);
      FreeandNil(TxtFormat);
    end;
  finally
    FreeAndNil(Bitmap);
  end;
end;

procedure TChromeTabControl.CalculateRects(var ImageRect, TextRect,
  CloseButtonRect, CloseButtonCrossRect: TRect;
  var NormalImageVisible, OverlayImageVisible, SpinnerVisible, TextVisible: Boolean);
var
  LeftOffset, RightOffset, ImageWidth, ImageHeight: Integer;
begin
  // Get the close button rect
  CloseButtonRect := GetCloseButonRect;
  CloseButtonCrossRect := GetCloseButtonCrossRect;

  if CloseButtonVisible then
  begin
    RightOffset := CloseButtonRect.Left - 1
  end
  else
  begin
    RightOffset := ControlRect.Right - ChromeTabs.GetOptions.Display.Tabs.ContentOffsetRight;
    CloseButtonRect.Left := CloseButtonRect.Right;
  end;

  // Get image size
  LeftOffset := ControlRect.Left + ChromeTabs.GetOptions.Display.Tabs.ContentOffsetLeft;

  NormalImageVisible := ImageVisible(ChromeTabs.GetImages, ChromeTab.GetImageIndex);
  OverlayImageVisible := ImageVisible(ChromeTabs.GetImagesOverlay, ChromeTab.GetImageIndexOverlay);
  SpinnerVisible := (ChromeTab.GetSpinnerState <> tssNone) and (not (csDesigning in ChromeTabs.GetComponentState));

  ImageWidth := 0;
  ImageHeight := 0;

  if SpinnerVisible then
  begin
    if ChromeTab.GetSpinnerState = tssRenderedUpload then
    begin
      ImageWidth := ChromeTabs.GetOptions.Display.TabSpinners.Upload.Position.Width;
      ImageHeight := ChromeTabs.GetOptions.Display.TabSpinners.Upload.Position.Height;
    end
    else
    begin
      ImageWidth := ChromeTabs.GetOptions.Display.TabSpinners.Download.Position.Width;
      ImageHeight := ChromeTabs.GetOptions.Display.TabSpinners.Download.Position.Height;
    end;
  end;

  if ((not SpinnerVisible) or
      (not ChromeTabs.GetOptions.Display.TabSpinners.HideImagesWhenSpinnerVisible)) and
     (NormalImageVisible) or
     (OverlayImageVisible) then
  begin
    if ChromeTabs.GetImages.Width > ImageWidth then
      ImageWidth := ChromeTabs.GetImages.Width;

    if ChromeTabs.GetImages.Height > ImageHeight then
      ImageHeight := ChromeTabs.GetImages.Height;
  end;

  if OverlayImageVisible then
  begin
    if ChromeTabs.GetImagesOverlay.Width > ChromeTabs.GetImagesOverlay.Width then
      ImageWidth := ChromeTabs.GetImagesOverlay.Width;

    if ChromeTabs.GetImagesOverlay.Height > ChromeTabs.GetImagesOverlay.Height then
      ImageHeight := ChromeTabs.GetImagesOverlay.Height;
  end;

  // Does the image fit between the left margin and the close button?
  if LeftOffset + ImageWidth > RightOffset then
  begin
    NormalImageVisible := FALSE;
    OverlayImageVisible := FALSE;
    SpinnerVisible := FALSE;
  end
  else
  begin
    // Should we centre the image?
    if (ChromeTab.GetPinned) and
       (not ChromeTabs.GetOptions.Display.Tabs.ShowPinnedTabText) then
      ImageRect := Rect(ControlRect.Left + (RectWidth(ControlRect) div 2) - (ImageWidth div 2),
                        ControlRect.Top + (RectHeight(ControlRect) div 2) - (ImageHeight div 2),
                        ControlRect.Left + (RectWidth(ControlRect) div 2) - (RectWidth(CloseButtonRect) div 2) + ImageHeight,
                        (ControlRect.Top + (RectHeight(ControlRect) div 2) - (ImageHeight div 2)) + ImageHeight)
    else
    begin
      ImageRect := Rect(LeftOffset,
                        ControlRect.Top + (RectHeight(ControlRect) div 2) - (ImageHeight div 2),
                        LeftOffset + ImageWidth,
                        (ControlRect.Top + (RectHeight(ControlRect) div 2) - (ImageHeight div 2)) + ImageHeight);

      LeftOffset := LeftOffset + ImageWidth + 1;
    end;
  end;

  // Does the Text fit?
  TextVisible := ((not ChromeTab.GetPinned) or
                  (ChromeTabs.GetOptions.Display.Tabs.ShowPinnedTabText)) and
                 (RightOffset - LeftOffset >= 5);

  if TextVisible then
  begin
    TextRect := Rect(LeftOffset,
                     ControlRect.Top,
                     RightOffset,
                     ControlRect.Bottom);
  end;

  if (CloseButtonVisible) and
     (not TextVisible) and
     (not NormalImageVisible) and
     (not OverlayImageVisible) and
     (not SpinnerVisible) then
  begin
    // If only the close button is visible, we need to centre it
    CloseButtonRect := Rect(ControlRect.Left + (RectWidth(ControlRect) div 2) - (RectWidth(CloseButtonRect) div 2),
                            CloseButtonRect.Top,
                            ControlRect.Left + (RectWidth(ControlRect) div 2) - (RectWidth(CloseButtonRect) div 2) + RectWidth(CloseButtonRect),
                            CloseButtonRect.Bottom);

    CloseButtonCrossRect := Rect(ControlRect.Left + (RectWidth(ControlRect) div 2) - (RectWidth(CloseButtonCrossRect) div 2),
                                 CloseButtonCrossRect.Top,
                                 ControlRect.Left + (RectWidth(ControlRect) div 2) - (RectWidth(CloseButtonCrossRect) div 2) + RectWidth(CloseButtonCrossRect),
                                 CloseButtonCrossRect.Bottom);
  end;

  ImageRect := ScrollRect(BidiRect(ImageRect));
  TextRect := ScrollRect(BidiRect(TextRect));
  CloseButtonRect := ScrollRect(BidiRect(CloseButtonRect));
  CloseButtonCrossRect := ScrollRect(BidiRect(CloseButtonCrossRect));
end;

procedure TChromeTabControl.DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons);

  procedure DrawGDITextWithOffset(const Text: String; TextRect: TRect; OffsetX, OffsetY: Integer; FontColor: TColor; Alpha: Byte; TextHint: TextRenderingHint);
  const
    BlendFactorsNormal: array[0..2] of Single = (0.0, 0.0, 0.0);
  var
    TabsFont: TGPFont;
    GPRect: TGPRectF;
    TxtFormat: TGPStringFormat;
    TabsTxtBrush: TGPLinearGradientBrush;
    TextFormatFlags: Integer;
    TabText: String;
    TextSize: Integer;
    BlendPositions: array[0..2] of Single;
    BlendFactorsFade: array[0..2] of Single;
  begin
    if ChromeTabs.GetOptions.Behaviour.DebugMode then
      TextSize := 7
    else
      TextSize := FChromeTabControlPropertyItems.CurrentTabProperties.FontSize;

    TabsFont := TGPFont.Create(FChromeTabControlPropertyItems.StopTabProperties.FontName, TextSize);
    try
      TabsTxtBrush := TGPLinearGradientBrush.Create(RectToGPRect(TextRect),
                                                    MakeGDIPColor(FontColor, Alpha),
                                                    MakeGDIPColor(FontColor, 0),
                                                    LinearGradientModeHorizontal);
      try
        GPRect.X := TextRect.Left + OffsetX;
        GPRect.Y := TextRect.Top + OffsetY;
        GPRect.Width := RectWidth(TextRect);
        GPRect.Height := RectHeight(TextRect);

        TxtFormat := TGPStringFormat.Create;
        try
          TabCanvas.SetTextRenderingHint(TextHint);

          BlendPositions[0] := 0.0;
          BlendPositions[2] := 1.0;

          BlendFactorsFade[1] := 0.0;;

          // Calculate the position at which we start to fade the text
          // A correction is made for text under 80 pixels
          if RectWidth(TextRect) > 80 then
            BlendPositions[1] := 0.85
          else
            BlendPositions[1] := 0.85 - ((80 - RectWidth(TextRect)) / 80);

          // Set the text trim mode
          if (ChromeTabs.GetOptions.Display.Tabs.TabWidthFromContent) and
             (RectWidth(ControlRect) < ChromeTabs.GetOptions.Display.Tabs.MaxWidth + ChromeTabs.GetOptions.Display.Tabs.TabOverlap) then
          begin
            TxtFormat.SetTrimming(StringTrimmingNone);

            TabsTxtBrush.SetBlend(@BlendFactorsNormal[0], @BlendPositions[0], Length(BlendFactorsNormal));
          end else
          if ChromeTabs.GetOptions.Display.Tabs.TextTrimType <> tttFade then
          begin
            TxtFormat.SetTrimming(TStringTrimming(ChromeTabs.GetOptions.Display.Tabs.TextTrimType));

            TabsTxtBrush.SetBlend(@BlendFactorsNormal[0], @BlendPositions[0], Length(BlendFactorsNormal));
          end
          else
          begin
            // Set the fade blend factors to fade the end of the text
            TxtFormat.SetTrimming(StringTrimmingNone);

            if ChromeTabs.GetBiDiMode in BidiRightTextAlignmentModes then
            begin
              BlendFactorsFade[0] := 1.0;
              BlendFactorsFade[2] := 0.0;

              BlendPositions[1] := 1 - BlendPositions[1];
            end
            else
            begin
              BlendFactorsFade[0] := 0.0;
              BlendFactorsFade[2] := 1.0;
            end;

            TabsTxtBrush.SetBlend(@BlendFactorsFade[0], @BlendPositions[0], Length(BlendFactorsFade));
          end;

          // Set the verrtical alignment
          case ChromeTabs.GetOptions.Display.Tabs.TextAlignmentVertical of
            taAlignTop: TxtFormat.SetLineAlignment(StringAlignmentNear);

            taAlignBottom: TxtFormat.SetLineAlignment(StringAlignmentFar);

            taVerticalCenter: TxtFormat.SetLineAlignment(StringAlignmentCenter);
          end;

          // Set the horizontal alignment
          case ChromeTabs.GetOptions.Display.Tabs.TextAlignmentHorizontal of
            taLeftJustify: if (ChromeTabs.GetBidiMode in BidiLeftToRightTextModes) or
                              (ChromeTabs.GetBidiMode in BidiRightTextAlignmentModes) then
                             TxtFormat.SetAlignment(StringAlignmentNear)
                           else
                             TxtFormat.SetAlignment(StringAlignmentFar);

            taRightJustify: if (ChromeTabs.GetBidiMode in BidiLeftToRightTextModes) or
                               (ChromeTabs.GetBidiMode in BidiRightTextAlignmentModes) then
                              TxtFormat.SetAlignment(StringAlignmentFar)
                            else
                              TxtFormat.SetAlignment(StringAlignmentNear);

            taCenter: TxtFormat.SetAlignment(StringAlignmentCenter);
          end;

          TextFormatFlags := 0;

          // Set other flags
          if not ChromeTabs.GetOptions.Behaviour.DebugMode then
          begin
            if not ChromeTabs.GetOptions.Display.Tabs.WordWrap then
              TextFormatFlags := TextFormatFlags + StringFormatFlagsNoWrap;

            if ChromeTabs.GetBiDiMode in BidiRightToLeftTextModes then
              TextFormatFlags := TextFormatFlags + StringFormatFlagsDirectionRightToLeft;
          end;

          TxtFormat.SetFormatFlags(TextFormatFlags);

          // Debug mode text
          if ChromeTabs.GetOptions.Behaviour.DebugMode then
            TabText := format('L: %d, T: %d, R: %d: B: %d W: %d H: %d',
                              [ControlRect.Left,
                               ControlRect.Top,
                               ControlRect.Right,
                               ControlRect.Bottom,
                               RectWidth(ControlRect),
                               RectHeight(ControlRect)])
          else
            TabText := ChromeTab.GetCaption;

          // Draw the text
          TabCanvas.DrawString(PChar(TabText),
                               Length(TabText),
                               TabsFont,
                               GPRect,
                               TxtFormat,
                               TabsTxtBrush);
        finally
          FreeAndNil(TxtFormat);
        end;
      finally
        FreeAndNil(TabsTxtBrush);
      end;
    finally
      FreeAndNil(TabsFont);
    end;
  end;

  procedure DrawGDIText(const Text: String; TextRect: TRect);
  begin
    DrawGDITextWithOffset(Text,
                          TextRect,
                          0,
                          0,
                          FChromeTabControlPropertyItems.CurrentTabProperties.FontColor,
                          FChromeTabControlPropertyItems.CurrentTabProperties.FontAlpha,
                          FChromeTabControlPropertyItems.StopTabProperties.TextRenderingMode);
  end;

  procedure DrawImage(Images: TCustomImageList; ImageIndex: Integer; ImageRect: TRect; ChromeTabItemType: TChromeTabItemType);
  var
    ImageBitmap: TGPImage;
    Handled: Boolean;
  begin
    ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ImageRect, ChromeTabItemType, ChromeTab.GetIndex, Handled);

    if not Handled then
    begin
      ImageBitmap := ImageListToTGPImage(Images, ImageIndex);
      try
        TabCanvas.DrawImage(ImageBitmap, ImageRect.Left, ImageRect.Top);
      finally
        FreeAndNil(ImageBitmap);
      end;
    end;

    ChromeTabs.DoOnAfterDrawItem(TabCanvas, ImageRect, ChromeTabItemType, ChromeTab.GetIndex);
  end;

  procedure DrawGlow(GlowRect: TRect; CentreColor, OutsideColor: TColor; CentreAlpha, OutsideAlpha: Byte);
  var
    GPGraphicsPath: TGPGraphicsPath;
    GlowBrush: TGPPathGradientBrush;
    SurroundColors : array[0..0] of TGPColor;
    ColCount: Integer;
  begin
    GPGraphicsPath := TGPGraphicsPath.Create;
    try
      // Add the glow ellipse to the path
      GPGraphicsPath.AddEllipse(RectToGPRectF(GlowRect));

      // Create the glow brush
      GlowBrush := TGPPathGradientBrush.Create(GPGraphicsPath);
      try
        // Set the glow parameters
        GlowBrush.SetCenterPoint(PointToGPPoint(Point(GlowRect.Left +
                                                      (RectWidth(GlowRect) div 2),
                                                      GlowRect.Top +
                                                      (Rectheight(GlowRect) div 2))));

        GlowBrush.SetCenterColor(MakeGDIPColor(CentreColor,
                                               CentreAlpha));
        ColCount := 1;

        SurroundColors[0] := MakeGDIPColor(OutsideColor,
                                           OutsideAlpha);

        GlowBrush.SetSurroundColors(@SurroundColors[0],
                                    ColCount);

        // Draw the glow
        TabCanvas.FillPath(GlowBrush, GPGraphicsPath);
      finally
        FreeAndNil(GlowBrush);
      end;
    finally
      FreeAndNil(GPGraphicsPath);
    end;
  end;

  procedure DrawSpinner(ImageRect: TRect);
  var
    SpinnerImages: TCustomImageList;
    SpinPen: TGPPen;
    SpinnerOptions: TChromeTabsSpinnerOptions;
    SpinnerLookAndFeel: TChromeTabsLookAndFeelPen;
    Offset: Real;
    Handled: Boolean;
  begin
    ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ImageRect, itTabImageSpinner, ChromeTab.GetIndex, Handled);

    if not Handled then
    begin
      if ChromeTab.GetSpinnerState in [tssRenderedUpload, tssRenderedDownload] then
      begin
        if ChromeTab.GetSpinnerState = tssRenderedUpload then
        begin
          SpinnerOptions := ChromeTabs.GetOptions.Display.TabSpinners.Upload;
          SpinnerLookAndFeel := ChromeTabs.GetLookAndFeel.Tabs.Spinners.Upload;
        end
        else
        begin
          SpinnerOptions := ChromeTabs.GetOptions.Display.TabSpinners.Download;
          SpinnerLookAndFeel := ChromeTabs.GetLookAndFeel.Tabs.Spinners.Download;
        end;

        Offset := SpinnerLookAndFeel.Thickness / 2;

        SpinPen := TGPPen.Create(MakeGDIPColor(SpinnerLookAndFeel.Color, SpinnerLookAndFeel.Alpha), SpinnerLookAndFeel.Thickness);
        try
          TabCanvas.DrawArc(SpinPen,
                            ImageRect.Left + Offset + SpinnerOptions.Position.Offsets.Horizontal,
                            ImageRect.Top + Offset + SpinnerOptions.Position.Offsets.Vertical,
                            SpinnerOptions.Position.Width - (Offset * 2),
                            SpinnerOptions.Position.Height - (Offset * 2),
                            FSpinnerRenderedDegrees,
                            SpinnerOptions.SweepAngle);
        finally
          FreeAndNil(SpinPen);
        end;
      end
      else
      begin
        SpinnerImages := GetSpinnerImageList;

        if SpinnerImages <> nil then
        begin
          DrawImage(SpinnerImages, FSpinnerImageIndex, ImageRect, itTabImageSpinner);
        end;
      end;
    end;
  end;

var
  CloseButtonStyle: TChromeTabsLookAndFeelStyle;
  CloseButtonCrossPen: TGPPen;
  ImageRect, TextRect, ButtonRect, CrossRect: TRect;
  NormalImageVisible, OverlayImageVisible, SpinnerVisible, TextVisible: Boolean;
  Handled: Boolean;
  ChromeTabPolygons: IChromeTabPolygons;
  OriginalClipRegion: TGPRegion;
  i: Integer;
  ModifiedTop: Integer;
begin
  if (FTabProperties <> nil) and (ChromeTabs <> nil) then
  begin
    OriginalClipRegion := TGPRegion.Create;
    try
      // Save the current clip region of the GPGraphics
      if ClipPolygons <> nil then
        for i := 0 to pred(ClipPolygons.PolygonCount) do
          SetTabClipRegionFromPolygon(TabCanvas, ClipPolygons.Polygons[i].Polygon, CombineModeExclude);

      TabCanvas.GetClip(OriginalClipRegion);

      ChromeTabPolygons := GetPolygons;

      // Calculate the positions and visibilty of the controls
      CalculateRects(ImageRect, TextRect, ButtonRect, CrossRect, NormalImageVisible, OverlayImageVisible, SpinnerVisible, TextVisible);

      // Fire the before draw event
      ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itTab, ChromeTab.GetIndex, Handled);

      // Only continue if the drawing hasn't already been handled
      if not Handled then
      begin
        // Draw the tab background
        ChromeTabPolygons.DrawTo(TabCanvas, dfBrush);
      end;

      // Set the clip region to that the glows stay within the tab
      SetTabClipRegionFromPolygon(TabCanvas, ChromeTabPolygons.Polygons[0].Polygon, CombineModeIntersect);

      // Draw the modified glow
      if (FChromeTab.GetModified) and
         (ChromeTabs.GetOptions.Display.TabModifiedGlow.Style <> msNone) then
      begin
        // Fire before draw event
        ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itTabModifiedGlow, ChromeTab.GetIndex, Handled);

        if not Handled then
        begin
          case ChromeTabs.GetOptions.Display.Tabs.Orientation of
            toTop: ModifiedTop := ChromeTabs.GetOptions.Display.TabModifiedGlow.VerticalOffset;
          else
            ModifiedTop := ControlRect.Bottom - ChromeTabs.GetOptions.Display.TabModifiedGlow.VerticalOffset;
          end;

          DrawGlow(BidiRect(Rect(FModifiedPosition,
                        ModifiedTop,
                        ChromeTabs.GetOptions.Display.TabModifiedGlow.Width + FModifiedPosition,
                        ChromeTabs.GetOptions.Display.TabModifiedGlow.Height + ChromeTabs.GetOptions.Display.TabModifiedGlow.VerticalOffset)),
                        ChromeTabs.GetLookAndFeel.Tabs.Modified.CentreColor,
                        ChromeTabs.GetLookAndFeel.Tabs.Modified.OutsideColor,
                        ChromeTabs.GetLookAndFeel.Tabs.Modified.CentreAlpha,
                        ChromeTabs.GetLookAndFeel.Tabs.Modified.OutsideAlpha);
        end;
      end;

      // Draw the mouse glow
      if (ChromeTabs.GetOptions.Display.TabMouseGlow.Visible) and
         (not ChromeTabs.IsDragging) and
         (PointInPolygon(ChromeTabPolygons.Polygons[0].Polygon, MouseX, MouseY)) then
      begin
        // Fire before draw event
        ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itTabMouseGlow, ChromeTab.GetIndex, Handled);

        if not Handled then
        begin
          DrawGlow(Rect(MouseX - (ChromeTabs.GetOptions.Display.TabMouseGlow.Width div 2),
                        MouseY - (ChromeTabs.GetOptions.Display.TabMouseGlow.Height div 2),
                        MouseX + (ChromeTabs.GetOptions.Display.TabMouseGlow.Width div 2),
                        MouseY + (ChromeTabs.GetOptions.Display.TabMouseGlow.Height div 2)),
                        ChromeTabs.GetLookAndFeel.Tabs.MouseGlow.CentreColor,
                        ChromeTabs.GetLookAndFeel.Tabs.MouseGlow.OutsideColor,
                        ChromeTabs.GetLookAndFeel.Tabs.MouseGlow.CentreAlpha,
                        ChromeTabs.GetLookAndFeel.Tabs.MouseGlow.OutsideAlpha);
        end;
      end;

      // Reset the clip region
      TabCanvas.SetClip(OriginalClipRegion);

      // Draw the text
      if TextVisible then
      begin
        ChromeTabs.DoOnBeforeDrawItem(TabCanvas, TextRect, itTabText, ChromeTab.GetIndex, Handled);

        if not Handled then
          DrawGDIText(ChromeTab.GetCaption, TextRect);

        ChromeTabs.DoOnAfterDrawItem(TabCanvas, TextRect, itTabText, ChromeTab.GetIndex);
      end;

      // Fire before draw event
      ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itTabOutline, ChromeTab.GetIndex, Handled);

      if not Handled then
      begin
        // Draw the border after the modified glow and text
        ChromeTabPolygons.DrawTo(TabCanvas, dfPen);
      end;

      // Draw the close button
      if CloseButtonVisible then
      begin
        ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ButtonRect, itTabCloseButton, ChromeTab.GetIndex, Handled);

        if not Handled then
        begin
          case FCloseButtonState of
            dsDown:
              begin
                CloseButtonStyle := ChromeTabs.GetLookAndFeel.CloseButton.Circle.Down;
                CloseButtonCrossPen := ChromeTabs.GetLookAndFeel.CloseButton.Cross.Down.GetPen;
              end;

            dsHot:
              begin
                CloseButtonStyle := ChromeTabs.GetLookAndFeel.CloseButton.Circle.Hot;
                CloseButtonCrossPen := ChromeTabs.GetLookAndFeel.CloseButton.Cross.Hot.GetPen;
              end;

            else
              begin
                CloseButtonStyle := ChromeTabs.GetLookAndFeel.CloseButton.Circle.Normal;
                CloseButtonCrossPen := ChromeTabs.GetLookAndFeel.CloseButton.Cross.Normal.GetPen;
              end;
          end;

          // Draw the circle
          TabCanvas.FillEllipse(CloseButtonStyle.GetBrush(ButtonRect),
                                                          ButtonRect.Left,
                                                          ButtonRect.Top,
                                                          RectWidth(ButtonRect),
                                                          RectHeight(ButtonRect));

          TabCanvas.DrawEllipse(CloseButtonStyle.GetPen,
                                ButtonRect.Left,
                                ButtonRect.Top,
                                RectWidth(ButtonRect),
                                RectHeight(ButtonRect));

          // Draw the cross
          TabCanvas.DrawLine(CloseButtonCrossPen, CrossRect.Left, CrossRect.Top, CrossRect.Right, CrossRect.Bottom);
          TabCanvas.DrawLine(CloseButtonCrossPen, CrossRect.Left, CrossRect.Bottom, CrossRect.Right, CrossRect.Top);
        end;

        ChromeTabs.DoOnAfterDrawItem(TabCanvas, ButtonRect, itTabCloseButton, ChromeTab.GetIndex);
      end;

      // Draw the normal and overlay images
      if (not SpinnerVisible) or
         (not ChromeTabs.GetOptions.Display.TabSpinners.HideImagesWhenSpinnerVisible) then
      begin
        if NormalImageVisible then
          DrawImage(ChromeTabs.GetImages, ChromeTab.GetImageIndex, ImageRect, itTabImage);

        if OverlayImageVisible then
          DrawImage(ChromeTabs.GetImagesOverlay, ChromeTab.GetImageIndexOverlay, ImageRect, itTabImageOverlay);
      end;

      // Draw the spinner image
      if SpinnerVisible then
        DrawSpinner(ImageRect);
    finally
      FreeAndNil(OriginalClipRegion);
    end;

    ChromeTabs.DoOnAfterDrawItem(TabCanvas, ControlRect, itTab, ChromeTab.GetIndex);
  end;
end;

procedure TChromeTabControl.EndAnimation;
begin
  FChromeTabControlPropertyItems.EndAnimation;

  AnimateStyle;
end;

procedure TChromeTabControl.SetCloseButtonState(const Value: TDrawState);
begin
  if FCloseButtonState <> Value then
  begin
    FCloseButtonState := Value;

    FCloseButtonInvalidate := TRUE;

    FChromeTabs.DoOnChange(FChromeTab.GetTab, tcControlState);
  end;
end;

procedure TChromeTabControl.SetDrawState(const Value: TDrawState; AnimationTimeMS: Integer; EaseType: TChromeTabsEaseType; ForceUpdate: Boolean);
var
  DefaultFont: TChromeTabsLookAndFeelBaseFont;
begin
  // Only update if the state has changed
  if (ForceUpdate) or (Value <> FDrawState) then
  begin
    // Retrieve the properties for the current state
    case Value of
      dsActive: FTabProperties := ChromeTabs.GetLookAndFeel.Tabs.Active;
      dsHot: FTabProperties := ChromeTabs.GetLookAndFeel.Tabs.Hot
    else
      FTabProperties := ChromeTabs.GetLookAndFeel.Tabs.NotActive;
    end;

    if FTabProperties.Font.UseDefaultFont then
      DefaultFont := ChromeTabs.GetLookAndFeel.Tabs.DefaultFont
    else
      DefaultFont := nil;

    FChromeTabControlPropertyItems.SetProperties(FTabProperties.Style,
                                                 FTabProperties.Font,
                                                 DefaultFont,
                                                 AnimationTimeMS,
                                                 EaseType);

    Invalidate;
  end;

  inherited;
end;


{ TScrollButtonControl }

procedure TScrollButtonControl.DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons);
begin
  GetPolygons.DrawTo(TabCanvas);
end;

function TScrollButtonControl.GetArrowPolygons(
  Direction: TChromeTabDirection): IChromeTabPolygons;
begin
  case Direction of
    drLeft:  Result := InternalGetPolygons(itScrollLeftButton, GetButtonBrush, GetButtonPen);
    drRight: Result := InternalGetPolygons(itScrollRightButton, GetButtonBrush, GetButtonPen);
  end;

  if Result = nil then
  begin
    Result := TChromeTabPolygons.Create;

    Result.AddPolygon(BidiPolygon(
                      NewPolygon(BidiControlRect, [Point(0, RectHeight(ControlRect)),
                                               Point(0, 0),
                                               Point(RectWidth(ControlRect), 0),
                                               Point(RectWidth(ControlRect), RectHeight(ControlRect))],
                                 ChromeTabs.GetOptions.Display.Tabs.Orientation)),
                                 GetButtonBrush,
                                 GetButtonPen);


    case Direction of
      drLeft:
        begin
          Result.AddPolygon(BidiPolygon(
                            NewPolygon(BidiControlRect, [Point(3, RectHeight(ControlRect) div 2),
                                                     Point(RectWidth(ControlRect) - 3, 2),
                                                     Point(RectWidth(ControlRect) - 3, RectHeight(ControlRect) - 2),
                                                     Point(3, RectHeight(ControlRect) div 2)],
                                       ChromeTabs.GetOptions.Display.Tabs.Orientation)),
                                       GetSymbolBrush,
                                       GetSymbolPen);
        end;

      drRight:
        begin
          Result.AddPolygon(BidiPolygon(
                            NewPolygon(BidiControlRect, [Point(RectWidth(ControlRect) - 3, RectHeight(ControlRect) div 2),
                                                     Point(3, 2),
                                                     Point(3, RectHeight(ControlRect) - 2),
                                                     Point(RectWidth(ControlRect) - 3, RectHeight(ControlRect) div 2)],
                                       ChromeTabs.GetOptions.Display.Tabs.Orientation)),
                                       GetSymbolBrush,
                                       GetSymbolPen);
        end;
    end;
  end;
end;

procedure TScrollButtonControl.SetStylePropertyClasses;
begin
  case FDrawState of
    dsDown:
      begin
        FButtonStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Button.Down;
        FSymbolStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Arrow.Down;
      end;

    dsHot:
      begin
        FButtonStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Button.Hot;
        FSymbolStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Arrow.Hot;
      end;

    dsDisabled:
      begin
        FButtonStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Button.Disabled;
        FSymbolStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Arrow.Disabled;
      end;
  else
    begin
      FButtonStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Button.Normal;
      FSymbolStyle := ChromeTabs.GetLookAndFeel.ScrollButtons.Arrow.Normal;
    end;
  end;
end;


{ TScrollButtonLeftControl }

constructor TScrollButtonLeftControl.Create(
  ChromeTabs: IChromeTabs);
begin
  inherited;

  FControlType := itScrollLeftButton;
end;

procedure TScrollButtonLeftControl.DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons);
var
  Handled: Boolean;
begin
  ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itScrollLeftButton, -1, Handled);

  if not Handled then
    inherited;

  ChromeTabs.DoOnAfterDrawItem(TabCanvas, ControlRect, itScrollLeftButton, -1);
end;

function TScrollButtonLeftControl.GetPolygons: IChromeTabPolygons;
begin
  Result := GetArrowPolygons(drLeft);
end;


{ TScrollButtonRightControl }

constructor TScrollButtonRightControl.Create(
  ChromeTabs: IChromeTabs);
begin
  inherited;

  FControlType := itScrollRightButton;
end;

procedure TScrollButtonRightControl.DrawTo(TabCanvas: TGPGraphics; MouseX, MouseY: Integer; ClipPolygons: IChromeTabPolygons);
var
  Handled: Boolean;
begin
  ChromeTabs.DoOnBeforeDrawItem(TabCanvas, ControlRect, itScrollRightButton, -1, Handled);

  if not Handled then
    inherited;

  ChromeTabs.DoOnAfterDrawItem(TabCanvas, ControlRect, itScrollRightButton, -1);
end;

function TScrollButtonRightControl.GetPolygons: IChromeTabPolygons;
begin
  Result := GetArrowPolygons(drRight);
end;


{ TChromeTabControlPropertyItems }

procedure TChromeTabControlPropertyItems.EndAnimation;
begin
  FCurrentTickCount := FEndTickCount;
end;

procedure TChromeTabControlPropertyItems.SetProperties(Style: TChromeTabsLookAndFeelStyle;
  StyleFont: TChromeTabsLookAndFeelFont; DefaultFont: TChromeTabsLookAndFeelBaseFont;
  EndTickCount: Cardinal; EaseType: TChromeTabsEaseType);
var
  Dst: TChromeTabControlProperties;
  Font: TChromeTabsLookAndFeelBaseFont;
  FontCreated: Boolean;
begin
  FEaseType := EaseType;

  if DefaultFont <> nil then
    Font := DefaultFont
  else
    Font := StyleFont;

  FontCreated := False;
  if Font = nil then
  begin
    Font := TChromeTabsLookAndFeelBaseFont.Create(nil);
    FontCreated := True;
  end;

  // Copy the property values to the record
  Dst.FontColor := Font.Color;
  Dst.FontAlpha := Font.Alpha;
  Dst.FontName := Font.Name;
  Dst.FontSize := Font.Size;
  Dst.TextRenderingMode := Font.TextRenderingMode;
  if FontCreated then
    FreeAndNil(Font);

  Dst.StartColor := Style.StartColor;
  Dst.StopColor := Style.StopColor;
  Dst.OutlineColor := Style.OutlineColor;
  Dst.OutlineSize := Style.OutlineSize;
  Dst.OutlineAlpha := Style.OutlineAlpha;
  Dst.StartAlpha := Style.StartAlpha;
  Dst.StopAlpha := Style.StopAlpha;

  FStopTabProperties := Dst;
  FStartTabProperties := CurrentTabProperties;

  // then start the animation sequence
  FStartTickCount := GetTickCount;
  FCurrentTickCount := 0;

  if EaseType = ttNone then
  begin
    FEndTickCount := 0;
    FCurrentTickCount := FEndTickCount;

    TransformColors(TRUE);
  end
  else
    FEndTickCount := EndTickCount;
end;

function TChromeTabControlPropertyItems.TransformColors(ForceUpdate: Boolean): Boolean;
var
  TransformPct: Integer;
begin
  Result := FALSE;

  if (ForceUpdate) or
     ((FStartTickCount > 0) and
      (FCurrentTickCount < FEndTickCount)) then
  begin
    Result := TRUE;

    if ForceUpdate then
    begin
      TransformPct := 100;
    end
    else
    begin
      FCurrentTickCount := GetTickCount - FStartTickCount;

      if FCurrentTickCount > FEndTickCount then
        FCurrentTickCount := FEndTickCount;

      TransformPct := Round(CalculateEase(FCurrentTickCount, 0, 100, FEndTickCount, FEaseType));
    end;

    FCurrentTabProperties.FontColor := ColorBetween(FStartTabProperties.FontColor, FStopTabProperties.FontColor, TransformPct);
    FCurrentTabProperties.FontAlpha := IntegerBetween(FStartTabProperties.FontAlpha, FStopTabProperties.FontAlpha, TransformPct);
    FCurrentTabProperties.FontSize := IntegerBetween(FStartTabProperties.FontSize, FStopTabProperties.FontSize, TransformPct);

    FCurrentTabProperties.StartColor := ColorBetween(FStartTabProperties.StartColor, FStopTabProperties.StartColor, TransformPct);
    FCurrentTabProperties.StopColor := ColorBetween(FStartTabProperties.StopColor, FStopTabProperties.StopColor, TransformPct);
    FCurrentTabProperties.OutlineColor := ColorBetween(FStartTabProperties.OutlineColor, FStopTabProperties.OutlineColor, TransformPct);
    FCurrentTabProperties.OutlineSize := SingleBetween(FStartTabProperties.OutlineSize, FStopTabProperties.OutlineSize, TransformPct);
    FCurrentTabProperties.StartAlpha := IntegerBetween(FStartTabProperties.StartAlpha, FStopTabProperties.StartAlpha, TransformPct);
    FCurrentTabProperties.StopAlpha := IntegerBetween(FStartTabProperties.StopAlpha, FStopTabProperties.StopAlpha, TransformPct);
    FCurrentTabProperties.OutlineAlpha := IntegerBetween(FStartTabProperties.OutlineAlpha, FStopTabProperties.OutlineAlpha, TransformPct);
  end;
end;

{ TBaseChromeButtonControl }

function TBaseChromeButtonControl.AnimateStyle: Boolean;
var
  SymbolResult: Boolean;
begin
  Result := FButtonControlPropertyItems.TransformColors(FALSE);

  if Result then
  begin
    FreeAndNil(FButtonBrush);
    FreeAndNil(FButtonPen);

    SymbolResult := FSymbolControlPropertyItems.TransformColors(FALSE);

    if SymbolResult then
    begin
      FreeAndNil(FSymbolBrush);
      FreeAndNil(FSymbolPen);
    end;

    Result := Result or SymbolResult;
  end;

  if Result then
    Invalidate;
end;

constructor TBaseChromeButtonControl.Create(ChromeTabs: IChromeTabs);
begin
  inherited Create(ChromeTabs);

  FButtonControlPropertyItems := TChromeTabControlPropertyItems.Create;
  FSymbolControlPropertyItems := TChromeTabControlPropertyItems.Create;
end;

destructor TBaseChromeButtonControl.Destroy;
begin
  FreeAndNil(FButtonBrush);
  FreeAndNil(FButtonPen);
  FreeAndNil(FSymbolBrush);
  FreeAndNil(FSymbolPen);

  FreeAndNil(FButtonControlPropertyItems);
  FreeAndNil(FSymbolControlPropertyItems);

  Invalidate;

  inherited;
end;

function TBaseChromeButtonControl.GetButtonBrush: TGPLinearGradientBrush;
begin
  if FButtonBrush = nil then
    FButtonBrush := TGPLinearGradientBrush.Create(MakePoint(0, ControlRect.Top),
                                               MakePoint(0, ControlRect.Bottom),
                                               MakeGDIPColor(FButtonControlPropertyItems.CurrentTabProperties.StartColor, FButtonControlPropertyItems.CurrentTabProperties.StartAlpha),
                                               MakeGDIPColor(FButtonControlPropertyItems.CurrentTabProperties.StopColor, FButtonControlPropertyItems.CurrentTabProperties.StopAlpha));

  Result := FButtonBrush;
end;

function TBaseChromeButtonControl.GetButtonPen: TGPPen;
begin
  if FButtonPen = nil then
    FButtonPen := TGPPen.Create(MakeGDIPColor(FButtonControlPropertyItems.CurrentTabProperties.OutlineColor,
                                              FButtonControlPropertyItems.CurrentTabProperties.OutlineAlpha),
                                              FButtonControlPropertyItems.CurrentTabProperties.OutlineSize);

  Result := FButtonPen;
end;

function TBaseChromeButtonControl.GetSymbolBrush: TGPLinearGradientBrush;
begin
  if FSymbolBrush = nil then
    FSymbolBrush := TGPLinearGradientBrush.Create(MakePoint(0, ControlRect.Top),
                                               MakePoint(0, ControlRect.Bottom),
                                               MakeGDIPColor(FSymbolControlPropertyItems.CurrentTabProperties.StartColor, FSymbolControlPropertyItems.CurrentTabProperties.StartAlpha),
                                               MakeGDIPColor(FSymbolControlPropertyItems.CurrentTabProperties.StopColor, FSymbolControlPropertyItems.CurrentTabProperties.StopAlpha));

  Result := FSymbolBrush;
end;

function TBaseChromeButtonControl.GetSymbolPen: TGPPen;
begin
  if FSymbolPen = nil then
    FSymbolPen := TGPPen.Create(MakeGDIPColor(FSymbolControlPropertyItems.CurrentTabProperties.OutlineColor,
                                           FSymbolControlPropertyItems.CurrentTabProperties.OutlineAlpha),
                                           FSymbolControlPropertyItems.CurrentTabProperties.OutlineSize);

  Result := FSymbolPen;
end;

procedure TBaseChromeButtonControl.Invalidate;
begin
  FreeAndNil(FButtonBrush);
  FreeAndNil(FButtonPen);
  FreeAndNil(FSymbolBrush);
  FreeAndNil(FSymbolPen);
end;

procedure TBaseChromeButtonControl.SetDrawState(const Value: TDrawState;
  AnimationTimeMS: Integer; EaseType: TChromeTabsEaseType; ForceUpdate: Boolean);
begin
  // Only update if the state has changed
  if (ForceUpdate) or (Value <> FDrawState) then
  begin
    FDrawState := Value;

    SetStylePropertyClasses;

    FButtonControlPropertyItems.SetProperties(FButtonStyle, nil, nil, AnimationTimeMS, EaseType);
    FSymbolControlPropertyItems.SetProperties(FSymbolStyle, nil, nil, AnimationTimeMS, EaseType);

    Invalidate;
  end;

  inherited;
end;

procedure TBaseChromeButtonControl.SetStylePropertyClasses;
begin
  // Override
end;

end.
