@isTest
public class ProdBuyclassTest {
    
    @TestSetup
    static void  setupTestData() {
        Contact conts = new Contact(FirstName='Test Name', LastName='Test LastName', Email='123@1.1');
        insert conts;
    }
   
    @isTest static void TestMetods() {
        Product_Table__c ptb = new Product_Table__c (Name='TestName', Unit_Price__c=500, Units_Ava__c=20);
     	insert ptb;
        PageReference pageRef = Page.ProdBuy;
            Test.startTest();
            Test.setCurrentPage(pageRef);
            pageRef.getParameters().put('id',ptb.Id);
            ProdBuyclass controller= new ProdBuyclass();
        	controller.unitCount = 25;
        	controller.updateUnitCount();
        	controller.buyItem();
        	controller.getptbList();
        	controller.getcontsField();
        	PageReference q = controller.redirectToTitle();
			PageReference s = Page.ProductList;
        	List<ApexPages.Message> msgList = ApexPages.getMessages();
        	Test.stopTest();
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
   		System.assertEquals('Unit Count must be no more than ' + ptb.Units_Ava__c, msg.getSummary());
        }
        system.assertEquals(q.getURL(), s.getURL());
        System.assert(controller.conts <> Null);
        System.assert(controller.ptbList.size() > 0);
        System.assertEquals(controller.totalAmount, 12500, 'Calculator Work');
    }
    
    @isTest static void buyItemContsUpdateAndUnitCount2() {
        Product_Table__c ptb = new Product_Table__c (Name='TestName', Unit_Price__c=500, Units_Ava__c=20);
     	insert ptb;
        PageReference pageRef = Page.ProdBuy;
            Test.startTest();
            Test.setCurrentPage(pageRef);
            pageRef.getParameters().put('id',ptb.Id);
            ProdBuyclass controller= new ProdBuyclass();
        	controller.unitCount = 2;
        	controller.total = 1000;
        	controller.buyItem();
        	Database.SaveResult resCont = Database.update(controller.conts, true);
        	Database.UpsertResult resOrd = Database.upsert(controller.ordTable, true);
        	List<ApexPages.Message> msgList = ApexPages.getMessages();
        	Test.stopTest();
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
   		System.assertEquals('Your purchase is successful.', msg.getSummary());
        }
		System.assertEquals(resCont.isSuccess(), true);
        System.assertEquals(controller.insConts, Null);
        System.assertEquals(resOrd.isSuccess(), true);
    }
    
    @isTest static void buyItemContsInsertAndUnitCount0() {
        Product_Table__c ptb = new Product_Table__c (Name='TestName', Unit_Price__c=500, Units_Ava__c=20);
     	insert ptb;
        PageReference pageRef = Page.ProdBuy;
            Test.startTest();
            Test.setCurrentPage(pageRef);
            pageRef.getParameters().put('id',ptb.Id);
            ProdBuyclass controller= new ProdBuyclass();
        	controller.unitCount = 0;
        	controller.conts = new Contact (FirstName='Name', LastName='Test', Email='test@net.net');
        	controller.buyItem();
        	Database.UpsertResult resCont = Database.upsert(controller.insConts, true);
        	List<ApexPages.Message> msgList = ApexPages.getMessages();
        	Test.stopTest();
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
   		System.assertEquals('Unit Count must be no more than 0', msg.getSummary());
        }
		System.assertEquals(resCont.isSuccess(), true);
    }    
}