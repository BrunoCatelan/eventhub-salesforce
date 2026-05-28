public with sharing class LeadTriggerHandler {
    
    public static void distribuirLeads(List<Lead> novosLeads) {
        
        // 1. Buscar a configuração do vendedor ativo
        List<Configuracao_Equipe__c> equipesAtivas = [
            SELECT Id, Vendedor__c 
            FROM Configuracao_Equipe__c 
            WHERE Ativo__c = true 
            ORDER BY Ultima_Atribuicao__c ASC NULLS FIRST 
            LIMIT 1
        ];
        
        // Se a lista estiver vazia, encerra para não travar o Salesforce
        if (equipesAtivas.isEmpty()) {
            return;
        }
        
        Configuracao_Equipe__c vendedorDaVez = equipesAtivas[0];
        
        // 2. Passar por cada novo Lead
        for (Lead ld : novosLeads) {
            // SÓ altera o proprietário se o Vendedor__c NÃO estiver nulo
            if (vendedorDaVez.Vendedor__c != null) {
                ld.OwnerId = vendedorDaVez.Vendedor__c;
            }
        }
        
        // 3. Atualizar a data/hora apenas se o vendedor for válido
        if (vendedorDaVez.Vendedor__c != null) {
            vendedorDaVez.Ultima_Atribuicao__c = System.now();
            update vendedorDaVez;
        }
    }
}