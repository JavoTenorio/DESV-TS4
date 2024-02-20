trigger CaseUpdateTrigger on Case (after update) {
    List<Id> caseIds = new List<Id>();
    
    for (Case updatedCase : Trigger.new) {
        if (Trigger.oldMap.get(updatedCase.Id).AMS_EstadoSLA__c != updatedCase.AMS_EstadoSLA__c) {
            // Only include cases where the AMS_EstadoSLA__c field was changed
            caseIds.add(updatedCase.Id);
        }
    }
    
    if (!caseIds.isEmpty()) {
        SLAUtils.updateSLAStatus(caseIds);
    }
}