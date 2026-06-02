public with sharing class FinTrackService {
    
    // Wrapper class para definir as variáveis de entrada que o Flow vai enviar
    public class CotacaoRequest {
        @InvocableVariable(label='Código da Moeda (Ex: USD, EUR)' required=true)
        public String codigoMoeda;
    }

    // Wrapper class para definir as variáveis de retorno que o Flow vai receber
    public class CotacaoResponse {
        @InvocableVariable(label='Valor da Cotação Convertida')
        public Decimal valorCotacao;
    }

    /**
     * Método invocado pelo Salesforce Flow para obter cotações em massa
     */
    @InvocableMethod(label='FinTrack: Obter Cotação de Moeda' description='Busca a cotação simulada ou real de uma moeda estrangeira para o EventHub.')
    public static List<CotacaoResponse> obterCotacaoParaFlow(List<CotacaoRequest> pedidos) {
        List<CotacaoResponse> respostas = new List<CotacaoResponse>();
        
        // Processa cada pedido enviado pelo Flow
        for (CotacaoRequest pedido : pedidos) {
            CotacaoResponse res = new CotacaoResponse();
            
            // Reutiliza o método obterCotacao que já testamos e validamos!
            res.valorCotacao = obterCotacao(pedido.codigoMoeda);
            
            respostas.add(res);
        }
        
        return respostas;
    }
    
    /**
     * Método original (com o nosso Mock ativo)
     */
    public static Decimal obterCotacao(String codigoMoeda) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        String endpoint = 'callout:AwesomeAPI/json/last/' + codigoMoeda + '-BRL';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        
        try {
            // Mock temporário ativo para evitar o erro 429
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setStatus('OK');
            response.setBody('{"USDBRL":{"bid":"5.25"},"EURBRL":{"bid":"5.70"},"GBPBRL":{"bid":"7.10"}}');
            
            if (response.getStatusCode() == 200) {
                String jsonBody = response.getBody();
                Map<String, Object> resultadoCompleto = (Map<String, Object>) JSON.deserializeUntyped(jsonBody);
                String chaveMoeda = codigoMoeda + 'BRL';
                Map<String, Object> dadosMoeda = (Map<String, Object>) resultadoCompleto.get(chaveMoeda);
                
                if (dadosMoeda != null && dadosMoeda.containsKey('bid')) {
                    String valorBidStr = (String) dadosMoeda.get('bid');
                    return Decimal.valueOf(valorBidStr);
                }
            }
        } catch (Exception e) {
            System.debug('Exceção capturada: ' + e.getMessage());
        }
        return null;
    }
}