@isTest
private class MaintenanceRequest_Test {
    @isTest static void testMaintenaceRequest() {
        Vehicle__c vehicle = new Vehicle__c();
        vehicle.Name = 'Test vehicle';
        insert vehicle;
        
        Product2 equipment = new Product2();
		equipment.Name = 'Test equip';
        equipment.Maintenance_Cycle__c = 100;
        insert equipment;
        
        List<Case> casesToUpdate = new List<Case>();
        
        for (Integer i = 0; i < 300; i++) {
            Case request = new Case();
            request.Subject = 'Test ' + i;
            request.Priority = 'Medium';
            request.Status = 'New';
            request.Type = 'Repair';
            request.Origin = 'Phone';
            request.Vehicle__c = vehicle.Id;
            request.Equipment__c = equipment.Id;
            casesToUpdate.add(request);
        }
        System.debug(casesToUpdate);
        insert casesToUpdate;
        
        test.startTest();
        List<Case> closedCases = new List<Case>();
        for (Case c : casesToUpdate) {
            c.Status = 'Closed';
            closedCases.add(c);
        }
        Database.SaveResult[] srList = Database.update(closedCases);
        for (Database.SaveResult sr : srList) {
			System.debug(sr.isSuccess());
        }
        
        test.stopTest();
        // assert that a new case has been raised on that vehicle 
        // with due date +100 days from today
    }
}