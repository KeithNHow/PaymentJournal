permissionset 51100 KNHPaymentJournal
{
    Assignable = true;
    Caption = 'Payment Journal', MaxLength = 30;
    Permissions =
        codeunit KNHVendorTransaction = X,
        page KNHPaymentJournalSubpage = X,
        xmlport KNHPymtJournalExport = X,
        xmlport KNHTestImport = X,
        xmlport KNHTestExport = X;
}
