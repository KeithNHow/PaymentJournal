/// <summary>
/// PageExtension KNH Vendor (ID 50002) extends Record Vendor List.
/// </summary>
pageextension 50201 "KNH Vendor" extends "Vendor Card"
{
    actions
    {
        addafter(ApprovalEntries)
        {
            action(RunVendorCU)
            {
                Caption = 'Run Vendor Test';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Run Vendor Transaction Count';
                ApplicationArea = All;

                trigger OnAction()
                var
                    VendTransCount: codeunit "KNH Vendor Transaction Count";
                begin
                    //VendTransCount.Run(Rec);
                    Codeunit.Run(Codeunit::"KNH Vendor Transaction Count", Rec)
                end;
            }
        }
    }
}