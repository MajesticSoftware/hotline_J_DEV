import 'package:get/get.dart';

class SelectGameController extends GetxController {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    update();
  }
}
