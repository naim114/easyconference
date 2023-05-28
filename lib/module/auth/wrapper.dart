import 'package:easyconference/module/auth/index.dart';
import 'package:easyconference/module/frame.dart';
import 'package:easyconference/service/auth_service.dart';
import 'package:easyconference/widget/scaffold_loader.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../service/db_service.dart';
import '../../service/specialize_area_service.dart';
import '../../service/user_service.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  void initDb() async {
    await DBService.instance.database;
  }

  void checkDB() async {
    //  Specialize Area Seeder
    print("All Specialize Area: ${await SpecializeAreaService().getAll()}");

    // User Seeder
    print("All User: ${await UserService().getAll()}");
  }

  @override
  void initState() {
    initDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO check if user logged in
    return FutureBuilder<UserModel?>(
      future: AuthService().getLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return scaffoldLoader();
        }

        UserModel? user = snapshot.data;

        print("logged in: $user");

        return user == null ? const AuthIndex() : Frame(user: user);
      },
    );
  }
}
