table 60101 "GAG Attachment"
{
    Caption = 'GAG Attachment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Attached Date"; DateTime)
        {
            Caption = 'Attached Date';
        }
        field(5; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(6; "File Type"; Option)
        {
            Caption = 'File Type';
            OptionMembers = " ",Image,PDF,Word,Excel,PowerPoint,Email,XML,Other;
            OptionCaption = ' ,Image,PDF,Word,Excel,PowerPoint,Email,XML,Other';
        }
        field(7; "File Extension"; Text[30])
        {
            Caption = 'File Extension';
        }
        field(8; "Document Reference ID"; Media)
        {
            Caption = 'Document Reference ID';
        }
        field(9; "Attached By"; Guid)
        {
            Caption = 'Attached By';
        }
        field(10; User; Code[50])
        {
            Caption = 'User';
        }
        field(11; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ",Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order","Posted Invoice","Posted Shipment";
            OptionCaption = ' , Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Posted Invoice,Posted Shipment';
        }
        field(12; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(13; "Type of Attachment"; Text[30])
        {
            Caption = 'Type of Attachment';
        }
        field(14; "Attachment Description"; Text[50])
        {
            Caption = 'Attachment Description';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }


}
