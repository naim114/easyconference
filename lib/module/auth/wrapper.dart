import 'package:easyconference/model/specialize_area_model.dart';
import 'package:easyconference/module/auth/index.dart';
import 'package:easyconference/service/seeders.dart';
import 'package:easyconference/widget/scaffold_loader.dart';
import 'package:flutter/material.dart';

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
    return FutureBuilder(
      future: Future.wait([
        SpecializeAreaService().getAll(),
        UserService().getAll(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return scaffoldLoader();
        }

        print("all special: ${snapshot.data![0]}");
        print("all user: ${snapshot.data![1]}");

        if (snapshot.data![0].isEmpty) {
          seed(snapshot.data![1].isEmpty);
        }

        return const AuthIndex();
      },
    );
  }

  void seed(bool userEmpty) async {
    await specializeAreaSeeder().then((value) async {
      if (userEmpty) {
        await userSeeders();
      }
    });
  }
}
