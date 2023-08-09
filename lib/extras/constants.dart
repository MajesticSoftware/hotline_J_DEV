import 'package:flutter/material.dart';

Map<String, String> requestHeader() {
  return {
    // 'X-RapidAPI-Key': '6dd1587895msh5f0c2263a5686aap120b34jsne9263cbd71ed',
    'X-RapidAPI-Key': '08caae6c2bmsh572aebe4b01a829p14475ejsn8e6b0956f735',
    'X-RapidAPI-Host': 'sportspage-feeds.p.rapidapi.com'
  };
}

final modileView = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
