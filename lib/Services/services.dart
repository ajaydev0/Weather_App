import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "b79f9a0c731d4eaa89325056242705";
  final String forecastBaseUrl = "http://api.weatherapi.com/v1/forecast.json";
  final String searchBaseUrl = "http://api.weatherapi.com/v1/search.json";

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=1&aqi=no&alerts=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to Load Weather Data");
    }
  }

  Future<Map<String, dynamic>> fetch7DaysForecast(String city) async {
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=7&api=no&alerts=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to Load Forecast Data");
    }
  }

  Future<List<dynamic>?> fetchCitySuggestion(String city) async {
    final url = '$searchBaseUrl?key=$apiKey&q=$city';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
// Get Storage Box
GetStorage box = GetStorage();


