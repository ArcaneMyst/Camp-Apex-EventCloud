trigger CampXSponsorBeforeInsert on CAMPX__Sponsor__c (before insert) {
    // When a CAMPX__Sponsor__c record is created, and the CAMPX__Status__c is blank, it should be set to "Pending"
    for (CAMPX__Sponsor__c sponsor : Trigger.new){
        if (String.isBlank(sponsor.CAMPX__Status__c) || sponsor.CAMPX__Status__c == null){
            sponsor.CAMPX__Status__c = 'Pending';
        }

    }

}