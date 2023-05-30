import 'package:easyconference/module/auth/login.dart';
import 'package:easyconference/module/auth/sign_up.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:easyconference/widget/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class AuthIndex extends StatelessWidget {
  const AuthIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "EasyConference",
          style: TextStyle(
            color: CustomColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SvgPicture.asset(
                  'assets/image/poster.svg',
                  semanticsLabel: 'Conference Made Easy',
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
              ),
              const Text(
                'Conference Made Easy with EasyConference',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              child: Column(
                children: [
                  customPillButton(
                    context: context,
                    borderColor: Colors.white,
                    fillColor: Colors.white,
                    onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const Login(),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: CustomColor.neutral1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  customPillButton(
                    context: context,
                    borderColor: CustomColor.primary,
                    fillColor: CustomColor.primary,
                    onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const SignUp(),
                      ),
                    ),
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
