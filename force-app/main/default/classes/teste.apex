Decimal cotacaoEuro = FinTrackService.obterCotacao('EUR');
System.debug('--- RE-TESTE FINTRACK ---');
if (cotacaoEuro != null) {
    System.debug('Sucesso! Cotação atual do Euro (EUR): R$ ' + cotacaoEuro);
} else {
    System.debug('A API ainda está sobrecarregada. Tente novamente em instantes.');
}
System.debug('-------------------------');