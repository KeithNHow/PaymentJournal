/// <summary>
/// Codeunit KNH Vendor Transaction Count(ID 51100).
/// </summary>
codeunit 51100 "KNHVendorTransactionCount"
{
    TableNo = Vendor;

    trigger OnRun();
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    //TotalRecords: Integer;
    begin
        VendorLedgerEntry.SetRange("Buy-from Vendor No.", Rec."No.");
        //TotalRecords := VendLedgEntries.Count();
    end;

}
