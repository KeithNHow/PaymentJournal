/// <summary>
/// XmlPort is used to import records into a payment journal. It is launched from an action on the Payment Journal page, where the user can select an XML file to be imported. The XMLPort will then loop through the records in the file and import them into the general journal line table. The XML file must be in a specific format, with the root element containing attributes for the file name, file type and total number of records, and child elements for each general journal line to be imported. The XMLPort uses UTF-8 encoding to ensure that special characters are properly handled in the import.
/// The request page for the XMLPort includes a field for the user to specify the posting date for the imported journal lines, as well as a field to specify the file name and path of the XML file to be imported. If the user does not specify a posting date, the XMLPort will default to using the current work date. The XMLPort also includes validation logic in the OnAfterAssignField trigger for each field to ensure that the data being imported meets the necessary requirements for the general journal line table.
/// </summary>
xmlport 51101 KNHTestImport
{
    Caption = 'General Journal Line Import';
    Encoding = UTF8;
    FormatEvaluate = Xml;
    FileName = 'C:\Temp\MyGenJnlLinesImport.xml';
    Direction = Import;

    schema
    {
        textelement(root)
        {
            textattribute(FileName)
            {
            }
            textattribute(FileType)
            {
            }
            textattribute(TotNumRec)
            {
            }
            tableelement(GenJnlLine; "Gen. Journal Line")
            {
                fieldelement(JnlTmpName; GenJnlLine."Journal Template Name")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Journal Template Name", 'Test');
                    end;
                }
                fieldelement(BatchName; GenJnlLine."Journal Batch Name")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Journal Batch Name", 'Keith');
                    end;
                }
                fieldelement(LineNo; GenJnlLine."Line No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Line No.", GenJnlLine."Line No." + 10000);
                    end;
                }
                fieldelement(AccountType; GenJnlLine."Account Type")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type");
                    end;
                }
                fieldelement(AccountNo; GenJnlLine."Account No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Account No.");
                    end;
                }
                fieldelement(PostDate; GenJnlLine."Posting Date")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Posting Date");
                    end;
                }
                fieldelement(DocumentType; GenJnlLine."Document Type")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Document Type");
                    end;
                }
                fieldelement(DocumentNo; GenJnlLine."Document No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.Validate("Document No.");
                    end;
                }

                //Runs after a record is loaded.
                trigger OnAfterInitRecord()
                begin
                end;

                //Runs after a record has been loaded and before it is inserted into a database table.
                trigger OnBeforeInsertRecord()
                begin
                end;

                //Runs after a record has been inserted into a database table.
                trigger OnAfterInsertRecord()
                begin
                end;
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
                        ToolTip = 'Specifies Posting Date for Import File';
                    }
                    field(FileName; FileName)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Name';
                        ToolTip = 'Specifies path and name for import';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if this.PostingDateReq = 0D then
                this.PostingDateReq := WorkDate();
        end;

        var
            PostingDateReq: Date;
    }
}