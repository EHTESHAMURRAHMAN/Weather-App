import 'package:get/get.dart';
import 'package:weather_app_tutorial/Service/Storage.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
