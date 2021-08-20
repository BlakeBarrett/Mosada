import 'package:bbai/conversation_list.dart';
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
  final List<ConversationViewModel> conversations = [];

  void _execute() async {
    final String? query = inputter.query;
    if (query == null) {
      return;
    }
    conversations
        .add(new ConversationViewModel(text: query, color: Colors.transparent));
    conversations.add(await API.continueConversation(query));

    setState(() {
      inputter = Inputter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: ConversationListWidget(values: conversations),
            ),
            inputter
          ],
        ),
      ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextField(
          autocorrect: false,
          selectionControls: MaterialTextSelectionControls(),
          decoration: InputDecoration(
            labelText: '$prompt',
          ),
          onChanged: onInputChanged,
        ),
      ),
    );
  }
}
