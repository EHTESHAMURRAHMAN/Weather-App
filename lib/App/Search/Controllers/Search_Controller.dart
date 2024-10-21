import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_tutorial/App/Weather/Controllers/Weather_Controllers.dart';

class SearchControllers extends GetxController {
  final WeatherController weatherController = Get.find<WeatherController>();
  final TextEditingController cityController = TextEditingController();
  final active = 0.obs;

  final List<String> famousCities =
      ['Mumbai', 'Delhi', 'Lucknow', 'Hydrabad', 'Bengaluru', 'Kolkata'].obs;

  final RxList<String> searchResults = <String>[].obs;

  Widget buttonActive(int value) {
    if (value == 1) {
      return IconButton(
          onPressed: () {
            saveCity(cityController.text).then((value) => Get.back());
          },
          icon: const Icon(Icons.search));
    } else if (value == 0) {
      return const SizedBox();
    } else {
      return const SizedBox();
    }
  }

  void check(value) {
    active.value = cityController.text.isEmpty ? 0 : 1;
  }

  void updateSearchResults(String query) {
    if (query.isEmpty) {
      searchResults.value = [];
    } else {
      searchResults.value = famousCities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', city);
    weatherController.cityName.value = city;
    weatherController.fetchWeatherByCity();
  }
}
