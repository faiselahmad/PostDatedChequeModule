table 60111 "Status List"
{
    Caption = 'Status List';
    DataClassification = ToBeClassified;
    DataCaptionFields = Code, Description;
    DrillDownPageId = "Status List";


    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
        }
        field(4; Priority; Integer)
        {
            Caption = 'Priority';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
