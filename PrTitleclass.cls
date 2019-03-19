public class PrTitleclass {
    
    public string itemId {get;set;}
    
    public list<Product_Table__c> pt;
     
    public list<Product_Table__c> getpt() {
        if(pt == null) {
            pt = [
        	SELECT Id, Name, Product_Description__c, Image_Url__c, Units_Ava__c, Title__c
        	FROM Product_Table__c
        	WHERE Id =
            :ApexPages.currentPage().
             getParameters().
             get('Id')
		    ];   
        } 
        return pt;
    }
    
   public PageReference redirectToTitle() {
        
        PageReference Page = Page.ProductList;
        Page.setRedirect(true);
        
        return Page;
    }   
    
  public PageReference redirectToShop() {
        
        PageReference shop = Page.ProdBuy;
            
        shop.getParameters().put('Id', itemId);
        shop.setRedirect(true);
        
    	return shop;
    }    
}