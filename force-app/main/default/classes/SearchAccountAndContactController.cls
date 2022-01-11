public with sharing class SearchAccountAndContactController {

    public String searchKey {get;set;}

    public List<ResultWrapper> searchResults {get; set;}

    public class ResultWrapper {
        public String id {get; set;}
        public String name {get; set;}
        public String sobjectName {get; set;}
        public String link {get; set;}
 
        public ResultWrapper(SObject record, String sobjectName) {
            this.id = (String) record.get('Id');
            this.name = (String) record.get('Name');
            this.sobjectName = sobjectName;
            this.link = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + (String) record.get('Id');
        }
    }

    public SearchAccountAndContactController() {}

    /**
     * Search Accounts and Contacts
     */
    public void search(){
        this.searchResults = new List<ResultWrapper>();

        if (searchKey.length() < 2) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Search key must more than one characters'));
            return;
        }

        List<List<SObject>> searchList = [
            FIND :searchKey IN NAME FIELDS RETURNING Account(Id, Name), Contact(Id, Name)
        ];

        Account[] searchAccounts = (Account[]) searchList[0];
        Contact[] searchContacts = (Contact[]) searchList[1];

        
        for (Account account : searchAccounts) {
            this.searchResults.add(new ResultWrapper(account, SObjectType.Account.getLabel()));
        }

        for (Contact contact : searchContacts) {
            this.searchResults.add(new ResultWrapper(contact, SObjectType.Contact.getLabel()));
        }
    }

}
