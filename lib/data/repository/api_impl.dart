import 'dart:convert';

import 'package:weatherapp/data/data_constants.dart';
import 'package:weatherapp/data/repository/api_repository.dart';
import 'package:weatherapp/model/city.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather.dart';

class ApiImpl extends ApiRepository {
  @override
  Future<List<City>> getCities(String text) async {
    final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();
    return cities;
  }

  @override
  Future<City> getWeathers(City city) async {
    final url = '$api${city.id}';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weathersData = data['consolidated_weather'] as List;
    final weathers = weathersData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);
    return newCity;
  }
}
