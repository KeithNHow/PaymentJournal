/// <summary>
/// XmlPort KNH Pymt Journal Export(ID 51100).
/// </summary>
xmlport 51100 "KNHPymtJournalExport"
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
            area(content)
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
        actions
        {
            area(processing)
            {
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
