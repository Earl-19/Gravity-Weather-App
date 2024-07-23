class WeatherData {
  final double temperature;
  final String description;
  final String icon;

  WeatherData({
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'] as double,
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
    );
  }
}
