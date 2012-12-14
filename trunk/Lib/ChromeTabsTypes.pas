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

{$include versions.inc}

uses
  Windows, GDIPAPI;

type
 {$IFNDEF DELPHI2006_UP}
  TVerticalAlignment = (
    taAlignTop,
    taAlignBottom,
    taVerticalCenter
  );
  {$ENDIF}

  TChromeTabsBidiMode = (
    bdmLeftToRight,
    bdmRightToLeftText,
    bdmRightToLeftTextAndTabs
  );

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

  TTabChangeType = (
    tcAdded,
    tcMoved,
    tcDeleting,
    tcDeleted,
    tcPropertyUpdated,
    tcActivated,
    tcDeactivated,
    tcPinned,
    tcControlState
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

  TTabSkin = (
    isCustom,
    isDefault,
    isChrome
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
    itTabText,
    itTabCloseButton,
    itTabImage,
    itTabImageOverlay,
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

  TChromeTabsAnimationMovementType = (
    aeTabAdd,
    aeTabMove,
    aeTabDragCancelled,
    aeAddButtonMove
  );
  TChromeTabsAnimationMovementTypes = set of TChromeTabsAnimationMovementType;

  TChromeTabState = (
    stsAnimating,
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
    stsLoading,
    stsAnimatingNewTab,
    stsFirstPaint,
    stsControlsPositionsInvalidated,
    stsDebug,
    stsInitialAddButtonPosition
  );
  TChromeTabStates = set of TChromeTabState;

  TChromeTabScrollButtons = (
    csbNone,
    csbLeft,
    csbRight,
    csbLeftAndRight
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

  THitTestResult = record
    TabIndex: Integer;
    HitTestArea: THitTestArea;
  end;

  TPolygon = packed Array of TPoint;

const
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
    'Control State'
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
    'Animating',
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
    'Loading',
    'Animating New Tab',
    'First Paint',
    'Controls Invalidated',
    'Debug',
    'Initial Add Button Position'
  );

  ChromeTabsControlTypeDescriptions: Array[TChromeTabItemType] of String = (
    'Tab Container',
    'Background',
    'Tab',
    'Tab Text',
    'Tab Close Button',
    'Tab Image',
    'Tab Image Overlay',
    'Add Button',
    'Add Button Plus',
    'Scroll Left Button',
    'Scroll Right Button'
  );

implementation

end.
