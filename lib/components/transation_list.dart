import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transaction.isEmpty
            ? Column(
                children: [
                  Text(
                    "Nenhuma transação cadastrada",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/imagens/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (ctx, index) {
                  final e = transaction[index];
                  return Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        padding: EdgeInsets.all(10),
                        width: 150,
                        child: Text(
                          'R\$${e.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            e.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            DateFormat('d MMM y').format(e.date),
                            style: TextStyle(color: Colors.grey[350]),
                          )
                        ],
                      )
                    ],
                  );
                }));
  }
}
