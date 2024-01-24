table 60112 "GAG Voucher Comment Line"
{
    Caption = 'GAG Voucher Comment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Voucher Type"; Option)
        {
            Caption = 'Voucher Type';
            OptionMembers = PPDCR,PDCR,PPDCI,PDCI,PBRV,BRV,PBPV,BPV;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }
    keys
    {
        key(PK; "Voucher Type")
        {
            Clustered = true;
        }
    }
}
