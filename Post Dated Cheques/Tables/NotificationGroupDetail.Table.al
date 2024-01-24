table 60107 "Notification Group Detail"
{
    Caption = 'Notification Group Detail';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Notification Group Code"; Code[10])
        {
            Caption = 'Notification Group Code';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(3; "Document Location Code"; Code[10])
        {
            Caption = 'Document Location Code';
        }
        field(4; "Make Code"; Code[20])
        {
            Caption = 'Make Code';
        }
        field(5; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
    }
    keys
    {
        key(PK; "Notification Group Code")
        {
            Clustered = true;
        }
    }
}
