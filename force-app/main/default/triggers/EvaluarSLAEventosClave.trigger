trigger EvaluarSLAEventosClave on Case (before insert, before update) {
    for (Case caso : Trigger.new) {
        
        List<CaseMilestone> eventosClave = [SELECT Id, CompletionDate, TargetDate FROM CaseMilestone WHERE CaseId = :caso.Id];
        
        Boolean alMenosUnoEnTiempo = false;
        
        for (CaseMilestone evento : eventosClave) {
            if (evento.CompletionDate <= evento.TargetDate) {
                alMenosUnoEnTiempo = true;
                break;
            }
        }
        
        caso.AMS_EstadoSLA__c = alMenosUnoEnTiempo ? 'Dentro de SLA' : 'Fuera de SLA';
    }
}