page 60103 "GAG Attachment Factbox"
{
    ApplicationArea = All;
    Caption = 'GAG Attachment Factbox';
    PageType = CardPart;
    SourceTable = "GAG Attachment";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
            }
        }
    }
}
