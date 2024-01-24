page 60106 "GAG Divisions"
{
    ApplicationArea = All;
    Caption = 'Divisions';
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "GAG Division Code";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Default Service Customer"; Rec."Default Service Customer")
                {
                    ToolTip = 'Specifies the value of the Default Service Customer field.';
                }
                field("Sales Quote Validity Formula"; Rec."Sales Quote Validity Formula")
                {
                    ToolTip = 'Specifies the value of the Sales Quote Validity Formula field.';
                }
                field("Arch. Sales Quote Vality Formu"; Rec."Arch. Sales Quote Vality Formu")
                {
                    ToolTip = 'Specifies the value of the Arch. Sales Quote Vality Formu field.';
                }
                field("Order Trcking Validity Formula"; Rec."Order Trcking Validity Formula")
                {
                    ToolTip = 'Specifies the value of the Order Trcking Validity Formula field.';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies the value of the Inventory Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("Purchase Planning Applicable"; Rec."Purchase Planning Applicable")
                {
                    ToolTip = 'Specifies the value of the Purchase Planning Applicable field.';
                }
                field("Average Costing Applicable"; Rec."Average Costing Applicable")
                {
                    ToolTip = 'Specifies the value of the Average Costing Applicable field.';
                }
                field("Profit Margin Applicable"; Rec."Profit Margin Applicable")
                {
                    ToolTip = 'Specifies the value of the Profit Margin Applicable field.';
                }
                field("Profit Margin Sal.VAT.Cond."; Rec."Profit Margin Sal.VAT.Cond.")
                {
                    ToolTip = 'Specifies the value of the Profit Margin Sal.VAT.Cond. field.';
                }
                field("Profit Margin Purch.VAT.Cond."; Rec."Profit Margin Purch.VAT.Cond.")
                {
                    ToolTip = 'Specifies the value of the Profit Margin Purch.VAT.Cond. field.';
                }
            }
        }
    }
}
