# Summary
This extension consists of 1 codeunit, 1 page, 2 page extensions, 1 table extension and three xmlports. It is used to demonstrate how to import bank records to payment journal lines and how to export payment journal lines.

# Payment Journal page
This listpart page displays the Vendor Ledger Entries for a single Vendor. The OnRun trigger of the KNHVendorTransactionCount codeunit filters the Vendor Ledger Entry table for the selected Vendor.

# Payment Journal page extension 
This pageExtension extends the Payment Journal page by adding a listpart that shows the related Vendor Ledger Entries for the current payment journal batch. An action is also added to the ribbon to allow for testing of an import process that brings in payment information from an external file, and another action to test exporting payment information to a file.

The export payment journal lines action checks if there are any lines to export, and if the lines have already been exported. If the lines have already been exported, the user is prompted to confirm if they want to export the lines again.

# Vendor Page extension
This pageExtension extends the Vendor List page. It adds an action to run the KNHVendorTransactionCount codeunit.

# Vendor Transaction codeunit
This codeunit has an OnRun trigger that filters for a single Vendor.

# Payment Journal Export xmlport
XmlPort is used to export payment journal lines to a BACS file layout. It is launched from an action on the Payment Journal page, where the user can select the journal lines to be exported. The XMLPort will then loop through the selected lines and export the relevant information to a file.

The OnInitXmlPort trigger is used to set a default posting date if the user does not enter one on the request page. The OnPreXmlPort trigger is used to filter the general journal lines that will be exported based on the "Exported to Payment File" field, and to count the number of records that will be exported.

The preXMLPort trigger is also used to set the ExportNumber and PymtRecordCount variables, which are included in the export file as part of the BACS file layout requirements. The ExportNumber is a sequential number that can be used to identify the export file, and the PymtRecordCount is the total number of payment records included in the export.

# Test Export xmlport
XmlPort is used to export payment journal lines to a BACS file layout. It is launched from an action on the Payment Journal page, where the user can select the journal lines to be exported. The XMLPort will then loop through the selected lines and exports the relevant information to a file.

The exported file is a text file with a .txt extension. There is no delimiter. The first line of the file contains the column headers, and each subsequent line contains the data for each journal line. The file is saved to the C:\Temp folder with the name PymtJnlLinesExport.txt. The XMLPort uses UTF-8 encoding to ensure that special characters are properly handled in the export.

Export fields include Description, Amount, Bank Account Number and Bank Sort Code. The Description field is cleansed of special characters and truncated to 15 characters to meet the requirements of the BACS file layout. The Bank Account Number and Bank Sort Code are retrieved from the Vendor Bank Account table based on the account number and recipient bank account specified in the journal line. These fields are also cleansed of special characters and truncated to meet the BACS file layout requirements.

# Test Import
XmlPort is used to import records into a payment journal. It is launched from an action on the Payment Journal page, where the user can select an XML file to be imported. The XMLPort will then loop through the records in the file and import them into the general journal line table. The XML file must be in a specific format, with the root element containing attributes for the file name, file type and total number of records, and child elements for each general journal line to be imported. The XMLPort uses UTF-8 encoding to ensure that special characters are properly handled in the import.

The request page for the XMLPort includes a field for the user to specify the posting date for the imported journal lines, as well as a field to specify the file name and path of the XML file to be imported. If the user does not specify a posting date, the XMLPort will default to using the current work date. The XMLPort also includes validation logic in the OnAfterAssignField trigger for each field to ensure that the data being imported meets the necessary requirements for the general journal line table.