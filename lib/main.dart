import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/Screens/homepage.dart';
import 'Views/Screens/one_timt_intro.dart';
import 'Views/Screens/splesh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool isVisitOnce = preferences.getBool("visited") ?? false;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: (isVisitOnce == true) ? 'home' : '/',
      routes: {
        '/': (context) => const One_Time_Intro_Page(),
        'splesh': (context) => Splash(),
        'home': (context) => HomePage(),
      },
    ),
  );
}
