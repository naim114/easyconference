import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../service/auth_service.dart';
import '../../service/helpers.dart';
import '../auth/wrapper.dart';

class Account extends StatefulWidget {
  const Account({super.key, required this.user});
  final UserModel user;

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final newUsernameController = TextEditingController();
  final newPasswordController = TextEditingController();
  final oldUsernameController = TextEditingController();
  final oldPasswordController = TextEditingController();

  @override
  void dispose() {
    newUsernameController.dispose();
    newPasswordController.dispose();
    oldUsernameController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  bool validate() {
    if (newUsernameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "New Username is empty. Please enter all information.");

      return false;
    } else if (newPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "New Password is empty. Please enter all information.");

      return false;
    } else if (oldUsernameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Old Username is empty. Please enter all information.");

      return false;
    } else if (oldPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Old Password is empty. Please enter all information.");

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              if (validate()) {
                final login = await AuthService().logIn(
                  username: oldUsernameController.text,
                  password: oldPasswordController.text,
                );

                if (login) {
                  final result = await UserService().updateAuth(
                    user: widget.user,
                    newUsername: newUsernameController.text,
                    newPassword: newPasswordController.text,
                  );

                  if (result) {
                    Fluttertoast.showToast(
                        msg:
                            "Username and Password updated. Please log in again to continue.");

                    final logout = await AuthService().logOut();

                    print("logout: $logout");

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthWrapper(),
                        ),
                        (route) => false,
                      );
                    }
                  }
                } else {
                  Fluttertoast.showToast(msg: "Wrong username or password.");
                }
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: CustomColor.primary),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const Text(
                    "To update username and password user need to login first then press Confirm at top right."),
                // New Username
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'New Username'),
                    controller: newUsernameController,
                  ),
                ),
                // New Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                    controller: newPasswordController,
                  ),
                ),
                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: oldUsernameController,
                  ),
                ),
                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: oldPasswordController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
