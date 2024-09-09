import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:wheather/models/weather_model.dart';
import 'package:wheather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
//api key
  // ignore: non_constant_identifier_names
  final _WeatherService = WeatherService('23474f85c62938615d08f2d30942d65e');
  Weather? _weather;

//fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _WeatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any errors
    catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assests/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assests/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assests/rain.json';
      case 'thunderstorm':
        return 'assests/thunder.json';
      case 'clear':
        return 'assests/sunny.json';

      default:
        return 'assests/sunny.json';
    }
  }

//weather animation

//init state
  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "Loading city...."),
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round()}"C"'),
            //weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}

