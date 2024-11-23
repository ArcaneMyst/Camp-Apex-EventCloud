trigger SetDefaultStatusOnEvent on CAMPX__Event__c (before insert) {
    // Loop through the records being inserted
    for (CAMPX__Event__c event : Trigger.new) {
         // Set the default status to 'Planning'
         event.CAMPX__Status__c = 'Planning';
         event.CAMPX__StatusChangeDate__c = System.now();

        if (event.CAMPX__GrossRevenue__c != null && event.CAMPX__TotalExpenses__c != null) {
            event.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
        } else if (event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null) {
            event.CAMPX__NetRevenue__c = null;
        } else if (event.CAMPX__GrossRevenue__c == 0 || event.CAMPX__TotalExpenses__c == 0) {
            event.CAMPX__NetRevenue__c = 0;
        }


    }            
        
}