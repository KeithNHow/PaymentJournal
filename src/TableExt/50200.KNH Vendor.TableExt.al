/// <summary>
/// TableExtension NEU Vendor (ID 50001) extends Record Vendor.
/// </summary>
tableextension 50200 "KNH Vendor" extends Vendor
{
    /// <summary>
    /// GotoCodeunit.
    /// </summary>
    procedure GotoVendorCu()
    var
        VendTransCount: Codeunit "KNH Vendor Transaction Count";
    begin
        VendTransCount.Run(Rec);
    end;
}
