public class ClickupIntegrationQueueable implements Queueable {
    private String method;
    private String body;
    private String apiUrl;
    
    public ClickupIntegrationQueueable(String method, String body, String apiUrl) {
        this.method = method;
        this.body = body;
        this.apiUrl = apiUrl;
    }
    public void execute(QueueableContext context) {
        HttpResponse response = AMS_ClickupIntegration.getResponse(method, body, apiUrl);
        // Procesar la respuesta si es necesario
    }
}