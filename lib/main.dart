import 'package:bbai/conversation_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'AIRequests.dart' as API;
import 'drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final blue = Color(
        0xFF00BFFF); // When asked, this was Mosada's favorite hue of blue.
    return MaterialApp(
      title: 'Mosada ಠ_ಠ',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff00bfff, {
          50: blue.withAlpha(10),
          100: blue.withAlpha(20),
          200: blue.withAlpha(30),
          300: blue.withAlpha(40),
          400: blue.withAlpha(50),
          500: blue.withAlpha(60),
          600: blue.withAlpha(70),
          700: blue.withAlpha(80),
          800: blue.withAlpha(90),
          900: blue.withAlpha(100),
        }),
      ),
      home: MosadaChatWidget(),
    );
  }
}

@immutable
class MosadaChatWidget extends StatefulWidget {
  MosadaChatWidget({Key? key}) : super(key: key);

  @override
  _MosadaChatWidgetState createState() => _MosadaChatWidgetState();
}

class _MosadaChatWidgetState extends State<MosadaChatWidget> {
  final List<ConversationViewModel> conversations = [];

  void _execute(final String query) async {
    conversations.add(new ConversationViewModel(
        text: "Me: $query", color: Colors.white70, speaker: Speaker.Me));
    conversations.addAll(await API.continueConversation(query));
    setState(() {});
  }

  Widget getInputter() {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: TextField(
          enabled: API.isReady(),
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
  Widget build(final BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
          title: Text('Mosada ಠ_ಠ'),
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    conversations.clear();
                    API.reset();
                  });
                },
                icon: Icon(Icons.delete))
          ]),
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
