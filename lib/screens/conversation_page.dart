import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:google_fonts/google_fonts.dart';

class ConvoPage extends StatefulWidget {
  const ConvoPage({super.key});

  @override
  State<ConvoPage> createState() => _ConvoPageState();
}

class _ConvoPageState extends State<ConvoPage> {
  var msg = TextEditingController();
  List<String> other_messages = ['Hi there', 'How are you?'];
  List<String> my_messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation"),
      ),

      // body (chat view)
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 10,
        ),
        reverse: true,
        child: Column(
          children: [
            DateChip(
              date: DateTime.now(),
              color: const Color(0x558AD3D5),
            ),
            ...other_messages.map((_) => BubbleSpecialOne(
                  text: _,
                  isSender: false,
                  color: Colors.grey.shade200,
                  textStyle: GoogleFonts.notoSans(
                    color: Colors.grey.shade900,
                  ),
                )),
            ...my_messages.map((_) => BubbleSpecialOne(
                  text: _,
                  color: Theme.of(context).primaryColor,
                  textStyle: GoogleFonts.notoSans(
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),

      // bottom text field
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                maxLines: 2,
                minLines: 1,
                controller: msg,
                decoration: const InputDecoration(
                  hintText: "Enter your message here",
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () => _handleMessage(),
              icon: const Icon(Icons.send, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  _handleMessage() {
    if (msg.text.isNotEmpty) {
      setState(() {
        my_messages = [...my_messages, msg.text];
      });

      msg.clear();
    }
  }
}
