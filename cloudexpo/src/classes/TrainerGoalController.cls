/*
 * @author Debadyuti Sil
 * @Date   30 May 2014
 * @purpose Controller for TrainerGoal Vf Page
 */
public class TrainerGoalController{
    
    public List<TrainerGoalWrapper> listOfTrainerGoals{get;set;}  
    public List<Selectoption>       listofClubs {get;set;}
    public List<Selectoption>       listofTrainerTiers{get{return processPickListValues(new User(),'Trainer_Tier__c','All Tiers');}set;}
    public String selectClub{get;set;}
    public String selectedTier{get;set;}
    public Integer currentmonth{get;set;}{currentmonth = system.today().month();}
    public Integer currentYear{get;set;}{currentYear = system.today().year();}
    public Map<Integer,String> mapofMonthNumberandName{get;set;}
    public Map<Id,String> mapofTrainerIdandProjectedvsActual{get;set;}
    public Map<Id,Integer>  mapofTrainerIdandPreviousmonthGoal{get;set;}
    public Map<Id,Integer>  mapofTrainerIdandCurrentmonthGoal{get;set;}
    public String trainerIdparaminController{get;set;}
    public Map<Id,Goal__c> mapofUserIdandCurrentMonthGoalInDB{get;set;}
    public boolean isReset ;

   
    public TrainerGoalController(ApexPages.StandardController controller) { 
            listOfTrainerGoals = new List<TrainerGoalWrapper>();
            listofClubs        = new List<Selectoption>();
            listofTrainerTiers = new List<Selectoption>();
            mapofMonthNumberandName = new Map<Integer,String>();
            mapofTrainerIdandCurrentmonthGoal  = new  Map<Id,Integer>();
            mapofUserIdandCurrentMonthGoalInDB = new Map<Id,Goal__c>();
            isReset = false;
                
            processAllClubs();
            processMonth();
            
            processTrainerGoals();
            
    }
    
    /*
     * Wrapper for Trainer Goal Table
     */ 
    public Class TrainerGoalWrapper{
        public String trainerName{get;set;}
        public String trainerURL{get;set;}
        public String tier{get;set;}
        public String userId{get;set;}
        public String projectVsActual{get;set;}
        public Integer previousmonthGoal{get;set;}
        public Integer currentmonthGoal{get;set;}//only current month goal editable
        
        public TrainerGoalWrapper(){
            
        }
    }
    
    
   

    
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}{size = 10;}
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                
                string queryString = 'SELECT Id,Name,User__r.Id,User__r.Is_trainer__c,user__r.trainer_tier__c,Home_Club__c FROM Contact Where User__r.Id != null and User__r.Is_trainer__c=true ';                
                if(!String.isBlank(selectClub)){
                    queryString += ' and Home_Club__c =:selectClub ';
                } 
                if(!String.isBlank(selectedTier)){
                    queryString += ' and user__r.trainer_tier__c =: selectedTier';
                }
                queryString += ' order by Name ';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));              
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
               
            }
           return setCon;
        }set;
    	
    }
    
    
    /*
    * Function that process Trainer Goals
    */
    Public void processTrainerGoals(){
        for(TrainerGoalWrapper wrapperRecord: listOfTrainerGoals){
            system.debug('****wrapperRecord***'+wrapperRecord);
            if(wrapperRecord.currentmonthgoal <> null && wrapperRecord.userId <> null){
                mapofTrainerIdandCurrentmonthGoal.put(wrapperRecord.userId,wrapperRecord.currentmonthgoal);
            }
            
        }
        system.debug('****mapofTrainerIdandCurrentmonthGoal****'+mapofTrainerIdandCurrentmonthGoal);
    	processgoalNumbers();
        listOfTrainerGoals = new List<TrainerGoalWrapper>();
        //iterarated over standardset cntroller records    
        for(Contact contact : (List<Contact>)setCon.getRecords()){
            TrainerGoalWrapper wrapper = new TrainerGoalWrapper();
            wrapper.trainerName = contact.Name;
            wrapper.trainerURL  = '/'+contact.Id;
                wrapper.tier        = contact.user__r.trainer_tier__c;
                wrapper.userId      = contact.user__r.Id;
                if(mapofTrainerIdandProjectedvsActual.containsKey(contact.user__r.Id)){
                    wrapper.projectVsActual =  mapofTrainerIdandProjectedvsActual.get(contact.user__r.Id);
                }
                if(mapofTrainerIdandPreviousmonthGoal.containsKey(contact.user__r.Id)){
                    wrapper.previousmonthGoal = mapofTrainerIdandPreviousmonthGoal.get(contact.user__r.Id);
                }else{
                    wrapper.previousmonthGoal = 0;
                }
                if(mapofTrainerIdandCurrentmonthGoal.containsKey(contact.user__r.Id)){
                    wrapper.currentmonthGoal = mapofTrainerIdandCurrentmonthGoal.get(contact.user__r.Id);
                }else{
                    wrapper.currentmonthGoal = 0;
                }
              
            listOfTrainerGoals.add(wrapper);
            system.debug('****listOfTrainerGoals**'+listOfTrainerGoals);
        }
        
         
    }      
    
    /*
     * Function that runs when we process any filter 
     */
    public void processFilter(){
        setcon= null;
        processTrainerGoals();
    }
    
    /*
     * Function that fetches all club details to use in club picklist
     */
    public void processAllClubs(){
        Set<String> setofUniqueClubs = new Set<String>();
        for(Club__c club : [SELECT Id, Name FROM Club__c order by Name]){
            if(!setofUniqueClubs.contains(club.Name)){
            	listofClubs.add(new Selectoption(club.Id,club.Name));
                setofUniqueClubs.add(club.Name);
            }
        }
        for(Contact con : [Select Id, Home_Club__c From Contact Where User__c =:UserInfo.getUserId()]){
            selectClub = con.Home_Club__c;
        }    
    }   
    
       
    public void processMonth(){
        mapofMonthNumberandName.put(1,'Jan') ;
        mapofMonthNumberandName.put(2,'Feb') ;
        mapofMonthNumberandName.put(3,'Mar') ;
        mapofMonthNumberandName.put(4,'Apr') ;
        mapofMonthNumberandName.put(5,'May') ;
        mapofMonthNumberandName.put(6,'Jun') ;
        mapofMonthNumberandName.put(7,'Jul') ;
        mapofMonthNumberandName.put(8,'Aug') ;
        mapofMonthNumberandName.put(9,'Sep') ;
        mapofMonthNumberandName.put(10,'Oct') ;
        mapofMonthNumberandName.put(11,'Nov') ;
        mapofMonthNumberandName.put(12,'Dec') ;
   
    }
    
    /*
     * Function that fetches all goal realted details
     */
    public void processgoalNumbers(){
        mapofTrainerIdandProjectedvsActual = new  Map<Id,String>();
        mapofTrainerIdandPreviousmonthGoal = new  Map<Id,Integer>();
        
        for(EDW_Proj_Dash_Trainer_Monthly__c trainerMonthly : [SELECT EDW_Trainer_Esp_Id__c, EDW_Month__c, EDW_Year__c, EDW_This_Month_Projection__c, EDW_This_Month_Actual__c 
                                                               FROM EDW_Proj_Dash_Trainer_Monthly__c
                                                               WHERE EDW_Month__c =: currentmonth
                                                               AND EDW_Year__c =: currentYear]){
                     if(trainerMonthly.EDW_Trainer_Esp_Id__c <> null ){                                             
                 		mapofTrainerIdandProjectedvsActual.put(trainerMonthly.EDW_Trainer_Esp_Id__c,String.valueof(Integer.valueof(trainerMonthly.EDW_This_Month_Projection__c))+'/'+String.valueof(Integer.valueof(trainerMonthly.EDW_This_Month_Actual__c)));    
                     }
           }
           system.debug('***mapofTrainerIdandProjectedvsActual***'+mapofTrainerIdandProjectedvsActual);
           
          for(Goal__c goal : [SELECT Id, PTGoal__c, User__c, GoalMonth__c, GoalYear__c 
          					  FROM Goal__c
          					  WHERE (GoalMonth__c =: currentmonth or GoalMonth__c =: currentmonth-1)
          					  AND GoalYear__c =: currentYear ]) {
          			if(goal.User__c <> null){
                        
          				if(goal.GoalMonth__c == currentmonth-1){
          					if(goal.PTGoal__c == null ){
          						goal.PTGoal__c = 0;
          					}
          					mapofTrainerIdandPreviousmonthGoal.put(goal.User__c,Integer.valueof(goal.PTGoal__c));
          				}else if(goal.GoalMonth__c == currentmonth){
          					if(isReset){
          						mapofTrainerIdandCurrentmonthGoal.put(goal.User__c,0);
          					}else{
	          					if(goal.PTGoal__c == null ){
	          						goal.PTGoal__c = 0;
	          					}
	                            if(!mapofTrainerIdandCurrentmonthGoal.containsKey(goal.User__c)){
	          				    	mapofTrainerIdandCurrentmonthGoal.put(goal.User__c,Integer.valueof(goal.PTGoal__c)); 
	                            }else{
	                                mapofTrainerIdandCurrentmonthGoal.put(goal.User__c,mapofTrainerIdandCurrentmonthGoal.get(goal.User__c));
	                            }
          					}
                            mapofUserIdandCurrentMonthGoalInDB.put(goal.User__c,goal);
          				}
          			}		  	
          					  	
          }
    }
    
    //Logic for Reset
    public void resetAll(){
		isReset = true;	
        processTrainerGoals();  
    }
    //logic for submit All
    public void submitAll(){
            isReset = false;
             processTrainerGoals();
             List<Goal__c> listofGoalstoUpsert = new List<Goal__c>();
           
			for(Id trainerUserId : mapofTrainerIdandCurrentmonthGoal.keyset()){
                Goal__c tobeUpdatedGoal = new Goal__c();
                if(mapofUserIdandCurrentMonthGoalInDB.containsKey(trainerUserId)){
                         tobeUpdatedGoal = mapofUserIdandCurrentMonthGoalInDB.get(trainerUserId);
                         
                }else{
                    tobeUpdatedGoal.User__c =  trainerUserId;
                    tobeUpdatedGoal.GoalMonth__c = currentmonth;
                    tobeUpdatedGoal.GoalYear__c = currentYear;
                }
                tobeUpdatedGoal.PTGoal__c = mapofTrainerIdandCurrentmonthGoal.get(trainerUserId);
                listofGoalstoUpsert.add(tobeUpdatedGoal);
                
            } 
          	 try{  
                   if(listofGoalstoUpsert.size()>0){
                     Database.upsert(listofGoalstoUpsert);
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm,'Goal Updated Successfully');
                 	 ApexPages.addMessage(myMsg);  
                   }
                 	
                }catch(Exception e){
                   ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Exception caused By : '+e.getmessage());
                   ApexPages.addMessage(myMsg);
                }
    }
    
    //submit current month trainer goal
    public void processSubmitSpecificTrainerGoal(){
    	isReset = false;
        processTrainerGoals();
        if(!String.isBlank(apexpages.currentPage().getparameters().get('trainerIdparam'))){
              string trainerUserId = apexpages.currentPage().getparameters().get('trainerIdparam');
              Goal__c tobeUpdatedGoal = new Goal__c();
            if(mapofTrainerIdandCurrentmonthGoal.containsKey(trainerUserId)){
                if(mapofUserIdandCurrentMonthGoalInDB.containsKey(trainerUserId)){
                         tobeUpdatedGoal = mapofUserIdandCurrentMonthGoalInDB.get(trainerUserId);
                         
                }else{
                    tobeUpdatedGoal.User__c =  trainerUserId;
                    tobeUpdatedGoal.GoalMonth__c = currentmonth;
                    tobeUpdatedGoal.GoalYear__c = currentYear;
                }
                tobeUpdatedGoal.PTGoal__c = mapofTrainerIdandCurrentmonthGoal.get(trainerUserId);

                try{
                 Database.upsert(tobeUpdatedGoal);
                 	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm,'Goal Updated Successfully');
                 	ApexPages.addMessage(myMsg);
                }catch(Exception e){
                   ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Exception caused By : '+e.getmessage());
                   ApexPages.addMessage(myMsg);
                }
            }  
            
        }
    }
    
    public List<selectOption> processPickListValues(Sobject objectName, String fieldName, String defaultValue) {
      List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
      if (defaultValue != null) { //if there is a first value being provided
         options.add(new selectOption('', defaultValue)); //add the first option
      }
      Schema.sObjectType sobjectType = objectName.getSObjectType(); //grab the sobject that was passed
      Schema.DescribeSObjectResult sobjectDescribe = sobjectType.getDescribe(); //describe the sobject
      Map<String, Schema.SObjectField> fieldMap = sobjectDescribe.fields.getMap(); //get a map of fields for the passed sobject
      List<Schema.PicklistEntry> picklistValues = fieldMap.get(fieldName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
      for (Schema.PicklistEntry option : picklistValues) { //for all values in the picklist list                  
            options.add(new selectOption(option.getValue(), option.getLabel())); //add the value and label to our final list
      }
      return options; 
   }
   
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
  
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
            
        }
        set;
    }
  
    public void first() {
      setCon.first();
      isReset = false;
      processTrainerGoals();  
    }
  
    public void last() {
        setCon.last();
        isReset = false;
        processTrainerGoals();
    }
  
    public void previous() {
        setCon.previous();
        isReset = false;
        processTrainerGoals();
    }
  
    public void next() {
       setCon.next();
       isReset = false;
       processTrainerGoals();
    }
}