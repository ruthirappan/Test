public class AccountContact {

    
  public List<Account> getaccounts()
  {
      List<Account> accounts123 = [SELECT Id,Type,Owner.Name,(Select Id,FirstName,LastName,Email From Account.contacts), Name from Account];
      return accounts;
  }
}