codeunit 60114 "GAG PDC-Post(Yes/No)"
{
    trigger OnRun()
    VAR
        Rec: Record "GAG PDC Header";

    begin
        PDCHeaderG.COPY(Rec);
        Code;


    end;

    procedure Code()
    var
        PDCLineL: Record "GAG PDC Line";

    begin

        IF NOT CONFIRM(C_INC_PostConfirmation, FALSE, PDCHeaderG."Document Type", PDCHeaderG."No.") THEN
            EXIT;
        PDCHeaderG.CALCFIELDS("Amount(LCY)");
        IF PDCHeaderG."Amount(LCY)" = 0 THEN
            ERROR(C_INC_PostError);
        PDCHeaderG.TESTFIELD(PDCHeaderG."Account Type");
        PDCHeaderG.TESTFIELD(PDCHeaderG."Account No.");
        PDCHeaderG.TESTFIELD(PDCHeaderG."Posting Date");
        PDCHeaderG.TESTFIELD(PDCHeaderG."Cheque Received From/Issue To");
        PDCHeaderG.TESTFIELD(Description);
        PDCHeaderG.TESTFIELD(Division);

        PDCLineL.RESET;
        PDCLineL.SETRANGE("Document Type", PDCHeaderG."Document Type");
        PDCLineL.SETRANGE("No.", PDCHeaderG."No.");
        IF PDCLineL.FINDSET THEN
            REPEAT
                PDCLineL.TESTFIELD("Cheque No.");
                PDCLineL.TESTFIELD("In the Name of");
                IF PDCHeaderG."Guarantee Cheque" THEN
                    PDCLineL.TESTFIELD("From (Customer Company)");
            UNTIL PDCLineL.NEXT = 0;

        IF DateNotAllowed(PDCHeaderG."Posting Date", PDCLineL."Cheque Date") THEN
            PDCHeaderG.FIELDERROR("Posting Date", C_INC_PostingDate);
        PDCSetupG.GET;
        CASE PDCHeaderG."Document Type" OF
            PDCHeaderG."Document Type"::Receipt:
                BEGIN
                    IF PDCSetupG."PDC Receipt Approval Required" THEN BEGIN
                        PDCSetupG.TESTFIELD("PDC Receipt Approval Status");
                        PDCSetupG.TESTFIELD("PDC Receipt Rejected Status");
                        PDCSetupG.TESTFIELD("PDC Receipt Re-Open Status");
                        PDCSetupG.TESTFIELD("PDC Receipt Request Status");
                    END;

                    IF PDCSetupG."PDC Receipt Approval Required" THEN
                        IF PDCSetupG."PDC Receipt Approval Status" <> PDCHeaderG."Status Code" THEN
                            ERROR(C_INC_RcptStatusCode);
                END;
            PDCHeaderG."Document Type"::Issue:
                BEGIN
                    IF PDCSetupG."PDC Issue Approval Required" THEN BEGIN
                        PDCSetupG.TESTFIELD("PDC Issue Approval Status");
                        PDCSetupG.TESTFIELD("PDC Issue Reject Status");
                        PDCSetupG.TESTFIELD("PDC Issue Re-Open Status");
                        PDCSetupG.TESTFIELD("PDC Issue Request Status");
                    END;
                    IF PDCSetupG."PDC Issue Approval Status" <> '' THEN
                        IF PDCSetupG."PDC Issue Approval Status" <> PDCHeaderG."Status Code" THEN
                            ERROR(C_INC_IssueStatusCode);
                END;
        END;
        //PDCPostG.RUN(PDCHeaderG);
        PDCPostG.Run();

        MESSAGE(C_INC_PostedConfirmation, PDCHeaderG."Document Type", PDCHeaderG."No.");
        PDCHeaderG.DELETE(TRUE);
        COMMIT;
    end;

    procedure DateNotAllowed(PostingDateP: Date; DueDateP: Date): Boolean
    begin
        EXIT(FALSE);
    end;

    var
        PDCSetupG: Record "GAG PDC Setup";
        PDCHeaderG: Record "GAG PDC Header";
        PDCPostG: Codeunit "GAG PDC-Post";
        C_INC_PostConfirmation: label 'Do you want to post the Post Dated Cheque %1 %2?';
        C_INC_PostError: label 'There is nothing post!';
        C_INC_PostedConfirmation: label 'Post Dated Cheque %1 %2 Posted successfully.';
        C_INC_RcptStatusCode: label 'Post Dated Cheque Receipt Voucher must be approved, before post the Voucher!';
        C_INC_IssueStatusCode: label 'Post Dated Cheque Issue Voucher must be approved, before post the Voucher!';
        C_INC_PostingDate: label 'is not within your range of allowed posting dates';
}