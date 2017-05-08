/*
 * Author: Enrico Murru (http://enree.co, @enreeco)
 */
({
    /*
     * When the v.value field changes its value, the lookup is loaded again
     */
    rerender : function(component, helper){
        this.superRerender();
        //UPDATE: creates problems with LockerService: this feature has been removed
	//if value changes, triggers the loading method
        //if(helper.typeaheadOldValue[component.getGlobalId()] !== component.get('v.value')){
        //    helper.loadValue(component,true);
        //}
    }
})
