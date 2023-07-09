/// <summary>
/// TableExtension KNH Vendor (ID 51100) extends Record Vendor.
/// </summary>
tableextension 51100 "KNHVendorExt" extends Vendor
{
    /// <summary>
    /// GotoCodeunit.
    /// </summary>
    procedure GotoVendorCu()
    var
        VendTransCount: Codeunit "KNHVendorTransactionCount";
    begin
        VendTransCount.Run(Rec);
    end;
}
