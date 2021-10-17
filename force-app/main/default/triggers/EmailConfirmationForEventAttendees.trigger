trigger EmailConfirmationForEventAttendees on Event_Attendee__c (after insert) {
    
    List<Messaging.SingleEmailMessage> mails = 
    new List<Messaging.SingleEmailMessage>(); 
    
        for (Event_Attendee__c attendee : Trigger.new) {    
            
              //if (attendee.Email__c != null && attendee.Name != null) {
                
                Messaging.SingleEmailMessage mail = 
                new Messaging.SingleEmailMessage();
                
                String emailAddress =         [SELECT Id, Attendee__r.Email__c FROM Event_Attendee__c WHERE Id IN :trigger.new LIMIT 1].Attendee__r.Email__c;
                String eventAttendeeName =    [SELECT Id, Attendee__r.Name FROM Event_Attendee__c WHERE Id IN :trigger.new LIMIT 1].Attendee__r.Name;
                Datetime eventStartingTime =  [SELECT Id, Event__r.Start_Date_Time__c FROM Event_Attendee__c WHERE Id IN :trigger.new].Event__r.Start_Date_Time__c;
                String eventName =            [SELECT Id, Event__r.Name__c FROM Event_Attendee__c WHERE Id IN :trigger.new].Event__r.Name__c ;
                String eventLocation =        [SELECT Id, Event__r.Location__r.Name FROM Event_Attendee__c WHERE Id IN :trigger.new].Event__r.Location__r.Name;
                String eventOrganizerName =   [SELECT Id, Event__r.Event_organizer__r.Name FROM Event_Attendee__c WHERE Id IN :trigger.new].Event__r.Event_organizer__r.Name;
    
         
                
                List<String> sendTo = new List<String>();
                sendTo.add(emailAddress);
                mail.setToAddresses(sendTo);
              
            
                mail.setSenderDisplayName('Cloufit Gym');
              
               
                mail.setSubject('Pass for the ' + eventName);
                String body = 'Dear ' + eventAttendeeName + ',\nThank you for registering for ' + eventName +' which will be Organized on ' + eventStartingTime +' & will be held in ' + eventLocation +'.\nWe are excited to have you, see you in the event.\nFind the Google Map Location for the Event Here.\nThanks,\n'+eventOrganizerName;
                //Need to provide link to google maps
              
                mail.setPlainTextBody(body);
              
            
                mails.add(mail);
              
          
            
            Messaging.sendEmail(mails);
          }
        }