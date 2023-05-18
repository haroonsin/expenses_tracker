import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { FOOD, TRAVEL, LEISURE, WORK }

const categoryIcons = {
  Category.FOOD: Icons.lunch_dining,
  Category.TRAVEL: Icons.flight_takeoff_rounded,
  Category.LEISURE: Icons.wine_bar,
  Category.WORK: Icons.laptop
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    // return expenses
    //     .map((expense) => expense.amount)
    //     .reduce((value, element) => value + element);
    double sum = 0;
    for (Expense expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
