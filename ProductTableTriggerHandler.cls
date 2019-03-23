public class ProductTableTriggerHandler {
    
    public static Warehouse__c wh;
    
    public static Integer days;
    
    public static String query;
    
    public static Date qDate;
    
    public static void handleBeforeInsert (Product_Table__c prodTab){
        
        if (ProdTab.Added_Date__c == Null) {
            
            ProdTab.Added_Date__c = Date.today();
            
        }
        
        Org_Configuration__c OrgConfig = [SELECT Period_Term__c FROM Org_Configuration__c];
        days = OrgConfig.Period_Term__c.intValue();
        
        qdate = ProdTab.Added_Date__c;
        
        query = 'SELECT Id FROM Warehouse__c WHERE Period_Start__c <= :qdate AND Period_End__c >= :qdate LIMIT 1';
        
        List<Warehouse__c> whList = Database.query(query);
        
        if (whList.isEmpty()) {
       
            wh = new Warehouse__c (Name = ('Warehouse ' + ProdTab.Added_Date__c + ' ' 
                                           + qdate.addDays(days)),
                                   Period_Start__c = qdate,
                                   Period_End__c = qdate.addDays(days));
            insert wh;
            prodTab.Warehouse__c = wh.id;
            
        }
        
        else {
            
            wh = [SELECT id FROM Warehouse__c WHERE id =:whList];
            prodTab.Warehouse__c = wh.id;
            
        }
        
    }
    
}