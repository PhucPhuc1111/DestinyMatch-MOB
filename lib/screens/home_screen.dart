import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chats_app/screens/AllChats_screen.dart';
import 'package:flutter_chats_app/screens/home_cart_screen.dart';
import 'package:flutter_chats_app/screens/user_profile.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeCartScreen(),
    const AllChatScreen(),
    Container(),
    const UserProfile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor2,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_fill), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Pfofile"),
        ],
      ),
    );
  }
}
