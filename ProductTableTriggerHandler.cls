public class ProductTableTriggerHandler {
    
    public static void handleBeforeInsert (List<Product_Table__c> ptList){
        
        Org_Configuration__c OrgConfig = Org_Configuration__c.getInstance();
        
        integer days = OrgConfig.Period_Term__c.intValue();
        
        Warehouse__c wh = new Warehouse__c();
        
        for (Product_Table__c ProdTab : ptList) {
            
            if (ProdTab.Added_Date__c == Null) {
                
                ProdTab.Added_Date__c = Date.today();
                
            }
            
            Date qdate = ProdTab.Added_Date__c;
            
            string query = 'SELECT Id FROM Warehouse__c WHERE Period_Start__c <= :qdate AND Period_End__c >= :qdate LIMIT 1';
            
            List<Warehouse__c> whList = Database.query(query);
            
            if (whList.isEmpty()) {
                
                wh.Name = ('Warehouse ' + ProdTab.Added_Date__c + ' ' + qdate.addDays(days));
                wh.Period_Start__c = qdate;
                wh.Period_End__c = qdate.addDays(days);
                insert wh;
                prodTab.Warehouse__c = wh.id;
                
            }
            
            else {

                wh = whList.get(0);
                prodTab.Warehouse__c = wh.id;
                whList.clear();
                
            }
            
        }
        
    }
    
}
