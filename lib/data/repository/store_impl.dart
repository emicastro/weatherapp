import 'dart:convert';

import 'package:weatherapp/data/repository/store_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/model/city.dart';

const keyCities = 'cities';
const keyLastUpdate = 'last_update';

class StoreImpl extends StoreRepository {
  @override
  Future<List<City>> getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(keyCities);
    if (list != null && list.isNotEmpty) {
      final cities = list
          .map(
            (e) => City.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
      return cities;
    }
    return <City>[];
  }

  @override
  Future<void> saveCity(City city) async {
    final list = await getCities();
    for (City item in list) {
      if (item.id == city.id) {
        throw Exception('City already exists');
      }
    }
    list.add(city);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        keyCities, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  @override
  Future<void> saveCities(List<City> cities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      keyCities,
      cities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<DateTime> getLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getInt(keyLastUpdate);
    if (data != null && data > 0) {
      return DateTime.fromMillisecondsSinceEpoch(data);
    }
    return null;
  }

  @override
  Future<void> saveLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyLastUpdate, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> deleteCity(City city) async {
    final cities = await getCities();
    cities.removeWhere((element) => element.id == city.id);
    saveCities(cities);
  }
}
