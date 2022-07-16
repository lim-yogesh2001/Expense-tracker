import '../models/transection.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transection> data;
  final Function txRemove;
  const TransactionList(this.data, this.txRemove);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: data.isEmpty
            ? Column(
                children: [
                  Text(
                    "There are no data at the moment",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        "assets/images/no_data.png",
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: SizedBox(
                      width: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 60.0,
                            width: 90.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                border:
                                    Border.all(color: Colors.teal, width: 2.0),
                                shape: BoxShape.circle),
                            child: Center(
                              child: FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Rs. ${data[index].amount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              Text(
                                DateFormat.yMMMMEEEEd()
                                    .format(data[index].date),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () => txRemove(data[index].id),
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ));
  }
}
