@isTest
private class triggersTestClass {
   
 static testMethod void Prevent_Duplicate_On_Contacttrigger(){
 
     Set<String> testEmailAddress = new Set<String>();
     
      testEmailAddress.add('test1@duptest.com');
      testEmailAddress.add('test2@duptest.com');
      testEmailAddress.add('test3@duptest.com');
      testEmailAddress.add('test4@duptest.com');
      testEmailAddress.add('test5@duptest.com');
      
      System.assert([SELECT count() FROM Contact WHERE Email IN :testEmailAddress] == 0);
      
      Contact contact1 = new contact(LastName ='Test1',Email='test1@duptest.com');
      Contact contact2 = new contact(LastName ='Test2',Email='test2@duptest.com');
      Contact contact3 = new contact(LastName ='Test3',Email='test3@duptest.com');
      
      Contact[] contacts = new contact[]{contact1,contact2,contact3};
      insert contacts;
      
      contact1.Email = 'test4@duptest.com';
      contact2.Email = 'test5@duptest.com';
      update contacts;
      
      Contact dup1 = new Contact(LastName='Test1Dup',
                                 Email='test1@duptest.com');
      try {
            insert dup1;
           // System.assert(false);
     } catch(DmlException e) {
     
         System.assert(e.getNumDml() == 1);
         System.assert(e.getDmlIndex(0) == 0);
         System.assert(e.getDmlFields(0).size() == 1);
         System.assert(e.getDmlFields(0)[0].getDescribe().getName() == 'Email');
         System.assert(e.getDmlMessage(0).indexOf(
            'A Contact with this Email aldready exists. ') > -1);
     
     }                            
      
   // CheckDuplicateOnContact trigger test coverage
     Lead lead = new Lead(LastName = 'Dupe Contact',
                          Status = 'Status',
                          Email='duplicate@gmail.com',
                          Company = 'Test');
     insert lead;                                                    
 
 }
 
 static testMethod void UpdateAccountFieldFromContacttrigger()  {
     
     Account acct = new Account(Name='test');
     insert acct;
     
     Contact cont = new Contact(LastName = 'test',
                                 Email='test@gmail.com',
                                 Is_Primary_Contact__c=true,
                                 Phone='9985635144',
                                 Accountid =acct.id);
     insert cont;
    
 }
 
 static testMethod void UpdateContactFieldtrigger(){
 
     Account acct = new Account(Name='test');
     insert acct;
     
     Contact  cont = new contact(LastName = 'test',
                                  Email='test@gmail.com',
                                  Accountid =acct.id,
                                  Is_Active_for_Campaign__c=false);
     insert cont;
     
     acct.Is_Customer_Active__c = true;
     update acct;
     
    
 
 }
}