public class ProdListclass {
    
    public string itemId {get;set;}
    
    public list<Product_Table__c> prodTab;
        
    public list<Product_Table__c> getprodTab() {
        if(ProdTab == null) {
            prodTab = [
                SELECT Id, Name, Unit_Price__c, Product_Description__c, Image_Url__c, Title__c 
                FROM Product_Table__c 
                LIMIT 50
                ];
        } 
        return prodTab;
    }
       
	public PageReference redirectToTitle() {
        
        PageReference title = Page.ProdTitle;
            
        title.getParameters().put('Id', itemId);
        title.setRedirect(true);
        
    	return title;
    }   
    
    public PageReference redirectToShop() {
        
        PageReference pagebuy = Page.ProdBuy;
            
        pagebuy.getParameters().put('Id', itemId);
        pagebuy.setRedirect(true);
        
    	return pagebuy;
    }  
 }