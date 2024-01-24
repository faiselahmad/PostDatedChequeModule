
table 60110 "GAG Voucher Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Voucher Type"; Option)
        {
            OptionMembers = BPV,BRV;
            DataClassification = ToBeClassified;
            Caption = 'Voucher Type';
        }
        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';


        }
        field(21; "Description"; Text[50])
        {

            DataClassification = ToBeClassified;
            Caption = 'Description';


        }

        field(22; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = ToBeClassified;
            Caption = 'Account Type';
        }
        field(23; "Account No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" ELSE
            IF ("Account Type" = CONST(Customer)) Customer ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account";



        }
        field(24; "Account Name"; Text[50])
        {

            DataClassification = ToBeClassified;
            Caption = 'Account Name';
        }
        field(25; "Currency Code"; code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Currency Code';
            TableRelation = Currency;


        }
        field(26; "Currency Factor"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Currency Factor';
        }
        field(27; "Document Date"; Date)
        {

            DataClassification = ToBeClassified;
            Caption = 'Document Date';
        }
        field(28; "Posting Date"; Date)
        {

            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
        }
        field(29; "Shortcut Dimension 1 Code"; code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(30; "Shortcut Dimension 2 Code"; code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(31; "Dimension Set ID"; Integer)
        {

            DataClassification = ToBeClassified;
            Caption = 'Dimension Set ID';
        }
        field(32; "No. Series"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Dimension Set ID';
        }
        field(33; "Source Code"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Source Code';
        }
        field(34; "Reason Code"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Reason Code';
        }
        field(35; "External Document No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Reason Code';
        }
        field(36; "Last Posting No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Last Posting No.';
        }
        field(37; "Division"; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Division';
            TableRelation = "GAG Division Code";
        }
        field(38; "Cheque No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Cheque No.';
        }
        field(39; "Cheque Date"; Date)
        {

            DataClassification = ToBeClassified;
            Caption = 'Cheque Date';
        }
        field(40; "Creation Date"; Date)
        {

            DataClassification = ToBeClassified;
            Caption = 'Creation Date';
        }
        field(41; "Created By"; code[50])
        {

            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }
        field(42; "Last Change Date"; Date)
        {

            DataClassification = ToBeClassified;
            Caption = 'Last Change Date';
        }
        field(43; "Last Change By"; Code[50])
        {

            DataClassification = ToBeClassified;
            Caption = 'Last Change By';
        }
        field(44; "Pre Voucher No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Pre Voucher No.';
        }
        field(45; "Created by PDC Voucher"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Created by PDC Voucher';
        }
        field(46; "PDC Document No."; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'PDC Document No.';
        }
        field(47; "PDC Document Type"; Option)
        {
            OptionMembers = Receipt,Issue;
            DataClassification = ToBeClassified;
            Caption = 'PDC Document Type';
        }
        field(48; "Exchange Rate"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Exchange Rate';
        }
        field(50; "Amount"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Amount';
        }
        field(51; "Amount(LYC)"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Amount(LYC)';
        }
        field(53; "Debit Amount"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Debit Amount';
        }
        field(54; "Credit Amount"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Credit Amount';
        }
        field(55; "Status Code"; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Status Code';
        }
        field(56; "Branch Code"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Branch Code';

        }
        field(57; "Location Code"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(58; "Payment Type"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Payment Type';

        }
        field(59; "Status Description"; Text[80])
        {

            //DataClassification = ToBeClassified;
            Caption = 'Payment Type';
            FieldClass = FlowField;
        }
        field(60; "Applies to Order Type"; Option)
        {
            OptionMembers = "Parts Purchases","Parts Sales","Vehicle Purchases","Vehicle Sales","Service Sales","Service Purchases";
            DataClassification = ToBeClassified;
            Caption = 'Applies to Order Type';
        }
        field(61; "Applies to Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applies to Order No.';
        }
        field(63; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Order No.';
        }
        field(80; "Approval Requested By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Requested By';
        }
        field(81; "Approval Approved/Rejected By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Approved/Rejected By';
        }
        field(90; "Note"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }
        field(101; "Bal.Account Type"; Option)
        {
            OptionMembers = GLAccount,Customer,Vendor;
            DataClassification = ToBeClassified;
            Caption = 'Bal.Account Type';
        }
        field(102; "Bal.Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bal.Account No.';
        }
        field(200; "Posted PDC Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted PDC Count';
        }

        field(201; "Posted Voucher Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Voucher Count';
        }
        field(300; "Document Status"; Option)
        {
            OptionMembers = Open,Printed,"Requested for Approval",Approved,Rejected;
            DataClassification = ToBeClassified;
            Caption = 'Document Status';
        }
        field(50000; "Line Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Account No.';
        }
        field(50001; "Line Account Name."; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Account Name.';
        }
    }

    keys
    {
        key(Key1; "Voucher Type")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {

        }
    }


}