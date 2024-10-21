import 'package:get/get.dart';
import 'package:weather_app_tutorial/App/Weather/Controllers/Weather_Controllers.dart';

class WeatherBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(() => WeatherController());
  }
}
