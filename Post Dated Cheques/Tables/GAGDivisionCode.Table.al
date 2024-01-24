table 60105 "GAG Division Code"
{
    Caption = 'GAG Division Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Default Service Vendor"; Code[20])
        {
            Caption = 'Default Service Vendor';
        }
        field(4; "Default Service Customer"; Code[20])
        {
            Caption = 'Default Service Customer';
        }
        field(5; "Sales Quote Validity Formula"; DateFormula)
        {
            Caption = 'Sales Quote Validity Formula';
        }
        field(6; "Arch. Sales Quote Vality Formu"; DateFormula)
        {
            Caption = 'Arch. Sales Quote Vality Formu';
        }
        field(7; "Order Trcking Validity Formula"; DateFormula)
        {
            Caption = 'Order Trcking Validity Formula';
        }
        field(8; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
        }
        field(9; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(10; "Purchase Planning Applicable"; Boolean)
        {
            Caption = 'Purchase Planning Applicable';
        }
        field(11; "Average Costing Applicable"; Boolean)
        {
            Caption = 'Average Costing Applicable';
        }
        field(12; "Profit Margin Applicable"; Boolean)
        {
            Caption = 'Profit Margin Applicable';
        }
        field(13; "Profit Margin Sal.VAT.Cond."; Code[20])
        {
            Caption = 'Profit Margin Sal.VAT.Cond.';
        }
        field(14; "Profit Margin Purch.VAT.Cond."; Code[20])
        {
            Caption = 'Profit Margin Purch.VAT.Cond.';
        }
        field(15; "GAG Adjusted Cost (Expected)"; Decimal)
        {
            Caption = 'GAG Adjusted Cost (Expected)';
        }
        field(16; "GAG Adjusted Cost"; Decimal)
        {
            Caption = 'GAG Adjusted Cost';
        }
        field(17; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
        }
        field(18; UnitCost; Decimal)
        {
            Caption = 'UnitCost';
        }
        field(19; AccessoriesCost; Decimal)
        {
            Caption = 'AccessoriesCost';
        }
        field(20; AverageCost; Decimal)
        {
            Caption = 'AverageCost';
        }
        field(21; CustomsDutyCost; Decimal)
        {
            Caption = 'CustomsDutyCost';
        }
        field(22; FreightCost; Decimal)
        {
            Caption = 'FreightCost';
        }
        field(23; HayazaCost; Decimal)
        {
            Caption = 'HayazaCost';
        }
        field(24; InsuranceCost; Decimal)
        {
            Caption = 'InsuranceCost';
        }
        field(25; MiscellenousCost; Decimal)
        {
            Caption = 'MiscellenousCost';
        }
        field(26; PurchaseCommissionCost; Decimal)
        {
            Caption = 'PurchaseCommissionCost';
        }
        field(27; RefurbishmentCost; Decimal)
        {
            Caption = 'RefurbishmentCost';
        }
        field(28; SpecificCost; Decimal)
        {
            Caption = 'SpecificCost';
        }
        field(29; ThirdPartyServiceCost; Decimal)
        {
            Caption = 'ThirdPartyServiceCost';
        }
        field(30; VehicleHealthCheckCost; Decimal)
        {
            Caption = 'VehicleHealthCheckCost';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
