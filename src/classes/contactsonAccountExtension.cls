public class contactsonAccountExtension {

 private final Account acct;
 public Integer sum{get;set;}
 
  public contactsonAccountExtension(ApexPages.standardController stdController){
  
      this.acct = (Account)stdController.getRecord();
      sum = [SELECT count()FROM Contact WHERE AccountId =:acct.Id];
 
 }  


}