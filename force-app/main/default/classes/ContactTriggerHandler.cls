public with sharing class ContactTriggerHandler {

    /*
    * Make a approval process for contact which have account
    */
    public static void submitApprovalProcess(List<Contact> contacts) {
        List<User> listUser = [SELECT id FROM User WHERE profile.name = 'System Administrator' LIMIT 1];
        if (!listUser.isEmpty()) {
            for (Contact contact : contacts) {
                if (contact.AccountId != null) {
                    Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
                    approvalRequest.setObjectId(contact.Id);
                    approvalRequest.setNextApproverIds(new List<ID>{listUser[0].id});
                    Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
                }
            }
        }
    }

    /*
    * Update Account TotalContacts__c of contact when update
    */
    public static void updateAccountTotalContacts(List<Contact> newContacts, Map<Id, Contact> mapOldContact) {
        // Find account which need to update
        Set<Id> setAccountId = new Set<Id>();
        for(Contact contact : newContacts) {
            if (contact.AccountId != null && mapOldContact.get(contact.Id).Active__c != contact.Active__c) {
                setAccountId.add(contact.AccountId);
            }
        }
        // Update account contact
        if(!setAccountId.isEmpty()) {
            updateAccountTotalContactByAccountIds(setAccountId);
        }
    }

    /*
    * Update Account TotalContacts__c of contact when delete
    */
    public static void updateAccountTotalContacts(List<Contact> contacts) {
        // Find account which need to update
        Set<Id> setAccountId = new Set<Id>();
        for(Contact contact : contacts) {
            if (contact.AccountId != null && contact.Active__c == true) {
                setAccountId.add(contact.AccountId);
            }
        }
        // Update account contact
        if(!setAccountId.isEmpty()) {
            updateAccountTotalContactByAccountIds(setAccountId);
        }
    }

    /*
    * Update Account TotalContacts__c of contact by using account id
    */
    public static void updateAccountTotalContactByAccountIds(Set<Id> setAccountId) {
        List<Account> listUpdateAccount = [
            SELECT Id, TotalContacts__c, (SELECT Id FROM Account.Contacts WHERE Active__c = TRUE) 
            FROM Account WHERE Id IN :setAccountId
        ];

        if (!listUpdateAccount.isEmpty()) {
            for(Account account : listUpdateAccount) {
                account.TotalContacts__c = account.Contacts.size();
            }
            UPDATE listUpdateAccount;
        }
    }

}
