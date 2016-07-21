<!--
 Author: Enrico Murru (http://enree.co, @enreeco)
 -->
<aura:application >

    <aura:attribute name="id" type="String" default="" access="GLOBAL"/>
	<aura:attribute name="objNew" type="Contact" default="{'sobjectType':'Contact',  
                                                       'Id':null}" />
	
    <div class="well">
        <div class="page-header">
          <h1>inputLookup <small>Example</small></h1>
        </div>
		
		<p>Search for an object or change the id on the textbox to watch the input load the new value</p>        
        
        <div class="panel panel-primary">
            <div class="panel-heading">Existent sobject</div>
            <div class="panel-body">
                <div class="form-horizontal" >
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Contact</label>
                        <div class="col-sm-8">
                            <c:InputLookup type="Contact"  
                                           value="{!v.id}"
                                           className="form-control "/>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-sm-2 control-label">Loaded contact Id</label>
                        <div class="col-sm-8 ">
                            <ui:inputText value="{!v.id}" 
                                          class="form-control"
                                          placeholder="Change id value"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="panel panel-primary">
            <div class="panel-heading">New sobject</div>
            <div class="panel-body">
                <div class="form-horizontal" >
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Contact</label>
                        <div class="col-sm-8">
                            <c:InputLookup type="{!v.objNew.sobjectType}"
                                           value="{!v.objNew.Id}"  
                                           className="form-control "/>
                        </div>
                    </div>
                    <div class="form-group has-feedback">
                        <label class="col-sm-2 control-label">New contact Id</label>
                        <div class="col-sm-8 ">
                            <ui:inputText value="{!v.objNew.Id}" 
                                          class="form-control"
                                          placeholder="Change id value"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</aura:application>