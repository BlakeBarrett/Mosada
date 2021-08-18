import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart' as secrets;

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

  void _execute() async {
    final String? query = inputter.query;
    final String url = 'https://api.github.com/search/repositories?q=$query';
    final Uri uri = Uri.parse(url);
    Map postData = {
      "prompt": "Me: what do you think of \"$query\"\r Mosada: #",
      "stop": [";"],
      "engine": "davinci",
      "temperature": 0,
      "max_tokens": 64,
      "top_p": 1.0,
      "frequency_penalty": 0.0,
      "presence_penalty": 0.0,
    };
    final postBody = json.encode(postData);
    var result = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: secrets.OPEN_AI_API_KEY,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: postBody,
    );
    setState(() {
      inputter.response = result.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? body = (inputter.response == null)
        ? inputter
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Query:',
                ),
                Text(
                  '${inputter.response}',
                  style: Theme.of(context).textTheme.headline4,
                ),
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
  String? response;

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
