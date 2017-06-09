trigger CreateCase_On_everyAccount_Inserted on Account (after insert) {
	for (Account Acc : trigger.new){
		Case Issue = new Case ();
		
		Issue.Status = 'Working';
		Issue.Origin = 'Web';
		Issue.Subject = 'New Issue';
		Issue.Priority = 'HIgh';
		Issue.AccountId = Acc.Id;
		Insert Issue;
		
		
	}
	
}