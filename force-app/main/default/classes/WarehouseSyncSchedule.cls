global class WarehouseSyncSchedule implements Schedulable {
    global void execute(SchedulableContext ctx) {
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}


/* 
 * public with sharing class WarehouseSyncSchedule {
    WarehouseCalloutService.runWarehouseEquipmentSync();
}*/