/** ce trigger permet de décocher active__c dans account si toutes les commandes reliées au compte sont supprimées
 * this Trigger change the value of the field active__c to false when all the orders associated with an account are deleted
 */

trigger DisableActive on order (after delete) {
    Set<Id> accountsIds = new Set<Id>();

    for(Order o:Trigger.old){
        accountsIds.add(o.AccountId);
    }

    List<Order> listOrders = [select AccountId, id, shippingcity from order where accountid in:accountsIds];

    List<Account> accountList = new List<Account>();

    for(Id ide:accountsIds){
        if(UpdateActiveField.checkNumbOrders(ide) == 0){
            accountList.add(UpdateActiveField.disableActive(ide));
        }
    }
    update accountList;
}