class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferência{valor: $valor, numeroConta: $numeroConta}';
  }
}


/* runApp é Ponto de Partida do App, para refletir as mudanças no app.
 Widgets é a representação genérica dos elementos visuais qe temos na tela.
 Ao construir uma tela podemos usar 1 ou N Widgets.
 Column nos permite ter uma lista de widgets.*/

/*No Stateful vamos ter a capacidade de modificar o contédudo do nosso widget de maneira
dinâmica já no statless não conseguimos fazer essa modificação de conteúdo*/