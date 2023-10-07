import 'package:flutter/material.dart';

import 'Views/Screens/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/': (context) => HomePage(),
      },
    ),
  );
}
