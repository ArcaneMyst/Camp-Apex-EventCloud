trigger SponsorUpdateLogic on CAMPX__Sponsor__c (after update) {
    // Set to store unique Event IDs for records that need updates
    Set<Id> eventIds = new Set<Id>();

    // Identify Event IDs for Sponsors updated to "Accepted" status
    for (CAMPX__Sponsor__c sponsor : Trigger.new) {
        CAMPX__Sponsor__c oldSponsor = Trigger.oldMap.get(sponsor.Id);
        if (sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Status__c != oldSponsor.CAMPX__Status__c) {
            eventIds.add(sponsor.CAMPX__Event__c);
        }
    }
      
    if (!eventIds.isEmpty()) {
        //convert the set to a list of event records
        List<CAMPX__Event__c> eventRecords = [SELECT Id, CAMPX__GrossRevenue__c 
                                              FROM CAMPX__Event__c
                                              WHERE Id IN :eventIds];

        // Call the function to update the revenue for all those events
        CampXSponsorHelper.updateEventRevenue(eventRecords);
    }

}