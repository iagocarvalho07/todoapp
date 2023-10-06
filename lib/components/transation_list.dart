import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onDelete;

  const TransactionList(this.transaction, this.onDelete, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: Text(
                      "Nenhuma transação cadastrada",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/imagens/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (ctx, index) {
                final tr = transaction[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            'R\$${tr.value}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: IconButton(
                      onPressed: () => onDelete(tr.id),
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              }),
    );
  }
}

// Row(
// children: <Widget>[
// Container(
// margin:
// EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2)),
// padding: EdgeInsets.all(10),
// width: 150,
// child: Text(
// 'R\$${e.value.toStringAsFixed(2)}',
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20,
// color: Colors.purple),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// e.title,
// style: const TextStyle(
// fontWeight: FontWeight.bold, fontSize: 15),
// ),
// Text(
// DateFormat('d MMM y').format(e.date),
// style: TextStyle(color: Colors.grey[350]),
// )
// ],
// )
// ],
// ),
