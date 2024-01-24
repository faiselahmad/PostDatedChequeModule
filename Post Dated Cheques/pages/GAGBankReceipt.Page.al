page 60108 "GAG Bank Receipt"
{
    ApplicationArea = All;
    Caption = 'GAG Bank Receipt';
    PageType = Document;
    SourceTable = "GAG Voucher Header";

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
                }
                field("Account No."; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Note; Rec.Note)
                {
                    ToolTip = 'Specifies the value of the Note field.';
                }
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Status Code"; Rec."Status Code")
                {
                    ToolTip = 'Specifies the value of the Status Code field.';
                }
                field("Status Description"; Rec."Status Description")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount(LYC)"; Rec."Amount(LYC)")
                {
                    ToolTip = 'Specifies the value of the Amount(LYC) field.';
                }
            }
            part(Lines; "GAG Bank Receipt SubPage")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Voucher Type" = CONST(BRV), "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {

            part("GAG Attachment Factbox"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(DATABASE::"GAG Voucher Line"), "No." = FIELD("No."), "Document Type" = FIELD("Voucher Type");

            }

        }

    }
}
