import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherService weatherService = WeatherService();
  String city = "Feni";
  Map<String, dynamic>? currentWeather;

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  Future<void> fetchWeather() async {
    try {
      final weatherData = await weatherService.fetchCurrentWeather(city);
      setState(() {
        currentWeather = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWeather == null
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.grey,
                      Colors.white,
                    ]),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.grey,
                      Colors.white,
                    ]),
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        city,
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          // width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(currentWeather!['current']
                                      ['condition']['icon']),
                                  fit: BoxFit.contain)),
                        ),
                        Text(
                          "${currentWeather!['current']['temp_c'].round()} °C",
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          currentWeather!['current']['condition']['text'],
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "Max: ${currentWeather!['forecast']['forecastday'][0]['day']['maxtemp_c'].round()} °C",
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
