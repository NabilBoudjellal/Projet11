/** This test class check the correct behavior of the Trigger DisableActive
*/
@isTest
public with sharing class DisableActiveTest {

    //this test verify that the trigger works correctly and change the value of active__c when all the orders related to an account are deleted
    @isTest
    static void desableActiveFieldTest() {
        //Test data setup
        Integer accountNumber = 10;
        TestDataFactory.account_WithDraftOrders(accountNumber);

        //Perform test
        Test.startTest();
            List<Order> orderList = [select id from order];
            delete orderList;
        Test.stopTest();

        // Verify that all the accounts has false in the field active__c
        AggregateResult[] accountActiveValue = [select active__c, count(id) from account group by active__c];

        System.AssertEquals(accountActiveValue.size(),1);
        System.AssertEquals(accountActiveValue[0].get('active__c'),false);
        System.AssertEquals(accountActiveValue[0].get('expr0'),accountNumber);        
        

    }
}
