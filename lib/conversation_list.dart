import 'package:flutter/material.dart';

class ConversationViewModel {
  late final String text;
  late final Color color;
  ConversationViewModel({required this.text, required this.color});
}

@immutable
class ConversationListWidget extends StatefulWidget {
  final List<ConversationViewModel> values;
  ConversationListWidget({required this.values});
  @override
  _ConversationListWidgetState createState() =>
      _ConversationListWidgetState(conversations: this.values);
}

class _ConversationListWidgetState extends State<ConversationListWidget> {
  List<ConversationViewModel> conversations = [];
  _ConversationListWidgetState({required this.conversations});

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
                return DecoratedBox(
                    decoration:
                        BoxDecoration(color: conversations[index].color),
                    child: SelectableText(
                      '${conversations[index].text}',
                      style: Theme.of(context).textTheme.headline4,
                    ));
              },
              childCount: conversations.length,
            ),
          ),
        ],
      ),
    ));
  }
}
