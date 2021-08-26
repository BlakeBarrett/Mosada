import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  final _scrollController = new ScrollController(keepScrollOffset: true);

  var _selfIcon = SvgPicture.asset('assets/account-outline.svg');
  var _aiIcon = SvgPicture.asset('assets/robot-outline.svg');

  @override
  Widget build(final BuildContext context) {
    // Dismiss keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
    // Scroll to "bottom" of chat
    // _scrollController.animateTo(
    //   conversations.length * 100.0,
    //   curve: Curves.easeOut,
    //   duration: const Duration(milliseconds: 300),
    // );
    // return CustomScrollView
    return Center(
      child: CustomScrollView(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverList(
            delegate: new SliverChildBuilderDelegate(
              (final BuildContext context, final int index) {
                final value = conversations[index];
                return getConversationCard(value, context);
              },
              childCount: conversations.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget getConversationCard(
      final ConversationViewModel value, final BuildContext context) {
    final bool isMe = value.speaker == Speaker.Me;
    final Widget? thumbnailSelf = (isMe)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [_selfIcon],
          )
        : null;
    final Widget? thumbnailAI = (!isMe)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [_aiIcon],
          )
        : null;
    return Container(
        child: Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: ListTile(
        leading: thumbnailSelf,
        title: Card(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4.0,
          color: value.color,
          child: Padding(
              padding: const EdgeInsets.all(16.0), child: Text(value.text)),
        ),
        trailing: thumbnailAI,
      ),
    ));
  }
}
