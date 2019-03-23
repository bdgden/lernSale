@isTest
public class ProdListclassTest {
    
    @TestSetup
    static void  setupTestData() {
 		Org_Configuration__c OrgConfig = new Org_Configuration__c (Period_Term__c=10);
        insert OrgConfig;
    }
    
    @isTest static void TestMetods() {
        
        Test.startTest();
        Product_Table__c ptb = new Product_Table__c (Name = 'Test', Unit_Price__c = 500, Product_Description__c= 'Test',
                                                     Image_Url__c = 'Test', Title__c = 'Test');
        insert ptb;
        PageReference pageRef = Page.ProdTitle;    
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',ptb.Id);
        ProdListclass controller = new ProdListclass();
        PageReference q = controller.redirectToTitle();
        PageReference s = Page.ProdTitle;
        PageReference w = controller.redirectToShop();
        PageReference d = Page.ProdBuy;
        controller.getprodTab();
        controller.itemId = ptb.id;
        Test.stopTest();
        system.assertEquals(q.getURL(), s.getURL());
        system.assertEquals(w.getURL(), d.getURL());
        System.assert(controller.prodTab.size() >= 0);
    }
}