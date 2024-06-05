import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:destinymatch/main.dart';
import 'package:destinymatch/services/AccountService.dart';
import 'package:destinymatch/services/AccountService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final response = await _accountservice.login(email, password);

    if (response.containsKey('error')) {
      // Xử lý lỗi đăng nhập
      print(response['error']);
    } else {
      // Xử lý đăng nhập thành công
      print('Login successful: $response');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                title:
                    "hellow")), // Thay MyHomePage bằng tên widget của trang bạn muốn điều hướng đến
      );

      // Lưu token hoặc dữ liệu cần thiết khác
    }
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images.jpg'),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
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
        ],
      ),
    );
  }
}
