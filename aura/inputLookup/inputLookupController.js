/*
 * Author: Enrico Murru (http://enree.co, @enreeco)
 */
({
    /*
        Verify component has been loaded with the required params
    */
    setup : function(component, event, helper){
        if(!component.get('v.type') ){
            $A.error("inputLookup component requires a valid SObject type as input: ["+component.getGlobalid()+"]");
            return;
        }
    },
    
    /*
        When RequireJS is loaded, loads the typeahead component
    */
    initTypeahead : function(component, event, helper){
        //first load the current value of the lookup field and then
        //creates the typeahead component
        helper.loadFirstValue(component);
    }
})