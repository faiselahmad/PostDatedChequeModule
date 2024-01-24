table 60117 "GAG Posted PDC Header"
{
    Caption = 'GAG Posted PDC Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = Receipt,Issue;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';

        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = "",Customer,Vendor;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(6; "Account Name"; Text[80])
        {
            Caption = 'Account Name';
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(8; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(9; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
        field(10; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(13; "Cheque Received From/Issue To"; Text[50])
        {
            Caption = 'Cheque Received From/Issue To';
        }
        field(14; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Posted,"Partially Processed",Processed,Cancelled,Returned;
        }
        field(15; Division; Code[20])
        {
            Caption = 'Division';
        }
        field(16; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
        }
        field(17; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
        }
        field(18; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(19; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(20; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(22; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(23; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(24; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(25; "Last Change Date"; Date)
        {
            Caption = 'Last Change Date';
        }
        field(26; "Last Change by"; Code[50])
        {
            Caption = 'Last Change by';
        }
        field(27; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(28; "Applies to Order Type"; Option)
        {
            Caption = 'Applies to Order Type';
            OptionMembers = "Parts Purchases","Parts Sales","Vehicle Purchases","Vehicle Sales","Service Sales","Service Purchases";
        }
        field(29; "Applies to Order No."; Code[20])
        {
            Caption = 'Applies to Order No.';
        }
        field(30; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(31; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
        }
        field(32; "Status Code"; Code[20])
        {
            Caption = 'Status Code';
        }
        field(33; "Pre-Document No."; Code[20])
        {
            Caption = 'Pre-Document No.';
        }
        field(34; "Status Description"; Text[80])
        {
            Caption = 'Status Description';
        }
        field(35; "Approval Requested By"; Code[50])
        {
            Caption = 'Approval Requested By';
        }
        field(36; "Approval Approved/Rejected By"; Code[50])
        {
            Caption = 'Approval Approved/Rejected By';
        }
        field(37; "Guarantee Cheque"; Boolean)
        {
            Caption = 'Guarantee Cheque';
        }
        field(38; "Is Cheque Returned"; Boolean)
        {
            Caption = 'Is Cheque Returned';
        }
    }
    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    Trigger OnDelete()
    begin
        PostedPDCLineG.RESET;
        PostedPDCLineG.SETRANGE("Document Type", "Document Type");
        PostedPDCLineG.SETRANGE("No.", "No.");
        PostedPDCLineG.DELETEALL(TRUE);

        PDCCommentLineG.RESET;
        PDCCommentLineG.SETRANGE("No.", "No.");
        PDCCommentLineG.DELETEALL(TRUE);

    end;

    procedure Navigate()
    var
        NavigatePage: page Navigate;
    begin
        NavigatePage.SetDoc("Posting Date", "No.");
        NavigatePage.RUN;
    end;

    var
        PostedPDCLineG: Record "GAG Posted PDC Line";
        PDCCommentLineG: Record "GAG Voucher Comment Line";

}
