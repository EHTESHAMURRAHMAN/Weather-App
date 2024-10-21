// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weather/weather.dart';
// import 'package:weather_app_tutorial/App/Functions/consts.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
//   Weather? _weather;
//   TextEditingController cityController = TextEditingController();
//   String? _cityName;
//   double? _latitude, _longitude;

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedCity();
//   }

//   Future<void> _loadSavedCity() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _cityName = prefs.getString('city') ?? 'Delhi';
//       cityController.text = _cityName!;
//       _fetchWeather();
//     });
//   }

//   Future<void> _saveCity(String city) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('city', city);
//   }

//   Future<void> _fetchWeather() async {
//     if (_cityName != null && _cityName!.isNotEmpty) {
//       try {
//         // First, geocode the city or village to get its coordinates
//         List<Location> locations = await locationFromAddress(_cityName!);
//         if (locations.isNotEmpty) {
//           _latitude = locations.first.latitude;
//           _longitude = locations.first.longitude;

//           // Fetch weather data by coordinates (latitude, longitude)
//           Weather? weather =
//               await _wf.currentWeatherByLocation(_latitude!, _longitude!);
//           setState(() {
//             _weather = weather;
//           });
//         }
//       } catch (e) {
//         // Handle exception when location is not found or weather data is unavailable
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//             'Location or Weather data not found',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//         ));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Weather',
//           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: _buildUI(),
//     );
//   }

//   Widget _buildUI() {
//     return SizedBox(
//       width: MediaQuery.sizeOf(context).width,
//       height: MediaQuery.sizeOf(context).height,
//       child: ListView(
//         children: [
//           _searchField(),
//           const SizedBox(height: 20),
//           if (_weather == null)
//             const Center(
//               child: CircularProgressIndicator(),
//             )
//           else
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _locationHeader(),
//                   SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
//                   _dateTimeInfo(),
//                   SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
//                   _weatherIcon(),
//                   SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
//                   _currentTemp(),
//                   SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
//                   _extraInfo(),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _searchField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: cityController,
//               decoration: InputDecoration(
//                 labelText: 'Enter City or Village',
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               setState(() {
//                 _cityName = cityController.text;
//                 _saveCity(_cityName!);
//                 _fetchWeather();
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _locationHeader() {
//     return Text(
//       _weather?.areaName ?? _cityName!,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _dateTimeInfo() {
//     DateTime now = _weather!.date!;
//     return Column(
//       children: [
//         Text(
//           DateFormat("h:mm a").format(now),
//           style: const TextStyle(
//             fontSize: 35,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               DateFormat("EEEE").format(now),
//               style: const TextStyle(fontWeight: FontWeight.w700),
//             ),
//             Text(
//               "  ${DateFormat("d.m.y").format(now)}",
//               style: const TextStyle(fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _weatherIcon() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: MediaQuery.sizeOf(context).height * 0.20,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(
//                   "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
//             ),
//           ),
//         ),
//         Text(
//           _weather?.weatherDescription ?? "",
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _currentTemp() {
//     return Text(
//       "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
//       style: const TextStyle(
//         color: Colors.black,
//         fontSize: 90,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _extraInfo() {
//     return Container(
//       height: MediaQuery.sizeOf(context).height * 0.15,
//       width: MediaQuery.sizeOf(context).width * 0.80,
//       decoration: BoxDecoration(
//         color: Colors.deepPurpleAccent,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//               ),
//               Text(
//                 "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//               ),
//               Text(
//                 "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
