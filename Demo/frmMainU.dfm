object frmMain: TfrmMain
  Left = 436
  Top = 187
  Caption = 'Chrome Tabs Demo'
  ClientHeight = 596
  ClientWidth = 1021
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object ChromeTabs1: TChromeTabs
    Left = 0
    Top = 0
    Width = 1021
    Height = 29
    OnChange = ChromeTabs1Change
    OnActiveTabChanged = ChromeTabs1ActiveTabChanged
    OnDebugLog = ChromeTabs1DebugLog
    OnButtonAddClick = ChromeTabs1ButtonAddClick
    OnNeedDragImageControl = ChromeTabs1NeedDragImageControl
    OnCreateDragForm = ChromeTabs1CreateDragForm
    OnGetControlPolygons = ChromeTabs1GetControlPolygons
    OnScroll = ChromeTabs1Scroll
    OnScrollWidthChanged = ChromeTabs1ScrollWidthChanged
    OnAnimateStyleTransisiton = ChromeTabs1AnimateStyleTransisiton
    ActiveTabIndex = 0
    Images = ImageList1
    ImagesOverlay = ImageList2
    Options.Display.CloseButton.Offsets.Vertical = 6
    Options.Display.CloseButton.Offsets.Horizontal = 2
    Options.Display.CloseButton.Offsets.HorizontalFloating = -3
    Options.Display.CloseButton.Height = 14
    Options.Display.CloseButton.Width = 14
    Options.Display.CloseButton.AutoHide = True
    Options.Display.CloseButton.Visibility = bvAll
    Options.Display.CloseButton.AutoHideWidth = 20
    Options.Display.CloseButton.CrossRadialOffset = 4
    Options.Display.AddButton.Offsets.Vertical = 10
    Options.Display.AddButton.Offsets.Horizontal = 2
    Options.Display.AddButton.Offsets.HorizontalFloating = -3
    Options.Display.AddButton.Height = 14
    Options.Display.AddButton.Width = 31
    Options.Display.AddButton.ShowPlusSign = False
    Options.Display.AddButton.Visibility = avRightFloating
    Options.Display.ScrollButtonLeft.Offsets.Vertical = 10
    Options.Display.ScrollButtonLeft.Offsets.Horizontal = 1
    Options.Display.ScrollButtonLeft.Offsets.HorizontalFloating = -3
    Options.Display.ScrollButtonLeft.Height = 15
    Options.Display.ScrollButtonLeft.Width = 15
    Options.Display.ScrollButtonRight.Offsets.Vertical = 10
    Options.Display.ScrollButtonRight.Offsets.Horizontal = 1
    Options.Display.ScrollButtonRight.Offsets.HorizontalFloating = -3
    Options.Display.ScrollButtonRight.Height = 15
    Options.Display.ScrollButtonRight.Width = 15
    Options.Display.TabModifiedGlow.Style = msRightToLeft
    Options.Display.TabModifiedGlow.VerticalOffset = -2
    Options.Display.TabModifiedGlow.Height = 20
    Options.Display.TabModifiedGlow.Width = 50
    Options.Display.TabModifiedGlow.AnimationSteps = 150
    Options.Display.Tabs.SeeThroughTabs = False
    Options.Display.Tabs.TabOverlap = 15
    Options.Display.Tabs.ContentOffsetLeft = 18
    Options.Display.Tabs.ContentOffsetRight = 16
    Options.Display.Tabs.OffsetLeft = 0
    Options.Display.Tabs.OffsetTop = 4
    Options.Display.Tabs.OffsetRight = 0
    Options.Display.Tabs.OffsetBottom = 0
    Options.Display.Tabs.MinWidth = 25
    Options.Display.Tabs.MaxWidth = 200
    Options.Display.Tabs.PinnedWidth = 39
    Options.Display.Tabs.ImageOffsetLeft = 13
    Options.Display.Tabs.TextTrimType = tttFade
    Options.Display.Tabs.Orientation = toTop
    Options.Display.Tabs.BaseLineTabRegionOnly = False
    Options.Display.Tabs.WordWrap = False
    Options.Display.Tabs.TextAlignmentHorizontal = taLeftJustify
    Options.Display.Tabs.TextAlignmentVertical = taVerticalCenter
    Options.Display.Tabs.ShowImages = True
    Options.Display.TabContainer.TransparentBackground = True
    Options.Display.TabContainer.OverlayButtons = True
    Options.Display.TabContainer.PaddingLeft = 0
    Options.Display.TabContainer.PaddingRight = 0
    Options.Display.TabMouseGlow.Offsets.Vertical = 0
    Options.Display.TabMouseGlow.Offsets.Horizontal = 0
    Options.Display.TabMouseGlow.Offsets.HorizontalFloating = -3
    Options.Display.TabMouseGlow.Height = 200
    Options.Display.TabMouseGlow.Width = 200
    Options.Display.TabMouseGlow.Visible = True
    Options.DragDrop.DragType = dtBetweenContainers
    Options.DragDrop.DragOutsideImageAlpha = 220
    Options.DragDrop.DragOutsideDistancePixels = 30
    Options.DragDrop.DragStartPixels = 2
    Options.DragDrop.DragControlImageResizeFactor = 0.500000000000000000
    Options.DragDrop.DragCursor = crDefault
    Options.DragDrop.DragDisplay = ddTabAndControl
    Options.DragDrop.DragFormBorderWidth = 2
    Options.DragDrop.DragFormBorderColor = 8421504
    Options.Animation.DefaultMovementAnimationTimeMS = 300
    Options.Animation.DefaultStyleAnimationTimeMS = 300
    Options.Animation.AnimationTimerInterval = 15
    Options.Animation.MinimumTabAnimationWidth = 40
    Options.Animation.DefaultMovementEaseType = ttLinearTween
    Options.Animation.DefaultStyleEaseType = ttLinearTween
    Options.Animation.MovementAnimations.TabAdd.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.TabAdd.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.TabAdd.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabAdd.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.TabDelete.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.TabDelete.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.TabDelete.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabDelete.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.TabMove.UseDefaultEaseType = False
    Options.Animation.MovementAnimations.TabMove.UseDefaultAnimationTime = False
    Options.Animation.MovementAnimations.TabMove.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabMove.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.TabDragCancelled.UseDefaultEaseType = False
    Options.Animation.MovementAnimations.TabDragCancelled.UseDefaultAnimationTime = False
    Options.Animation.MovementAnimations.TabDragCancelled.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabDragCancelled.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.AddButtonMove.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.AddButtonMove.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.AddButtonMove.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.AddButtonMove.AnimationTimeMS = 800
    Options.Behaviour.BackgroundDblClickMaximiseRestoreForm = True
    Options.Behaviour.BackgroundDragMovesForm = True
    Options.Behaviour.TabSmartDeleteResizing = True
    Options.Behaviour.TabSmartDeleteResizeCancelDelay = 700
    Options.Behaviour.UseBuiltInPopupMenu = True
    Options.Behaviour.TabRightClickSelect = True
    Options.Behaviour.ActivateNewTab = True
    Options.Behaviour.DebugMode = False
    Options.Behaviour.IgnoreDoubleClicksWhileAnimatingMovement = True
    Options.Scrolling.Enabled = True
    Options.Scrolling.ScrollButtons = csbRight
    Options.Scrolling.ScrollStep = 20
    Options.Scrolling.ScrollRepeatDelay = 20
    Options.Scrolling.AutoHideButtons = False
    Options.Scrolling.DragScroll = True
    Options.Scrolling.DragScrollOffset = 50
    Options.Scrolling.MouseWheelScroll = True
    Tabs = <
      item
        Caption = 'Tab 1'
        Active = True
        Tag = 0
        ImageIndex = 4
        ImageIndexOverlay = 0
        Pinned = False
        Visible = True
        Modified = False
      end
      item
        Caption = 'Tab 2'
        Active = False
        Tag = 0
        ImageIndex = -1
        ImageIndexOverlay = -1
        Pinned = False
        Visible = True
        Modified = False
      end>
    LookAndFeel.TabsContainer.StartColor = 14586466
    LookAndFeel.TabsContainer.StopColor = 13201730
    LookAndFeel.TabsContainer.StartAlpha = 255
    LookAndFeel.TabsContainer.StopAlpha = 255
    LookAndFeel.TabsContainer.OutlineColor = 14520930
    LookAndFeel.TabsContainer.OutlineAlpha = 0
    LookAndFeel.Tabs.BaseLine.Color = 11110509
    LookAndFeel.Tabs.BaseLine.Thickness = 1.000000000000000000
    LookAndFeel.Tabs.BaseLine.Alpha = 255
    LookAndFeel.Tabs.Modified.CentreColor = clWhite
    LookAndFeel.Tabs.Modified.OutsideColor = clWhite
    LookAndFeel.Tabs.Modified.CentreAlpha = 130
    LookAndFeel.Tabs.Modified.OutsideAlpha = 0
    LookAndFeel.Tabs.DefaultFont.Name = 'Segoe UI'
    LookAndFeel.Tabs.DefaultFont.Color = clBlack
    LookAndFeel.Tabs.DefaultFont.Size = 9
    LookAndFeel.Tabs.DefaultFont.Alpha = 255
    LookAndFeel.Tabs.DefaultFont.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.MouseGlow.CentreColor = clWhite
    LookAndFeel.Tabs.MouseGlow.OutsideColor = clWhite
    LookAndFeel.Tabs.MouseGlow.CentreAlpha = 120
    LookAndFeel.Tabs.MouseGlow.OutsideAlpha = 0
    LookAndFeel.Tabs.Active.Font.Name = 'Segoe UI'
    LookAndFeel.Tabs.Active.Font.Color = clOlive
    LookAndFeel.Tabs.Active.Font.Size = 9
    LookAndFeel.Tabs.Active.Font.Alpha = 100
    LookAndFeel.Tabs.Active.Font.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.Active.Font.UseDefaultFont = True
    LookAndFeel.Tabs.Active.Style.StartColor = clWhite
    LookAndFeel.Tabs.Active.Style.StopColor = 16316920
    LookAndFeel.Tabs.Active.Style.StartAlpha = 255
    LookAndFeel.Tabs.Active.Style.StopAlpha = 255
    LookAndFeel.Tabs.Active.Style.OutlineColor = 10189918
    LookAndFeel.Tabs.Active.Style.OutlineSize = 1.000000000000000000
    LookAndFeel.Tabs.Active.Style.OutlineAlpha = 255
    LookAndFeel.Tabs.NotActive.Font.Name = 'Segoe UI'
    LookAndFeel.Tabs.NotActive.Font.Color = 4603477
    LookAndFeel.Tabs.NotActive.Font.Size = 9
    LookAndFeel.Tabs.NotActive.Font.Alpha = 215
    LookAndFeel.Tabs.NotActive.Font.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.NotActive.Font.UseDefaultFont = False
    LookAndFeel.Tabs.NotActive.Style.StartColor = 15194573
    LookAndFeel.Tabs.NotActive.Style.StopColor = 15194573
    LookAndFeel.Tabs.NotActive.Style.StartAlpha = 210
    LookAndFeel.Tabs.NotActive.Style.StopAlpha = 230
    LookAndFeel.Tabs.NotActive.Style.OutlineColor = 13546390
    LookAndFeel.Tabs.NotActive.Style.OutlineSize = 1.000000000000000000
    LookAndFeel.Tabs.NotActive.Style.OutlineAlpha = 215
    LookAndFeel.Tabs.Hot.Font.Name = 'Segoe UI'
    LookAndFeel.Tabs.Hot.Font.Color = 4210752
    LookAndFeel.Tabs.Hot.Font.Size = 9
    LookAndFeel.Tabs.Hot.Font.Alpha = 215
    LookAndFeel.Tabs.Hot.Font.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.Hot.Font.UseDefaultFont = False
    LookAndFeel.Tabs.Hot.Style.StartColor = 15721176
    LookAndFeel.Tabs.Hot.Style.StopColor = 15589847
    LookAndFeel.Tabs.Hot.Style.StartAlpha = 255
    LookAndFeel.Tabs.Hot.Style.StopAlpha = 255
    LookAndFeel.Tabs.Hot.Style.OutlineColor = 12423799
    LookAndFeel.Tabs.Hot.Style.OutlineSize = 1.000000000000000000
    LookAndFeel.Tabs.Hot.Style.OutlineAlpha = 235
    LookAndFeel.CloseButton.Cross.Normal.Color = 6643031
    LookAndFeel.CloseButton.Cross.Normal.Thickness = 1.500000000000000000
    LookAndFeel.CloseButton.Cross.Normal.Alpha = 255
    LookAndFeel.CloseButton.Cross.Down.Color = 15461369
    LookAndFeel.CloseButton.Cross.Down.Thickness = 2.000000000000000000
    LookAndFeel.CloseButton.Cross.Down.Alpha = 220
    LookAndFeel.CloseButton.Cross.Hot.Color = clWhite
    LookAndFeel.CloseButton.Cross.Hot.Thickness = 2.000000000000000000
    LookAndFeel.CloseButton.Cross.Hot.Alpha = 220
    LookAndFeel.CloseButton.Circle.Normal.StartColor = clGradientActiveCaption
    LookAndFeel.CloseButton.Circle.Normal.StopColor = clNone
    LookAndFeel.CloseButton.Circle.Normal.StartAlpha = 0
    LookAndFeel.CloseButton.Circle.Normal.StopAlpha = 0
    LookAndFeel.CloseButton.Circle.Normal.OutlineColor = clGray
    LookAndFeel.CloseButton.Circle.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.CloseButton.Circle.Normal.OutlineAlpha = 0
    LookAndFeel.CloseButton.Circle.Down.StartColor = 3487169
    LookAndFeel.CloseButton.Circle.Down.StopColor = 3487169
    LookAndFeel.CloseButton.Circle.Down.StartAlpha = 255
    LookAndFeel.CloseButton.Circle.Down.StopAlpha = 255
    LookAndFeel.CloseButton.Circle.Down.OutlineColor = clGray
    LookAndFeel.CloseButton.Circle.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.CloseButton.Circle.Down.OutlineAlpha = 255
    LookAndFeel.CloseButton.Circle.Hot.StartColor = 9408475
    LookAndFeel.CloseButton.Circle.Hot.StopColor = 9803748
    LookAndFeel.CloseButton.Circle.Hot.StartAlpha = 255
    LookAndFeel.CloseButton.Circle.Hot.StopAlpha = 255
    LookAndFeel.CloseButton.Circle.Hot.OutlineColor = 6054595
    LookAndFeel.CloseButton.Circle.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.CloseButton.Circle.Hot.OutlineAlpha = 255
    LookAndFeel.AddButton.Button.Normal.StartColor = 14340292
    LookAndFeel.AddButton.Button.Normal.StopColor = 14340035
    LookAndFeel.AddButton.Button.Normal.StartAlpha = 255
    LookAndFeel.AddButton.Button.Normal.StopAlpha = 255
    LookAndFeel.AddButton.Button.Normal.OutlineColor = 13088421
    LookAndFeel.AddButton.Button.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.Button.Normal.OutlineAlpha = 255
    LookAndFeel.AddButton.Button.Down.StartColor = 13417645
    LookAndFeel.AddButton.Button.Down.StopColor = 13417644
    LookAndFeel.AddButton.Button.Down.StartAlpha = 255
    LookAndFeel.AddButton.Button.Down.StopAlpha = 255
    LookAndFeel.AddButton.Button.Down.OutlineColor = 10852748
    LookAndFeel.AddButton.Button.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.Button.Down.OutlineAlpha = 255
    LookAndFeel.AddButton.Button.Hot.StartColor = 15524314
    LookAndFeel.AddButton.Button.Hot.StopColor = 15524314
    LookAndFeel.AddButton.Button.Hot.StartAlpha = 255
    LookAndFeel.AddButton.Button.Hot.StopAlpha = 255
    LookAndFeel.AddButton.Button.Hot.OutlineColor = 14927787
    LookAndFeel.AddButton.Button.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.Button.Hot.OutlineAlpha = 255
    LookAndFeel.AddButton.PlusSign.Normal.StartColor = clWhite
    LookAndFeel.AddButton.PlusSign.Normal.StopColor = clWhite
    LookAndFeel.AddButton.PlusSign.Normal.StartAlpha = 255
    LookAndFeel.AddButton.PlusSign.Normal.StopAlpha = 255
    LookAndFeel.AddButton.PlusSign.Normal.OutlineColor = clGray
    LookAndFeel.AddButton.PlusSign.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.PlusSign.Normal.OutlineAlpha = 255
    LookAndFeel.AddButton.PlusSign.Down.StartColor = clWhite
    LookAndFeel.AddButton.PlusSign.Down.StopColor = clWhite
    LookAndFeel.AddButton.PlusSign.Down.StartAlpha = 255
    LookAndFeel.AddButton.PlusSign.Down.StopAlpha = 255
    LookAndFeel.AddButton.PlusSign.Down.OutlineColor = clGray
    LookAndFeel.AddButton.PlusSign.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.PlusSign.Down.OutlineAlpha = 255
    LookAndFeel.AddButton.PlusSign.Hot.StartColor = clWhite
    LookAndFeel.AddButton.PlusSign.Hot.StopColor = clWhite
    LookAndFeel.AddButton.PlusSign.Hot.StartAlpha = 255
    LookAndFeel.AddButton.PlusSign.Hot.StopAlpha = 255
    LookAndFeel.AddButton.PlusSign.Hot.OutlineColor = clGray
    LookAndFeel.AddButton.PlusSign.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.PlusSign.Hot.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Normal.StartColor = 14735310
    LookAndFeel.ScrollButtons.Button.Normal.StopColor = 14274499
    LookAndFeel.ScrollButtons.Button.Normal.StartAlpha = 255
    LookAndFeel.ScrollButtons.Button.Normal.StopAlpha = 255
    LookAndFeel.ScrollButtons.Button.Normal.OutlineColor = 11507842
    LookAndFeel.ScrollButtons.Button.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Normal.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Down.StartColor = 13417645
    LookAndFeel.ScrollButtons.Button.Down.StopColor = 13417644
    LookAndFeel.ScrollButtons.Button.Down.StartAlpha = 255
    LookAndFeel.ScrollButtons.Button.Down.StopAlpha = 255
    LookAndFeel.ScrollButtons.Button.Down.OutlineColor = 10852748
    LookAndFeel.ScrollButtons.Button.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Down.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Hot.StartColor = 15524314
    LookAndFeel.ScrollButtons.Button.Hot.StopColor = 15524313
    LookAndFeel.ScrollButtons.Button.Hot.StartAlpha = 255
    LookAndFeel.ScrollButtons.Button.Hot.StopAlpha = 255
    LookAndFeel.ScrollButtons.Button.Hot.OutlineColor = 14927788
    LookAndFeel.ScrollButtons.Button.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Hot.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Disabled.StartColor = 14340036
    LookAndFeel.ScrollButtons.Button.Disabled.StopColor = 14274499
    LookAndFeel.ScrollButtons.Button.Disabled.StartAlpha = 150
    LookAndFeel.ScrollButtons.Button.Disabled.StopAlpha = 150
    LookAndFeel.ScrollButtons.Button.Disabled.OutlineColor = 11113341
    LookAndFeel.ScrollButtons.Button.Disabled.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Disabled.OutlineAlpha = 100
    LookAndFeel.ScrollButtons.Arrow.Normal.StartColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Normal.StopColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Normal.StartAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Normal.StopAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Normal.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Normal.OutlineAlpha = 200
    LookAndFeel.ScrollButtons.Arrow.Down.StartColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Down.StopColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Down.StartAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Down.StopAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Down.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Down.OutlineAlpha = 200
    LookAndFeel.ScrollButtons.Arrow.Hot.StartColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Hot.StopColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Hot.StartAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Hot.StopAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Hot.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Hot.OutlineAlpha = 200
    LookAndFeel.ScrollButtons.Arrow.Disabled.StartColor = clSilver
    LookAndFeel.ScrollButtons.Arrow.Disabled.StopColor = clSilver
    LookAndFeel.ScrollButtons.Arrow.Disabled.StartAlpha = 150
    LookAndFeel.ScrollButtons.Arrow.Disabled.StopAlpha = 150
    LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineAlpha = 200
    Align = alTop
    OnResize = ChromeTabs1Resize
    TabOrder = 1
  end
  object ChromeTabs2: TChromeTabs
    Left = 0
    Top = 565
    Width = 1021
    Height = 31
    OnDebugLog = ChromeTabs1DebugLog
    OnButtonAddClick = ChromeTabs1ButtonAddClick
    OnButtonCloseTabClick = ChromeTabs1ButtonCloseTabClick
    OnNeedDragImageControl = ChromeTabs1NeedDragImageControl
    OnAfterDrawItem = ChromeTabs2AfterDrawItem
    OnShowHint = ChromeTabs1ShowHint
    ActiveTabIndex = -1
    Options.Display.CloseButton.Offsets.Vertical = 6
    Options.Display.CloseButton.Offsets.Horizontal = 2
    Options.Display.CloseButton.Offsets.HorizontalFloating = -3
    Options.Display.CloseButton.Height = 14
    Options.Display.CloseButton.Width = 14
    Options.Display.CloseButton.AutoHide = True
    Options.Display.CloseButton.Visibility = bvAll
    Options.Display.CloseButton.AutoHideWidth = 20
    Options.Display.CloseButton.CrossRadialOffset = 4
    Options.Display.AddButton.Offsets.Vertical = 7
    Options.Display.AddButton.Offsets.Horizontal = 2
    Options.Display.AddButton.Offsets.HorizontalFloating = -3
    Options.Display.AddButton.Height = 15
    Options.Display.AddButton.Width = 32
    Options.Display.AddButton.ShowPlusSign = False
    Options.Display.AddButton.Visibility = avRightFloating
    Options.Display.ScrollButtonLeft.Offsets.Vertical = 7
    Options.Display.ScrollButtonLeft.Offsets.Horizontal = 1
    Options.Display.ScrollButtonLeft.Offsets.HorizontalFloating = -3
    Options.Display.ScrollButtonLeft.Height = 15
    Options.Display.ScrollButtonLeft.Width = 15
    Options.Display.ScrollButtonRight.Offsets.Vertical = 7
    Options.Display.ScrollButtonRight.Offsets.Horizontal = 1
    Options.Display.ScrollButtonRight.Offsets.HorizontalFloating = -3
    Options.Display.ScrollButtonRight.Height = 15
    Options.Display.ScrollButtonRight.Width = 15
    Options.Display.TabModifiedGlow.Style = msRightToLeft
    Options.Display.TabModifiedGlow.VerticalOffset = -2
    Options.Display.TabModifiedGlow.Height = 20
    Options.Display.TabModifiedGlow.Width = 50
    Options.Display.TabModifiedGlow.AnimationSteps = 150
    Options.Display.Tabs.SeeThroughTabs = False
    Options.Display.Tabs.TabOverlap = 15
    Options.Display.Tabs.ContentOffsetLeft = 18
    Options.Display.Tabs.ContentOffsetRight = 16
    Options.Display.Tabs.OffsetLeft = 0
    Options.Display.Tabs.OffsetTop = 0
    Options.Display.Tabs.OffsetRight = 0
    Options.Display.Tabs.OffsetBottom = 4
    Options.Display.Tabs.MinWidth = 25
    Options.Display.Tabs.MaxWidth = 200
    Options.Display.Tabs.PinnedWidth = 39
    Options.Display.Tabs.ImageOffsetLeft = 13
    Options.Display.Tabs.TextTrimType = tttFade
    Options.Display.Tabs.Orientation = toBottom
    Options.Display.Tabs.BaseLineTabRegionOnly = False
    Options.Display.Tabs.WordWrap = False
    Options.Display.Tabs.TextAlignmentHorizontal = taLeftJustify
    Options.Display.Tabs.TextAlignmentVertical = taVerticalCenter
    Options.Display.Tabs.ShowImages = True
    Options.Display.TabContainer.TransparentBackground = False
    Options.Display.TabContainer.OverlayButtons = True
    Options.Display.TabContainer.PaddingLeft = 0
    Options.Display.TabContainer.PaddingRight = 0
    Options.Display.TabMouseGlow.Offsets.Vertical = 0
    Options.Display.TabMouseGlow.Offsets.Horizontal = 0
    Options.Display.TabMouseGlow.Offsets.HorizontalFloating = -3
    Options.Display.TabMouseGlow.Height = 200
    Options.Display.TabMouseGlow.Width = 200
    Options.Display.TabMouseGlow.Visible = True
    Options.DragDrop.DragType = dtBetweenContainers
    Options.DragDrop.DragOutsideImageAlpha = 220
    Options.DragDrop.DragOutsideDistancePixels = 30
    Options.DragDrop.DragStartPixels = 2
    Options.DragDrop.DragControlImageResizeFactor = 0.500000000000000000
    Options.DragDrop.DragCursor = crDefault
    Options.DragDrop.DragDisplay = ddTabAndControl
    Options.DragDrop.DragFormBorderWidth = 2
    Options.DragDrop.DragFormBorderColor = 8421504
    Options.Animation.DefaultMovementAnimationTimeMS = 500
    Options.Animation.DefaultStyleAnimationTimeMS = 300
    Options.Animation.AnimationTimerInterval = 15
    Options.Animation.MinimumTabAnimationWidth = 40
    Options.Animation.DefaultMovementEaseType = ttEaseOutExpo
    Options.Animation.DefaultStyleEaseType = ttLinearTween
    Options.Animation.MovementAnimations.TabAdd.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.TabAdd.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.TabAdd.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabAdd.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.TabDelete.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.TabDelete.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.TabDelete.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabDelete.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.TabMove.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.TabMove.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.TabMove.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabMove.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.TabDragCancelled.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.TabDragCancelled.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.TabDragCancelled.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.TabDragCancelled.AnimationTimeMS = 800
    Options.Animation.MovementAnimations.AddButtonMove.UseDefaultEaseType = True
    Options.Animation.MovementAnimations.AddButtonMove.UseDefaultAnimationTime = True
    Options.Animation.MovementAnimations.AddButtonMove.EaseType = ttEaseOutExpo
    Options.Animation.MovementAnimations.AddButtonMove.AnimationTimeMS = 800
    Options.Behaviour.BackgroundDblClickMaximiseRestoreForm = True
    Options.Behaviour.BackgroundDragMovesForm = True
    Options.Behaviour.TabSmartDeleteResizing = True
    Options.Behaviour.TabSmartDeleteResizeCancelDelay = 700
    Options.Behaviour.UseBuiltInPopupMenu = True
    Options.Behaviour.TabRightClickSelect = True
    Options.Behaviour.ActivateNewTab = True
    Options.Behaviour.DebugMode = False
    Options.Behaviour.IgnoreDoubleClicksWhileAnimatingMovement = True
    Options.Scrolling.Enabled = True
    Options.Scrolling.ScrollButtons = csbRight
    Options.Scrolling.ScrollStep = 20
    Options.Scrolling.ScrollRepeatDelay = 20
    Options.Scrolling.AutoHideButtons = False
    Options.Scrolling.DragScroll = True
    Options.Scrolling.DragScrollOffset = 50
    Options.Scrolling.MouseWheelScroll = True
    Tabs = <>
    LookAndFeel.TabsContainer.StartColor = 14586466
    LookAndFeel.TabsContainer.StopColor = 13201730
    LookAndFeel.TabsContainer.StartAlpha = 255
    LookAndFeel.TabsContainer.StopAlpha = 255
    LookAndFeel.TabsContainer.OutlineColor = 14520930
    LookAndFeel.TabsContainer.OutlineAlpha = 0
    LookAndFeel.Tabs.BaseLine.Color = 11110509
    LookAndFeel.Tabs.BaseLine.Thickness = 1.000000000000000000
    LookAndFeel.Tabs.BaseLine.Alpha = 255
    LookAndFeel.Tabs.Modified.CentreColor = clWhite
    LookAndFeel.Tabs.Modified.OutsideColor = clWhite
    LookAndFeel.Tabs.Modified.CentreAlpha = 130
    LookAndFeel.Tabs.Modified.OutsideAlpha = 0
    LookAndFeel.Tabs.DefaultFont.Name = 'Segoe UI'
    LookAndFeel.Tabs.DefaultFont.Color = clBlack
    LookAndFeel.Tabs.DefaultFont.Size = 9
    LookAndFeel.Tabs.DefaultFont.Alpha = 255
    LookAndFeel.Tabs.DefaultFont.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.MouseGlow.CentreColor = clWhite
    LookAndFeel.Tabs.MouseGlow.OutsideColor = clWhite
    LookAndFeel.Tabs.MouseGlow.CentreAlpha = 120
    LookAndFeel.Tabs.MouseGlow.OutsideAlpha = 0
    LookAndFeel.Tabs.Active.Font.Name = 'Segoe UI'
    LookAndFeel.Tabs.Active.Font.Color = clOlive
    LookAndFeel.Tabs.Active.Font.Size = 9
    LookAndFeel.Tabs.Active.Font.Alpha = 100
    LookAndFeel.Tabs.Active.Font.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.Active.Font.UseDefaultFont = True
    LookAndFeel.Tabs.Active.Style.StartColor = clWhite
    LookAndFeel.Tabs.Active.Style.StopColor = 16316664
    LookAndFeel.Tabs.Active.Style.StartAlpha = 255
    LookAndFeel.Tabs.Active.Style.StopAlpha = 255
    LookAndFeel.Tabs.Active.Style.OutlineColor = 9985595
    LookAndFeel.Tabs.Active.Style.OutlineSize = 1.000000000000000000
    LookAndFeel.Tabs.Active.Style.OutlineAlpha = 255
    LookAndFeel.Tabs.NotActive.Font.Name = 'Segoe UI'
    LookAndFeel.Tabs.NotActive.Font.Color = clBlack
    LookAndFeel.Tabs.NotActive.Font.Size = 9
    LookAndFeel.Tabs.NotActive.Font.Alpha = 255
    LookAndFeel.Tabs.NotActive.Font.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.NotActive.Font.UseDefaultFont = True
    LookAndFeel.Tabs.NotActive.Style.StartColor = 16107683
    LookAndFeel.Tabs.NotActive.Style.StopColor = 15778203
    LookAndFeel.Tabs.NotActive.Style.StartAlpha = 210
    LookAndFeel.Tabs.NotActive.Style.StopAlpha = 210
    LookAndFeel.Tabs.NotActive.Style.OutlineColor = 10576703
    LookAndFeel.Tabs.NotActive.Style.OutlineSize = 1.000000000000000000
    LookAndFeel.Tabs.NotActive.Style.OutlineAlpha = 215
    LookAndFeel.Tabs.Hot.Font.Name = 'Segoe UI'
    LookAndFeel.Tabs.Hot.Font.Color = 4210752
    LookAndFeel.Tabs.Hot.Font.Size = 9
    LookAndFeel.Tabs.Hot.Font.Alpha = 255
    LookAndFeel.Tabs.Hot.Font.TextRendoringMode = TextRenderingHintClearTypeGridFit
    LookAndFeel.Tabs.Hot.Font.UseDefaultFont = True
    LookAndFeel.Tabs.Hot.Style.StartColor = 16308929
    LookAndFeel.Tabs.Hot.Style.StopColor = 15979450
    LookAndFeel.Tabs.Hot.Style.StartAlpha = 255
    LookAndFeel.Tabs.Hot.Style.StopAlpha = 255
    LookAndFeel.Tabs.Hot.Style.OutlineColor = 12423799
    LookAndFeel.Tabs.Hot.Style.OutlineSize = 1.000000000000000000
    LookAndFeel.Tabs.Hot.Style.OutlineAlpha = 235
    LookAndFeel.CloseButton.Cross.Normal.Color = 6643031
    LookAndFeel.CloseButton.Cross.Normal.Thickness = 2.000000000000000000
    LookAndFeel.CloseButton.Cross.Normal.Alpha = 255
    LookAndFeel.CloseButton.Cross.Down.Color = 15461369
    LookAndFeel.CloseButton.Cross.Down.Thickness = 2.000000000000000000
    LookAndFeel.CloseButton.Cross.Down.Alpha = 220
    LookAndFeel.CloseButton.Cross.Hot.Color = clWhite
    LookAndFeel.CloseButton.Cross.Hot.Thickness = 2.000000000000000000
    LookAndFeel.CloseButton.Cross.Hot.Alpha = 220
    LookAndFeel.CloseButton.Circle.Normal.StartColor = clGradientActiveCaption
    LookAndFeel.CloseButton.Circle.Normal.StopColor = clNone
    LookAndFeel.CloseButton.Circle.Normal.StartAlpha = 0
    LookAndFeel.CloseButton.Circle.Normal.StopAlpha = 0
    LookAndFeel.CloseButton.Circle.Normal.OutlineColor = clGray
    LookAndFeel.CloseButton.Circle.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.CloseButton.Circle.Normal.OutlineAlpha = 0
    LookAndFeel.CloseButton.Circle.Down.StartColor = 3487169
    LookAndFeel.CloseButton.Circle.Down.StopColor = 3487169
    LookAndFeel.CloseButton.Circle.Down.StartAlpha = 255
    LookAndFeel.CloseButton.Circle.Down.StopAlpha = 255
    LookAndFeel.CloseButton.Circle.Down.OutlineColor = clGray
    LookAndFeel.CloseButton.Circle.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.CloseButton.Circle.Down.OutlineAlpha = 255
    LookAndFeel.CloseButton.Circle.Hot.StartColor = 9408475
    LookAndFeel.CloseButton.Circle.Hot.StopColor = 9803748
    LookAndFeel.CloseButton.Circle.Hot.StartAlpha = 255
    LookAndFeel.CloseButton.Circle.Hot.StopAlpha = 255
    LookAndFeel.CloseButton.Circle.Hot.OutlineColor = 6054595
    LookAndFeel.CloseButton.Circle.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.CloseButton.Circle.Hot.OutlineAlpha = 255
    LookAndFeel.AddButton.Button.Normal.StartColor = 16041889
    LookAndFeel.AddButton.Button.Normal.StopColor = 15844511
    LookAndFeel.AddButton.Button.Normal.StartAlpha = 255
    LookAndFeel.AddButton.Button.Normal.StopAlpha = 255
    LookAndFeel.AddButton.Button.Normal.OutlineColor = 11889731
    LookAndFeel.AddButton.Button.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.Button.Normal.OutlineAlpha = 255
    LookAndFeel.AddButton.Button.Down.StartColor = 12355685
    LookAndFeel.AddButton.Button.Down.StopColor = 12091999
    LookAndFeel.AddButton.Button.Down.StartAlpha = 255
    LookAndFeel.AddButton.Button.Down.StopAlpha = 255
    LookAndFeel.AddButton.Button.Down.OutlineColor = 9135436
    LookAndFeel.AddButton.Button.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.Button.Down.OutlineAlpha = 255
    LookAndFeel.AddButton.Button.Hot.StartColor = 16375240
    LookAndFeel.AddButton.Button.Hot.StopColor = 16044468
    LookAndFeel.AddButton.Button.Hot.StartAlpha = 255
    LookAndFeel.AddButton.Button.Hot.StopAlpha = 255
    LookAndFeel.AddButton.Button.Hot.OutlineColor = 11824194
    LookAndFeel.AddButton.Button.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.Button.Hot.OutlineAlpha = 255
    LookAndFeel.AddButton.PlusSign.Normal.StartColor = clWhite
    LookAndFeel.AddButton.PlusSign.Normal.StopColor = clWhite
    LookAndFeel.AddButton.PlusSign.Normal.StartAlpha = 255
    LookAndFeel.AddButton.PlusSign.Normal.StopAlpha = 255
    LookAndFeel.AddButton.PlusSign.Normal.OutlineColor = clGray
    LookAndFeel.AddButton.PlusSign.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.PlusSign.Normal.OutlineAlpha = 255
    LookAndFeel.AddButton.PlusSign.Down.StartColor = clWhite
    LookAndFeel.AddButton.PlusSign.Down.StopColor = clWhite
    LookAndFeel.AddButton.PlusSign.Down.StartAlpha = 255
    LookAndFeel.AddButton.PlusSign.Down.StopAlpha = 255
    LookAndFeel.AddButton.PlusSign.Down.OutlineColor = clGray
    LookAndFeel.AddButton.PlusSign.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.PlusSign.Down.OutlineAlpha = 255
    LookAndFeel.AddButton.PlusSign.Hot.StartColor = clWhite
    LookAndFeel.AddButton.PlusSign.Hot.StopColor = clWhite
    LookAndFeel.AddButton.PlusSign.Hot.StartAlpha = 255
    LookAndFeel.AddButton.PlusSign.Hot.StopAlpha = 255
    LookAndFeel.AddButton.PlusSign.Hot.OutlineColor = clGray
    LookAndFeel.AddButton.PlusSign.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.AddButton.PlusSign.Hot.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Normal.StartColor = 15975841
    LookAndFeel.ScrollButtons.Button.Normal.StopColor = 15778204
    LookAndFeel.ScrollButtons.Button.Normal.StartAlpha = 255
    LookAndFeel.ScrollButtons.Button.Normal.StopAlpha = 255
    LookAndFeel.ScrollButtons.Button.Normal.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Button.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Normal.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Down.StartColor = 12355684
    LookAndFeel.ScrollButtons.Button.Down.StopColor = 12091999
    LookAndFeel.ScrollButtons.Button.Down.StartAlpha = 255
    LookAndFeel.ScrollButtons.Button.Down.StopAlpha = 255
    LookAndFeel.ScrollButtons.Button.Down.OutlineColor = 9135180
    LookAndFeel.ScrollButtons.Button.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Down.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Hot.StartColor = 16241848
    LookAndFeel.ScrollButtons.Button.Hot.StopColor = 16044468
    LookAndFeel.ScrollButtons.Button.Hot.StartAlpha = 255
    LookAndFeel.ScrollButtons.Button.Hot.StopAlpha = 255
    LookAndFeel.ScrollButtons.Button.Hot.OutlineColor = 11824194
    LookAndFeel.ScrollButtons.Button.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Hot.OutlineAlpha = 255
    LookAndFeel.ScrollButtons.Button.Disabled.StartColor = 13531723
    LookAndFeel.ScrollButtons.Button.Disabled.StopColor = 13267523
    LookAndFeel.ScrollButtons.Button.Disabled.StartAlpha = 150
    LookAndFeel.ScrollButtons.Button.Disabled.StopAlpha = 150
    LookAndFeel.ScrollButtons.Button.Disabled.OutlineColor = 9985595
    LookAndFeel.ScrollButtons.Button.Disabled.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Button.Disabled.OutlineAlpha = 100
    LookAndFeel.ScrollButtons.Arrow.Normal.StartColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Normal.StopColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Normal.StartAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Normal.StopAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Normal.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Normal.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Normal.OutlineAlpha = 200
    LookAndFeel.ScrollButtons.Arrow.Down.StartColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Down.StopColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Down.StartAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Down.StopAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Down.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Down.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Down.OutlineAlpha = 200
    LookAndFeel.ScrollButtons.Arrow.Hot.StartColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Hot.StopColor = clWhite
    LookAndFeel.ScrollButtons.Arrow.Hot.StartAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Hot.StopAlpha = 255
    LookAndFeel.ScrollButtons.Arrow.Hot.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Hot.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Hot.OutlineAlpha = 200
    LookAndFeel.ScrollButtons.Arrow.Disabled.StartColor = clSilver
    LookAndFeel.ScrollButtons.Arrow.Disabled.StopColor = clSilver
    LookAndFeel.ScrollButtons.Arrow.Disabled.StartAlpha = 150
    LookAndFeel.ScrollButtons.Arrow.Disabled.StopAlpha = 150
    LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineColor = clGray
    LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineSize = 1.000000000000000000
    LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineAlpha = 200
    Align = alBottom
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 1021
    Height = 536
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1021
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 0
      object Label19: TLabel
        Left = 7
        Top = 7
        Width = 155
        Height = 15
        Caption = 'Show Options and Events for:'
      end
      object cbSelectTabs: TComboBox
        Left = 167
        Top = 4
        Width = 128
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'Top Tabs'
        OnChange = cbSelectTabsChange
        Items.Strings = (
          'Top Tabs'
          'Bottom Tabs')
      end
      object btnOpenForm: TButton
        Left = 870
        Top = 0
        Width = 144
        Height = 29
        Caption = 'Open New Form'
        TabOrder = 0
        OnClick = btnOpenFormClick
      end
    end
    object pcMain: TPageControl
      Left = 0
      Top = 29
      Width = 1021
      Height = 507
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Options'
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 270
          Height = 444
          Align = alLeft
          Caption = 'New/Active Tab'
          TabOrder = 0
          object Label1: TLabel
            Left = 11
            Top = 22
            Width = 25
            Height = 15
            Caption = 'Text:'
            FocusControl = edtTabCaption
          end
          object Label2: TLabel
            Left = 11
            Top = 70
            Width = 67
            Height = 15
            Caption = 'Image Index:'
            FocusControl = edtImageIndex
          end
          object Label3: TLabel
            Left = 135
            Top = 70
            Width = 110
            Height = 15
            Caption = 'Image Overlay Index:'
            FocusControl = edtImageOverlayIndex
          end
          object edtTabCaption: TEdit
            Left = 11
            Top = 37
            Width = 246
            Height = 23
            TabOrder = 0
            Text = 'New Tab'
            OnChange = CommonTabPropertyChange
          end
          object edtImageIndex: TSpinEdit
            Left = 11
            Top = 85
            Width = 118
            Height = 24
            MaxValue = 5
            MinValue = -1
            TabOrder = 1
            Value = 0
            OnChange = CommonTabPropertyChange
          end
          object edtImageOverlayIndex: TSpinEdit
            Left = 135
            Top = 85
            Width = 122
            Height = 24
            MaxValue = 1
            MinValue = -1
            TabOrder = 2
            Value = -1
            OnChange = CommonTabPropertyChange
          end
          object chkPinned: TCheckBox
            Left = 11
            Top = 115
            Width = 97
            Height = 17
            Caption = 'Pinned'
            TabOrder = 3
            OnClick = CommonTabPropertyChange
          end
          object btnMakeAllTabsVisible: TButton
            Left = 135
            Top = 144
            Width = 122
            Height = 25
            Caption = 'Make All Tabs Visible'
            TabOrder = 6
            OnClick = btnMakeAllTabsVisibleClick
          end
          object chkModified: TCheckBox
            Left = 135
            Top = 115
            Width = 97
            Height = 17
            Caption = 'Modified'
            TabOrder = 4
            OnClick = CommonTabPropertyChange
          end
          object btnHideTab: TButton
            Left = 11
            Top = 144
            Width = 118
            Height = 25
            Caption = 'Hide Tab'
            TabOrder = 5
            OnClick = btnHideTabClick
          end
        end
        object pcOptions: TPageControl
          Left = 270
          Top = 0
          Width = 743
          Height = 444
          ActivePage = TabSheet8
          Align = alClient
          TabOrder = 1
          object TabSheet5: TTabSheet
            Caption = 'Tabs'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object GroupBox3: TGroupBox
              Left = 0
              Top = 0
              Width = 735
              Height = 185
              Align = alTop
              Caption = 'Tabs'
              TabOrder = 0
              object Label6: TLabel
                Left = 8
                Top = 76
                Width = 75
                Height = 15
                Caption = 'Pinned Width:'
                FocusControl = edtPinnedWidth
              end
              object Label12: TLabel
                Left = 108
                Top = 20
                Width = 83
                Height = 15
                Caption = 'Max Tab Width:'
                FocusControl = edtMaxTabWidth
              end
              object lblMinTabWidth: TLabel
                Left = 8
                Top = 21
                Width = 82
                Height = 15
                Caption = 'Min Tab Width:'
                FocusControl = edtMinTabWidth
              end
              object Label17: TLabel
                Left = 278
                Top = 20
                Width = 120
                Height = 15
                Caption = 'Tab/Container Offsets:'
                FocusControl = edtTabOffsetTop
              end
              object Label51: TLabel
                Left = 283
                Top = 131
                Width = 115
                Height = 15
                Caption = 'Tab Content Margins:'
                FocusControl = edtTabOffsetTop
              end
              object Label71: TLabel
                Left = 108
                Top = 76
                Width = 67
                Height = 15
                Caption = 'Tab Overlap:'
                FocusControl = edtTabOverlap
              end
              object edtPinnedWidth: TSpinEdit
                Left = 8
                Top = 92
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = 4
                TabOrder = 8
                Value = 39
                OnChange = OnCommonControlPropertyChange
              end
              object edtMaxTabWidth: TSpinEdit
                Left = 108
                Top = 37
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = 4
                TabOrder = 6
                Value = 200
                OnChange = OnCommonControlPropertyChange
              end
              object edtMinTabWidth: TSpinEdit
                Left = 8
                Top = 37
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = 4
                TabOrder = 0
                Value = 150
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabOffsetTop: TSpinEdit
                Left = 312
                Top = 37
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                Increment = 2
                MaxValue = 65535
                MinValue = 0
                ParentFont = False
                TabOrder = 1
                Value = 4
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabOffsetLeft: TSpinEdit
                Left = 280
                Top = 67
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                Increment = 10
                MaxValue = 65535
                MinValue = 0
                ParentFont = False
                TabOrder = 3
                Value = 0
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabOffsetRight: TSpinEdit
                Left = 352
                Top = 67
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                Increment = 10
                MaxValue = 65535
                MinValue = 0
                ParentFont = False
                TabOrder = 4
                Value = 0
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabOffsetBottom: TSpinEdit
                Left = 312
                Top = 97
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                Increment = 2
                MaxValue = 65535
                MinValue = 0
                ParentFont = False
                TabOrder = 7
                Value = 0
                OnChange = OnCommonControlPropertyChange
              end
              object edtContainerOffsetLeft: TSpinEdit
                Left = 221
                Top = 67
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                Increment = 10
                MaxValue = 65535
                MinValue = 0
                ParentFont = False
                TabOrder = 2
                Value = 0
                OnChange = OnCommonControlPropertyChange
              end
              object edtContainerOffsetRight: TSpinEdit
                Left = 411
                Top = 67
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                Increment = 10
                MaxValue = 65535
                MinValue = 0
                ParentFont = False
                TabOrder = 5
                Value = 0
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabContentMarginLeft: TSpinEdit
                Left = 285
                Top = 148
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                MaxValue = 65535
                MinValue = -65535
                ParentFont = False
                TabOrder = 9
                Value = 18
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabContentMarginRight: TSpinEdit
                Left = 344
                Top = 148
                Width = 53
                Height = 24
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                MaxValue = 65535
                MinValue = -65535
                ParentFont = False
                TabOrder = 10
                Value = 16
                OnChange = OnCommonControlPropertyChange
              end
              object edtTabOverlap: TSpinEdit
                Left = 108
                Top = 92
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = -65535
                TabOrder = 11
                Value = 15
                OnChange = OnCommonControlPropertyChange
              end
            end
            object GroupBox5: TGroupBox
              Left = 0
              Top = 185
              Width = 735
              Height = 118
              Align = alTop
              Caption = 'Modified Glow'
              TabOrder = 1
              object Label15: TLabel
                Left = 11
                Top = 20
                Width = 87
                Height = 15
                Caption = 'Animation Style:'
                FocusControl = cbModifiedGlowStyle
              end
              object Label54: TLabel
                Left = 235
                Top = 66
                Width = 77
                Height = 15
                Caption = 'Vertical Offset:'
                FocusControl = edtModifiedGlowVerticalOffset
              end
              object Label55: TLabel
                Left = 343
                Top = 66
                Width = 90
                Height = 15
                Caption = 'Animation Steps:'
                FocusControl = edtModifiedGlowAnimationSteps
              end
              object Label56: TLabel
                Left = 11
                Top = 66
                Width = 39
                Height = 15
                Caption = 'Height:'
                FocusControl = edtModifiedGlowHeight
              end
              object Label57: TLabel
                Left = 119
                Top = 66
                Width = 35
                Height = 15
                Caption = 'Width:'
                FocusControl = edtModifiedGlowWidth
              end
              object cbModifiedGlowStyle: TComboBox
                Left = 11
                Top = 35
                Width = 143
                Height = 23
                Style = csDropDownList
                ItemIndex = 2
                TabOrder = 0
                Text = 'Right to Left'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'None'
                  'Left to Right'
                  'Right to Left'
                  'Knight Rider')
              end
              object edtModifiedGlowVerticalOffset: TSpinEdit
                Left = 235
                Top = 83
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = -65535
                TabOrder = 3
                Value = -2
                OnChange = OnCommonControlPropertyChange
              end
              object edtModifiedGlowAnimationSteps: TSpinEdit
                Left = 343
                Top = 83
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = -65535
                TabOrder = 4
                Value = 100
                OnChange = OnCommonControlPropertyChange
              end
              object edtModifiedGlowHeight: TSpinEdit
                Left = 11
                Top = 83
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 1
                Value = 20
                OnChange = OnCommonControlPropertyChange
              end
              object edtModifiedGlowWidth: TSpinEdit
                Left = 119
                Top = 83
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 2
                Value = 50
                OnChange = OnCommonControlPropertyChange
              end
            end
            object GroupBox6: TGroupBox
              Left = 0
              Top = 303
              Width = 735
              Height = 90
              Align = alTop
              Caption = 'Mouse Glow'
              TabOrder = 2
              object pnlMouseGlow: TPanel
                Left = 3
                Top = 43
                Width = 521
                Height = 41
                BevelOuter = bvNone
                TabOrder = 1
                object Label9: TLabel
                  Left = 233
                  Top = -1
                  Width = 77
                  Height = 15
                  Caption = 'Vertical Offset:'
                  FocusControl = edtMouseGlowVerticalOffset
                end
                object Label10: TLabel
                  Left = 341
                  Top = -1
                  Width = 93
                  Height = 15
                  Caption = 'Horizontal Offset:'
                  FocusControl = edtMouseGlowHorzOffset
                end
                object Label11: TLabel
                  Left = 9
                  Top = -1
                  Width = 39
                  Height = 15
                  Caption = 'Height:'
                  FocusControl = edtMouseGlowHeight
                end
                object Label16: TLabel
                  Left = 117
                  Top = -1
                  Width = 35
                  Height = 15
                  Caption = 'Width:'
                  FocusControl = edtMouseGlowWidth
                end
                object edtMouseGlowVerticalOffset: TSpinEdit
                  Left = 233
                  Top = 14
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 2
                  Value = 0
                  OnChange = OnCommonControlPropertyChange
                end
                object edtMouseGlowHorzOffset: TSpinEdit
                  Left = 341
                  Top = 14
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 3
                  Value = 0
                  OnChange = OnCommonControlPropertyChange
                end
                object edtMouseGlowHeight: TSpinEdit
                  Left = 9
                  Top = 14
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = OnCommonControlPropertyChange
                end
                object edtMouseGlowWidth: TSpinEdit
                  Left = 117
                  Top = 14
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = OnCommonControlPropertyChange
                end
              end
              object chkMouseGlowVisible: TCheckBox
                Left = 12
                Top = 21
                Width = 84
                Height = 17
                Caption = 'Visible'
                Checked = True
                State = cbChecked
                TabOrder = 0
                OnClick = OnCommonControlPropertyChange
              end
            end
          end
          object TabSheet7: TTabSheet
            Caption = 'Text'
            ImageIndex = 6
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object GroupBox4: TGroupBox
              Left = 0
              Top = 0
              Width = 735
              Height = 172
              Align = alTop
              Caption = 'Default Font'
              TabOrder = 0
              object Label14: TLabel
                Left = 8
                Top = 20
                Width = 158
                Height = 15
                Caption = 'Default Text Rendoring Mode:'
                FocusControl = cbFontHintMode
              end
              object Label63: TLabel
                Left = 8
                Top = 73
                Width = 62
                Height = 15
                Caption = 'Font Name:'
                FocusControl = edtDragImageAapha
              end
              object Label64: TLabel
                Left = 184
                Top = 72
                Width = 23
                Height = 15
                Caption = 'Size:'
                FocusControl = edtFontSize
              end
              object Label65: TLabel
                Left = 184
                Top = 120
                Width = 34
                Height = 15
                Caption = 'Alpha:'
                FocusControl = edtFontAlpha
              end
              object Label66: TLabel
                Left = 8
                Top = 124
                Width = 66
                Height = 15
                Caption = 'Font Colour:'
                FocusControl = edtFontColor
              end
              object cbFontHintMode: TComboBox
                Left = 8
                Top = 36
                Width = 170
                Height = 23
                Style = csDropDownList
                ItemIndex = 4
                TabOrder = 0
                Text = 'Anti Alias'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'System Default'
                  'Single Bit Per Pixel Grid Fit'
                  'Single Bit Per Pixel'
                  'Anti Alias Grid Fit'
                  'Anti Alias'
                  'ClearType Grid Fit')
              end
              object cbFontName: TComboBox
                Left = 8
                Top = 89
                Width = 170
                Height = 23
                TabOrder = 1
                Text = 'Segoe UI'
                OnChange = OnCommonControlPropertyChange
              end
              object edtFontSize: TSpinEdit
                Left = 184
                Top = 89
                Width = 94
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 2
                Value = 9
                OnChange = OnCommonControlPropertyChange
              end
              object edtFontAlpha: TSpinEdit
                Left = 184
                Top = 137
                Width = 94
                Height = 24
                MaxValue = 255
                MinValue = 0
                TabOrder = 3
                Value = 255
                OnChange = OnCommonControlPropertyChange
              end
              object edtFontColor: TColorBox
                Left = 8
                Top = 139
                Width = 170
                Height = 22
                DefaultColorColor = clSkyBlue
                TabOrder = 4
                OnChange = OnCommonControlPropertyChange
              end
            end
            object GroupBox10: TGroupBox
              Left = 0
              Top = 172
              Width = 735
              Height = 151
              Align = alTop
              Caption = 'Display'
              TabOrder = 1
              object Label67: TLabel
                Left = 13
                Top = 99
                Width = 90
                Height = 15
                Caption = 'Trimming Mode:'
                FocusControl = cbTextTrimming
              end
              object Label18: TLabel
                Left = 13
                Top = 51
                Width = 122
                Height = 15
                Caption = 'Horzizontal Alignment:'
                FocusControl = cbTextAlignment
              end
              object Label52: TLabel
                Left = 174
                Top = 51
                Width = 101
                Height = 15
                Caption = 'Vertical Alignment:'
                FocusControl = cbTextVerticalAlignment
              end
              object cbTextTrimming: TComboBox
                Left = 13
                Top = 115
                Width = 152
                Height = 23
                Style = csDropDownList
                ItemIndex = 6
                TabOrder = 3
                Text = 'Fade'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'None'
                  'Character'
                  'Word'
                  'Ellipsis Character'
                  'Ellipsis Word'
                  'Ellipsis Path'
                  'Fade')
              end
              object chkTabWordWrap: TCheckBox
                Tag = 1
                Left = 13
                Top = 24
                Width = 91
                Height = 17
                Caption = 'Word Wrap'
                TabOrder = 0
                OnClick = OnCommonControlPropertyChange
              end
              object cbTextAlignment: TComboBox
                Left = 13
                Top = 66
                Width = 150
                Height = 23
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 2
                Text = 'Left'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'Left'
                  'Right'
                  'Centre')
              end
              object cbTextVerticalAlignment: TComboBox
                Left = 174
                Top = 66
                Width = 139
                Height = 23
                Style = csDropDownList
                ItemIndex = 2
                TabOrder = 1
                Text = 'Centre'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'Top'
                  'Bottom'
                  'Centre')
              end
            end
          end
          object TabSheet4: TTabSheet
            Caption = 'Buttons'
            ImageIndex = 5
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object pcButtons: TPageControl
              Left = 0
              Top = 19
              Width = 735
              Height = 395
              ActivePage = TabSheet11
              Align = alClient
              TabOrder = 0
              object TabSheet11: TTabSheet
                Caption = 'Close Buttons'
                ImageIndex = 1
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object Label4: TLabel
                  Left = 11
                  Top = 6
                  Width = 47
                  Height = 15
                  Caption = 'Visibility:'
                  FocusControl = cbCloseButtonVisibility
                end
                object Label39: TLabel
                  Left = 207
                  Top = 4
                  Width = 108
                  Height = 15
                  Caption = 'Auto hide tab width:'
                  FocusControl = edtCloseButtonAutoHideWidth
                end
                object Label42: TLabel
                  Left = 235
                  Top = 56
                  Width = 77
                  Height = 15
                  Caption = 'Vertical Offset:'
                  FocusControl = edtCloseButtonVerticalOffset
                end
                object Label43: TLabel
                  Left = 343
                  Top = 56
                  Width = 63
                  Height = 15
                  Caption = 'Horz Offset:'
                  FocusControl = edtCloseButtonHorzOffset
                end
                object Label44: TLabel
                  Left = 11
                  Top = 56
                  Width = 39
                  Height = 15
                  Caption = 'Height:'
                  FocusControl = edtCloseButtonHeight
                end
                object Label45: TLabel
                  Left = 119
                  Top = 56
                  Width = 35
                  Height = 15
                  Caption = 'Width:'
                  FocusControl = edtCloseButtonWidth
                end
                object Label50: TLabel
                  Left = 11
                  Top = 112
                  Width = 67
                  Height = 15
                  Caption = 'Cross Offset:'
                  FocusControl = edtCrossOffset
                end
                object cbCloseButtonVisibility: TComboBox
                  Left = 11
                  Top = 21
                  Width = 94
                  Height = 23
                  Style = csDropDownList
                  ItemIndex = 1
                  TabOrder = 1
                  Text = 'All Tabs'
                  OnChange = OnCommonControlPropertyChange
                  Items.Strings = (
                    'Never'
                    'All Tabs'
                    'Active Tab')
                end
                object chkCloseButtonAutoHide: TCheckBox
                  Left = 115
                  Top = 24
                  Width = 84
                  Height = 17
                  Caption = 'Auto Hide'
                  TabOrder = 2
                  OnClick = OnCommonControlPropertyChange
                end
                object edtCloseButtonAutoHideWidth: TSpinEdit
                  Left = 206
                  Top = 19
                  Width = 114
                  Height = 24
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 20
                  OnChange = OnCommonControlPropertyChange
                end
                object edtCloseButtonVerticalOffset: TSpinEdit
                  Left = 235
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 5
                  Value = 6
                  OnChange = OnCommonControlPropertyChange
                end
                object edtCloseButtonHorzOffset: TSpinEdit
                  Left = 343
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 6
                  Value = 2
                  OnChange = OnCommonControlPropertyChange
                end
                object edtCloseButtonHeight: TSpinEdit
                  Left = 11
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 3
                  Value = 14
                  OnChange = OnCommonControlPropertyChange
                end
                object edtCloseButtonWidth: TSpinEdit
                  Left = 119
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 4
                  Value = 14
                  OnChange = OnCommonControlPropertyChange
                end
                object edtCrossOffset: TSpinEdit
                  Left = 11
                  Top = 129
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 7
                  Value = 3
                  OnChange = OnCommonControlPropertyChange
                end
              end
              object TabSheet12: TTabSheet
                Caption = 'Add Button'
                ImageIndex = 2
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object Label29: TLabel
                  Left = 11
                  Top = 6
                  Width = 47
                  Height = 15
                  Caption = 'Visibility:'
                  FocusControl = cbAddButtonVisibility
                end
                object Label37: TLabel
                  Left = 235
                  Top = 56
                  Width = 77
                  Height = 15
                  Caption = 'Vertical Offset:'
                  FocusControl = edtAddButtonVerticalOffset
                end
                object Label38: TLabel
                  Left = 343
                  Top = 56
                  Width = 63
                  Height = 15
                  Caption = 'Horz Offset:'
                  FocusControl = edtAddButtonHorzOffset
                end
                object Label46: TLabel
                  Left = 11
                  Top = 56
                  Width = 39
                  Height = 15
                  Caption = 'Height:'
                  FocusControl = edtAddButtonHeight
                end
                object Label47: TLabel
                  Left = 119
                  Top = 56
                  Width = 35
                  Height = 15
                  Caption = 'Width:'
                  FocusControl = edtAddButtonWidth
                end
                object Label68: TLabel
                  Left = 443
                  Top = 56
                  Width = 109
                  Height = 15
                  Caption = 'Floating Horz Offset:'
                  FocusControl = edtAddButtonFloatingHorzOffset
                end
                object cbAddButtonVisibility: TComboBox
                  Left = 11
                  Top = 21
                  Width = 118
                  Height = 23
                  Style = csDropDownList
                  ItemIndex = 2
                  TabOrder = 0
                  Text = 'Floating Right'
                  OnChange = OnCommonControlPropertyChange
                  Items.Strings = (
                    'None'
                    'Left'
                    'Floating Right'
                    'Fixed Right')
                end
                object edtAddButtonVerticalOffset: TSpinEdit
                  Left = 235
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 4
                  Value = 9
                  OnChange = OnCommonControlPropertyChange
                end
                object edtAddButtonHorzOffset: TSpinEdit
                  Left = 343
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 5
                  Value = 2
                  OnChange = OnCommonControlPropertyChange
                end
                object edtAddButtonHeight: TSpinEdit
                  Left = 11
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 2
                  Value = 14
                  OnChange = OnCommonControlPropertyChange
                end
                object edtAddButtonWidth: TSpinEdit
                  Left = 119
                  Top = 73
                  Width = 94
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 3
                  Value = 25
                  OnChange = OnCommonControlPropertyChange
                end
                object chkShowPlus: TCheckBox
                  Left = 147
                  Top = 24
                  Width = 118
                  Height = 17
                  Caption = 'Show Plus'
                  Checked = True
                  State = cbChecked
                  TabOrder = 1
                  OnClick = OnCommonControlPropertyChange
                end
                object edtAddButtonFloatingHorzOffset: TSpinEdit
                  Left = 443
                  Top = 73
                  Width = 118
                  Height = 24
                  MaxValue = 65535
                  MinValue = -65535
                  TabOrder = 6
                  Value = 2
                  OnChange = OnCommonControlPropertyChange
                end
              end
              object TabSheet13: TTabSheet
                Caption = 'Scroll Buttons'
                ImageIndex = 3
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object Label25: TLabel
                  Left = 11
                  Top = 7
                  Width = 76
                  Height = 15
                  Caption = 'Scroll Buttons:'
                  FocusControl = cbScrollButtons
                end
                object cbScrollButtons: TComboBox
                  Left = 11
                  Top = 23
                  Width = 144
                  Height = 23
                  Style = csDropDownList
                  ItemIndex = 2
                  TabOrder = 0
                  Text = 'Right'
                  OnChange = OnCommonControlPropertyChange
                  Items.Strings = (
                    'None'
                    'Left'
                    'Right'
                    'LeftAndRight')
                end
                object chkAutoHideScrollButtons: TCheckBox
                  Left = 161
                  Top = 26
                  Width = 138
                  Height = 17
                  Caption = 'Auto Hide'
                  Checked = True
                  State = cbChecked
                  TabOrder = 1
                  OnClick = OnCommonControlPropertyChange
                end
                object GroupBox2: TGroupBox
                  Left = 13
                  Top = 63
                  Width = 508
                  Height = 74
                  Caption = 'Left Button'
                  TabOrder = 2
                  object Label40: TLabel
                    Left = 235
                    Top = 20
                    Width = 77
                    Height = 15
                    Caption = 'Vertical Offset:'
                    FocusControl = edtLeftScrollButtonsVerticalOffset
                  end
                  object Label41: TLabel
                    Left = 343
                    Top = 20
                    Width = 63
                    Height = 15
                    Caption = 'Horz Offset:'
                    FocusControl = edtLeftScrollButtonsHorzOffset
                  end
                  object Label48: TLabel
                    Left = 11
                    Top = 20
                    Width = 39
                    Height = 15
                    Caption = 'Height:'
                    FocusControl = edtLeftScrollButtonHeight
                  end
                  object Label49: TLabel
                    Left = 119
                    Top = 20
                    Width = 35
                    Height = 15
                    Caption = 'Width:'
                    FocusControl = edtLeftScrollButtonWidth
                  end
                  object edtLeftScrollButtonsVerticalOffset: TSpinEdit
                    Left = 235
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 2
                    Value = 10
                    OnChange = OnCommonControlPropertyChange
                  end
                  object edtLeftScrollButtonsHorzOffset: TSpinEdit
                    Left = 343
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 3
                    Value = 0
                    OnChange = OnCommonControlPropertyChange
                  end
                  object edtLeftScrollButtonHeight: TSpinEdit
                    Left = 11
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 0
                    Value = 15
                    OnChange = OnCommonControlPropertyChange
                  end
                  object edtLeftScrollButtonWidth: TSpinEdit
                    Left = 119
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 1
                    Value = 15
                    OnChange = OnCommonControlPropertyChange
                  end
                end
                object GroupBox7: TGroupBox
                  Left = 13
                  Top = 143
                  Width = 508
                  Height = 74
                  Caption = 'Right Button'
                  TabOrder = 3
                  object Label58: TLabel
                    Left = 235
                    Top = 20
                    Width = 77
                    Height = 15
                    Caption = 'Vertical Offset:'
                    FocusControl = edtRightScrollButtonVerticalOffset
                  end
                  object Label59: TLabel
                    Left = 343
                    Top = 20
                    Width = 63
                    Height = 15
                    Caption = 'Horz Offset:'
                    FocusControl = edtRightScrollButtonHorzOffset
                  end
                  object Label60: TLabel
                    Left = 11
                    Top = 20
                    Width = 39
                    Height = 15
                    Caption = 'Height:'
                    FocusControl = edtRightScrollButtonHeight
                  end
                  object Label61: TLabel
                    Left = 119
                    Top = 20
                    Width = 35
                    Height = 15
                    Caption = 'Width:'
                    FocusControl = edtRightScrollButtonWidth
                  end
                  object edtRightScrollButtonVerticalOffset: TSpinEdit
                    Left = 235
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 2
                    Value = 10
                    OnChange = OnCommonControlPropertyChange
                  end
                  object edtRightScrollButtonHorzOffset: TSpinEdit
                    Left = 343
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 3
                    Value = 0
                    OnChange = OnCommonControlPropertyChange
                  end
                  object edtRightScrollButtonHeight: TSpinEdit
                    Left = 11
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 0
                    Value = 15
                    OnChange = OnCommonControlPropertyChange
                  end
                  object edtRightScrollButtonWidth: TSpinEdit
                    Left = 119
                    Top = 37
                    Width = 94
                    Height = 24
                    MaxValue = 65535
                    MinValue = -65535
                    TabOrder = 1
                    Value = 15
                    OnChange = OnCommonControlPropertyChange
                  end
                end
              end
            end
            object Panel8: TPanel
              Left = 0
              Top = 0
              Width = 735
              Height = 19
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object chkScrollOverlayButtons: TCheckBox
                Left = 0
                Top = 0
                Width = 728
                Height = 17
                Caption = 'Overlay Buttons'
                TabOrder = 0
                OnClick = OnCommonControlPropertyChange
              end
            end
          end
          object TabSheet10: TTabSheet
            Caption = 'Internationlization'
            ImageIndex = 8
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label69: TLabel
              Left = 3
              Top = 6
              Width = 57
              Height = 15
              Caption = 'Bidi Mode:'
              FocusControl = cbBidiMode
            end
            object cbBidiMode: TComboBox
              Left = 3
              Top = 21
              Width = 206
              Height = 23
              Style = csDropDownList
              ItemIndex = 0
              TabOrder = 0
              Text = 'Left to Right'
              OnChange = OnCommonControlPropertyChange
              Items.Strings = (
                'Left to Right'
                'Right to Left Text'
                'Right to Left Tabs'
                'Right to Left Text and Tabs')
            end
          end
          object Scrolling: TTabSheet
            Caption = 'Scrolling'
            ImageIndex = 4
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object chkScrolling: TCheckBox
              Left = 3
              Top = 3
              Width = 1057
              Height = 17
              Caption = 'Enable Scrolling'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = OnCommonControlPropertyChange
            end
            object pnlScroll: TPanel
              Left = 0
              Top = 0
              Width = 735
              Height = 414
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object Label26: TLabel
                Left = 17
                Top = 60
                Width = 60
                Height = 15
                Caption = 'Scroll Steps'
                FocusControl = edtScrollSteps
              end
              object Label27: TLabel
                Left = 172
                Top = 63
                Width = 95
                Height = 15
                Caption = 'Repeat Delay (ms)'
                FocusControl = edtScrollRepeatDelay
              end
              object Label24: TLabel
                Left = 17
                Top = 8
                Width = 67
                Height = 15
                Caption = 'Scroll Offset:'
                FocusControl = sbScrollOffset
              end
              object lblScrollOffset: TLabel
                Left = 321
                Top = 26
                Width = 6
                Height = 15
                Caption = '0'
              end
              object Label28: TLabel
                Left = 172
                Top = 110
                Width = 109
                Height = 15
                Caption = 'Scroll Edge Distance:'
                FocusControl = edtDragScrollEdge
              end
              object edtScrollSteps: TSpinEdit
                Left = 17
                Top = 77
                Width = 144
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 1
                Value = 20
                OnChange = OnCommonControlPropertyChange
              end
              object edtScrollRepeatDelay: TSpinEdit
                Left = 172
                Top = 80
                Width = 141
                Height = 24
                MaxValue = 65535
                MinValue = 0
                TabOrder = 2
                Value = 20
                OnChange = OnCommonControlPropertyChange
              end
              object sbScrollOffset: TScrollBar
                Left = 17
                Top = 26
                Width = 296
                Height = 17
                PageSize = 1
                TabOrder = 0
                OnChange = sbScrollOffsetChange
              end
              object chkScrollWhileDragging: TCheckBox
                Left = 17
                Top = 130
                Width = 149
                Height = 17
                Caption = 'Scroll While Dragging'
                Checked = True
                State = cbChecked
                TabOrder = 4
                OnClick = OnCommonControlPropertyChange
              end
              object edtDragScrollEdge: TSpinEdit
                Left = 172
                Top = 127
                Width = 141
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 3
                Value = 50
                OnChange = OnCommonControlPropertyChange
              end
              object chkMouseWheelScrolling: TCheckBox
                Left = 17
                Top = 170
                Width = 149
                Height = 17
                Caption = 'Mouse Wheel Scrolling'
                Checked = True
                State = cbChecked
                TabOrder = 5
                OnClick = OnCommonControlPropertyChange
              end
              object Button1: TButton
                Left = 17
                Top = 208
                Width = 184
                Height = 25
                Caption = 'Scroll Active Tab into View'
                TabOrder = 6
                OnClick = Button1Click
              end
            end
          end
          object TabSheet6: TTabSheet
            Caption = 'Tab Container'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label20: TLabel
              Left = 3
              Top = 4
              Width = 137
              Height = 15
              Caption = 'Canvas Smoothing Mode:'
              FocusControl = cbCanvasSmoothingMode
            end
            object chkTransparentBackground: TCheckBox
              Left = 3
              Top = 49
              Width = 198
              Height = 17
              Caption = 'Transparent Background'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = OnCommonControlPropertyChange
            end
            object cbCanvasSmoothingMode: TComboBox
              Left = 3
              Top = 20
              Width = 170
              Height = 23
              Style = csDropDownList
              ItemIndex = 2
              TabOrder = 0
              Text = 'High Quality'
              OnChange = OnCommonControlPropertyChange
              Items.Strings = (
                'Default'
                'High Speed'
                'High Quality'
                'None'
                'Anti Alias')
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Behaviour'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label53: TLabel
              Left = 24
              Top = 118
              Width = 240
              Height = 15
              Alignment = taRightJustify
              Caption = 'Delay before resizing tabs when cursor leaves:'
              FocusControl = edtCloseButtonMouseLeaveDelay
            end
            object Label62: TLabel
              Left = 348
              Top = 118
              Width = 16
              Height = 15
              Caption = 'ms'
            end
            object chkBackgroundDoubleClickMaxmise: TCheckBox
              Left = 3
              Top = 6
              Width = 371
              Height = 17
              Caption = 'Double click background to minimise/maxmise form'
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = OnCommonControlPropertyChange
            end
            object chkDraggingBackgoundMovesForm: TCheckBox
              Left = 3
              Top = 29
              Width = 371
              Height = 17
              Caption = 'Dragging background moves form'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = OnCommonControlPropertyChange
            end
            object chkSmartResize: TCheckBox
              Left = 3
              Top = 94
              Width = 371
              Height = 17
              Caption = 'Reposition tab close button under mouse after closing a tab'
              Checked = True
              State = cbChecked
              TabOrder = 3
              OnClick = OnCommonControlPropertyChange
            end
            object edtCloseButtonMouseLeaveDelay: TSpinEdit
              Left = 270
              Top = 115
              Width = 75
              Height = 24
              Increment = 100
              MaxValue = 65535
              MinValue = 1
              TabOrder = 4
              Value = 700
              OnChange = OnCommonControlPropertyChange
            end
            object chkRightClickSelect: TCheckBox
              Left = 3
              Top = 60
              Width = 371
              Height = 17
              Caption = 'Right Click Select'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = OnCommonControlPropertyChange
            end
          end
          object TabSheet8: TTabSheet
            Caption = 'Animation'
            ImageIndex = 3
            object GroupBox8: TGroupBox
              Left = 0
              Top = 0
              Width = 735
              Height = 185
              Align = alTop
              Caption = 'Properties'
              TabOrder = 0
              object Label21: TLabel
                Left = 8
                Top = 76
                Width = 81
                Height = 15
                Caption = 'Movement MS:'
                FocusControl = edtAnimationStepsMovement
              end
              object Label22: TLabel
                Left = 8
                Top = 135
                Width = 48
                Height = 15
                Caption = 'Style MS:'
                FocusControl = edtAnimationStepsStyle
              end
              object Label23: TLabel
                Left = 8
                Top = 23
                Width = 102
                Height = 15
                Caption = 'Update Timer (ms):'
                FocusControl = edtAnimationUpdate
              end
              object Label70: TLabel
                Left = 132
                Top = 76
                Width = 116
                Height = 15
                Caption = 'Movement Ease Type:'
                FocusControl = cbMovementEaseType
              end
              object Label72: TLabel
                Left = 132
                Top = 135
                Width = 83
                Height = 15
                Caption = 'Style Ease Type:'
                FocusControl = cbStyleEaseType
              end
              object edtAnimationStepsMovement: TSpinEdit
                Left = 8
                Top = 93
                Width = 118
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 0
                Value = 500
                OnChange = OnCommonControlPropertyChange
              end
              object edtAnimationStepsStyle: TSpinEdit
                Left = 8
                Top = 152
                Width = 118
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 1
                Value = 300
                OnChange = OnCommonControlPropertyChange
              end
              object edtAnimationUpdate: TSpinEdit
                Left = 8
                Top = 40
                Width = 118
                Height = 24
                MaxValue = 65535
                MinValue = 1
                TabOrder = 2
                Value = 30
                OnChange = OnCommonControlPropertyChange
              end
              object cbMovementEaseType: TComboBox
                Left = 132
                Top = 93
                Width = 129
                Height = 23
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 3
                Text = 'None'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'None'
                  'Linear'
                  'In Quad'
                  'Out Quad'
                  'In Out Quad'
                  'In Cubic'
                  'Out Cubic'
                  'In Out Cubic'
                  'In Quart'
                  'Out Quart'
                  'In Out Quart'
                  'In Quint'
                  'Out Quint'
                  'In Out Quint'
                  'In Sine'
                  'Out Sine'
                  'In Out Sine'
                  'In Expo'
                  'Out Expo'
                  'In Out Expo'
                  'In Circ'
                  'Out Circ'
                  'In Out Circ')
              end
              object cbStyleEaseType: TComboBox
                Left = 132
                Top = 152
                Width = 129
                Height = 23
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 4
                Text = 'None'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'None'
                  'Linear'
                  'In Quad'
                  'Out Quad'
                  'In Out Quad'
                  'In Cubic'
                  'Out Cubic'
                  'In Out Cubic'
                  'In Quart'
                  'Out Quart'
                  'In Out Quart'
                  'In Quint'
                  'Out Quint'
                  'In Out Quint'
                  'In Sine'
                  'Out Sine'
                  'In Out Sine'
                  'In Expo'
                  'Out Expo'
                  'In Out Expo'
                  'In Circ'
                  'Out Circ'
                  'In Out Circ')
              end
            end
            object GroupBox9: TGroupBox
              Left = 0
              Top = 185
              Width = 735
              Height = 127
              Align = alTop
              Caption = 'Movement Animation'
              TabOrder = 1
              object Label30: TLabel
                Left = 11
                Top = 91
                Width = 377
                Height = 33
                AutoSize = False
                Caption = 
                  'Style transition animation properties can be set in the OnAnimat' +
                  'eStyleTransisiton event'
                Font.Charset = ANSI_CHARSET
                Font.Color = clGray
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                WordWrap = True
              end
              object chkAnimationAddTab: TCheckBox
                Left = 11
                Top = 21
                Width = 151
                Height = 17
                Caption = 'Add Tab'
                Checked = True
                State = cbChecked
                TabOrder = 0
                OnClick = OnCommonMovementAnimationClick
              end
              object chkAnimationTabMovements: TCheckBox
                Tag = 2
                Left = 11
                Top = 44
                Width = 162
                Height = 17
                Caption = 'Tab Movements'
                Checked = True
                State = cbChecked
                TabOrder = 2
                OnClick = OnCommonMovementAnimationClick
              end
              object chkAnimationDragCancelled: TCheckBox
                Tag = 3
                Left = 179
                Top = 44
                Width = 180
                Height = 17
                Caption = 'Tab Drag Cancelled'
                Checked = True
                State = cbChecked
                TabOrder = 3
                OnClick = OnCommonMovementAnimationClick
              end
              object chkAnimationAddButtonMove: TCheckBox
                Tag = 4
                Left = 11
                Top = 68
                Width = 158
                Height = 17
                Caption = 'Add Button Move'
                Checked = True
                State = cbChecked
                TabOrder = 4
                OnClick = OnCommonMovementAnimationClick
              end
              object chkAnimationDeleteTab: TCheckBox
                Tag = 1
                Left = 179
                Top = 21
                Width = 158
                Height = 17
                Caption = 'Delete Tab'
                Checked = True
                State = cbChecked
                TabOrder = 1
                OnClick = OnCommonMovementAnimationClick
              end
            end
          end
          object TabSheet9: TTabSheet
            Caption = 'Drag Drop'
            ImageIndex = 7
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object cbDragType: TComboBox
              Left = 3
              Top = 21
              Width = 200
              Height = 23
              Style = csDropDownList
              Constraints.MaxWidth = 200
              Constraints.MinWidth = 200
              ItemIndex = 2
              TabOrder = 1
              Text = 'Drag between containers'
              OnChange = OnCommonControlPropertyChange
              Items.Strings = (
                'None'
                'Drag within container'
                'Drag between containers')
            end
            object pnlDragDrop: TPanel
              Left = 0
              Top = 0
              Width = 735
              Height = 414
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object Label31: TLabel
                Left = 6
                Top = 6
                Width = 63
                Height = 15
                Caption = 'Drag Cursor'
                FocusControl = cbDragCursor
              end
              object Label32: TLabel
                Left = 140
                Top = 5
                Width = 87
                Height = 15
                Caption = 'Drag Start Pixels:'
                FocusControl = edtDragStartPixels
              end
              object Label33: TLabel
                Left = 6
                Top = 62
                Width = 113
                Height = 15
                Caption = 'External Drag Display:'
                FocusControl = cbExternalDragDisplay
              end
              object Label34: TLabel
                Left = 274
                Top = 5
                Width = 105
                Height = 15
                Caption = 'Drag away distance:'
                FocusControl = edtDragAwayDistance
              end
              object cbDragCursor: TComboBox
                Left = 6
                Top = 22
                Width = 126
                Height = 23
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 0
                Text = 'Default'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'Default'
                  'Drag')
              end
              object edtDragStartPixels: TSpinEdit
                Left = 140
                Top = 22
                Width = 128
                Height = 24
                MaxValue = 65535
                MinValue = 0
                TabOrder = 1
                Value = 2
                OnChange = OnCommonControlPropertyChange
              end
              object cbExternalDragDisplay: TComboBox
                Left = 6
                Top = 78
                Width = 126
                Height = 23
                Style = csDropDownList
                ItemIndex = 3
                TabOrder = 3
                Text = 'Tab and Control'
                OnChange = OnCommonControlPropertyChange
                Items.Strings = (
                  'Cursor'
                  'Tab'
                  'Control'
                  'Tab and Control')
              end
              object pnlDragDisplay: TPanel
                Left = 6
                Top = 107
                Width = 470
                Height = 62
                BevelOuter = bvNone
                TabOrder = 4
                object Label35: TLabel
                  Left = 1
                  Top = 3
                  Width = 98
                  Height = 15
                  Caption = 'Drag Image Alpha:'
                  FocusControl = edtDragImageAapha
                end
                object Label36: TLabel
                  Left = 135
                  Top = 3
                  Width = 99
                  Height = 15
                  Caption = 'Drag Image Resize:'
                  FocusControl = edtDragImageAapha
                end
                object edtDragImageAapha: TSpinEdit
                  Left = 1
                  Top = 20
                  Width = 128
                  Height = 24
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 0
                  Value = 220
                  OnChange = OnCommonControlPropertyChange
                end
                object edtDragImageResize: TEdit
                  Left = 135
                  Top = 20
                  Width = 121
                  Height = 23
                  TabOrder = 1
                  Text = '0.5'
                  OnChange = OnCommonControlPropertyChange
                end
              end
              object edtDragAwayDistance: TSpinEdit
                Left = 274
                Top = 22
                Width = 130
                Height = 24
                MaxValue = 65535
                MinValue = 0
                TabOrder = 2
                Value = 30
                OnChange = OnCommonControlPropertyChange
              end
            end
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 444
          Width = 1013
          Height = 33
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object btnSaveOptions: TButton
            Left = 133
            Top = 0
            Width = 133
            Height = 33
            Action = actSaveOptions
            TabOrder = 1
          end
          object btnLoadOptions: TButton
            Left = 0
            Top = 0
            Width = 133
            Height = 33
            Action = actLoadOptions
            TabOrder = 0
          end
          object btnCopyOptions: TButton
            Left = 266
            Top = 0
            Width = 170
            Height = 33
            Action = actCopyOptionsAsCode
            TabOrder = 2
          end
        end
      end
      object TabSheet14: TTabSheet
        Caption = 'Look and Feel'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object tvLookAndFeelItems: TTreeView
          Left = 0
          Top = 0
          Width = 169
          Height = 444
          Align = alLeft
          HideSelection = False
          Indent = 19
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          OnChange = tvLookAndFeelItemsChange
        end
        object Panel5: TPanel
          Left = 169
          Top = 0
          Width = 844
          Height = 444
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object pnlLookAndFeelPath: TPanel
            Left = 0
            Top = 0
            Width = 844
            Height = 25
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = 'pnlLookAndFeelPath'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ScrollBox1: TScrollBox
            Left = 0
            Top = 25
            Width = 844
            Height = 419
            HorzScrollBar.Smooth = True
            HorzScrollBar.Style = ssHotTrack
            HorzScrollBar.Tracking = True
            VertScrollBar.Smooth = True
            VertScrollBar.Tracking = True
            Align = alClient
            BorderStyle = bsNone
            Color = clWindow
            ParentColor = False
            TabOrder = 1
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 444
          Width = 1013
          Height = 33
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object btnSaveLookAndFeel: TButton
            Left = 133
            Top = 0
            Width = 133
            Height = 33
            Action = actSaveLookandFeel
            TabOrder = 1
          end
          object btnLoadLookAndFeel: TButton
            Left = 0
            Top = 0
            Width = 133
            Height = 33
            Action = actLoadLookAndFeel
            TabOrder = 0
          end
          object btnCopyLookAndFeel: TButton
            Left = 266
            Top = 0
            Width = 170
            Height = 33
            Action = actCopyLookAndFeelAsCode
            TabOrder = 2
          end
        end
      end
      object TabSheet15: TTabSheet
        Caption = 'General'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label7: TLabel
          Left = 16
          Top = 8
          Width = 117
          Height = 15
          Caption = 'Tab Container Height:'
          FocusControl = edtTabHeight
        end
        object Label5: TLabel
          Left = 30
          Top = 88
          Width = 90
          Height = 15
          Alignment = taRightJustify
          Caption = 'Glass Height Top'
          FocusControl = edtGlassHeightTop
        end
        object Label8: TLabel
          Left = 11
          Top = 115
          Width = 109
          Height = 15
          Alignment = taRightJustify
          Caption = 'Glass Height Bottom'
          FocusControl = edtGlassHeightBottom
        end
        object edtTabHeight: TSpinEdit
          Left = 16
          Top = 25
          Width = 129
          Height = 24
          MaxValue = 65535
          MinValue = 4
          TabOrder = 0
          Value = 65
          OnChange = OnCommonControlPropertyChange
        end
        object edtGlassHeightTop: TSpinEdit
          Left = 126
          Top = 85
          Width = 74
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 25
          OnChange = OnCommonControlPropertyChange
        end
        object chkUseGlass: TCheckBox
          Left = 14
          Top = 63
          Width = 155
          Height = 17
          Caption = 'Glass Form'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = OnCommonControlPropertyChange
        end
        object edtGlassHeightBottom: TSpinEdit
          Left = 126
          Top = 112
          Width = 74
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 25
          OnChange = OnCommonControlPropertyChange
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Events'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 63
          Width = 1013
          Height = 414
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object gbOtherEvents: TGroupBox
            Left = 685
            Top = 0
            Width = 328
            Height = 414
            Align = alClient
            Caption = 'Other Events'
            TabOrder = 3
          end
          object gbChange: TGroupBox
            Left = 241
            Top = 0
            Width = 222
            Height = 414
            Align = alLeft
            Caption = 'OnChange'
            TabOrder = 1
            object Panel9: TPanel
              Left = 2
              Top = 394
              Width = 218
              Height = 18
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 0
              object chkIgnorePropertyUpdated: TCheckBox
                Left = 4
                Top = 0
                Width = 218
                Height = 17
                Caption = 'Ignore Property Updated Events'
                Checked = True
                State = cbChecked
                TabOrder = 0
              end
            end
          end
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 241
            Height = 414
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object gbMouseMove: TGroupBox
              Left = 0
              Top = 0
              Width = 241
              Height = 169
              Align = alTop
              Caption = 'OnMouseMove'
              TabOrder = 0
            end
            object gbDragOver: TGroupBox
              Left = 0
              Top = 169
              Width = 241
              Height = 245
              Align = alClient
              Caption = 'OnTabDragOver'
              TabOrder = 1
              object lbTabDragOver: TListBox
                Left = 2
                Top = 17
                Width = 237
                Height = 226
                Align = alClient
                BorderStyle = bsNone
                ItemHeight = 15
                TabOrder = 0
              end
            end
          end
          object gbEvents: TGroupBox
            Left = 463
            Top = 0
            Width = 222
            Height = 414
            Align = alLeft
            Caption = 'Event Counts'
            TabOrder = 2
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 1013
          Height = 63
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            1013
            63)
          object Label13: TLabel
            Left = 1
            Top = 21
            Width = 77
            Height = 15
            Caption = 'Current States:'
          end
          object chkEnableEvents: TCheckBox
            Left = 1
            Top = 1
            Width = 191
            Height = 19
            Caption = 'Enable Events'
            TabOrder = 0
            OnClick = chkEnableEventsClick
          end
          object edtStates: TEdit
            Left = 1
            Top = 36
            Width = 1010
            Height = 23
            Anchors = [akLeft, akTop, akRight]
            ReadOnly = True
            TabOrder = 1
          end
        end
      end
      object tabDebug: TTabSheet
        Caption = 'Debug'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel10: TPanel
          Left = 0
          Top = 0
          Width = 1013
          Height = 19
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object chkDebugLog: TCheckBox
            Left = 0
            Top = 0
            Width = 145
            Height = 19
            Caption = 'Debug Mode'
            TabOrder = 0
            OnClick = OnCommonControlPropertyChange
          end
        end
      end
    end
  end
  object ImageList1: TImageList
    DrawingStyle = dsTransparent
    Left = 48
    Top = 264
    Bitmap = {
      494C010106000900040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E
      46FF2F3E46FF2F3E46FF2F3E46FF000000000000000000000000000000000000
      000000000000000000000D0D5BBF1717A3FF1717A3FF0D0D5BBF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF658396FF658396FF658396FF5D798BFF5B6C77FF4F64
      71FF445A67FF3F535EFF2F3E46FF0000000000000000929292FF929292FF9292
      92FF929292FF929292FF1717A3FF8484F6FF5F5FEDFF1717A3FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E
      46FF2F3E46FF2F3E46FF2F3E46FF0000000000000000929292FF000000000000
      000000000000000000000D0D5BBF1717A3FF1717A3FF0D0D5BBF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF679FC1FF679FC1FF679FC1FF6195B5FF658398FF6A87
      9AFF517791FF446D88FF2F3E46FF0000000000000000929292FF000000000000
      00000000000000000000174F17BF2A8F29FF2A8F29FF174F17BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E
      46FF2F3E46FF2F3E46FF2F3E46FF0000000000000000929292FF929292FF9292
      92FF929292FF929292FF2A8F29FF87E087FF60CC60FF2A8F29FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF658396FF658396FF658396FF5D798BFF5B6C77FF4F64
      71FF445A67FF3F535EFF2F3E46FF0000000000000000929292FF000000000000
      00000000000000000000174F17BF2A8F29FF2A8F29FF174F17BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E46FF2F3E
      46FF2F3E46FF2F3E46FF2F3E46FF0000000000000000929292FF000000000000
      00000000000000000000115B81BF1EA4E7FF1EA4E7FF115B81BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000928F8FFF928F8FFF0000000000000000000000000000
      0000928F8FFF928F8FFF000000000000000000000000929292FF929292FF9292
      92FF929292FF929292FF1EA4E7FF56FFFFFF23FFFFFF1EA4E7FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000928F8FFF928F8FFF0000000000000000000000000000
      0000928F8FFF928F8FFF000000000000000000000000929292FF000000000000
      00000000000000000000115B81BF1EA4E7FF1EA4E7FF115B81BF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000404040AF928F8FFF1818187000000000000000001818
      1870928F8FFF444242AF0000000000000000552300BF9A3F00FF9A3F00FF5523
      00BF00000000000000000000000000000000000000000000000000000000041D
      06940C5713FF041D069400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000008080840928F8FFF928F8FFF928F8FFF928F8FFF928F
      8FFF928F8FFF0808084000000000000000009A3F00FFEAC83AFFDCA216FF9A3F
      00FF000000000000000000000000000000000000000000000000000000000C57
      13FF21BB29FF0C5713FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000C0C0C506D6C6CDF928F8FFF928F8FFF7979
      79DF0C0C0C50000000000000000000000000552300BF9A3F00FF9A3F00FF5523
      00BF0000000000000000000000000000000000000000041D06940C5713FF0C57
      13FF5DCD5EFF0C5713FF0C5713FF041D06940000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C5713FFABEEADFFA5EA
      A6FF80E07EFF60D462FF16B11DFF0C5713FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000041D06940C5713FF0C57
      13FF9FE7A0FF0C5713FF0C5713FF041D06940000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000C57
      13FFA1E8A3FF0C5713FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000041D
      06940C5713FF041D069400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001B1D58BF3B3EA9FF2D2F8DEF0101053000000000000000001313
      3D9F3234A1FF2A2D8BEF03030A40000000000000000000000000000000000000
      000012121260484747BF818080FF818080FF818080FF818080FF484747BF1212
      1260000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000202169CF7174D8FF5A5DC5FF13133D9F00000000000000001B1D
      58BF4C4FBAFF393CA7FF0F10318F000000000000000000000000020202205454
      54CF8B7368FF95573DFF903613FF8E2C08FF8E2C08FF913714FF985B40FF876E
      64FF545454CF0202022000000000000000002B2B2B99787878FF787878FF7878
      78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF7878
      78FF787878FF787878FF787878FF2B2B2B99000000000009125D155BD8FF0320
      429F000102200000000000000000000000000000000000000000000000000001
      0220031F429F1158D8FF0009125D000000000000000000000000000000000000
      0000000002203F41ACFF8689E7FF8287E6FF3437A4FF3234A0FF1B1D58BF2E30
      8FEF5D62C9FF5255BFFF202169CF000000000000000002020220707070EF935F
      49FF90340EFFA33F0CFFD38642FFEEC181FFEFC689FFD48A4AFFA3400EFF9638
      12FF936149FF707070EF0202022000000000787878FFE5E5E5FFEDEDEDFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDED
      EDFFE2E2E2FFDCDCDCFFD3D3D3FF787878FF00000000000204301761E7FF2482
      FFFF1D5FBBEF0316298000000010000000000000000000000010031529801B58
      BBEF217CFFFF135CE7FF0002043000000000000000000000001013133D9F3538
      94EF464AB1FF777CD8FF9196EBFF9196EBFF4548B1FF6265C7FF6467C7FF4144
      ADFF4B4FB8FF6266CCFF3A3DA9FF0000000000000000545454CF95614AFF9331
      08FFC4590CFFEF9929FFF7BB46FFFBCF5CFFFBD161FFF8C04CFFF09D2FFFC255
      0AFF973309FF95634BFF545454CF00000000787878FFE5E5E5FF787878FF7878
      78FF787878FF787878FF787878FFEDEDEDFFEDEDEDFF787878FF787878FF7878
      78FF787878FF787878FFD3D3D3FF787878FF0000000000000000083C7CCF2197
      FFFF24A6FFFF309CF7FF185D9BDF010C1660010C1660185AAEEF297AF7FF1C8A
      FFFF197AFFFF05367CCF000000000000000000000010202169CF666AC9FF999F
      EBFF9CA3EBFF9EA5EBFF969CEAFF9CA3EBFF474BB1FF6E74D3FF6F74D4FF6A6D
      D1FF4043AFFF6F74D8FF474AB5FF06071660121212608C7468FF90330EFFBF51
      09FFCB6512FF933714FF933714FF933714FF933714FF933714FF933714FFCE67
      11FFBB4705FF963712FF886E64FF12121260787878FFE5E5E5FF787878FF1B1A
      18FF17202EFF468E96FF787878FFFAFAFAFFFAFAFAFF787878FF9A4A83FFB480
      55FF5B5082FF787878FFD5D5D5FF787878FF0000000000000000000C166027AA
      F7FF29BCFFFF2BBDFFFF2FBBFFFF32AAF7FF2EA1F7FF27A3FFFF1E9AFFFF1A90
      FFFF1364F7FF000A166000000000000000001B1D58BF5155BAFF5C61C0FFA1AA
      EBFFACB5EEFFAFB8EEFF9DA4EBFFA1AAEBFF4F53B6FF8990E0FF8A90E2FF8388
      E1FF4346B0FF7C81E1FF676BD1FF252779DF484747BF955539FF9F3404FFC557
      0BFF933714FFD8C0B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8C0B5FF9337
      14FFC55108FF9C2D02FF9A5D42FF484747BF787878FFE7E7E7FF787878FF5B93
      95FF24373EFF42878BFF787878FFFAFAFAFFFAFAFAFF787878FFC09A79FF978B
      69FF887166FF787878FFD8D8D8FF787878FF0000000000000000000000101E7F
      B5EF3DC6FFFF3DC6FFFF3BC6FFFF35C4FFFF2EC0FFFF27BBFFFF22ACFFFF1B91
      FFFF0647B5EF0000001000000000000000003D40AAFF8C92E2FFA4ACEBFFB0BB
      EBFFB0BBEBFFB2BFEBFFA4ACEBFF9CA4EAFFA9B4EAFFA7B1EBFFA1AAEBFF99A0
      EBFF9196EBFF888BE9FF7477DCFF3B3EAAFF818080FF903713FFC15208FF9E37
      07FF933714FFFFFFFFFFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFFFFFFFFF9337
      14FFA43C08FFB53800FF923915FF818080FF787878FFEAEAEAFF787878FF7878
      78FF787878FF787878FF787878FFFAFAFAFFFAFAFAFF787878FF787878FF7878
      78FF787878FF787878FFDCDCDCFF787878FF0000000000000000000000000426
      3D9F69D8FFFF53D0FFFF52D0FFFF4ACCFFFF40C9FFFF32C2FFFF27BBFFFF1288
      FFFF001D3D9F0000000000000000000000001B1D58BF5458B7FFBBC2EFFF3031
      40FFB6C2EBFF848CD5FF7981CCFFB0BAEDFFB7C4EDFFB1BDEBFFAAB4EBFFA1A9
      EBFF989EEBFF8F93EBFF7D82E3FF28297DDF818080FF8E2C06FFC2550AFF8723
      03FF933714FFFFFFFFFFBDBDBDFFBDBDBDFFBDBDBDFFBDBDBDFFFFFFFFFF9337
      14FF8B2703FFB23500FF8E2B06FF818080FF787878FFEDEDEDFFEDEDEDFFEDED
      EDFFEDEDEDFFEDEDEDFFEDEDEDFFFAFAFAFFFAFAFAFFE9E9E9FFE9E9E9FFE9E9
      E9FFE6E6E6FFE6E6E6FFE0E0E0FF787878FF0000000000000000000408406AA1
      BBEF92E5FFFF68DAFFFF67D9FFFF5ED5FFFF51CFFFFF40C7FFFF2FC0FFFF179F
      FFFF0453BBEF00040840000000000000000000000000090A1E705B5FBAFFCCD5
      F3FFCCD5F3FFA7B0EBFF555ABFFFC0CCF0FFBCC9EFFFB7C4EDFFB0BCEBFFA7B0
      EBFF9EA5EBFF9599EBFF6E72D5FF13133D9F818080FF8E2C07FFE3AD7DFFB161
      36FF933714FFFFFFFFFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFFFFFFFFF9337
      14FFB16237FFDC9A69FF8E2B06FF818080FF787878FFF0F0F0FF787878FF7878
      78FF787878FF787878FF787878FFFAFAFAFFFAFAFAFF787878FF787878FF7878
      78FF787878FF787878FFE1E1E1FF787878FF00000000030D166093C7E0FFB1F0
      FFFFA1EFFFFF9CEEFFFF7EE6FFFF6CDDFFFF5FD5FFFF4CCCFFFF37C4FFFF29BC
      FFFF1691FFFF0455E0FF000A16600000000000000000000000000F10318F4E53
      B2FFADB6E3FF6367CAFF8489E0FFDAE2F8FFD7DEF8FFC9D3F4FFB6C2EDFFABB5
      EBFFA0A9EBFF9299EAFF4F52BCFF04050F50818080FF923815FFD79F74FFB873
      4DFF933714FFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFF9337
      14FFBA7551FFD39065FF913714FF818080FF787878FFF3F3F3FF787878FF0063
      9FFF004571FF003069FF787878FFFAFAFAFFFAFAFAFF787878FF347243FF3C78
      5CFF4C8F77FF787878FFE3E3E3FF787878FF091D2A7FA1D1E7FFA4EBFFFFA5EE
      FFFFB1F2FFFFB5F7FFFFADF6FFFF9EEFFFFF83E3FFFF62D4FFFF3EC6FFFF2CBD
      FFFF23ADFFFF178AFFFF044DE7FF001C429F0000000000000000000000000101
      05302D2F7EDF3639A4FFA1A7E2FFE2E9FBFFE1E7FBFFDAE2FBFFCED7F6FFACB6
      EBFFA1ABEBFF7C82DAFF3437A3FF01010530484747BF995C41FFA65129FFD5A3
      80FF933714FFD8C0B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8C0B5FF9337
      14FFD39872FFA54C24FF985B40FF484747BF787878FFF6F6F6FF787878FF007D
      F8FF006DE2FF002C33FF787878FFFAFAFAFFFAFAFAFF787878FF5FA152FF5991
      47FF56833FFF787878FFE7E7E7FF787878FF416981CC89C4E0FF8CC4E0FF92C6
      E0FF93C7E0FFB8E2EFFFBCF6FFFFA0F0FFFF88EBFFFF7AE2FFFF54C1EFFF229F
      E0FF1592E0FF0C72E0FF0A64E0FF0A64E0FF0000000000000000000000000000
      000001010530303290EF7D86CEFFB6C1EBFFC5D0F2FFC1CCF0FFB5C0EDFFAAB4
      EBFF7379CEFF393CA6FF3335A1FF2D2F8DEF12121260876E64FF973C17FFD098
      75FFBF805EFF933714FF933714FF933714FF933714FF933714FF933714FFBC7C
      59FFCC8B62FF913612FF8E7569FF12121260787878FFFAFAFAFF787878FF7878
      78FF787878FF787878FF787878FFFAFAFAFFFAFAFAFF787878FF787878FF7878
      78FF787878FF787878FFEAEAEAFF787878FF0000000000000000000000000000
      000000000000071A2880D4F7FFFFA1EEFFFF83EAFFFF73E1FFFF08283F9F0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000100C0D2880142F71DE324292FF3E4F98FF3250A1FF1B1D
      58BF2A2D8CEF3B3FA7FF5B61BFFF3F41ABFF00000000545454CF95624BFF993E
      18FFD09C7AFFDCB59DFFC99781FFC6957CFFC6957CFFC99882FFDAAF93FFCE90
      68FF963A15FF95614AFF545454CF00000000787878FFFAFAFAFFFAFAFAFFFAFA
      FAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFA
      FAFFF7F7F7FFF2F2F2FFEAEAEAFF787878FF0000000000000000000000000000
      000000000000000102209CC7E0FF9EEBFFFF7AE7FFFF55B7E0FF000102200000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000108FB1FF82C4CBFF82C4CBFF0E80A4FF0000
      0000000000101718409F575CB7FF0C0D28800000000002020220707070EF9361
      49FF963B16FFA7532DFFD9AA8BFFE6C5ABFFE6C2A6FFD7A581FFA65129FF9136
      12FF905D46FF707070EF0202022000000000787878FFA0A0A0FFA0A0A0FFA0A0
      A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0A0FFA0A0
      A0FFA0A0A0FFA0A0A0FFA0A0A0FF787878FF0000000000000000000000000000
      0000000000000000000031556CBF9FEAFFFF76E3FFFF1D4F6CBF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000040634108FB1FF0E80A4FF000406340000
      0000000000000000000000000000000000000000000000000000020202205454
      54CF876D63FF96563AFF913714FF8E2C08FF8E2C08FF8F3612FF93573DFF8971
      65FF545454CF0202022000000000000000002B2B2B99787878FF787878FF7878
      78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF7878
      78FF787878FF787878FF787878FF2B2B2B990000000000000000000000000000
      00000000000000000000000A136082D1EFFF6ACEF3FF000A1360000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000012121260484747BF818080FF818080FF818080FF818080FF484747BF1212
      1260000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001A445EB211384FA600000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object ImageList2: TImageList
    DrawingStyle = dsTransparent
    Left = 128
    Top = 264
    Bitmap = {
      494C010102000500040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000A3D0CA324802EDB001500610000
      0003000000000000000000000000000000000000000000000000000000000000
      00000000000000000000030A3780182A92CB2846CAEA183AC0E40D38C2E40A3C
      C3E40F43C4E4124AC7E41554D2EA03185F9E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000349C41F47BE2A6FF37C65EFF064F
      0DB3000500320000000000000000000000000000000000000000000000000000
      000000000000000000001B2B8ECC5E77F2FF5D85FFFF346DFFFF1C69FFFF2078
      FFFF2C8FFFFF36A2FFFF3BAFFFFF1451D2EC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002A8D35EF5ED185FF3BCF6EFF3BD8
      72FF22A93FF20227038100000012000000000000000000000000000000000000
      00000000000000000000172480C64F69EEFF4972FFFF215CFFFF125DFFFF1D6F
      FFFF2682FFFF2C90FFFF339DFFFF1046C2E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000288631ED58CB7BFF30C25EFF33CE
      67FF40DC79FF3BD46BFF106E1DCF000A00470000000000000000000000000000
      0000000000000000000017217BC64F66E9FF466DFFFF1C56FFFF0F57FFFF1968
      FFFF2076FFFF247EFFFF298BFFFF0D3DBEE60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000298131ED5BC679FF30BB58FF2AC3
      5AFF31CB64FF39D570FF44E483FF117E21E30000000000000000000000000000
      00000000000000000000171F77C65265E4FF496DFEFF1F52FFFF0B4CFFFF125B
      FFFF1867FFFF1A6CFFFF1E75FFFF0A35B9E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002B7E32ED66C47EFF3AB65AFF27B6
      4FFF2BC15AFF30C963FF22AF44FD022503870000000000000000000000000000
      00000000000000000000181E73C65969DEFF5573F7FF2954FDFF0C45FFFF094A
      FFFF1056FFFF125BFFFF1462FFFF072CB4E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000317C35EC78C58AFF4FB565FF3EB8
      5FFF24AB44FF085811CA00090046000000000000000000000000000000000000
      000000000000000000001B1E6DC66670D8FF677EF0FF3D5EF4FF1D4AFDFF083F
      FFFF0441FFFF0745FFFF084CFFFF0321B0E60000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000408542F0A1D6ACFF6ABB79FF2883
      32EF001A01790000000E00000000000000000000000000000000000000000000
      00000000000000000000242672CB8187DBFF8B9BF0FF5E76EFFF4061F6FF2751
      FDFF1445FFFF0C41FFFF0F48FFFF0620B4EB0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002A622AD782BA86FF0C370DAD0003
      002C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010104DAD5E61BCF97A82D8FF5965D5FF4556D7FF354B
      DAFF2A43DEFF223DDFFF2443E3FF08127CCF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000822088B19491ABF000600420000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000010118670F104BAB222372CB171B6BC614176CC61014
      6CC60D136DC60C116DC60C1375CB01022A810000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.ctlf'
    Filter = 'Chrome Tabs Look and Feel (*.ctlf)|*.ctlf|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Look and Feel'
    Left = 128
    Top = 400
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.ctlf'
    Filter = 'Chrome Tabs Look and Feel (*.ctlf)|*.ctlf|All Files (*.*)|*.*'
    Title = 'Load Look and Feel'
    Left = 48
    Top = 400
  end
  object ActionList1: TActionList
    Left = 48
    Top = 328
    object actLoadLookAndFeel: TAction
      Caption = 'Load Look and Feel'
      OnExecute = actLoadLookAndFeelExecute
    end
    object actSaveLookandFeel: TAction
      Caption = 'Save Look and Feel'
      OnExecute = actSaveLookandFeelExecute
    end
    object actLoadOptions: TAction
      Caption = 'Load Options'
      OnExecute = actLoadOptionsExecute
    end
    object actSaveOptions: TAction
      Caption = 'Save Options'
      OnExecute = actSaveOptionsExecute
    end
    object actCopyOptionsAsCode: TAction
      Caption = 'Copy Options as Code'
      OnExecute = actCopyOptionsAsCodeExecute
    end
    object actCopyLookAndFeelAsCode: TAction
      Caption = 'Copy Look and Feel as Code'
      OnExecute = actCopyLookAndFeelAsCodeExecute
    end
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = '.ctop'
    Filter = 'Chrome Tabs Options (*.ctop)|*.ctop|All Files (*.*)|*.*'
    Title = 'Load Look and Feel'
    Left = 48
    Top = 464
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.ctop'
    Filter = 'Chrome Tabs Options (*.ctop)|*.ctop|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Look and Feel'
    Left = 128
    Top = 464
  end
  object ApplicationEvents1: TApplicationEvents
    OnDeactivate = ApplicationEvents1Deactivate
    OnMessage = ApplicationEvents1Message
    Left = 128
    Top = 328
  end
end
