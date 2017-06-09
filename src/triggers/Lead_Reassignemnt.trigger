trigger Lead_Reassignemnt on Lead (after insert, before insert, before update) {
	List< String > LeadAssignmentProfile = new List < String >();
	LeadAssignmentProfile.add('System Administrator');
	LeadAssignmentProfile.add('Sales Profile');
	
	List < User > AssignLeads = [select Id, Name from user where isactive = true and profile.name in :LeadAssignmentProfile];
	
	List < Task > NewTasks = new List < Task >();
	List < Task > UpdateTasks = new List < Task >();
	
	

}