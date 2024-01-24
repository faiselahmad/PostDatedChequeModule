table 60116 "GAG NML Setup"
{
    Caption = 'GAG NML Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Layer Code"; Code[10])
        {
            Caption = 'Layer Code';
        }
        field(3; "Revenue Recognition Req. Code"; Code[30])
        {
            Caption = 'Revenue Recognition Req. Code';
        }
        field(4; "Belgium Specific Requirement"; Boolean)
        {
            Caption = 'Belgium Specific Requirement';
        }
        field(5; "Purchase Planning Password"; Text[20])
        {
            Caption = 'Purchase Planning Password';
        }
        field(6; "Credit Limit Requirement Code"; Code[30])
        {
            Caption = 'Credit Limit Requirement Code';
        }
        field(7; "Purch.Ord.Approval Req. Code"; Code[30])
        {
            Caption = 'Purch.Ord.Approval Req. Code';
        }
        field(8; "Discount Limit Req.Code"; Code[30])
        {
            Caption = 'Discount Limit Req.Code';
        }
        field(9; "Skip Licence Check"; Boolean)
        {
            Caption = 'Skip Licence Check';
        }
        field(10; "Default Rev.Reco Doc. Status"; Code[20])
        {
            Caption = 'Default Rev.Reco Doc. Status';
        }
        field(11; "Delivery Note Req. Code"; Code[30])
        {
            Caption = 'Delivery Note Req. Code';
        }
        field(12; "Disable Ship & Inv. Veh. Post"; Code[30])
        {
            Caption = 'Disable Ship & Inv. Veh. Post';
        }
        field(13; "JOB Type Dimension Code"; Code[20])
        {
            Caption = 'JOB Type Dimension Code';
        }
        field(14; "Division Dimension Mapping"; Code[20])
        {
            Caption = 'Division Dimension Mapping';
        }
        field(15; "Auto Item Chrg. Req. Code"; Code[30])
        {
            Caption = 'Auto Item Chrg. Req. Code';
        }
        field(16; "Proforma Invoice Footer Code"; Code[10])
        {
            Caption = 'Proforma Invoice Footer Code';
        }
        field(17; "Commercial Invoice Footer Code"; Code[10])
        {
            Caption = 'Commercial Invoice Footer Code';
        }
        field(18; "Delivery Request Footer Code"; Code[10])
        {
            Caption = 'Delivery Request Footer Code';
        }
        field(19; "Average Costing Jrnl. Template"; Code[10])
        {
            Caption = 'Average Costing Jrnl. Template';
        }
        field(20; "Average Costing Jrnl. Batch"; Code[10])
        {
            Caption = 'Average Costing Jrnl. Batch';
        }
        field(21; "Delivery Request Nos."; Code[10])
        {
            Caption = 'Delivery Request Nos.';
        }
        field(22; "IC Sales Requirement Code"; Code[30])
        {
            Caption = 'IC Sales Requirement Code';
        }
        field(23; "IC Purchase Requirement Code"; Code[30])
        {
            Caption = 'IC Purchase Requirement Code';
        }
        field(24; "Veh.Sale.Return.Aprvl.Req"; Code[30])
        {
            Caption = 'Veh.Sale.Return.Aprvl.Req';
        }
        field(25; "IC Service Aprvl.Req.Code"; Code[30])
        {
            Caption = 'IC Service Aprvl.Req.Code';
        }
        field(26; "Employee Dimension Mapping"; Code[20])
        {
            Caption = 'Employee Dimension Mapping';
        }
        field(27; "Default Veh.Rec.Jrnl ProdGrp"; Code[20])
        {
            Caption = 'Default Veh.Rec.Jrnl ProdGrp';
        }
        field(28; "Re-Open Purchase Order Status"; Code[20])
        {
            Caption = 'Re-Open Purchase Order Status';
        }
        field(29; "Re-Open Sales Order Status"; Code[20])
        {
            Caption = 'Re-Open Sales Order Status';
        }
        field(30; "Average Costing ItemCharge No."; Code[20])
        {
            Caption = 'Average Costing ItemCharge No.';
        }
        field(31; "Refurbishment Job ItemCharge"; Code[20])
        {
            Caption = 'Refurbishment Job ItemCharge';
        }
        field(32; "Accessory Fitment Item Charge"; Code[20])
        {
            Caption = 'Accessory Fitment Item Charge';
        }
        field(33; "Miscellaneous Item Charge"; Code[20])
        {
            Caption = 'Miscellaneous Item Charge';
        }
        field(34; "Vehicle Check Item Charge"; Code[20])
        {
            Caption = 'Vehicle Check Item Charge';
        }
        field(35; "Default Service Vendor"; Code[20])
        {
            Caption = 'Default Service Vendor';
        }
        field(36; "Delivery Note Nos."; Code[10])
        {
            Caption = 'Delivery Note Nos.';
        }
        field(37; "Branch Dimension Mapping"; Code[20])
        {
            Caption = 'Branch Dimension Mapping';
        }
        field(38; "Incoterms Mandatory"; Boolean)
        {
            Caption = 'Incoterms Mandatory';
        }
        field(39; "Can. Delivery Request Nos."; Code[10])
        {
            Caption = 'Can. Delivery Request Nos.';
        }
        field(40; "Can. Delivery Note Nos."; Code[10])
        {
            Caption = 'Can. Delivery Note Nos.';
        }
        field(41; "Salary Jrnl Template Name"; Code[20])
        {
            Caption = 'Salary Jrnl Template Name';
        }
        field(42; "Salary Jrnl Batch Name"; Code[20])
        {
            Caption = 'Salary Jrnl Batch Name';
        }
        field(43; "HRMS Integration Req. Code"; Code[30])
        {
            Caption = 'HRMS Integration Req. Code';
        }
        field(44; "PDC Terms & Condition"; Blob)
        {
            Caption = 'PDC Terms & Condition';
        }
        field(45; "Bank Voucher Terms & Condition"; Blob)
        {
            Caption = 'Bank Voucher Terms & Condition';
        }
        field(46; "IB Bal.Transfer Jrnl. Template"; Code[10])
        {
            Caption = 'IB Bal.Transfer Jrnl. Template';
        }
        field(47; "IB Bal.Transfer Jrnl. Batch"; Code[10])
        {
            Caption = 'IB Bal.Transfer Jrnl. Batch';
        }
        field(48; "IB Bal.Transfer Nos."; Code[10])
        {
            Caption = 'IB Bal.Transfer Nos.';
        }
        field(49; "IB Bal.Transfer Source Code"; Code[10])
        {
            Caption = 'IB Bal.Transfer Source Code';
        }
        field(50; "IB Transfer Order Nos."; Code[10])
        {
            Caption = 'IB Transfer Order Nos.';
        }
        field(51; "Posted IB Transfer Order Nos."; Code[10])
        {
            Caption = 'Posted IB Transfer Order Nos.';
        }
        field(52; "IB Sales Invoice Nos."; Code[10])
        {
            Caption = 'IB Sales Invoice Nos.';
        }
        field(53; "Posted IB Sales Invoice Nos."; Code[10])
        {
            Caption = 'Posted IB Sales Invoice Nos.';
        }
        field(54; "IB Sales CreditMemo Nos."; Code[10])
        {
            Caption = 'IB Sales CreditMemo Nos.';
        }
        field(55; "Posted IB Sales Cr.Memo Nos."; Code[10])
        {
            Caption = 'Posted IB Sales Cr.Memo Nos.';
        }
        field(56; "IB Purchase Invoice Nos."; Code[10])
        {
            Caption = 'IB Purchase Invoice Nos.';
        }
        field(57; "Posted IB Purchas Invoice Nos."; Code[10])
        {
            Caption = 'Posted IB Purchas Invoice Nos.';
        }
        field(58; "IB Purchase CreditMemo Nos."; Code[10])
        {
            Caption = 'IB Purchase CreditMemo Nos.';
        }
        field(59; "Posted IB Purchas Cr.Memo Nos."; Code[10])
        {
            Caption = 'Posted IB Purchas Cr.Memo Nos.';
        }
        field(60; "Sales Quote Footer Code"; Code[10])
        {
            Caption = 'Sales Quote Footer Code';
        }
        field(61; "Sales Order Footer Code"; Code[10])
        {
            Caption = 'Sales Order Footer Code';
        }
        field(62; "Tax Invoice Footer Code"; Code[10])
        {
            Caption = 'Tax Invoice Footer Code';
        }
        field(63; "Sales Conditions Jrnl Nos."; Code[10])
        {
            Caption = 'Sales Conditions Jrnl Nos.';
        }
        field(64; "Branch Order Address"; Code[10])
        {
            Caption = 'Branch Order Address';
        }
        field(65; "Receipt Checked By"; Code[20])
        {
            Caption = 'Receipt Checked By';
        }
        field(66; "Delivery Note Report ID"; Integer)
        {
            Caption = 'Delivery Note Report ID';
        }
        field(67; "Vat Condition Filter"; Boolean)
        {
            Caption = 'Vat Condition Filter';
        }
        field(68; "Depeartment Dimension Mapping"; Code[10])
        {
            Caption = 'Depeartment Dimension Mapping';
        }
        field(69; "Delivery Request Report ID"; Integer)
        {
            Caption = 'Delivery Request Report ID';
        }
        field(70; "Proforma Invoice Report ID"; Integer)
        {
            Caption = 'Proforma Invoice Report ID';
        }
        field(71; "Commercial Invoice Report ID"; Integer)
        {
            Caption = 'Commercial Invoice Report ID';
        }
        field(72; "Custom Request Form Report ID"; Integer)
        {
            Caption = 'Custom Request Form Report ID';
        }
        field(73; "Veh.Sal.Order No Sales Lines"; Integer)
        {
            Caption = 'Veh.Sal.Order No Sales Lines';
        }
        field(74; "Veh.Sa.Quote No Sales Lines"; Integer)
        {
            Caption = 'Veh.Sa.Quote No Sales Lines';
        }
        field(75; "Veh. Pro.Inv. No Sales Lines"; Integer)
        {
            Caption = 'Veh. Pro.Inv. No Sales Lines';
        }
        field(76; "PM Veh. Pro.Inv. Report ID"; Integer)
        {
            Caption = 'PM Veh. Pro.Inv. Report ID';
        }
        field(77; "PM Veh. Sal. TAX Inv. ReportID"; Integer)
        {
            Caption = 'PM Veh. Sal. TAX Inv. ReportID';
        }
        field(78; "PM Veh.Sal.TAX Cr.Memo Report"; Integer)
        {
            Caption = 'PM Veh.Sal.TAX Cr.Memo Report';
        }
        field(79; "PM Veh.Sal.Quote Report ID"; Integer)
        {
            Caption = 'PM Veh.Sal.Quote Report ID';
        }
        field(80; "PM Veh.Sal.Rev.Reco.Inv Report"; Integer)
        {
            Caption = 'PM Veh.Sal.Rev.Reco.Inv Report';
        }
        field(81; "PM Veh.Sal.RevReco.Cr.Memo Rep"; Integer)
        {
            Caption = 'PM Veh.Sal.RevReco.Cr.Memo Rep';
        }
        field(82; "PM Veh.Sal. Order Report ID"; Integer)
        {
            Caption = 'PM Veh.Sal. Order Report ID';
        }
        field(83; "PM Veh. Comm. Inv. Report ID"; Integer)
        {
            Caption = 'PM Veh. Comm. Inv. Report ID';
        }
        field(84; "Enable Login Companies"; Boolean)
        {
            Caption = 'Enable Login Companies';
        }
        field(85; "Transfer Model Nos."; Code[10])
        {
            Caption = 'Transfer Model Nos.';
        }
        field(86; "Tax Credit Memo Footer Code"; Code[10])
        {
            Caption = 'Tax Credit Memo Footer Code';
        }
        field(87; "Rev. Invoice Footer Code"; Code[10])
        {
            Caption = 'Rev. Invoice Footer Code';
        }
        field(88; "Rev. Credit Memo Footer Code"; Code[10])
        {
            Caption = 'Rev. Credit Memo Footer Code';
        }
        field(89; Workshop; Boolean)
        {
            Caption = 'Workshop';
        }
        field(90; "Default VAT%"; Decimal)
        {
            Caption = 'Default VAT%';
        }
        field(91; "BE Terms & Condisions"; Blob)
        {
            Caption = 'BE Terms & Condisions';
        }
        field(92; "Last Vendor Ledger Entry No."; Integer)
        {
            Caption = 'Last Vendor Ledger Entry No.';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
