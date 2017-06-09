global class GlobalFunctions
{

    @future
    public static void updateUserLastLeadAssigned( Id UserId, Datetime LeadLastAssigned )
    {
        User u = [select Id, Lead_Last_Assigned__c from User where Id = :UserId];
        u.Lead_Last_Assigned__c = LeadLastAssigned;
        try
        {
            System.Debug( 'User: ' + u + '\nLast Lead Assigned: ' + LeadLastAssigned );
            update u;
            System.Debug( '\n\nUser Updated\n' );
            
        }
        catch (DmlException de)
        {
            for ( integer i = 0; i < de.getNumDml(); i++ )
            {
                System.debug( u );
                System.debug('Error Updating user: ' + de.getDmlMessage(i));
                //System.assert( false, de.getDmlMessage(i));
            }   
        }
    }


}