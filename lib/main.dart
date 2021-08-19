import 'package:bbai/AIResponse.dart';
import 'package:flutter/material.dart';
import 'AIRequests.dart' as API;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BBAI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Inputter inputter = Inputter();
  String? response;
  Color? color;

  // ignore: non_constant_identifier_names
  AIResponse? response_obj;

  void _execute() async {
    final String? query = inputter.query;
    if (query == null) {
      return;
    }
    response_obj = await API.askQuestion(query);
    var responseText = response_obj?.choices.first.text;
    if (responseText != null) {
      color = await API.getColor(responseText);
    }
    setState(() {
      response = responseText;
      inputter.query = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? body = (response == null)
        ? inputter
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                    decoration: BoxDecoration(color: color),
                    child: Text(
                      '$response',
                      style: Theme.of(context).textTheme.headline4,
                    )),
              ],
            ),
          );

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: _execute,
        tooltip: 'Go!',
        child: Icon(Icons.add_task),
      ),
    );
  }
}

class Inputter extends StatefulWidget {
  String? query;

  @override
  _InputterState createState() => _InputterState();
}

class _InputterState extends State<Inputter> {
  final String prompt = 'Enter something: ';

  void onInputChanged(value) {
    setState(() {
      widget.query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        autocorrect: false,
        decoration: InputDecoration(
          labelText: '$prompt',
        ),
        onChanged: onInputChanged,
      ),
    );
  }
}
