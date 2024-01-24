pageextension 60101 "Apply Vendor Entries" extends "Apply Vendor Entries"
{
    procedure SetPDCLine(NewPDCLine: Record "GAG PDC Line"; ApplnTypeSelect: Integer)

    begin
        PDCLineG := NewPDCLine;

        IF PDCLineG."Account Type" = PDCLineG."Account Type"::Customer THEN
            ApplyingAmount := PDCLineG.Amount;
        IF PDCLineG."Account Type" = PDCLineG."Account Type"::Customer THEN
            ApplyingAmount := -PDCLineG.Amount;
        ApplnDate := PDCLineG."Posting Date";
        ApplnCurrencyCode := PDCLineG."Currency Code";
        CalcType := CalcType::PDCLine;

        CASE ApplnTypeSelect OF
            PDCLineG.FIELDNO("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PDCLineG.FIELDNO(PDCLineG."Cheque No."):
                ApplnType := ApplnType::"Applies-to ID";
        END;

        SetApplyingVendLedgEntry;
    end;

    var
        PDCLineG: Record "GAG PDC Line";
        CalcType: option PDCLine;
}
