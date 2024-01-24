page 60116 "GAG Posted PDC Receipt Subpage"
{
    ApplicationArea = All;
    Caption = 'GAG Posted PDC Receipt Subpage';
    PageType = ListPart;
    SourceTable = "GAG Posted PDC Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                }
                field("In the Name of"; Rec."In the Name of")
                {
                    ToolTip = 'Specifies the value of the In the Name of field.';
                }
                field("From (Customer Company)"; Rec."From (Customer Company)")
                {
                    ToolTip = 'Specifies the value of the From (Customer Company) field.';
                }
            }
        }
    }
}
