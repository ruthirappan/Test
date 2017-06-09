trigger UpdateContactField on Account (before update) {

  list<Account> AccountList = new list<Account>(); 
  list<Contact> ContactListtoupdate = new list<Contact>();
  
 
 for( Account Acc: Trigger.new){
 
 // Account oldAcc = Trigger.oldMap.get(acc.id);
  
  if(Trigger.oldMap.get(acc.id).Is_Customer_Active__c != Acc.Is_Customer_Active__c){
    
    AccountList.add(Acc);      
  }
  
 }

 ContactListtoupdate = [SELECT id,Name,Is_Active_for_Campaign__c,Accountid FROM Contact WHERE Accountid = : AccountList ];
 
 for(Contact con : ContactListtoupdate ){
  for(Account acc: AccountList){
  
   if(con.Accountid == acc.id){
   con.Is_Active_for_Campaign__c = acc.Is_Customer_Active__c; 
   }
   
  }
   }
  
  if(ContactListtoupdate.isEmpty()== false){
  
     update ContactListtoupdate;
  }
       
  }