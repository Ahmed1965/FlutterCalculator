import 'package:calculator/calculator/Calculator.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  var userQuestion = '';
  var userAnswer = '';
  final myTextStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple[900]);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userQuestion,
                    style:
                        TextStyle(fontSize: 30, color: Colors.deepPurple[500]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style:
                        TextStyle(fontSize: 30, color: Colors.deepPurple[500]),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                //clear button
                if (index == 0) {
                  return Calculator(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                        userAnswer = '';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
                  );

                  // delete button

                } else if (index == 1) {
                  return Calculator(
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                  );
                } else if (index == buttons.length - 1) {
                  return Calculator(
                      buttonText: buttons[index],
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      buttonTapped: () {
                        setState(() {
                          equalpressed();
                        });
                      });
                } else {
                  return Calculator(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple[50],
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                    buttonText: buttons[index],
                  );
                }
              }),
        ),
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == 'x' ||
        x ==
            '''
-''' ||
        x == '+' ||
        x == '=') {
      return true;
    }
    return false;
  }

  void equalpressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
