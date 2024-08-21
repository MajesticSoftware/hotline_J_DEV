import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MetricTracking {
  void incrementCounter(String sportsbook) async {
    try{
      await http.patch(
        Uri.parse('${dotenv.env['METRIC_DB_URL']}sportsbooks/incrementBooksNumber'),
        headers: {
          'Content-Type': 'application/json',
          'auth-token': '${dotenv.env['METRIC_DB_ACCESS_TOKEN']}'
        },
        body: jsonEncode({
          "sportsbook": sportsbook
        })
      );
    }
    catch(e){
      //
    }
  }
}