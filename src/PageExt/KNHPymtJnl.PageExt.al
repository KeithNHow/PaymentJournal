/// <summary>
/// This PageExtension extends the Payment Journal page by adding a listpart that shows the related Vendor Ledger Entries for the current payment journal batch. An action is also added to the ribbon to allow for testing of an import process that brings in payment information from an external file, and another action to test exporting payment information to a file.
/// The export payment journal lines action checks if there are any lines to export, and if the lines have already been exported. If the lines have already been exported, the user is prompted to confirm if they want to export the lines again.
/// </summary>
pageextension 51100 KNHPymtJnl extends "Payment Journal"
{
    layout
    {
        addafter(IncomingDocAttachFactBox)
        {
            part(ApplyEntriesSub; KNHPaymentJournalSubpage)
            {
                ApplicationArea = All;
                SubPageLink = "Vendor No." = field("Account No."), "Currency Code" = field("Currency Code");
                SubPageView = sorting("Document No.");
            }
        }
    }
    actions
    {
        addbefore(ExportPaymentsToFile)
        {
            action(KNHImportGenJournalLines)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test I&mport';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Import a file with payment information to journal lines';
                trigger OnAction();
                begin
                    Xmlport.Run(Xmlport::KNHTestImport, true, true);
                end;
            }
        }
        addbefore(KNHImportGenJournalLines)
        {
            action(KNHExportGenJournalLines)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Ex&port';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Export a BACS file with payment information from journal lines';
                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                    ConfirmManagement: Codeunit "Confirm Management";
                    ExportAgainQst: Label 'One or more of the selected lines have already been exported. Do you want to export them again?';
                    NothingToExportErr: Label 'There is nothing to export.';
                begin
                    GenJnlLine.CopyFilters(Rec);
                    if GenJnlLine.FindFirst() then
                        if not Rec.FindSet() then
                            Error(NothingToExportErr);
                    Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    Rec.TestField("Check Printed", false);

                    Rec.CheckDocNoOnLines();
                    if Rec.IsExportedToPaymentFile() then
                        if not ConfirmManagement.GetResponseOrDefault(ExportAgainQst, true) then
                            exit;

                    Xmlport.Run(Xmlport::KNHTestExport, false, false, GenJnlLine);
                end;
            }
        }
    }
}