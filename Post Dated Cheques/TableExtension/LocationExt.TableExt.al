tableextension 60106 LocationExt extends Location
{
    fields
    {
        field(60100; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
        }
        field(60101; "Receipt Checked By"; Code[20])
        {
            Caption = 'Receipt Checked By';
            DataClassification = ToBeClassified;
        }
    }
}
