import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:weather_app_tutorial/App/Search/Bindings/Search_Bindings.dart';
import 'package:weather_app_tutorial/App/Search/Views/Search_Views.dart';
import 'package:weather_app_tutorial/App/Weather/Bindings/Weather_Bindings.dart';

import '../App/Weather/Views/Weather_Views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.WEATHER;

  static final routes = [
    GetPage(
      name: Routes.WEATHER,
      page: () => const WeatherView(),
      binding: WeatherBindings(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchView(),
      binding: SearchBindins(),
    ),
  ];
}
