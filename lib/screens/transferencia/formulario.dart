import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/tranferencia.dart';
import 'package:flutter/material.dart';

const _dicaCampo = "0000";
const _tituloAppBar = "Criando Transferência";
const _rotuloCampoConta = "Número da Conta";
const _dicaCampoValor = "Valor";
const _dicaCampoValorNumero = "0.00";

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(_tituloAppBar)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNumeroConta,
                dica: _dicaCampo,
                rotulo: _rotuloCampoConta,
              ),
              Editor(
                // dessa forma podemos colocar os campos que vamos usar ou não e na ordem que quisermos.
                controlador: _controladorCampoValor,
                dica: _dicaCampoValorNumero,
                rotulo: _dicaCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: const Text('confirmar'),
                onPressed: () => {
                  _criaTranferencia(context),
                },
              ),
            ],
          ),
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
