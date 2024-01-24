table 60109 "GAG Document Status Line"
{
    Caption = 'GAG Document Status Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Area"; Option)
        {
            Caption = 'Area';
            OptionMembers = BRV,BPV,"Bank Payment Voucher","Bank Receipt Voucher","PDC Receipt Voucher","PDC Issue Voucher";
        }
        field(2; "Status Code"; Code[20])
        {
            Caption = 'Status Code';
        }
        field(21; "Status Description"; Text[70])
        {
            Caption = 'Status Description';
        }
        field(22; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(23; "No. of Functions"; Integer)
        {
            Caption = 'No. of Functions';
        }
    }

    keys
    {
        key(PK; "Area", "Status Code")
        {
            Clustered = true;
        }
    }

    procedure SetDocumentNo(DocNoP: Code[20])
    begin
        // @ Function to set the Document No.
        // @ param DocNoP - of type Code length 20.
        DocNoG := DocNoP;
    end;

    procedure SetCommBuffer(VAR TempCommBufferP: Record "Communication Method" temporary)
    var


    begin
        TempCommBufferG.DELETEALL;
        TempCommBufferG.INIT;
        TempCommBufferG := TempCommBufferP;
        TempCommBufferG.INSERT;
    end;

    procedure ExecuteSpecificCU()
    var
        GAGStatusFunctionL: Record "GAG Document Status Function";
        PDCHeaderL: Record "GAG PDC Header";
        GAGVoucherHeaderL: Record "GAG Voucher Header";
        RecRefL: RecordRef;
        PageIDL: Integer;
    begin
        // @ Function to check if Document Status Line of Type Specific
        // @ setup exists for a Document Status and execute the Codeunit
        GAGStatusFunctionL.SETCURRENTKEY(Area, "Status Code", Type);
        GAGStatusFunctionL.SETRANGE(Area, Area);
        GAGStatusFunctionL.SETRANGE("Status Code", "Status Code");
        GAGStatusFunctionL.SETRANGE(Type, GAGStatusFunctionL.Type::Specific);
        GAGStatusFunctionL.SETFILTER("Codeunit No.", '<>%1', 0);
        IF GAGStatusFunctionL.FINDSET THEN BEGIN
            REPEAT
                GetParameters(RecRefL, PageIDL);
                CASE RecRefL.NUMBER OF
                    DATABASE::"GAG PDC Header":
                        BEGIN
                            IF Area = Area::"PDC Issue Voucher" THEN
                                PDCHeaderL.SETRANGE("Document Type", PDCHeaderL."Document Type"::Issue)
                            ELSE
                                IF Area = Area::"PDC Receipt Voucher" THEN
                                    PDCHeaderL.SETRANGE("Document Type", PDCHeaderL."Document Type"::Receipt);
                            PDCHeaderL.SETRANGE("No.", DocNoG);
                            IF PDCHeaderL.FINDFIRST THEN
                                CODEUNIT.RUN(GAGStatusFunctionL."Codeunit No.", PDCHeaderL);
                        END;
                    DATABASE::"GAG Voucher Header":
                        BEGIN
                            IF Area = Area::BRV THEN
                                GAGVoucherHeaderL.SETRANGE("Voucher Type", GAGVoucherHeaderL."Voucher Type"::BRV)
                            ELSE
                                IF Area = Area::BPV THEN
                                    GAGVoucherHeaderL.SETRANGE("Voucher Type", GAGVoucherHeaderL."Voucher Type"::BPV);
                            GAGVoucherHeaderL.SETRANGE("No.", DocNoG);
                            IF GAGVoucherHeaderL.FINDFIRST THEN
                                CODEUNIT.RUN(GAGStatusFunctionL."Codeunit No.", GAGVoucherHeaderL);
                        END;
                    ELSE
                        EXIT;
                END;
            UNTIL GAGStatusFunctionL.NEXT = 0;
        END;
    end;

    procedure GetParameters(VAR RecRefP: RecordRef; VAR PageIDP: Integer)
    // @ Function to retreive and set Record and Page Parameters for Documents of all Areas.
    // @ param RecRefP - type RecordRef passed by reference.
    // @ param PageIDP - type Integer passed by reference.

    var
        PDCHeaderL: Record "GAG PDC Header";
        GAGVoucherHeaderL: Record "GAG Voucher Header";
    begin
        DeleteRecG := FALSE;
        CASE Area OF
            Area::"PDC Receipt Voucher":
                BEGIN
                    PageIDP := PAGE::"GAG PDC Receipt";
                    IF NOT PDCHeaderL.GET(PDCHeaderL."Document Type"::Receipt, DocNoG) THEN BEGIN
                        PDCHeaderL.INIT;
                        PDCHeaderL."Document Type" := PDCHeaderL."Document Type"::Receipt;
                        PDCHeaderL."No." := DocNoG;
                        UserSessionUnitG.GetUserSession(UserSessionG);
                        PDCHeaderL.INSERT;
                        DeleteRecG := TRUE;
                    END;
                    RecRefP.GETTABLE(PDCHeaderL);
                END;
            Area::"PDC Issue Voucher":
                BEGIN
                    PageIDP := PAGE::"GAG PDC Issue";
                    IF NOT PDCHeaderL.GET(PDCHeaderL."Document Type"::Issue, DocNoG) THEN BEGIN
                        PDCHeaderL.INIT;
                        PDCHeaderL."Document Type" := PDCHeaderL."Document Type"::Issue;
                        PDCHeaderL."No." := DocNoG;
                        UserSessionUnitG.GetUserSession(UserSessionG);
                        PDCHeaderL.INSERT;
                        DeleteRecG := TRUE;
                    END;
                    RecRefP.GETTABLE(PDCHeaderL);
                END;
            Area::BRV:
                BEGIN
                    PageIDP := PAGE::"GAG Bank Receipt";
                    IF NOT GAGVoucherHeaderL.GET(GAGVoucherHeaderL."Voucher Type"::BRV, DocNoG) THEN BEGIN
                        GAGVoucherHeaderL.INIT;
                        GAGVoucherHeaderL."Voucher Type" := GAGVoucherHeaderL."Voucher Type"::BRV;
                        GAGVoucherHeaderL."No." := DocNoG;
                        UserSessionUnitG.GetUserSession(UserSessionG);
                        GAGVoucherHeaderL.INSERT;
                        DeleteRecG := TRUE;
                    END;
                    RecRefP.GETTABLE(GAGVoucherHeaderL);
                END;
            Area::BPV:
                BEGIN
                    PageIDP := PAGE::"GAG Bank Payment";
                    IF NOT GAGVoucherHeaderL.GET(GAGVoucherHeaderL."Voucher Type"::BPV, DocNoG) THEN BEGIN
                        GAGVoucherHeaderL.INIT;
                        GAGVoucherHeaderL."Voucher Type" := GAGVoucherHeaderL."Voucher Type"::BPV;
                        GAGVoucherHeaderL."No." := DocNoG;
                        UserSessionUnitG.GetUserSession(UserSessionG);
                        GAGVoucherHeaderL.INSERT;
                        DeleteRecG := TRUE;
                    END;
                    RecRefP.GETTABLE(GAGVoucherHeaderL);
                END;
        END;
    end;

    procedure ExecuteNotifications()
    var
        GAGStatusFunctionL: Record "GAG Document Status Function";
        NotGroupLinesL: Record "Notification Group Detail";
        PDCHeaderL: Record "GAG PDC Header";
        GAGVoucherHeaderL: Record "GAG Voucher Header";
        RecRefL: RecordRef;
        MakeCodeL: code[20];
        PageIDL: integer;
        GAGStatusFunctionCountL: integer;

    begin
        // @ Function to check if Notification setup exists for a Document Status and insert notifications.
        GAGStatusFunctionL.SETCURRENTKEY(Area, "Status Code", Type);
        GAGStatusFunctionL.SETRANGE(Area, Area);
        GAGStatusFunctionL.SETRANGE("Status Code", "Status Code");
        GAGStatusFunctionL.SETRANGE(Type, GAGStatusFunctionL.Type::Notification);
        IF GAGStatusFunctionL.FINDSET THEN BEGIN
            REPEAT
                GAGStatusFunctionCountL += 1;
                CALCFIELDS("Status Description");
                IF RecRefL.NUMBER = 0 THEN
                    GetParameters(RecRefL, PageIDL);
                CASE RecRefL.NUMBER OF
                    DATABASE::"GAG PDC Header":
                        BEGIN
                            IF Area = Area::"PDC Receipt Voucher" THEN
                                PDCHeaderL.GET(PDCHeaderL."Document Type"::Receipt, DocNoG)
                            ELSE
                                IF Area = Area::"PDC Issue Voucher" THEN
                                    PDCHeaderL.GET(PDCHeaderL."Document Type"::Issue, DocNoG);
                            MakeCodeL := PDCHeaderL."Shortcut Dimension 2 Code";
                        END;
                    DATABASE::"GAG Voucher Header":
                        BEGIN
                            IF Area = Area::BRV THEN
                                GAGVoucherHeaderL.GET(GAGVoucherHeaderL."Voucher Type"::BRV, DocNoG)
                            ELSE
                                IF Area = Area::BPV THEN
                                    GAGVoucherHeaderL.GET(GAGVoucherHeaderL."Voucher Type"::BPV, DocNoG);
                            MakeCodeL := GAGVoucherHeaderL."Shortcut Dimension 2 Code";
                        END;
                    ELSE
                        EXIT;
                END;
                NotGroupLinesL.RESET;
                NotGroupLinesL.SETRANGE("Notification Group Code", GAGStatusFunctionL."Notification Group");
                NotGroupLinesL.SETFILTER("Make Code", '%1|%2', '', MakeCodeL);
                IF NotGroupLinesL.FINDSET THEN BEGIN
                    REPEAT
                        InsertRecordLink(RecRefL, PageIDL, TRUE, NotGroupLinesL."Employee No.", "Status Description");
                    UNTIL NotGroupLinesL.NEXT = 0;
                END;
                IF GAGStatusFunctionCountL = (GAGStatusFunctionL.COUNT) THEN
                    IF DeleteRecG THEN BEGIN
                        CASE RecRefL.NUMBER OF
                            DATABASE::"GAG PDC Header":
                                PDCHeaderL.DELETE;
                            DATABASE::"GAG Voucher Header":
                                GAGVoucherHeaderL.DELETE;
                        END;
                    END;
            UNTIL GAGStatusFunctionL.NEXT = 0;
        END;
    end;

    procedure InsertRecordLink(RecRefP: RecordRef; PageIDP: Integer; NotifyP: Boolean; EmpNoP: Code[20]; NotificationTextP: Text[1024])
    var
        RecordLinkL: Record "Record Link";
        UserSetupL: Record "User Setup";
        LenCharL: Char;
        Char2L: Char;
        DivL: Integer;
        ModL: Integer;
        BigTextL: BigText;
        // EncodingL: DotNet "System.Text.Encoding".'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'";
        //BinaryWriterL:DotNet System.IO.BinaryWriter.'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
        OutStreamL: OutStream;
    begin

        // @ Function to insert record into the Record Link table.
        // @ param RecRefP - type RecordRef
        // @ param PageIDP - type Integer
        // @ param NotifyP - type Boolean
        // @ param EmpNoP - type Code length 20
        // @ param NotificationTextP - of type Text length 1024.

        UserSetupL.RESET;
        UserSetupL.SETCURRENTKEY("User ID");
        UserSetupL.SETRANGE("User ID", EmpNoP);
        IF NOT UserSetupL.FINDFIRST THEN
            EXIT;

        BigTextL.ADDTEXT(NotificationTextP);
        DivL := BigTextL.LENGTH DIV 128;
        ModL := BigTextL.LENGTH MOD 128;
        RecordLinkL.GET(RecRefP.ADDLINK('dynamicsnav:////' + COMPANYNAME + '/' + 'runpage?page=' + FORMAT(PageIDP) + '&mode=Edit&bookmark=' + FORMAT(RecRefP.RECORDID, 0, 10)));
        RecordLinkL.CALCFIELDS(Note);
        RecordLinkL.Note.CREATEOUTSTREAM(OutStreamL);
        IF NOT ISSERVICETIER THEN BEGIN
            IF DivL = 0 THEN BEGIN
                LenCharL := BigTextL.LENGTH;
                BigTextL.ADDTEXT(FORMAT(LenCharL), 1);
            END ELSE BEGIN
                LenCharL := ModL + 128;
                Char2L := DivL;
                BigTextL.ADDTEXT(FORMAT(LenCharL) + FORMAT(Char2L), 1);
            END;
            BigTextL.WRITE(OutStreamL);
        END ELSE BEGIN
            // EncodingL := EncodingL.GetEncoding(65001);
            // BinaryWriterL := BinaryWriterL.BinaryWriter(OutStreamL, EncodingL);
            //BinaryWriterL.Write(FORMAT(BigTextL));
        END;

        RecordLinkL.Description := FORMAT(RecRefP.RECORDID);
        RecordLinkL.Type := RecordLinkL.Type::Note;
        RecordLinkL.Notify := NotifyP;
        RecordLinkL."To User ID" := UserSetupL."User ID";
        RecordLinkL.Company := COMPANYNAME;
        RecordLinkL.MODIFY(TRUE);

    end;

    procedure SendMessage()

    begin

    end;

    procedure ExecuteStatusFunctions()
    var
        GAGStatusFunctionL: record "GAG Document Status Function";

    begin
        GAGStatusFunctionL.SETCURRENTKEY(Area, "Status Code", Type);
        GAGStatusFunctionL.SETRANGE(Area, Area);
        GAGStatusFunctionL.SETRANGE("Status Code", "Status Code");
        GAGStatusFunctionL.SETRANGE(Type, GAGStatusFunctionL.Type::Lock);
        IF GAGStatusFunctionL.FINDFIRST THEN
            ERROR(C_INC001, GAGStatusFunctionL.Area);
    end;

    var
        DocNoG: code[20];
        TempCommBufferG: Record "Communication Method";
        DeleteRecG: Boolean;
        SendMessageAutoG: Boolean;
        // StatusListG:Record "Status List";
        UserSessionG: Record "User Session";
        UserSessionUnitG: Codeunit "User Session Unit";
        C_INC001: label 'The %1 document is locked. You cannot modify it.';


}