page 60119 "User Setups"
{
    ApplicationArea = All;
    Caption = 'User Setups';
    PageType = List;
    SourceTable = "User Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                    ToolTip = 'Specifies the earliest date on which the user is allowed to post to the company.';
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                    ToolTip = 'Specifies the last date on which the user is allowed to post to the company.';
                }
                field("Register Time"; Rec."Register Time")
                {
                    ToolTip = 'Specifies whether to register the user''s time usage defined as the time spent from when the user logs in to when the user logs out. Unexpected interruptions, such as idle session timeout, terminal server idle session timeout, or a client crash are not recorded.';
                }
                field("Allow Deferral Posting To"; Rec."Allow Deferral Posting To")
                {
                    ToolTip = 'Specifies the last date on which the user is allowed to post deferrals to the company.';
                }
                field("Allow Deferral Posting From"; Rec."Allow Deferral Posting From")
                {
                    ToolTip = 'Specifies the earliest date on which the user is allowed to post deferrals to the company.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the salesperson or purchaser code that relates to the User ID field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ToolTip = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.';
                }
                field("Sales Amount Approval Limit"; Rec."Sales Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field("Purchase Amount Approval Limit"; Rec."Purchase Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field("Unlimited Sales Approval"; Rec."Unlimited Sales Approval")
                {
                    ToolTip = 'Specifies that the user on this line is allowed to approve sales records with no maximum amount. If you select this check box, then you cannot fill the Sales Amount Approval Limit field.';
                }
                field("Unlimited Purchase Approval"; Rec."Unlimited Purchase Approval")
                {
                    ToolTip = 'Specifies that the user on this line is allowed to approve purchase records with no maximum amount. If you select this check box, then you cannot fill the Purchase Amount Approval Limit field.';
                }
                field(Substitute; Rec.Substitute)
                {
                    ToolTip = 'Specifies the User ID of the user who acts as a substitute for the original approver.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the user''s phone number.';
                }
                field("Request Amount Approval Limit"; Rec."Request Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field("Unlimited Request Approval"; Rec."Unlimited Request Approval")
                {
                    ToolTip = 'Specifies that the user on this line can approve all purchase quotes regardless of their amount. If you select this check box, then you cannot fill the Request Amount Approval Limit field.';
                }
                field("Approval Administrator"; Rec."Approval Administrator")
                {
                    ToolTip = 'Specifies the user who has rights to unblock approval workflows, for example, by delegating approval requests to new substitute approvers and deleting overdue approval requests.';
                }
                field("License Type"; Rec."License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.';
                }
                field("Sales Invoice Posting Policy"; Rec."Sales Invoice Posting Policy")
                {
                    ToolTip = 'Specify if you want user who posts warehouse shipment, sales shipments, or inventory pick to be able to post invoice/credit-memo as well.';
                }
                field("Purch. Invoice Posting Policy"; Rec."Purch. Invoice Posting Policy")
                {
                    ToolTip = 'Specify if you want user who posts purchase receipt or inventory put-away to be able to post invoice/credit-memo as well.';
                }
                field("Time Sheet Admin."; Rec."Time Sheet Admin.")
                {
                    ToolTip = 'Specifies if a user is a time sheet administrator. A time sheet administrator can access any time sheet and then edit, change, or delete it.';
                }
                field("Allow FA Posting From"; Rec."Allow FA Posting From")
                {
                    ToolTip = 'Specifies the value of the Allow FA Posting From field.';
                }
                field("Allow FA Posting To"; Rec."Allow FA Posting To")
                {
                    ToolTip = 'Specifies the value of the Allow FA Posting To field.';
                }
                field("Allow to Modify Exchange Rate"; Rec."Allow to Modify Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Allow to Modify Exchange Rate field.';
                }
                field("Allow Voucher Modification"; Rec."Allow Voucher Modification")
                {
                    ToolTip = 'Specifies the value of the Allow Voucher Modification field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}