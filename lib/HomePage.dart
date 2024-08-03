import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const platform = MethodChannel('examples.ios/native_ios_app');

  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = 'Enter two numbers and press the button.';

  Future<void> _addNumbers() async {
    int num1, num2;
    int? sum;
    try {
      
      num1 = int.parse(_num1Controller.text);
      num2 = int.parse(_num2Controller.text);

      // Call the native method to add the numbers.
      sum = await platform.invokeMethod<int>('addNumbers', {
        'num1': num1,
        'num2': num2,
      });

      setState(() {
        _result = 'The sum is $sum.';
      });
    } on PlatformException catch (e) {
      setState(() {
        _result = "Failed to add numbers: '${e.message}'.";
      });
    } catch (e) {
      setState(() {
        _result = "Invalid input! Please enter valid integers.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add Two Numbers (iOS)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              //textfield and all sunder decorations :)
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter first number'),
            ),
            TextField(
              //textfield and all sunder decorations :)
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter second number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNumbers,
              child: const Text('Add Numbers'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
