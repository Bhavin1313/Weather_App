import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class One_Time_Intro_Page extends StatefulWidget {
  const One_Time_Intro_Page({super.key});

  @override
  State<One_Time_Intro_Page> createState() => _One_Time_Intro_PageState();
}

class _One_Time_Intro_PageState extends State<One_Time_Intro_Page> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: IntroductionScreen(
        globalBackgroundColor: Colors.blue.withOpacity(.2),
        pages: [
          PageViewModel(
            titleWidget: const Text(
              "Weather App",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            bodyWidget: Container(
              height: h * .75,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("lib/Components/Assets/weather_app1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Text(
              "Weather App",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            bodyWidget: Container(
              height: h * .75,
              width: w,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("lib/Components/Assets/weather_app2.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Text(
              "Weather App",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            bodyWidget: Container(
              height: h * .75,
              width: w,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("lib/Components/Assets/weather_app3.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Text(
              "Weather App",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            bodyWidget: Container(
              height: h * .75,
              width: w,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("lib/Components/Assets/3.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          PageViewModel(
            titleWidget: const Text(
              "Content Diary App",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            bodyWidget: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("lib/Components/Assets/1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        showNextButton: true,
        next: const Text("Next"),
        done: const Text("Start"),
        onDone: () async {
          Navigator.pushReplacementNamed(context, 'splesh');
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("visited", true);
        },
      ),
    );
  }
}
