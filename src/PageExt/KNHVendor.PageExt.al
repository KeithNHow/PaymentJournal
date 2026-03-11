/// <summary>
/// PageExtension extends the Vendor List page. It adds an action to run the KNHVendorTransactionCount codeunit.
/// </summary>
pageextension 51101 KNHVendor extends "Vendor Card"
{
    actions
    {
        addafter(ApprovalEntries)
        {
            action("KNH RunVendorCU")
            {
                Caption = 'Run Vendor Test';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Run Vendor Transaction Count';
                ApplicationArea = All;
                Image = Vendor;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::KNHVendorTransaction, Rec)
                end;
            }
        }
    }
}