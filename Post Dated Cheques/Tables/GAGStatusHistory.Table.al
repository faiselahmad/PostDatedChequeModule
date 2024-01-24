table 60108 "GAG Status History"
{
    Caption = 'GAG Status History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Area"; Option)
        {
            Caption = 'Area';
            OptionMembers = "Bank Payment Voucher","Bank Receipt Voucher","PDC Receipt Voucher","PDC Issue Voucher";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Status Code"; Code[20])
        {
            Caption = 'Status Code';
        }
        field(4; "Modification Date/Time"; DateTime)
        {
            Caption = 'Modification Date/Time';
        }
        field(21; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(22; "Changed by User ID"; Code[50])
        {
            Caption = 'Changed by User ID';
        }
        field(23; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(24; "Modification Date"; Date)
        {
            Caption = 'Modification Date';
        }
    }
    keys
    {
        key(PK; "Area", "Document No.", "Status Code", "Modification Date/Time")
        {
            Clustered = true;
        }
    }
    procedure UpdateStatusHistory(AreaP: option BPV,BRV,"PDC Receipt","PDC Issue"; DocNoP: Code[20]; StatusCodeP: Code[20])
    var
        GAGStatusHistoryL: Record "GAG Status History";
    begin

        // @ This function updates the Document Status History or Work Status History from a service document
        GAGStatusHistoryL.SETCURRENTKEY(Area, "Document No.", "Modification Date/Time");
        GAGStatusHistoryL.SETRANGE(Area, AreaP);
        GAGStatusHistoryL.SETRANGE("Document No.", DocNoP);
        IF GAGStatusHistoryL.FINDLAST AND (GAGStatusHistoryL."Status Code" = StatusCodeP) THEN
            EXIT;
        GAGStatusHistoryL.INIT;
        GAGStatusHistoryL.Area := AreaP;
        GAGStatusHistoryL."Document No." := DocNoP;
        GAGStatusHistoryL.VALIDATE("Status Code", StatusCodeP);
        GAGStatusHistoryL."Modification Date/Time" := CURRENTDATETIME;
        GAGStatusHistoryL."Modification Date" := TODAY;
        GAGStatusHistoryL."Changed by User ID" := USERID;
        GAGStatusHistoryL.INSERT;
    end;

    procedure ShowStatusHistory(AreaP: Option BPV,BRV,"PDC Receipt","PDC Issue"; DocNoP: Code[20])
    var
        GAGStatusHistoryL: Record "GAG Status History";
    begin
        GAGStatusHistoryL.RESET;
        GAGStatusHistoryL.SETCURRENTKEY(Area, "Document No.", "Modification Date/Time");
        GAGStatusHistoryL.SETRANGE(Area, AreaP);
        GAGStatusHistoryL.SETRANGE("Document No.", DocNoP);
        PAGE.RUN(PAGE::"GAG Document Status History", GAGStatusHistoryL);
    end;
}
