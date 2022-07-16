import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function trAdd;
  TransactionForm(this.trAdd);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final idController = TextEditingController();

  final titleController = TextEditingController();

  final amountController = TextEditingController();
   DateTime ?_selectedDate;

  void addTr() {
    final inputTitle = titleController.text;
    final inputId = int.parse(idController.text);
    final inputAmount = double.parse(amountController.text);
    if (inputTitle.isEmpty || inputId <= 0 || inputAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.trAdd(inputId, inputTitle, inputAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((selected) {
      if (selected == null) {
        return;
      }
      setState(() {
        _selectedDate = selected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: const InputDecoration(labelText: "ID"),
            controller: idController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => addTr(),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: titleController,
            onSubmitted: (_) => addTr(),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => addTr(),
          ),
          SizedBox(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: unnecessary_null_comparison
                Text(_selectedDate == null ? "No Chosen Date": DateFormat.yMMMEd().format(_selectedDate!)),
                MaterialButton(
                  onPressed: _datePicker,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          MaterialButton(
            color: Colors.teal,
            onPressed: addTr,
            child: Text(
              "Add Expense",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
