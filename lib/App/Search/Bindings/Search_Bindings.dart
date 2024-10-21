import 'package:get/get.dart';
import 'package:weather_app_tutorial/App/Search/Controllers/Search_Controller.dart';

class SearchBindins extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchControllers>(() => SearchControllers());
  }
}
