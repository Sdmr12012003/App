import 'package:flutter/material.dart';

class AddExpenseDialog extends StatefulWidget {
  final Function(String name, double cost) onExpenseAdded;

  AddExpenseDialog({required this.onExpenseAdded});

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[500],
      title: Text(
        'Add Expense',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Add Credits/Debit',
              fillColor: Colors.white,
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
                labelText: 'Add Amount',
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Add your logic here to handle the addition of the expense
            String name = _nameController.text;
            double amount = double.tryParse(_amountController.text) ?? 0.0;
            // Add the expense to the list or perform any other action
            widget.onExpenseAdded(
                name, amount); // Call the callback function with name and cost
            Navigator.pop(context); // Close the dialog
          },
          child: Text(
            'Add',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
                context); // Close the dialog without adding the expense
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
