import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_app_tutorial/App/Search/Controllers/Search_Controller.dart';

class SearchView extends GetView<SearchControllers> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: controller1controller.cityController,
              decoration: InputDecoration(
                suffixIcon: Obx(() => controller1controller
                    .buttonActive(controller1controller.active.value)),
                labelText: 'Enter City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                controller1controller.updateSearchResults(value);
                controller1controller.check(value);
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller1controller.searchResults.isEmpty) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            childAspectRatio: 2.3),
                    itemCount: controller1controller.famousCities.length,
                    itemBuilder: (context, index) {
                      final city = controller1controller.famousCities[index];
                      return Center(
                          child: InkWell(
                        onTap: () {
                          controller1controller.saveCity(city);
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            city,
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                      ));
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            childAspectRatio: 2.3),
                    itemCount: controller1controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final city = controller1controller.searchResults[index];
                      return Center(
                          child: InkWell(
                        onTap: () {
                          controller1controller.saveCity(city);
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            city,
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                      ));
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
