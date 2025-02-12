import 'package:flutter/material.dart';
import 'package:flutter_gemini_chatbot/pages/homepage.dart';
import 'package:flutter_gemini_chatbot/provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const String API_KEY = "AIzaSyBPkjMjuzK-flgf7Ue7rsmU-WGwLP6lY0c";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext) => Uiprovider()..init(),
      child:
          Consumer<Uiprovider>(builder: (context, Uiprovider notifier, child) {
        return MaterialApp(
            theme: ThemeData(
              fontFamily: GoogleFonts.nunitoSans().fontFamily,
            ),
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:
                notifier.isDark ? notifier.darkTheam : notifier.lightTheam,
            home: Chat());
      }),
    );
  }
}
