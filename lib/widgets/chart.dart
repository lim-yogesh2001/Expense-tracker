import 'package:expense_tracker/models/transection.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transection> recentTransections;

  List<Map<String, Object>> get transactionValue {
    return List.generate(7, (index){
      double totalAmount = 0.0;
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      for (var i = 0; i < recentTransections.length; i++) {
        if (recentTransections[i].date.day == weekday.day &&
            recentTransections[i].date.month == weekday.month &&
            recentTransections[i].date.year == weekday.year) {
          totalAmount += recentTransections[i].amount;
        };
      }
      return {'days': DateFormat.E().format(weekday), 'amount': totalAmount};
    });
  }

  double get totalspending {
    return transactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  Chart({required this.recentTransections});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['days'].toString(), (data['amount'] as double),
                  totalspending==0.0 ? 0.0 : (data['amount'] as double) / totalspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
