trigger CampXEventUpdateLogic on CAMPX__Event__c (after update) {
    // List to hold records that need to be updated
    List<CampX__Event__c> eventsToUpdate = new List<CampX__Event__c>();

    for (CAMPX__Event__c event : Trigger.New) {
        // Create a record only if there is a valid reason to update it
        CAMPX__Event__c updatedEvent = new CAMPX__Event__c();
        Boolean needsUpdate = false;

        // Check if CAMPX__Status__c has changed
        if (Trigger.OldMap.get(event.Id).CAMPX__Status__c != event.CAMPX__Status__c) {
            updatedEvent.Id = event.Id;
            updatedEvent.CAMPX__StatusChangeDate__c = System.now();
            needsUpdate = true;
        }

        // Logic to check if revenue or expense has changed and calculate net revenue
        if (
            (Trigger.OldMap.get(event.Id).CAMPX__GrossRevenue__c != event.CAMPX__GrossRevenue__c ||
             Trigger.OldMap.get(event.Id).CAMPX__TotalExpenses__c != event.CAMPX__TotalExpenses__c) &&
            event.CAMPX__GrossRevenue__c != null && event.CAMPX__TotalExpenses__c != null
        ) {
            updatedEvent.Id = event.Id; // Ensure the Id is set
            updatedEvent.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
            needsUpdate = true;
        } else if (event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null) {
            updatedEvent.Id = event.Id; // Ensure the Id is set
            updatedEvent.CAMPX__NetRevenue__c = null;
            needsUpdate = true;
        } else if (event.CAMPX__GrossRevenue__c == 0 || event.CAMPX__TotalExpenses__c == 0) {
            updatedEvent.Id = event.Id; // Ensure the Id is set
            updatedEvent.CAMPX__NetRevenue__c = 0;
            needsUpdate = true;
        }

        // Add the record to the list if it needs to be updated
        if (needsUpdate) {
            eventsToUpdate.add(updatedEvent);
        }
    }


    // Perform the update DML operation if there are records to update
    if (!eventsToUpdate.isEmpty()) {
        update eventsToUpdate;
    }
}