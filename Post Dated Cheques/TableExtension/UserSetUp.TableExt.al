tableextension 60103 "User SetUp" extends "User Setup"
{
    fields
    {
        field(60100; "Allow to Modify Exchange Rate"; Boolean)
        {
            Caption = 'Allow to Modify Exchange Rate';
            DataClassification = ToBeClassified;

        }
        field(60101; "Allow Voucher Modification"; Boolean)
        {
            Caption = 'Allow Voucher Modification';
            DataClassification = ToBeClassified;
        }
    }
}
