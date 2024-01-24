table 60106 "GAG Document Status Function"
{
    Caption = 'GAG Document Status Function';
    DataClassification = CustomerContent;
    DataCaptionFields = Area, "Status Code";

    fields
    {
        field(1; "Area"; Option)
        {
            Caption = 'Area';
            OptionMembers = "Bank Payment Voucher","Bank Receipt Voucher","PDC Receipt Voucher","PDC Issue Voucher";
        }
        field(2; "Status Code"; Code[20])
        {
            Caption = 'Status Code';
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(5; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Lock,Message,Notification,Specific;
        }
        field(6; "Notification Group"; Code[10])
        {
            Caption = 'Notification Group';
        }
        field(7; "Send Message Automatically"; Boolean)
        {
            Caption = 'Send Message Automatically';
        }
        field(8; "Interaction Template Code"; Code[10])
        {
            Caption = 'Interaction Template Code';
        }
        field(9; "Codeunit No."; Integer)
        {
            Caption = 'Codeunit No.';
        }
        field(10; "Codeunit Name"; Text[30])
        {
            Caption = 'Codeunit Name';
        }
    }
    keys
    {
        key(PK; "Area", "Status Code", "Code")
        {
            Clustered = true;
        }
    }
}
