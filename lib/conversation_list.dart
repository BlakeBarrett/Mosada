import 'package:flutter/material.dart';

enum Speaker { Me, Them }

class ConversationViewModel {
  late final String text;
  late final Color color;
  late final Speaker speaker;
  ConversationViewModel(
      {required this.text, required this.color, required this.speaker});
}

@immutable
class ChatWidget extends StatefulWidget {
  final List<ConversationViewModel> values;
  ChatWidget({required this.values});
  @override
  _ChatWidgetState createState() =>
      _ChatWidgetState(conversations: this.values);
}

class _ChatWidgetState extends State<ChatWidget> {
  List<ConversationViewModel> conversations = [];
  _ChatWidgetState({required this.conversations});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: new SliverChildBuilderDelegate(
              (final BuildContext context, final int index) {
                final value = conversations[index];
                return getCell(value, context);
              },
              childCount: conversations.length,
            ),
          ),
        ],
      ),
    ));
  }

  Widget getCell(ConversationViewModel value, BuildContext context) {
    return Card(
        color: value.color,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SelectableText(
              '${value.text}',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: (value.speaker == Speaker.Me)
                  ? TextAlign.start
                  : TextAlign.end,
            )));
  }
}
