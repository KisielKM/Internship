public with sharing class AttendeesTableController {
    
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getAttendees(Id recordId){
        Set<Id> attds = new Set<Id>();
        
        for (Event_Attendee__c ea : [SELECT Attendee__r.Id FROM Event_Attendee__c WHERE Event__r.Id = :recordId]) {
            attds.add(ea.Attendee__r.Id);
            
        }
        
        System.debug(attds);
        return [SELECT Name, Email__c, Phone__c, Location__r.Name FROM Attendee__c WHERE Id IN :attds];
    }
}