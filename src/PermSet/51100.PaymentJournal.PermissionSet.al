/// <summary>
/// Unknown "PaymentJournal" (ID 51100).
/// </summary>
permissionset 51100 PaymentJournal
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
