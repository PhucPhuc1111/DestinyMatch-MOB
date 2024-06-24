import 'package:flutter/material.dart';
import 'package:destinymatch/screens/ConversationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _curIndex = 0;

  final List<Widget> _tabs = [
    ConversationPage(),
    const Center(
      child: Text(
        "Love",
        style: TextStyle(fontSize: 30),
      ),
    ),
    const Center(
      child: Text(
        "Profile",
        style: TextStyle(fontSize: 30),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _tabs[_curIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        fixedColor: Colors.red,
        iconSize: 22,
        selectedFontSize: 17,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Love",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "Profile",
          ),
        ],
        currentIndex: _curIndex,
        onTap: (index) {
          setState(() {
            _curIndex = index;
          });
        },
      ),
    );
  }
}
