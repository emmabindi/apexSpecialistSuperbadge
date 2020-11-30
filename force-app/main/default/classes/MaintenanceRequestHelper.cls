public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> closedReqs) {
        List<Case> closedRequests = [SELECT Id, Vehicle__c, Equipment__c, Subject, Type,
                                              Date_Reported__c, Status, Equipment__r.Maintenance_Cycle__c
                                              FROM Case WHERE Id in :closedReqs];
        
        // TODO: Complete the method to update workorders
        List<Case> reqsToAdd = new List<Case>();
        
        for (Case req : closedRequests) {
            if (req.Type == 'Repair' || req.Type == 'Routine Maintenance') {
                if (req.Status == 'Closed') {
                    System.debug('Closed Req ' + req);
                    Case newReq = new Case(); 
					newReq.Vehicle__c = req.Vehicle__c;
                    newReq.Equipment__c = req.Equipment__c;
                    newReq.Subject = 'Routine Checkup';
                    newReq.Date_Reported__c = date.today();
                    newReq.Status = 'New';
                    newReq.Type = 'Routine Maintenance';
                    newReq.Origin = 'Phone';
                    System.debug(Integer.valueOf(req.Equipment__r.Maintenance_Cycle__c));
                    newReq.Date_Due__c = date.today().addDays(Integer.valueOf(req.Equipment__r.Maintenance_Cycle__c)); 
                    System.debug('newReq ' + newReq);
                    reqsToAdd.add(newReq);
                }
				System.debug('List ' + reqsToAdd);
            }
        }
        
        if (reqsToAdd.size() > 0) {
            insert reqsToAdd;
        }
    }        
}
/*
 * i had status as the type!! added origin too JIC
 * A non foreign key field cannot be referenced in a path expression: Equipment__c change to r
 * Date expressions must use Integer or Long - addDays not +
 * Method does not exist or incorrect signature: void addDays(Decimal) from the type Date - use Integer.valueOf( 
 *  CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY
 * */