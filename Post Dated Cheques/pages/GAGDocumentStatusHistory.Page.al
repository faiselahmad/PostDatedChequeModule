page 60121 "GAG Document Status History"
{
    ApplicationArea = All;
    Caption = 'GAG Document Status History';
    PageType = List;
    SourceTable = "GAG Status History";
    SourceTableView = SORTING(Area, "Document No.", "Modification Date/Time");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Visible = false;
                }
                field("Status Code"; Rec."Status Code")
                {
                    ToolTip = 'Specifies the value of the Status Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Modification Date/Time"; Rec."Modification Date/Time")
                {
                    ToolTip = 'Specifies the value of the Modification Date/Time field.';
                }
                field("Changed by User ID"; Rec."Changed by User ID")
                {
                    ToolTip = 'Specifies the value of the Changed by User ID field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }
}
