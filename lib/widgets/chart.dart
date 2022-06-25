import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import "../models/transaction.dart";
import "./chart_bar.dart";

class Chart extends StatelessWidget {
  List<Transacton> transactions;
  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var totalSum = 0.0;
      final weekValue = DateTime.now().subtract(
        Duration(days: index),
      );

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekValue.day &&
            transactions[i].date.month == weekValue.month &&
            transactions[i].date.year == weekValue.year) {
          totalSum += transactions[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekValue).substring(0, 1),
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element["amount"]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(25),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tx["day"],
                tx["amount"],
                totalSpending == 0.0
                    ? 0.0
                    : (tx["amount"] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
