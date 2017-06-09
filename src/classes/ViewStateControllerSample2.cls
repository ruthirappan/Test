public with sharing class ViewStateControllerSample2 {

   public final Account account {get; set;}
   
   public List<Account> getaccounts(){
   
    return [SELECT id,Name,Type FROM Account ];
   
   }

   public ViewStateControllerSample2() {
         
         account = [select name from Account where id=:ApexPages.currentPage().getParameters().get('id')];

   }
   
    public PageReference save() {
        update account;
        return null;
    }
}