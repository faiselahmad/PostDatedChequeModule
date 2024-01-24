codeunit 60115 "GAG PDC-Post"
{
    trigger OnRun()
    VAR
        Rec: Record "GAG PDC Header";
    begin
        PDCSetupG.GET;
        Rec."Pre-Document No." := Rec."No.";
        PDCHeaderG.COPY(Rec);

        CASE Rec."Document Type" OF
            Rec."Document Type"::Receipt:
                BEGIN
                    PDCSetupG.TESTFIELD("Posted Receipt Nos.");
                    Rec."Last Posting No." := NoSeriesMgtG.GetNextNo(PDCSetupG."Posted Receipt Nos.", Rec."Posting Date", TRUE);
                END;
            Rec."Document Type"::Issue:
                BEGIN
                    PDCSetupG.TESTFIELD(PDCSetupG."Posted Issue Nos");
                    Rec."Last Posting No." := NoSeriesMgtG.GetNextNo(PDCSetupG."Posted Issue Nos", Rec."Posting Date", TRUE);
                END;
        END;

        PostedPDCHdrG.INIT;
        PostedPDCHdrG.TRANSFERFIELDS(PDCHeaderG);
        PostedPDCHdrG."No." := Rec."Last Posting No.";
        PostedPDCHdrG.Status := PostedPDCHdrG.Status::Posted;
        PostedPDCHdrG.INSERT(TRUE);
        PDCLineG.RESET;
        PDCLineG.SETRANGE("Document Type", PDCHeaderG."Document Type");
        PDCLineG.SETRANGE("No.", PDCHeaderG."No.");
        IF PDCLineG.FINDSET THEN
            REPEAT
                PostedPDCLineG.INIT;
                PostedPDCLineG.TRANSFERFIELDS(PDCLineG);
                PostedPDCLineG."No." := Rec."Last Posting No.";
                PostedPDCLineG.Status := PostedPDCLineG.Status::Posted;
                PostedPDCLineG."Guarantee Check" := PostedPDCHdrG."Guarantee Cheque";
                PostedPDCLineG.INSERT(TRUE);
            UNTIL PDCLineG.NEXT = 0;

        PDCCommentLineG.RESET;
        PDCCommentLineG.SETRANGE("Voucher Type", PDCHeaderG."Document Type");
        PDCCommentLineG.SETRANGE("No.", PDCHeaderG."No.");
        IF PDCCommentLineG.FINDSET THEN
            REPEAT
                PostedPDCCommentLineG.INIT;
                PostedPDCCommentLineG.TRANSFERFIELDS(PDCCommentLineG);
                CASE Rec."Document Type" OF
                    Rec."Document Type"::Receipt:
                        PostedPDCCommentLineG."Voucher Type" := PostedPDCCommentLineG."Voucher Type"::PDCR;
                    Rec."Document Type"::Issue:
                        PostedPDCCommentLineG."Voucher Type" := PostedPDCCommentLineG."Voucher Type"::PDCI;
                END;
                PostedPDCCommentLineG."No." := PostedPDCHdrG."No.";
                PostedPDCCommentLineG.INSERT;
            UNTIL PDCCommentLineG.NEXT = 0;
    end;

    var
        PDCSetupG: Record "GAG PDC Setup";
        PDCHeaderG: Record "GAG PDC Header";
        PDCLineG: Record "GAG PDC Line";
        PostedPDCHdrG: Record "GAG Posted PDC Header";
        PostedPDCLineG: Record "GAG Posted PDC Line";
        PostedPDCCommentLineG: Record "GAG Voucher Comment Line";
        PDCCommentLineG: Record "GAG Voucher Comment Line";
        NoSeriesMgtG: codeunit NoSeriesManagement;
        C_INC_PostPDCJrnlConfirmation: Label 'Do you want to post the PDC Journal Lines?';
        C_INC_PostError: Label 'There is nothing post!';
}