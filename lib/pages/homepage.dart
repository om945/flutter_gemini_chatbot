import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini_chatbot/pages/drawer.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  // String _name = "";

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showNameDialog();
  //   });
  // }

  // void _showNameDialog() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(
  //             'Enter your name',
  //           ),
  //           content: TextFormField(
  //             decoration: InputDecoration(hintText: 'Name'),
  //             onChanged: (value) {
  //               _name = value;
  //               setState(() {});
  //             },
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('Submit'),
  //               onPressed: () {
  //                 if (_name.isNotEmpty) {
  //                   Navigator.pop(context);
  //                 } else {
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(content: Text('please enter your name')));
  //                 }
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }
  ChatUser user = ChatUser(id: '1', firstName: 'Me');
  ChatUser bot =
      ChatUser(id: '2', firstName: 'A U Z A', profileImage: 'assets/files/icon.png');

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final our_Uri =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyBzSaeAi6ktTHBIeYoNLbvjZkGA1FOmtuQ";

  final headers = {
    'Content-Type': 'application/json',
  };

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {});
    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(
      Uri.parse(our_Uri),
      headers: headers,
      body: jsonEncode(data),
    )
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        String responseText = result['candidates'][0]['content']['parts'][0]['text'];
        ChatMessage m1 = ChatMessage(
          text: responseText,
          user: bot,
          createdAt: DateTime.now(),
          isMarkdown: true,
        );

        allMessages.insert(0, m1);
      } else {
        print("error occured");
      }
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text('A U Z A',
            style: TextStyle(
          fontWeight: FontWeight.bold
        )),
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          getdata(m);
        },
        messages: allMessages,
        messageListOptions: MessageListOptions(),
        scrollToBottomOptions: ScrollToBottomOptions(
          scrollToBottomBuilder: (scrollController) {
            return Container(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                },
              ),
            );
          },
        ),
        messageOptions: MessageOptions(
          messageTextBuilder: (ChatMessage message,
              ChatMessage? previousMessage, ChatMessage? nextMessage) {
            return SelectableText.rich(
              TextSpan(
                children: _parseText(message.text),
              ),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 100 ? 16 : 16,
              ),
            );
          },
          maxWidth: MediaQuery.of(context).size.width.isFinite
              ? MediaQuery.of(context).size.width - 70
              : 300,
          showTime: false,
          currentUserContainerColor:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.indigo
                  : Colors.blue,
          currentUserTextColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          containerColor: Colors.transparent,
          textColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        inputOptions: InputOptions(
          inputToolbarPadding: EdgeInsets.fromLTRB(8, 8, 8, 10),
          sendButtonBuilder: (onSend) {
            return IconButton(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.indigo
                  : Colors.blue,
              icon: Icon(Icons.send),
              onPressed: onSend,
            );
          },
          inputDecoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.indigo
                        : Colors.blue,
                    width: 2.0),
                borderRadius: BorderRadius.circular(30.0),
              ),
              fillColor: Colors.white,
              hintText: 'Type a message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              )),
          inputTextStyle: TextStyle(),
        ),
        typingUsers: typing,
      ),
    );
  }

  List<TextSpan> _parseText(String text) {
    final boldPattern = RegExp(r'\*\*(.*?)\*\*');
    final matches = boldPattern.allMatches(text);
    if (matches.isEmpty) {
      return [TextSpan(text: text)];
    }

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}
