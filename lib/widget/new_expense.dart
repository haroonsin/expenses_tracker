import 'package:expenses_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  Category _pickedCategory = Category.WORK;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            controller: _titleController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pickedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_pickedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _pickedCategory,
                  items: Category.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: _onCategorySelect),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: const Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
    //   // setState(() {
    // }
  }

  // void _saveTitleInput(String value) {

  //   _newTitle = value;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _pickedDate = selectedDate;
    });
  }

  void _onCategorySelect(Category? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _pickedCategory = value;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (isAmountInvalid ||
        _titleController.text.trim().isEmpty ||
        _pickedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please check data"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _pickedDate!,
        category: _pickedCategory,
      ),
    );
    Navigator.pop(context);
  }
}
