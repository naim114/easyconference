import 'package:flutter/material.dart';

import '../../service/helpers.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
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
                    controller: null, // TODO
                  ),
                ),
                // New Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                    controller: null, // TODO
                  ),
                ),
                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: null, // TODO
                  ),
                ),
                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: null, // TODO
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
