//This class contain all the functions dedicated to handle the data of the object OrdersItems
public with sharing class VerifingOrdersItems {

    //This function count the number of order item lines saved in the DB with the order Id in parameter
    public static Integer countOrderItemsLines(Id orderId) {
        AggregateResult[] groupedResults  =[select count(orderid) from OrderItem where orderid =:orderId and isDeleted = false group by id];
        return groupedResults.size();
    }
}
