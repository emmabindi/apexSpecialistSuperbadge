public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
    	Http http = new Http();
    	HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<Object> equipmentList = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> equipmentToUpdate = new List<Product2>();
            
            for (Object item : equipmentList) {
                Map<String,Object> itemMap = (Map<String,Object>) item;
                // System.debug(item);
                // System.debug('-----------------------');
                // parse each to then create list of records to upsert using SKU as ext id
                Product2 e = new Product2();
                String sku = itemMap.get('sku').toString();
                e.Warehouse_SKU__c = sku;
                e.Replacement_Part__c = true;
                e.Cost__c = (Decimal)itemMap.get('cost');
                e.Current_Inventory__c = (Double)itemMap.get('quantity');
                e.Lifespan_Months__c = (Double)itemMap.get('lifespan');
                e.Maintenance_Cycle__c = (Decimal)itemMap.get('maintenanceperiod');
                e.Name = (String)itemMap.get('name');
                equipmentToUpdate.add(e);
                System.debug(e);
                /*System.debug(itemMap.get('sku'));
                System.debug(itemMap.get('_id'));
                System.debug(itemMap.get('name'));
                System.debug(itemMap.get('cost'));
                System.debug(itemMap.get('quantity'));
                System.debug(itemMap.get('lifespan'));
                System.debug(itemMap.get('replacement'));
                System.debug(itemMap.get('maintenanceperiod')); */
            }
            upsert equipmentToUpdate;
        }
    }
}