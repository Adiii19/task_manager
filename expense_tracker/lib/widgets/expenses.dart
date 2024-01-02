import 'package:expense_tracker/widgets/expenses_list.dart/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpenseOverlays() {
    
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: addexpensedata);
        });
  }

  void addexpensedata(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final expenseindex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseindex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
       final width= MediaQuery.of(context).size.width;
       final height=MediaQuery.of(context).size.height;


    Widget maincontent =
        Center(child: Text("No expenses found.Add some expenses"));

    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpenses,
        onremoveexpense: removeexpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
          
          title: Text(
            "Expenses App",
            
          ),
          toolbarHeight: 60,
          actions: [
            IconButton(
                onPressed: () {
                  _openAddExpenseOverlays();
                },
                icon: Icon(Icons.add))
          ]),
      body: width<600?Column(
        children: [
          Chart(expenses:_registeredExpenses),
          Expanded(child: maincontent),
        ],
      ):
      Row(
          children: [
          Expanded(child: Chart(expenses:_registeredExpenses)),
          Expanded(child: maincontent),
        ],
      ),

    );
  }
}
