public class EmailController {
    @AuraEnabled 
    public static List<EmailTemplate> getEmailTemplate(){
        return [SELECT Id,Body,DeveloperName FROM EmailTemplate];
    }
    @AuraEnabled 
    public static void sendEmail(string body,string subject,string Emailadd,string sigID){
        
         Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        if(sigID !='')
        {
        Attachment doc =[SELECT Id,ContentType,Body,Name FROM Attachment WHERE Id =: sigID];
 
     //Create Email file attachment from document
        
         attach.setContentType(doc.ContentType);
         attach.setFileName(doc.Name);
         attach.setInline(false);
         attach.Body = doc.Body;
        }
           //Apex Single email message
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           mail.setUseSignature(false);
           mail.setToAddresses(new String[] { Emailadd });//Set To Email Address
           mail.setSubject(subject);//Set Subject
           mail.setHtmlBody(body);//Set HTML Body
        if(sigID !=''){
           mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });//Set File Attachment
        }
         
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });//Send Email
    }
}