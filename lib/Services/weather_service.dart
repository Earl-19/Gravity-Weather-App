import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '35e48f639d31fb3f53ac30e814bb6bb5';
  static const String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey"),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> getWeatherByCity(String cityName) async {
    final response = await http
        .get(Uri.parse('$apiUrl?q=$cityName&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
