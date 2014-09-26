public with sharing class newOpportunityController {
	
	private Account account;
	private Contact contact;
	private Opportunity opportunity;
	private OpportunityContactRole role;
	
	public Account getAccount() {
		if(account == null) {
			account = new Account();
		}
		return account;
	}
	
	public Contact getContact() {
		if(contact == null) {
			contact = new Contact(); 			
		}
		return contact;
	}
	
	public Opportunity getOpportunity() {
		if(opportunity == null) {
			opportunity = new Opportunity();
		}
		return opportunity;
	}
	
	public OpportunityCOntactRole getRole() {
		if(role == null) {
			role = new OpportunityContactRole();
		}
		return role;
	}
	
	public PageReference step1() {
		PageReference firstPage = Page.OpptyStep1;
		//firstPage.setRedirect(true);
		return firstPage;
	}
	
	public PageReference step2() {
		PageReference secondPage = Page.opptyStep2;
		//secondPage.setRedirect(true); 
		return secondPage;		
	}
	
	public PageReference step3() {
		PageReference thirdPage = Page.OpptyStep3;
		//thirdPage.setRedirect(true);
		return thirdPage;
	}
	
	public PageReference cancel() {
		return null;
	}
	
	public PageReference save() {
		
		//Insert account
		
		account.phone = contact.phone;
		insert account;
		
		contact.AccountId = account.Id;
		insert contact;
		
		opportunity.AccountId = account.Id;
		insert opportunity;
		
		role.OpportunityId = opportunity.Id;
		role.ContactId = contact.Id;
		insert role;
		
		PageReference opptyPage = new ApexPages.Standardcontroller(Opportunity).view();
		opptyPage.setRedirect(true);
		
		return opptyPage;
		
	}

}