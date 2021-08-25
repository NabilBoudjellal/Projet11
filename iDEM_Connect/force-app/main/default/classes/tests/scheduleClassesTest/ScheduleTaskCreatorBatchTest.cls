/** This test class check the correct behavior of the Scheduled class ScheduleTaskCreatorBatch
*/
@isTest
public with sharing class ScheduleTaskCreatorBatchTest {

    public static String CRON_EXP = '00 00 05 ? * 2#1';
    public static Integer accountNumber= 3;

    //This test insure that when executing the scheduled class a job is created with the right data 
    static testmethod void testScheduledJob() {
        //Test data setup
            TestDataFactory.genAccounts_WithAvtivatedContract(accountNumber);
        //Perform Test
        Test.startTest();
            ScheduleTaskCreatorBatch scheduleTaskCreatorBatch = new ScheduleTaskCreatorBatch();
            String jobID = System.schedule('scheduleBatchTest', CRON_EXP, scheduleTaskCreatorBatch);
        Test.stopTest();
        //verify 
        AggregateResult cronTriggerCount = [select count(id) from CronTrigger];
        List<CronTrigger> cronTriggerList = [select NextFireTime, PreviousFireTime, EndTime, CronExpression, TimesTriggered from CronTrigger];
        System.AssertEquals(1,cronTriggerCount.get('expr0'));
        System.AssertEquals(CRON_EXP,cronTriggerList[0].CronExpression);
        System.AssertEquals(0,cronTriggerList[0].TimesTriggered);

    }
}