page 60122 "GAG Document Status Line List"
{
    ApplicationArea = All;
    Caption = 'GAG Document Status Line List';
    PageType = List;
    SourceTable = "GAG Document Status Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Area"; Rec."Area")
                {
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field("Status Code"; Rec."Status Code")
                {
                    ToolTip = 'Specifies the value of the Status Code field.';
                }
                field("Status Description"; Rec."Status Description")
                {
                    ToolTip = 'Specifies the value of the Status Description field.';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field("No. of Functions"; Rec."No. of Functions")
                {
                    ToolTip = 'Specifies the value of the No. of Functions field.';
                }
            }
        }
    }
    Trigger OnOpenPage()
    var
        UserStatusCodeL: Record "User Status Code";
        FilterstringL: text;
    begin
        UserStatusCodeL.RESET;
        UserStatusCodeL.SETRANGE("User ID", UPPERCASE(USERID));
        IF UserStatusCodeL.FINDSET THEN
            REPEAT
                IF FilterstringL <> '' THEN
                    FilterstringL := FilterstringL + '|' + UserStatusCodeL."Status Code"
                ELSE
                    FilterstringL := UserStatusCodeL."Status Code";
            UNTIL UserStatusCodeL.NEXT = 0;
        IF FilterstringL <> '' THEN
            Rec.SETFILTER("Status Code", FilterstringL);
    end;
}
