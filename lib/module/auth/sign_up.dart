import 'package:easyconference/module/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../service/helpers.dart';
import '../../widget/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String roleDropdownValue = roles.first;
  String expertisetDropdownValue = expertise.first;

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    nameController.dispose();
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
    } else if (rePasswordController.text != passwordController.text) {
      Fluttertoast.showToast(
          msg: "Password and Re-enter password has to be the same value.");

      return false;
    } else if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Phone Number is empty. Please enter all information.");

      return false;
    } else if (nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Name is empty. Please enter all information.");

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
                "Sign in",
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
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CustomTextField(
                controller: passwordController,
                icon: const Icon(CupertinoIcons.padlock),
                labelText: 'Password',
                isPassword: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CustomTextField(
                controller: passwordController,
                icon: const Icon(CupertinoIcons.padlock),
                labelText: 'Re-enter Password',
                isPassword: true,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CustomTextField(
                controller: nameController,
                icon: const Icon(CupertinoIcons.person),
                labelText: 'Name',
                isPassword: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CustomTextField(
                controller: phoneController,
                icon: const Icon(CupertinoIcons.phone),
                labelText: 'Phone Number',
                isPassword: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: DropdownButtonFormField(
                value: roleDropdownValue,
                icon: const Icon(Icons.arrow_downward),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white,
                  label: Text("Role"),
                  filled: true,
                ),
                dropdownColor: CupertinoColors.lightBackgroundGray,
                style: const TextStyle(color: CustomColor.neutral1),
                onChanged: (String? value) {
                  setState(() {
                    roleDropdownValue = value!;
                  });
                },
                items: roles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            roleDropdownValue == 'Presenter'
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: DropdownButtonFormField(
                      value: expertisetDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.science),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white,
                        label: Text("Expertise"),
                        filled: true,
                      ),
                      dropdownColor: CupertinoColors.lightBackgroundGray,
                      style: const TextStyle(color: CustomColor.neutral1),
                      onChanged: (String? value) {
                        setState(() {
                          expertisetDropdownValue = value!;
                        });
                      },
                      items: expertise
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO
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
                    type: PageTransitionType.rightToLeft,
                    child: const Login(),
                  ),
                );
              },
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: CustomColor.neutral2),
                    ),
                    TextSpan(
                      text: 'Login',
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
