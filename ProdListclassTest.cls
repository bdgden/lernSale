@isTest
public class ProdListclassTest {

    @isTest static void TestMetods() {
        Product_Table__c ptb = new Product_Table__c (Name='TestName', Title__c='Some body here', Product_Description__c='Some',
                                                     Image_Url__c='image', Unit_Price__c=200);
     	insert ptb;
        PageReference pageRef = Page.ProdTitle;
            Test.startTest();
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
        System.assert(controller.prodTab.size() > 0);
    }
}