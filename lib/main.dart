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

@immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ConversationViewModel> conversations = [];

  void _execute(final String query) async {
    conversations.add(new ConversationViewModel(
        text: "Me: $query", color: Colors.transparent));
    conversations.addAll(await API.continueConversation(query));
    setState(() {});
  }

  Widget getInputter() {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TextField(
          autofocus: true,
          autocorrect: false,
          controller: controller,
          decoration: InputDecoration(
            labelText: '',
          ),
          selectionControls: MaterialTextSelectionControls(),
          onSubmitted: (value) {
            _execute(value);
            controller.clear();
          },
        ),
      ),
    );
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
            getInputter(),
          ],
        ),
      ),
    );
  }
}
