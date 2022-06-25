import "package:flutter/material.dart";
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function txAdd;

  NewTransaction(this.txAdd);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitTransaction() {
    final txTitle = _titleController.text;
    final txAmount = double.parse(_amountController.text);

    if (txTitle.isEmpty || txAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.txAdd(
      txTitle,
      txAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: _titleController,
                onSubmitted: (_) {
                  submitTransaction();
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) {
                  submitTransaction();
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Choosen"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          "Choose Date",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitTransaction,
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Add Transaction",
                ),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
