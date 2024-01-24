codeunit 60111 "User Session Unit"
{
    trigger OnRun()
    begin

    end;

    procedure GetUserSession(VAR UserSessionP: Record "User Session")
    begin
        UserSessionP := UserSessionG;
    end;

    procedure GetLock(): Boolean
    begin
        EXIT(LockG);
    end;

    var
        LockG: Boolean;
        UserSessionG: Record "User Session";
}