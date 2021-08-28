import 'package:flutter/animation.dart';
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

class _ChatWidgetState extends State<ChatWidget>
    with SingleTickerProviderStateMixin {
  List<ConversationViewModel> conversations = [];
  _ChatWidgetState({required this.conversations});

  final _scrollController = new ScrollController(keepScrollOffset: true);

  var _selfIcon = SvgPicture.asset('assets/account-outline.svg');
  var _aiIcon = SvgPicture.asset('assets/robot-outline.svg');

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          try {
            final value = _scrollController.position.maxScrollExtent;
            // The state that has changed here is the animation object’s value.
            _scrollController.jumpTo(value);
          } catch (e) {
            print(e); // just ignore it
          }
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          // SliverFillRemaining(
          //   fillOverscroll: false,
          // ),
          SliverList(
            delegate: new SliverChildListDelegate(
              conversations
                  .map((final value) => getConversationCard(value))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getConversationCard(final ConversationViewModel value) {
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
    return ListTile(
      leading: thumbnailAI,
      title: Wrap(
        alignment: isMe ? WrapAlignment.end : WrapAlignment.start,
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4.0,
            color: value.color,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  value.text,
                  softWrap: true,
                )),
          ),
        ],
      ),
      trailing: thumbnailSelf,
    );
  }
}
