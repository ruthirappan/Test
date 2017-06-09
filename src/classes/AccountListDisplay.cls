public class AccountListDisplay {

public list<Account> getAccount(){

   return [SELECT id,Name,Type FROM Account];


}



}