trigger AddressVerificationTrigger on Location__c (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        AddressVerificationClass avc = new AddressVerificationClass();
        avc.verifyAddress(Trigger.new);
        System.debug(Trigger.new);
      }
}