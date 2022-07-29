/// <summary>
/// Codeunit KNH Vendor (ID 50002).
/// </summary>
codeunit 50200 "KNH Vendor Transaction Count"
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
