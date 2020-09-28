public class SignatureCtr{
    
    @AuraEnabled
    public static String saveSignature(String signatureBody,string emaildata){
       
        system.debug(emaildata);
        Blob myBlob = EncodingUtil.base64Decode(signatureBody);
        Attachment a = new Attachment();
         account acc = [SELECT Id FROM Account WHERE name='signaturepad' limit 1];
        a.ParentId = acc.id; 
        a.Body = myBlob;
        a.ContentType = 'image/png';
        a.Name = 'Signature Capture.png';
        insert a;
        return a.id;
    }
    

}