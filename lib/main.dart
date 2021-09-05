import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'AIRequests.dart' as API;
import 'conversation_list.dart';
import 'drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor _primarySwatch() {
    final blue = Color(
        0xff00bfff); // When asked, this was Mosada's favorite hue of blue.
    return MaterialColor(0xff00bfff, {
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
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mosada ಠ_ಠ',
      theme: ThemeData(
        primarySwatch: _primarySwatch(),
      ),
      home: MosadaChatWidget(),
    );
  }
}

@immutable
class MosadaChatWidget extends StatefulWidget {
  @override
  _MosadaChatWidgetState createState() => _MosadaChatWidgetState();
}

class _MosadaChatWidgetState extends State<MosadaChatWidget> {
  final List<ConversationViewModel> conversations = () {
    final List<ConversationViewModel> list = [];
    list.addAll(API
        .getPreamble()
        .split('\n')
        .where((element) => element.isNotEmpty)
        .map((element) => new ConversationViewModel(
            text: element, color: Colors.white70, speaker: Speaker.Them)));
    return list;
  }();

  void _execute(final String query) async {
    conversations.add(new ConversationViewModel(
        text: query, color: Colors.white70, speaker: Speaker.Me));
    setState(
        () {}); // calling setState() triggers the loading indicator to appear.
    conversations.addAll(await API.continueConversation(query));
    setState(() {}); // calling setState() triggers the loading indicator to
    // disappear and the conversation to render.
  }

  Widget _getInputter() {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Center(
        child: TextField(
          enabled: API.isReady(),
          autofocus: true,
          autocorrect: false,
          textInputAction: TextInputAction.send,
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
            builder: (final context) => IconButton(
                icon: const Icon(Icons.menu),
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
                icon: const Icon(Icons.delete))
          ]),
      body: Stack(
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                  child: DecoratedBox(
                decoration: BoxDecoration(color: HexColor('#f0f0f0')),
                child: ChatWidget(values: conversations),
              )),
              _getInputter(),
            ],
          ),
        ],
      ),
    );
  }
}
