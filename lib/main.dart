import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _texto = '';
  var _imc;
  TextEditingController _peso = new TextEditingController();
  TextEditingController _altura = new TextEditingController();

  @override
  void initState() {
    _texto = 'Preencha as informações necessárias para descobrir seu IMC';
    super.initState();
  }

  void _calcularIMC(){
    var pesoAtual = double.tryParse(_peso.text);
    var alturaAtual = double.tryParse(_altura.text);

    _imc = pesoAtual! / (alturaAtual! * alturaAtual);
  }
  

  void _atualizarTexto() {
    setState(() {
      _texto = 'Resultado \n';
      if (_imc < 18.5) {
        _texto += 'IMC - ${_imc.toStringAsFixed(2)}: abaixo do peso normal';
      } else if (_imc >= 18.5 && _imc < 24.9) {
        _texto += 'IMC - ${_imc.toStringAsFixed(2)}: peso normal';
      } else if (_imc >= 25 && _imc < 29.9) {
        _texto += 'IMC - ${_imc.toStringAsFixed(2)}: excesso de peso';
       } else if (_imc >= 30 && _imc < 34.9) {
        _texto += 'IMC - ${_imc.toStringAsFixed(2)}: obesidade classe I';
      }  else if (_imc >= 35 && _imc < 39.9) {
        _texto += 'IMC - ${_imc.toStringAsFixed(2)}: obesidade classe II';
      } else {
        _texto += 'IMC - ${_imc.toStringAsFixed(2)}: obesidade classe III';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
             TextFormField(
              controller: _peso,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Peso (Ex 71.9)',
                ),
              ),
              TextFormField(
                controller: _altura,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Altura (Ex 1.79)',
                ),
              ),
              Card(
                child: Text(_texto),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_altura.text.isNotEmpty && _peso.text.isNotEmpty) {
                    _calcularIMC();
                    _atualizarTexto();
                  }
                }, 
                child: const Text('Calcular'))
          ],
        ),
      ),
     );
  }
}
