/** This test class check the correct behavior of the Trigger ActivateActiveCheckboxTrigger
*/
@isTest
public with sharing class ActivateActiveCheckboxTriggerTest {

    //this test verify that the trigger works correctly when draf orders are insered
    @isTest
    static void draftOrderTest() {
        //Test data setup
        Integer accountNumber = 10;
        TestDataFactory.genAccounts_WithAvtivatedContract(accountNumber);

        //Perform test
        Test.startTest();
            TestDataFactory.draftOrderGen();
        Test.stopTest();

        // Verify 
        // Verify that all the accounts has true in the field active__c
        AggregateResult[] accountActiveValue = [select active__c, count(id) from account group by active__c];

        System.AssertEquals(accountActiveValue.size(),1);
        System.AssertEquals(accountActiveValue[0].get('active__c'),true);
        System.AssertEquals(accountActiveValue[0].get('expr0'),accountNumber);


    }

    //this test verify that the trigger works correctly when activated orders are insered
    @isTest
    static void activatedOrderTest(){
        //Test data setup
        Integer accountNumber = 10;
        TestDataFactory.genAccounts_WithAvtivatedContract(accountNumber);

        //Perform test
        Test.startTest();
            TestDataFactory.insertActivatedOrders(100, 10);
        Test.stopTest();

        // Verify 
        // Verify that all the accounts has true in the field active__c
        AggregateResult[] accountActiveValue = [select active__c, count(id) from account group by active__c];

        System.AssertEquals(accountActiveValue.size(),1);
        System.AssertEquals(accountActiveValue[0].get('active__c'),true);
        System.AssertEquals(accountActiveValue[0].get('expr0'),accountNumber);
        
    }
}
