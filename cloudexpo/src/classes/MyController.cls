public with sharing class MyController {

    private Account account;
    
    public Account getAccount() {
    	
    	Id id = ApexPages.currentPage().getParameters().get('Id');
    	
		if(id == null) {
			account = new Account();
		}
    	
        if(account == null)
        	account = [Select Id, name from Account 
        				where Id=: ApexPages.currentPage().getParameters().get('Id')];
		return account; 
    }
    
    public PageReference save() {
    	return null;
    }

}