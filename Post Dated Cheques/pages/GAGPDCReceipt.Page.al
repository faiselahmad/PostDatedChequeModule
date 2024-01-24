page 60102 "GAG PDC Receipt"
{
    ApplicationArea = All;
    Caption = 'PDC Receipt Voucher';
    UsageCategory = none;
    PageType = Document;

    SourceTable = "GAG PDC Header";
    SourceTableView = WHERE("Document Type" = FILTER(Receipt));
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    DelayedInsert = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssitEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;


                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Applies to Order No."; Rec."Applies to Order No.")
                {
                    ToolTip = 'Specifies the value of the Applies to Order No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                }
                field("Cheque Received From/Issue To"; Rec."Cheque Received From/Issue To")
                {
                    ToolTip = 'Specifies the value of the Cheque Received From/Issue To field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Status Code"; Rec."Status Code")
                {
                    ToolTip = 'Specifies the value of the Status Code field.';
                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE;
                    end;

                }

                field("Status Description"; Rec."Status Description")
                {
                    ToolTip = 'Specifies the value of the Status Description field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    trigger OnAssistEdit()
                    begin

                        IF Rec."Currency Code" <> '' THEN BEGIN
                            ChangeExchRateG.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                            IF ChangeExchRateG.RUNMODAL = ACTION::OK THEN BEGIN
                                Rec.VALIDATE(Rec."Currency Factor", ChangeExchRateG.GetParameter);
                                CurrPage.UPDATE;
                            END;
                            CLEAR(ChangeExchRateG);
                        END;
                    end;
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    trigger OnValidate()
                    begin
                        CurrPage.update;
                    end;

                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                    trigger OnValidate()
                    begin
                        CurrPage.update;
                    end;
                }
                field("Guarantee Cheque"; Rec."Guarantee Cheque")
                {
                    ToolTip = 'Specifies the value of the Guarantee Cheque field.';
                }

            }
            part(Lines; "GAG PDC Receipt Subpage")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }


        }

        area(factboxes)
        {

            part("GAG Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"GAG PDC Line"), "No." = FIELD("No."), "Document Type" = FIELD("Document Type");

            }

        }

    }
    actions
    {
        area(Processing)
        {
            action(Receipt)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    PDCHeaderL: Record "GAG PDC Header";
                    PDCSetupL: Record "GAG PDC Setup";
                begin
                    PDCHeaderL.RESET;
                    CurrPage.SETSELECTIONFILTER(PDCHeaderL);
                    PDCSetupL.GET;
                    IF PDCSetupL."Un-Posted PDC Rcpt. Report ID" <> 0 THEN
                        REPORT.RUN(PDCSetupL."Un-Posted PDC Rcpt. Report ID", TRUE, FALSE, PDCHeaderL)
                    ELSE
                        ERROR(C_INC_ReportSetupErr);
                end;
            }
            action(Post)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF NOT Rec."Guarantee Cheque" THEN
                        Rec.TESTFIELD("Bank Code");
                    CODEUNIT.RUN(CODEUNIT::"GAG PDC-Post(Yes/No)", Rec);
                end;
            }
            action("Post $ Print")
            {
                Caption = 'Post & Print';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CODEUNIT.RUN(CODEUNIT::"GAG PDC-Post + Print", Rec);
                end;
            }
        }
    }

    var
        C_INC_ReportSetupErr: label 'Report Setup Not Found!';
        PDCSetupG: Record "GAG PDC Setup";
        NoSeriesMgtG: Codeunit NoSeriesManagement;
        ChangeExchRateG: Page "Change Exchange Rate";


    procedure OnNewRecord(BelowxRec: Boolean)
    VAR
        GAG: Record "GAG PDC Header";
    begin
        GAG.SetupNewLine;
    end;

    procedure GetNoSeriesCode(): Code[10]
    begin
        CASE Rec."Document Type" OF
            Rec."Document Type"::Receipt:
                EXIT(PDCSetupG."Receipts Nos.");
            Rec."Document Type"::Issue:
                EXIT(PDCSetupG."Issue Nos.")
        END;
    end;

}
