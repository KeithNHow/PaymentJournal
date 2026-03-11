/// <summary>
/// XmlPort is used to export payment journal lines to a BACS file layout. It is launched from an action on the Payment Journal page, where the user can select the journal lines to be exported. The XMLPort will then loop through the selected lines and export the relevant information to a file.
/// The OnInitXmlPort trigger is used to set a default posting date if the user does not enter one on the request page. The OnPreXmlPort trigger is used to filter the general journal lines that will be exported based on the "Exported to Payment File" field, and to count the number of records that will be exported.
/// The preXMLPort trigger is also used to set the ExportNumber and PymtRecordCount variables, which are included in the export file as part of the BACS file layout requirements. The ExportNumber is a sequential number that can be used to identify the export file, and the PymtRecordCount is the total number of payment records included in the export.
/// </summary>
xmlport 51100 KNHPymtJournalExport
{
    Caption = 'Natwest Pymt Jnl Export ';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                SourceTableView = where("Exported to Payment File" = const(false));

                textattribute(VendBankName)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        this.VendorBankAccount.Get(GenJournalLine."Account No.", GenJournalLine."Recipient Bank Account");
                        VendBankName := this.VendorBankAccount.Name;
                    end;
                }
                textattribute(ExportNumber)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        ExportNumber := Format(0001);
                    end;
                }
                textattribute(PymtRecordCount)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        PymtRecordCount := Format(this.RecordCount);
                    end;
                }
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }
                fieldelement(DocumentType; GenJournalLine."Document Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(RecipientBankAccount; GenJournalLine."Recipient Bank Account")
                {
                }
                fieldelement(MessagetoRecipient; GenJournalLine."Message to Recipient")
                {
                }
                fieldelement(CreditorNo; GenJournalLine."Creditor No.")
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }
                fieldelement(BalAccountNo; GenJournalLine."Bal. Account No.")
                {
                }
                fieldelement(BalAccountType; GenJournalLine."Bal. Account Type")
                {
                }
                textelement(BankAccSortCode)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        this.VendorBankAccount.Get(GenJournalLine."Account No.", GenJournalLine."Recipient Bank Account");
                        BankAccSortCode := this.VendorBankAccount."Bank Branch No.";
                    end;
                }
                textelement(VendorBankAccountNo)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        this.VendorBankAccount.Get(GenJournalLine."Account No.", GenJournalLine."Recipient Bank Account");
                        VendorBankAccountNo := this.VendorBankAccount."Bank Account No.";
                    end;
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDateReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                    }
                }
            }
        }
    }

    trigger OnInitXmlPort()
    begin
        if this.PostingDateReq = 0D then
            this.PostingDateReq := WorkDate();
    end;

    trigger OnPreXmlPort()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'Default');
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'Default');
        GenJournalLine.SetRange(GenJournalLine."Exported to Payment File", false);
        this.RecordCount := GenJournalLine.Count();
    end;

    var
        VendorBankAccount: Record "Vendor Bank Account";
        PostingDateReq: Date;
        RecordCount: Integer;
}
