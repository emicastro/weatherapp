import 'package:flutter/material.dart';
import 'package:weatherapp/data/repository/api_repository.dart';
import 'package:weatherapp/data/repository/store_repository.dart';
import 'package:weatherapp/model/city.dart';
import 'package:weatherapp/ui/common/debouncer.dart';

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer();
  final StoreRepository storage;
  final ApiRepository apiService;
  List<City> cities = [];
  bool loading = false;
  String errorMessage;

  AddCityBloc({
    @required this.storage,
    @required this.apiService,
  });

  void onChangedText(String text) {
    debouncer.run(
      () {
        if (text.isNotEmpty) requestSearch(text);
      },
    );
  }

  void requestSearch(String text) async {
    loading = true;
    notifyListeners();

    cities = await apiService.getCities(text);

    loading = false;
    notifyListeners();
  }

  Future<bool> addCity(City city) async {
    loading = true;
    notifyListeners();
    final newCity = await apiService.getWeathers(city);
    try {
      await storage.saveCity(newCity);
      errorMessage = null;
      return true;
    } on Exception catch (ex) {
      errorMessage = ex.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
