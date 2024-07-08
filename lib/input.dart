import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key, required this.label, required this.onSaved});

  final String label;
  final Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      decoration: InputDecoration(
        icon: const Icon(Icons.first_page),
        labelText: label,
      ),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }

        return 'Please enter some text';
      },
    );
  }
}
