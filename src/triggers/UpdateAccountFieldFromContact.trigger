trigger UpdateAccountFieldFromContact on Contact (after insert,after update) {

     List <id> accId = new List<id>();
    
   for(Contact c: trigger.new ){
      if(c.Accountid!=NULL && c.Is_Primary_Contact__c == true && c.Phone!=null){
             
             accId.add(c.Accountid);
             
       }
    } 
    
    List <Account> accList = [SELECT id,Name,Phone,(SELECT id,Accountid,Phone FROM Contacts) FROM Account WHERE id IN : accId ]; 
    System.debug('@@@@The Stringd is @@@@@'+accList);
    
  //Map <string,Contact> contactMap = new Map<string,Contact>();
  
    List <Account> updatedaccList = new List <Account>();
    
    for(Contact c: trigger.new){
       for(Account Acc : accList){
          if(accList[0].contacts!=NULL){
        
             Acc.Phone = c.Phone;
             updatedaccList.add(Acc);
        
        }
       }
     }
     
          update updatedaccList;
     
   /* for(Account Acc:accList){
       if(contactMap.containsKey(Acc.id)){
       
         Acc.Phone = contactMap.get(Acc.id).Phone;
       
       }
    
    }*/
   
     
}