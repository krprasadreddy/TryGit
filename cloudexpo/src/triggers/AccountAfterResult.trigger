trigger AccountAfterResult on Account (after insert, after update) {
	
	set<Id> accIds = new Set<Id>();
	
	for(Account acc : trigger.new) {
		system.debug('****** Interest ************'+acc.Interest__c);
		accIds.add(acc.Id);
	}
	
	if(accIds != null) {
		Account acc = [select Id, name, Interest__c from Account where Id =: accIds];
		system.debug('***** Account *********'+acc);
	}
}