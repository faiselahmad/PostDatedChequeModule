table 60119 "GAG Posted PDC Line"
{
    Caption = 'GAG Posted PDC Line';
    DataClassification = ToBeClassified;
    DrillDownPageId = "GAG Posted PDC Lines";


    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = Receipt,Issue;
            OptionCaption = 'Receipt,Issue';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "GAG Posted PDC Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(21; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
        }
        field(22; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(23; "Due Date"; Date)
        {
            Caption = 'Due Date';
            trigger OnValidate()
            begin
                IF "Due Date" <= "Cheque Date" THEN
                    ERROR(C_INC_DueDateValidte, FIELDCAPTION("Due Date"), FIELDCAPTION("Cheque Date"));
            end;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(27; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = ,Customer,Vendor;
            OptionCaption = ' ,Customer,Vendor';
        }
        field(28; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer."No." WHERE(Blocked = FILTER(' ')) ELSE
            IF ("Account Type" = FILTER(Vendor)) Vendor."No." WHERE(Blocked = FILTER(' '));
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            MinValue = 0;
        }
        field(31; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            TableRelation = "Bank Account";
        }
        field(32; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(33; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(34; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Posted,Processed,Cancelled,Returned;
            OptionCaption = 'Open,Posted,Processed,Cancelled,Returned';
        }
        field(35; "Initial Due Date"; Date)
        {
            Caption = 'Initial Due Date';
        }
        field(36; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
            TableRelation = "Branch Description";
        }
        field(37; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(38; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(39; "Account Name"; Text[80])
        {
            Caption = 'Account Name';
        }
        field(50; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(51; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = ' , Payment,Invoice, Credit Memo, Finance Charge Memo,Reminder, Refund';
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            TableRelation = IF ("Account Type" = FILTER(Customer)) "Cust. Ledger Entry"."Document No." WHERE("Document Type" = FIELD("Applies-to Doc. Type"), Open = FILTER(true)) ELSE
            IF ("Account Type" = FILTER(Vendor)) "Vendor Ledger Entry"."Document No." WHERE("Document Type" = FIELD("Applies-to Doc. Type"), Open = FILTER(true));
        }
        field(54; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
        }
        field(55; "Applies-to Ext. Doc. No."; Code[20])
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        field(60; "Voucher Created"; Boolean)
        {
            Caption = 'Voucher Created';
        }
        field(61; "In the Name of"; Text[30])
        {
            Caption = 'In the Name of';
        }
        field(62; "From (Customer Company)"; Text[30])
        {
            Caption = 'From (Customer Company)';
        }
        field(82; "Guarantee Check"; Boolean)
        {
            Caption = 'Guarantee Check';
        }
    }
    keys
    {
        key(PK; "Document Type", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        C_INC_DueDateValidte: Label '%1 should always grater then %2';
}