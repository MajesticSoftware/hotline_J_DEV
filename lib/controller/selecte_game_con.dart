import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotlines/model/nfl_rushing_ranking_model.dart';

import '../constant/constant.dart';
import '../model/response_item.dart';
import '../network/game_repo.dart';
import '../theme/helper.dart';

class SelectGameController extends GetxController {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    update();
  }
}
