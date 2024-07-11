import 'package:flutter/material.dart';
import 'package:flutter_chats_app/screens/login_screen.dart';
import 'package:flutter_chats_app/utils/app_colors.dart';
import 'package:flutter_chats_app/widgets/round_gradient_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/welcome_promo.png",
                width: media.width * 0.80,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: media.width*0.05,),
              const Text(
                "Welcome",
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: media.width * 0.03),
              const Text(
                "You are all set now, let's chat with\nyour loved ones",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grayColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: media.width * 0.15),
              RoundGradientButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    )
                  );
                },
                title: "Get Started",
              )
            ],
          ),
        ),
      ),
    );
  }
}