import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/components/chart_bar.dart';
import 'package:todoapp/models/transation.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransation;

  Chart(this.recentTransation);

  List<Map<String, dynamic>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSumm = 0.0;
      for (var i = 0; i < recentTransation.length; i++) {
        bool sameDay = recentTransation[i].date.day == weekDay.day;
        bool samemanth = recentTransation[i].date.month == weekDay.month;
        bool sameYear = recentTransation[i].date.year == weekDay.year;

        if (sameDay && samemanth && sameYear) {
          totalSumm += recentTransation[i].value;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSumm,
      };
    });
  }

  double get _weekTotal {
    return groupedTransaction.fold(
        0.0, (sum, element)  {
          return sum+ element['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransaction;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransaction.map((tr) {
          return Flexible(
            fit: FlexFit.loose,
            child: ChartBar(
              label: tr['day'].toString(),
              value: tr['value'],
              percentage: tr['value'] / _weekTotal,
            ),
          );
        }).toList(),
      ),
    );
  }
}
