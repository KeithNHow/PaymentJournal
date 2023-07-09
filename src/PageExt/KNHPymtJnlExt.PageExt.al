/// <summary>
/// PageExtension "MyExtension" (ID 51100) extends Record Payment Journal.
/// </summary>
pageextension 51100 "KNHPymtJnlExt" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter(IncomingDocAttachFactBox)
        {
            part(ApplyEntriesSub; "KNHPaymentJournalSubpage")
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
            action("KNH ImportGenJournalLines")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test I&mport';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Import a file with payment information to journal lines';
                trigger OnAction();
                begin
                    Xmlport.Run(Xmlport::"KNHTestImport", true, true);
                end;
            }
        }
        addbefore("KNH ImportGenJournalLines")
        {
            action("KNH ExportGenJournalLines")
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
                    NothingToExportErr: Label 'There is nothing to export.';
                    ExportAgainQst: label 'One or more of the selected lines have already been exported. Do you want to export them again?';
                begin
                    GenJnlLine.CopyFilters(Rec);
                    if GenJnlLine.FindFirst() then
                        if not rec.FindSet() then
                            Error(NothingToExportErr);
                    Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    Rec.TestField("Check Printed", false);

                    Rec.CheckDocNoOnLines();
                    if Rec.IsExportedToPaymentFile() then
                        if not ConfirmManagement.GetResponseOrDefault(ExportAgainQst, true) then
                            exit;

                    Xmlport.Run(xmlport::"KNHTestExport", false, false, GenJnlLine);
                end;
            }
        }
    }
}