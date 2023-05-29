import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: FormularioTransferencia(),
    ));
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Criando Transferência')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controladorCampoNumeroConta,
                style: const TextStyle(fontSize: 20.0),
                decoration: const InputDecoration(
                    labelText: 'Número da conta', hintText: '0000'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controladorCampoValor,
                style: const TextStyle(fontSize: 20.0),
                decoration: const InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Valor',
                  hintText: '0.00',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              child: const Text('confirmar'),
              onPressed: () {
                final numeroConta =
                    int.tryParse(_controladorCampoNumeroConta.text);
                final valor = double.tryParse(_controladorCampoValor.text);
                if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$transferenciaCriada')),
                  );
                }
              },
            ),
          ],
        ));
  }
}

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: Column(
        children: <Widget>[
          ItemTranferencia(Transferencia(500, 2000)),
          ItemTranferencia(Transferencia(1000, 20000)),
          ItemTranferencia(Transferencia(2000, 2000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTranferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTranferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

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