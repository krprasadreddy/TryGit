public with sharing class AccountPagination {
	
	private List<Opportunity> opps;
	
	public ApexPages.StandardSetController setCon; 
	
	public AccountPagination(ApexPages.StandardSetController stdController) {
		setCon = stdController;
		stdController.setPageSize(5);
	}
	
	public ApexPages.StandardSetController accountRecords {
        get {
            if(accountRecords == null) {
                accountRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT Name FROM Opportunity]));
            }
            return accountRecords;
        }
        private set;
    }
    
    public List<Opportunity> getOpportunities() {
         return (List<Opportunity>) accountRecords.getRecords();
    } 
    
    public Integer getRecordSize() {
    	return accountRecords.getRecords().size();
    }

}