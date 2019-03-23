trigger ProductTableTrigger on Product_Table__c (before insert) {
    
    if (Trigger.isBefore && Trigger.isInsert) {
        
        for (Product_Table__c ProdTab : Trigger.new) {
        
		ProductTableTriggerHandler.handleBeforeInsert(prodTab);
            
        }
        
    }

}