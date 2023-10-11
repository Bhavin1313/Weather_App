import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_pr/Components/Utils/mytheam.dart';
import 'package:weather_app_pr/Views/ios/homeios.dart';

import 'Provider/platformprovider.dart';
import 'Provider/theamprovider.dart';
import 'Views/Screens/homepage.dart';
import 'Views/Screens/one_timt_intro.dart';
import 'Views/Screens/splesh_screen.dart';
import 'Views/ios/iossplesh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool isVisitOnce = preferences.getBool("visited") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<PlatformProvider>(
          create: (context) => PlatformProvider(),
        ),
        ListenableProvider<Themeprovider>(
          create: (context) => Themeprovider(),
        ),
      ],
      builder: (context, child) => (Provider.of<PlatformProvider>(context)
                  .changePlatform
                  .isios ==
              false)
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: myTheam.lightTheme,
              darkTheme: myTheam.darkTheme,
              themeMode:
                  (Provider.of<Themeprovider>(context).theme.isdark == false)
                      ? ThemeMode.light
                      : ThemeMode.dark,
              initialRoute: (isVisitOnce == true) ? 'splesh' : '/',
              routes: {
                '/': (context) => const One_Time_Intro_Page(),
                'splesh': (context) => Splash(),
                'home': (context) => HomePage(),
              },
            )
          : CupertinoApp(
              debugShowCheckedModeBanner: false,
              theme: MaterialBasedCupertinoThemeData(
                materialTheme:
                    (Provider.of<Themeprovider>(context).theme.isdark == false)
                        ? ThemeData(
                            brightness: Brightness.light,
                          )
                        : ThemeData(
                            brightness: Brightness.dark,
                          ),
              ),
              routes: {
                '/': (context) => SplashIos(),
                'homeios': (context) => HomeIos(),
              },
            ),
    ),
  );
}
