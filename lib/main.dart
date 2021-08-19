import 'dart:io';
import 'dart:convert';
import 'package:bbai/AIResponse.dart';
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
  String? response;
  // ignore: non_constant_identifier_names
  AIResponse? response_obj;

  void _execute() async {
    final String? query = inputter.query;
    final String url = 'https://api.openai.com/v1/engines/davinci/completions';
    final Uri uri = Uri.parse(url);
    Map postData = {
      // "prompt": "Me: $query\r Mosada: #",
      "prompt": "The CSS code for a color like $query:\n\nbackground-color: #",
      "stop": [";"],
      "temperature": 0,
      "max_tokens": 69,
      "top_p": 1.0,
      "frequency_penalty": 0.0,
      "presence_penalty": 0.0,
    };
    final postBody = json.encode(postData);
    var result = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${secrets.OPEN_AI_API_KEY}",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: postBody,
    );
    print(result.body);
    response_obj = AIResponse.fromJson(jsonDecode(result.body));
    setState(() {
      response = response_obj?.choices.first.text;
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
                Text(
                  'Query:',
                ),
                Text(
                  '$response',
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

@immutable
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
