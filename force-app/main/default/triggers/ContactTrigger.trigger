trigger ContactTrigger on Contact (after insert, after update, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContactTriggerHandler.submitApprovalProcess(Trigger.new);
        }
        
        if (Trigger.isUpdate) {
            ContactTriggerHandler.updateAccountTotalContacts(Trigger.new, Trigger.oldMap);
        }

        if (Trigger.isDelete) {
            ContactTriggerHandler.updateAccountTotalContacts(Trigger.old);
        }
    }
}