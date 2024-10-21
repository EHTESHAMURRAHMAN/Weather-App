import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_tutorial/App/Functions/consts.dart';

class WeatherController extends GetxController {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  final sun =
      "https://static.vecteezy.com/system/resources/thumbnails/009/304/897/small_2x/sun-icon-set-clipart-design-illustration-free-png.png"
          .obs;

  final clearSky =
      "https://cdn1.iconfinder.com/data/icons/weather-blips-warm/26/night_clear-512.png"
          .obs;
  var weather = Rxn<Weather>();
  var cityName = 'Delhi'.obs; // Default city
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedCity(); // Load the saved city on initialization
  }

  // Load saved city from SharedPreferences
  Future<void> loadSavedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cityName.value = prefs.getString('Delhi') ?? 'Delhi';
    fetchWeatherByCity();
  }

  // Save city name in SharedPreferences
  Future<void> saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Delhi', city);
  }

  // Future<void> fetchWeatherByCity() async {
  //   if (cityName.isNotEmpty) {
  //     try {
  //       Weather? fetchedWeather =
  //           await _wf.currentWeatherByCityName(cityName.value);

  //       weather.value = fetchedWeather;
  //     } catch (e) {
  //       throw (e);
  //     }
  //   } else {
  //     EasyLoading.showToast('not fouynd');
  //   }
  // }

  Future<void> fetchWeatherByCity() async {
    if (cityName.value.isNotEmpty) {
      try {
        Weather? fetchedWeather =
            await _wf.currentWeatherByCityName(cityName.value);
        weather.value = fetchedWeather;
      } on OpenWeatherAPIException catch (e) {
        // Check for city not found error
        if (e.toString().contains('404')) {
          fetchWeatherByLong();
        } else {
          _showErrorSnackbar('An error occurred: ${e.toString()}');
        }
      } catch (e) {
        // Handle other exceptions
        _showErrorSnackbar('An unexpected error occurred');
      }
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar('title', message);
  }

  Future<void> fetchWeatherByLong() async {
    try {
      List<Location> locations = await locationFromAddress(cityName.value);
      if (locations.isNotEmpty) {
        latitude.value = locations.first.latitude;
        longitude.value = locations.first.longitude;

        Weather fetchedWeather =
            await _wf.currentWeatherByLocation(latitude.value, longitude.value);
        weather.value = fetchedWeather;
      }
    } catch (e) {
      Get.snackbar("Error", "Location or Weather data not found",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    }
  }
}
