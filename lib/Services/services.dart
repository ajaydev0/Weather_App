import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class WeatherService {
  final String apiKey = "b79f9a0c731d4eaa89325056242705";
  final String forecastBaseUrl = "";
  final String searchBaseUrl = "";

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=1&api=no&alerts=no';
    final url2 = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';
    final response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
            print("If  Part");
      return json.decode(response.body);
    } else {
      print("ELse Part");
      throw Exception("Failed to Load Weather Data");
    }
  }

  Future<Map<String, dynamic>> fetch7DaysForecast(String city) async {
    final Url = '$searchBaseUrl?key=$apiKey&q=$city&days=7&api=no&alerts=no';
    final response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to Load Forecast Data");
    }
  }

  Future<List<dynamic>?> fetchCitySuggestion(String query) async {
    final Url = '$searchBaseUrl?key=$apiKey&q=$query';
    final response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
