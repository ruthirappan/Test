@isTest 

public class TestClass_CreateCase_On_everyAccount  {

static testMethod void Insert_New_Account (){

Account Acc = new Account();
Acc.Name = 'HP';
Acc.Type = 'Prospect';
Acc.NumberOfEmployees = 2000;
insert Acc;




}

}