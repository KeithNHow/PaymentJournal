/// <summary>
/// XmlPort KNH Pymt Journal Export(ID 51100).
/// </summary>
xmlport 51100 "KNH Pymt Journal Export"
{
    Caption = 'Natwest Pymt Jnl Export ';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                SourceTableView = WHERE("Exported to Payment File" = const(false));

                textattribute(VendBankName)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        VendBankAcc.Get(GenJournalLine."Account No.", GenJournalLine."Recipient Bank Account");
                        VendBankName := VendBankAcc.Name;
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
                        PymtRecordCount := Format(RecordCount);
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
                        VendBankAcc.Get(GenJournalLine."Account No.", GenJournalLine."Recipient Bank Account");
                        BankAccSortCode := VendBankAcc."Bank Branch No.";
                    end;
                }
                textelement(VendBankAccNo)
                {
                    trigger OnAfterAssignVariable()
                    begin
                        VendBankAcc.Get(GenJournalLine."Account No.", GenJournalLine."Recipient Bank Account");
                        VendBankAccNo := VendBankAcc."Bank Account No.";
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
        if PostingDateReq = 0D then
            PostingDateReq := WorkDate();
    end;

    trigger OnPreXmlPort()
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'Default');
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'Default');
        GenJnlLine.SetRange(GenJnlLine."Exported to Payment File", false);
        RecordCount := GenJnlLine.Count();
    end;

    var
        VendBankAcc: Record "Vendor Bank Account";
        PostingDateReq: Date;
        RecordCount: Integer;
}
