({
    handleLoad : function(component, event, helper) {
        component.set('v.showSpinner', false);
    },

    handleSubmit : function(component, event, helper) {
        component.set('v.showSpinner', true);
    },

    handleSuccess : function(component, event, helper) {
        component.set('v.showSpinner', false);
        helper.closeQuickAction();
        helper.showToast('success', 'Sucesso', 'Conta alterada com sucesso');
    },

    handleError : function(component, event, helper) {
        component.set('v.showSpinner', false);
    }
})
