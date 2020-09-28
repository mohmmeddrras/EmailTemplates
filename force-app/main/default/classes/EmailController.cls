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
     
        string attachmentId=sigID;
        PageReference pageReference2 = new PageReference('/apex/ImageToPDF?FileId='+attachmentId+'&data='+body);
        fetchContentDataFromPage(pageReference2.getUrl(),subject,Emailadd);
        }
        
          if(sigID =='')
          {
               //Apex Single email message
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           mail.setUseSignature(false);
           mail.setToAddresses(new String[] { Emailadd });//Set To Email Address
           mail.setSubject(subject);//Set Subject
           mail.setHtmlBody(body);//Set HTML Body
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });//Send Email
              
          }
         
           
    }
    
    @Future(Callout=true)
public static void fetchContentDataFromPage(String pageURL,String subject, String emailadd){
 
     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('data.pdf');
    attach.setInline(false);
    attach.setBody(new PageReference(pageURL).getContent());
    email.setSubject(subject);
    List<String> lStrings = new List<String>();
    lStrings.add(emailadd);
    email.setToAddresses(lStrings);
    email.setPlainTextBody('Thank You .');
    email.setFileAttachments(new Messaging.EmailFileAttachment[]{
            attach
    });
    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
            email
    });
}
    
}