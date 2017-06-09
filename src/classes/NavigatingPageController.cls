public class NavigatingPageController {
  Account account;
  
  public Account getAccount() {
     if( account == null ) account = new Account();
     return account;
  } 
  
  public PageReference save() {
       // Add the Account to the Database.
        insert account;
       // Send the user to the detail page for the new account.
       PageReference acctPage = new ApexPages.StandardController(account).view();
       acctPage.setRedirect(true);
       return acctPage;
  }  
}