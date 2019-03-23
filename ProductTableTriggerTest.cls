@isTest
public class ProductTableTriggerTest {
    
    @TestSetup
    static void  setupTestData() {
        Org_Configuration__c OrgConfig = new Org_Configuration__c(Period_Term__c=10);
        insert OrgConfig;
    }
    
    @isTest public static void Test1() {	
        
        Product_Table__c prodTab = new Product_Table__c(Name = 'Test Name', Added_Date__c = date.newInstance(2019, 03, 21));
        
        Test.startTest();
        Database.SaveResult result = Database.insert(prodTab, true);
        Test.stopTest();
        System.assert(result.isSuccess());
        
    }
    
    @isTest public static void Test2() {
        
        Warehouse__c wh = new Warehouse__c (Name = 'Test Warehouse',
                                            Period_Start__c = date.newInstance(2019, 03, 01),
                                            Period_End__c = date.newInstance(2019, 03, 25));
        insert wh;
        
        Product_Table__c prodTab = new Product_Table__c(Name = 'Test Name');
        
        Test.startTest();
        Database.SaveResult result = Database.insert(prodTab, true);
        Test.stopTest();
        
        System.assert(result.isSuccess());
        
    }
    
     @isTest public static void Tets200Products() {
        
		List<product_table__c> ptbList = new List<product_table__c>();
		for (integer i=200; i<200; i++) {   
  			Product_Table__c prodTab = new Product_Table__c (Name='Test'+i); 
  			ptbList.add(prodTab);
            system.debug(prodTab);   
		}
         
        Test.startTest();
        Database.insert(ptbList);
        Test.stopTest();
    }
    	
}
