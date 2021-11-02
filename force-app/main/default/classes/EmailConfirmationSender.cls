public with sharing class EmailConfirmationSender {

    public EmailConfirmationSender() {
        
    }
    
    public void sendEmailToAttendee(List<Event_Attendee__c> evAttList) {

        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();    
            
            
                
        Messaging.SingleEmailMessage mail = 
        new Messaging.SingleEmailMessage();
                
        Set<Id> attendeesIdsSet = new Set<Id>();

        Set<Id> eventIdsSet = new Set<Id>();
                
        //List<Event_Attendee__c> attendeeList = new List<Event_Attendee__c>([Select Id, Attendee__c, Event__c From Event_Attendee__c WHERE  Id IN : attendeesIdsSet]);               
              
        for(Event_Attendee__c ea : evAttList){
                
            attendeesIdsSet.add(ea.Attendee__c);
                
            eventIdsSet.add(ea.Event__c);                                    
                
        }
                
                       
                
        Map<Id,Attendee__c> attendeeMap = new Map<Id,Attendee__c>([Select Id, Name, Email__c From Attendee__c WHERE  Id IN : attendeesIdsSet]);
                
        // for(Id attKey : attendeeMap.keySet()){
        //     Attendee__c item = attendeeMap.get(attKey);
        // System.debug(item);  
        // System.debug(item.Name);
        // }               
                
        Map<Id, Event__c > eventMap = new Map<Id, Event__c > ( [Select Id, Name__c, Start_Date_Time__c, Event_Organizer__c , Event_Organizer__r.Name,
                
                                                                                Location__c , Location__r.Name, Location__r.City__c,
                
                                                                                Location__r.State__c, Location__r.Country__c,
                
                                                                                Location__r.Postal_Code__c, Location__r.Street__c
                
                                                                                FROM Event__c  WHERE ID IN: eventIdsSet]
                
        );
    
        // for(Id evKey : eventMap.keySet()){ 
        // Event__c item2 = eventMap.get(evKey);
        // System.debug(item2);
        // System.debug(item2.Location__r.Name);
        // }
         
        // Attendee__c att = attendeeMap.get(ea.Attendee__c);
        // String attendeeName = att.Name;
        // String emailAddress = att.Email__c;

        // Event__c evt = eventMap.get(ea.Event__c);
        // String eventName = evt.Name__c;
        // String eventLocation = evt.Location__r.Name;
        // String eventOrganizerName = evt.Event_Organizer__r.Name;
        // Datetime eventStartingTime = evt.Start_Date_Time__c;

        List<String> sendTo = new List<String>();
       
        for(Event_Attendee__c ea : evAttList){
           
            Event__c eve = eventMap.get(ea.Event__c); 
               
           Attendee__c att = attendeeMap.get(ea.Attendee__c);
          
           
           sendTo.add(att.Email__c);
            mail.setToAddresses(sendTo);
              
            mail.setSenderDisplayName('Cloufit Gym');
              
            mail.setSubject('Pass for the ' + eve.Name__c);
            //String body = 'Dear ' + att.Name + ',\nThank you for registering for ' + eve.Name__c +' which will be Organized on ' + eve.Start_Date_Time__c +' & will be held in ' + eve.Location__r.Name +'.\nWe are excited to have you, see you in the event.\nFind the Google Map Location for the Event'+'\nThanks,\n'+ eve.Event_Organizer__r.Name;
            //Need to provide link to google maps
            //System.debug(body);  
            mail.setHtmlBody('Dear ' + att.Name + ',<br>Thank you for registering for ' + eve.Name__c +' which will be Organized on ' + eve.Start_Date_Time__c +' & will be held in ' + eve.Location__r.Name +'.<br>We are excited to have you, see you in the event.<br>Find the Google Map Location for the Event '+'<a href=http://www.google.com/maps/search/?api=1&query=' + eve.Location__r.Country__c + '%20'+ eve.Location__r.City__c + '%20' + eve.Location__r.Street__c.replace(' ','%20') +'>Here</a>'+'<br>Thanks,<br>'+ eve.Event_Organizer__r.Name);
                
            mails.add(mail);
            
            try {
                Messaging.sendEmail(mails);
                System.debug('Test wysylania maila'); 
            } 
            catch (LogException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }    
                 
                                                
                
        }

       
    }
}