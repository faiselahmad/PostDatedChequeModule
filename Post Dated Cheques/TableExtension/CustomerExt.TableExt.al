tableextension 60104 CustomerExt extends Customer
{
    fields
    {
        field(60100; "GAG Division Code"; Code[10])
        {
            Caption = 'GAG Division Code';
            DataClassification = ToBeClassified;
        }
        field(60101; Blockeds; option)
        {
            Caption = 'Blocked';
            OptionMembers = " ",Ship,Invoice,All;

        }
    }
}
