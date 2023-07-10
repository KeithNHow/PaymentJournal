/// <summary>
/// New XmlPort Test Import.
/// </summary>
xmlport 51101 "KNHTestImport"
{
    Caption = 'General Journal Line Import';
    Encoding = UTF8;
    FormatEvaluate = xml;
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
                        GenJnlLine.Validate("Line No.", GenjnlLine."Line No." + 10000);
                    end;
                }
                fieldelement(AccountType; GenJnlLine."Account Type")
                {
                    trigger OnAfterAssignField()
                    begin
                        GenJnlLine.validate("Account Type", GenJnlLine."Account Type");
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
            area(content)
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
            if PostingDateReq = 0D then
                PostingDateReq := WorkDate();
        end;

        var
            PostingDateReq: Date;
    }

    //Runs after a record is loaded.
    trigger OnInitXmlPort()
    begin
    end;

    //Runs after the table views and filters are set and before the XMLport is run.
    trigger OnPreXmlPort()
    begin
    end;

    //Runs after the XMLport is run.
    trigger OnPostXmlPort()
    begin
    end;
}