trigger AccountBefore on Account (after insert, after update) {
    
    set<Id> AccountIds = new set<Id>();
    set<Id> pIds = new set<Id>();
    
    Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Account.getRecordTypeInfosById();
    //type = rtMap.get(o.RecordTypeId).getName();
        
    if(trigger.isInsert) {
        for(Account acc : trigger.new) {
            if(rtMap.get(acc.recordTypeId).getName() == 'Address') {
                if(acc.ParentId != null) {
                    AccountIds.add(acc.Id);
                    pIds.add(acc.ParentId);
                }
            }
        }
        
        if(!AccountIds.isEmpty()) {
            AccountAfterSupport.SyncParentAccount(AccountIds, pIds); 
        }
    }
    
    
    
    if(trigger.isUpdate) {
        for(Account acc : trigger.new) {
            
            if(acc.ParentId != null) {
                
                pIds.add(acc.ParentId);
                    
                    if(rtMap.get(acc.recordTypeId).getName() == 'Address') {
                    
                    // change non default address to default address
                    if(trigger.oldMap.get(acc.Id).Default_Address__c != trigger.newMap.get(acc.Id).Default_Address__c) {
                
                        if(acc.Default_Address__c) {
                            AccountIds.add(acc.Id);
                        }       
                
                    }else {
                
                        // update address on parent for existing default account
                        if(acc.Default_Address__c) {
                            
                            Account oldAcc = Trigger.oldMap.get(acc.Id);
                             
                             if(acc.BillingStreet != oldAcc.BillingStreet || acc.BillingCity != oldAcc.BillingCity ||
                                    acc.BillingPostalCode != oldAcc.BillingPostalCode || acc.BillingState != oldAcc.BillingState ||
                                    acc.BillingCountry != oldAcc.BillingCountry) {
                                    AccountIds.add(acc.Id);
                             }                  
                        }   
                    }
                }   
            }
            
        }   
        
        if(!AccountIds.isEmpty()) {
            AccountAfterSupport.SyncParentAccount(AccountIds, pIds);
        }
                
    }   
}