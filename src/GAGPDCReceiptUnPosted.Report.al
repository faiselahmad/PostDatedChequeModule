report 60113 "GAG PDC Receipt (Un-Posted)"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/GAGPDCReceiptUnPosted.rdl';
    Caption = 'PDC Receipt (Un-Posted)';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    ApplicationArea = Basic, Suite;
    DataAccessIntent = ReadOnly;


    dataset
    {
        dataitem("GAG PDC Header"; "GAG PDC Header")
        {
            CalcFields = Amount, "Amount(LCY)";
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "Document Type";
            column(ReportLayoutSetupG__Header_Graphic_Left_; ReportLayoutSetupG."Header Graphic Left")
            {
                Description = 'PA038227';
            }
            column(RepTittle; PostDatedChequeReceipt_lbl)
            {
            }
            column(No; "GAG PDC Header"."No.")
            {
            }
            column(CompAddrG_Name; CompAddrG[1])
            {
            }
            column(CompAddrG_Name2; CompAddrG[2])
            {
            }
            column(CompAddrG_Address; CompAddrG[3])
            {
            }
            column(CompAddrG_Address2; CompAddrG[4])
            {
            }
            column(CompAddrG_CityPostCode; CompAddrG[5])
            {
            }
            column(CompAddrG_Country; CompAddrG[6])
            {
            }
            column(CompAddrG_VATRegNo; CompAddrG[7])
            {
            }
            column(Acct_No; AccountInfoG[1])
            {
            }
            column(Acct_Name; AccountInfoG[2])
            {
            }
            column(Acct_Address; AccountInfoG[3])
            {
            }
            column(Acct_Phone; AccountInfoG[4])
            {
            }
            column(Acct_Fax; AccountInfoG[5])
            {
            }
            column(Acct_Email; AccountInfoG[6])
            {
            }
            column(DocumentDate; FORMAT("GAG PDC Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(Today_Date; FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(PDC_Desc; "GAG PDC Header".Description)
            {
            }
            column(PDC_Currency; CurrCodeG)
            {
            }
            column(AmtInWords; NoTextG[1] + ' ' + NoTextG[2])
            {
            }
            column(SalOrdNoG; "GAG PDC Header"."Applies to Order No.")
            {
            }
            column(SalesPersonName; SalesPersonNameG)
            {
            }
            column(LocationCode_GAGPDCHeader; "GAG PDC Header"."Location Code")
            {
            }
            column(ExternalDocumentNo_GAGPDCHeader; "GAG PDC Header"."External Document No.")
            {
            }
            column(CreatedBy_GAGPDCHeader; CreatedByG)
            {
            }
            column(CheckedByG; CheckedByG)
            {
            }
            column(CustBoolG; CustBoolG)
            {
            }
            column(Amount; ABS("GAG PDC Header".Amount))
            {
            }
            column(PrintByG; PrintByG)
            {
            }
            dataitem("GAG PDC Line"; "GAG PDC Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "No." = FIELD("No.");
                DataItemLinkReference = "GAG PDC Header";
                DataItemTableView = SORTING("Document Type", "No.", "Line No.");
                column(ChequeNo; "GAG PDC Line"."Cheque No.")
                { }
                column(ChequeDate; FORMAT("GAG PDC Line"."Cheque Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                {
                }
                column(DueDate; FORMAT("GAG PDC Line"."Due Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                {
                }
            }
            dataitem("GAG PDC Setup"; "GAG PDC Setup")
            {
                DataItemTableView = SORTING("Primary Key");
                column(GetTermsandCondition; "GAG PDC Setup".GetReceiptTermsandCondition)
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                GAGPDCSetupL: Record "GAG PDC Setup";
                GAGStatusHistoryL: Record "GAG Status History";
                EmployeeL: Record Employee;
                BranchDescriptionL: Record "Branch Description";
            begin
                CLEAR(SerialNoG);

                IF BranchDescriptionL.GET("GAG PDC Header"."Branch Code") THEN;
                ReportLayoutSetupG.GetReportLayout(ReportLayoutSetupG, '', BranchDescriptionL."Main Location Code");

                IF (NMLSetupG.GET) AND (NMLSetupG."Branch Order Address" <> '') THEN BEGIN
                    IF BranchDescriptionG.GET(NMLSetupG."Branch Order Address") THEN
                        CompanyAddress(BranchDescriptionG);
                END ELSE BEGIN
                    IF BranchDescriptionG.GET("GAG PDC Header"."Branch Code") THEN
                        CompanyAddress(BranchDescriptionG);
                END;
                CLEAR(CustBoolG);
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    CustomerG.GET("Account No.");
                    IF CountryRegion.GET(CustomerG."Country/Region Code") THEN
                      ;
                    AccountInfoG[1] := CustomerG."No.";
                    AccountInfoG[2] := CustomerG.Name;
                    AccountInfoG[3] := CustomerG.Address;
                    AccountInfoG[4] := CustomerG."Phone No.";
                    AccountInfoG[5] := CustomerG."Fax No.";
                    AccountInfoG[6] := CustomerG."E-Mail";
                    AccountInfoG[7] := 'TRN :' + CustomerG."VAT Registration No.";
                    CustBoolG := TRUE;
                    IF SalesPersonG.GET(CustomerG."Salesperson Code") THEN
                        SalesPersonNameG := SalesPersonG.Name;
                END ELSE
                    IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                        VendorG.GET("Account No.");
                        IF CountryRegion.GET(VendorG."Country/Region Code") THEN
                          ;
                        AccountInfoG[1] := VendorG."No.";
                        AccountInfoG[2] := VendorG.Name;
                        AccountInfoG[3] := VendorG.Address;
                        AccountInfoG[4] := VendorG."Phone No.";
                        AccountInfoG[5] := VendorG."Fax No.";
                        AccountInfoG[6] := VendorG."E-Mail";
                        AccountInfoG[7] := 'TRN :' + VendorG."VAT Registration No.";
                        CustBoolG := FALSE;
                        IF SalesPersonG.GET(VendorG."Purchaser Code") THEN
                            SalesPersonNameG := SalesPersonG.Name;
                    END;

                AmountRoundPrecisionG := CurrencyG.GetAmountRoundingPrecision("GAG PDC Header"."Currency Code");

                IF "GAG PDC Header"."Currency Factor" <> 0 THEN
                    ExchangeRateG := (1 / "GAG PDC Header"."Currency Factor");
                IF ExchangeRateG <> 0 THEN BEGIN
                    IF AmountRoundPrecisionG = 0.001 THEN
                        CurrCodeG := "GAG PDC Header"."Currency Code" + ', Exchange Rate : ' + FORMAT(ExchangeRateG, 0, '<precision,5><Integer><Decimals>')
                    ELSE
                        CurrCodeG := "GAG PDC Header"."Currency Code" + ', Exchange Rate : ' + FORMAT(ExchangeRateG, 0, '<precision,5><Integer><Decimals>');
                END ELSE
                    CurrCodeG := "GAG PDC Header"."Currency Code";

                IF BnkAccG.GET("GAG PDC Header"."Bank Code") THEN
                  ;

                GenLedgSetupG.GET;
                IF CurrCodeG = '' THEN
                    CurrCodeG := GenLedgSetupG."LCY Code";

                NumbertoWordsG.InitTextVariable;
                IF "GAG PDC Header"."Currency Code" <> '' THEN
                    NumbertoWordsG.FormatNoText(NoTextG, Amount, "GAG PDC Header"."Currency Code")
                ELSE
                    NumbertoWordsG.FormatNoText(NoTextG, Amount, CurrCodeG);


                GAGPDCSetupL.GET;
                GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL."Document No.", "GAG PDC Header"."No.");
                IF "GAG PDC Header"."Document Type" = "GAG PDC Header"."Document Type"::Issue THEN BEGIN
                    GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL.Area, GAGStatusHistoryL.Area::"PDC Issue Voucher");
                    GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL."Status Code", GAGPDCSetupL."PDC Issue Request Status");
                END ELSE BEGIN
                    GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL.Area, GAGStatusHistoryL.Area::"PDC Receipt Voucher");
                    GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL."Status Code", GAGPDCSetupL."PDC Receipt Request Status");
                END;
                GAGStatusHistoryL.SETCURRENTKEY("Modification Date/Time");
                IF GAGStatusHistoryL.FINDLAST THEN BEGIN
                    EmployeeL.CALCFIELDS("User ID");
                    EmployeeL.SETRANGE("User ID", GAGStatusHistoryL."Changed by User ID");
                    IF EmployeeL.FINDFIRST THEN
                        ReqByG := EmployeeL.Name;
                END;
                IF "GAG PDC Header"."Document Type" = "GAG PDC Header"."Document Type"::Issue THEN
                    GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL."Status Code", GAGPDCSetupL."PDC Issue Approval Status")
                ELSE
                    GAGStatusHistoryL.SETRANGE(GAGStatusHistoryL."Status Code", GAGPDCSetupL."PDC Receipt Approval Status");
                GAGStatusHistoryL.SETCURRENTKEY("Modification Date/Time");
                IF GAGStatusHistoryL.FINDLAST THEN BEGIN
                    EmployeeL.CALCFIELDS("User ID");
                    EmployeeL.SETRANGE("User ID", GAGStatusHistoryL."Changed by User ID");
                    IF EmployeeL.FINDFIRST THEN
                        AppByG := EmployeeL.Name;
                END;

                UserG.SETRANGE(UserG."User Name", "GAG PDC Header"."Created By");
                IF UserG.FINDFIRST THEN BEGIN
                    IF UserG."Full Name" <> '' THEN
                        CreatedByG := UserG."Full Name"
                    ELSE
                        CreatedByG := "GAG PDC Header"."Created By";
                END;

                IF NMLSetupG.GET THEN
                  ;
                IF LocationG.GET("Location Code") THEN
                  ;
                UserG.SETRANGE(UserG."User Name", LocationG."Receipt Checked By");
                IF UserG.FINDFIRST THEN BEGIN
                    IF UserG."Full Name" <> '' THEN
                        CheckedByG := UserG."Full Name"
                    ELSE
                        CheckedByG := LocationG."Receipt Checked By";
                END;


                UserG.RESET;
                UserG.SETRANGE(UserG."User Name", USERID);
                IF UserG.FINDFIRST THEN
                    IF UserG."Full Name" <> '' THEN
                        PrintByG := UserG."Full Name"
                    ELSE
                        PrintByG := UserG."User Name";
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        BnkDetails_Lbl = 'Bank Details';
        Comments_Lbl = 'Comments / Remarks';
        BankCodeLbl = 'Bank Code';
        BankNameLbl = 'Bank Name';
        ReceiptInformationLbl = 'RECEIPT INFORMATION';
        ReceiptNoLbl = 'Receipt No';
        ReceiptDataLbl = 'Receipt Date';
        BranchLbl = 'Branch';
        SalesExecutiveLbl = 'Sales Executive';
        SalesOrderLbl = 'Sales Order';
        CustomerInformationLbl = 'CUSTOMER INFORMATION';
        CustomerNoLbl = 'Customer Number';
        CustomerNameLbl = 'Customer Name';
        CustomerAddressLbl = 'Customer Address';
        CustomerPhoneLbl = 'Customer Phone';
        CustomerFaxLbl = 'Customer Fax';
        CustomerEmailLbl = 'Customer Email';
        SalesRepresentativeLbl = 'Sales Representative';
        CheckedByLbl = 'Checked By';
        RequestedByLbl = 'Received By';
        CustomerSignatureLbl = 'Customer Signature';
        AmountInWordsLbl = 'AMOUNT IN WORDS';
        DescriptionLbl = 'DESCRIPTION';
        TermConditionLbl = 'TERMS & CONDITIONS';
        SrnoLbl = 'SR NO.';
        FromLbl = 'FROM :';
        TotalLbl = 'TOTAL';
        ChequeLbl = 'CHEQUE NO';
        DueDateLbl = 'DUE DATE';
        BankLbl = 'BANK';
        CurrencyLbl = 'CURRENCY';
        AmountLbl = 'AMOUNT';
        AmountLcyLbl = 'AMOUNT LCY';
        NumberLbl = 'NUMBER';
        PaymentTypeLbl = 'CHEQUE/ TTR/ CREDIT CARD';
        PaymentAsLbl = 'PAYMENTS AS';
        BracketLbl = '(';
        BrackerCloseLbl = ')';
        PaymentType_Lbl = 'PDC';
        VendorInformationLbl = 'VENDOR INFORMATION';
        VendorNoLbl = 'Vendor Number :';
        VendorNameLbl = 'Vendor Name :';
        VendorAddressLbl = 'Vendor Address :';
        VendorPhoneLbl = 'Vendor Phone :';
        VendorrFaxLbl = 'Vendor Fax :';
        VendorEmailLbl = 'Vendor Email :';
        for_Lbl = 'for';
        Status_Lbl = 'Status';
        UnPosted_Lbl = 'Un-Posted';
        PageNoLbl = 'Page No. :';
        Printed_By_Lbl = 'Printed By :';
        Printed_Date_lbl = 'Print Date :';
    }

    trigger OnInitReport()
    begin
        CompInfoG.GET;
    end;

    var
        UserG: Record User;
        SalesPersonG: Record "Salesperson/Purchaser";
        LocationG: Record Location;
        GenLedgSetupG: Record "General Ledger Setup";
        ReportLayoutSetupG: Record "Report Layout Setup";
        BnkAccG: Record "Bank Account";
        CompInfoG: Record "Company Information";
        CountryRegion: Record "Country/Region";
        CustomerG: Record Customer;
        VendorG: Record Vendor;
        CurrencyG: Record "Currency";
        BranchDescriptionG: Record "Branch Description";
        NMLSetupG: Record "GAG NML Setup";
        NumbertoWordsG: Codeunit "GAG Number to Text";
        CheckG: Report Check;
        CurrCodeG: Text[100];
        NoTextG: array[2] of Text[80];
        AccountInfoG: array[8] of Text[50];
        CompAddrG: array[13] of Text[50];
        ReqByG: Text[50];
        AppByG: Text[50];
        ReportTittle: Text;
        SalesPersonNameG: Text[50];
        CheckedByG: Text[50];
        CreatedByG: Text[50];
        PrintByG: Text;
        SerialNoG: Integer;
        CustBoolG: Boolean;
        PostDatedChequeIssue_lbl: Label 'POST DATED CHEQUE ISSUE';
        PostDatedChequeReceipt_lbl: Label 'POST DATED CHEQUE RECEIPT';
        ExchangeRateG: Decimal;
        AmountRoundPrecisionG: Decimal;

    local procedure CompanyAddress(BranchDescriptionP: Record "Branch Description")
    begin
        CompAddrG[1] := BranchDescriptionG.Name;
        CompAddrG[2] := BranchDescriptionG."Name 2";
        CompAddrG[3] := BranchDescriptionG.Address;
        CompAddrG[4] := BranchDescriptionG."Address 2";
        CompAddrG[5] := BranchDescriptionG.City + '' + BranchDescriptionG."Post Code";
        IF CountryRegion.GET(BranchDescriptionG."Country/Region Code") THEN
          ;
        CompAddrG[6] := CountryRegion.Name;
        CompAddrG[7] := 'TRN :' + CompInfoG."VAT Registration No.";
        COMPRESSARRAY(CompAddrG);
    end;
}

