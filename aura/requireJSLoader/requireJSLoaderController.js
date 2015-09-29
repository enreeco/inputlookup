({
	/*
    	Sets up the RequireJS library (async load)
    */
    doInit : function(component, event, helper){
        
        if (typeof require !== "undefined") {
            var evt = $A.get("e.c:requireJSLoaded");
		    evt.fire();
        } else {
            var head = document.getElementsByTagName('head')[0];
            var script = document.createElement('script');
            
            script.src = component.get('v.src'); 
            script.type = 'text/javascript';
            script.key = component.get('v.src'); 
            script.helper = this;
            script.id = "script_" + component.getGlobalId();
            var hlp = helper;
            script.onload = function scriptLoaded(){
                var evt = $A.get("e.c:requireJSLoaded");
		        evt.fire();
            };
            head.appendChild(script);
        }
    },
})