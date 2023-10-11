import 'dart:async';

import 'package:flutter/material.dart';

class SplashIos extends StatefulWidget {
  const SplashIos({super.key});

  @override
  State<SplashIos> createState() => _SplashIosState();
}

class _SplashIosState extends State<SplashIos> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, 'homeios');
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "lib/Components/Assets/preview.gif",
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
