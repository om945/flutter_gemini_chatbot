import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        shape: Border(
            // bottom: BorderSide(color: Colors.black, width: 0.3),
            ),
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.1),
          child: Container(
            // color: Colors.black,
            height: 1.0,
          ),
        ),
        title: const Text(
          'About',
          style:
              TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 10),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set the height to the screen height
        width: MediaQuery.of(context)
            .size
            .width, // Set the width to the screen width
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' A U Z A',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '• Version: 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    '🤖  A U Z A  your AI Assistance',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "This AI chatbot leverages advanced natural language processing to understand and respond to your queries in a human-like manner.  It's trained on a massive dataset, enabling it to handle a wide range of topics and tasks, from answering simple questions to providing complex information and assistance.  Enjoy seamless and efficient interactions anytime, anywhere.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    '• Developed by: Om Sunil Belekar',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '• Contact us:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse('https://github.com/om945'));
                            },
                            child: Image.asset(
                              "assets/files/github.png",
                              height: 30,
                              width: 30,
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  'https://www.linkedin.com/in/om-belekar-aab424326?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app'));
                            },
                            child: Image.asset(
                              "assets/files/LinkedIn.png",
                              height: 30,
                              width: 30,
                            ))
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
