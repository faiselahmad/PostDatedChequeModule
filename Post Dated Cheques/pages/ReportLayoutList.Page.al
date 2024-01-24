page 60113 "Report Layout List"
{
    ApplicationArea = All;
    Caption = 'Report Layout List';
    PageType = List;
    SourceTable = "Report Layout Setup";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Make Code"; Rec."Make Code")
                {
                    ToolTip = 'Specifies the value of the Make Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
            }
        }
    }
}
