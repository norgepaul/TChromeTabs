unit ChromeTabsTypes;

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
  System.Classes,
  WinApi.Windows,
  {$ELSE}
  Classes,
  Windows,
  {$IFEND}

  GDIPAPI;

type
  {$IF CompilerVersion < 18.0} //{$IFNDEF DELPHI2006_UP}
  TVerticalAlignment = (
    taAlignTop,
    taAlignBottom,
    taVerticalCenter
  );
  {$IFEND}

  TChromeTabDirection = (
    drLeft,
    drRight
  );

  TDrawToFunctions = (
    dfBrush,
    dfPen,
    dfBrushAndPen
  );

  TChromeTabDragType = (
    dtNone,
    dtWithinContainer,
    dtBetweenContainers
  );

  TChromeTabModifiedStyle = (
    msNone,
    msLeftToRight,
    msRightToLeft,
    msKnightRider
  );

  TChromeTabDragDisplay = (
    ddCursor,
    ddTab,
    ddControl,
    ddTabAndControl
  );

  TChromeTabSpinnerState = (
    tssNone,
    tssRenderedUpload,
    tssRenderedDownload,
    tssImageUpload,
    tssImageDownload
  );

  TTabChangeType = (
    tcAdded,
    tcMoved,
    tcDeleting,
    tcDeleted,
    tcPropertyUpdated,
    tcActivated,
    tcDeactivated,
    tcPinned,
    tcControlState,
    tcVisibility
  );

  TTabOrientation = (
    toTop,
    toBottom
  );

  TTextTrimType = (
    tttNone,
    tttCharacter,
    tttWord,
    tttEllipsisCharacter,
    tttEllipsisWord,
    tttEllipsisPath,
    tttFade
  );

  THitTestArea = (
    htNowhere,
    htBackground,
    htTab,
    htAddButton,
    htCloseButton,
    htScrollButtonLeft,
    htScrollButtonRight
  );

  TDrawState = (
    dsUnknown,
    dsActive,
    dsNotActive,
    dsDown,
    dsHot,
    dsDisabled
  );

  TCloseButtonVisiblity = (
    bvNever,
    bvAll,
    bvActive
  );

  TChromeTabItemType = (
    itTabContainer,
    itBackground,
    itTab,
    itTabOutline,
    itTabText,
    itTabCloseButton,
    itTabImage,
    itTabImageOverlay,
    itTabImageSpinner,
    itTabMouseGlow,
    itTabModifiedGlow,
    itAddButton,
    itAddButtonPlus,
    itScrollLeftButton,
    itScrollRightButton
  );

  TTabDropOption = (
    tdDeleteDraggedTab,
    tdCreateDroppedTab,
    tdMoveTab
  );
  TTabDropOptions = set of TTabDropOption;

  TChromeTabState = (
    stsAnimatingMovement,
    stsAnimatingStyle,
    stsDragging,
    stsDragStarted,
    stsDragFinished,
    stsCancellingDrag,
    stsCompletingDrag,
    stsDeletingUnPinnedTabs,
    stsTabDeleted,
    stsEndTabDeleted,
    stsResizing,
    stsMouseDown,
    stsPendingUpdates,
    stsAddingDroppedTab,
    stsAnimatingNewTab,
    stsFirstPaint,
    stsControlPositionsInvalidated,
    stsDebug,
    stsAnimatingCloseTab
  );
  TChromeTabStates = set of TChromeTabState;

  TChromeTabsEaseType = (
    ttNone,
    ttLinearTween,
    ttEaseInQuad,
    ttEaseOutQuad,
    ttEaseInOutQuad,
    ttEaseInCubic,
    ttEaseOutCubic,
    ttEaseInOutCubic,
    ttEaseInQuart,
    ttEaseOutQuart,
    ttEaseInOutQuart,
    ttEaseInQuint,
    ttEaseOutQuint,
    ttEaseInOutQuint,
    ttEaseInSine,
    ttEaseOutSine,
    ttEaseInOutSine,
    ttEaseInExpo,
    ttEaseOutExpo,
    ttEaseInOutExpo,
    ttEaseInCirc,
    ttEaseOutCirc,
    ttEaseInOutCirc
  );

  TChromeTabScrollButtons = (
    csbNone,
    csbLeft,
    csbRight,
    csbLeftAndRight
  );

  TTabDisplayState = (
    tdNormal,
    tdCompressed,
    tdScrolling
  );

  TScrollDirection = (
    mdsNone,
    mdsLeft,
    mdsRight
  );

  TAddButtonVisibility = (
    avNone,
    avLeft,
    avRightFloating,
    avRightFixed
  );

  TDragOverType = (
    dotNone,
    dotHomeContainer,
    dotRemoteContainer
  );

  TBiDiModes = set of TBiDiMode;

  THitTestResult = record
    TabIndex: Integer;
    HitTestArea: THitTestArea;
  end;

  TPolygon = packed Array of TPoint;

const
  BidiLeftToRightTabModes: TBiDiModes = [bdLeftToRight, bdRightToLeftReadingOnly];
  BidiRightToLeftTabModes: TBiDiModes = [bdRightToLeft, bdRightToLeftNoAlign];
  BidiLeftToRightTextModes: TBiDiModes = [bdLeftToRight];
  BidiRightToLeftTextModes: TBiDiModes = [bdRightToLeft, bdRightToLeftNoAlign, bdRightToLeftReadingOnly];
  BidiLeftTextAlignmentModes: TBiDiModes = [bdLeftToRight, bdRightToLeftNoAlign, bdRightToLeftReadingOnly];
  BidiRightTextAlignmentModes: TBiDiModes = [bdRightToLeft];


  HitTestDescriptions: Array[THitTestArea] of String = (
    'Nowhere',
    'Background',
    'Tab',
    'New Button',
    'Close Button',
    'Scroll Left',
    'Scroll Right'
  );

  TabChangeTypeDescriptions: Array[TTabChangeType] of String = (
    'Added',
    'Moved',
    'Deleting',
    'Deleted',
    'PropertyUpdated',
    'Activated',
    'Deactivated',
    'Pinned',
    'Control State',
    'Visibility'
  );

  TabDrawStateDescriptions: Array[TDrawState] of String = (
    'Unknown',
    'Active',
    'Not Active',
    'Down',
    'Hot',
    'Disabled'
  );

  ChromeTabStateDescriptions: Array[TChromeTabState] of String = (
    'Animating Movement',
    'Animating Style',
    'Dragging',
    'Drag Started',
    'Drag Finished',
    'Cancelling Drag',
    'Completing Drag',
    'Tabs Deleted By Close Button',
    'Tab Deleted',
    'End Tab Deleted',
    'Resizing',
    'Mouse Down',
    'Pending Updates',
    'Adding Dropped Tab',
    'Animating New Tab',
    'First Paint',
    'Controls Invalidated',
    'Debug',
    'Animating Close Tab'
  );

  ChromeTabsControlTypeDescriptions: Array[TChromeTabItemType] of String = (
    'Tab Container',
    'Background',
    'Tab',
    'Tab Outline',
    'Tab Text',
    'Tab Close Button',
    'Tab Image',
    'Tab Image Overlay',
    'Tab Image Spinner',
    'Tab Mouse Glow',
    'Tab Modified Glow',
    'Add Button',
    'Add Button Plus',
    'Scroll Left Button',
    'Scroll Right Button'
  );

  ChromeTabsEaseTypeDestriptions: Array[TChromeTabsEaseType] of String = (
    'None',
    'LinearTween',
    'In Quad',
    'Out Quad',
    'In Out Quad',
    'In Cubic',
    'Out Cubic',
    'In Out Cubic',
    'In Quart',
    'Out Quart',
    'In Out Quart',
    'In Quint',
    'Out Quint',
    'In Out Quint',
    'In Sine',
    'Out Sine',
    'In Out Sine',
    'In Expo',
    'Out Expo',
    'In Out Expo',
    'In Circ',
    'Out Circ',
    'In Out Circ'
  );

implementation

end.

