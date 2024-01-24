tableextension 60108 Currency extends Currency
{
    fields
    {
        field(60100; "Least Denomination"; Code[10])
        {
            Caption = 'Least Denomination';
            DataClassification = ToBeClassified;
        }

    }
    procedure GetAmountRoundingPrecision(CurrencyCodeP: Code[10]): Decimal

    begin
        // @ Use this function to get Amount Rounding Precision
        // @ param CurrencyCodeP - Code 10
        // @ retval - Decimal

        Initialize(CurrencyCodeP);
        EXIT("Amount Rounding Precision");
    end;
}
