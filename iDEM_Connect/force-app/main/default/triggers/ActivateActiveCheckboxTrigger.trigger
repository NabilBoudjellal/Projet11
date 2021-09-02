/** this Trigger change the value of the field active__c to true when an order associated with the account is created
 */
trigger ActivateActiveCheckboxTrigger on Order (after insert) {
    Set<Id> accountsIds = new Set<Id>();
    for(Order o: Trigger.new){
        accountsIds.add(o.AccountId);
    }
    List<Account> acountListe = new List<Account>();
    for(Id ids:accountsIds){
        acountListe.addall(UpdateActiveField.activateCheckbox(ids));
    }
    update acountListe;
}