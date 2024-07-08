import 'package:flutter/material.dart';
import './input.dart';
import './button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Calculator';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  int _firstNumber = 0;
  int _secondNumber = 0;
  String _symbol = '';

  void _setSymbolAndSubmit(String symbol) {
    setState(() {
      _symbol = symbol;
    });
    _submit();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      num result = 0;
      switch (_symbol) {
        case '+':
          result = _firstNumber + _secondNumber;
          break;
        case '-':
          result = _firstNumber - _secondNumber;
          break;
        case '*':
          result = _firstNumber * _secondNumber;
          break;
        case '/':
          result = _firstNumber / _secondNumber;
          break;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Result'),
          content: Text(result.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Input(
              label: 'First Number',
              onSaved: (value) {
                if (value != null) {
                  _firstNumber = int.parse(value);
                }
              },
            ),
            Input(
              label: 'Second Number',
              onSaved: (value) {
                if (value != null) {
                  _secondNumber = int.parse(value);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['+', '-', '*', '/'].map((symbol) {
                  return ButtonSymbol(
                    symbol: symbol,
                    onPressed: () => _setSymbolAndSubmit(symbol),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonSymbol extends StatelessWidget {
  const ButtonSymbol({
    super.key,
    required this.symbol,
    required this.onPressed,
  });

  final String symbol;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Button(
        text: symbol,
        onPressed: onPressed,
      ),
    );
  }
}
