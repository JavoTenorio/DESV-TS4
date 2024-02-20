@isTest
public class ReactivarTiempoCasosTest {
    @isTest
    static void testReactivarTiempoCasos() {
      
        Account accountContract = new Account();
        accountContract.Name  = 'Soriana';
        insert accountContract;
        
        Contact contactAMSContract = new Contact();
        contactAMSContract.LastName = 'Manuel Gonzalez';
        contactAMSContract.AccountId = accountContract.Id;
        contactAMSContract.AMS_TipoContacto__c = 'Agente AMS';
        contactAMSContract.AMS_IdUserClickup__c='12345';
        insert contactAMSContract;
        
        Date fechaInicio = Date.newInstance(2023, 04, 01);
        Date fechaFinalizacion = Date.newInstance(2023, 12, 31);
        
        ServiceContract contract = new ServiceContract();
        contract.Name= '1234';
        contract.AccountId= accountContract.Id;
        contract.StartDate = fechaInicio;
        contract.EndDate= fechaFinalizacion;
        contract.AMS_Estatus__c = 'Activo';
        insert contract;
        
        Case cseContract = new Case();
        cseContract.AccountId = accountContract.Id;
        cseContract.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract.Subject = 'Caso test contrato servicio';
        cseContract.Operador__c = contactAMSContract.Id;
        cseContract.Origin = 'Correo electrónico';
        cseContract.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract.Status = 'En proceso';
        cseContract.Nivel__c = 'N2';
        cseContract.Priority = 'Baja';
        cseContract.Tiempo_de_resoluci_n__c = '3';
        cseContract.Tiempo_Real__c= 4;
        cseContract.SlaStartDate =System.now();
        
        Case cseContract2 = new Case();
        cseContract2.AccountId = accountContract.Id;
        cseContract2.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract2.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract2.Subject = 'Caso test contrato servicio';
        cseContract2.Operador__c = contactAMSContract.Id;
        cseContract2.Origin = 'Correo electrónico';
        cseContract2.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract2.Status = 'Nuevo';
        cseContract2.Nivel__c = 'N3';
        cseContract2.Priority = 'Baja';
        cseContract2.Tiempo_de_resoluci_n__c = '3';
        cseContract2.Tiempo_Real__c= 4;
        cseContract2.SlaStartDate =System.now();
        
        Case cseContract3 = new Case();
        cseContract3.AccountId = accountContract.Id;
        cseContract3.NombreDelSolicitante__c  = 'Elizabeth';
        cseContract3.AMS_EmailSolicitante__c = 'eortega@ts4.mx';
        cseContract3.Subject = 'Caso test contrato servicio';
        cseContract3.Operador__c = contactAMSContract.Id;
        cseContract3.Origin = 'Correo electrónico';
        cseContract3.AMS_TipoIncidencia__c = 'Incidencia';
        cseContract3.Status = 'En Proceso';
        cseContract3.Nivel__c = 'N3	';
        cseContract3.Priority = 'Baja';
        cseContract3.Tiempo_de_resoluci_n__c = '3';
        cseContract3.Tiempo_Real__c= 4;
        cseContract3.IsStopped = true;
        cseContract3.SlaStartDate = System.now();
        
        
        
        insert new List<Case>{cseContract, cseContract2, cseContract3};
       
        AMS_ClickupIntegration datos = new AMS_ClickupIntegration();
        datos.Name = cseContract.Subject;
        String body = JSON.serialize(datos);
        
        Test.setMock(HttpCalloutMock.class, new AMS_Mock(201,'Ok',body,null));
        
        
		Test.startTest();
        String jobID = System.schedule('ReactivarCasosJob', '0 0 * * 7 ?', new ReactivarTiempoCasos());

        Test.stopTest();

        // Verificar que el caso que no está cerrado y es domingo se haya reactivado
        cseContract = [SELECT IsStopped FROM Case WHERE Id = :cseContract2.Id];
        System.assertEquals(false, cseContract2.IsStopped, 'El caso de domingo debería haber sido reactivado.');

        // Verificar que el caso que no está cerrado y no es domingo no se haya reactivado
        cseContract2 = [SELECT IsStopped FROM Case WHERE Id = :cseContract.Id];
        System.assertEquals(false, cseContract.IsStopped, 'El caso no debería haber sido reactivado.');

        // Verificar que el caso cerrado no se haya reactivado
        cseContract3 = [SELECT IsStopped FROM Case WHERE Id = :cseContract3.Id];
        System.assertEquals(true, cseContract3.IsStopped, 'El caso cerrado no debería haber sido reactivado.');
    }
    
    
}