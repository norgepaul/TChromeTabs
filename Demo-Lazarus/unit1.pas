unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ChromeTabs, ChromeTabsTypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ImageList4: TImageList;
    procedure FormCreate(Sender: TObject);
  private
    ChromeTabs1: TChromeTabs;
    ChromeTabs2: TChromeTabs;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  ChromeTabs1 := TChromeTabs.Create(Self);

  ChromeTabs1.Name := 'ChromeTabs1';
  ChromeTabs1.Parent := Self;
  ChromeTabs1.Left := 0;
  ChromeTabs1.Top := 0;
  ChromeTabs1.Width := 1017;
  ChromeTabs1.Height := 27;
  //ChromeTabs1.OnActiveTabChanging := ChromeTabs1ActiveTabChanging;
  //ChromeTabs1.OnChange := ChromeTabs1Change;
  //ChromeTabs1.OnActiveTabChanged := ChromeTabs1ActiveTabChanged;
  //ChromeTabs1.OnDebugLog := ChromeTabs1DebugLog;
  //ChromeTabs1.OnButtonAddClick := ChromeTabs1ButtonAddClick;
  //ChromeTabs1.OnNeedDragImageControl := ChromeTabs1NeedDragImageControl;
  //ChromeTabs1.OnBeforeDrawItem := ChromeTabs1BeforeDrawItem;
  //ChromeTabs1.OnGetControlPolygons := ChromeTabs1GetControlPolygons;
  //ChromeTabs1.OnTabDragDrop := ChromeTabs1TabDragDrop;
  //ChromeTabs1.OnTabDragDropped := ChromeTabs1TabDragDropped;
  //ChromeTabs1.OnScroll := ChromeTabs1ScrollWidthChanged;
  //ChromeTabs1.OnScrollWidthChanged := ChromeTabs1ScrollWidthChanged;
  //ChromeTabs1.OnSetTabWidth := ChromeTabs1SetTabWidth;
  ChromeTabs1.Images := ImageList1;
  ChromeTabs1.ImagesOverlay := ImageList2;
  ChromeTabs1.ImagesSpinnerUpload := ImageList3;
  ChromeTabs1.ImagesSpinnerDownload := ImageList4;
  with ChromeTabs1.Tabs.Add do begin
    Caption := 'Chrome Tab 1';
    Active := True;
    Tag := 0;
    ImageIndex := 3;
    ImageIndexOverlay := -1;
    Pinned := False;
    Visible := True;
    Modified := False;
    SpinnerState := tssRenderedDownload;
    HideCloseButton := False;
  end;
  with ChromeTabs1.Tabs.Add do begin
    Caption := 'Chrome Tab 2';
    Active := False;
    Tag := 0;
    ImageIndex := -1;
    ImageIndexOverlay := -1;
    Pinned := False;
    Visible := True;
    Modified := False;
    SpinnerState := tssNone;
    HideCloseButton := False;
  end;
  ChromeTabs1.Align := alTop;
  ChromeTabs1.TabOrder := 0;
  //ChromeTabs1.OnMouseEnter := ChromeTabs1MouseEnter;
  //ChromeTabs1.OnMouseLeave := ChromeTabs1MouseLeave;
  ChromeTabs1.ActiveTabIndex := 0;

  ChromeTabs2 := TChromeTabs.Create(Self);
  ChromeTabs2.Name := 'ChromeTabs2';
  ChromeTabs2.Parent := Self;
  ChromeTabs2.Left := 0;
  ChromeTabs2.Top := 575;
  ChromeTabs2.Width := 1017;
  ChromeTabs2.Height := 31;
  //ChromeTabs2.OnChange := ChromeTabs1Change;
  //ChromeTabs2.OnActiveTabChanged := ChromeTabs1ActiveTabChanged;
  //ChromeTabs2.OnDebugLog := ChromeTabs1DebugLog;
  //ChromeTabs2.OnButtonAddClick := ChromeTabs1ButtonAddClick;
  //ChromeTabs2.OnButtonCloseTabClick := ChromeTabs1ButtonCloseTabClick;
  //ChromeTabs2.OnNeedDragImageControl := ChromeTabs1NeedDragImageControl;
  //ChromeTabs2.OnAfterDrawItem := ChromeTabs2AfterDrawItem;
  //ChromeTabs2.OnShowHint := ChromeTabs1ShowHint;
  //ChromeTabs2.OnTabDragDrop := ChromeTabs2TabDragDrop;
  ChromeTabs2.ActiveTabIndex := -1;
  ChromeTabs2.Images := ImageList1;
  ChromeTabs2.ImagesOverlay := ImageList2;
  ChromeTabs2.ImagesSpinnerUpload := ImageList4;
  ChromeTabs2.ImagesSpinnerDownload := ImageList3;
  ChromeTabs2.Align := alBottom;
  ChromeTabs2.TabOrder := 2;
end;

end.

