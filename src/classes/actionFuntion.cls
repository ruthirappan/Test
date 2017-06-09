public class actionFuntion {

 public Account accObj {get;set;}
 PageReference prf= null;

 public actionFuntion(){
   accObj = new Account();
  }
  
 public pageReference saveRec() {
  if(accObj.Name!=null){
     
    insert accObj;
  }
  else
    {
      ApexPages.Message Mymessage = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter the Account Name.');
      ApexPages.addMessage(Mymessage);
    }
  if(accObj.id!=NULL){
   
    prf = new PageReference('/'+accObj.id);
    prf.setRedirect(true);
    }
    return prf;
   } 

}