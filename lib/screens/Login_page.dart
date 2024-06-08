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
    await _accountservice.login(email, password);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const MyHomePage(
              title:
                  "hello")), // Thay MyHomePage bằng tên widget của trang bạn muốn điều hướng đến
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Login Page")),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image.asset(
  //             'assets/logo.png', // Đường dẫn đến logo của bạn
  //             height: 100.0,
  //             width: 100.0,
  //           ),
  //           SizedBox(height: 20.0),
  //           Form(
  //             key: _formKey,
  //             child: Column(
  //               children: <Widget>[
  //                 TextFormField(
  //                   controller: _emailController,
  //                   decoration: const InputDecoration(
  //                     labelText: 'Email',
  //                     border: OutlineInputBorder(),
  //                   ),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter your email';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 SizedBox(height: 20.0),
  //                 TextFormField(
  //                   controller: _passwordController,
  //                   decoration: const InputDecoration(
  //                     labelText: 'Password',
  //                     border: OutlineInputBorder(),
  //                   ),
  //                   obscureText: true,
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter your password';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 SizedBox(height: 20.0),
  //                 ElevatedButton(
  //                   onPressed: () async {
  //                     if (_formKey.currentState!.validate()) {
  //                       // Xử lý đăng nhập ở đây
  //                       // print('Email: ${_emailController.text}');
  //                       // print('Password: ${_passwordController.text}');
  //                       login(_emailController.text, _passwordController.text);
  //                     }
  //                   },
  //                   child: Text('Login'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
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
