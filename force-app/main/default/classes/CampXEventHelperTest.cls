@isTest
public class CampXEventHelperTest {
    // Method to test calculateNetRevenue(List<CAMPX__Event__c> events)
    @isTest
    static void testCalculateNetRevenue() {
        // Create test data: A list of events
        List<CAMPX__Event__c> eventList = new List<CAMPX__Event__c>{
            // Case 1: Both GrossRevenue and TotalExpenses are not null
            new CAMPX__Event__c(CAMPX__GrossRevenue__c = 5000, CAMPX__TotalExpenses__c = 2000),
            
            // Case 2: GrossRevenue is null
            new CAMPX__Event__c(CAMPX__GrossRevenue__c = null, CAMPX__TotalExpenses__c = 2000),
            
            // Case 3: TotalExpenses is null
            new CAMPX__Event__c(CAMPX__GrossRevenue__c = 5000, CAMPX__TotalExpenses__c = null),
            
            // Case 4: Both GrossRevenue and TotalExpenses are zero
            new CAMPX__Event__c(CAMPX__GrossRevenue__c = 0, CAMPX__TotalExpenses__c = 0)
        };
        
        // Call the helper method
        CampXEventHelper.calculateNetRevenue(eventList);

        // Validate results
        System.assertEquals(3000, eventList[0].CAMPX__NetRevenue__c, 'Net Revenue should be 3000');
        System.assertEquals(null, eventList[1].CAMPX__NetRevenue__c, 'Net Revenue should be null when GrossRevenue is null');
        System.assertEquals(null, eventList[2].CAMPX__NetRevenue__c, 'Net Revenue should be null when TotalExpenses is null');
        System.assertEquals(0, eventList[3].CAMPX__NetRevenue__c, 'Net Revenue should be 0 when both GrossRevenue and TotalExpenses are 0');
    }

    // Method to test calculateSingleNetRevenue(CAMPX__Event__c event)
    @isTest
    static void testCalculateSingleNetRevenue() {
        // Case 1: Both GrossRevenue and TotalExpenses are not null
        CAMPX__Event__c event1 = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 8000, CAMPX__TotalExpenses__c = 5000);
        Decimal result1 = CampXEventHelper.calculateSingleNetRevenue(event1);
        System.assertEquals(3000, result1, 'Net Revenue should be 3000');
        
        // Case 2: GrossRevenue is null
        CAMPX__Event__c event2 = new CAMPX__Event__c(CAMPX__GrossRevenue__c = null, CAMPX__TotalExpenses__c = 3000);
        Decimal result2 = CampXEventHelper.calculateSingleNetRevenue(event2);
        System.assertEquals(null, result2, 'Net Revenue should be null when GrossRevenue is null');
        
        // Case 3: TotalExpenses is null
        CAMPX__Event__c event3 = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 4000, CAMPX__TotalExpenses__c = null);
        Decimal result3 = CampXEventHelper.calculateSingleNetRevenue(event3);
        System.assertEquals(null, result3, 'Net Revenue should be null when TotalExpenses is null');
        
        // Case 4: Both GrossRevenue and TotalExpenses are zero
        CAMPX__Event__c event4 = new CAMPX__Event__c(CAMPX__GrossRevenue__c = 0, CAMPX__TotalExpenses__c = 0);
        Decimal result4 = CampXEventHelper.calculateSingleNetRevenue(event4);
        System.assertEquals(0, result4, 'Net Revenue should be 0 when both GrossRevenue and TotalExpenses are 0');
    }
}
