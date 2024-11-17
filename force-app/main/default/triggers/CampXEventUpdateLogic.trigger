trigger CampXEventUpdateLogic on CAMPX__Event__c (after update) {
    // List to hold records that need to be updated
    List<CampX__Event__c> eventsToUpdate = new List<CampX__Event__c>();

    for (CAMPX__Event__c event : Trigger.New) {
        if (Trigger.OldMap.get(event.Id).CAMPX__Status__c != event.CAMPX__Status__c) {
            CampX__Event__c updatedEvent = new CampX__Event__c(
            Id = event.Id,
            CAMPX__StatusChangeDate__c = System.now() // Example of setting a date field
        );
        eventsToUpdate.add(updatedEvent);
        }
    }

    // Perform the update DML operation if there are records to update
    if (!eventsToUpdate.isEmpty()) {
        update eventsToUpdate;
}
}