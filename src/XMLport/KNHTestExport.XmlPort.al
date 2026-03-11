/// <summary>
/// XmlPort is used to export payment journal lines to a BACS file layout. It is launched from an action on the Payment Journal page, where the user can select the journal lines to be exported. The XMLPort will then loop through the selected lines and exports the relevant information to a file.
/// The exported file is a text file with a .txt extension. There is no delimiter. The first line of the file contains the column headers, and each subsequent line contains the data for each journal line. The file is saved to the C:\Temp folder with the name PymtJnlLinesExport.txt. The XMLPort uses UTF-8 encoding to ensure that special characters are properly handled in the export.
/// Export fields include Description, Amount, Bank Account Number and Bank Sort Code. The Description field is cleansed of special characters and truncated to 15 characters to meet the requirements of the BACS file layout. The Bank Account Number and Bank Sort Code are retrieved from the Vendor Bank Account table based on the account number and recipient bank account specified in the journal line. These fields are also cleansed of special characters and truncated to meet the BACS file layout requirements.
/// </summary>
xmlport 51102 KNHTestExport
{
    Caption = 'General Journal Line Export';
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '<None>';
    TableSeparator = '<NewLine>';
    FileName = 'C:\Temp\PymttJnlLinesExport.txt';
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
                textelement(BankAccNo)
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
                textelement(BankSortCode)
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