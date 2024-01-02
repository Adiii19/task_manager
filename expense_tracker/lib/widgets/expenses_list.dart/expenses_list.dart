import 'package:expense_tracker/widgets/expenses_list.dart/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {super.key, required this.expenses, required this.onremoveexpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onremoveexpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(
                expenses[index],
              ),
               background:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_rounded),
                    Center(child: Text('Delete')),
                  ],
                ),
            color: Theme.of(context).colorScheme.error,
            margin:EdgeInsets.symmetric(horizontal:Theme.of(context).cardTheme.margin!.horizontal) ,
            ),
              child: ExpenseItem(expenses[index]),
              onDismissed: (direction) => onremoveexpense(expenses[index]),
            ));
  }
}
