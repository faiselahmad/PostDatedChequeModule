table 60100 "GAG PDC Header"
{
    Caption = 'PDC Header';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", "Account Type", "Account No.";
    DataPerCompany = true;



    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Documents';
            OptionMembers = Receipt,Issue;

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            var

            BEGIN
                IF "No." <> xRec."No." THEN BEGIN
                    PDCSetupG.GET;
                    NoSeriesMgtG.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            END;

        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
            end;
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = " ",Customer,Vendor;
            OptionCaption = ',Customer,Vendor';
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
                UpdatePDCLines(FIELDNAME("Account Type"));
            end;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer."No." WHERE(Blocked = FILTER('')) ELSE
            IF ("Account Type" = FILTER(Vendor)) Vendor."No." WHERE(Blocked = FILTER(''));

            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
                CASE "Account Type" OF
                    "Account Type"::Customer:
                        BEGIN
                            CustomerG.GET("Account No.");
                            "Account Name" := CustomerG.Name;
                            "Shortcut Dimension 1 Code" := CustomerG."Global Dimension 1 Code";
                            "Shortcut Dimension 2 Code" := CustomerG."Global Dimension 2 Code";
                            Division := CustomerG."GAG Division Code";
                            "Salespers./Purch. Code" := CustomerG."Salesperson Code";
                            "Applies to Order Type" := "Applies to Order Type"::"Vehicle Sales";
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            VendorG.GET("Account No.");
                            "Account Name" := VendorG.Name;
                            Division := VendorG."GAG Division Code";
                            "Shortcut Dimension 1 Code" := VendorG."Global Dimension 1 Code";
                            "Shortcut Dimension 2 Code" := VendorG."Global Dimension 2 Code";
                            "Salespers./Purch. Code" := VendorG."Purchaser Code";
                            "Applies to Order Type" := "Applies to Order Type"::"Vehicle Purchases";
                        END;
                    ELSE
                        CLEAR("Account Name");
                END;
                VALIDATE("Location Code", UserSessionG.GetLocation);
                "Branch Code" := UserSessionG.GetBranchCode("Location Code");

                UpdatePDCLines(FIELDNAME("Account No."));
                UpdatePDCLines(FIELDNAME("Salespers./Purch. Code"));
                UpdatePDCLines(FIELDNAME("Location Code"));
                UpdatePDCLines(FIELDNAME("Branch Code"));
            end;
        }
        field(6; "Account Name"; Text[80])
        {
            Caption = 'Account Name';
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
                IF CurrFieldNo <> FIELDNO("Currency Code") THEN
                    UpdateCurrencyFactor
                ELSE BEGIN
                    IF "Currency Code" <> xRec."Currency Code" THEN
                        UpdateCurrencyFactor
                    ELSE
                        IF "Currency Code" <> '' THEN BEGIN
                            UpdateCurrencyFactor;
                            IF "Currency Factor" <> xRec."Currency Factor" THEN
                                ConfirmUpdateCurrencyFactor;
                        END;
                END;

                UpdatePDCLines(FIELDNAME("Currency Code"));
            end;
        }
        field(8; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            trigger OnValidate()
            begin
                IF "Currency Factor" <> xRec."Currency Factor" THEN
                    UpdatePDCLines(FIELDNAME("Currency Factor"));
            end;
        }
        field(9; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
                IF BankAccountG.GET("Bank Code") THEN BEGIN
                    "Bank Name" := BankAccountG.Name;
                END ELSE
                    CLEAR("Bank Name");

                UpdatePDCLines(FIELDNAME("Bank Code"));
            end;
        }
        field(10; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(13; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';

            trigger OnValidate()
            var
                UserSetupL: Record "User Setup";
            begin
                UserSetupL.GET(USERID);
                UserSetupL.TESTFIELD("Allow to Modify Exchange Rate", true);
                TESTFIELD("Currency Code");
                TESTFIELD("Currency Factor");
                IF "Exchange Rate" <> 0 THEN BEGIN
                    Rec.VALIDATE("Currency Factor", 1 / "Exchange Rate");

                END ELSE BEGIN
                    VALIDATE("Currency Factor", 1);
                    VALIDATE("Currency Code", '');
                END;
                IF "Currency Factor" <> xRec."Currency Factor" THEN
                    UpdatePDCLines(FIELDNAME("Exchange Rate"));
            end;
        }
        field(14; "Cheque Received From/Issue To"; Text[50])
        {
            Caption = 'Received From';
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
            end;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Open,Posted,"Partially Processed",Processed,Cancelled,Returned;
            OptionCaption = ',Open,Posted,Partially Processed,Processed,Cancelled,Returned';
        }
        field(16; Division; Code[20])
        {
            Caption = 'Division';
            TableRelation = "GAG Division Code";
        }
        field(17; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
        }
        field(18; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
                IF BankAccountG.GET("Bank Code") THEN BEGIN
                    "Bank Name" := BankAccountG.Name;
                END ELSE
                    CLEAR("Bank Name");

                UpdatePDCLines(FIELDNAME("Bank Code"));
            end;
        }
        field(19; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);

                IF "Location Code" > '' THEN
                    "Branch Code" := UserSessionG.GetBranchCode("Location Code");
            end;
        }
        field(20; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
        }
        field(21; "Document Date"; Date)
        {
            Caption = 'Document Date';
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
            end;
        }
        field(22; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            trigger OnValidate()
            begin
                ApplyStatusFunction(TRUE);
                UpdatePDCLines(FIELDNAME("Posting Date"));
            end;
        }
        field(23; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(24; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(25; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(26; "Last Change Date"; Date)
        {
            Caption = 'Last Change Date';
        }
        field(27; "Last Change by"; Code[50])
        {
            Caption = 'Last Change by';
        }
        field(28; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(29; "Applies to Order Type"; Option)
        {
            Caption = 'Applies to Order Type';
            OptionMembers = " ","Parts Purchases","Parts Sales","Vehicle Purchases","Vehicle Sales","Service Sales","Service Purchases";
            OptionCaption = ' ,Parts Purchases,Parts Sales,Vehicle Purchases,Vehicle Sales,Service Sales,Service Purchases';
            trigger OnValidate()
            begin
                TESTFIELD("Account No.");
                IF "Applies to Order Type" IN ["Applies to Order Type"::"Parts Purchases",
                                               "Applies to Order Type"::"Vehicle Purchases",
                                               "Applies to Order Type"::"Service Purchases"] THEN
                    TESTFIELD("Account Type", "Account Type"::Vendor);
                IF "Applies to Order Type" IN ["Applies to Order Type"::"Parts Sales",
                                               "Applies to Order Type"::"Vehicle Sales",
                                               "Applies to Order Type"::"Service Sales"] THEN
                    TESTFIELD("Account Type", "Account Type"::Customer);
            end;
        }
        field(30; "Applies to Order No."; Code[20])
        {
            Caption = 'Applies to Order No.';

            TableRelation = IF ("Applies to Order Type" = FILTER("Parts Purchases")) "Purchase Header"."No." WHERE("Document Type" = FILTER(Order),
            "Order Type" = FILTER('Parts Sales & Purchases'), "Buy-from Vendor No." = FIELD("Account No.")) ELSE
            IF ("Applies to Order Type" = FILTER("Vehicle Purchases")) "Purchase Header"."No." WHERE("Document Type" = FILTER(Order),
            "Order Type" = FILTER('Vehicle Sales & Purchases'), "Buy-from Vendor No." = FIELD("Account No.")) ELSE
            IF ("Applies to Order Type" = FILTER("Service Purchases")) "Purchase Header"."No." WHERE("Document Type" = FILTER(Order),
            "Order Type" = FILTER('Services'), "Buy-from Vendor No." = FIELD("Account No.")) ELSE
            IF ("Applies to Order Type" = FILTER("Parts Sales")) "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
            "Order Type" = FILTER('Parts Sales & Purchases'), "Sell-to Customer No." = FIELD("Account No.")) ELSE
            IF ("Applies to Order Type" = FILTER("Vehicle Sales")) "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
            "Order Type" = FILTER('Vehicle Sales & Purchases'), "Sell-to Customer No." = FIELD("Account No.")) ELSE
            IF ("Applies to Order Type" = FILTER("Service Sales")) "Service Header"."No." WHERE("Document Type" = FILTER(Order), "Sell-to Customer No." = FIELD("Account No."));

            Editable = true;
            ValidateTableRelation = true;
            DataClassification = ToBeClassified;
        }
        field(31; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("GAG PDC Line".Amount WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No.")));
        }
        field(32; "Amount(LCY)"; Decimal)
        {
            Caption = 'Amount(LCY)';
            FieldClass = FlowField;
            CalcFormula = Sum("GAG PDC Line"."Amount(LCY)" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No.")));
        }
        field(33; "Status Code"; Code[20])
        {
            Caption = 'Document Status Code';

            trigger OnValidate()
            var
                AreaL: Integer;
            begin
                IF "Status Code" = xRec."Status Code" THEN
                    EXIT;
                IF "Document Type" = "Document Type"::Receipt THEN
                    AreaL := 2
                ELSE
                    IF "Document Type" = "Document Type"::Issue THEN
                        AreaL := 3;
                GAGStatusHistoryG.UpdateStatusHistory(AreaL, "No.", "Status Code");
                IF GAGDocStatusLineG.GET(AreaL, "Status Code") THEN BEGIN
                    GAGDocStatusLineG.SetDocumentNo("No.");
                    GAGDocStatusLineG.SetCommBuffer(TempCommBufferG);
                    GAGDocStatusLineG.ExecuteSpecificCU();
                    GAGDocStatusLineG.ExecuteNotifications();
                    GAGDocStatusLineG.SendMessage();
                END;
            end;
        }
        field(34; "Pre-Document No."; Code[20])
        {
            Caption = 'Pre-Document No.';
        }
        field(35; "Status Description"; Text[80])
        {
            Caption = 'Status Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("Status List".Description WHERE(Code = FIELD("Status Code")));
        }
        field(36; "Approval Requested By"; Code[50])
        {
            Caption = 'Approval Requested By';
        }
        field(37; "Approval Approved/Rejected By"; Code[50])
        {
            Caption = 'Approval Approved/Rejected By';
        }
        field(38; "Guarantee Cheque"; Boolean)
        {
            Caption = 'Guarantee Cheque';
        }
        field(39; "Is Cheque Returned"; Boolean)
        {
            Caption = 'Is Cheque Returned';
        }
    }

    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
    procedure AssitEdit(OldPDCHeaderP: Record "GAG PDC Header"): Boolean

    begin
        WITH PDCHeaderG DO BEGIN
            PDCHeaderG := Rec;
            PDCSetupG.GET;
            PDCSetupG.TESTFIELD(PDCSetupG."Receipts Nos.");
            IF NoSeriesMgtG.SelectSeries(GetNoSeriesCode, OldPDCHeaderP."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgtG.SetSeries("No.");
                Rec := PDCHeaderG;
                EXIT(TRUE);
            END;
        END;
    end;

    procedure TestNoSeries(): Boolean
    begin
        CASE "Document Type" OF
            "Document Type"::Receipt:
                PDCSetupG.TESTFIELD("Receipts Nos.");
            "Document Type"::issue:
                PDCSetupG.TESTFIELD("Issue Nos.");
        END;
    end;

    procedure GetNoSeriesCode(): Code[10]

    begin

        CASE "Document Type" OF
            "Document Type"::Receipt:
                EXIT(PDCSetupG."Receipts Nos.");
            "Document Type"::Issue:
                EXIT(PDCSetupG."Issue Nos.")
        END;
    end;

    procedure TestManual(DefaultNoSeriesCode: Code[10])
    var
        NoSeries: Record "No. Series";
    begin

        IF DefaultNoSeriesCode <> '' THEN BEGIN
            NoSeries.GET(DefaultNoSeriesCode);
            IF NOT NoSeries."Manual Nos." THEN
                ERROR(

                  Text000 + ' ' +

                  Text001,
                  NoSeries.FIELDCAPTION("Manual Nos."), NoSeries.TABLECAPTION, NoSeries.Code);
        END;

    end;

    procedure SetupNewLine()

    begin
        "Location Code" := UserSessionG.GetLocation;
        "Branch Code" := UserSessionG.GetBranchCode("Location Code");
    end;

    procedure ApplyStatusFunction(CheckFieldNumberP: Boolean)
    var
        DocStatusLineL: Record "GAG Document Status Line";
    begin
        IF CheckFieldNumberP AND (CurrFieldNo = 0) THEN
            EXIT;

        IF UserSessionUnitG.GetLock() THEN
            EXIT;

        CASE "Document Type" OF
            "Document Type"::Receipt:
                IF DocStatusLineL.GET(
                  DocStatusLineG.Area::"PDC Receipt Voucher",
                  "Status Code")
                THEN
                    DocStatusLineL.ExecuteStatusFunctions();
            "Document Type"::Issue:
                IF DocStatusLineL.GET(
                  DocStatusLineG.Area::"PDC Issue Voucher",
                  "Status Code")
                THEN
                    DocStatusLineL.ExecuteStatusFunctions();
        END;
    end;

    local procedure UpdateCurrencyFactor()
    begin
        IF "Currency Code" <> '' THEN BEGIN
            IF "Posting Date" <> 0D THEN
                CurrencyDate := "Posting Date"
            ELSE
                CurrencyDate := WORKDATE;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
            IF "Currency Factor" <> 0 THEN
                "Exchange Rate" := 1 / "Currency Factor";
        END ELSE BEGIN
            "Currency Factor" := 0;
            "Exchange Rate" := 0;
        END;

    end;

    local procedure ConfirmUpdateCurrencyFactor()

    begin
        IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
        ELSE
            Confirmed := CONFIRM(C_GAG_UpdateExchangeRate, FALSE);
        IF Confirmed THEN
            VALIDATE("Currency Factor")
        ELSE
            "Currency Factor" := xRec."Currency Factor";
    end;

    local procedure PDCLinesExist(): Boolean
    begin
        PDCLineG.RESET;
        PDCLineG.SETRANGE("Document Type", "Document Type");
        PDCLineG.SETRANGE("No.", "No.");
        EXIT(PDCLineG.FINDFIRST);
    end;

    local procedure UpdatePDCLines(ChangedFieldNameP: Text[100])

    begin
        IF PDCLinesExist THEN BEGIN
            PDCLineG.RESET;
            PDCLineG.SETRANGE("Document Type", "Document Type");
            PDCLineG.SETRANGE("No.", "No.");
            IF PDCLineG.FINDSET THEN BEGIN
                REPEAT
                    CASE ChangedFieldNameP OF
                        FIELDNAME("Currency Factor"):
                            PDCLineG.VALIDATE("Currency Factor", "Currency Factor");
                        FIELDNAME("Exchange Rate"):
                            PDCLineG.VALIDATE("Exchange Rate", "Exchange Rate");
                        FIELDNAME("Account Type"):
                            PDCLineG."Account Type" := "Account Type";
                        FIELDNAME("Account No."):
                            BEGIN
                                PDCLineG."Account No." := "Account No.";
                                PDCLineG."Account Name" := "Account Name";
                            END;
                        FIELDNAME("Currency Code"):
                            BEGIN
                                PDCLineG.VALIDATE("Currency Code", "Currency Code");
                                PDCLineG.VALIDATE("Currency Factor", "Currency Factor");
                            END;
                        FIELDNAME("Bank Code"):
                            PDCLineG."Bank Code" := "Bank Code";
                        FIELDNAME("Posting Date"):
                            PDCLineG."Posting Date" := "Posting Date";
                        FIELDNAME("Branch Code"):
                            PDCLineG."Branch Code" := "Branch Code";
                        FIELDNAME("Location Code"):
                            PDCLineG."Location Code" := "Location Code";
                        FIELDNAME("Salespers./Purch. Code"):
                            PDCLineG."Salespers./Purch. Code" := "Salespers./Purch. Code";
                    END;
                    PDCLineG.MODIFY(TRUE);
                UNTIL PDCLineG.NEXT = 0;
            END;


        END;
    end;

    procedure SelectSeries(DefaultNoSeriesCode: Code[10]; OldNoSeriesCode: Code[10]; VAR NewNoSeriesCode: Code[10]): Boolean

    begin
        NoSeriesCode := DefaultNoSeriesCode;
        FilterSeries;
        IF NewNoSeriesCode = '' THEN BEGIN
            IF OldNoSeriesCode <> '' THEN
                NoSeries.Code := OldNoSeriesCode;
        END ELSE
            NoSeries.Code := NewNoSeriesCode;
        IF PAGE.RUNMODAL(0, NoSeries) = ACTION::LookupOK THEN BEGIN
            NewNoSeriesCode := NoSeries.Code;
            EXIT(TRUE);
        END;
    end;

    procedure FilterSeries()
    var
    begin
        NoSeries.RESET;
        NoSeriesRelationship.SETRANGE(Code, NoSeriesCode);
        IF NoSeriesRelationship.FINDSET THEN
            REPEAT
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.MARK := TRUE;
            UNTIL NoSeriesRelationship.NEXT = 0;
        NoSeries.GET(NoSeriesCode);
        NoSeries.MARK := TRUE;
        NoSeries.MARKEDONLY := TRUE;
    end;

    /* procedure SetSeries(VAR NewNo: Code[20])
     var
         NoSeriesCode2: Code[10];
     begin

         NoSeriesCode2 := NoSeries.Code;
         FilterSeries;
         NoSeries.Code := NoSeriesCode2;
         NoSeries.FIND;
         NewNo := GetNextNo(NoSeries.Code, 0D, TRUE);
     end;

     procedure GetNextNo(NoSeriesCode: Code[10]; SeriesDate: Date; ModifySeries: Boolean): Code[20]

     begin


         EXIT(NoSeriesLine."Last No. Used");
     end;*/

    var
        NoSeriesLine: Record "No. Series Line";
        NoSeriesRelationship: Record "No. Series Relationship";
        PDCHeaderG: Record "GAG PDC Header";
        BankAccountG: Record "Bank Account";
        PDCLineG: Record "GAG PDC Line";
        C_GAG_UpdateExchangeRate: label 'Do you want to update the exchange rate?';
        Confirmed: Boolean;
        HideValidationDialog: Boolean;
        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        DocStatusLineG: Record "GAG Document Status Line";
        UserSessionUnitG: Codeunit "User Session Unit";
        PDCSetupG: Record "GAG PDC Setup";
        NoSeriesMgtG: Codeunit NoSeriesManagement;
        Text000: label 'Error 0...';
        Text001: label 'Error 1...';

        UserSessionG: Record "User Session";
        GAGStatusHistoryG: Record "GAG Status History";
        GAGDocStatusLineG: Record "GAG Document Status Line";
        TempCommBufferG: Record "Communication Method";
        CustomerG: Record Customer;
        VendorG: Record Vendor;
        NoSeriesCode: Code[20];
        NoSeries: Record "No. Series";


    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PDCSetupG.GET;
            TestNoSeries;
            NoSeriesMgtG.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;

        "Created By" := USERID;
        "Creation Date" := TODAY;
        "Document Date" := WORKDATE;
        "Posting Date" := WORKDATE;
    end;

    trigger OnModify()
    begin
        "Last Change by" := USERID;
        "Last Change Date" := TODAY;
    end;

    trigger OnDelete()
    var
        PDCLineL: Record "GAG PDC Line";
        PDCCommentLineL: Record "GAG Voucher Comment Line";
    begin
        PDCLineL.RESET;
        PDCLineL.SETRANGE("Document Type", "Document Type");
        PDCLineL.SETRANGE("No.", "No.");
        PDCLineL.DELETEALL(TRUE);

        PDCCommentLineL.RESET;
        PDCCommentLineL.SETRANGE("Voucher Type", "Document Type");
        PDCCommentLineL.SETRANGE("No.", "No.");
        PDCCommentLineL.DELETEALL(TRUE);
    end;

    trigger OnRename()
    begin
        "Last Change by" := USERID;
        "Last Change Date" := TODAY;
    end;

}
