/*************************************************************** 
Name: EvaluarSLAEventosClave
Copyright © 2023 Salesforce
======================================================
Purpose:
This class encapsulates the logic to determine whether all specified milestones have been violated, 
facilitating efficient decision-making processes.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      vruiz@ts4.mx     21/08/2023    INITIAL    
***************************************************************/
public with sharing class EventoClaveServiceImp {
    public static Boolean todosConInfraccion(List<CaseMilestone> eventosClave) {
        for (CaseMilestone evento : eventosClave) {
            if (!evento.IsViolated) {
                return false;
            }
        }
        return true;
    }
}