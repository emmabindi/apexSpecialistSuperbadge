trigger MaintenanceRequest on Case (before update, after update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    if (Trigger.isAfter) {
    	MaintenanceRequestHelper.updateWorkOrders(Trigger.new);	  
    }
}

    /*
for (Case req : Trigger.new) {
if (req.Type == 'Routine Maintenance' || req.Type == 'Repair') {
req.
}
}
*/

/*
if (Trigger.isAfter || Trigger.isBefore) {
if (Trigger.isUpdate) {
	MaintenanceRequestHelper.updateWorkOrders(Trigger.new, Trigger.oldMap);
}
} */

/*
 *     if (Trigger.isBefore) {
        System.debug('********Trigger values***********');
        System.debug('***SFDC: Trigger.old is: ' + Trigger.old);
        System.debug('***SFDC: Trigger.new is: ' + Trigger.new);
    }
    
    if (Trigger.isAfter) {
        
        System.debug('***SFDC: Trigger.old is: ' + Trigger.old);
        System.debug('***SFDC: Trigger.new is: ' + Trigger.new);
    } */