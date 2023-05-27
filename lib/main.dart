import 'package:easyconference/module/auth/wrapper.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:easyconference/service/seeders.dart';
import 'package:easyconference/service/specialize_area_service.dart';
import 'package:easyconference/service/user_service.dart';
import 'package:easyconference/widget/scaffold_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyConference',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        scaffoldBackgroundColor: CustomColor.bg,
        appBarTheme: AppBarTheme(
          backgroundColor: CustomColor.bg,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
          ),
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        canvasColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: CupertinoColors.darkBackgroundGray,
        ),
      ),
      home: FutureBuilder(
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

          return const AuthWrapper();
        },
      ),
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
