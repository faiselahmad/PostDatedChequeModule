page 60109 "GAG Bank Receipt SubPage"
{
    ApplicationArea = All;
    Caption = 'GAG Bank Receipt SubPage';
    PageType = ListPart;
    SourceTable = "GAG Voucher Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                    ToolTip = 'Specifies the value of the Account Name  field.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ToolTip = 'Specifies the value of the Debit Amount field.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ToolTip = 'Specifies the value of the Credit Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Amount  field.';
                }
                field("Amount (LYC)"; Rec."Amount (LYC)")
                {
                    ToolTip = 'Specifies the value of the Amount (LYC) field.';
                }
                field("Applies to Open Order No."; Rec."Applies to Open Order No.")
                {
                    ToolTip = 'Specifies the value of the Applies to Open Order No. field.';
                }
                field("Sales Person Name"; Rec."Sales Person Name")
                {
                    ToolTip = 'Specifies the value of the Sales Person Name field.';
                }
                field("Sales Person Name 2"; Rec."Sales Person Name 2")
                {
                    ToolTip = 'Specifies the value of the Sales Person Name 2 field.';
                }
            }
        }
    }
}
