import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/data/data_constants.dart';
import 'package:weatherapp/model/city.dart';
import 'package:weatherapp/ui/common/debouncer.dart';
import 'package:http/http.dart' as http;

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer();
  List<City> cities = [];
  bool loading = false;

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
}
