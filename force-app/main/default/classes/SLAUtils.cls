public class SLAUtils {
    public static void updateSLAStatus(List<Id> caseIds) {
        List<Case> casesToUpdate = new List<Case>();
        
        for (Id caseId : caseIds) {
            Boolean allEventsViolated = true;
            
            // Query all CaseMilestones for the current case
            List<CaseMilestone> caseMilestones = [SELECT Id, completionDate, MilestoneType.Name, isViolated
                                                  FROM CaseMilestone
                                                  WHERE CaseId = :caseId];
            
            for (CaseMilestone cm : caseMilestones) {
                if (!cm.isViolated) {
                    allEventsViolated = false;
                    break; // No need to check further if one event is completed in time
                }
            }
            
            Case updatedCase = new Case(Id = caseId);
            if (!allEventsViolated) {
                updatedCase.AMS_EstadoSLA__c = 'Dentro de SLA';
            } else {
                updatedCase.AMS_EstadoSLA__c = 'Fuera del SLA';
            }
            
            casesToUpdate.add(updatedCase);
        }
        
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }
}