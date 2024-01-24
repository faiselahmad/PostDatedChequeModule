table 60118 "User Status Code"
{
    Caption = 'User Status Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(2; "Status Code"; Code[20])
        {
            Caption = 'Status Code';
        }
        field(3; "Permission Level"; Option)
        {
            Caption = 'Permission Level';
            OptionMembers = Activate,Deactivate,"Activate/Deactivate";
        }
        field(4; "Status Description"; Text[30])
        {
            Caption = 'Status Description';
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}
