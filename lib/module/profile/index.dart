import 'dart:convert';

import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/module/profile/edit.dart';
import 'package:easyconference/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widget/scaffold_loader.dart';

class Profile extends StatefulWidget {
  final UserModel user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  UserModel? userState;

  Future<void> _refreshData() async {
    try {
      final UserModel fetchedData = await UserService().get(widget.user.id);

      setState(() {
        userState = fetchedData;
      });

      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Get User:  ${e.toString()}");
    }

    setState(() {});
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: userState == null
          ? scaffoldLoader()
          : Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileEdit(user: userState!),
                    )),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  // Avatar // TODO change this to user image
                  userState!.avatarBytes == null
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
                              image: MemoryImage(
                                  base64Decode(userState!.avatarBytes!)),
                              fit: BoxFit.contain,
                            ),
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
                            initialValue: userState!.username,
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            readOnly: true,
                          ),
                        ),
                        // Name
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            initialValue: userState!.name,
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            readOnly: true,
                          ),
                        ),
                        // Email
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            initialValue: userState!.email,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            readOnly: true,
                          ),
                        ),
                        // Phone
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            initialValue: userState!.phone.toString(),
                            decoration:
                                const InputDecoration(labelText: 'PhoneNumber'),
                            readOnly: true,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        // Role
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            initialValue: userState!.role,
                            decoration:
                                const InputDecoration(labelText: 'Role'),
                            readOnly: true,
                          ),
                        ),
                        // Specialize
                        userState!.role == 'Presenter'
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  initialValue:
                                      userState!.specializeArea == null
                                          ? "None"
                                          : userState!.specializeArea?.area,
                                  decoration: const InputDecoration(
                                      labelText: 'Specialize'),
                                  readOnly: true,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
