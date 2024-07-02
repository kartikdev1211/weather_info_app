// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_info/model/weather_model.dart';
import 'package:weather_info/services/api_services.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;
  final ApiServices _apiServices = ApiServices();
  Future<void> fetchData(String city) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _apiServices.fetchWeather(city);
      _weather = Weather.fromJson(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lastCity', city);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadLastCityWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('lastCity');
    if (lastCity != null) {
      fetchData(lastCity);
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
