/** this Trigger change the value of the field active__c to true when an order associated with the account is created
 */
trigger ActivateActiveCheckboxTrigger on Order (after insert) {
    Set<Id> accountsIds = new Set<Id>();
    for(Order o: Trigger.new){
        accountsIds.add(o.AccountId);
    }
    for(Id ids:accountsIds){
        UpdateActiveField.activateCheckbox(ids);
    }
}