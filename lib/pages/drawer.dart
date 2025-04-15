import 'package:flutter/material.dart';
import 'package:flutter_gemini_chatbot/pages/aboutpage.dart';
import 'package:flutter_gemini_chatbot/theme/theam.dart';

class MyDrawer extends StatelessWidget {
  // final String name;
  const MyDrawer({
    super.key,
    // required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 50),
        children: [
          ListTile(
            title: Text('Homepage'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
          ListTile(
            title: Text(
              'About',
              softWrap: true,
            ),
            leading: Icon(Icons.info),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}
