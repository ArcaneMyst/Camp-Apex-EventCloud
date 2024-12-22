trigger CampXSponsorBeforeInsert on CAMPX__Sponsor__c (before insert) {
    //Create a list of Sponsors that may need updating the Event contribution for
    Set<Id> sponsorEventsToUpdate = new Set<Id>();

    // When a CAMPX__Sponsor__c record is created, and the CAMPX__Status__c is blank, it should be set to "Pending"
    for (CAMPX__Sponsor__c sponsor : Trigger.new){
        if (String.isBlank(sponsor.CAMPX__Status__c)){
            sponsor.CAMPX__Status__c = 'Pending';
        }
        
        //Set the sponsor tier level automatically
        if(sponsor.CAMPX__ContributionAmount__c > 0 && sponsor.CAMPX__ContributionAmount__c < 1000){
            sponsor.CAMPX__Tier__c = 'Bronze';
        } else if (sponsor.CAMPX__ContributionAmount__c >= 1000 && sponsor.CAMPX__ContributionAmount__c < 5000){
            sponsor.CAMPX__Tier__c = 'Silver';
        } else if (sponsor.CAMPX__ContributionAmount__c >= 5000){
            sponsor.CAMPX__Tier__c = 'Gold';
        }

    }

    
}