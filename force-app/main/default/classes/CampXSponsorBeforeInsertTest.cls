@isTest
public class CampXSponsorBeforeInsertTest {
    @isTest
    static void testStatusDefault(){
        // insert test sponsor
        CAMPX__Sponsor__c sponsor = new CAMPX__Sponsor__c(Name = 'Test Sponsor');
        insert sponsor;

        // Query the inserted record to check the status
        CAMPX__Sponsor__c insertedSponsor = [SELECT CAMPX__Status__c FROM CAMPX__Sponsor__c WHERE Id = :sponsor.Id];

        // Assert that the status is set to "Pending"
        System.assertEquals('Pending', insertedSponsor.CAMPX__Status__c);

    }

}