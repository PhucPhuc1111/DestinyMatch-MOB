import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:destinymatch/main.dart';
import 'package:destinymatch/services/AccountService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginFunction();
}

class LoginFunction extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Accountservice _accountservice = Accountservice();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await _accountservice.login(context, email, password);
  }

  Future<void> _checkIfLoggedIn() async {
    bool isLoggedIn = await _accountservice.checkAccountLogin();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: "hello")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images.jpg'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Forgot password?",
                  style: TextStyle(
                      color: Colors.blue[300],
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue[600])),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // button's shape
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white), // Thay đổi màu chữ sang màu vàng
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 50,
              height: 50,
              padding:
                  EdgeInsets.all(8), // Khoảng cách bên trong để cân đối logo
              decoration: BoxDecoration(
                color: Colors.white, // Màu nền trắng
                borderRadius: BorderRadius.circular(8), // Bo góc
                border: Border.all(color: Colors.grey, width: 1), // Viền
              ),
              child: Image.asset(
                'assets/googleLogo.png', // Đường dẫn đến hình ảnh Google icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
