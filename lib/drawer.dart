import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class DrawerWidget extends StatelessWidget {
  Widget _getLineItem(
      final IconData icon, final String title, final String url) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Drawer(
      child: Flex(direction: Axis.vertical, children: [
        DrawerHeader(
            child: const Center(
              child: Text('ಠ_ಠ'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            )),
        Expanded(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              _getLineItem(Icons.info_rounded, 'README',
                  'https://github.com/BlakeBarrett/Mosada/blob/master/README.md'),
              _getLineItem(Icons.question_answer, 'FAQs',
                  'https://github.com/BlakeBarrett/Mosada/blob/master/docs/FAQs.md'),
              _getLineItem(Icons.history, 'History',
                  'https://github.com/BlakeBarrett/Mosada/blob/master/docs/conversations.md'),
              _getLineItem(Icons.source, 'Source Code',
                  'https://github.com/BlakeBarrett/Mosada'),
            ],
          ),
        ),
        const AboutListTile(
          applicationName: 'Mosada',
          aboutBoxChildren: [Center(child: Text('ಠ_ಠ'))],
        ),
      ]),
    );
  }
}
