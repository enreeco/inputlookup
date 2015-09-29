@isTest
private class InputLookupControllerTest {
    
    /*
     * Initial test's dataset setup
     */
    @testsetup
    private static void initTestDataSet(){
        Contact cnt = new Contact(LastName = 'testLastName', FirstName = 'testFirstName');
        insert cnt;
    }
    
    /*
     * Tests initial input load
     */
    private static testmethod void unit_test_1(){
        Test.startTest();
        InputLookupController controller = new InputLookupController();
        
        //nothing passed
        String result = InputLookupController.getCurrentValue(null, null);
        System.assert(String.isBlank(result), 'Why an actual result? '+result);
        
        //only type passed: no ID expected to be loaded
        result = InputLookupController.getCurrentValue('Contact', null);
        System.assert(String.isBlank(result), 'Why an actual result? '+result);
        
        //wrong type
        Contact testContact = [Select Id, Name From Contact Limit 1];
        result = InputLookupController.getCurrentValue('ContactERROR', testContact.Id);
        System.assert(String.isBlank(result), 'Why an actual result? '+result);
        
        //wrong ID value
        result = InputLookupController.getCurrentValue('Contact', 'ERROR');
        System.assert(String.isBlank(result), 'Why an actual result? '+result);
        
        //found 1 result
        result = InputLookupController.getCurrentValue('Contact', testContact.Id);
        System.assert(result == testContact.Name, 'Why account name mismatch? '+result);
        
        //found 0 result
        delete testContact;
        result = InputLookupController.getCurrentValue('Contact', testContact.Id);
        System.assert(String.isBlank(result), 'Why an actual result? '+result);

        
        Test.stopTest();
    }
    
    /*
     * Tests search
     */
    private static testmethod void unit_test_2(){
        Test.startTest();
        Contact testContact = [Select Id, Name From Contact Limit 1];
        //https://www.salesforce.com/us/developer/docs/apexcode/Content/apex_testing_SOSL.htm
        Test.setFixedSearchResults(new List<ID>{testContact.Id});
        
        String result = InputLookupController.searchSObject(null, null);
        System.assert(String.isBlank(result), 'Why an actual result? '+result);
        
        //invalid sobject type
        result = InputLookupController.searchSObject('InvalidObject','test');
        System.assert(String.isBlank(result), 'Why an actual result? '+result);
        
        //found result
        result = InputLookupController.searchSObject('Contact', 'test');
        System.assert(String.isNotBlank(result),'Why null result?'); 
        List<InputLookupController.SearchResult> output = (List<InputLookupController.SearchResult>)JSON.deserialize(result, 
															List<InputLookupController.SearchResult>.class);
        System.assert(output.size()==1,'Why not 1 result? '+result);
        System.assert(output[0].value == testContact.Name, 'Contact name mismatch: '+result);
        Test.stopTest();
    }
}