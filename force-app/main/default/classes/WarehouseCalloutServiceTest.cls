@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
    @isTest static void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}