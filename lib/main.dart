import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: MyHomePage(title: 'BMI Calculator'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _heightController=TextEditingController();
  final _weightController=TextEditingController();
  double _bmi;

  String _message = 'Please enter your height an weight';
  void _calculate() {
    final double height = double.tryParse(_heightController.value.text);
    final double weight = double.tryParse(_weightController.value.text);

    if (height <= 0 || weight <= 0) {
      setState(() {
        _message = "Your height and weigh must be positive numbers";
      });
      return;
    }
    setState(() {
      _bmi = weight / (height * height);
      if (_bmi < 18.5) {
        _message = "You are underweight";
      } else if (_bmi < 25) {
        _message = 'You body is fine';
      } else if (_bmi < 30) {
        _message = 'You are overweight';
      } else {
        _message = 'You are obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(
            child: Text(widget.title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight. bold
            ),),
          ),
        ),
    backgroundColor:Colors.lightBlue,
      body: Center(
        child: Container(
          width: 320,
          child: Card(
            color: Colors.tealAccent,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Height (m)'),
                    controller: _heightController,
                  ),
                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Weight (kg)',
                    ),
                    controller: _weightController,
                  ),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text('Calculate'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      _bmi == null ? 'No Result' : _bmi.toStringAsFixed(2),
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      _message,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    ));
  }
}
