trigger CampXSponsorAfterInsert on CAMPX__Sponsor__c (after insert) {
    Set<Id> sponsorEventsToUpdate = new Set<Id>();

    for (CAMPX__Sponsor__c sponsor : Trigger.new){
        if(sponsor.CAMPX__Status__c == 'Accepted' && !String.isEmpty(sponsor.CAMPX__Event__c)){
            sponsorEventsToUpdate.add(sponsor.CAMPX__Event__c);
        }
    }

    if (!sponsorEventsToUpdate.isEmpty()){
        //Collect the list of events and call the function to update their Gross Revenue
        List<CAMPX__Event__c> eventsToUpdate = [SELECT Id, CAMPX__GrossRevenue__c FROM CAMPX__Event__c
                                                WHERE Id IN :sponsorEventsToUpdate];
        if (!eventsToUpdate.isEmpty()){
            CampXSponsorHelper.updateEventRevenue(eventsToUpdate);
        }

    }

}