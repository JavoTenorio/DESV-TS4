public class ReactivarTiempoCasos implements Schedulable {
    public void execute(SchedulableContext ctx) {
        
        Datetime dt = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        String dayOfWeek = dt.format('EEEE');

        // Verifica si hoy es domingo
        if (dayOfWeek == 'Sunday') {
            // No reactivar los casos en nivel N3
            List<Case> casosAReactivar = [SELECT Id, Nivel__c FROM Case WHERE IsClosed = false AND Nivel__c != 'N3'];

            for (Case caso : casosAReactivar) {
                caso.IsStopped = false;
            }

            if (!casosAReactivar.isEmpty()) {
                update casosAReactivar;
            }
        } else {
           
            List<Case> casosAReactivar = [SELECT Id FROM Case WHERE IsClosed = false];

            for (Case caso : casosAReactivar) {
                caso.IsStopped = false;
            }

            if (!casosAReactivar.isEmpty()) {
                update casosAReactivar;
            }
        }
    }
}