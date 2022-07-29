/// <summary>
/// PageExtension "MyExtension" (ID 50510) extends Record Payment Journal.
/// </summary>
pageextension 50200 "KNH Extension" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter(IncomingDocAttachFactBox)
        {
            part(ApplyEntriesSub; "KNH Payment Journal Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Vendor No." = field("Account No."), "Currency Code" = field("Currency Code");
                SubPageView = sorting("Document No.");
            }
        }
    }
    actions
    {
        addafter("Ledger E&ntries")
        {
            action("Email Test")
            {
                Caption = 'Email Test';
                ApplicationArea = All;
            }
        }
        addBefore(ExportPaymentsToFile)
        {
            action(ImportGenJournalLines)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test I&mport';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Import a file with payment information to journal lines';
                trigger OnAction();
                begin
                    Xmlport.Run(Xmlport::"KNH Test Import", true, true);
                end;
            }
        }
        addBefore(ImportGenJournalLines)
        {
            action(ExportGenJournalLines)
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
                    if GenJnlLine.FindFirst then
                        if not rec.FindSet() then
                            Error(NothingToExportErr);
                    Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    Rec.TestField("Check Printed", false);

                    Rec.CheckDocNoOnLines();
                    if Rec.IsExportedToPaymentFile() then
                        if not ConfirmManagement.GetResponseOrDefault(ExportAgainQst, true) then
                            exit;

                    Xmlport.Run(xmlport::"KNH Test Export", false, false, GenJnlLine);
                end;
            }
        }
    }
}