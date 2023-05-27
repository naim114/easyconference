import 'package:easyconference/module/auth/wrapper.dart';
import 'package:easyconference/service/helpers.dart';
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
      home: const AuthWrapper(),
    );
  }
}
