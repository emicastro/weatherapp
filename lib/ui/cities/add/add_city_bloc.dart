import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/data/data_constants.dart';
import 'package:weatherapp/data/repository/store_impl.dart';
import 'package:weatherapp/data/repository/store_repository.dart';
import 'package:weatherapp/model/city.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:weatherapp/ui/common/debouncer.dart';
import 'package:http/http.dart' as http;

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer();
  final StoreRepository storage = StoreImpl();
  List<City> cities = [];
  bool loading = false;
  String errorMessage;

  void onChangedText(String text) {
    debouncer.run(() {
      if (text.isNotEmpty) requestSearch(text);
    });
  }

  void requestSearch(String text) async {
    loading = true;
    notifyListeners();

    final url = '${API}search/?query=$text';
    final response = await http.get(url);
    final data = jsonDecode(response.body) as List;
    loading = false;

    cities = data.map((e) => City.fromJson(e)).toList();
    notifyListeners();
  }

  void addCity(City city) async {
    loading = true;
    notifyListeners();

    final url = '$API${city.id}';
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final weatherData = data['consolidated_weather'] as List;
    final weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);
    try {
      storage.saveCity(newCity);
      errorMessage = null;
    } on Exception catch (ex) {
      errorMessage = ex.toString();
    }

    loading = false;
    notifyListeners();
  }
}
