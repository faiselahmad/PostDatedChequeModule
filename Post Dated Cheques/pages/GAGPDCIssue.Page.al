page 60107 "GAG PDC Issue"
{
    ApplicationArea = All;
    Caption = 'Posted Dated Cheques Issues List';
    PageType = Document;
    SourceTable = "GAG PDC Header";
    SourceTableView = WHERE("Document Type" = FILTER(Issue));


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
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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

                    trigger OnDrillDown()
                    begin
                        GAGStatusHistoryG.ShowStatusHistory(3, Rec."No.");
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
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                }
            }
            part(Lines; "GAG PDC Issue Subpage")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }
        }
        area(factboxes)
        {

            part("GAG Attachment Factbox"; "Document Attachment Factbox") //GAG Attachment Factbox instead of Attached Document
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"GAG PDC Line"), "No." = FIELD("No."), "Document Type" = FIELD("Document Type");

            }

        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetupNewLine;
    end;

    var
        GAGStatusHistoryG: Record "GAG Status History";
        ChangeExchRateG: Page "Change Exchange Rate";
}
