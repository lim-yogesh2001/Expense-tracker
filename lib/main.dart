import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/transaction_form.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        fontFamily: "RobotoSlab",
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "RobotoSlab",
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontFamily: "RobotoSlab",
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final List<Transection> _usertransections = [
    // Transection(
    //   id: 1,
    //   title: "New Book",
    //   date: DateTime.now(),
    //   amount: 500.0,
    // ),
    // Transection(
    //   id: 2,
    //   title: "New Pen",
    //   date: DateTime.now(),
    //   amount: 20.50,
    // )
  ];

  List<Transection> get _recentTransaction {
    return _usertransections.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransections(
      int id, String trtitle, double tramount, DateTime date) {
    final newTransection = Transection(
      id: id,
      title: trtitle,
      date: date,
      amount: tramount,
    );
    setState(() {
      _usertransections.add(newTransection);
    });
  }

  void _deleteTransection(int id) {
    setState(() {
      _usertransections.removeWhere((tx) => tx.id == id);
    });
  }

  void _startTrasaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (cxt) {
          return GestureDetector(
            onTap: () {},
            child: TransactionForm(_addNewTransections),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Expense Tracker"),
      actions: [
        IconButton(
          onPressed: () => _startTrasaction(context),
          icon: Icon(Icons.add_box),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height) *
                        0.3 -
                    MediaQuery.of(context).padding.top,
                child: Chart(recentTransections: _recentTransaction)),
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height) *
                        0.7 -
                    MediaQuery.of(context).padding.top,
                child: TransactionList(_usertransections, _deleteTransection))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startTrasaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
