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
        // Query related Sponsors grouped by Event ID
        Map<Id, Decimal> eventToGrossRevenue = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT CAMPX__Event__c eventId, SUM(CAMPX__ContributionAmount__c) totalRevenue
            FROM CAMPX__Sponsor__c
            WHERE CAMPX__Event__c IN :eventIds AND CAMPX__Status__c = 'Accepted'
            GROUP BY CAMPX__Event__c
        ]) {
            eventToGrossRevenue.put((Id) ar.get('eventId'), (Decimal) ar.get('totalRevenue'));
        }

        // Prepare Event updates
        List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
        for (Id eventId : eventToGrossRevenue.keySet()) {
            eventsToUpdate.add(new CAMPX__Event__c(
                Id = eventId,
                CAMPX__GrossRevenue__c = eventToGrossRevenue.get(eventId)
            ));
        }

        // Perform the update
        if (!eventsToUpdate.isEmpty()) {
            update eventsToUpdate;
        }
    }

}