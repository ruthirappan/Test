trigger application1Update on Application_2__c (after insert,after Update) {

 Set<id> app1ID = new Set<id>();
 List<Application__c > app1ToUpdate = new List<Application__c >();
 
 for(Application_2__c app2 : trigger.new){
  if(app2.Application1__c!=NULL){
   
   app1ID.add(app2.Application1__c);
   
   }
  }
  
  List<Application__c> application1 = [SELECT id,Check__c,Type_of_Application__c,(SELECT id,Check__c FROM Applications_2__r) FROM Application__c WHERE id IN:app1ID];
  
  for(Application_2__c app2 : trigger.new ){
   for(Application__c app1 :application1)  {
    if(app1.Applications_2__r!=NULL){
    
       app1.check__c = app2.check__c; 
       app1ToUpdate.add(app1);
    
    
      }
     }
   }
    update app1ToUpdate;
 }