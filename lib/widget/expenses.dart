import 'package:expenses_tracker/widget/charts/chart.dart';
import 'package:expenses_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Expense(
    //   title: 'Flutter Course',
    //   amount: 19.99,
    //   date: DateTime.now(),
    //   category: Category.WORK,
    // ),
    Expense(
      title: 'Movie',
      amount: 2.9,
      date: DateTime.now(),
      category: Category.LEISURE,
    ),
    Expense(
      title: 'Lasagne',
      amount: 2.5,
      date: DateTime.now(),
      category: Category.FOOD,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense added"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessengerState scaffoldState = ScaffoldMessenger.of(context);
    scaffoldState.clearSnackBars();
    scaffoldState.showSnackBar(
      SnackBar(
        content: const Text("Expenses Deleted"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () => _registeredExpenses.insert(expenseIndex, expense),
            );
          },
        ),
      ),
    );
  }
}
