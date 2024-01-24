tableextension 60107 Employee extends Employee
{
    fields
    {
        field(60100; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(60101; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }
}
