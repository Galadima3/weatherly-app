import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:weatherly/src/features/search/domain/search_model.dart';

class CityWeatherNetworking{
  Future<SearchWeatherModel> getCityWeather(String cityName) async {
    try {
      var uri =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=18966628b08a83615fea91c56f19fb3c&units=metric';
      var url = Uri.parse(uri);
      var response = await get(url);
      log(response.body);
      return SearchWeatherModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw (e.toString());
    }
  }
}