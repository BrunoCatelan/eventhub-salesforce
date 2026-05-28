trigger LeadTrigger on Lead (before insert) {
    // Quando novos Leads estiverem prestes a ser inseridos (before insert)...
    if (Trigger.isBefore && Trigger.isInsert) {
        // ...nós chamamos a nossa classe e entregamos a lista de novos Leads para ela
        LeadTriggerHandler.distribuirLeads(Trigger.new);
    }
}