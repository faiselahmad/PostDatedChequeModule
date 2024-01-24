table 60102 "GAG PDC Line"
{
    Caption = 'PDC Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ",Receipt,Issue;
            OptionCaption = ' ,Receipt,Issue';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            Trigger OnValidate()
            begin
                StatusCheckFunction(TRUE);

                GetPDCHeader;
                PDCHeaderG.TESTFIELD("Account Type");
                PDCHeaderG.TESTFIELD("Account No.");
                PDCHeaderG.TESTFIELD("Posting Date");

                "Account Type" := PDCHeaderG."Account Type";
                "Account No." := PDCHeaderG."Account No.";
                "Posting Date" := PDCHeaderG."Posting Date";
                "Bank Code" := PDCHeaderG."Bank Code";
                "Bank Name" := PDCHeaderG."Bank Name";
                "Currency Code" := PDCHeaderG."Currency Code";
                "Account Name" := PDCHeaderG."Account Name";
                "Location Code" := PDCHeaderG."Location Code";
                "Branch Code" := PDCHeaderG."Branch Code";
                "Salespers./Purch. Code" := PDCHeaderG."Salespers./Purch. Code";
                "Guarantee Check" := PDCHeaderG."Guarantee Cheque";
            end;
        }
        field(5; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            trigger OnValidate()
            begin
                StatusCheckFunction(TRUE);

                IF "Cheque Date" <= TODAY THEN
                    ERROR(C_GAG_DataValidation, FIELDCAPTION("Cheque Date"));

                "Due Date" := "Cheque Date";
            end;
        }
        field(6; "Due Date"; Date)
        {
            Caption = 'Due Date';
            trigger OnValidate()
            begin
                StatusCheckFunction(TRUE);

                TESTFIELD("Due Date");

                IF "Due Date" <= TODAY THEN
                    ERROR(C_GAG_DataValidation, FIELDCAPTION("Due Date"));

                IF "Due Date" < "Cheque Date" THEN
                    ERROR(C_GAG_DueDateValidation, FIELDCAPTION("Due Date"), FIELDCAPTION("Cheque Date"));
            end;
        }
        field(7; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(8; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(9; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = " ",Customer,Vendor;
            OptionCaption = '  ,Customer,Vendor';
        }
        field(10; "Account No."; Code[80])
        {
            Caption = 'Account No.';
        }
        field(11; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            trigger OnValidate()
            begin
                IF "Currency Code" = '' THEN
                    "Currency Factor" := 0;
                IF Amount <> 0 THEN
                    VALIDATE(Amount);
            end;
        }
        field(12; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            trigger OnLookup()
            begin
                IF Amount <> 0 THEN
                    VALIDATE(Amount);
            end;
        }
        field(13; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
        field(14; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(15; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(16; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Open,Posted,Processed,Cancelled,Returned;
            OptionCaption = '  ,Open,Posted,Processed,Cancelled,Returned';
        }
        field(17; "Initial Due Date"; Date)
        {
            Caption = 'Initial Due Date';
        }
        field(18; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
        }
        field(19; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(20; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(21; "Account Name"; Text[80])
        {
            Caption = 'Account Name';
        }
        field(22; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            trigger OnValidate()
            begin
                IF Amount <> 0 THEN
                    VALIDATE(Amount);
            end;
        }
        field(23; Amount; Decimal)
        {
            Caption = 'Amount';
            trigger OnValidate()
            var
                CurrExchRateL: Record "Currency Exchange Rate";
            begin
                StatusCheckFunction(TRUE);

                TESTFIELD("Cheque No.");
                TESTFIELD("Cheque Date");
                TESTFIELD("Due Date");
                IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN BEGIN
                    "Amount(LCY)" := ROUND(CurrExchRateL.ExchangeAmtFCYToLCY(
                              WORKDATE, "Currency Code", Amount,
                              "Currency Factor"), 0.00001);
                    IF "Exchange Rate" <> 0 THEN
                        "Amount(LCY)" := ROUND((Amount * "Exchange Rate"), 0.00001);
                END ELSE
                    "Amount(LCY)" := Amount;
            end;
        }
        field(24; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            trigger OnValidate()
            begin
                StatusCheckFunction(TRUE);
            end;
        }
        field(25; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            OptionCaption = '   ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';

            trigger OnValidate()
            begin
                IF "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" THEN
                    VALIDATE("Applies-to Doc. No.", '');
            end;
        }
        field(26; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            trigger OnValidate()
            VAR
                AccTypeL: option Customer;
                AccNoL: Code[20];

            begin
                IF "Applies-to Doc. No." <> xRec."Applies-to Doc. No." THEN
                    ClearCustVendApplnEntry;

                GetAccTypeAndNo(Rec, AccTypeL, AccNoL);
                IF ("Applies-to Doc. No." = '') AND (xRec."Applies-to Doc. No." <> '') THEN BEGIN
                    IF AccTypeL = AccTypeL::Customer THEN BEGIN
                        CustLedgEntryG.SETCURRENTKEY("Document No.");
                        CustLedgEntryG.SETRANGE("Document No.", xRec."Applies-to Doc. No.");
                        CustLedgEntryG.SETRANGE("Customer No.", AccNoL);
                        CustLedgEntryG.SETRANGE(Open, TRUE);
                        IF CustLedgEntryG.FINDFIRST THEN BEGIN
                            IF CustLedgEntryG."Amount to Apply" <> 0 THEN BEGIN
                                CustLedgEntryG."Amount to Apply" := 0;
                                CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgEntryG);
                            END;
                            "Applies-to Ext. Doc. No." := '';
                        END;
                    END ELSE
                        IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                            VendLedgEntryG.SETCURRENTKEY("Document No.");
                            VendLedgEntryG.SETRANGE("Document No.", xRec."Applies-to Doc. No.");
                            VendLedgEntryG.SETRANGE("Vendor No.", "Account No.");
                            VendLedgEntryG.SETRANGE(Open, TRUE);
                            IF VendLedgEntryG.FINDFIRST THEN BEGIN
                                IF VendLedgEntryG."Amount to Apply" <> 0 THEN BEGIN
                                    VendLedgEntryG."Amount to Apply" := 0;
                                    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntryG);
                                END;
                                "Applies-to Ext. Doc. No." := '';
                            END;
                        END;
                END;

                IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (Amount <> 0) THEN
                    SetApplyToAmount;
                CASE "Account Type" OF
                    "Account Type"::Customer:
                        GetCustLedgerEntry;
                    "Account Type"::Vendor:
                        GetVendLedgerEntry;
                END;
                ValidateApplyRequirements(Rec);
                SetJournalLineFieldsFromApplication;
            end;

            trigger OnLookup()
            var
                AccTypeL: Option Customer,Vendor;
                AccNoL: code[20];
            begin
                GetPDCHeader;
                PDCHeaderG.TESTFIELD("Account Type");
                PDCHeaderG.TESTFIELD("Account No.");

                xRec.Amount := Amount;
                xRec."Currency Code" := "Currency Code";
                xRec."Posting Date" := "Posting Date";
                GetAccTypeAndNo(Rec, AccTypeL, AccNoL);
                CLEAR(CustLedgEntryG);
                CLEAR(VendLedgEntryG);

                CASE AccTypeL OF
                    AccTypeL::Customer:
                        LookUpAppliesToDocCust(AccNoL);
                    AccTypeL::Vendor:
                        LookUpAppliesToDocVend(AccNoL);
                END;
                SetJournalLineFieldsFromApplication;
            end;
        }
        field(27; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
        }
        field(28; "Applies-to Ext. Doc. No."; Code[20])
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        field(29; "Voucher Created"; Boolean)
        {
            Caption = 'Voucher Created';
        }
        field(30; "In the Name of"; Text[30])
        {
            Caption = 'In the Name of';
        }
        field(31; "From (Customer Company)"; Text[30])
        {
            Caption = 'From (Customer Company)';
        }
        field(32; "Guarantee Check"; Boolean)
        {
            Caption = 'Guarantee Check';
        }
    }
    keys
    {
        key(PK; "Document Type", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure LookUpAppliesToDocVend(AccNo: Code[20])

    begin
        CLEAR(VendLedgEntryG);
        VendLedgEntryG.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");
        IF AccNo <> '' THEN
            VendLedgEntryG.SETRANGE("Vendor No.", AccNo);
        VendLedgEntryG.SETRANGE(Open, TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            VendLedgEntryG.SETRANGE("Document Type", "Applies-to Doc. Type");
            VendLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF VendLedgEntryG.ISEMPTY THEN BEGIN
                VendLedgEntryG.SETRANGE("Document Type");
                VendLedgEntryG.SETRANGE("Document No.");
            END;
        END;
        IF "Applies-to ID" <> '' THEN BEGIN
            VendLedgEntryG.SETRANGE("Applies-to ID", "Applies-to ID");
            IF VendLedgEntryG.ISEMPTY THEN
                VendLedgEntryG.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
            VendLedgEntryG.SETRANGE("Document Type", "Applies-to Doc. Type");
            IF VendLedgEntryG.ISEMPTY THEN
                VendLedgEntryG.SETRANGE("Document Type");
        END;
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            VendLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF VendLedgEntryG.ISEMPTY THEN
                VendLedgEntryG.SETRANGE("Document No.");
        END;
        IF Amount <> 0 THEN BEGIN
            VendLedgEntryG.SETRANGE(Positive, Amount < 0);
            IF VendLedgEntryG.ISEMPTY THEN;
            VendLedgEntryG.SETRANGE(Positive);
        END;
        ApplyVendEntries.SetPDCLine(Rec, PDCLIneG.FIELDNO("Applies-to Doc. No."));

        ApplyVendEntries.SETTABLEVIEW(VendLedgEntryG);
        ApplyVendEntries.SETRECORD(VendLedgEntryG);
        ApplyVendEntries.LOOKUPMODE(TRUE);
        IF ApplyVendEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ApplyVendEntries.GETRECORD(VendLedgEntryG);
            IF AccNo = '' THEN BEGIN
                AccNo := VendLedgEntryG."Vendor No.";
                IF "Account Type" = "Account Type"::Vendor THEN
                    VALIDATE("Account No.", AccNo);
            END;
            SetAmountWithVendLedgEntry;
            "Applies-to Doc. Type" := VendLedgEntryG."Document Type";
            "Applies-to Doc. No." := VendLedgEntryG."Document No.";
            "Applies-to ID" := '';
        END;

    end;

    procedure SetAmountWithVendLedgEntry()

    begin
        IF "Currency Code" <> VendLedgEntryG."Currency Code" THEN
            CheckModifyCurrencyCode(PDCLIneG."Account Type"::Vendor, VendLedgEntryG."Currency Code");
        IF Amount = 0 THEN BEGIN
            VendLedgEntryG.CALCFIELDS("Remaining Amount");
            SetAmountWithRemaining(
              FALSE,
              VendLedgEntryG."Amount to Apply", VendLedgEntryG."Remaining Amount", VendLedgEntryG."Remaining Pmt. Disc. Possible");
        END;
    end;

    procedure LookUpAppliesToDocCust(AccNo: Code[20])
    var
        ApplyCustEntries: Page "Apply Customer Entries";
    begin
        CLEAR(CustLedgEntryG);
        CustLedgEntryG.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date");
        IF AccNo <> '' THEN
            CustLedgEntryG.SETRANGE("Customer No.", AccNo);
        CustLedgEntryG.SETRANGE(Open, TRUE);
        IF "Applies-to Doc. No." <> '' THEN BEGIN
            CustLedgEntryG.SETRANGE("Document Type", "Applies-to Doc. Type");
            CustLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
            IF CustLedgEntryG.ISEMPTY THEN BEGIN
                CustLedgEntryG.SETRANGE("Document Type");
                CustLedgEntryG.SETRANGE("Document No.");
            END;
        END;
        IF "Cheque No." <> '' THEN BEGIN
            CustLedgEntryG.SETRANGE("Applies-to ID", "Cheque No.");
            IF CustLedgEntryG.ISEMPTY THEN
                CustLedgEntryG.SETRANGE("Applies-to ID");
        END;
        IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
            CustLedgEntryG.SETRANGE("Document Type", "Applies-to Doc. Type");
            IF CustLedgEntryG.ISEMPTY THEN
                CustLedgEntryG.SETRANGE("Document Type");
        END;
        IF Amount <> 0 THEN BEGIN
            CustLedgEntryG.SETRANGE(Positive, Amount < 0);
            IF CustLedgEntryG.ISEMPTY THEN
                CustLedgEntryG.SETRANGE(Positive);
        END;
        ApplyCustEntries.SetPDCLine(Rec, PDCLIneG.FIELDNO("Applies-to Doc. No."));

        ApplyCustEntries.SETTABLEVIEW(CustLedgEntryG);
        ApplyCustEntries.SETRECORD(CustLedgEntryG);
        ApplyCustEntries.LOOKUPMODE(TRUE);
        IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ApplyCustEntries.GETRECORD(CustLedgEntryG);
            IF AccNo = '' THEN BEGIN
                AccNo := CustLedgEntryG."Customer No.";
                IF "Account Type" = "Account Type"::Customer THEN
                    VALIDATE("Account No.", AccNo);
            END;
            SetAmountWithCustLedgEntry;
            "Applies-to Doc. Type" := CustLedgEntryG."Document Type";
            "Applies-to Doc. No." := CustLedgEntryG."Document No.";
            "Applies-to ID" := '';
        END;
    end;

    procedure SetAmountWithRemaining(CalcPmtDisc: Boolean; AmountToApply: Decimal; RemainingAmount: Decimal; RemainingPmtDiscPossible: Decimal)

    begin
        IF AmountToApply <> 0 THEN
            IF CalcPmtDisc AND (ABS(AmountToApply) >= ABS(RemainingAmount - RemainingPmtDiscPossible)) THEN
                Amount := -(RemainingAmount - RemainingPmtDiscPossible)
            ELSE
                Amount := -AmountToApply
        ELSE
            IF CalcPmtDisc THEN
                Amount := -(RemainingAmount - RemainingPmtDiscPossible)
            ELSE
                Amount := -RemainingAmount;
        IF "Account Type" IN ["Account Type"::Customer, "Account Type"::Vendor] THEN
            Amount := -Amount;
        VALIDATE(Amount);
    end;

    procedure SetAmountWithCustLedgEntry()
    begin
        IF "Currency Code" <> CustLedgEntryG."Currency Code" THEN
            CheckModifyCurrencyCode(PDCLIneG."Account Type"::Customer, CustLedgEntryG."Currency Code");
        IF Amount = 0 THEN BEGIN
            CustLedgEntryG.CALCFIELDS("Remaining Amount");
            SetAmountWithRemaining(
              FALSE,
              CustLedgEntryG."Amount to Apply", CustLedgEntryG."Remaining Amount", CustLedgEntryG."Remaining Pmt. Disc. Possible");
        END;
    end;

    procedure CheckModifyCurrencyCode(AccountType: Option; CustVendLedgEntryCurrencyCode: Code[10])
    begin
        IF Amount = 0 THEN BEGIN
            FromCurrencyCodeG := GetShowCurrencyCode("Currency Code");
            ToCurrencyCodeG := GetShowCurrencyCode(CustVendLedgEntryCurrencyCode);
            IF NOT
               CONFIRM(
                 Text003, TRUE, FIELDCAPTION("Currency Code"), TABLECAPTION, FromCurrencyCodeG, ToCurrencyCodeG)
            THEN
                ERROR(Text005);
            VALIDATE("Currency Code", CustVendLedgEntryCurrencyCode);
        END ELSE
            GenJnlApplyG.CheckAgainstApplnCurrency(
              "Currency Code", CustVendLedgEntryCurrencyCode, AccountType, TRUE);
    end;

    procedure SetJournalLineFieldsFromApplication()
    VAR
        AccType: option Customer,Vendor;
        AccNo: Code[20];
    begin
        GetAccTypeAndNo(Rec, AccType, AccNo);
        CASE AccType OF
            AccType::Customer:
                IF "Applies-to Doc. No." <> '' THEN
                    IF FindFirstCustLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") THEN BEGIN
                        "Applies-to Ext. Doc. No." := CustLedgEntryG."External Document No.";
                        "Branch Code" := CustLedgEntryG."Branch Code";
                        "Applies-to ID" := CustLedgEntryG."Applies-to ID";
                    END;
            AccType::Vendor:
                IF "Applies-to Doc. No." <> '' THEN
                    IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") THEN BEGIN
                        "Applies-to Ext. Doc. No." := VendLedgEntryG."External Document No.";
                        "Branch Code" := VendLedgEntryG."Branch Code";
                        "Applies-to ID" := VendLedgEntryG."Applies-to ID";
                    END;
        END;
    end;

    procedure ValidateApplyRequirements(TempPDCLineP: Record "GAG PDC Line" TEMPORARY)

    begin
        IF TempPDCLineP."Account Type" = TempPDCLineP."Account Type"::Customer THEN BEGIN
            IF TempPDCLineP."Applies-to ID" <> '' THEN BEGIN
                CustLedgEntryG.SETCURRENTKEY("Customer No.", "Applies-to ID", Open);
                CustLedgEntryG.SETRANGE("Customer No.", TempPDCLineP."Account No.");
                CustLedgEntryG.SETRANGE("Applies-to ID", TempPDCLineP."Applies-to ID");
                CustLedgEntryG.SETRANGE(Open, TRUE);
                IF CustLedgEntryG.FINDSET THEN
                    REPEAT
                        IF TempPDCLineP."Posting Date" < CustLedgEntryG."Posting Date" THEN
                            ERROR(
                              Text015, TempPDCLineP."Document Type", TempPDCLineP."No.",
                              CustLedgEntryG."Document Type", CustLedgEntryG."Document No.");
                    UNTIL CustLedgEntryG.NEXT = 0;
            END ELSE
                IF TempPDCLineP."Applies-to Doc. No." <> '' THEN BEGIN
                    CustLedgEntryG.SETCURRENTKEY("Document No.");
                    CustLedgEntryG.SETRANGE("Document No.", TempPDCLineP."Applies-to Doc. No.");
                    IF TempPDCLineP."Applies-to Doc. Type" <> TempPDCLineP."Applies-to Doc. Type"::" " THEN
                        CustLedgEntryG.SETRANGE("Document Type", TempPDCLineP."Applies-to Doc. Type");
                    CustLedgEntryG.SETRANGE("Customer No.", TempPDCLineP."Account No.");
                    CustLedgEntryG.SETRANGE(Open, TRUE);
                    IF CustLedgEntryG.FINDFIRST THEN
                        IF TempPDCLineP."Posting Date" < CustLedgEntryG."Posting Date" THEN
                            ERROR(
                              Text015, TempPDCLineP."Document Type", TempPDCLineP."No.",
                              CustLedgEntryG."Document Type", CustLedgEntryG."Document No.");
                END;
        END ELSE
            IF TempPDCLineP."Account Type" = TempPDCLineP."Account Type"::Vendor THEN BEGIN
                IF TempPDCLineP."Applies-to ID" <> '' THEN BEGIN
                    VendLedgEntryG.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open);
                    VendLedgEntryG.SETRANGE("Vendor No.", TempPDCLineP."Account No.");
                    VendLedgEntryG.SETRANGE("Applies-to ID", TempPDCLineP."Applies-to ID");
                    VendLedgEntryG.SETRANGE(Open, TRUE);
                    REPEAT
                        IF TempPDCLineP."Posting Date" < VendLedgEntryG."Posting Date" THEN
                            ERROR(
                              Text015, TempPDCLineP."Document Type", TempPDCLineP."No.",
                              VendLedgEntryG."Document Type", VendLedgEntryG."Document No.");
                    UNTIL VendLedgEntryG.NEXT = 0;
                    IF VendLedgEntryG.FINDFIRST THEN
                      ;
                END ELSE
                    IF TempPDCLineP."Applies-to Doc. No." <> '' THEN BEGIN
                        VendLedgEntryG.SETCURRENTKEY("Document No.");
                        VendLedgEntryG.SETRANGE("Document No.", TempPDCLineP."Applies-to Doc. No.");
                        IF TempPDCLineP."Applies-to Doc. Type" <> TempPDCLineP."Applies-to Doc. Type"::" " THEN
                            VendLedgEntryG.SETRANGE("Document Type", TempPDCLineP."Applies-to Doc. Type");
                        VendLedgEntryG.SETRANGE("Vendor No.", TempPDCLineP."Account No.");
                        VendLedgEntryG.SETRANGE(Open, TRUE);
                        IF VendLedgEntryG.FINDFIRST THEN
                            IF TempPDCLineP."Posting Date" < VendLedgEntryG."Posting Date" THEN
                                ERROR(
                                  Text015, TempPDCLineP."Document Type", TempPDCLineP."No.",
                                  VendLedgEntryG."Document Type", VendLedgEntryG."Document No.");
                    END;
            END;

    end;

    procedure GetVendLedgerEntry()

    begin
        IF ("Account Type" = "Account Type"::Vendor) AND ("Account No." = '') AND
   ("Applies-to Doc. No." <> '') AND (Amount = 0)
THEN BEGIN
            VendLedgEntryG.RESET;
            VendLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
            VendLedgEntryG.SETRANGE(Open, TRUE);
            IF NOT VendLedgEntryG.FINDFIRST THEN
                ERROR(NotExistErr, "Applies-to Doc. No.");

            VALIDATE("Account No.", VendLedgEntryG."Vendor No.");
            VendLedgEntryG.CALCFIELDS("Remaining Amount");

            IF "Posting Date" <= VendLedgEntryG."Pmt. Discount Date" THEN
                Amount := -(CustLedgEntryG."Remaining Amount" - VendLedgEntryG."Remaining Pmt. Disc. Possible")
            ELSE
                Amount := -VendLedgEntryG."Remaining Amount";

            IF "Currency Code" <> VendLedgEntryG."Currency Code" THEN BEGIN
                FromCurrencyCode := GetShowCurrencyCode("Currency Code");
                ToCurrencyCode := GetShowCurrencyCode(CustLedgEntryG."Currency Code");
                IF NOT
                   CONFIRM(
                     Text003,
                     TRUE, FIELDCAPTION("Currency Code"), TABLECAPTION, FromCurrencyCode, ToCurrencyCode)
                THEN
                    ERROR(Text005);
                VALIDATE("Currency Code", VendLedgEntryG."Currency Code");
            END;
        END;

    end;

    procedure GetCustLedgerEntry()

    begin
        IF ("Account Type" = "Account Type"::Customer) AND ("Account No." = '') AND
   ("Applies-to Doc. No." <> '') AND (Amount = 0)
THEN BEGIN
            CustLedgEntryG.RESET;
            CustLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
            CustLedgEntryG.SETRANGE(Open, TRUE);
            IF NOT CustLedgEntryG.FINDFIRST THEN
                ERROR(NotExistErr, "Applies-to Doc. No.");

            VALIDATE("Account No.", CustLedgEntryG."Customer No.");
            CustLedgEntryG.CALCFIELDS("Remaining Amount");

            IF "Posting Date" <= CustLedgEntryG."Pmt. Discount Date" THEN
                Amount := -(CustLedgEntryG."Remaining Amount" - CustLedgEntryG."Remaining Pmt. Disc. Possible")
            ELSE
                Amount := -CustLedgEntryG."Remaining Amount";

            IF "Currency Code" <> CustLedgEntryG."Currency Code" THEN BEGIN
                FromCurrencyCode := GetShowCurrencyCode("Currency Code");
                ToCurrencyCode := GetShowCurrencyCode(CustLedgEntryG."Currency Code");
                IF NOT
                   CONFIRM(
                     Text003, TRUE,
                     FIELDCAPTION("Currency Code"), TABLECAPTION, FromCurrencyCode,
                     ToCurrencyCode)
                THEN
                    ERROR(Text005);
                VALIDATE("Currency Code", CustLedgEntryG."Currency Code");
            END;
        END;
    end;

    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10]

    begin
        IF CurrencyCode <> '' THEN
            EXIT(CurrencyCode);

        EXIT(Text009);
    end;

    procedure SetApplyToAmount()

    begin
        IF "Account Type" = "Account Type"::Customer THEN BEGIN
            CustLedgEntryG.SETCURRENTKEY("Document No.");
            CustLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
            CustLedgEntryG.SETRANGE("Customer No.", "Account No.");
            CustLedgEntryG.SETRANGE(Open, TRUE);
            IF CustLedgEntryG.FINDFIRST THEN
                IF CustLedgEntryG."Amount to Apply" = 0 THEN BEGIN
                    CustLedgEntryG.CALCFIELDS("Remaining Amount");
                    CustLedgEntryG."Amount to Apply" := CustLedgEntryG."Remaining Amount";
                    CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgEntryG);
                END;
        END ELSE
            IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                VendLedgEntryG.SETCURRENTKEY("Document No.");
                VendLedgEntryG.SETRANGE("Document No.", "Applies-to Doc. No.");
                VendLedgEntryG.SETRANGE("Vendor No.", "Account No.");
                VendLedgEntryG.SETRANGE(Open, TRUE);
                IF VendLedgEntryG.FINDFIRST THEN
                    IF VendLedgEntryG."Amount to Apply" = 0 THEN BEGIN
                        VendLedgEntryG.CALCFIELDS("Remaining Amount");
                        VendLedgEntryG."Amount to Apply" := VendLedgEntryG."Remaining Amount";
                        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntryG);
                    END;
            END;

    end;

    procedure StatusCheckFunction(CheckFieldNumberP: Boolean)

    begin
        IF CheckFieldNumberP AND (CurrFieldNo = 0) THEN;
        EXIT;
        GetPDCHeader();
        PDCHeaderG.ApplyStatusFunction(FALSE);
    end;

    procedure GetPDCHeader()

    begin
        PDCHeaderG.GET("Document Type", "No.");
    end;

    procedure ClearCustVendApplnEntry()
    VAR
        AccTypeL: Option Customer,Vendor;
        AccNoL: Code[20];
        TempVendLedgEntryL: Record "Vendor Ledger Entry";
        TempCustLedgEntryL: Record "Cust. Ledger Entry";
        VendEntryEditL: Codeunit "Vend. Entry-Edit";
        CustEntryEditL: Codeunit "Cust. Entry-Edit";
    begin
        GetAccTypeAndNo(Rec, AccTypeL, AccNoL);
        CASE AccTypeL OF
            AccTypeL::Customer:
                IF xRec."Applies-to ID" <> '' THEN BEGIN
                    IF FindFirstCustLedgEntryWithAppliesToID(AccNoL, xRec."Applies-to ID") THEN BEGIN
                        ClearCustApplnEntryFields;
                        CustEntrySetApplIDG.SetApplId(CustLedgEntryG, TempCustLedgEntryL, '');
                    END
                END ELSE
                    IF xRec."Applies-to Doc. No." <> '' THEN
                        IF FindFirstCustLedgEntryWithAppliesToDocNo(AccNoL, xRec."Applies-to Doc. No.") THEN BEGIN
                            ClearCustApplnEntryFields;
                            CustEntryEditL.RUN(CustLedgEntryG);
                        END;
            AccTypeL::Vendor:
                IF xRec."Applies-to ID" <> '' THEN BEGIN
                    IF FindFirstVendLedgEntryWithAppliesToID(AccNoL, xRec."Applies-to ID") THEN BEGIN
                        ClearVendApplnEntryFields;
                        VendEntrySetApplIDG.SetApplId(VendLedgEntryG, TempVendLedgEntryL, '');
                    END
                END ELSE
                    IF xRec."Applies-to Doc. No." <> '' THEN
                        IF FindFirstVendLedgEntryWithAppliesToDocNo(AccNoL, xRec."Applies-to Doc. No.") THEN BEGIN
                            ClearVendApplnEntryFields;
                            VendEntryEditL.RUN(VendLedgEntryG);
                        END;
        END;
    end;

    procedure FindFirstVendLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        VendLedgEntryG.RESET;
        VendLedgEntryG.SETCURRENTKEY("Document No.");
        VendLedgEntryG.SETRANGE("Document No.", AppliestoDocNo);
        VendLedgEntryG.SETRANGE("Document Type", "Applies-to Doc. Type");
        VendLedgEntryG.SETRANGE("Vendor No.", AccNo);
        VendLedgEntryG.SETRANGE(Open, TRUE);
        EXIT(VendLedgEntryG.FINDFIRST)
    end;

    procedure ClearVendApplnEntryFields()

    begin
        VendLedgEntryG."Amount to Apply" := 0;
    end;

    Local procedure GetAccTypeAndNo(PDCLine2: Record "GAG PDC Line"; VAR AccType: Option; VAR AccNo: Code[20])
    begin
        IF PDCLine2."Account Type" IN
   [PDCLine2."Account Type"::Customer, PDCLine2."Account Type"::Vendor]
THEN BEGIN
            AccType := PDCLine2."Account Type";
            AccNo := PDCLine2."Account No.";
        END;
    end;

    procedure FindFirstCustLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        CustLedgEntryG.RESET;
        CustLedgEntryG.SETCURRENTKEY("Customer No.", "Applies-to ID", Open);
        CustLedgEntryG.SETRANGE("Customer No.", AccNo);
        CustLedgEntryG.SETRANGE("Applies-to ID", AppliesToID);
        CustLedgEntryG.SETRANGE(Open, TRUE);
        EXIT(CustLedgEntryG.FINDFIRST)
    end;

    procedure FindFirstVendLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean

    begin
        VendLedgEntryG.RESET;
        VendLedgEntryG.SETCURRENTKEY("Vendor No.", "Applies-to ID", Open);
        VendLedgEntryG.SETRANGE("Vendor No.", AccNo);
        VendLedgEntryG.SETRANGE("Applies-to ID", AppliesToID);
        VendLedgEntryG.SETRANGE(Open, TRUE);
        EXIT(VendLedgEntryG.FINDFIRST)
    end;

    procedure ClearCustApplnEntryFields()

    begin
        CustLedgEntryG."Amount to Apply" := 0;
    end;

    procedure FindFirstCustLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean

    begin
        CustLedgEntryG.RESET;
        CustLedgEntryG.SETCURRENTKEY("Document No.");
        CustLedgEntryG.SETRANGE("Document No.", AppliestoDocNo);
        CustLedgEntryG.SETRANGE("Document Type", "Applies-to Doc. Type");
        CustLedgEntryG.SETRANGE("Customer No.", AccNo);
        CustLedgEntryG.SETRANGE(Open, TRUE);
        EXIT(CustLedgEntryG.FINDFIRST)

    end;

    trigger OnInsert()
    begin
        GetPDCHeader;
        PDCHeaderG.TESTFIELD("Account Type");
        PDCHeaderG.TESTFIELD("Account No.");
        PDCHeaderG.TESTFIELD("Posting Date");
        "Account Type" := PDCHeaderG."Account Type";
        "Account No." := PDCHeaderG."Account No.";
        "Posting Date" := PDCHeaderG."Posting Date";
        "Bank Code" := PDCHeaderG."Bank Code";
        "Bank Name" := PDCHeaderG."Bank Name";
        "Currency Code" := PDCHeaderG."Currency Code";
        "Guarantee Check" := PDCHeaderG."Guarantee Cheque";
    end;

    trigger OnModify()
    begin
        GetPDCHeader;
        PDCHeaderG.TESTFIELD("Account Type");
        PDCHeaderG.TESTFIELD("Account No.");
        PDCHeaderG.TESTFIELD("Posting Date");
        "Account Type" := PDCHeaderG."Account Type";
        "Account No." := PDCHeaderG."Account No.";
        "Posting Date" := PDCHeaderG."Posting Date";
        "Bank Code" := PDCHeaderG."Bank Code";
        "Bank Name" := PDCHeaderG."Bank Name";
        "Currency Code" := PDCHeaderG."Currency Code";
        "Guarantee Check" := PDCHeaderG."Guarantee Cheque";
    end;

    var
        PDCHeaderG: Record "GAG PDC Header";
        CustLedgEntryG: Record "Cust. Ledger Entry";
        VendLedgEntryG: Record "Vendor Ledger Entry";
        CustEntrySetApplIDG: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplIDG: Codeunit "Vend. Entry-SetAppl.ID";
        NotExistErr: label 'Document No. %1 does not exist or is already closed.';
        Text003: label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text005: label 'The update has been interrupted to respect the warning.';
        FromCurrencyCode: Code[20];
        ToCurrencyCode: Code[20];
        Text009: label 'LCY';
        Text015: Label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        C_GAG_DataValidation: label '%1 should always be in future date!';
        C_GAG_DueDateValidation: label '%1 should not be prior to %2 !';
        PDCLIneG: Record "GAG PDC Line";
        FromCurrencyCodeG: code[10];
        ToCurrencyCodeG: code[10];
        GenJnlApplyG: codeunit "Gen. Jnl.-Apply";
        ApplyVendEntries: Page "Apply Vendor Entries";
}
