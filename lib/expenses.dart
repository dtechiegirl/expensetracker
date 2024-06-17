import 'package:expensetracker/widgets/add_new_expense.dart';
import 'package:expensetracker/widgets/chart/chart.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Fanta",
        amount: 400,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Coke",
        amount: 400,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Movie",
        amount: 3400,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Ugh, Expense Deleted"),
      action: SnackBarAction(
        label: 'undo',
        onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void _addExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
   final width =  MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No Expenses Found"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expanded(
          child: ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      ));
    }
    // _registeredExpenses.isNotEmpty ? mainContent ==  Expanded(child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,)) : mainContent;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expense Tracker"),
        actions: [
          IconButton(onPressed: _addExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent)
          // Expanded(child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,))
        ],
      ) : Row(
        children: [
           Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent)
        ],
      )
      // body: ListView.builder(itemCount: _registeredExpenses.length , itemBuilder: (context, index) => Text(_registeredExpenses[index].title)),
    );
  }
}
