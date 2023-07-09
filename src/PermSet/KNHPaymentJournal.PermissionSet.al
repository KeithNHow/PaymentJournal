/// <summary>
/// Unknown "KNH"KNHPaymentJournal"" (ID 51100).
/// </summary>
permissionset 51100 PaymentJournal
{
    Assignable = true;
    Caption = 'Payment Journal', MaxLength = 30;
    Permissions =
        codeunit "KNHVendorTransactionCount" = X,
        page "KNHPaymentJournalSubpage" = X,
        xmlport "KNHPymtJournalExport" = X,
        xmlport "KNHTestImport" = X,
        xmlport "KNHTestExport" = X;
}
