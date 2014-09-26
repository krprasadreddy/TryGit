@isTest
private class globalShipmentControllerTest{
    static testMethod void globalShipmentControllerTest() {
    	globalShipmentController testCon = new globalShipmentController();
        
        Merchandise__c testMerch = new Merchandise__c(
        	Name = 'Test Merch 1',
            Quantity__c = 1000,
            Description__c = 'this is a test thing'
        );
        insert testMerch;
        
        Shipment__c testShipment = testCon.getShipment();
        List<Merchandise__c> testMerchandiseList = testCon.getMerchandise();
        
        List<Merchandise__c> testAllMerch = globalShipmentController.remoteMerchandise('');
        List<Merchandise__c> testFilteredMerch = globalShipmentController.remoteMerchandise('Test');
        
        boolean testBool = globalShipmentController.insertShipment(String.valueOf(testFilteredMerch[0].id), '10', 'Arrived', String.valueOf(date.Today()));
    }
}