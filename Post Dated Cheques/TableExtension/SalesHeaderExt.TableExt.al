tableextension 60101 "Sales HeaderExt" extends "Sales Header"
{
    fields
    {
        field(60100; "Order Type"; Text[100])
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
        }
    }
}
