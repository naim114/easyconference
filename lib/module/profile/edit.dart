import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/helpers.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();

  String roleDropdownValue = roles.first;
  String specializeDropdownValue = specialize.first;

  @override
  void dispose() {
    passwordController.dispose();
    rePasswordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

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
          // Avatar
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: CupertinoColors.darkBackgroundGray,
                builder: (context) {
                  return Wrap(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.image_outlined),
                        title: const Text('New avatar'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.delete_outline,
                          color: CustomColor.danger,
                        ),
                        title: const Text(
                          'Remove current picture',
                          style: TextStyle(color: CustomColor.danger),
                        ),
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                                'Are you sure you want to remove your avatar?'),
                            content: const Text(
                                'Deleted data can\'t be retrieve back. Select OK to delete.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: CustomColor.danger),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.17,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.height * 0.17,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/image/default-profile-picture.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Tap Image to Edit Avatar',
                    style: TextStyle(
                      color: CustomColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Username here",
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: null, // TODO
                  ),
                ),
                // Name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Name here",
                    decoration: const InputDecoration(labelText: 'Name'),
                    controller: null, // TODO
                  ),
                ),

                // Phone
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Phone here",
                    decoration: const InputDecoration(labelText: 'PhoneNumber'),
                    controller: null, // TODO
                  ),
                ),
                // Role
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "Role here",
                    decoration: const InputDecoration(labelText: 'Role'),
                    controller: null, // TODO
                  ),
                ),
                // Specialize
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: "specialize here",
                    decoration: const InputDecoration(labelText: 'specialize'),
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
