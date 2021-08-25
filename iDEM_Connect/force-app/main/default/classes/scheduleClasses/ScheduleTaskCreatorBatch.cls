/**
 * This schedule class allow to plan the execution of the batch TaskCreatorBatch
 */
public with sharing class ScheduleTaskCreatorBatch implements Schedulable {
    public void execute(SchedulableContext ctx) {
        TaskCreatorBatch taskCreatorBatch = new TaskCreatorBatch();
        Id batchId = Database.executeBatch(taskCreatorBatch);
    }
}