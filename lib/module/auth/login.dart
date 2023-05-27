import 'package:easyconference/module/auth/sign_up.dart';
import 'package:easyconference/module/frame.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../widget/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  bool validate() {
    if (usernameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Username is empty. Please enter all information.");

      return false;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Password is empty. Please enter all information.");

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                "Log in",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomTextField(
                controller: usernameController,
                icon: const Icon(CupertinoIcons.at),
                labelText: 'Username',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: CustomTextField(
                controller: passwordController,
                icon: const Icon(CupertinoIcons.padlock),
                labelText: 'Password',
                isPassword: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const Frame(),
                    ),
                    (route) => false,
                  );
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(
                  double.infinity,
                  55,
                )),
                backgroundColor:
                    MaterialStateProperty.all<Color>(CustomColor.primary),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const SignUp(),
                  ),
                );
              },
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: CustomColor.neutral2),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(color: CustomColor.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
