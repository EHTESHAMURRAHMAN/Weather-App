import 'package:get/get.dart';
import 'package:weather_app_tutorial/App/Weather/Controllers/Weather_Controllers.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<WeatherController>(WeatherController(), permanent: true);
  }
}
