import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp/components/chart.dart';
import 'package:todoapp/components/transation_form.dart';
import 'package:todoapp/components/transation_list.dart';
import 'package:todoapp/models/transation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transation = [
    Transaction(
      id: "ti",
      title: "NovoTenis",
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t3",
      title: "conta de agua",
      value: 20.76,
      date: DateTime.now().subtract(Duration(days: 44)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transation.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransactinon(String tittle, double value) {
    final newTransation = Transaction(
        id: Random().nextDouble().toString(),
        title: tittle,
        value: value,
        date: DateTime.now());

    setState(() {
      _transation.add(newTransation);
    });
    Navigator.of(context).pop();
  }

  _openTransationForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return transationForm(_addTransactinon);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Despesas Pessoais",
            strutStyle: StrutStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () => _openTransationForm(context),
                icon: Icon(Icons.add)),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transation),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransationForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
