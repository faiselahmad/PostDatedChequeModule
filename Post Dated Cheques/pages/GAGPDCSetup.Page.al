page 60105 "GAG PDC Setup"
{
    ApplicationArea = All;
    Caption = 'Post Dated Cheques Setup';
    UsageCategory = Administration;
    PageType = Card;
    SourceTable = "GAG PDC Setup";
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Reminder Date Formula"; Rec."Reminder Date Formula")
                {
                    ToolTip = 'Specifies the value of the Reminder Date Formula field.';
                }

            }
            group(Receipt)
            {
                Caption = 'Receipts';

                field("Receipts Nos."; Rec."Receipts Nos.")
                {

                }
                field("Posted Receipt Nos."; Rec."Posted Receipt Nos.")
                {

                }
                field("PDC Receipt Approval Required"; Rec."PDC Receipt Approval Required")
                {

                }
                field("PDC Receipt Request Status"; Rec."PDC Receipt Request Status")
                {

                }
                field("PDC Receipt Approval Status"; Rec."PDC Receipt Approval Status")
                {

                }
                field("PDC Receipt Rejected Status"; Rec."PDC Receipt Rejected Status")
                {

                }
                field("PDC Receipt Re-Open Status"; Rec."PDC Receipt Re-Open Status")
                {

                }
                field("PDC Receipt Terms & Condition"; Rec."PDC Receipt Terms & Condition")
                {

                }
                field("Un-Posted PDC Rcpt. Report ID"; Rec."Un-Posted PDC Rcpt. Report ID")
                {

                }
                field("Posted PDC Rcpt. Report ID"; Rec."Posted PDC Rcpt. Report ID")
                {

                }

            }
            group(Issues)
            {
                Caption = 'Issues';

                field("Issue Nos."; Rec."Issue Nos.")
                {

                }
                field("Posted Issue Nos"; Rec."Posted Issue Nos")
                {

                }
                field("PDC Issue Approval Required"; Rec."PDC Issue Approval Required")
                {

                }
                field("PDC Issue Request Status"; Rec."PDC Issue Request Status")
                {

                }
                field("PDC Issue Approval Status"; Rec."PDC Issue Approval Status")
                {

                }
                field("PDC Issue Reject Status"; Rec."PDC Issue Reject Status")
                {

                }
                field("PDC Issue Re-Open Status"; Rec."PDC Issue Re-Open Status")
                {

                }
                field("PDC Terms & Condition"; Rec."PDC Terms & Condition")
                {

                }
                field("Un-Posted PDC Issue Report ID"; Rec."Un-Posted PDC Issue Report ID")
                {

                }
                field("Posted PDC Issue Report ID"; Rec."Posted PDC Issue Report ID")
                {

                }

            }
        }
    }
}
