import 'package:flutter/material.dart';
import '../Model/theammodel.dart';

class Themeprovider extends ChangeNotifier {
  Thememodel theme = Thememodel(isdark: true);
  void changetheme() {
    theme.isdark = !theme.isdark;
    notifyListeners();
  }
}
