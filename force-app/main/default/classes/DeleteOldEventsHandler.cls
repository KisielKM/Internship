public class DeleteOldEventsHandler implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT End_Date_Time__c, Live__c FROM Event__c]);
    }
    public void execute(Database.BatchableContext bc, List<Event__c> scope){
        
        List<Event__c> eventsToDelete = new List<Event__c>();
        for (Event__c event : scope) {
           if (event.Live__c == true && event.End_Date_Time__c < System.NOW().addMonths(-2)) {
                
                eventsToDelete.add(event);
                
            }
            
            delete eventsToDelete;
        }
    }
    
    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {job.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Sharing Recalculation ' + job.Status);
        mail.setPlainTextBody
        ('The batch Apex job processed ' + job.TotalJobItems +
        ' batches with '+ job.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}