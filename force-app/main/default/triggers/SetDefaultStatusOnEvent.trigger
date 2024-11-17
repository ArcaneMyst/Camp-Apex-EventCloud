trigger SetDefaultStatusOnEvent on CAMPX__Event__c (before insert) {
    // Loop through the records being inserted
    for (CAMPX__Event__c eventRecord : Trigger.new) {
         // Set the default status to 'Planning'
         eventRecord.CAMPX__Status__c = 'Planning';
         eventRecord.CAMPX__StatusChangeDate__c = System.now();
        }            
        
    }