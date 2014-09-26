public with sharing class AccountAfterSupport {
	
	public static void syncParentAccount(set<Id> AccountIds, set<Id> parentIds) {
		
		Map<Id, Account> addMap = new Map<Id, Account>();
		Map<Id, Account> uncheckMap = new Map<Id, Account>();
		
		Map<Id, Map<Id,Account>> parentMap = new Map<Id, Map<Id, Account>>(); 
		
		for(List<Account> accounts : [Select a.ParentId, a.Name, a.Id, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity,Default_Address__c, 
										(Select Id, Name, Type, RecordTypeId, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,Default_Address__c, 
										LastModifiedDate From ChildAccounts where RecordType.Name = 'Address' and Default_Address__c = true  order By LastModifiedDate DESC) From Account a where Id IN: parentIds]) {
			
			for(Account account : accounts) {
				for(Account acc : account.ChildAccounts) {					
					if(accountIds.contains(acc.Id)) {
						addMap.put(acc.parentId, acc); // parent to new Address Account.
					}else {
						uncheckMap.put(acc.Id, acc); // unchec exixting default address.
					}
					
					system.debug('addMap----------'+addMap);
					system.debug('uncheckMap------'+uncheckMap);
				/*	
					if(parentMap.get(acc.ParentId) == null) {
						parentMap.put(acc.Id, new Map<Id, Account>{acc.id => acc});
					}else {
						parentMap.get(acc.ParentId).put(acc.Id,acc);
					}*/
				}
				
			}
		}
		
		
			updateParentAddress(addMap);
			uncheckDefaultAddress(uncheckMap);
		
	}
	
	public static void uncheckDefaultAddress(Map<Id, Account> newMap) {
		
		List<Account> updateAccounts = new List<Account>();
		
		for(Account acc : newMap.values()) {
			if(acc.Default_Address__c) {
				acc.Default_Address__c = false;
				updateAccounts.add(acc);
			}
		}
		
		update updateAccounts;
		
	}
	
	public static void updateParentAddress(Map<Id, Account> newMap) {
		
		List<Account> updateAccounts = new List<Account>();
		
		for(Account acc : newMap.values()) {
			updateAccounts.add(new Account(
				Id = acc.ParentId,
				BillingStreet = acc.BillingStreet,
				BillingCity = acc.BillingCity,
				BillingState = acc.BillingState,
				BillingPostalCode = acc.BillingPostalCode,
				BillingCountry = acc.BillingCountry
			));
		}
		
		update updateAccounts;
	}

}