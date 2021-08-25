//This class contain all the functions dedicated to handle the data Related to the field active__c
public with sharing class UpdateActiveField {

        //this function update the value of active__c to true for the id in parameter
        public static void activateCheckbox(Id accountId) {
            List<Account> accountsActive=[select id, active__c from Account where id =:accountId];
            for(Account a:accountsActive){
                a.active__c = true;
            }
            update accountsActive;
        }

        //this function update the value of active__c to false for the id in parameter
        public static void disableActive(Id accountId){
            Account account = [select active__c from account where id=:accountId];
            account.active__c = false;
            update account;
        }
        
        //This fuction return the of orders related to the account id in parameter 
        public static Integer checkNumbOrders(Id accountId) {
            AggregateResult[] groupedResults  =[select count(id) from order where accountid=:accountId];
            Integer count = (Integer)groupedResults[0].get('expr0');
            return count;
        }
}
