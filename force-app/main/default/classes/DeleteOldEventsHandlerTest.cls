@isTest
public class DeleteOldEventsHandlerTest {
    @testSetup
    static void setup() {
        List<Event__c> events = new List<Event__c>();
        Event_Organizer__c  eo = new Event_Organizer__c(Name='ThomasTestEventOrganizer', Email__c = 'thomastest@gooback.com', Phone__c = '111222333');
        insert eo;
        // insert 10 accounts
        for (Integer i=0;i<10;i++) {
            events.add(new Event__c(
                                    Start_Date_Time__c = DateTime.newInstance(2021, 8, 20, 8, 0, 0),
                                    End_Date_Time__c = DateTime.newInstance(2021, 8, 21, 12, 0, 0), 
                                    Live__c = true, 
                                    Event_Organizer__c = eo.Id,
                                    Max_Seats__c = 20,
                                    Name__c = 'Ungabunga'+i));
        
            events.add(new Event__c(
                                    Start_Date_Time__c = DateTime.newInstance(2021, 8, 20, 8, 0, 0),
                                    End_Date_Time__c = DateTime.newInstance(2021, 8, 21, 12, 0, 0), 
                                    Live__c = false, 
                                    Event_Organizer__c = eo.Id,
                                    Max_Seats__c = 20,
                                    Name__c = 'Chambawamba'+i));
        
            events.add(new Event__c(
                                    Start_Date_Time__c = DateTime.newInstance(2021, 11, 20, 8, 0, 0),
                                    End_Date_Time__c = DateTime.newInstance(2021, 11, 21, 12, 0, 0), 
                                    Live__c = true, 
                                    Event_Organizer__c = eo.Id,
                                    Max_Seats__c = 20,
                                    Name__c = 'Wilkowyje'+i));
        }
        insert events;
    }
        // find the account just inserted. add contact for each
    //     for (Account account : [select id from account]) {
    //         contacts.add(new Contact(firstname='first',
    //             lastname='last', accountId=account.id));
    //     }
    //     insert contacts;
    // }
   static testMethod void test() {
        Test.startTest();
        DeleteOldEventsHandler det = new DeleteOldEventsHandler();
        Id batchId = Database.executeBatch(det);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(20, [SELECT count() FROM Event__c WHERE Name__c LIKE 'Chambawamba%' OR Name__c LIKE 'Ungabunga%' OR Name__c LIKE 'Wilkowyje%']);
        System.assertNotEquals(30, [SELECT count() FROM Event__c WHERE Name__c LIKE 'Chambawamba%' OR Name__c LIKE 'Ungabunga%' OR Name__c LIKE 'Wilkowyje%']);
    }
}