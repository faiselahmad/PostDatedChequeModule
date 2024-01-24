table 60113 "GAG Voucher Line"
{
    Caption = 'GAG Voucher Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Voucher Type"; Option)
        {
            Caption = 'Voucher Type';
            OptionMembers = BPV,BRV;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(21; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = "G/L Account",Customer,Vendor;
        }
        field(22; "Account No."; Code[20])
        {
            Caption = 'Account No.';
        }
        field(24; "Account Name"; Text[50])
        {
            Caption = 'Account Name ';
        }
        field(25; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(26; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(28; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(31; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
        }
        field(32; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionMembers = Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(33; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(34; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
        }
        field(35; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
        }
        field(36; "Applies-to Ext. Doc. No"; Code[20])
        {
            Caption = 'Applies-to Ext. Doc. No';
        }
        field(37; "Applies-to Open Order Type"; Option)
        {
            Caption = 'Applies-to Open Order Type';
            OptionMembers = "Parts Purchases","Parts Sales","Vehicle Purchases","Vehicle Sales","Service Sales","Service Purchases";
        }
        field(38; "Applies to Open Order No."; Code[20])
        {
            Caption = 'Applies to Open Order No.';
        }
        field(50; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(51; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
        }
        field(52; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
        }
        field(53; "Amount (LYC)"; Decimal)
        {
            Caption = 'Amount (LYC)';
        }
        field(56; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
        }
        field(57; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(58; Division; Code[20])
        {
            Caption = 'Division';
        }
        field(59; "Salespers./Purch.Code"; Code[10])
        {
            Caption = 'Salespers./Purch.Code';
        }
        field(60; "Sales Person Name"; Text[50])
        {
            Caption = 'Sales Person Name';
        }
        field(61; "Receipt Amount"; Decimal)
        {
            Caption = 'Receipt Amount ';
        }
        field(62; "Salespers./Purch. Code 2"; Code[10])
        {
            Caption = 'Salespers./Purch. Code 2';
        }
        field(63; "Sales Person Name 2"; Text[50])
        {
            Caption = 'Sales Person Name 2';
        }
    }
    keys
    {
        key(PK; "Voucher Type")
        {
            Clustered = true;
        }
    }
}