import 'package:bbai/conversation_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'AIRequests.dart' as API;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mosada ಠ_ಠ',
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
        text: "Me: $query", color: Colors.transparent, speaker: Speaker.Me));
    conversations.addAll(await API.continueConversation(query));
    setState(() {});
  }

  Widget getInputter() {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: TextField(
          autofocus: true,
          autocorrect: false,
          controller: controller,
          decoration: InputDecoration(
            labelText: '',
          ),
          selectionControls: MaterialTextSelectionControls(),
          onSubmitted: (final value) {
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
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
              child: DecoratedBox(
                  decoration: BoxDecoration(color: HexColor('#f0f0f0')),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatWidget(values: conversations),
                  ))),
          getInputter(),
        ],
      ),
    );
  }
}
