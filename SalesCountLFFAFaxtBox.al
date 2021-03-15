
table 50110 "Anzahl LFFA"
{
    Caption = 'Anzahl LF / FA';

    fields
    {
        field(1; "Primary Key"; code[10])
        {
        }
        field(2; "No."; code[20])
        {
        }
        field(3; "Anzahl LF"; Integer)
        {
            CalcFormula = Count ("Sales Shipment Header"
                            where("Order No." = field("No.")));
            FieldClass = FlowField;
        }
        field(4; "Anzahl FA"; Integer)
        {
            CalcFormula = Count ("Sales Invoice Header"
                          where("Order No." = field("No.")));
            FieldClass = FlowField;
        }

    }

}

page 50120 SalesLFFAFactBox
{
    caption = 'Anzahl LF/FA';
    PageType = CardPart;
    SourceTable = "Anzahl LFFA";

    layout
    {
        area(Content)
        {

            cuegroup("Anzahl LF/FA")
            {
                // Caption = 'Anzahl LF FA';
                ShowCaption = false;

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the number of Order. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    //Visible = ShowCustomerNo;

                    //trigger OnDrillDown()
                    //begin
                    //ShowDetails;
                    //end;
                }
                field("Anzahl LF"; "Anzahl LF")
                {
                    caption = 'Lieferungen';
                    ApplicationArea = All;
                    DrillDownPageID = "Posted Sales Shipment";
                }
                field("Anzahl FA"; "Anzahl FA")
                {

                    caption = 'Rechnungen';
                    ApplicationArea = All;
                    DrillDownPageID = "Posted Sales Invoices";
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        // Implementing the Singleton Design Pattern
        if not Get() then begin
            Init();
            Insert();

        end;
    end;

}

pageextension 50130 SalesOrderxExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addfirst(factboxes)
        {

            part("SalesLFFAFactBox"; "SalesLFFAFactBox")
            {
                ApplicationArea = All;
                //provider = SalesLines;
                //SubPageLink = "Order No." = FIELD("No.");

            }
        }
    }

    actions
    {

        // Add changes to page actions here
    }


}