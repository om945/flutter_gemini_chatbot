// import 'package:flutter/material.dart';
// import 'package:flutter_gemini_chatbot/main.dart';
// import 'package:flutter_gemini_chatbot/pages/drawer.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class Homepage extends StatefulWidget {
//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   late final GenerativeModel _model;
//   late final ChatSession _chat;
//   final ScrollController _scrollController = ScrollController();
//   TextEditingController _textController = TextEditingController();
//   final List<ChatMessage> _messages = [];
//   String _name = "";

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showNameDialog();
//     });
//     _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: API_KEY);
//     _chat = _model.startChat();
//   }

//   void _showNameDialog() {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(
//               'Enter your name',
//             ),
//             content: TextFormField(
//               decoration: InputDecoration(hintText: 'Name'),
//               onChanged: (value) {
//                 _name = value;
//                 setState(() {});
//               },
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Submit'),
//                 onPressed: () {
//                   if (_name.isNotEmpty) {
//                     Navigator.pop(context);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('please enter your name')));
//                   }
//                 },
//               )
//             ],
//           );
//         });
//   }

//   void _scrollDown() {
//     WidgetsBinding.instance.addPostFrameCallback((_) =>
//         _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 750),
//             curve: Curves.easeInOutCirc));
//   }

//   Future<void> _sendChatMessage(String message) async {
//     setState(() {
//       _messages.add(ChatMessage(text: message, isUser: true));
//     });

//     try {
//       final response = await _chat.sendMessage(Content.text(message));
//       final text = response.text;
//       setState(() {
//         _messages.add(ChatMessage(text: text!, isUser: false));
//         _scrollDown();
//       });
//     } catch (e) {
//       _messages.add(ChatMessage(text: 'Error occured', isUser: false));
//     } finally {
//       _textController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(name: _name),
//       appBar: AppBar(
//         title: Text('AI ChatBot'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//                 controller: _scrollController,
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   return ChatBubble(message: _messages[index]);
//                 }),
//           ),
//           Padding(
//               padding: EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       onSubmitted: _sendChatMessage,
//                       controller: _textController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () => _sendChatMessage(_textController.text),
//                       icon: Icon(Icons.send))
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
// }

// class ChatMessage {
//   final String text;
//   final bool isUser;
//   ChatMessage({required this.text, required this.isUser});
// }

// class ChatBubble extends StatelessWidget {
//   final ChatMessage message;

//   const ChatBubble({super.key, required this.message});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Container(
//         child: Text(
//           message.text,
//           style: TextStyle(
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }
