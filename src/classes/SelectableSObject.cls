public with sharing class SelectableSObject {
	
	private SObject record;
	public Boolean selected {get; set;}
	
	// Universal constructor for any SalesForce object type
	public SelectableSObject(SObject obj)
	{
		record = obj;
		selected = false;
		
	}
	
	// Getter for Asset
	public Asset getAsset()
	{
		return (Asset)record;
		
	}
	
	 // Getter for Contact
	 public Contact getContact()
	 {
	 	return (Contact)record;
	 	
	 }
	 
	
	 
	
	

}