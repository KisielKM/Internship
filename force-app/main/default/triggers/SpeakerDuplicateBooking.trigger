trigger SpeakerDuplicateBooking on EventSpeakers__c (before insert, before update) {
    
    List<EventSpeakers__c> eventSpeakersList = [SELECT Id,Event__r.Start_Date_Time__c,Event__r.End_Date_Time__c, Event__r.Id, Speaker__r.Id FROM EventSpeakers__c WHERE Id IN :trigger.new];
    

    Set<Id> eventIds = new Set<Id>();
    Set<Id> speakerIds = new Set<Id>();
    // Map<Id,Event__c> eventsMap = new Map<Id,Event__c>();


    for(EventSpeakers__c eventSpkr : eventSpeakersList)
	{
        eventIds.add(eventSpkr.Event__r.Id);
        speakerIds.add(eventSpkr.Speaker__r.Id);
    }

    // for(EventSpeakers__c eventSpkr : eventSpeakersList)
	// {
    //     eventsMap.put(eventSpkr.Speaker__r.Id, eventSpeakersList.Event__c);
    // }    
    
    List<Event__c> events = [SELECT Start_Date_Time__c, End_Date_Time__c FROM Event__c WHERE Event_Speakers__r.Speaker__r.Id IN :speakerIds];


    
    // for(Id speakerId : map.keySet()){ {
    //     Object item = map.get(Object);
        
    // }






    
    
    
    
    
    
    
    // Datetime eventStartingTime =  [SELECT Id, Event__r.Start_Date_Time__c FROM EventSpeakers__c WHERE Id IN :trigger.new].Event__r.Start_Date_Time__c;
    // Datetime eventEndingTime =    [SELECT Id, Event__r.End_Date_Time__c FROM EventSpeakers__c WHERE Id IN :trigger.new].Event__r.End_Date_Time__c;
    
    // List<Datetime> date2 = [SELECT Events (SELECT Start_time, End_time FROM Event) FROM Speakers__c WHERE EventTime.system.Date() == system.Date()]        
    // wyciągnięcie eventów z taką samą datą

    
}