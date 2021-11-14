public with sharing class speakersTableController {
    
    @AuraEnabled(cacheable=true)
    public static List<Speaker__c> getSpeakers(Id recordId){
        Set<Id> spkrs = new Set<Id>();
        
        for (EventSpeakers__c es : [SELECT Speaker__r.Id FROM EventSpeakers__c WHERE Event__r.Id = :recordId]) {
            spkrs.add(es.Speaker__r.Id);
            
        }
        
        System.debug(spkrs);
        return [SELECT Name, Email__c, Phone__c, Company__c FROM Speaker__c WHERE Id IN :spkrs];
    }
}