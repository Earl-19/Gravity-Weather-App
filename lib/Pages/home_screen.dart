import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../Services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherService _weatherService = WeatherService();
  String _temperature = '';
  String _description = '';
  String _icon = '';
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather({String? cityName}) async {
    try {
      var weatherData;
      if (cityName != null && cityName.isNotEmpty) {
        weatherData = await _weatherService.getWeatherByCity(cityName);
      } else {
        Position position = await _getCurrentLocation();
        weatherData = await _weatherService.getWeather(
            position.latitude, position.longitude);
      }
      setState(() {
        _temperature = '${weatherData['main']['temp']}°C';
        _description = weatherData['weather'][0]['description'];
        _icon = getWeatherIcon(weatherData['weather'][0]['main']);
        _loading = false;
      });
    } catch (e) {
      print('Error fetching weather: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation, secondaryAnimation) =>
                  SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
              ),
              child: Column(
                key: const ValueKey<int>(0),
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        const BlurHash(
                          hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                          imageFit: BoxFit.cover,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                _icon,
                                height: 150,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _temperature,
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                _description,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search City'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: 'Enter city name'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Search'),
              onPressed: () {
                Navigator.of(context).pop();
                _fetchWeather(cityName: _searchController.text);
              },
            ),
          ],
        );
      },
    );
  }
}

String getWeatherIcon(String condition) {
  switch (condition) {
    case 'Clear':
      return 'lib/assets/sunny-day.svg';
    case 'Clouds':
      return 'lib/assets/cloud-view.svg';
    case 'Rain':
      return 'lib/assets/icon-rain.svg';
    case 'Drizzle':
      return 'lib/assets/rainbow.svg';
    case 'Thunderstorm':
      return 'lib/assets/reshot-icon-weather-YRQ52EZUTW.svg';
    case 'Snow':
      return 'lib/assets/snowflake.svg';
    case 'Mist':
    case 'Smoke':
    case 'Haze':
    case 'Dust':
    case 'Fog':
    case 'Sand':
    case 'Ash':
    case 'Squall':
    case 'Tornado':
      return 'lib/assets/sunny-and-windy.svg';
    default:
      return 'lib/assets/weather.svg';
  }
}
