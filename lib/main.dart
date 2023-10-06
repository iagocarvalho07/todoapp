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
  bool _showChart = false;
  final List<Transaction> _transation = [];

  List<Transaction> get _recentTransactions {
    return _transation.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransactinon(String tittle, double value, DateTime date) {
    final newTransation = Transaction(
        id: Random().nextDouble().toString(),
        title: tittle,
        value: value,
        date: date);

    setState(() {
      _transation.add(newTransation);
    });
    Navigator.of(context).pop();
  }

  _deleteTransation(String id) {
    setState(() {
      _transation.removeWhere((element) {
        return element.id == id;
      });
    });
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
    bool isLandsCap =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      title: const Text(
        "Despesas Pessoais",
        strutStyle: StrutStyle(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.bar_chart)),
        IconButton(
            onPressed: () => _openTransationForm(context),
            icon: Icon(Icons.add)),
      ],
    );

    final availabelHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandsCap)
            //   Row(
            //     children: [
            //       const Text('Exibir Gráfico'),
            //       Switch(
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLandsCap)
              SizedBox(
                height: availabelHeight * (isLandsCap ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandsCap)
              SizedBox(
                height: availabelHeight * 0.6,
                child: TransactionList(_transation, _deleteTransation),
              ),
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
