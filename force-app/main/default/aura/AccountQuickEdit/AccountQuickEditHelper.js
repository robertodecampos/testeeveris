({
    closeQuickAction : function() {
        $A.get("e.force:closeQuickAction").fire();
    },

    showToast : function(type, title, body) {
        var toastEvent = $A.get("e.force:showToast");

        toastEvent.setParams({
            "title": title,
            "message": body,
            "type": type,
            "duration": 5000
        });

        toastEvent.fire();
    }
})
