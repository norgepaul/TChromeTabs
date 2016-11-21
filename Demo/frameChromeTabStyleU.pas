unit frameChromeTabStyleU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  Spin, ExtCtrls, Buttons,

  GDIPAPI,

  ChromeTabs,
  ChromeTabsUtils,
  ChromeTabsClasses;

type
  TframeChromeTabStyle = class(TFrame)
    ColorDialog1: TColorDialog;
    gbBrush: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtAlphaStart: TSpinEdit;
    edtAlphaStop: TSpinEdit;
    Button1: TBitBtn;
    Button2: TBitBtn;
    colStart: TPanel;
    colStop: TPanel;
    gbPen: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    edtOutlineWidth: TSpinEdit;
    edtOutlineAlpha: TSpinEdit;
    Button3: TBitBtn;
    colOutline: TPanel;
    gbFont: TGroupBox;
    chkUseDefaultFont: TCheckBox;
    pnlFont: TPanel;
    cbFontHintMode: TComboBox;
    edtFontAlpha: TSpinEdit;
    edtFontSize: TSpinEdit;
    cbFontName: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Button4: TBitBtn;
    colFont: TPanel;
    Label8: TLabel;
    gbModified: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtCentreAlpha: TSpinEdit;
    edtOutsideAlpha: TSpinEdit;
    Button5: TBitBtn;
    Button6: TBitBtn;
    colCentre: TPanel;
    colOutside: TPanel;
    Label17: TLabel;
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure OnSelectColorClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure colStartChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure chkUseDefaultFontClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure colStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    FOnStartColorPicking: TNotifyEvent;
    FUpdating: Boolean;
    FChromeTabLookAndFeelStyle: TChromeTabsLookAndFeelStyle;
    FChromeTabLookAndFeelPen: TChromeTabsLookAndFeelPen;
    FChromeTabFont: TChromeTabsLookAndFeelBaseFont;
    FChromeTabsLookAndFeelTabModified: TChromeTabsLookAndFeelGlow;
    FPreviousColor: TColor;
    FColorPickPanel: TPanel;
    FChromeTabs: TChromeTabs;

    procedure SetColor(ColorPanel: TPanel; Color: TColor; UpdateChromeTabs: Boolean);
    function SelectColor(ColorBox: TPanel): Boolean;
    procedure GUIToChromeTabLookAndFeelStyle;
    procedure ChromeTabLookAndFeelStyleToGUI;
    procedure SetChromeTabLookAndFeelStyle(const Value: TChromeTabsLookAndFeelStyle);
    procedure SetChromeTabLookAndFeelPen(const Value: TChromeTabsLookAndFeelPen);
    procedure SetChromeTabFont(const Value: TChromeTabsLookAndFeelBaseFont);
    procedure UpdateControls;
    procedure SetChromeTabsLookAndFeelTabModified(const Value: TChromeTabsLookAndFeelGlow);
    procedure StartColourPicking(Panel: TPanel);
  public
    constructor Create(AOwner: TComponent; ChromeTabs: TChromeTabs); reintroduce; virtual;

    procedure StopColorPicking(Cancelled: Boolean);

    property ChromeTabLookAndFeelStyle: TChromeTabsLookAndFeelStyle read FChromeTabLookAndFeelStyle write SetChromeTabLookAndFeelStyle;
    property ChromeTabLookAndFeelPen: TChromeTabsLookAndFeelPen read FChromeTabLookAndFeelPen write SetChromeTabLookAndFeelPen;
    property ChromeTabFont: TChromeTabsLookAndFeelBaseFont read FChromeTabFont write SetChromeTabFont;
    property ChromeTabsLookAndFeelTabModified: TChromeTabsLookAndFeelGlow read FChromeTabsLookAndFeelTabModified write SetChromeTabsLookAndFeelTabModified;

    property OnStartColorPicking: TNotifyEvent read FOnStartColorPicking write FOnStartColorPicking;
  end;

implementation

{$R *.dfm}

procedure TframeChromeTabStyle.BitBtn1Click(Sender: TObject);
begin
  StartColourPicking(colStart);
end;

procedure TframeChromeTabStyle.BitBtn2Click(Sender: TObject);
begin
  StartColourPicking(colStop);
end;

procedure TframeChromeTabStyle.BitBtn3Click(Sender: TObject);
begin
  StartColourPicking(colOutline);
end;

procedure TframeChromeTabStyle.BitBtn4Click(Sender: TObject);
begin
  StartColourPicking(colFont);
end;

procedure TframeChromeTabStyle.BitBtn5Click(Sender: TObject);
begin
  StartColourPicking(colCentre);
end;

procedure TframeChromeTabStyle.BitBtn6Click(Sender: TObject);
begin
  StartColourPicking(colOutside);
end;

procedure TframeChromeTabStyle.Button2Click(Sender: TObject);
begin
  SelectColor(colStop);
end;

procedure TframeChromeTabStyle.Button3Click(Sender: TObject);
begin
  SelectColor(colOutline);
end;

procedure TframeChromeTabStyle.Button4Click(Sender: TObject);
begin
  SelectColor(colFont);
end;

procedure TframeChromeTabStyle.Button5Click(Sender: TObject);
begin
  SelectColor(colCentre);
end;

procedure TframeChromeTabStyle.Button6Click(Sender: TObject);
begin
  SelectColor(colOutside);
end;

procedure TframeChromeTabStyle.chkUseDefaultFontClick(Sender: TObject);
begin
  UpdateControls;

  GUIToChromeTabLookAndFeelStyle;
end;

procedure TframeChromeTabStyle.UpdateControls;
begin
  chkUseDefaultFont.Visible := FChromeTabFont is TChromeTabsLookAndFeelFont;

  EnableControlAndChildren(pnlFont, (not chkUseDefaultFont.Checked) or (not chkUseDefaultFont.Visible));
end;

procedure TframeChromeTabStyle.colStartChange(Sender: TObject);
begin
  GUIToChromeTabLookAndFeelStyle;
end;

function GetPixelColourAsColor(const PixelCoords: TPoint): TColor;
var
  dc: HDC;
begin
  // Get Device Context of windows desktop
  dc := GetDC(0);
  // Read the color of the pixel at the given coordinates
  Result := GetPixel(dc,PixelCoords.X,PixelCoords.Y);
end;

procedure TframeChromeTabStyle.colStartClick(Sender: TObject);
begin
  StartColourPicking(TPanel(Sender));
end;

procedure TframeChromeTabStyle.StartColourPicking(Panel: TPanel);
begin
  FPreviousColor := Panel.Color;
  FColorPickPanel := Panel;

  Timer1.Enabled := TRUE;

  if Assigned(FOnStartColorPicking) then
    FOnStartColorPicking(Self);
end;

constructor TframeChromeTabStyle.Create(AOwner: TComponent; ChromeTabs: TChromeTabs);
begin
  inherited Create(AOwner);

  FChromeTabs := ChromeTabs;

  cbFontName.Items.Assign(Screen.Fonts);
end;

procedure TframeChromeTabStyle.StopColorPicking(Cancelled: Boolean);
begin
  Timer1.Enabled := FALSE;

  if Cancelled then
    SetColor(FColorPickPanel, FPreviousColor, FALSE)
  else
    GUIToChromeTabLookAndFeelStyle;
end;

procedure TframeChromeTabStyle.ChromeTabLookAndFeelStyleToGUI;
begin
  if not FUpdating then
  begin
    FUpdating := TRUE;
    try
      if FChromeTabLookAndFeelStyle <> nil then
      begin
        SetColor(colStart, FChromeTabLookAndFeelStyle.StartColor, TRUE);
        SetColor(colStop, FChromeTabLookAndFeelStyle.StopColor, TRUE);
        edtAlphaStart.Value := FChromeTabLookAndFeelStyle.StartAlpha;
        edtAlphaStop.Value := FChromeTabLookAndFeelStyle.StopAlpha;
        SetColor(colOutline, FChromeTabLookAndFeelStyle.OutlineColor, TRUE);
        edtOutlineWidth.Value := Round(FChromeTabLookAndFeelStyle.OutlineSize);
        edtOutlineAlpha.Value := FChromeTabLookAndFeelStyle.OutlineAlpha;
      end;

      if FChromeTabLookAndFeelPen <> nil then
      begin
        SetColor(colOutline, FChromeTabLookAndFeelPen.Color, TRUE);
        edtOutlineWidth.Value := Round(FChromeTabLookAndFeelPen.Thickness);
        edtOutlineAlpha.Value := FChromeTabLookAndFeelPen.Alpha;
      end;

      if FChromeTabFont <> nil then
      begin
        cbFontHintMode.ItemIndex := Integer(FChromeTabFont.TextRenderingMode);
        cbFontName.Text := FChromeTabFont.Name;
        edtFontAlpha.Value := FChromeTabFont.Alpha;
        edtFontSize.Value := FChromeTabFont.Size;
        cbFontName.Text := FChromeTabFont.Name;
        SetColor(colFont, FChromeTabFont.Color, TRUE);

        if FChromeTabFont is TChromeTabsLookAndFeelFont then
          chkUseDefaultFont.Checked := TChromeTabsLookAndFeelFont(FChromeTabFont).UseDefaultFont
        else
        begin
          pnlFont.Align := alTop;
          chkUseDefaultFont.Visible := FALSE;
        end;

        UpdateControls;
      end;

      if FChromeTabsLookAndFeelTabModified <> nil then
      begin
        SetColor(colCentre, FChromeTabsLookAndFeelTabModified.CentreColor, TRUE);
        SetColor(colOutside, FChromeTabsLookAndFeelTabModified.OutsideColor, TRUE);
        edtCentreAlpha.Value := FChromeTabsLookAndFeelTabModified.CentreAlpha;
        edtOutsideAlpha.Value := FChromeTabsLookAndFeelTabModified.OutsideAlpha;
      end;
    finally
      FUpdating := FALSE;
    end;
  end;
end;

procedure TframeChromeTabStyle.GUIToChromeTabLookAndFeelStyle;
begin
  if not FUpdating then
  begin
    FChromeTabs.BeginUpdate;
    try
      if FChromeTabLookAndFeelStyle <> nil then
      begin
        FChromeTabLookAndFeelStyle.StartColor := colStart.Color;
        FChromeTabLookAndFeelStyle.StopColor := colStop.Color;
        FChromeTabLookAndFeelStyle.StartAlpha := edtAlphaStart.Value;
        FChromeTabLookAndFeelStyle.StopAlpha := edtAlphaStop.Value;
        FChromeTabLookAndFeelStyle.OutlineColor := colOutline.Color;
        FChromeTabLookAndFeelStyle.OutlineSize := edtOutlineWidth.Value;
        FChromeTabLookAndFeelStyle.OutlineAlpha := edtOutlineAlpha.Value;
      end;

      if FChromeTabLookAndFeelPen <> nil then
      begin
        FChromeTabLookAndFeelPen.Color := colOutline.Color;
        FChromeTabLookAndFeelPen.Thickness := edtOutlineWidth.Value;
        FChromeTabLookAndFeelPen.Alpha := edtOutlineAlpha.Value;
      end;

      if FChromeTabFont <> nil then
      begin
        FChromeTabFont.TextRenderingMode := TTextRenderingHint(cbFontHintMode.ItemIndex);
        FChromeTabFont.Name := cbFontName.Text;
        FChromeTabFont.Alpha := edtFontAlpha.Value;
        FChromeTabFont.Size := edtFontSize.Value;
        FChromeTabFont.Name := cbFontName.Text;
        FChromeTabFont.Color := colFont.Color;

        if FChromeTabFont is TChromeTabsLookAndFeelFont then
          TChromeTabsLookAndFeelFont(FChromeTabFont).UseDefaultFont := chkUseDefaultFont.Checked;
      end;

      if FChromeTabsLookAndFeelTabModified <> nil then
      begin
        FChromeTabsLookAndFeelTabModified.CentreColor := colCentre.Color;
        FChromeTabsLookAndFeelTabModified.OutsideColor := colOutside.Color;
        FChromeTabsLookAndFeelTabModified.CentreAlpha := edtCentreAlpha.Value;
        FChromeTabsLookAndFeelTabModified.OutsideAlpha := edtOutsideAlpha.Value;
      end;
    finally
      FChromeTabs.EndUpdate;
    end;
  end;
end;

procedure TframeChromeTabStyle.OnSelectColorClick(Sender: TObject);
begin
  SelectColor(colStart);
end;

function TframeChromeTabStyle.SelectColor(ColorBox: TPanel): Boolean;
begin
  ColorDialog1.Color := ColorBox.Color;

  Result := ColorDialog1.Execute;

  if Result then
    SetColor(ColorBox, ColorDialog1.Color, TRUE);
end;

procedure TframeChromeTabStyle.SetColor(ColorPanel: TPanel; Color: TColor; UpdateChromeTabs: Boolean);
var
  r,g,b: Byte;
begin
  ColorPanel.Color := Color;

  // Convert the Delphi TColor value to it's RGB components
  r := Color and $FF;
  g := (Color shr 8) and $FF;
  b := (Color shr 16) and $FF;

  ColorPanel.Caption := '$00' + IntToHex(r, 2) + IntToHex(g, 2) + IntToHex(b, 2);
  ColorPanel.Color := Color;
  ColorPanel.Font.Color := ContrastingColor(Color);

  if UpdateChromeTabs then
    GUIToChromeTabLookAndFeelStyle;
end;

procedure TframeChromeTabStyle.SetChromeTabFont(
  const Value: TChromeTabsLookAndFeelBaseFont);
begin
  FChromeTabFont := Value;

  gbFont.Visible := TRUE;

  ChromeTabLookAndFeelStyleToGUI;
end;

procedure TframeChromeTabStyle.SetChromeTabLookAndFeelPen(
  const Value: TChromeTabsLookAndFeelPen);
begin
  FChromeTabLookAndFeelPen := Value;

  gbPen.Visible := TRUE;

  ChromeTabLookAndFeelStyleToGUI;
end;

procedure TframeChromeTabStyle.SetChromeTabLookAndFeelStyle(
  const Value: TChromeTabsLookAndFeelStyle);
begin
  FChromeTabLookAndFeelStyle := Value;

  gbBrush.Visible := TRUE;
  gbPen.Visible := TRUE;

  ChromeTabLookAndFeelStyleToGUI;
end;

procedure TframeChromeTabStyle.SetChromeTabsLookAndFeelTabModified(
  const Value: TChromeTabsLookAndFeelGlow);
begin
  FChromeTabsLookAndFeelTabModified := Value;

  gbModified.Visible := TRUE;

  ChromeTabLookAndFeelStyleToGUI;
end;

procedure TframeChromeTabStyle.Timer1Timer(Sender: TObject);
var
  col: TColor;
begin
  Col := GetPixelColourAsColor(Mouse.CursorPos);

  SetColor(FColorPickPanel, Col, FALSE);
end;

end.
