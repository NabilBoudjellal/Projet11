//This class contain all the functions dedicated to handle the data of the object Task
public with sharing class TaskOperation {

    /**this function create a task related to the account id in parameter
     * with the specifications :
     * subject = 'Call'
     * status = 'Nouvelle'
     * Priority ='Normal'
     * RecurrenceRegeneratedType = 'RecurrenceRegenerateAfterDueDate'
     * RecurrenceInterval = 5 
     */ 

    public static void createTask(Id accountId) {

        Task task = new Task( subject = 'Call',
                              status = 'Nouvelle',
                              Priority ='Normal',
                              WhatId = accountId,
                              ActivityDate = system.today(),
                              RecurrenceRegeneratedType = 'RecurrenceRegenerateAfterDueDate',
                              RecurrenceInterval = 5 );

        insert task;

    }
            /** Pour la mise en place du rappel automatique la tache doit avoir une activitydate
         * elle doit aussi avoir un tyoe de reccurance dans notre cas RecurrenceRegenerateAfterDueDate
         * et pour finir le RecurrenceInterval qui est le nombre de jour avant le rappel
         */
}
