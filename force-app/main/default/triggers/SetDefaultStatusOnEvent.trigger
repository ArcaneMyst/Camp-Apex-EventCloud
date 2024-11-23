trigger SetDefaultStatusOnEvent on CAMPX__Event__c (before insert) {
    // Loop through the records being inserted
    for (CAMPX__Event__c event : Trigger.new) {
         // Set the default status to 'Planning'
         event.CAMPX__Status__c = 'Planning';
         event.CAMPX__StatusChangeDate__c = System.now();
         event.CAMPX__NetRevenue__c = CampXEventHelper.calculateSingleNetRevenue(event);     
    }            
        
}