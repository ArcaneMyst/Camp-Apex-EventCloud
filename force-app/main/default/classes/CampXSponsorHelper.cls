public class CampXSponsorHelper {
    public static void updateEventRevenue(List<CAMPX__Event__c> events) {
        // Collect Event IDs
        Set<Id> eventIds = new Set<Id>();
        for (CAMPX__Event__c event : events) {
            eventIds.add(event.Id);
        }

        // Map to store Event IDs and their calculated Gross Revenue
        Map<Id, Decimal> eventToGrossRevenue = new Map<Id, Decimal>();

        // Query to calculate total contribution amount for each event
        for (AggregateResult ar : [
            SELECT CAMPX__Event__c, SUM(CAMPX__ContributionAmount__c) totalRevenue
            FROM CAMPX__Sponsor__c
            WHERE CAMPX__Event__c IN :eventIds AND CAMPX__Status__c = 'Accepted'
            GROUP BY CAMPX__Event__c
        ]) {
            eventToGrossRevenue.put((Id) ar.get('CAMPX__Event__c'), (Decimal) ar.get('totalRevenue'));
        }

        // Prepare Event updates       
        List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
        for (Id eventId : eventIds) {
            Decimal calculatedRevenue = eventToGrossRevenue.containsKey(eventId) 
                ? eventToGrossRevenue.get(eventId) 
                : 0; // Default to 0 if no "Accepted" sponsors found
            eventsToUpdate.add(new CAMPX__Event__c(
                Id = eventId,
                CAMPX__GrossRevenue__c = calculatedRevenue
        ));
    }

        // Perform the update
        if (!eventsToUpdate.isEmpty()) {
            update eventsToUpdate;
        }
    }
    
}