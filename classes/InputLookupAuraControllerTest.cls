/*
 * Author: Enrico Murru (http://enree.co, @enreeco)
 */
@isTest
private class InputLookupAuraControllerTest {
    
    @testSetup
    private static void setup(){
        insert new Contact(LastName = 'Test1', FirstName = 'Name1');
        insert new Contact(LastName = 'Test2', FirstName = 'Name2');
        insert new Contact(LastName = 'Test3', FirstName = 'Name3');
    }
    
    private static testmethod void test_get_name(){
        List<Contact> contacts = [Select Id, LastName, FirstName, Name From Contact];
        
        Test.startTest();
        
        String ret = InputLookupAuraController.getCurrentValue(null, null);
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = InputLookupAuraController.getCurrentValue('INVALID_OBJECT', 'INVALID_ID');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = InputLookupAuraController.getCurrentValue('INVALID_OBJECT', '000000000000000');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = InputLookupAuraController.getCurrentValue('Contact', '000000000000000');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = InputLookupAuraController.getCurrentValue('Contact', contacts[0].Id);
        System.assert(ret == contacts[0].Name, 'Should return '+contacts[0].Name+ ' ['+ret+']');
            
        Test.stopTest();
    }
    
    private static testmethod void test_search(){
        List<Contact> contacts = [Select Id, LastName, FirstName, Name From Contact];
        Test.startTest();
        
        String ret = InputLookupAuraController.searchSObject(null, null);
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
       	ret = InputLookupAuraController.searchSObject('INVALID_OBJECT', 'NO_RESULT_SEARCH_STRING');
        System.assert(String.isBlank(ret), 'Should return null string ['+ret+']');
        
        ret = InputLookupAuraController.searchSObject('Contact', 'NO_RESULT_SEARCH_STRING');
        System.assert(String.isNotBlank(ret), 'Should return non null string ['+ret+']');
        List<InputLookupAuraController.SearchResult> sResList = (List<InputLookupAuraController.SearchResult>)JSON.deserialize(ret, 
			List<InputLookupAuraController.SearchResult>.class);
        System.assert(sResList.isEmpty(), 'Why not empty list? ['+sResList.size()+' instead]');
        
        Test.setFixedSearchResults(new List<String>{contacts[0].Id,contacts[1].Id,contacts[2].Id});
        ret = InputLookupAuraController.searchSObject('Contact', 'Test');
        System.assert(String.isNotBlank(ret), 'Should return a serialized list string ['+ret+']');
        sResList = (List<InputLookupAuraController.SearchResult>)JSON.deserialize(ret, 
			List<InputLookupAuraController.SearchResult>.class);
        System.assert(sResList.size() == 3, 'Why not 3 items found? ['+sResList.size()+' instead]');
        Test.stopTest();
    }
}