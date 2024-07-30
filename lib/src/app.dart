
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HomePage.dart';
import 'constants/dark_theme.dart';
import 'constants/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   /* precacheImage(
        Image.asset(
          "assets/images/baptiste_debout.png",
          fit: BoxFit.fitHeight,
        ).image,
        context);*/
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.system,
      home: Scaffold(

        // backgroundColor: TcColors.white,
        body: MyHomePage(),
      ),
    );
  }
}
