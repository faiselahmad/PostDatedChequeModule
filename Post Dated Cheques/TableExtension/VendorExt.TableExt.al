tableextension 60105 VendorExt extends Vendor
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
