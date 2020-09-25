({
    sendmail : function(component, event, helper) {
        
        component.set("v.sendEmail", false); 
         let attid =component.get("v.attID"); 
         var action = component.get("c.sendEmail");
         let emailbody =component.get("v.body"); 
         let subject = component.get("v.subject"); 
         let emailadd = component.get("v.Emailadd"); 
         console.log(emailbody); console.log(subject); console.log(emailadd);
        action.setParams({
            "sigID": attid,
            "body"  :emailbody,
            "subject" : subject,
            "Emailadd" : emailadd
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {           
                var allValues = response.getReturnValue();
                component.set("v.QuoteLineItem", allValues);
                var QuoteLineItem = component.get("v.QuoteLineItem");
                 console.log(QuoteLineItem);
            }        	         
              else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
     component.set("v.attID","");  

    },
    
})