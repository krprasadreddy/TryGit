public with sharing class AccountHandler {
	
	private static AccountHandler instance = null;
	private static boolean firstRun = true;
	
	private List<Account> parentToChildAccounts = null;
	private List<Account> updateAccounts = new List<Account>();
	
	private Map<ID, Schema.RecordTypeInfo> recordTypeById = null;
	private static Map<Id, Account> parentToChildSyncMap = new Map<Id, Account>();
	private static Map<Id, Account> uncheckDefaultMap = new Map<Id, Account>();
	
	
	// private constructor
	private AccountHandler () {
		
	}
	
	// return instance of Account handler
	public static AccountHandler getInstance() {
		if(instance == null) {
			instance = new AccountHandler();
		}
		return instance;
	}
	
	// to avoid recursive trigger
	public static boolean runOnce(){
    	if(firstRun) {
    		firstRun = false;
    		return true;
    	}else {
    		return firstRun;
    	}
    }
    
    public Map<ID, Schema.RecordTypeInfo> getRecordTypeInfosById() {    	
    	if(recordTypeById == null) {
    		recordTypeById = Schema.SObjectType.Account.getRecordTypeInfosById();
    	}
    	return recordTypeById;    		
    }
    
    public void updateCompanyDefaultAddress(Map<Id, Account> oldAccMap, Map<Id,Account> newAccMap) {  
    	
    	Map<Id,Id> parentToChildMap = validateCompanyDefaultAddress(oldAccMap,newAccMap);
    	
    	set<Id> addressSyncIds = getChildIds(parentToChildMap.values());
    	
    	List<Account> parentAccounts = AccountHandler.getInstance().getAccountsByParentAndChild(parentToChildMap.keySet());
    	
    	processAddressSync(parentAccounts, addressSyncIds);
    }
    
    public void insertCompanyDefaultAddress(Map<Id,Account> newAccMap) {    	
    	
    	Map<Id,Id> parentToChildMap = validateCompanyDefaultAddress(null,newAccMap);
    	
    	set<Id> addressSyncIds = getChildIds(parentToChildMap.values());
    	
    	List<Account> parentAccounts = AccountHandler.getInstance().getAccountsByParentAndChild(parentToChildMap.keySet());
    	
    	processAddressSync(parentAccounts, addressSyncIds);    	
    	
    }
    
    private set<Id> getChildIds(list<Id> newAddressIds) {
		
		set<Id> cIds = new Set<Id>();
		    	
    	for(Id cId : newAddressIds) {
    		cIds.add(cId);	
    	}    	
    	return cIds;
    }
    
    private void syncToCompanyAddressFields(List<Account> syncAccounts) {		
		
		for(Account acc : syncAccounts) {
			updateAccounts.add(new Account(
				Id = acc.ParentId,
				BillingStreet = acc.BillingStreet,
				BillingCity = acc.BillingCity,
				BillingState = acc.BillingState,
				BillingPostalCode = acc.BillingPostalCode,
				BillingCountry = acc.BillingCountry
			));
		}		
	}
	
	private void uncheckdefaultAccountAddress(List<Account> uncheckAccounts) {
		
		for(Account acc : uncheckAccounts) {
			if(acc.ReedConfig_IsDefault__c) {
				acc.ReedConfig_IsDefault__c = false;
				updateAccounts.add(acc);
			}
		}		
	}
	
    
    public Map<Id, Id> validateCompanyDefaultAddress(Map<Id, Account> oldAccMap, Map<Id,Account> newAccMap) {
    	
    	Map<Id,Id> parentToChildMap = new Map<Id, Id>();
    	
    	for(Account newAccount : newAccMap.values()) {
			
			if('Address'== getRecordTypeInfosById().get(newAccount.recordTypeId).getName()) {
				
				if(newAccount.ReedConfig_IsDefault__c) {
				
					if(newAccount.ParentId != null) {
				
						if(oldAccMap == null) {
							parentToChildMap.put(newAccount.ParentId, newAccount.Id);
						}else {
							if(oldAccMap.get(newAccount.Id).ReedConfig_IsDefault__c != newAccMap.get(newAccount.Id).ReedConfig_IsDefault__c) {
								parentToChildMap.put(newAccount.ParentId, newAccount.Id);	
							} else {
								Account oldAccount = oldAccMap.get(newAccount.Id);
								if(newAccount.BillingStreet != oldAccount.BillingStreet || newAccount.BillingCity != oldAccount.BillingCity 
									|| newAccount.BillingPostalCode != oldAccount.BillingPostalCode || newAccount.BillingState != oldAccount.BillingState
									|| newAccount.BillingCountry != oldAccount.BillingCountry) {
										
									parentToChildMap.put(newAccount.ParentId, newAccount.Id);					
								} 
							}
						}
					}	
				}
			}
		}
		return parentToChildMap;
    }
    
    public void processAddressSync(List<Account> pAccounts, Set<Id> addressSyncIds) {
    	
    	for(Account cAccounts : pAccounts) {
    		for(Account cAccount : cAccounts.childAccounts) {
    			if(addressSyncIds.contains(cAccount.Id)) {
	    			parentToChildSyncMap.put(cAccount.Id, cAccount);
	    		}else {
	    			uncheckDefaultMap.put(cAccount.Id, cAccount);
	    		}	
    		}
    	}
    	
    	syncToCompanyAddressFields(parentToChildSyncMap.values());
    	uncheckdefaultAccountAddress(uncheckDefaultMap.values());
    	UpdateSobjects(updateAccounts);
    	
    }
    
     //receives a list of wrappers, commits a set of sobjects to database
	public Database.SaveResult[] UpdateSobjects(List<sObject> sObjects)	{
		return Database.update(sObjects);
	}
    
    private List<Account> getAccountsByParentAndChild(Set<Id> parentIds) {
		
		if(parentToChildAccounts == null) {
			parentToChildAccounts = [Select Id, Name, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, 
									BillingCountry, ReedConfig_IsDefault__c, (Select Id, Name, RecordTypeId, ReedConfig_IsDefault__c, 
									LastModifiedDate, ParentId,BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry
									from ChildAccounts where RecordType.Name ='Address' and ReedConfig_IsDefault__c = true Order By LastModifiedDate desc) 
									from Account where Id IN: parentIds];
		}
		return parentToChildAccounts;
	}
}