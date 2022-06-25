import "package:flutter/material.dart";

import '../models/transaction.dart';

import '../widgets/transcation_item.dart';

class TransactionList extends StatelessWidget {
  List<Transacton> transactions;
  Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No transactions added yet!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                    height: constraints.maxHeight * 0.6,
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  transactions: transactions[index],
                  deleteTransaction: deleteTransaction,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
