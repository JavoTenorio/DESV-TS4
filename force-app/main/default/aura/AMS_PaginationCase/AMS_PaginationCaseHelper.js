({
    loadCases: function(component) {
        var pageNumber = component.get("v.pageNumber");

        var action = component.get("c.getCases");
        action.setParams({ "pageNumber": pageNumber });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cases", response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    }
})