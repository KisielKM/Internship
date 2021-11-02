trigger EmailConfirmationForEventAttendees on Event_Attendee__c (after insert) {
 
  if(Trigger.isAfter && Trigger.isInsert){
    EmailConfirmationSender ecs = new EmailConfirmationSender();
    ecs.sendEmailToAttendee(Trigger.new);
    System.debug(Trigger.new);
  }
   
}