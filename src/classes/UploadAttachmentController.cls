Public class UploadAttachmentController {

  public String selectedType{get;set;}
  public String description{get;set;}
  private Account account{get;set;}
  public String fileName{get;set;}
  public Blob fileBody{get;set;}
  
  public UploadAttachmentController (ApexPages.StandardController controller){
  
          this.account = (Account)controller.getRecord();
    
  }
  
  // creates a new Contact_Attachment__c record
  private Database.SaveResult saveCustomAttachment(){
  
  Account_Attachment__c obj = new Account_Attachment__c();
   obj.Account__c = account.id;
   obj.Description__c =description;  
   obj.Type__c = selectedType;
   obj.Name = fileName;
   
   return Database.insert(obj);
  
  }
  
  // create an actual Attachment record with the Contact_Attachment__c as parent
  private Database.SaveResult saveStandardAttachment(Id parentId){
    
    Database.SaveResult result;
    
    Attachment attachment = new Attachment();
    attachment.body = this.fileBody;
    attachment.name = this.fileName; 
    attachment.parentId = parentId;
    
    // inser the attachment
    result = Database.insert(attachment);
   
    // reset the file for the view state
    fileBody = Blob.Valueof('');
    return result;  
  
  }
  
    /**
    * Upload process is:
    *  1. Insert new Account_Attachment__c record
    *  2. Insert new Attachment with the new Account_Attachment__c record as parent
    *  3. Update the Account_Attachment__c record with the ID of the new Attachment
    **/
    
    public PageReference processUpload(){
    
    try{
    Database.SaveResult customAttachmentResult = saveCustomAttachment();
       if(customAttachmentResult == null || !customAttachmentResult.isSuccess()){
          ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Could not save Attachment. '));
           return null;
      }
      
      Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());
      
      if(attachmentResult == null || !attachmentResult.isSuccess()){
         ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ' Could not save Attachment. '));
         return null;
     } else {
      // update the custom attachment record with some attachment info
                Account_Attachment__c customAttachment = [select id from Account_Attachment__c where id = :customAttachmentResult.getId()];
                customAttachment.name = this.fileName;
                customAttachment.Attachment__c = attachmentResult.getId();
                update customAttachment;
            }
        
        } catch (Exception e) {
            ApexPages.AddMessages(e);
            return null;
        }
    
        return new PageReference('/'+account.Id);
    
    }
    
    public PageReference back() {
        return new PageReference('/'+account.Id);
    }     
    
    
  
}