table 60103 "GAG PDC Setup"
{
    Caption = 'PDC Setup';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Receipts Nos."; Code[10])
        {
            Caption = 'Receipts Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Posted Receipt Nos."; Code[10])
        {
            Caption = 'Posted Receipt Nos.';
            TableRelation = "No. Series";
        }
        field(4; "Issue Nos."; Code[10])
        {
            Caption = 'Issue Nos.';
            TableRelation = "No. Series";
        }
        field(5; "Posted Issue Nos"; Code[10])
        {
            Caption = 'Posted Issue Nos';
            TableRelation = "No. Series";
        }
        field(6; "Reminder Date Formula"; DateFormula)
        {
            Caption = 'Reminder Date Formula';
        }
        field(7; "PDC Receipt Approval Status"; Code[30])
        {
            Caption = 'PDC Receipt Approval Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Receipt Voucher"));
        }
        field(8; "PDC Issue Approval Status"; Code[30])
        {
            Caption = 'PDC Issue Approval Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Issue Voucher"));
        }
        field(9; "PDC Receipt Request Status"; Code[30])
        {
            Caption = 'PDC Receipt Request Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Receipt Voucher"));
        }
        field(10; "PDC Receipt Rejected Status"; Code[30])
        {
            Caption = 'PDC Receipt Rejected Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Receipt Voucher"));
        }
        field(11; "PDC Issue Request Status"; Code[30])
        {
            Caption = 'PDC Issue Request Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Issue Voucher"));
        }
        field(12; "PDC Issue Reject Status"; Code[30])
        {
            Caption = 'PDC Issue Reject Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Issue Voucher"));
        }
        field(13; "PDC Terms & Condition"; Blob)
        {
            Caption = 'PDC Terms & Condition';
        }
        field(14; "PDC Issue Re-Open Status"; Code[30])
        {
            Caption = 'PDC Issue Re-Open Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Issue Voucher"));
        }
        field(15; "PDC Receipt Re-Open Status"; Code[30])
        {
            Caption = 'PDC Receipt Re-Open Status';
            TableRelation = "GAG Document Status Line"."Status Code" WHERE(Area = FILTER("PDC Receipt Voucher"));
        }
        field(16; "PDC Receipt Approval Required"; Boolean)
        {
            Caption = 'PDC Receipt Approval Required';
        }
        field(17; "PDC Issue Approval Required"; Boolean)
        {
            Caption = 'PDC Issue Approval Required';
        }
        field(18; "PDC Receipt Terms & Condition"; Blob)
        {
            Caption = 'PDC Receipt Terms & Condition';
        }
        field(19; "Un-Posted PDC Rcpt. Report ID"; Integer)
        {
            Caption = 'Un-Posted PDC Rcpt. Report ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(20; "Posted PDC Rcpt. Report ID"; Integer)
        {
            Caption = 'Posted PDC Rcpt. Report ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(21; "Un-Posted PDC Issue Report ID"; Integer)
        {
            Caption = 'Un-Posted PDC Issue Report ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(22; "Posted PDC Issue Report ID"; Integer)
        {
            Caption = 'Posted PDC Issue Report ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure GetReceiptTermsandCondition(): Text
    var
        //TempBlob:Record "Upgrade Blob Storage";
        CR: Text[20];
    begin
        CALCFIELDS("PDC Receipt Terms & Condition");
        IF NOT "PDC Receipt Terms & Condition".HASVALUE THEN
            EXIT('');
        CR[1] := 10;
        //TempBlob.Blob := "PDC Receipt Terms & Condition";
        //EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;
}
