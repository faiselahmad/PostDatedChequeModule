table 60115 "Report Layout Setup"
{
    Caption = 'Report Layout Setup';
    DataClassification = ToBeClassified;
    LookupPageId = "Report Layout List";
    DrillDownPageId = "Report Layout List";

    fields
    {
        field(1; "Make Code"; Code[20])
        {
            Caption = 'Make Code';
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(4; "Footer 1-1"; Text[150])
        {
            Caption = 'Footer 1-1';
        }
        field(5; "Footer 1-2"; Text[150])
        {
            Caption = 'Footer 1-2';
        }
        field(6; "Footer 1-3"; Text[150])
        {
            Caption = 'Footer 1-3';
        }
        field(7; "Footer 1-4"; Text[150])
        {
            Caption = 'Footer 1-4';
        }
        field(8; "Footer 1-5"; Text[150])
        {
            Caption = 'Footer 1-5';
        }
        field(9; "Footer 1-6"; Text[150])
        {
            Caption = 'Footer 1-6';
        }
        field(10; "Footer 2-1"; Text[24])
        {
            Caption = 'Footer 2-1';
        }
        field(11; "Footer 2-2"; Text[24])
        {
            Caption = 'Footer 2-2';
        }
        field(12; "Footer 2-3"; Text[24])
        {
            Caption = 'Footer 2-3';
        }
        field(13; "Footer 2-4"; Text[24])
        {
            Caption = 'Footer 2-4';
        }
        field(14; "Footer 2-5"; Text[24])
        {
            Caption = 'Footer 2-5';
        }
        field(15; "Footer 2-6"; Text[24])
        {
            Caption = 'Footer 2-6';
        }
        field(16; "Footer 3-1"; Text[24])
        {
            Caption = 'Footer 3-1';
        }
        field(17; "Footer 3-2"; Text[24])
        {
            Caption = 'Footer 3-2';
        }
        field(18; "Footer 3-3"; Text[24])
        {
            Caption = 'Footer 3-3';
        }
        field(19; "Footer 3-4"; Text[24])
        {
            Caption = 'Footer 3-4';
        }
        field(20; "Footer 3-5"; Text[24])
        {
            Caption = 'Footer 3-5';
        }
        field(21; "Footer 3-6"; Text[24])
        {
            Caption = 'Footer 3-6';
        }
        field(22; "Footer 4-1"; Text[24])
        {
            Caption = 'Footer 4-1';
        }
        field(23; "Footer 4-2"; Text[24])
        {
            Caption = 'Footer 4-2';
        }
        field(24; "Footer 4-3"; Text[24])
        {
            Caption = 'Footer 4-3';
        }
        field(25; "Footer 4-4"; Text[24])
        {
            Caption = 'Footer 4-4';
        }
        field(26; "Footer 4-5"; Text[24])
        {
            Caption = 'Footer 4-5';
        }
        field(27; "Footer 4-6"; Text[24])
        {
            Caption = 'Footer 4-6';
        }
        field(28; "Footer 5-1"; Text[24])
        {
            Caption = 'Footer 5-1';
        }
        field(29; "Footer 5-2"; Text[24])
        {
            Caption = 'Footer 5-2';
        }
        field(30; "Footer 5-3"; Text[24])
        {
            Caption = 'Footer 5-3';
        }
        field(31; "Footer 5-4"; Text[24])
        {
            Caption = 'Footer 5-4';
        }
        field(32; "Footer 5-5"; Text[24])
        {
            Caption = 'Footer 5-5';
        }
        field(33; "Footer 5-6"; Text[24])
        {
            Caption = 'Footer 5-6';
        }
        field(34; "Footer 6-1"; Text[24])
        {
            Caption = 'Footer 6-1';
        }
        field(35; "Footer 6-2"; Text[24])
        {
            Caption = 'Footer 6-2';
        }
        field(36; "Footer 6-3"; Text[24])
        {
            Caption = 'Footer 6-3';
        }
        field(37; "Footer 6-4"; Text[24])
        {
            Caption = 'Footer 6-4';
        }
        field(38; "Footer 6-5"; Text[24])
        {
            Caption = 'Footer 6-5';
        }
        field(39; "Footer 6-6"; Text[24])
        {
            Caption = 'Footer 6-6';
        }
        field(40; "Header Graphic Left"; Blob)
        {
            Caption = 'Header Graphic Left';
        }
        field(41; "Header Graphic Right"; Blob)
        {
            Caption = 'Header Graphic Right';
        }
        field(42; "Footer Graphic Left"; Blob)
        {
            Caption = 'Footer Graphic Left';
        }
        field(43; "Footer Graphic Right"; Blob)
        {
            Caption = 'Footer Graphic Right';
        }
        field(44; "Duplicate Graphic"; Blob)
        {
            Caption = 'Duplicate Graphic';
        }
        field(45; "Auth. Left Alignment"; Option)
        {
            Caption = 'Auth. Left Alignment';
            OptionMembers = Left,Center,Right;
        }
        field(46; "Auth. Left Line 1"; Text[35])
        {
            Caption = 'Auth. Left Line 1';
        }
        field(47; "Auth. Left Line 2"; Text[35])
        {
            Caption = 'Auth. Left Line 2';
        }
        field(48; "Auth. Left Line 3"; Text[35])
        {
            Caption = 'Auth. Left Line 3';
        }
        field(49; "Auth. Left Line 4"; Text[35])
        {
            Caption = 'Auth. Left Line 4';
        }
        field(50; "Auth. Left Line 5"; Text[35])
        {
            Caption = 'Auth. Left Line 5';
        }
        field(51; "Header Graphic Center"; Blob)
        {
            Caption = 'Header Graphic Center';
        }
    }
    keys
    {
        key(PK; "Make Code")
        {
            Clustered = true;
        }
    }
    procedure GetReportLayout(VAR RepLayoutSetupP: Record "Report Layout Setup"; MakeCodeP: Code[20]; LocationCodeP: Code[20])
    var
        myInt: Integer;
    begin
        RepLayoutSetupP.SETRANGE("Make Code", MakeCodeP);
        RepLayoutSetupP.SETRANGE("Location Code", LocationCodeP);
        RepLayoutSetupP.SETFILTER("Start Date", '<=%1', WORKDATE);
        IF NOT RepLayoutSetupP.FINDSET THEN
            RepLayoutSetupP.SETRANGE("Location Code", '');
        IF NOT RepLayoutSetupP.FINDSET THEN BEGIN
            RepLayoutSetupP.SETRANGE("Make Code", '');
            RepLayoutSetupP.SETRANGE("Location Code", LocationCodeP);
        END;
        IF NOT RepLayoutSetupP.FINDSET THEN
            RepLayoutSetupP.SETRANGE("Location Code", '');

        IF RepLayoutSetupP.FINDLAST THEN
            RepLayoutSetupP.CALCFIELDS("Header Graphic Left", "Header Graphic Right", "Header Graphic Center", "Footer Graphic Left",

    "Footer Graphic Right", "Duplicate Graphic")
    end;

}
