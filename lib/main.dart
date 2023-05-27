import 'package:easyconference/module/auth/frame.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const AuthFrame(),
    );
  }
}
