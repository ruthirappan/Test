public class accountinsert {

 List<Account> accountinsertList = new List<Account>();
 
  public List<Account> insertaccount (){
  
  for(integer i=0;i<10;i++){
  
   Account acc = new Account(Name='Test Account'+i,Type='Prospect');
   accountinsertList.add(acc);    
  
  }
  
  insert accountinsertList;
  return accountinsertList;
  
  }
 

}