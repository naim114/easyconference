import 'package:easyconference/model/specialize_area_model.dart';
import 'package:easyconference/module/auth/login.dart';
import 'package:easyconference/service/specialize_area_service.dart';
import 'package:easyconference/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final emailController = TextEditingController();
  final instituteController = TextEditingController();

  String roleDropdownValue = roles.first;
  String specializeDropdownValue = specialize.first;

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    nameController.dispose();
    instituteController.dispose();
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
    } else if (emailController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email is empty. Please enter all information.");

      return false;
    } else if (instituteController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Institute is empty. Please enter all information.");

      return false;
    } else if (!validateEmail(emailController.text)) {
      Fluttertoast.showToast(msg: "Invalid email format.");

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              "Sign up",
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
              controller: rePasswordController,
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
              controller: emailController,
              icon: const Icon(CupertinoIcons.mail),
              labelText: 'Email',
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
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CustomTextField(
              controller: instituteController,
              icon: const Icon(CupertinoIcons.building_2_fill),
              labelText: 'Institute',
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
                    value: specializeDropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.science),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white,
                      label: Text("Specialize"),
                      filled: true,
                    ),
                    dropdownColor: CupertinoColors.lightBackgroundGray,
                    style: const TextStyle(color: CustomColor.neutral1),
                    onChanged: (String? value) {
                      setState(() {
                        specializeDropdownValue = value!;
                      });
                    },
                    items: specialize
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
            onPressed: () async {
              if (validate()) {
                var result;

                if (roleDropdownValue == 'Presenter') {
                  print("is presenter: $specializeDropdownValue");
                  SpecializeAreaModel? getting = await SpecializeAreaService()
                      .getByArea(specializeDropdownValue)
                      .then((specializeArea) async {
                    print("is presenter2: $specializeArea");

                    final signUp = await UserService().signUp(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      role: roleDropdownValue,
                      username: usernameController.text,
                      password: passwordController.text,
                      specializeArea: specializeArea,
                      institute: instituteController.text,
                    );

                    print("Sign Up: $signUp");

                    return specializeArea;
                  });

                  if (getting != null) {
                    result = true;
                  }
                } else {
                  result = await UserService().signUp(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    role: roleDropdownValue,
                    username: usernameController.text,
                    password: passwordController.text,
                    specializeArea: null,
                    institute: instituteController.text,
                  );
                }

                if (result) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const Login(),
                      ),
                    );
                    Fluttertoast.showToast(
                        msg:
                            "Sign up success! Please log in first to continue");
                  }
                } else {
                  Fluttertoast.showToast(msg: "Username or Password wrong.");
                }
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
