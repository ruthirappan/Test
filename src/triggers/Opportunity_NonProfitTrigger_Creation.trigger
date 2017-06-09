trigger Opportunity_NonProfitTrigger_Creation on Account (after insert) {
    
    for(Account Acc :trigger.new) {
        
        if (Acc.Type == 'Prospect') {
             
            Opportunity Opp = new Opportunity(); 
            Opp.Name = 'Staffing Partner';
            Opp.StageName = 'Prospecting' ;
            Opp.CloseDate = Date.today().addDays(30);
            Opp.AccountId = Acc.Id;
            
        if (Acc.Industry == 'Technology')  {
            
            Opp.Amount = 15000;          
            
            
        }  else if(Acc.Industry == 'Not For Profit') {
            
            Opp.Amount = 7000;
            
        } else {
            
            Opp.Amount = 10000;
        }
        
        Integer BigCompanyMultiplerComplex = 2;
        
        if(Acc.NumberOfEmployees > 1000)    {
            
            Opp.Amount = Opp.Amount * BigCompanyMultiplerComplex ;
            
        }
        
        Insert Opp;
            
            
        }
            
        
    }

}