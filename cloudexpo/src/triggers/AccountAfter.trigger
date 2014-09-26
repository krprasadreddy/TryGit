trigger AccountAfter on Account (after insert, after update) {
	
	if(AccountHandler.runOnce()) { 
		
		if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)) {
			
			if(trigger.isInsert) {
				AccountHandler.getInstance().insertCompanyDefaultAddress(trigger.newMap);
			}
						
			if(trigger.isUpdate) {
				AccountHandler.getInstance().updateCompanyDefaultAddress(trigger.oldMap, trigger.newMap);
			}
		}	
	}

}