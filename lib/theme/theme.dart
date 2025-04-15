import 'package:flutter/material.dart';
import 'package:flutter_gemini_chatbot/provider/provider.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Uiprovider>(builder: (context, Uiprovider notifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Consumer<Uiprovider>(
            builder: (context, Uiprovider notifier, child) {
          return Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.dark_mode,
                ),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: notifier.isDark,
                  onChanged: (value) => notifier.changeTheme(),
                ),
              )
            ],
          );
        }),
      );
    });
  }
}
