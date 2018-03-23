unit ChromeTabsUtils;

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

{.$DEFINE USE_PNGIMAGE} // <-- Enable this define if you want to use an external
                        //     copy of pngImage in Delphi 2008 or earlier

uses
  {$IF CompilerVersion >= 23.0}
  System.SysUtils, System.Classes, System.Types, System.Math,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.GraphUtil, Vcl.ImgList,
  WinApi.Windows, WinApi.Messages, WinApi.ActiveX,
  Vcl.Graphics,
  {$ELSE}
  SysUtils, Classes, Math,
  Controls, ExtCtrls, Forms, GraphUtil, ImgList,
  Windows, Messages, ActiveX,
  Graphics,
  {$IFEND}

  {$IFDEF USE_PNGIMAGE}
  pngImage,
  {$ENDIF}

  GDIPObj, GDIPAPI,

  ChromeTabsTypes;

function MakeGDIPColor(C: TColor; Alpha: Byte): Cardinal;
function PointInPolygon(Polygon: TPolygon; X, Y: Integer): Boolean;
function SameRect(Rect1, Rect2: TRect): Boolean;
function ColorBetween(const ColorA, ColorB: TColor; const Percent: Integer): TColor;
function IntegerBetween(const IntA, IntB: Integer; const Percent: Integer): Integer;
function SingleBetween(const SingA, SingB: Single; const Percent: Integer): Single;
procedure PaintControlToCanvas(SrcControl: TControl; TargetCanvas: TCanvas);
procedure CopyControlToBitmap(AWinControl: TWinControl; Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; X, Y: Integer);
function ImageListToTGPImage(ImageList: TCustomImageList; ImageIndex: Integer): TGPImage;
function ChromeTabStatesToString(States: TChromeTabStates): String;
function RectToGPRectF(ARect: TRect): TGPRectF;
function RectToGPRect(ARect: TRect): TGPRect;
function PointToGPPoint(Pt: TPoint): TGPPoint;
function IconToGPImage(Icon: TIcon): TGPImage;
function BitmapToGPBitmap(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap): TGPBitmap;
function GeneratePolygon(ControlRect: TRect; const PolygonPoints: Array of TPoint; Orientation: TTabOrientation): TPolygon;
function CreateAlphaBlendForm(AOwner: TComponent; Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; Alpha: Byte): TForm;
procedure SetTabClipRegionFromPolygon(GPGraphics: TGPGraphics; Polygon: TPolygon; CombineMode: TCombineMode);
procedure ClearBitmap(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap);
procedure ScaleImage(Bitmap, ScaledBitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; ScaleFactor: Real);
procedure EnableControlAndChildren(Control: TWinControl; DoEnable: Boolean);
procedure SaveComponentToStream(AComponent: TComponent; AStream: TStream);
procedure ReadComponentFromStream(AComponent: TComponent; AStream: TStream);
function ContrastingColor(Color: TColor): TColor;
function ComponentToCode(AComponent: TComponent; const ComponentName: String): String;
function HorzFlipRect(ParentRect, ChildRect: TRect): TRect;
function HorzFlipPolygon(ParentRect: TRect; Polygon: TPolygon): TPolygon;
function RectHeight(Rect: TRect): Integer;
function RectWidth(Rect: TRect): Integer;
function RectInflate(ARect: TRect; Value: Integer): TRect;
procedure BitmapTo32BitBitmap(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap);
procedure SetColorAlpha(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; AColor: TColor; NewAlpha: Byte);
function TransformRect(StartRect, EndRect: TRect; CurrentTicks, EndTicks: Cardinal; EaseType: TChromeTabsEaseType): TRect;
function CalculateEase(CurrentTime, StartValue, ChangeInValue, Duration: Real; EaseType: TChromeTabsEaseType): Real; overload;
function CalculateEase(StartPos, EndPos, PositionPct: Real; EaseType: TChromeTabsEaseType): Real; overload;

implementation

function CalculateEase(CurrentTime, StartValue, ChangeInValue, Duration: Real; EaseType: TChromeTabsEaseType): Real;
begin
  case EaseType of
    ttNone:
      begin
        Result := 0;
      end;

    ttLinearTween:
      begin
        Result := ChangeInValue * CurrentTime / Duration + StartValue;
      end;

    ttEaseInQuad:
      begin
        CurrentTime := CurrentTime / Duration;

	      Result := ChangeInValue * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutQuad:
      begin
        CurrentTime := CurrentTime / Duration;

	      Result := -ChangeInValue * CurrentTime * (CurrentTime-2) + StartValue;
      end;

    ttEaseInOutQuad:
      begin
        CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 1;
          Result := -ChangeInValue / 2 * (CurrentTime * (CurrentTime - 2) - 1) + StartValue;
        end;
      end;

    ttEaseInCubic:
      begin
        CurrentTime := CurrentTime / Duration;

        Result := ChangeInValue * CurrentTime * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutCubic:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

        Result := ChangeInValue * ( CurrentTime * CurrentTime * CurrentTime + 1) + StartValue;
      end;

    ttEaseInOutCubic:
      begin
        CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 2;

          Result := ChangeInValue / 2 * (CurrentTime * CurrentTime * CurrentTime + 2) + StartValue;
        end;
      end;

    ttEaseInQuart:
      begin
        CurrentTime := CurrentTime / Duration;

        Result := ChangeInValue * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutQuart:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

        Result := -ChangeInValue * (CurrentTime * CurrentTime * CurrentTime * CurrentTime - 1) + StartValue;
      end;

    ttEaseInOutQuart:
      begin
	      CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 2;

          Result := -ChangeInValue / 2 * (CurrentTime * CurrentTime * CurrentTime * CurrentTime - 2) + StartValue;
        end;
      end;

    ttEaseInQuint:
      begin
        CurrentTime := CurrentTime / Duration;

        Result := ChangeInValue * CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue;
      end;

    ttEaseOutQuint:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

	      Result := ChangeInValue * (CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + 1) + StartValue;
      end;

    ttEaseInOutQuint:
      begin
      	CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := ChangeInValue / 2 * CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + StartValue
        else
        begin
          CurrentTime := CurrentTime - 2;

          Result := ChangeInValue / 2 * (CurrentTime * CurrentTime * CurrentTime * CurrentTime * CurrentTime + 2) + StartValue;
        end;
      end;

    ttEaseInSine:
      begin
	      Result := -ChangeInValue * Cos(CurrentTime / Duration * (PI / 2)) + ChangeInValue + StartValue;
      end;

    ttEaseOutSine:
      begin
	      Result := ChangeInValue * Sin(CurrentTime / Duration * (PI / 2)) + StartValue;
      end;

    ttEaseInOutSine:
      begin
        Result := -ChangeInValue / 2 * (Cos(PI * CurrentTime / Duration) - 1) + StartValue;
      end;

    ttEaseInExpo:
      begin
        Result := ChangeInValue * Power(2, 10 * (CurrentTime / Duration - 1) ) + StartValue;
      end;

    ttEaseOutExpo:
      begin
        Result := ChangeInValue * (-Power(2, -10 * CurrentTime / Duration ) + 1 ) + StartValue;
      end;

    ttEaseInOutExpo:
      begin
        CurrentTime := CurrentTime / (Duration/2);

	      if CurrentTime < 1 then
          Result := ChangeInValue / 2 * Power(2, 10 * (CurrentTime - 1) ) + StartValue
        else
         begin
           CurrentTime := CurrentTime - 1;

	         Result := ChangeInValue / 2 * (-Power(2, -10 * CurrentTime) + 2 ) + StartValue;
         end;
      end;

    ttEaseInCirc:
      begin
        CurrentTime := CurrentTime / Duration;

	      Result := -ChangeInValue * (Sqrt(1 - CurrentTime * CurrentTime) - 1) + StartValue;
      end;

    ttEaseOutCirc:
      begin
        CurrentTime := (CurrentTime / Duration) - 1;

        Result := ChangeInValue * Sqrt(1 - CurrentTime * CurrentTime) + StartValue;
      end;

    ttEaseInOutCirc:
      begin
        CurrentTime := CurrentTime / (Duration / 2);

        if CurrentTime < 1 then
          Result := -ChangeInValue / 2 * (Sqrt(1 - CurrentTime * CurrentTime) - 1) + StartValue
        else
        begin
        	CurrentTime := CurrentTime - 2;

	        Result := ChangeInValue / 2 * (Sqrt(1 - CurrentTime * CurrentTime) + 1) + StartValue;
        end;
      end;

    else
    begin
      Result := 0;

      Assert(FALSE, 'Invalid Ease Type');
    end;
  end;
end;

function CalculateEase(StartPos, EndPos, PositionPct: Real; EaseType: TChromeTabsEaseType): Real;
var
  t, b, c, d: Real;
begin
  c := EndPos - StartPos;
  d := 100;
  t := PositionPct;
  b := StartPos;

  Result := CalculateEase(t, b, c, d, EaseType);
end;

function TransformRect(StartRect, EndRect: TRect; CurrentTicks, EndTicks: Cardinal; EaseType: TChromeTabsEaseType): TRect;

  function TransformInteger(StartInt, EndInt: Integer): Integer;
  begin
    TransformInteger := Round(CalculateEase(CurrentTicks, StartInt, EndInt - StartInt, EndTicks, EaseType));
  end;

begin
  Result.Left := TransformInteger(StartRect.Left, EndRect.Left);
  Result.Top := TransformInteger(StartRect.Top, EndRect.Top);
  Result.Right := TransformInteger(StartRect.Right, EndRect.Right);
  Result.Bottom := TransformInteger(StartRect.Bottom, EndRect.Bottom);
end;

function HorzFlipRect(ParentRect, ChildRect: TRect): TRect;
begin
  Result := Rect(ParentRect.Left + ParentRect.Right - ChildRect.Right,
                 ChildRect.Top,
                 ParentRect.Left + ParentRect.Right - ChildRect.Left,
                 ChildRect.Bottom);
end;

function HorzFlipPolygon(ParentRect: TRect; Polygon: TPolygon): TPolygon;
var
  i: Integer;
begin
  Result := Polygon;

  for i := Low(Polygon) to High(Polygon) do
    Polygon[i].X := ParentRect.Left + ParentRect.Right - Polygon[i].X;
end;

function ContrastingColor(Color: TColor): TColor;
begin
  Color := ColorToRGB(Color);

  Result := (Color+$000080) and $0000FF +
            (Color+$008000) and $00FF00 +
            (Color+$800000) and $FF0000;
end;

procedure SaveComponentToStream(AComponent: TComponent; AStream: TStream);
var
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  try
    MemStream.WriteComponent(AComponent);
    MemStream.Position := 0;

    ObjectBinaryToText(MemStream, AStream);
  finally
    FreeAndNil(MemStream);
  end;
end;

procedure ReadComponentFromStream(AComponent: TComponent; AStream: TStream);
var
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  try
    ObjectTextToBinary(AStream, MemStream);
    MemStream.Position := 0;

    MemStream.ReadComponent(AComponent);
  finally
    FreeAndNil(MemStream);
  end;
end;

function ComponentToCode(AComponent: TComponent; const ComponentName: String): String;
var
  CodeStrings: TStringList;
  StringStream: TStringStream;
  i: Integer;
begin
  StringStream := TStringStream.Create('');
  CodeStrings := TStringList.Create;
  try
    SaveComponentToStream(AComponent, StringStream);
    StringStream.Position := 0;

    CodeStrings.LoadFromStream(StringStream);

    if CodeStrings.Count <= 2 then
      Result := ''
    else
    begin
      // Remove the top and bottom lines
      CodeStrings.Delete(0);
      CodeStrings.Delete(CodeStrings.Count - 1);

      // Format the code
      for i := 0 to pred(CodeStrings.Count) do
        CodeStrings[i] := ComponentName + '.' + StringReplace(Trim(CodeStrings[i]), ' = ', ' := ', [rfReplaceAll, rfIgnoreCase]) + ';';

      Result := CodeStrings.Text;
    end;
  finally
    FreeAndNil(CodeStrings);
    FreeAndNil(StringStream);
  end;
end;

function RectHeight(Rect: TRect): Integer;
begin
  Result := Rect.Bottom - Rect.Top;
end;

function RectWidth(Rect: TRect): Integer;
begin
  Result := Rect.Right - Rect.Left;
end;

procedure ClearBitmap(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap);
var
  Graphics: TGPGraphics;
  Brush: TGPBrush;
begin
  Graphics := TGPGraphics.Create(Bitmap.Handle);
  try
    Brush := TGPLinearGradientBrush.Create(MakePoint(0, 0),
                                               MakePoint(0, Bitmap.Height),
                                               MakeGDIPColor(clBlack, 0),
                                               MakeGDIPColor(clBlack, 0));
    try
      Graphics.FillRectangle(Brush, 0, 0, Bitmap.Width, Bitmap.Height);
    finally
      FreeAndNil(Brush);
    end;
  finally
    FreeAndNil(Graphics);
  end;
end;

procedure ScaleImage(Bitmap, ScaledBitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; ScaleFactor: Real);
{$IF CompilerVersion < 18.0}
var
  NewHeight, NewWidth: Integer;
{$IFEND}
begin
  {$IF CompilerVersion >= 18.0} //{$IFDEF DELPHI2006_UP}
    {$IF CompilerVersion >= 23.0}Vcl.{$IFEND}GraphUtil.ScaleImage(Bitmap, ScaledBitmap, ScaleFactor);
  {$ELSE}
    NewWidth := Round(Bitmap.Width * ScaleFactor);
    NewHeight := Round(Bitmap.Height * ScaleFactor);

    ScaledBitmap.Width := NewWidth;
    ScaledBitmap.Height := NewHeight;

    ScaledBitmap.Canvas.StretchDraw(Rect(0, 0, NewWidth, NewHeight), Bitmap);
  {$IFEND}
end;

procedure SetTabClipRegionFromPolygon(GPGraphics: TGPGraphics; Polygon: TPolygon; CombineMode: TCombineMode);
var
  TabPathPolygon: PGPPoint;
  TabPath: TGPGraphicsPath;
begin
  TabPathPolygon := PGPPoint(Polygon);

  // Create a clip region so we don't draw outside the tab
  TabPath := TGPGraphicsPath.Create;
  try
    TabPath.AddPolygon(TabPathPolygon, length(Polygon));

    GPGraphics.SetClip(TabPath, CombineMode);
  finally
    FreeAndNil(TabPath);
  end;
end;

function GeneratePolygon(ControlRect: TRect; const PolygonPoints: Array of TPoint; Orientation: TTabOrientation): TPolygon;
var
  i: Integer;
begin
  SetLength(Result, length(PolygonPoints));

  for i := low(PolygonPoints) to High(PolygonPoints) do
  begin
    case Orientation of
      toTop: Result[i] := Point(PolygonPoints[i].X + ControlRect.Left,
                                PolygonPoints[i].Y + ControlRect.Top);

      toBottom: Result[i] := Point(PolygonPoints[i].X + ControlRect.Left,
                                  (RectHeight(ControlRect) - PolygonPoints[i].Y) + ControlRect.Top - 1);
    end;
  end;
end;

function RectInflate(ARect: TRect; Value: Integer): TRect;
begin
  Result := Rect(ARect.Left + Value,
                 ARect.Top + Value,
                 ARect.Right - Value,
                 ARect.Bottom - Value);
end;

function RectToGPRectF(ARect: TRect): TGPRectF;
begin
  Result.X := ARect.Left;
  Result.Y := ARect.Top;
  Result.Width := RectWidth(ARect);
  Result.Height := RectHeight(ARect);
end;

function RectToGPRect(ARect: TRect): TGPRect;
begin
  Result.X := ARect.Left;
  Result.Y := ARect.Top;
  Result.Width := RectWidth(ARect);
  Result.Height := RectHeight(ARect);
end;

function PointToGPPoint(Pt: TPoint): TGPPoint;
begin
  Result.X := Pt.X;
  Result.Y := Pt.Y;
end;

procedure EnableControlAndChildren(Control: TWinControl; DoEnable: Boolean);
var
  i: Integer;
begin
  Control.Enabled := DoEnable;

  for i := 0 to Control.ControlCount - 1 do
    if Control.Controls[i] is TWinControl then
      EnableControlAndChildren(Control.Controls[i] as TWinControl, DoEnable);
end;

function ChromeTabStatesToString(States: TChromeTabStates): String;
var
  s: TChromeTabState;
begin
  Result := '';

  for s := Low(TChromeTabState) to High(TChromeTabState) do
    if s in States then
    begin
      if Result <> '' then
        Result := Result + ',';

      Result := Result + ChromeTabStateDescriptions[s];
    end;
end;

function IconToGPImage(Icon: TIcon): TGPImage;
var
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  try
    Icon.SaveToStream(MemStream);

    MemStream.Position := 0;
  except
    FreeAndNil(MemStream);

    raise;
  end;

  Result := TGPImage.Create(TStreamAdapter.Create(MemStream, soOwned));
end;

function BitmapToGPBitmap(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap): TGPBitmap;
var
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  try
    Bitmap.SaveToStream(MemStream);

    MemStream.Position := 0;
  except
    FreeAndNil(MemStream);

    raise;
  end;

  Result := TGPBitmap.Create(TStreamAdapter.Create(MemStream, soOwned));
end;

{$IFDEF USE_PNGIMAGE}
function ImageListToTGPImage(ImageList: TCustomImageList; ImageIndex: Integer): TGPImage;
var
  Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap;
  PNGObject: {$IF CompilerVersion >= 28}TPNGImage{$ELSE}TPNGObject{$IFEND};
  Stream: TStream;
begin
  Stream := TMemoryStream.Create;
  try
    PNGObject := {$IF CompilerVersion >= 28}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
    try
      Bitmap := {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap.Create;
      try
        ImageList.GetBitmap(ImageIndex, Bitmap);

        Bitmap.Transparent := True;
        PNGObject.Assign(Bitmap);
      finally
        FreeAndNil(Bitmap);
      end;

      PNGObject.SaveToStream(Stream);
      Stream.Position := 0;
    finally
      FreeAndNil(PNGObject);
    end;
  except
    FreeAndNil(Stream);

    raise;
  end;

  Result := TGPBitmap.Create(TStreamAdapter.Create(Stream, soOwned));
end;
{$ELSE}
function ImageListToTGPImage(ImageList: TCustomImageList; ImageIndex: Integer): TGPImage;
var
  Icon: TIcon;
begin
  Icon := TIcon.Create;
  try
    ImageList.GetIcon(ImageIndex, Icon);
    Icon.Transparent := TRUE;

    Result := IconToGPImage(Icon);
  finally
    FreeAndNil(Icon);
  end;
end;
{$ENDIF}

procedure CopyControlToBitmap(AWinControl: TWinControl; Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; X, Y: Integer);
var
 SrcDC: HDC;
begin
  SrcDC := GetDC(AWinControl.Handle);
  try
    BitBlt(Bitmap.Canvas.Handle, X, Y, AWinControl.ClientWidth, AWinControl.ClientHeight, SrcDC, 0, 0, SRCCOPY);
  finally
     ReleaseDC(AWinControl.Handle, SrcDC);
  end;
end;

procedure PaintControlToCanvas(SrcControl: TControl; TargetCanvas: TCanvas);
var
  SaveIndex: Integer;
  DC: HDC;
  Position: TPoint;
begin
  if SrcControl.Parent <> nil then
  begin
    DC := TargetCanvas.Handle;

    SaveIndex := SaveDC(DC);
    try
      GetViewportOrgEx(DC, Position);

      SetViewportOrgEx(DC, Position.x - SrcControl.Left, Position.y - SrcControl.Top, nil);

      IntersectClipRect(DC, 0, 0, SrcControl.Parent.ClientWidth, SrcControl.Parent.ClientHeight);

      SrcControl.Parent.Perform(WM_ERASEBKGND, WParam(DC), 0);
      SrcControl.Parent.Perform(WM_PAINT, WParam(DC), 0);
    finally
      RestoreDC(DC, SaveIndex);
    end;
  end;
end;

function IntegerBetween(const IntA, IntB: Integer; const Percent: Integer): Integer;
begin
  Result := Percent * (IntB - IntA) div 100 + IntA;
end;

function SingleBetween(const SingA, SingB: Single; const Percent: Integer): Single;
begin
  Result := Percent * (SingB - SingA) / 100 + SingA;
end;

function ColorBetween(const ColorA, ColorB: TColor; const Percent: Integer): TColor;
var
  R1, G1, B1: Byte;
  R2, G2, B2: Byte;
begin
  R1:= GetRValue(ColorA);
  G1:= GetGValue(ColorA);
  B1:= GetBValue(ColorA);
  R2:= GetRValue(ColorB);
  G2:= GetGValue(ColorB);
  B2:= GetBValue(ColorB);

  Result:= RGB(Percent * (R2-R1) div 100 + R1,
               Percent * (G2-G1) div 100 + G1,
               Percent * (B2-B1) div 100 + B1);
end;

function SameRect(Rect1, Rect2: TRect): Boolean;
begin
  Result := (Rect1.Left = Rect2.Left) and
            (Rect1.Top = Rect2.Top) and
            (Rect1.Right = Rect2.Right) and
            (Rect1.Bottom = Rect2.Bottom);
end;

function MakeGDIPColor(C: TColor; Alpha: Byte): Cardinal;
var
  tmpRGB : TColorRef;
begin
  tmpRGB := ColorToRGB(C);

  result := ((DWORD(GetBValue(tmpRGB)) shl  BlueShift) or
             (DWORD(GetGValue(tmpRGB)) shl GreenShift) or
             (DWORD(GetRValue(tmpRGB)) shl   RedShift) or
             (DWORD(Alpha) shl AlphaShift));
end;

function PointInPolygon(Polygon: TPolygon; X, Y: Integer): Boolean;
var
  Count, i, n: Integer;
begin
  Result := FALSE;

  Count := Length(Polygon);

  n := pred(Count);

  for i := 0 to pred(Count) do
  begin
    if ((Polygon[i].y <= y) and
        (y < Polygon[n].y)) or
       ((Polygon[n].y <= y) and
        (y < Polygon[i].y)) then
    begin
      if (x < (Polygon[n].x - Polygon[i].x) *
         (y - Polygon[i].y) / (Polygon[n].y - Polygon[i].y) +
         Polygon[i].x) then
        Result := not Result;
    end;

    n := i;
  end;
end;

procedure BitmapTo32BitBitmap(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap);
var
  PNGBitmap: TGPBitmap;
  BitmapHandle: HBITMAP;
  Stream: TMemoryStream;
  StreamAdapter: IStream;
begin
  Stream := TMemoryStream.Create;
  try
    Bitmap.SaveToStream(Stream);

    // Wrap the VCL stream in a COM IStream
    StreamAdapter := TStreamAdapter.Create(Stream);
    try
      // Create and load a GDI+ bitmap from the stream
      PNGBitmap := TGPBitmap.Create(StreamAdapter);
      try
        // Convert the PNG to a 32 bit bitmap
        PNGBitmap.GetHBITMAP(MakeColor(0,0,0,0), BitmapHandle);

        // Wrap the bitmap in a VCL TBitmap
        Bitmap.Handle := BitmapHandle;
      finally
        FreeAndNil(PNGBitmap);
      end;
    finally
      StreamAdapter := nil;
    end;
  finally
    FreeAndNil(Stream);
  end;
end;

procedure SetColorAlpha(Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; AColor: TColor; NewAlpha: Byte);
var
  Row, Col: integer;
  p: PRGBQuad;
  PreMult: array[byte, byte] of byte;
begin
  // precalculate all possible values of a*b
  for Row := 0 to 255 do
    for Col := Row to 255 do
    begin
      PreMult[Row, Col] := Row*Col div 255;

      if (Row <> Col) then
        PreMult[Col, Row] := PreMult[Row, Col]; // a*b = b*a
    end;

  for Row := 0 to pred(Bitmap.Height) do
  begin
    Col := Bitmap.Width;

    p := Bitmap.ScanLine[Row];

    while (Col > 0) do
    begin
      if (GetRed(AColor) = p.rgbRed) and
         (GetBlue(AColor) = p.rgbBlue) and
         (GetGreen(AColor) = p.rgbGreen) then
      begin
        p.rgbReserved := NewAlpha;

        p.rgbBlue := PreMult[p.rgbReserved, p.rgbBlue];
        p.rgbGreen := PreMult[p.rgbReserved, p.rgbGreen];
        p.rgbRed := PreMult[p.rgbReserved, p.rgbRed];
      end;

      inc(p);
      dec(Col);
    end;
  end;
end;

// Thanks to Anders Melander for the transparent form tutorial
// (http://melander.dk/articles/alphasplash2/2/)
function CreateAlphaBlendForm(AOwner: TComponent; Bitmap: {$IF CompilerVersion >= 23.0}Vcl.Graphics.{$IFEND}TBitmap; Alpha: Byte): TForm;
var
  BlendFunction: TBlendFunction;
  BitmapPos: TPoint;
  BitmapSize: TSize;
  exStyle: DWORD;
begin
  Result := TForm.Create(AOwner);

  // Enable window layering
  exStyle := GetWindowLongA(Result.Handle, GWL_EXSTYLE);

  if (exStyle and WS_EX_LAYERED = 0) then
    SetWindowLong(Result.Handle, GWL_EXSTYLE, exStyle or WS_EX_LAYERED);

  // Resize form to fit bitmap
  Result.ClientWidth := Bitmap.Width;
  Result.ClientHeight := Bitmap.Height;

  // Position bitmap on form
  BitmapPos := Point(0, 0);
  BitmapSize.cx := Bitmap.Width;
  BitmapSize.cy := Bitmap.Height;

  // Setup alpha blending parameters
  BlendFunction.BlendOp := AC_SRC_OVER;
  BlendFunction.BlendFlags := 0;
  BlendFunction.SourceConstantAlpha := Alpha;
  BlendFunction.AlphaFormat := AC_SRC_ALPHA;

  UpdateLayeredWindow(Result.Handle, 0, nil, @BitmapSize, Bitmap.Canvas.Handle,
    @BitmapPos, 0, @BlendFunction, ULW_ALPHA);
end;

end.
