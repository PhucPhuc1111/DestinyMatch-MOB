import 'package:flutter/material.dart';
import 'package:flutter_chats_app/screens/home_screen.dart';
import 'package:flutter_chats_app/screens/registerMember_screen.dart';
import 'package:flutter_chats_app/screens/signup_screen.dart';
import 'package:flutter_chats_app/services/AccountService.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/round_gradient_button.dart';
import 'package:flutter_chats_app/widgets/round_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
Future<void> Login(BuildContext context, String email, String password) async {
  final Accountservice accountService = Accountservice();

 
  bool loginSuccess = await accountService.login(email, password);

  if (loginSuccess) {
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    
    if (userId != null && await accountService.checkAccountExists(userId)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterMemberScreen(accountId: userId ?? ''),
        ),
      );
    }
  } else {
    print("Login failed");
  }
}


class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isObsecure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: media.height * 0.1,
                  ),
                  SizedBox(
                    width: media.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: media.width * 0.03,
                        ),
                        const Text(
                          "Hey there",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.01,
                        ),
                        const Text(
                          "Welcome Back",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: media.width * 0.1),
                  RoundTextField(
                    
                    textEditingController: _emailController,
                    hintText: "email",
                    icon: "assets/icons/message_icon.png",
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your email";
                      }
                      return null;
                    },
                    
                  ),
                  SizedBox(height: media.width * 0.05),
                  RoundTextField(
                    textEditingController: _passController,
                    hintText: "password",
                    icon: "assets/icons/lock_icon.png",
                    textInputType: TextInputType.text,
                    isObsecureText: _isObsecure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your pass";
                      } else if (value.length < 6) {
                        return "pass must be at least 6 characters long";
                      }
                      return null;
                    },
                    rightIcon: TextButton(
                      onPressed: () {
                        setState(() {
                          _isObsecure = !_isObsecure;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          _isObsecure
                              ? "assets/icons/show_pwd_icon.png"
                              : "assets/icons/hide_pwd_icon.png",
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //   Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ChangePassWord(),
                        //     )
                        // );
                      },
                      child: const Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                          color: AppColors.secondaryColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: media.width * 0.1),
                  RoundGradientButton(
                      title: "Đăng nhập",
                      onPressed: () {
                        Login(context, _emailController.text,
                            _passController.text);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => HomeScreen(),
                        //     ));
                      }),
                  SizedBox(height: media.width * 0.05),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: AppColors.grayColor.withOpacity(0.5),
                        ),
                      ),
                      const Text(
                        "   Hoặc   ",
                        style: TextStyle(
                          color: AppColors.grayColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          height: 1,
                          color: AppColors.grayColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: media.width * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primaryColor1.withOpacity(0.5),
                                width: 1,
                              )),
                          child: Image.asset(
                            "assets/icons/google_icon.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: media.width * 0.08),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primaryColor1.withOpacity(0.5),
                                width: 1,
                              )),
                          child: Image.asset(
                            "assets/icons/facebook_icon.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: media.width * 0.08),

                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(text: "Chưa có tài khoản?    "),
                            TextSpan(
                                text: "Đăng ký ngay",
                                style: TextStyle(
                                  color: AppColors.secondaryColor1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                          ],
                        ),
                      )
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
