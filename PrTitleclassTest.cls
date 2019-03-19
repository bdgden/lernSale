@isTest
public class PrTitleclassTest {
    
     @isTest static void TestMetods() {
        Product_Table__c ptb = new Product_Table__c (Name='TestName', Title__c='Some body here', Product_Description__c='Some',
                                                     Image_Url__c='image', Units_Ava__c=20);
     	insert ptb;
        PageReference pageRef = Page.ProdTitle;
            Test.startTest();
            Test.setCurrentPage(pageRef);
            pageRef.getParameters().put('id',ptb.Id);
            PrTitleclass controller = new PrTitleclass();
        	PageReference q = controller.redirectToTitle();
			PageReference s = Page.ProductList;
         	PageReference w = controller.redirectToShop();
			PageReference d = Page.ProdBuy;
         	controller.getpt();
         	controller.itemId = ptb.id;
        	Test.stopTest();
        system.assertEquals(q.getURL(), s.getURL());
        system.assertEquals(w.getURL(), d.getURL());
        System.assert(controller.pt.size() > 0);
    }

}