import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayertimes/constants/apiString.dart';
import 'package:prayertimes/models/weather.dart';

class APIService {
  Future<PrayerTimes> getPrayerInfo(String month, String year) async {
    var client = http.Client();
    var prayerInfo = null;
    try {
      var response = await client.get(
        Uri.parse(
          ApiString.getApiUrl('2', '2022'),
        ),
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        prayerInfo = PrayerTimes.fromJson(jsonMap);
      }
    } catch (ex) {}
    return prayerInfo;
  }
}
