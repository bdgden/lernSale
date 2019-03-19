public class ProdBuyclass {
    
    public Contact conts;
    
    public Product_Table__c ptb;
    
    public List<Product_Table__c> ptbList;
    
    public Integer totalAmount {get;set;}
    
    public Integer unitCount {get;set;}
    
    public Integer unitPrice {get;set;}
    
    public Decimal total {get;set;}
    
    public List<Contact> sqConts;
    
    public Order_Table__c ordTable;
    
    Public Contact insConts;
    
    public ProdBuyclass() {
        
        conts = [SELECT FirstName, LastName, Email from Contact LIMIT 1];
        ptb = [
            SELECT Name, Unit_Price__c, Units_Ava__c
            FROM Product_Table__c
            WHERE Id =
            :ApexPages.currentPage().
            getParameters().
            get('Id')
        ];
        unitPrice = ptb.Unit_Price__c.intValue();
        
    }
    
    public List<Product_Table__c> getptbList() {
        
        ptblist = [
            SELECT Id, Name, Unit_Price__c
            FROM Product_Table__c
            WHERE Id =
            :ApexPages.currentPage().
            getParameters().
            get('Id')
        ];
        return ptbList;
    }
    
    public Contact getcontsField() {
        
        return conts;
        
    }    
    
    public PageReference updateUnitCount() {
        system.debug(unitCount);
        this.totalAmount = unitPrice * unitCount;
        this.total = totalAmount;
        
        return null;
        
    }
    
    public PageReference redirectToTitle() {
        
        PageReference Page = Page.ProductList;
        Page.setRedirect(true);
        
        return Page;
    }   
    
    public void buyItem() {
        
        sqConts = [SELECT Id FROM Contact WHERE Email =:conts.Email];
        system.debug('doUpdate sqConts= ' + sqConts);
        
        if  (sqConts == null || sqConts.isEmpty()) {
            
            insConts = new Contact (FirstName=conts.FirstName, LastName=conts.LastName, Email=conts.Email);
            system.debug('BeforeInsert= ' + insConts);
            upsert insConts;
            conts = [SELECT FirstName, LastName, Email from Contact WHERE Id =:insConts.Id]; 
            
        }
        
        else {
            
            update conts;
        }
        
        if (unitCount == null || unitCount < 1) {
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Unit Count must be no more than 0'));
        }
        
        else  { 
            
            If ((ptb.Units_Ava__c - unitCount) < 0) {
                
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
                                                           'Unit Count must be no more than ' + ptb.Units_Ava__c));
            }
            
            else {
                
                this.ordTable = new Order_Table__c (Product_Table__c=ptb.Id, Units__c=unitCount, 
                                                    Order_Amount__c=total, Contact__c=conts.Id);
                upsert ordTable;
                ptb.Units_Ava__c = ptb.Units_Ava__c - ordTable.Units__c;
                update ptb;
                unitCount = 0;
                totalAmount = 0;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your purchase is successful.'));
            }
            
        }    
        
    }
}