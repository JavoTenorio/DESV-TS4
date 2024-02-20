({
    init: function(component, event, helper) {
        // Llamar al método del controlador Apex para cargar los casos
        helper.loadCases(component);
    },

    previousPage: function(component, event, helper) {
        // Retroceder a la página anterior
        var pageNumber = component.get("v.pageNumber");
        if (pageNumber > 0) {
            component.set("v.pageNumber", pageNumber - 1);
            helper.loadCases(component);
        }
    },

    nextPage: function(component, event, helper) {
        // Avanzar a la página siguiente
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber + 1);
        helper.loadCases(component);
    }
})