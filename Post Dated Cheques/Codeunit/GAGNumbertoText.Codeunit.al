codeunit 60116 "GAG Number to Text"
{
    trigger OnRun()
    begin

    end;

    procedure FormatNoText(VAR NoTextP: ARRAY[2] OF Text[100]; NoP: Decimal; CurrencyCodeP: Code[10]): Text[200]
    var
        CurrencyL: Record Currency;
        PrintExponentL: Boolean;
        OnesL: Integer;
        TensL: Integer;
        HundredsL: Integer;
        ExponentL: Integer;
        NoTextIndexL: Integer;
        DecimalPositionL: Decimal;
        DecimalAmountL: Decimal;
        GeneralLedgerSetupL: Record "General Ledger Setup";
    begin
        CLEAR(NoTextP);
        NoTextIndexL := 1;
        NoTextP[1] := '****';
        GLSetup.GET;
        InitTextVariable;
        IF NoP < 1 THEN
            AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, C_INC_ZERO)
        ELSE
            FOR ExponentL := 4 DOWNTO 1 DO BEGIN
                PrintExponentL := FALSE;
                OnesL := NoP DIV POWER(1000, ExponentL - 1);
                HundredsL := OnesL DIV 100;
                TensL := (OnesL MOD 100) DIV 10;
                OnesL := OnesL MOD 10;
                IF HundredsL > 0 THEN BEGIN
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, OnesText[HundredsL]);
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, C_INC_HUNDRED);
                END;
                IF TensL >= 2 THEN BEGIN
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, TensText[TensL]);
                    IF OnesL > 0 THEN
                        AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, OnesText[OnesL]);
                END ELSE
                    IF (TensL * 10 + OnesL) > 0 THEN
                        AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, OnesText[TensL * 10 + OnesL]);
                IF PrintExponentL AND (ExponentL > 1) THEN
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, ExponentText[ExponentL]);
                NoP := NoP - (HundredsL * 100 + TensL * 10 + OnesL) * POWER(1000, ExponentL - 1);
            END;
        IF NoP > 0 THEN BEGIN
            AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, C_INC_AND);
            DecimalPositionL := GetAmtDecimalPosition(CurrencyCodeP);
            DecimalAmountL := NoP * DecimalPositionL;
            OnesL := DecimalAmountL DIV POWER(1000, ExponentL - 1);
            HundredsL := OnesL DIV 100;
            TensL := (OnesL MOD 100) DIV 10;
            OnesL := OnesL MOD 10;
            IF TensL >= 2 THEN BEGIN
                AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, TensText[TensL]);
                IF OnesL > 0 THEN
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, OnesText[OnesL]);
            END ELSE
                IF (TensL * 10 + OnesL) > 0 THEN
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, OnesText[TensL * 10 + OnesL]);
        END;

        IF NoP > 0 THEN BEGIN
            IF (CurrencyCodeP > '') AND CurrencyL.GET(CurrencyCodeP) THEN
                AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, CurrencyL."Least Denomination")
            ELSE BEGIN
                IF GeneralLedgerSetupL.GET AND CurrencyL.GET(GeneralLedgerSetupL."LCY Code") THEN
                    AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, CurrencyL."Least Denomination");
            END;
        END ELSE
            AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, CurrencyCodeP);
        IF NoP > 0 THEN
            AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, CurrencyCodeP + ' ' + C_INC_ONLY)
        ELSE
            AddToNoText(NoTextP, NoTextIndexL, PrintExponentL, C_INC_ONLY);
        EXIT(NoTextP[1] + ' ' + NoTextP[2]);
    end;

    procedure InitTextVariable()

    begin
        OnesText := C_INC_ONE;
        OnesText := C_INC_TWO;
        OnesText := C_INC_THREE;
        OnesText := C_INC_FOUR;
        OnesText := C_INC_FIVE;
        OnesText := C_INC_SIX;
        OnesText := C_INC_SEVEN;
        OnesText := C_INC_EIGHT;
        OnesText := C_INC_NINE;
        OnesText := C_INC_TEN;
        OnesText := C_INC_ELEVEN;
        OnesText := C_INC_TWELVE;
        OnesText := C_INC_THIRTEEN;
        OnesText := C_INC_FOURTEEN;
        OnesText := C_INC_FIFTEEN;
        OnesText := C_INC_SIXTEEN;
        OnesText := C_INC_SENENTEEN;
        OnesText := C_INC_EIGHTEEN;
        OnesText := C_INC_NINETEEN;

        TensText := '';
        TensText := C_INC_TWENTY;
        TensText := C_INC_THIRTY;
        TensText := C_INC_FORTY;
        TensText := C_INC_FIFTY;
        TensText := C_INC_SIXTY;
        TensText := C_INC_SEVENTY;
        TensText := C_INC_EIGHTY;
        TensText := C_INC_NINETY;

        ExponentText := '';
        ExponentText := C_INC_THOUSAND;
        ExponentText := C_INC_MILLION;
        ExponentText := C_INC_BILLION;
    end;

    procedure AddToNoText(VAR NoTextP: ARRAY[2] OF Text[100]; VAR NoTextIndexP: Integer; VAR PrintExponentP: Boolean; AddTextP: Text[30])

    begin
        PrintExponentP := TRUE;

        WHILE STRLEN(NoTextP[NoTextIndexP] + ' ' + AddTextP) > MAXSTRLEN(NoTextP[1]) DO BEGIN
            NoTextIndexP := NoTextIndexP + 1;
            IF NoTextIndexP > ARRAYLEN(NoTextP) THEN
                ERROR(Text001, AddTextP);
        END;

        NoTextP[NoTextIndexP] := DELCHR(NoTextP[NoTextIndexP] + ' ' + AddTextP, '<');
    end;

    procedure GetAmtDecimalPosition(CurrencyL: Code[10]): Decimal
    var
        Currency: Record Currency;

    begin
        IF CurrencyL = '' THEN
            Currency.InitRoundingPrecision
        ELSE BEGIN
            IF Currency.GET(CurrencyL) THEN BEGIN
                Currency.TESTFIELD("Amount Rounding Precision");
                EXIT(1 / Currency."Amount Rounding Precision");
            END ELSE BEGIN
                GLSetup.GET;
                GLSetup.TESTFIELD("Amount Rounding Precision");
                EXIT(1 / GLSetup."Amount Rounding Precision");
            END;
        END;
    end;

    var
        OnesText: Text[50];
        TensText: Text[50];
        ExponentText: Text[30];

        GLSetup: Record "General Ledger Setup";

        Text001: Label '%1 results in a written number that is too long.';
        Text003: label '%1 %2 %3 %4 %5 %6%7';
        Text004: label '%1 %2 %3 %4';
        C_INC_ZERO: label 'ZERO';
        C_INC_HUNDRED: label 'HUNDRED';
        C_INC_AND: label 'AND';
        C_INC_ONE: label 'ONE';
        C_INC_TWO: label 'TWO';
        C_INC_THREE: label 'THREE';
        C_INC_FOUR: label 'FOUR';
        C_INC_FIVE: label 'FIVE';
        C_INC_SIX: label 'SIX';
        C_INC_SEVEN: label 'SEVEN';
        C_INC_EIGHT: label 'EIGHT';
        C_INC_NINE: label 'NINE';
        C_INC_TEN: label 'TEN';
        C_INC_ELEVEN: Label 'ELEVEN';
        C_INC_TWELVE: label 'TWELVE';
        C_INC_THIRTEEN: label 'THIRTEEN';
        C_INC_FOURTEEN: label 'FOURTEEN';
        C_INC_FIFTEEN: label 'FIFTEEN';
        C_INC_SIXTEEN: label 'SIXTEEN';
        C_INC_SENENTEEN: label 'SEVENTEEN';
        C_INC_EIGHTEEN: label 'EIGHTEEN';
        C_INC_NINETEEN: label 'NINETEEN';
        C_INC_TWENTY: label 'TWENTY';
        C_INC_THIRTY: Label 'THIRTY';
        C_INC_FORTY: Label 'FORTY';
        C_INC_FIFTY: Label 'FIFTY';
        C_INC_SIXTY: Label 'SIXTY';
        C_INC_SEVENTY: Label 'SEVENTY';
        C_INC_EIGHTY: Label 'EIGHTY';
        C_INC_NINETY: Label 'NINETY';
        C_INC_THOUSAND: Label 'THOUSAND';
        C_INC_MILLION: Label 'MILLION';
        C_INC_BILLION: Label 'BILLION';
        C_INC_ONLY: Label 'ONLY';


}