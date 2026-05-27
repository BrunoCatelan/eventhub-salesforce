trigger InscricaoTrigger on Inscricao__c (before insert) {
    // 1. Coletar os IDs dos Eventos relacionados às novas inscrições
    Set<Id> eventoIds = new Set<Id>();
    for (Inscricao__c inscricao : Trigger.new) {
        if (inscricao.Evento__c != null) {
            eventoIds.add(inscricao.Evento__c);
        }
    }

    // 2. Buscar as informações de vagas dos Eventos no banco de dados
    Map<Id, Evento__c> eventosMap = new Map<Id, Evento__c>([
        SELECT Id, Vagas_Maximas__c, Total_Inscritos__c 
        FROM Evento__c 
        WHERE Id IN :eventoIds
    ]);

    // 3. Validar se o evento possui vagas disponíveis antes de salvar a inscrição
    for (Inscricao__c inscricao : Trigger.new) {
        Evento__c evento = eventosMap.get(inscricao.Evento__c);
        
        if (evento != null) {
            // Se o total atual já for igual ou maior que o máximo permitido, barramos
            if (evento.Total_Inscritos__c >= evento.Vagas_Maximas__c) {
                inscricao.addError('Não é possível realizar a inscrição. Este evento já atingiu o limite máximo de vagas.');
            }
        }
    }
}