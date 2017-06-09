public  class MyController {
	
	public Account getAccount() {
		
		 return [select id,name,(select id,firstname, lastname,Email,Phone from Contacts limit 5) from Account where id = : System.currentPageReference().getParameters().get('id')];
		
		
		
	}

}