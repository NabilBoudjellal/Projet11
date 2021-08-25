/** This Batch iterates the object account and count the tasks and orders associate
 * and if no order and no task are associated a task is created
 */
public with sharing class TaskCreatorBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('select id from account');
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Order> orderList = [select accountid from order];
        List<Task> taskList = [select WhatId from task];
		for (Account account : scope) {

            Integer countOrder = 0;
            Integer countTask = 0;

            for(Task t:taskList){
                if(account.id == t.WhatId){
                    countTask = countTask + 1;
                }
            }

            for(Order o:orderList){
                if(account.id == o.AccountId){
                    countOrder= countOrder + 1;
                }
            }
            if(countOrder == 0 && countTask == 0){
                TaskOperation.createTask(account.id);
            }
        }
    }
    public void finish(Database.BatchableContext bc){
    }
}
