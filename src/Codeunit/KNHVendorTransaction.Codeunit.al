/// <summary>
/// This codeunit has an OnRun trigger that filters for a single Vendor.
/// </summary>
codeunit 51100 KNHVendorTransaction
{
    TableNo = Vendor;

    trigger OnRun();
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Buy-from Vendor No.", Rec."No.");
    end;
}
