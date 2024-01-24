tableextension 60100 "Purchase HeaderExt" extends "Purchase Header"
{
    fields
    {
        field(60100; "Order Type"; Option)
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Parts Sales & Purchases","Vehicle Sales & Purchases",Service;
            OptionCaption = 'Parts Sales & Purchases,Vehicle Sales & Purchases,Service';
        }
    }
}
