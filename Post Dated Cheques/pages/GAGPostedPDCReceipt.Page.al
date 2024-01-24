page 60115 "GAG Posted PDC Receipt"
{
    ApplicationArea = All;
    Caption = 'GAG Posted PDC Receipt';
    PageType = Document;
    SourceTable = "GAG Posted PDC Header";

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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                }
                field("Guarantee Cheque"; Rec."Guarantee Cheque")
                {
                    ToolTip = 'Specifies the value of the Guarantee Cheque field.';
                }
                field("Is Cheque Returned"; Rec."Is Cheque Returned")
                {
                    ToolTip = 'Specifies the value of the Is Cheque Returned field.';
                }
                field("Applies to Order No."; Rec."Applies to Order No.")
                {
                    ToolTip = 'Specifies the value of the Applies to Order No. field.';
                }
                field("Cheque Received From/Issue To"; Rec."Cheque Received From/Issue To")
                {
                    ToolTip = 'Specifies the value of the Cheque Received From/Issue To field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Status Code"; Rec."Status Code")
                {
                    ToolTip = 'Specifies the value of the Status Code field.';
                }
                field("Status Description"; Rec."Status Description")
                {
                    ToolTip = 'Specifies the value of the Status Description field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
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
            part(Lines; "GAG Posted PDC Receipt Subpage")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }

        }
    }
}
