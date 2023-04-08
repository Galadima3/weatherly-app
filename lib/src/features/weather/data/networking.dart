import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weatherly/src/features/weather/domain/city_weather_model.dart';

import 'package:weatherly/src/features/weather/domain/weather_model_x.dart';

class WeatherNetworking {
  Future<Position> getLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disable');
      }
      LocationPermission permission = await Geolocator.checkPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location Permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location Permissions are permanently denied. We cannot process your request');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WeatherModelX> getWeatherData() async {
    final position = await getLocationPermission();

    try {
      var uri =
          'https://api.weatherapi.com/v1/forecast.json?key=29f397a4d03f4fc8b4e122621230404&q=${position.longitude},${position.longitude}&days=7&aqi=no&alerts=no';
      // var uri =
      //     'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=18966628b08a83615fea91c56f19fb3c&units=metric';
      var url = Uri.parse(uri);
      var response = await get(url);

      return WeatherModelX.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<CityWeatherModel> getCityWeather(String cityName) async {
    try {
      var uri =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=18966628b08a83615fea91c56f19fb3c&units=metric';
      var url = Uri.parse(uri);
      var response = await get(url);
      return CityWeatherModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw (e.toString());
    }
  }
}

final weatherProvider = Provider<WeatherNetworking>((ref) {
  return WeatherNetworking();
});

final weatherDetailsProvider = FutureProvider((ref) async {
  return ref.watch(weatherProvider).getWeatherData();
});

final cityWeatherDetailsProvider =
    FutureProvider.family<CityWeatherModel, String>((ref, cityName) {
  return ref.watch(weatherProvider).getCityWeather(cityName);
});
