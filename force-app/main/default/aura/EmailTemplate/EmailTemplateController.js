({
    doInit : function(component, event, helper) {
        var action = component.get("c.getEmailTemplate");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let resp =response.getReturnValue() ;
                let lables= [] ; 
                resp.forEach(function(key) {
                    lables.push({"label":key.DeveloperName ,"value":key.DeveloperName});
                });
               
                component.set("v.options", lables);
                component.set("v.templatedata", resp);
                
            }
            
        })
        
        $A.enqueueAction(action);
        
    },
    
    handleChange: function(component, event, helper){
           let tempdata = component.get("v.templatedata");
           let selectedtemp= component.find("combobox").get("v.value"); 
           let data ="";
         tempdata.forEach(function(key) {
               if(key.DeveloperName== selectedtemp)
               {
                   data=key.Body;
               }
                });
          component.set("v.body", data);
         component.set("v.isOpen", true);
    },
    
 
   closeModel: function(component, event, helper) {
      component.set("v.isOpen", false);
      component.set("v.sendEmail", false);        
   },
    
    ShowSendEmail: function(component, event, helper) {
      component.set("v.isOpen", false);   
      component.set("v.sendEmail", true); 
    },
    Back: function(component, event, helper) {
      component.set("v.isOpen", true);   
      component.set("v.sendEmail", false); 
    },
    handleComponentEvent: function(component, event, helper) {
      var message = event.getParam("message");
       console.log(message);
      component.set("v.attID", message);   
     
    },
    sendEmailout: function(component, event, helper) {
        helper.sendmail(component, event, helper);
    },
    
})