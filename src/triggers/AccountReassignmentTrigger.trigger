trigger AccountReassignmentTrigger on Account (before insert, after insert,before update) {
  
  // Initialize all the data required
  List< String > AccountAssignmentProfileList = new List< String >();
  AccountAssignmentProfileList.add('Sales Profile');
  
  List< User > AssignAccounts = [select Id, Name, Lead_Last_Assigned__c from user where isactive = true and profile.name in :AccountAssignmentProfileList and Do_Not_Assign_Ownership__c = false order by Name];
  Boolean isValidLeadOwner = false;
  
  // Iterate through each lead being either inserted
  if ( Trigger.isInsert )
  {
   if( Trigger.isBefore )
    {
     for(Account a_New: Trigger.new)
     {
           // Execute all before logic here  as below
           
           /* Check tos ee that the Lead isn't already assigned to a valid lead owner (a user from the AssignLeads list)
             Scenarios :
          1) User has no Daily Assigned Leads - needs to match the Daily Assigned Leads value as everyone else (lowest value currently for the day), or starts at 0
          2) The current Date and the last modified date are different - means that this is a new day, they get processed first, and their daily assigned lead count resets to 0
          3) If 1) and 2) are not applicable, then assign the lead to the user with the lowest daily assigned lead count, and increment their daily assigned lead count by 1
         */
         User nextAssignedLeadOwner;
         for( User u : AssignAccounts )
         {
          // If valid lead then set isValidLeadOwner to true
          // We can break out of here because we won't be reassigning this lead
          if ( u.Id == a_New.Ownerid ) 
          {
            isValidLeadOwner = true;
            break;
          }     
 
         }
  
        if(isValidLeadOwner = false)
        {
         for( User u : AssignAccounts )
         {
          // Determine the next user to be assigned leads
    
          //  Check to see whether the user had any assigned leads at all
         if ( u.Lead_Last_Assigned__c == null )
         {
          nextAssignedLeadOwner = u;
          break;
         }
         // For now check to see who has been the last person to be assigned a lead
         // Initialize the first potential owner and do subsequent datetime comparisons
         if ( nextAssignedLeadOwner == null ) nextAssignedLeadOwner = u;
                            
         // After the FOR loop completes, we should have the next owner set
         if ( u.Lead_Last_Assigned__c < nextAssignedLeadOwner.Lead_Last_Assigned__c ) nextAssignedLeadOwner = u;
        }
        if ( isValidLeadOwner == false ) 
         {
                            
           a_new.OwnerId = nextAssignedLeadOwner.Id;
                            
           nextAssignedLeadOwner.Lead_Last_Assigned__c = DateTime.now();
                            
           // Update the lead owner with its new Daily Assigned Lead value
           GlobalFunctions.updateUserLastLeadAssigned(a_New.OwnerId, DateTime.now());
           
            try
             {
              System.Debug( 'Next Assigned Owner:\n' +nextAssignedLeadOwner + '\nAssignLeadList:\n' + AssignAccounts );
              update nextAssignedLeadOwner;
              System.Debug( '\n\nnextAssignedLeadOwner UPDATE\n' );
                                
              }
              catch (DmlException de)
              {
               for ( integer i = 0; i < de.getNumDml(); i++ )
               {
                 System.debug( nextAssignedLeadOwner );
                 System.debug('Error Updating nextAssignedLeadOwner: ' + de.getDmlMessage(i));
                 System.assert( false, de.getDmlMessage(i));
                }   
               }
                            
                            
        }
  
       } 
     
      }
    
     }
   
  }
  
  
  
 
}