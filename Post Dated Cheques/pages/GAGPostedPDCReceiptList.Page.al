page 60114 "GAG Posted PDC Receipt List"
{
    ApplicationArea = All;
    Caption = 'GAG Posted PDC Receipt List'; //Posted PDC Receipt Vouchers List
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "GAG Posted PDC Header";
    CardPageId = "GAG Posted PDC Receipt";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
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
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
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
                field("Guarantee Cheque"; Rec."Guarantee Cheque")
                {
                    ToolTip = 'Specifies the value of the Guarantee Cheque field.';
                }
                field("Is Cheque Returned"; Rec."Is Cheque Returned")
                {
                    ToolTip = 'Specifies the value of the Is Cheque Returned field.';
                }
            }
        }
    }
}
