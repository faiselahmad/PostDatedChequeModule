codeunit 60201 "GAG PDC-Post + Print"
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
        PDCHeaderG.TESTFIELD(PDCHeaderG."Bank Code");

        PDCLineL.RESET;
        PDCLineL.SETRANGE("Document Type", PDCHeaderG."Document Type");
        PDCLineL.SETRANGE("No.", PDCHeaderG."No.");
        IF PDCLineL.FINDSET THEN
            REPEAT
                PDCLineL.TESTFIELD("Cheque No.");
                PDCLineL.TESTFIELD("Cheque Date");
                PDCLineL.TESTFIELD("Due Date");
            UNTIL PDCLineL.NEXT = 0;

        //PDCPostG.RUN(PDCHeaderG);
        PDCPostG.RUN();

        COMMIT;
        PrintPostedReport(PDCHeaderG);

        MESSAGE(C_INC_PostedConfirmation, PDCHeaderG."Document Type", PDCHeaderG."No.");
        PDCHeaderG.DELETE(TRUE);
    end;

    procedure PrintPostedReport(PDCHeaderP: Record "GAG PDC Header")
    var
        PostedPDCHeaderL: Record "GAG Posted PDC Header";
    begin
        PostedPDCHeaderL.RESET;
        PostedPDCHeaderL.GET(PDCHeaderP."Document Type", PDCHeaderP."Last Posting No.");
        PostedPDCHeaderL.SETRECFILTER;
        //  REPORT.RUN(REPORT::"GAG PDC Receipt (Posted)", FALSE, FALSE, PostedPDCHeaderL);
    end;

    var
        PDCSetupG: Record "GAG PDC Setup";
        PDCHeaderG: Record "GAG PDC Header";
        PDCPostG: codeunit "GAG PDC-Post";
        PostedReportG: Report "GAG PDC Receipt (Un-Posted)";//"GAG PDC Receipt (Posted)";
        C_INC_PostConfirmation: label 'Do you want to post and print the PDC %1 %2?';
        C_INC_PostError: label 'There is nothing post!';
        C_INC_PostedConfirmation: label 'PDC %1 %2 Posted successfully.';

}