/// <summary>
/// TableExtension KNH Vendor (ID 51100) extends Record Vendor.
/// </summary>
tableextension 51100 "KNH Vendor" extends Vendor
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
