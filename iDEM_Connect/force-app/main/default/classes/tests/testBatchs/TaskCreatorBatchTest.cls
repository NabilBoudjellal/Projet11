/** This test class check the correct behavior of the Batch TaskCreatorBatch
*/
@isTest
public with sharing class TaskCreatorBatchTest {
    static Integer accountNumber= 3;

    @testSetup
    static void setup() {
        //Test data setup
        TestDataFactory.genAccounts_WithAvtivatedContract(accountNumber);
    }


    //this test verify that the Batch create tasks for all accounts who do not have orders and tasks related

    @isTest
    static void case_1_noOrder_noTask() {
        //Perform Test
        Test.startTest();
            TaskCreatorBatch taskCreatorBatch = new TaskCreatorBatch();
            Id batchId = Database.executeBatch(taskCreatorBatch);
        Test.stopTest();
        // Verify that tasks has been created with the right informations
        AggregateResult[] aggregateResult = [select count(id), status, Priority, RecurrenceRegeneratedType, RecurrenceInterval
        from task group by status, Priority, RecurrenceRegeneratedType, RecurrenceInterval];

        System.AssertEquals(1,aggregateResult.size());
        System.AssertEquals('Nouvelle',aggregateResult[0].get('status'));
        System.AssertEquals('Normal',aggregateResult[0].get('Priority'));
        System.AssertEquals('RecurrenceRegenerateAfterDueDate',aggregateResult[0].get('RecurrenceRegeneratedType'));
        System.AssertEquals(5,aggregateResult[0].get('RecurrenceInterval'));
        System.AssertEquals(accountNumber,aggregateResult[0].get('expr0'));
    }

    //this test verify that the Batch don't create tasks when accounts have orders but don't have tasks related
    @isTest
    static void case_2_withOrder_noTask(){
        //Perform Test
        Test.startTest();
            TestDataFactory.insertActivatedOrders(10,10);

            TaskCreatorBatch taskCreatorBatch = new TaskCreatorBatch();
            Id batchId = Database.executeBatch(taskCreatorBatch);
        Test.stopTest();
        // Verify that no task has been created

        AggregateResult aggregateResult = [select count(id) from task];
        System.AssertEquals(0,aggregateResult.get('expr0'));

    }

    //this test verify that the Batch don't create tasks when accounts don't have orders but have tasks related
    @isTest
    static void case_3_noOrder_task(){
        //creating tasks to all the accounts before executing the batch
        TestDataFactory.genTasks();
        AggregateResult aggregateResult = [select count(id) from task];
        Integer taskCount = (Integer)aggregateResult.get('expr0');
        //Perform Test
        Test.startTest();
            TaskCreatorBatch taskCreatorBatch = new TaskCreatorBatch();
            Id batchId = Database.executeBatch(taskCreatorBatch);
        Test.stopTest();

        // Verify that no new task has been created after executing the batch
        AggregateResult aggregateResult2 = [select count(id) from task];
        System.AssertEquals(taskCount,aggregateResult2.get('expr0'));
    }
}
