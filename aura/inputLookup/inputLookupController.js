/*
 * Author: Enrico Murru (http://enree.co, @enreeco)
 */
({
    
    /*
     * Executes the search server-side action when the c:InputLookupEvt is thrown
     */
    handleInputLookupEvt: function(component, event, helper){
		helper.searchAction(component, event.getParam('searchString')); 
    },
    
    /*
    	Loads the typeahead component after JS libraries are loaded
    */
    initTypeahead : function(component, event, helper){
        //first load the current value of the lookup field and then
        //creates the typeahead component
        helper.loadFirstValue(component);
    }
})