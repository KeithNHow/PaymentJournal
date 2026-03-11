/// <summary>
/// TableExtension extends Vendor table by adding a new procedure to run KNHVendorTransaction codeunit.
/// </summary>
tableextension 51100 KNHVendor extends Vendor
{
    procedure GotoVendorCodeunit()
    var
        KNHVendorTransaction: Codeunit KNHVendorTransaction;
    begin
        KNHVendorTransaction.Run(Rec);
    end;
}
