import "package:flutter/foundation.dart";

class Transacton {
  String id;
  String title;
  double amount;
  DateTime date;
  Transacton({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
