page 60120 "GAG PDC Issue Subpage"
{
    ApplicationArea = All;
    Caption = 'GAG PDC Issue Subpage';
    PageType = ListPart;
    SourceTable = "GAG PDC Line";
    SourceTableView = WHERE("Document Type" = FILTER(Issue));

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
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ToolTip = 'Specifies the value of the Amount(LCY) field.';
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
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
