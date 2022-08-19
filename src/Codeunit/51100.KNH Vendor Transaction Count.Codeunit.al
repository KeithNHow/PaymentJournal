/// <summary>
/// Codeunit KNH Vendor (ID 51100).
/// </summary>
codeunit 51100 "KNH Vendor Transaction Count"
{
    TableNo = Vendor;

    trigger OnRun();
    var
        VendLedgEntries: Record "Vendor Ledger Entry";
        TotalRecords: Integer;
    begin
        VendLedgEntries.SetRange("Buy-from Vendor No.", Rec."No.");
        TotalRecords := VendLedgEntries.Count();
    end;

}
