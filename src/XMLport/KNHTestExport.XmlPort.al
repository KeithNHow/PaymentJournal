/// <summary>
/// XmlPort 51102.
/// </summary>
xmlport 51102 "KNHTestExport"
{
    Caption = 'General Journal Line Export';
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '<None>';
    TableSeparator = '<NewLine>';
    FileName = 'C:\Temp\MyGenJnlLinesExport.txt';
    Direction = Export;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(Integer; Integer)
            {
                SourceTableView = sorting(Number) where(Number = const(1));
                textelement(Supplier)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Supplier := 'Supplier';
                    end;
                }
                textelement(Amount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Amount := 'Amount';
                    end;
                }
                textelement(BankAccount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BankAccount := 'Account No.';
                    end;
                }
                textelement(BankBranch)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BankBranch := 'Sort Code';
                    end;
                }

            }
            tableelement(GenJnlLine; "Gen. Journal Line")
            {
                SourceTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
                fieldelement(Description; GenJnlLine.Description)
                {
                    trigger OnBeforePassField()
                    begin
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '(', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, ')', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '%', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '*', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '@', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '!', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '#', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '[', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, ']', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '?', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '\', '-');
                        GenJnlLine.Description := ConvertStr(GenJnlLine.Description, '/', '-');
                        GenJnlLine.Description := DelChr(GenJnlLine.Description, '=', '-');
                        GenJnlLine.Description := CopyStr(GenJnlLine.Description, 1, 15);
                    end;
                }
                fieldelement(Amount; GenJnlLine.Amount)
                {

                }
                Textelement(BankAccNo)
                {
                    trigger OnBeforePassVariable()
                    var
                        VendBankAcc: Record "Vendor Bank Account";
                    begin
                        VendBankAcc.Get(GenJnlLine."Account No.", GenJnlLine."Recipient Bank Account");
                        BankAccNo := VendBankAcc."Bank Account No.";
                        BankAccNo := DelChr(BankAccNo, '=', '-');
                        BankAccNo := CopyStr(BankAccNo, 1, 8);
                    end;
                }
                Textelement(BankSortCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        VendBankAcc: Record "Vendor Bank Account";
                    begin
                        VendBankAcc.Get(GenJnlLine."Account No.", GenJnlLine."Recipient Bank Account");
                        BankSortCode := VendBankAcc."Bank Branch No.";
                        BankSortCode := DelChr(BankSortCode, '=', '-');
                        BankSortCode := CopyStr(BankSortCode, 1, 6);
                    end;
                }
            }
        }
    }
}