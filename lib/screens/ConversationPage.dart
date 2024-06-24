import 'package:flutter/material.dart';
import 'package:destinymatch/widgets/ConversationCard.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Members List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const BackButton(),
                  Expanded(child: SearchBar(controller: _textController)),
                  const SizedBox(width: 10),
                  IconButton(icon: const Icon(Icons.search), onPressed: () {})
                ],
              ),
            ),
            Expanded(child: Conversationcard()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Navigator.pushNamed(context, '/chat');
            print("hello");
          },
          child: const Icon(Icons.chat),
        ));
  }
}
