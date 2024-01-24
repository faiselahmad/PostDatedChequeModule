table 60104 "User Session"
{
    Caption = 'User Session';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(13; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        field(21; "Last EPC Make Code"; Code[20])
        {
            Caption = 'Last EPC Make Code';
        }
        field(22; "Initial Data Import"; Boolean)
        {
            Caption = 'Initial Data Import';
        }
        field(23; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
        }
        field(24; "Dealer Importer Code"; Code[10])
        {
            Caption = 'Dealer Importer Code';
        }
        field(25; "Last Source of Demand"; Integer)
        {
            Caption = 'Last Source of Demand';
        }
        field(26; "Last Cash Register Used"; Code[20])
        {
            Caption = 'Last Cash Register Used';
        }
        field(27; ClientGUID; Guid)
        {
            Caption = 'ClientGUID';
        }
        field(28; "Current PCASO Version"; Decimal)
        {
            Caption = 'Current PCASO Version';
        }
        field(29; "Actual Segment No."; Code[30])
        {
            Caption = 'Actual Segment No.';
        }
        field(30; "Thousands Separator"; Text[1])
        {
            Caption = 'Thousands Separator';
        }
        field(31; "Decimal Separator"; Text[1])
        {
            Caption = 'Decimal Separator';
        }
        field(32; "Date Separator"; Text[1])
        {
            Caption = 'Date Separator';
        }
        field(33; "Time Separator"; Text[1])
        {
            Caption = 'Time Separator';
        }
        field(34; "Date Format"; Code[10])
        {
            Caption = 'Date Format';
        }
        field(35; ScheduleOpened; Boolean)
        {
            Caption = 'ScheduleOpened';
        }
        field(36; "Print Archive"; Boolean)
        {
            Caption = 'Print Archive';
        }
        field(37; "Maintenance Mode"; Boolean)
        {
            Caption = 'Maintenance Mode';
        }
        field(38; "Skip Import"; Boolean)
        {
            Caption = 'Skip Import';
        }
        field(39; "Batch Process Execution"; Boolean)
        {
            Caption = 'Batch Process Execution';
        }
    }

    keys
    {
        key(PK; "Session ID")
        {
            Clustered = true;
        }
    }
    procedure GetLocation(): Code[10]
    var
        LocationL: Record Location;
    begin
        UserSessionUnitG.GetUserSession(Rec);
        IF LocationL.GET("Location Code") THEN
            EXIT(LocationL.Code);
        EXIT('');
    end;

    procedure GetBranchCode(LocationCodeP: Code[10]): Code[10]
    var
        LocationL: Record Location;
    begin
        IF LocationCodeP = '' THEN BEGIN
            UserSessionUnitG.GetUserSession(Rec);
            IF LocationL.GET("Location Code") THEN
                EXIT(LocationL."Branch Code");
        END ELSE
            IF LocationL.GET(LocationCodeP) THEN
                EXIT(LocationL."Branch Code");
        EXIT('');
    end;

    var
        UserSessionUnitG: Codeunit "User Session Unit";

}