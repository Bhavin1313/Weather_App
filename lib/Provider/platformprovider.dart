import 'package:flutter/cupertino.dart';
import '../Model/platformmodel.dart';

class PlatformProvider extends ChangeNotifier {
  ChangePlatform changePlatform = ChangePlatform(isios: false);

  void ConvertPlatform() {
    changePlatform.isios = !changePlatform.isios;
    notifyListeners();
  }
}
