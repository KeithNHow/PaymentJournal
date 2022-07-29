/// <summary>
/// Unknown "PaymentJournal" (ID 50200).
/// </summary>
permissionset 50200 PaymentJournal
{
    Assignable = true;
    Caption = 'Payment Journal', MaxLength = 30;
    Permissions =
        codeunit "KNH Vendor Transaction Count" = X,
        page "KNH Payment Journal Subpage" = X,
        xmlport "KNH Pymt Journal Export" = X,
        xmlport "KNH Test Import" = X,
        xmlport "KNH Test Export" = X;
}
