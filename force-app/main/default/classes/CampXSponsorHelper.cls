public class CampXSponsorHelper {
    public static void updateEventRevenue(List<CAMPX__Event__c> events) {
        for(CAMPX__Event__c event : events){
            Map<Id, Decimal> eventToGrossRevenue = new Map<Id, Decimal>();
            for (AggregateResult ar : [
            SELECT Id, SUM(CAMPX__ContributionAmount__c) totalRevenue
            FROM CAMPX__Sponsor__c
            WHERE CAMPX__Event__c IN :event.Id AND CAMPX__Status__c = 'Accepted'
            GROUP BY Id
        ]) {
            eventToGrossRevenue.put((Id) ar.get('Id'), (Decimal) ar.get('totalRevenue'));
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
}