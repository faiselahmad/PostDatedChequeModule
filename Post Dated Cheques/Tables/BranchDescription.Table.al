table 60114 "Branch Description"
{
    Caption = 'Branch Description';
    DataClassification = ToBeClassified;
    LookupPageId = Branches;
    DrillDownPageId = Branches;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(21; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(22; "Branch ID"; Code[10])
        {
            Caption = 'Branch ID';
        }
        field(23; "Consolidation Code"; Code[10])
        {
            Caption = 'Consolidation Code';
        }
        field(24; "Main Location Code"; Code[10])
        {
            Caption = 'Main Location Code';
            TableRelation = Location.Code WHERE("Branch Code" = FIELD(Code));
        }
        field(25; "Update Labor Clocking In Order"; Option)
        {
            Caption = 'Update Labor Clocking In Order';
            OptionMembers = Manual,Automatic;
        }
        field(26; "IC Customer No."; Code[20])
        {
            Caption = 'IC Customer No.';
            TableRelation = Customer;
        }
        field(27; "IC Vendor No."; Code[20])
        {
            Caption = 'IC Vendor No.';
            TableRelation = Vendor;
        }
        field(28; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(29; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(30; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(31; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(32; City; Text[30])
        {
            Caption = 'City';
        }
        field(33; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(34; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            ExtendedDatatype = PhoneNo;
        }
        field(35; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(36; County; Text[30])
        {
            Caption = 'County';
        }
        field(37; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(38; "TAX Invoice Expiry Formula"; DateFormula)
        {
            Caption = 'TAX Invoice Expiry Formula';
        }
        field(39; "BOE Expiry Formula"; DateFormula)
        {
            Caption = 'BOE Expiry Formula';
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
