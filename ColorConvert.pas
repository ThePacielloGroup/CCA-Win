unit ColorConvert;

interface
uses
    Windows,Graphics, Math, SysUtils, Dialogs;

type

    EColorError = CLASS(Exception);
const
    PROTANOPIA: Integer = 0;
    DEUTERANOPIA: Integer = 1;
    TRITANOPIA: Integer = 2;
    RGBtoLMS: array[0..2, 0..2] of Double = ((0.05059983, 0.08585369, 0.00952420), (0.01893033, 0.08925308, 0.01370054), (0.00292202, 0.00975732, 0.07145979));
    LMStoRGB: array[0..2, 0..2] of Double = ((30.830854, -29.832659, 1.610474), (-6.481468, 17.715578, -2.532642), (-0.375690, -1.199062, 14.273846));
    Gamma: array [0..2] of Double = (2.1 , 2.0, 2.1);
    WL475nm: array [0..2] of Double = (0.08, 0.16, 0.59);
    WL485nm: array [0..2] of Double = (0.13, 0.22, 0.36);
    WL575nm: array [0..2] of Double = (0.99, 0.73, 0.0);
    WL660nm: array [0..2] of Double = (0.09, 0.0, 0.0);
    
    function ColortoHex(Color: TColor; ResIsRGB: Boolean = True): String;
    function ColortoHex2(Color: TColor; ResIsRGB: Boolean = True): String;
    function HexToColor(RGBHex: String; HexIsRGB: Boolean = True): TColor;
    function IsHex(RGBHex: String): Boolean;
    function ByteToColor(R: Byte; G: Byte; B: Byte): TColor;
    function ConvertDichromatColors(Color: TColor; DichromatType: Integer): TColor;
    procedure ConvertDichromatFromRGB(var Red: Byte; var Green: byte; var Blue: Byte; const DichromatType: Integer);
    procedure Convert_P(sRed, sGreen, sBlue: Byte; var dRed: Byte; var dGreen: byte; var dBlue: Byte);
    procedure Convert_D(sRed, sGreen, sBlue: Byte; var dRed: Byte; var dGreen: byte; var dBlue: Byte);
    procedure Convert_T(sRed, sGreen, sBlue: Byte; var dRed: Byte; var dGreen: byte; var dBlue: Byte);
implementation

function ByteToColor(R: Byte; G: Byte; B: Byte): TColor;
begin
    Result := StringToColor('$' + IntToHex(B, 2) + IntToHex(G, 2) + IntToHex(R, 2));
end;

function ColortoHex(Color: TColor; ResIsRGB: Boolean = True): String;
var
    RGBColor : LongInt;
    R, G, B: Integer;
begin
    RGBColor := ColorToRGB(Color);
    R := ($000000FF and RGBColor);
    G := ($0000FF00 and RGBColor) shr 8;
    B := ($00FF0000 and RGBColor) shr 16;
    if ResIsRGB Then
        Result := '$' + IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2)
    else
        Result := '$' + IntToHex(B, 2) + IntToHex(G, 2) + IntToHex(R, 2);
end;

function ColortoHex2(Color: TColor; ResIsRGB: Boolean = True): String;
var
    RGBColor : LongInt;
    R, G, B: Integer;
begin
    RGBColor := ColorToRGB(Color);
    R := ($000000FF and RGBColor);
    G := ($0000FF00 and RGBColor) shr 8;
    B := ($00FF0000 and RGBColor) shr 16;
    if ResIsRGB Then
        Result := '#' + IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2)
    else
        Result := '#' + IntToHex(B, 2) + IntToHex(G, 2) + IntToHex(R, 2);
end;

function HexToColor(RGBHex: String; HexIsRGB: Boolean = True): TColor;
var
    d, R, G, B: String;
begin
    if not IsHex(RGBHex) then
        Raise EConvertError.Create('This value is invalid hex value.: ' + RGBHex);
    d := RGBHex;
    if (Copy(d, 1, 1) = '#') or (Copy(d, 1, 1) = '$') then
        Delete(d, 1, 1);
    R := Copy(d, 1, 2);
    G := Copy(d, 3, 2);
    B := Copy(d, 5, 2);
    if not HexIsRGB then
        Result := StringToColor('$' + R + G + B)
    else
        Result := StringToColor('$' + B + G + R);
end;

function IsHex(RGBHex: String): Boolean;
var
    d, R, G, B: String;
    i: Integer;
begin
    Result := True;
    d := RGBHex;
    if (Copy(d, 1, 1) = '#') or (Copy(d, Length(d), 1) = '$') then
        Delete(d, 1, 1);
    R := '$' + Copy(d, 1, 2);
    G := '$' + Copy(d, 3, 2);
    B := '$' + Copy(d, 5, 2);
    try
        i := StrToInt(R);
        if (i > 255) and (i < 0) then
        begin
            Result := False;
        end;
    except
        on EConvertError do
        begin
            Result := False;
        end;
    end;
    try
        i := StrToInt(G);
        if (i > 255) and (i < 0) then
        begin
            Result := False;
        end;
    except
        on EConvertError do
        begin
            Result := False;
        end;
    end;
    try
        i := StrToInt(B);
        if (i > 255) and (i < 0) then
        begin
            Result := False;
        end;
    except
        on EConvertError do
        begin
            Result := False;
        end;
    end;
end;


function ConvertDichromatColors(Color: TColor; DichromatType: Integer): TColor;
var
    RGBColor : LongInt;
    R, G, B, a, t: Double;
    a1, b1, c1, a2, b2, c2, OldR, OldG: Double;
const
	Le = 0.14597772;
	Me = 0.12188395;
	Se = 0.08413913;
begin
    //DicromatType
    //PROTANOPIA = 0;
    //DEUTERANOPIA = 1;
    //TRITANOPIA = 2;
    //Le := RGBtoLMS[0, 0] + RGBtoLMS[0, 1] + RGBtoLMS[0, 2];
    //Me := RGBtoLMS[1, 0] + RGBtoLMS[1, 1] + RGBtoLMS[1, 2];
    //Se := RGBtoLMS[2, 0] + RGBtoLMS[2, 1] + RGBtoLMS[2, 2];

    RGBColor := ColorToRGB(Color);
    R := ($000000FF and RGBColor);
    G := ($0000FF00 and RGBColor) shr 8;
    B := ($00FF0000 and RGBColor) shr 16;

    try
        R := Power(R / 255, Gamma[0]);
    except
        R := 0;
    end;
    try
        G := Power(G / 255, Gamma[1]);
    except
        G := 0;
    end;
    try
        B := Power(B / 255, Gamma[2]);
    except
        B := 0;
    end;

    OldR := R;
    OldG := G;

    R := OldR * RGBtoLMS[0, 0] + OldG * RGBtoLMS[0, 1] + B * RGBtoLMS[0, 2];
    G := OldR * RGBtoLMS[1, 0] + OldG * RGBtoLMS[1, 1] + B * RGBtoLMS[1, 2];
    B := OldR * RGBtoLMS[2, 0] + OldG * RGBtoLMS[2, 1] + B * RGBtoLMS[2, 2];
    if (DichromatType = 0) or (DichromatType = 1) then
    begin
        //575nm
        a1 := -0.0614;
        b1 := 0.0833;
        c1 := -0.0141;
        //a1 := Me * WL575nm[2] - Se * WL575nm[1];
        //b1 := Se * WL575nm[0] - Le * WL575nm[2];
        //c1 := Le * WL575nm[1] - Me * WL575nm[0];
        //475nm
        a2 := 0.0584;
        b2 := -0.0794;
        c2 := 0.0136;
        {a2 := Me * WL475nm[2] - Se * WL475nm[1];
        b2 := Se * WL475nm[0] - Le * WL475nm[2];
        c2 := Le * WL475nm[1] - Me * WL475nm[0];}
    end
    else
    begin
        //660nm
        a1 := 0;
        b1 := 0.0076;
        c1 := -0.011;
        {a1 := Me * WL660nm[2] - Se * WL660nm[1];
        b1 := Se * WL660nm[0] - Le * WL660nm[2];
        c1 := Le * WL660nm[1] - Me * WL660nm[0];}
        //485nm
        a2 := 0.0254;
        b2 := -0.0416;
        c2 := 0.0163;
        {a2 := Me * WL485nm[2] - Se * WL485nm[1];
        b2 := Se * WL485nm[0] - Le * WL485nm[2];
        c2 := Le * WL485nm[1] - Me * WL485nm[0];}
    end;

    if DichromatType = 0 then //PROTANOPIA
    begin
        try
            if G > 0 then
                a := B / G
            else
                a := 0;
        except
            on EMathError do
                a := 0;
        end;
        try
            if Me > 0 then
                t := 0.6903//(Se / Me)
            else
                t := 0;
        except
            on EMathError do
                t := 0;
        end;
        try
            if a < t then
                R := -(b1 * G + c1 * B) / a1
            else
                R := -(b2 * G + c2 * B) / a2;
        except
            on EMathError do
                R := 0;
        end;
    end
    else if DichromatType = 1 then //DEUTERANOPIA
    begin
        try
            if R > 0 then
                a := B / R
            else
                a := 0;
        except
            on EMathError do
                a := 0;
        end;
        try
            if Le > 0 then
                t := 0.5764//(Se / Le)
            else
                t := 0;
        except
            on EMathError do
                t := 0;
        end;
        try
            if a < t then
                G := -(a1 * R + c1 * B) / b1
            else
                G := -(a2 * R + c2 * B) / b2;
        except
            on EMathError do
                G := 0;
        end;
    end
    else  //TRITANOPIA
    begin
        try
            if R > 0 then
                a := G / R
            else
                a := 0;
        except
            on EMathError do
                a := 0;
        end;
        try
            if Le > 0 then
                t := 0.8349//(Me / Le)
            else
                t := 0;
        except
            on EMathError do
                t := 0;
        end;
        try
            if a < t then
                B := -(a1 * R + b1 * G) / c1
            else
                B := -(a2 * R + b2 * G) / c2;
        except
            on EMathError do
                B := 0;
        end;
    end;
    OldR := R;
    OldG := G;
    R := OldR * LMStoRGB[0, 0] + OldG * LMStoRGB[0, 1] + B * LMStoRGB[0, 2];
    G := OldR * LMStoRGB[1, 0] + OldG * LMStoRGB[1, 1] + B * LMStoRGB[1, 2];
    B := OldR * LMStoRGB[2, 0] + OldG * LMStoRGB[2, 1] + B * LMStoRGB[2, 2];
    try
        if R > 0 then
            R := 255 * Power(R, 0.476190476)
        else
            R := 0;
    except
        on EMathError do
            R := 0;
    end;
    try
        if G > 0 then
            G := 255 * Power(G, 0.5)
        else
            G := 0;
    except
        on EMathError do
            G := 0;
    end;
    try
        if B > 0 then
            B := 255 * Power(B, 0.476190476)
        else
            B := 0;
    except
        on EMathError do
            B := 0;
    end;
    R := EnsureRange(R, 0, 255);
    G := EnsureRange(G, 0, 255);
    B := EnsureRange(B, 0, 255);
    //Showmessage('$' + IntToHex(Floor(Int(R)), 2) + IntToHex(Floor(Int(G)), 2) + IntToHex(Floor(Int(B)), 2));
    Result := StringToColor('$00' + IntToHex(Floor(B), 2) + IntToHex(Floor(G), 2) + IntToHex(Floor(R), 2));
end;

procedure Convert_P(sRed, sGreen, sBlue: Byte; var dRed: Byte; var dGreen: byte; var dBlue: Byte);
var
    R, G, B, a, t: Double;
    a1, b1, c1, a2, b2, c2, OldR, OldG: Double;
const
	Le = 0.14597772;
	Me = 0.12188395;
	Se = 0.08413913;
begin
    //DicromatType
    //PROTANOPIA = 0;
    //DEUTERANOPIA = 1;
    //TRITANOPIA = 2;
    {Le := RGBtoLMS[0, 0] + RGBtoLMS[0, 1] + RGBtoLMS[0, 2];
    Me := RGBtoLMS[1, 0] + RGBtoLMS[1, 1] + RGBtoLMS[1, 2];
    Se := RGBtoLMS[2, 0] + RGBtoLMS[2, 1] + RGBtoLMS[2, 2];}

    R := sRed;
    G := sGreen;
    B := sBlue;

    try
        R := Power(R / 255, Gamma[0]);
    except
        R := 0;
    end;
    try
        G := Power(G / 255, Gamma[1]);
    except
        G := 0;
    end;
    try
        B := Power(B / 255, Gamma[2]);
    except
        B := 0;
    end;

    OldR := R;
    OldG := G;

    R := OldR * RGBtoLMS[0, 0] + OldG * RGBtoLMS[0, 1] + B * RGBtoLMS[0, 2];
    G := OldR * RGBtoLMS[1, 0] + OldG * RGBtoLMS[1, 1] + B * RGBtoLMS[1, 2];
    B := OldR * RGBtoLMS[2, 0] + OldG * RGBtoLMS[2, 1] + B * RGBtoLMS[2, 2];

        //575nm
        a1 := -0.0614;
        b1 := 0.0833;
        c1 := -0.0141;
        //a1 := Me * WL575nm[2] - Se * WL575nm[1];
        //b1 := Se * WL575nm[0] - Le * WL575nm[2];
        //c1 := Le * WL575nm[1] - Me * WL575nm[0];
        //475nm
        a2 := 0.0584;
        b2 := -0.0794;
        c2 := 0.0136;
        {a2 := Me * WL475nm[2] - Se * WL475nm[1];
        b2 := Se * WL475nm[0] - Le * WL475nm[2];
        c2 := Le * WL475nm[1] - Me * WL475nm[0];}



        try
            a := B / G;
        except
            a := 0;
        end;

        t := 0.6903;//(Se / Me)


        try
            if a < t then
                R := -(b1 * G + c1 * B) / a1
            else
                R := -(b2 * G + c2 * B) / a2;
        except
            R := 0;
        end;

    OldR := R;
    OldG := G;
    R := OldR * LMStoRGB[0, 0] + OldG * LMStoRGB[0, 1] + B * LMStoRGB[0, 2];
    G := OldR * LMStoRGB[1, 0] + OldG * LMStoRGB[1, 1] + B * LMStoRGB[1, 2];
    B := OldR * LMStoRGB[2, 0] + OldG * LMStoRGB[2, 1] + B * LMStoRGB[2, 2];
    try
        R := 255 * Power(R, 0.476190476);
    except
        R := 0;
    end;
    try
        G := 255 * Power(G, 0.5);
    except
        G := 0;
    end;
    try
        B := 255 * Power(B, 0.476190476);
    except
         B := 0;
    end;
    R := EnsureRange(R, 0, 255);
    G := EnsureRange(G, 0, 255);
    B := EnsureRange(B, 0, 255);
    dRed := Floor(R);
    dGreen := Floor(G);
    dBlue := Floor(B);

end;

procedure Convert_D(sRed, sGreen, sBlue: Byte; var dRed: Byte; var dGreen: byte; var dBlue: Byte);
var
    R, G, B, a, t: Double;
    a1, b1, c1, a2, b2, c2, OldR, OldG: Double;
const
	Le = 0.14597772;
	Me = 0.12188395;
	Se = 0.08413913;
begin
    //DicromatType
    //PROTANOPIA = 0;
    //DEUTERANOPIA = 1;
    //TRITANOPIA = 2;
    {Le := RGBtoLMS[0, 0] + RGBtoLMS[0, 1] + RGBtoLMS[0, 2];
    Me := RGBtoLMS[1, 0] + RGBtoLMS[1, 1] + RGBtoLMS[1, 2];
    Se := RGBtoLMS[2, 0] + RGBtoLMS[2, 1] + RGBtoLMS[2, 2];}

    R := sRed;
    G := sGreen;
    B := sBlue;

    try
        R := Power(R / 255, Gamma[0]);
    except
        R := 0;
    end;
    try
        G := Power(G / 255, Gamma[1]);
    except
        G := 0;
    end;
    try
        B := Power(B / 255, Gamma[2]);
    except
        B := 0;
    end;

    OldR := R;
    OldG := G;

    R := OldR * RGBtoLMS[0, 0] + OldG * RGBtoLMS[0, 1] + B * RGBtoLMS[0, 2];
    G := OldR * RGBtoLMS[1, 0] + OldG * RGBtoLMS[1, 1] + B * RGBtoLMS[1, 2];
    B := OldR * RGBtoLMS[2, 0] + OldG * RGBtoLMS[2, 1] + B * RGBtoLMS[2, 2];

        //575nm
        a1 := -0.0614;
        b1 := 0.0833;
        c1 := -0.0141;
        //a1 := Me * WL575nm[2] - Se * WL575nm[1];
        //b1 := Se * WL575nm[0] - Le * WL575nm[2];
        //c1 := Le * WL575nm[1] - Me * WL575nm[0];
        //475nm
        a2 := 0.0584;
        b2 := -0.0794;
        c2 := 0.0136;
        {a2 := Me * WL475nm[2] - Se * WL475nm[1];
        b2 := Se * WL475nm[0] - Le * WL475nm[2];
        c2 := Le * WL475nm[1] - Me * WL475nm[0];}



        try
            a := B / R;
        except
            a := 0;
        end;
        t := 0.5764;//(Se / Le);
        try
            if a < t then
                G := -(a1 * R + c1 * B) / b1
            else
                G := -(a2 * R + c2 * B) / b2;
        except
            G := 0;
        end;

    OldR := R;
    OldG := G;
    R := OldR * LMStoRGB[0, 0] + OldG * LMStoRGB[0, 1] + B * LMStoRGB[0, 2];
    G := OldR * LMStoRGB[1, 0] + OldG * LMStoRGB[1, 1] + B * LMStoRGB[1, 2];
    B := OldR * LMStoRGB[2, 0] + OldG * LMStoRGB[2, 1] + B * LMStoRGB[2, 2];
    try
        R := 255 * Power(R, 0.476190476);
    except
        R := 0;
    end;
    try
        G := 255 * Power(G, 0.5);
    except
        G := 0;
    end;
    try
         B := 255 * Power(B, 0.476190476);
    except
        B := 0;
    end;
    R := EnsureRange(R, 0, 255);
    G := EnsureRange(G, 0, 255);
    B := EnsureRange(B, 0, 255);
    dRed := Floor(R);
    dGreen := Floor(G);
    dBlue := Floor(B);

end;

procedure Convert_T(sRed, sGreen, sBlue: Byte; var dRed: Byte; var dGreen: byte; var dBlue: Byte);
var
    R, G, B, a, t: Double;
    a1, b1, c1, a2, b2, c2, OldR, OldG: Double;
const
	Le = 0.14597772;
	Me = 0.12188395;
	Se = 0.08413913;
begin
    //DicromatType
    //PROTANOPIA = 0;
    //DEUTERANOPIA = 1;
    //TRITANOPIA = 2;
    {Le := RGBtoLMS[0, 0] + RGBtoLMS[0, 1] + RGBtoLMS[0, 2];
    Me := RGBtoLMS[1, 0] + RGBtoLMS[1, 1] + RGBtoLMS[1, 2];
    Se := RGBtoLMS[2, 0] + RGBtoLMS[2, 1] + RGBtoLMS[2, 2];}

    R := sRed;
    G := sGreen;
    B := sBlue;

    try
        R := Power(R / 255, Gamma[0]);
    except
        R := 0;
    end;
    try
        G := Power(G / 255, Gamma[1]);
    except
        G := 0;
    end;
    try
        B := Power(B / 255, Gamma[2]);
    except
        B := 0;
    end;

    OldR := R;
    OldG := G;

    R := OldR * RGBtoLMS[0, 0] + OldG * RGBtoLMS[0, 1] + B * RGBtoLMS[0, 2];
    G := OldR * RGBtoLMS[1, 0] + OldG * RGBtoLMS[1, 1] + B * RGBtoLMS[1, 2];
    B := OldR * RGBtoLMS[2, 0] + OldG * RGBtoLMS[2, 1] + B * RGBtoLMS[2, 2];

        //660nm
        a1 := 0;
        b1 := 0.0076;
        c1 := -0.011;
        {a1 := Me * WL660nm[2] - Se * WL660nm[1];
        b1 := Se * WL660nm[0] - Le * WL660nm[2];
        c1 := Le * WL660nm[1] - Me * WL660nm[0];}
        //485nm
        a2 := 0.0254;
        b2 := -0.0416;
        c2 := 0.0163;
        {a2 := Me * WL485nm[2] - Se * WL485nm[1];
        b2 := Se * WL485nm[0] - Le * WL485nm[2];
        c2 := Le * WL485nm[1] - Me * WL485nm[0];}

        try
            a := G / R;
        except
             a := 0;
        end;
        t := 0.8349;//(Me / Le)
        try
            if a < t then
                B := -(a1 * R + b1 * G) / c1
            else
                B := -(a2 * R + b2 * G) / c2;
        except
            B := 0;
        end;

    OldR := R;
    OldG := G;
    R := OldR * LMStoRGB[0, 0] + OldG * LMStoRGB[0, 1] + B * LMStoRGB[0, 2];
    G := OldR * LMStoRGB[1, 0] + OldG * LMStoRGB[1, 1] + B * LMStoRGB[1, 2];
    B := OldR * LMStoRGB[2, 0] + OldG * LMStoRGB[2, 1] + B * LMStoRGB[2, 2];
    try
        R := 255 * Power(R, 0.476190476);
    except
        R := 0;
    end;
    try
        G := 255 * Power(G, 0.5);
    except
        G := 0;
    end;
    try
        B := 255 * Power(B, 0.476190476);
    except
        B := 0;
    end;
    R := EnsureRange(R, 0, 255);
    G := EnsureRange(G, 0, 255);
    B := EnsureRange(B, 0, 255);
    dRed := Floor(R);
    dGreen := Floor(G);
    dBlue := Floor(B);

end;

procedure ConvertDichromatFromRGB(var Red: Byte; var Green: byte; var Blue: Byte; const DichromatType: Integer);
var
     R, G, B, a, t: Double;
    a1, b1, c1, a2, b2, c2, OldR, OldG: Double;
const
	Le = 0.14597772;
	Me = 0.12188395;
	Se = 0.08413913;
begin
    //DicromatType
    //PROTANOPIA = 0;
    //DEUTERANOPIA = 1;
    //TRITANOPIA = 2;
    {Le := RGBtoLMS[0, 0] + RGBtoLMS[0, 1] + RGBtoLMS[0, 2];
    Me := RGBtoLMS[1, 0] + RGBtoLMS[1, 1] + RGBtoLMS[1, 2];
    Se := RGBtoLMS[2, 0] + RGBtoLMS[2, 1] + RGBtoLMS[2, 2];}

    R := Red;
    G := Green;
    B := Blue;

    try
        R := Power(R / 255, Gamma[0]);
    except
        R := 0;
    end;
    try
        G := Power(G / 255, Gamma[1]);
    except
        G := 0;
    end;
    try
        B := Power(B / 255, Gamma[2]);
    except
        B := 0;
    end;

    OldR := R;
    OldG := G;

    R := OldR * RGBtoLMS[0, 0] + OldG * RGBtoLMS[0, 1] + B * RGBtoLMS[0, 2];
    G := OldR * RGBtoLMS[1, 0] + OldG * RGBtoLMS[1, 1] + B * RGBtoLMS[1, 2];
    B := OldR * RGBtoLMS[2, 0] + OldG * RGBtoLMS[2, 1] + B * RGBtoLMS[2, 2];
    if (DichromatType = 0) or (DichromatType = 1) then
    begin
        //575nm
        a1 := -0.0614;
        b1 := 0.0833;
        c1 := -0.0141;
        //a1 := Me * WL575nm[2] - Se * WL575nm[1];
        //b1 := Se * WL575nm[0] - Le * WL575nm[2];
        //c1 := Le * WL575nm[1] - Me * WL575nm[0];
        //475nm
        a2 := 0.0584;
        b2 := -0.0794;
        c2 := 0.0136;
        {a2 := Me * WL475nm[2] - Se * WL475nm[1];
        b2 := Se * WL475nm[0] - Le * WL475nm[2];
        c2 := Le * WL475nm[1] - Me * WL475nm[0];}
    end
    else
    begin
        //660nm
        a1 := 0;
        b1 := 0.0076;
        c1 := -0.011;
        {a1 := Me * WL660nm[2] - Se * WL660nm[1];
        b1 := Se * WL660nm[0] - Le * WL660nm[2];
        c1 := Le * WL660nm[1] - Me * WL660nm[0];}
        //485nm
        a2 := 0.0254;
        b2 := -0.0416;
        c2 := 0.0163;
        {a2 := Me * WL485nm[2] - Se * WL485nm[1];
        b2 := Se * WL485nm[0] - Le * WL485nm[2];
        c2 := Le * WL485nm[1] - Me * WL485nm[0];}
    end;

    if DichromatType = 0 then //PROTANOPIA
    begin
        try
            if G > 0 then
                a := B / G
            else
                a := 0;
        except
            on EMathError do
                a := 0;
        end;
        try
            if Me > 0 then
                t := 0.6903//(Se / Me)
            else
                t := 0;
        except
            on EMathError do
                t := 0;
        end;
        try
            if a < t then
                R := -(b1 * G + c1 * B) / a1
            else
                R := -(b2 * G + c2 * B) / a2;
        except
            on EMathError do
                R := 0;
        end;
    end
    else if DichromatType = 1 then //DEUTERANOPIA
    begin
        try
            if R > 0 then
                a := B / R
            else
                a := 0;
        except
            on EMathError do
                a := 0;
        end;
        try
            if Le > 0 then
                t := 0.5764//(Se / Le)
            else
                t := 0;
        except
            on EMathError do
                t := 0;
        end;
        try
            if a < t then
                G := -(a1 * R + c1 * B) / b1
            else
                G := -(a2 * R + c2 * B) / b2;
        except
            on EMathError do
                G := 0;
        end;
    end
    else  //TRITANOPIA
    begin
        try
            if R > 0 then
                a := G / R
            else
                a := 0;
        except
            on EMathError do
                a := 0;
        end;
        try
            if Le > 0 then
                t := 0.8349//(Me / Le)
            else
                t := 0;
        except
            on EMathError do
                t := 0;
        end;
        try
            if a < t then
                B := -(a1 * R + b1 * G) / c1
            else
                B := -(a2 * R + b2 * G) / c2;
        except
            on EMathError do
                B := 0;
        end;
    end;
    OldR := R;
    OldG := G;
    R := OldR * LMStoRGB[0, 0] + OldG * LMStoRGB[0, 1] + B * LMStoRGB[0, 2];
    G := OldR * LMStoRGB[1, 0] + OldG * LMStoRGB[1, 1] + B * LMStoRGB[1, 2];
    B := OldR * LMStoRGB[2, 0] + OldG * LMStoRGB[2, 1] + B * LMStoRGB[2, 2];
    try
        if R > 0 then
            R := 255 * Power(R, 0.476190476)
        else
            R := 0;
    except
        on EMathError do
            R := 0;
    end;
    try
        if G > 0 then
            G := 255 * Power(G, 0.5)
        else
            G := 0;
    except
        on EMathError do
            G := 0;
    end;
    try
        if B > 0 then
            B := 255 * Power(B, 0.476190476)
        else
            B := 0;
    except
        on EMathError do
            B := 0;
    end;
    R := EnsureRange(R, 0, 255);
    G := EnsureRange(G, 0, 255);
    B := EnsureRange(B, 0, 255);
    Red := Floor(R);
    Green := Floor(G);
    Blue := Floor(B);
end;


end.
