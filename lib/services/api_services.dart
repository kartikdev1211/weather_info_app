import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static const String apiKey = "be6806f74773bb40fbec251a56828247";
  static const String apiUrl =
      "https://api.openweathermap.org/data/2.5/weather";
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response =
        await http.get(Uri.parse("$apiUrl?q=$city&&appid=$apiKey"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}
