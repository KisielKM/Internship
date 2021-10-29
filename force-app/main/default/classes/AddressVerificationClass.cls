public class AddressVerificationClass {
    public void verifyAddress(List<Location__c> locationList){
        
       List<Location__c> location = ( [SELECT Id, City__c, State__c, Country__c, Postal_Code__c, Street__c FROM Location__c WHERE Id IN : locationList]); 
       
       for(Location__c loc : location){
        
            Http Http = new Http();
            HttpRequest Request = new HttpRequest();
            Request.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id=7d19d32f-625a-1a08-9625-fef10867d77a&auth-token=rxpzsXuNFOsdHALvM7vD&candidates=10&match=invalid&street='+loc.Street__c.replace(' ','%20')+'&street2=&city='+loc.City__c+'&state='+loc.State__c+'&zipcode='+loc.Postal_Code__c);
            // w razie problemu encoding adresu
            Request.setMethod('GET');
            HttpResponse Response = Http.send(Request);
            
            if(Response.getStatusCode()!=200){
                system.debug(Response.getBody());
            }
            
            if(Response.getStatusCode()==200){
                
                try{
                    loc.Verified__c = true;
                    update loc;
                }
                catch (Exception ex){
                    system.debug('Error'+ex.getMessage());
                }
            }      
            
        }
    }
}
