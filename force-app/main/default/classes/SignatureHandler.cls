public class SignatureHandler {
    @AuraEnabled 
    public static void saveSign(String base64Data, String contentType) { 
        account acc = [SELECT Id FROM Account WHERE name='signaturepad' limit 1];
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');        
        Attachment a = new Attachment();
        a.parentId = acc.Id;
        a.Body = EncodingUtil.base64Decode(base64Data);        
        a.Name = 'Signature.png';
        a.ContentType = contentType;        
        insert a;        
    }
 }