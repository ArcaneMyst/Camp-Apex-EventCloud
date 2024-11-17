trigger UpdateStatusChangeDate on CAMPX__Event__c (after update) {
    for (CAMPX__Event__c event : Trigger.New) {
        if (Trigger.OldMap.get(event.Id).CAMPX__Status__c != event.CAMPX__Status__c) {
            event.CAMPX__StatusChangeDate__c = System.now();
        }
    }
}