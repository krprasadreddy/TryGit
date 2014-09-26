/*
 * @author Debadyuti Sil
 * @Date   2 Jun 2014
 * @purpose Test Class  for TrainerGoalController
 */

@isTest
public class TrainerGoalControllerTest{
  
    public static testmethod void processTrainerGoalControllerTest(){
        //create club
        Club__c testClub = new Club__c(Name = '19th street', clubId__c =  '19th street');
        insert testClub;
        system.assert(testClub.id <> null);
        //create user
         Profile p = [select id from profile where  Name = 'System Administrator' limit 1];
        User testUser = new User(
            FirstName='User test',
            LastName='Test',
            Alias='Test123',
            Username='usertest123@equinox.com',
            email='user@bmi.com',
            CommunityNickname='usertest123',
            TimeZoneSidKey='America/Los_Angeles',
            localesidkey='en_US',
            profileId = p.Id,
            EmailEncodingKey='UTF-8',
            LanguageLocaleKey='en_US',
            trainer_tier__c = 'Tier 1',
            Is_trainer__c = true);
        insert testUser;
        system.assert(testUser.id <> null);

        //create Contact
        Contact testContact = new Contact(Home_Club__c = testClub.Id,User__c = testUser.Id,lastname='TestCon');
        insert testContact;
        system.assert(testContact.id <> null);
        
        Goal__c testCurrentMonthGoal = new Goal__c(PTGoal__c = 45,User__c=testUser.ID, GoalMonth__c=System.now().month(), GoalYear__c = system.now().year());
        insert  testCurrentMonthGoal;
        Goal__c testPreviousMonthGoal = new Goal__c(PTGoal__c = 40,User__c=testUser.ID, GoalMonth__c=System.now().month()-1, GoalYear__c = system.now().year());
        insert  testPreviousMonthGoal; 
        
        Test.startTest();
         
         ApexPages.StandardController sc = new ApexPages.StandardController(testContact);
         TrainerGoalController testcontroller = new TrainerGoalController(sc);
         Pagereference testPage = page.TrainerGoal;
         Test.setcurrentpage(testPage);
         testcontroller.selectClub = testClub.Id;
         testcontroller.selectedTier = 'Tier 1';
         testcontroller.processFilter();
         apexpages.currentPage().getparameters().put('trainerIdparam',testUser.Id);
         testcontroller.processSubmitSpecificTrainerGoal();
         testcontroller.next();
         testcontroller.last();
         testcontroller.previous();
         testcontroller.first();
         testcontroller.resetAll();
         testcontroller.submitAll();
         
        Test.stopTest();
        
    }
}