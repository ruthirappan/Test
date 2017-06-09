trigger CheckDuplicateOnContact on Lead (before insert, before update) {
 
 List<Lead> leadList = new List<Lead>();
 
 for (Lead myLead : Trigger.new) {
    if (myLead.Email != null) {
        leadList.add(mylead); 
    }
  }
  
  List<Contact> conList = [SELECT id,LastName,Email FROM Contact];
  
  for(Contact con : conList){
   for(Lead lead :leadList ) {
    if(con.Email == lead.Email){
   
     lead.addError(' Duplicate Alert !! - There is already an contact record with identical email address : <a href="https://ap1.salesforce.com/'+con.id+'" target="_blank" >Go to Dupe Record</a>',false);
     
     }
   
   }
  
  
  }

}