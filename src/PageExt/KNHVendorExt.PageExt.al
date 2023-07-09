/// <summary>
/// PageExtension KNH Vendor (ID 51101) extends Record Vendor List.
/// </summary>
pageextension 51101 "KNHVendorExt" extends "Vendor Card"
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
                image = Vendor;

                trigger OnAction()
                begin
                    //VendTransCount.Run(Rec);
                    Codeunit.Run(Codeunit::"KNHVendorTransactionCount", Rec)
                end;
            }
        }
    }
}