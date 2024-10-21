import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_tutorial/App/Weather/Controllers/Weather_Controllers.dart';
import 'package:weather_app_tutorial/Routes/app_pages.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spiderweb Weather',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.toNamed(Routes.SEARCH);
            },
          ),
        ],
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Obx(() {
        if (controller1controller.weather.value == null) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        } else {
          return Column(
            children: [
              _locationHeader(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              _dateTimeInfo(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              _weatherIcon(context),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              _currentTemp(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              _extraInfo(context),
            ],
          );
        }
      }),
    );
  }

  Widget _locationHeader() {
    return Obx(() => Text(
          controller1controller.weather.value?.areaName ??
              controller1controller.cityName.value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ));
  }

  Widget _dateTimeInfo() {
    return Obx(() {
      DateTime now =
          controller1controller.weather.value?.date ?? DateTime.now();
      return Column(
        children: [
          Text(
            DateFormat("h:mm a").format(now),
            style: const TextStyle(fontSize: 35),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat("EEEE").format(now),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                "  ${DateFormat("d.m.y").format(now)}",
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _weatherIcon(context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    controller1controller.weather.value?.weatherIcon == "01d"
                        ? controller1controller.sun.value
                        : controller1controller.weather.value?.weatherIcon ==
                                "01n"
                            ? controller1controller.clearSky.value
                            : "http://openweathermap.org/img/wn/${controller1controller.weather.value?.weatherIcon}@4x.png",
                  ),
                ),
              ),
            ),
            Text(
              controller1controller.weather.value?.weatherDescription ?? "",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ));
  }

  Widget _currentTemp() {
    return Obx(() => Text(
          "${controller1controller.weather.value?.temperature?.celsius?.toStringAsFixed(0)}° C",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 90,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  Widget _extraInfo(context) {
    return Obx(() => Container(
          height: MediaQuery.sizeOf(context).height * 0.15,
          width: MediaQuery.sizeOf(context).width * 0.80,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Max: ${controller1controller.weather.value?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Min: ${controller1controller.weather.value?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Wind: ${controller1controller.weather.value?.windSpeed?.toStringAsFixed(0)}m/s",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Humidity: ${controller1controller.weather.value?.humidity?.toStringAsFixed(0)}%",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
