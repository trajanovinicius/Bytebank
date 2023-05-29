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
      body: ListaTransferencias(),
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
            Editor(
              controlador: _controladorCampoNumeroConta,
              dica: '0000',
              rotulo: 'Número da Conta',
            ),
            Editor(
              // dessa forma podemos colocar os campos que vamos usar ou não e na ordem que quisermos.
              controlador: _controladorCampoValor,
              dica: '0.00',
              rotulo: 'Valor',
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: const Text('confirmar'),
              onPressed: () => {
                _criaTranferencia(context),
              },
            ),
          ],
        ));
  }

  void _criaTranferencia(BuildContext context) {
    final numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final tranferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, tranferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  const Editor(
      {super.key, this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          icon: icone != null
              ? Icon(icone)
              : null, // validação para remoção do espaçamento em branco desnecessário.
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List.empty(growable: true);

  ListaTransferencias({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciasState();
  }
}

class ListaTranferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTranferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // utilizamos o navigator para acessar outras telas. ele controla todo esse fluxo.
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia(); // acessando tela de formulário para criação de transferência.
          }));
          future.then((transferenciaRecebida) {
            //then faz a operação de forma assíncrona.
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
            debugPrint('$transferenciaRecebida');
          });
        },
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