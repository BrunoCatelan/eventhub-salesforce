@isTest
private class InscricaoTriggerTest {

    @isTest
    static void testInscricaoComVagasSucesso() {
        // 1. Criar o cenário de teste: Um evento com 1 vaga disponível
        Evento__c evento = new Evento__c(
            Name = 'Curso de Apex Test',
            Data_Hora_Inicio__c = DateTime.now().addDays(2),
            Local__c = 'Sala Virtual Zoom',
            Vagas_Maximas__c = 1
        );
        insert evento;

        // 2. Executar a ação: Criar a primeira inscrição (deve funcionar)
        Inscricao__c inscricao1 = new Inscricao__c(
            Evento__c = evento.Id
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(inscricao1, false);
        Test.stopTest();

        // 3. Validar o resultado (Asserts)
        System.assert(result.isSuccess(), 'A primeira inscrição deveria ter sido salva com sucesso.');
    }

    @isTest
    static void testInscricaoSemVagasFalha() {
        // 1. Criar o cenário de teste: Um evento com 1 vaga
        Evento__c evento = new Evento__c(
            Name = 'Workshop Lotado Test',
            Data_Hora_Inicio__c = DateTime.now().addDays(5),
            Local__c = 'Auditório Principal',
            Vagas_Maximas__c = 1
        );
        insert evento;

        // Inserir a primeira inscrição para esgotar as vagas
        Inscricao__c inscricao1 = new Inscricao__c(Evento__c = evento.Id);
        insert inscricao1;

        // 2. Executar a ação: Tentar inserir a SEGUNDA inscrição (deve falhar)
        Inscricao__c inscricao2 = new Inscricao__c(Evento__c = evento.Id);

        Test.startTest();
        Database.SaveResult result = Database.insert(inscricao2, false);
        Test.stopTest();

        // 3. Validar o resultado: A inserção não deve ter sucesso e deve conter o erro da trigger
        System.assertEquals(false, result.isSuccess(), 'A segunda inscrição deveria ter sido bloqueada.');
        System.assertEquals(1, result.getErrors().size(), 'Deveria haver exatamente um erro de validação.');
        System.assert(result.getErrors()[0].getMessage().contains('atingiu o limite máximo de vagas'), 
            'A mensagem de erro deveria ser a de falta de vagas.');
    }
}