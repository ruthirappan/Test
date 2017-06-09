trigger Prevent_Duplicate_On_Contact on Contact (before insert, before update) {
	
	Map<String, Contact> ContactMap = new Map<String, Contact>();
	
	for(Contact Cont : system.Trigger.new){
		
 // Make sure we don't treat an email address that isn't changing during an update as a duplicate.so
 
    if ((Cont.Email != null) && (System.Trigger.isInsert || (Cont.Email !=System.Trigger.oldMap.get(Cont.Id).Email))) {
    
// Make sure another new Contact isn't also a duplicate so	
    
    if (ContactMap.containsKey(Cont.Email)) {
    	 	
    	 	Cont.Email.addError('Another new contact has the '+ 'same email address.');
    	
    		
    	} else {
    		
    		ContactMap.put(Cont.Email, Cont);
    		
    	} 
    	
 // Using a single database query, find all the Contacts in the database that have the same email address as any of the contacts being inserted or updated.so 
 
    for (Contact Conta : [SELECT Email FROM Contact WHERE Email IN :ContactMap.KeySet()]) {
    	
             Contact NewCont = ContactMap.get(Conta.Email);
             NewCont.Email.addError('A contact with this email '+'address already exists.');	
    		
    	}
    	
    	 
    	
    }
		
	}
	
	}