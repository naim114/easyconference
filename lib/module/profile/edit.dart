import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/specialize_area_model.dart';
import '../../model/user_model.dart';
import '../../service/helpers.dart';
import '../../service/specialize_area_service.dart';
import '../../service/user_service.dart';
import '../../widget/image_uploader.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  String roleDropdownValue = roles.first;
  String specializeDropdownValue = specialize.first;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    phoneController.text = widget.user.phone.toString();
    emailController.text = widget.user.email;
    roleDropdownValue = widget.user.role;
    specializeDropdownValue = widget.user.specializeArea == null
        ? specialize.first
        : widget.user.specializeArea!.area;
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool validate() {
    if (phoneController.text.isEmpty) {
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
                var result;

                if (roleDropdownValue == 'Presenter') {
                  print("is presenter: $specializeDropdownValue");
                  SpecializeAreaModel? getting = await SpecializeAreaService()
                      .getByArea(specializeDropdownValue)
                      .then((specializeArea) async {
                    print("is presenter2: $specializeArea");

                    final update = await UserService().update(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      role: roleDropdownValue,
                      specializeArea: specializeArea,
                      user: widget.user,
                    );

                    print("Update: $update");

                    return specializeArea;
                  });

                  if (getting != null) {
                    result = true;
                  }
                } else {
                  result = await UserService().update(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    role: roleDropdownValue,
                    user: widget.user,
                  );
                }

                if (result) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Profile update. Refresh if there is no changes.");
                  }
                } else {
                  Fluttertoast.showToast(msg: "Username or Password wrong.");
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
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ImageUploader(
                              appBarTitle: "Upload New Avatar",
                              onCancel: () => Navigator.of(context).pop(),
                              onConfirm: (imageFile, _) async {
                                final result = await UserService().updateAvatar(
                                  user: widget.user,
                                  avatar: imageToBytes(imageFile),
                                );

                                if (result) {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg:
                                            "Avatar update. Refresh if there is no changes.");
                                  }
                                }
                              },
                            ),
                          ),
                        ),
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
                                onPressed: () async {
                                  if (widget.user.avatarPath == null) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: "There is no previous avatar");
                                  } else {
                                    final result = await UserService()
                                        .removeAvatar(user: widget.user);

                                    print("Remove avatar: $result");

                                    if (result && context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg:
                                              "Avatar removed. Refresh if there is no changes.");
                                    }
                                  }
                                },
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
            child: widget.user.avatarPath == null
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.height * 0.17,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/image/default-profile-picture.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.height * 0.17,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            MemoryImage(base64Decode(widget.user.avatarPath!)),
                        fit: BoxFit.contain,
                      ),
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
              textAlign: TextAlign.center,
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
                    decoration: const InputDecoration(labelText: 'Username'),
                    readOnly: true,
                    initialValue: widget.user.username,
                  ),
                ),
                // Name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    controller: nameController,
                  ),
                ),
                // Email
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: emailController,
                  ),
                ),
                // Phone
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'PhoneNumber'),
                    controller: phoneController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                // Role
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10),
                  child: DropdownButtonFormField(
                    value: roleDropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    decoration: const InputDecoration(
                      label: Text("Role"),
                    ),
                    dropdownColor: CupertinoColors.darkBackgroundGray,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                    ),
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
                // Specialize
                roleDropdownValue == 'Presenter'
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: specializeDropdownValue,
                          decoration: const InputDecoration(
                            label: Text("Specialize"),
                          ),
                          dropdownColor: CupertinoColors.darkBackgroundGray,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                          ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
