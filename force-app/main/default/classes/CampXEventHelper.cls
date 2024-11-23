public class CampXEventHelper {
    // Method to calculate Net Revenue for a list of events
    public static void calculateNetRevenue(List<CAMPX__Event__c> events) {
        for (CAMPX__Event__c event : events) {
            if (event.CAMPX__GrossRevenue__c != null && event.CAMPX__TotalExpenses__c != null) {
                event.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
            } else if (event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null) {
                event.CAMPX__NetRevenue__c = null;
            } else if (event.CAMPX__GrossRevenue__c == 0 || event.CAMPX__TotalExpenses__c == 0) {
                event.CAMPX__NetRevenue__c = 0;
            }
        }
    }

    public static decimal calculateSingleNetRevenue(CAMPX__Event__c event) {
        Decimal netRevenue;
        if (event.CAMPX__GrossRevenue__c != null && event.CAMPX__TotalExpenses__c != null) {
            netRevenue = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
        } else if (event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null) {
            netRevenue = null;
        } else if (event.CAMPX__GrossRevenue__c == 0 || event.CAMPX__TotalExpenses__c == 0) {
            netRevenue = 0;
        }
        return netRevenue;
        }
    
}