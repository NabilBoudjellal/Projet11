/** This test class check the correct behavior of the Trigger CautionMessageTrigger
*/
@isTest
public with sharing class CautionMessageTriggerTest {
    //this test checks that users are blocked when trying to activate orders with out related orderItems
    @isTest
    static void CautionMessageTriggerTest() {

        //Test data setup
        TestDataFactory.account_WithDraftOrders(10);

        //Perform test
        Test.startTest();
            List<Order> orders = [select id, status from order];
            for(Order o:orders){
                o.status = 'Activated';
            }
            Boolean updateDone = true;
            String message = 'no message';
            try {
                update orders;
            } catch(Exception e){
                System.debug(e.getMessage());
                updateDone =false;
            }
        Test.stopTest();

        //verify that the update has been blocked
        System.AssertEquals(updateDone,false);
    }
}
