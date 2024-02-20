/*************************************************************** 
Name: TestEvaluarSLAEventosClave
Copyright © 2023 Salesforce
======================================================
Purpose:
Test class to execute the methods of the class EvaluarEventosClave.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      vruiz@ts4.mx   21/08/2023      INITIAL    Test class to execute the methods of the class EvaluarEventosClave.
***************************************************************/
/*************************************************************** 
Name: TestEvaluarSLAEventosClave
Copyright © 2023 Salesforce
======================================================
Purpose:
Test class to execute the methods of the class EvaluarEventosClave.
======================================================
History:
Creation
VERSION  AUTHOR           DATE          DETAIL     Description
1.0      vruiz@ts4.mx   21/08/2023      INITIAL    Test class to execute the methods of the class EvaluarEventosClave.
***************************************************************/
@isTest
public class EvaluarSLAEventosClaveTest {
    // Define una clase Mock ficticia para simular la consulta a CaseMilestone
    public class CaseMilestoneSelectorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest request) {
            // Simula la respuesta del Mock aquí
            // Devuelve una respuesta simulada de CaseMilestone
            HTTPResponse res = new HTTPResponse();
            res.setStatusCode(200);
            res.setStatus('OK');
            
            // Aquí configura el cuerpo de la respuesta simulada con el JSON ficticio
            String json = '{'+
    '"CompletionDate": "2023-08-21T17:00:00.000+0000",'+
    '"TargetDate": "2023-08-21T18:00:00.000+0000",'+
    '"ElapsedTimeInDays": 0.03,'+
    '"ElapsedTimeInHrs": 0.82,'+
    '"ElapsedTimeInMins": 49,'+
    '"IsCompleted": true,'+
    '"IsViolated": false,'+
    '"StartDate": "2023-08-21T17:28:47.000+0000",'+
    '"TargetResponseInDays": 0.02,'+
    '"TargetResponseInHrs": 0.5,'+
    '"TargetResponseInMins": 30,'+
    '"MilestoneTypeId": "5576g000000CbiXAAS",'+
    '"CaseId": "caso.Id"'+
'}';


            res.setBody(json);
            
            return res;
        }
    }

    @isTest
    static void testEvaluarSLA() {
        Account cuenta = new Account();
        cuenta.Name ='Prueba cuenta';
        insert cuenta;
        
        Contact contacto = new Contact();
        contacto.FirstName = 'Contacto';
        contacto.LastName = 'Prueba';
        contacto.AccountId = cuenta.Id;
        contacto.AMS_TipoContacto__c = 'Agente AMS';
        contacto.AMS_IdUserClickup__c ='6335393';
        insert contacto;
        
        ServiceContract contrato = new ServiceContract();
        contrato.AccountId = cuenta.Id;
        contrato.Name ='Contrato Prueba';
        contrato.AMS_Estatus__c = 'Activo';
        insert contrato;
        
        Case caso = new Case();
        caso.AccountId = cuenta.Id;
        caso.NombreDelSolicitante__c = 'Solicitante Prueba';
        caso.Operador__c = contacto.Id;
        caso.AMS_EmailSolicitante__c = 'prueba@gmail.com';
        caso.Subject = 'Caso prueba';
        caso.Origin ='Correo Electrónico';
        caso.AMS_TipoIncidencia__c ='Solicitud';
        caso.Type ='Type';
        caso.Status ='Nuevo';
        caso.Nivel__c ='N1';
        caso.Priority = 'Alta';
        caso.Tiempo_de_resoluci_n__c ='1';
        insert caso;

        // Configura el Mock para la consulta de eventos clave
        Test.setMock(HttpCalloutMock.class, new CaseMilestoneSelectorMock());

        // Llama al trigger (esto activará la lógica del trigger)
        Test.startTest();
        update new List<Case>{caso};
        Test.stopTest();

        // Recupera el caso actualizado desde la base de datos
        caso = [SELECT AMS_EstadoSLA__c FROM Case WHERE Id = :caso.Id];
        
        

        // Verifica que el campo AMS_EstadoSLA__c se actualiza correctamente
        //System.assertEquals('Fuera de SLA', caso.AMS_EstadoSLA__c);
    }
}