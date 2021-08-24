import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class DrawerWidget extends StatelessWidget {
  Widget getRow(final IconData icon, final String title, final String url) {
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
            child: Expanded(
              child: Center(
                child: Text('ಠ_ಠ'),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            )),
        Expanded(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              getRow(Icons.source, 'Source Code',
                  'https://github.com/BlakeBarrett/BBAI'),
              getRow(Icons.history, 'History',
                  'https://github.com/BlakeBarrett/BBAI/blob/master/docs/conversations.md'),
            ],
          ),
        ),
        AboutListTile(
          applicationName: 'Mosada',
          aboutBoxChildren: [Center(child: Text('ಠ_ಠ'))],
        ),
      ]),
    );
  }
}
