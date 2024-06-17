import 'package:expensetracker/widgets/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });
  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(.75),
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(
                horizontal:  Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (dirextion) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpensesItem(expenses[index])),
    );
  }
}
