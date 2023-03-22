using com.training as Training from '../db/training';

service ManageOrders {

    type cancelOrderReturn {
        status  : String enum {
            Succeeded;
            Failed;
        };
        message : String;
    };

    entity Orders as projection on Training.Orders actions {
        function getClientTaxRate(clientEmail : String(65)) returns Decimal(4, 2);
        action   cancelOrder(clientEmail : String(65))      returns cancelOrderReturn;
    }

// function getClientTaxRate(clientEmail : String(65)) returns Decimal(4, 2);
// action   cancelOrder(clientEmail : String(65))      returns cancelOrderReturn;
}
