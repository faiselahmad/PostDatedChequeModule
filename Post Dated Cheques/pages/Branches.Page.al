page 60112 Branches
{
    ApplicationArea = All;
    Caption = 'Branches';
    PageType = List;
    SourceTable = "Branch Description";

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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Branch ID"; Rec."Branch ID")
                {
                    ToolTip = 'Specifies the value of the Branch ID field.';
                }
                field("Main Location Code"; Rec."Main Location Code")
                {
                    ToolTip = 'Specifies the value of the Main Location Code field.';
                }
                field("TAX Invoice Expiry Formula"; Rec."TAX Invoice Expiry Formula")
                {
                    ToolTip = 'Specifies the value of the TAX Invoice Expiry Formula field.';
                }
                field("BOE Expiry Formula"; Rec."BOE Expiry Formula")
                {
                    ToolTip = 'Specifies the value of the BOE Expiry Formula field.';
                }
                field("Update Labor Clocking In Order"; Rec."Update Labor Clocking In Order")
                {
                    ToolTip = 'Specifies the value of the Update Labor Clocking In Order field.';
                }
                field("IC Customer No."; Rec."IC Customer No.")
                {
                    ToolTip = 'Specifies the value of the IC Customer No. field.';
                }
                field("IC Vendor No."; Rec."IC Vendor No.")
                {
                    ToolTip = 'Specifies the value of the IC Vendor No. field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ToolTip = 'Specifies the value of the Phone No. 2 field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
            }
        }
    }
}
