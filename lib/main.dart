// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_apps/7days_Forecast_Screen.dart';
import 'package:weather_apps/Search_Page.dart';
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
              decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [
                  //       Colors.black,
                  //       Colors.grey,
                  //       Colors.black,
                  //     ]),
                  ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 20,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          // controller.globalKey.currentState?.openDrawer();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/icons/menu.png"),
                                fit: BoxFit.cover,
                              ),
                              // color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      InkWell(

                        onTap: () {
                           Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SearchPage(),
                              ));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 20, color: Colors.grey.shade600),
                            const SizedBox(width: 1),
                            Text(city,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade600,
                                )),
                          ],
                        ),
                      ),
                      // IconButton(onPressed: () {}, icon: Icon(Icons.search,size: 40,))
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SearchPage(),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/icons/search2.png"),
                                fit: BoxFit.cover,
                              ),
                              // color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   city,
                              //   style: const TextStyle(
                              //       fontSize: 40,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.black),
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Material(
                                elevation: 7,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 110,
                                  width: 100,
                                  padding: const EdgeInsets.all(15),
                                  // decoration: BoxDecoration(
                                  //     // color: Colors.black,
                                  //     borderRadius: BorderRadius.circular(20),
                                  //     image: DecorationImage(
                                  //       image: NetworkImage("https:${currentWeather!['current']
                                  //               ['condition']['icon']}"),
                                  //       fit: BoxFit.contain,
                                  //     )),
                                  child: Image.network(
                                      "https:${currentWeather!['current']['condition']['icon']}",
                                      // color: Colors.black,
                                      fit: BoxFit.fitHeight),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        "${currentWeather!['current']['temp_c'].round()}°",
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      const Text(
                                        "C",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Feels like ${currentWeather!['current']['feelslike_c'].round()} °C",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            currentWeather!['current']['condition']['text'],
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Max: ${currentWeather!['forecast']['forecastday'][0]['day']['maxtemp_c'].round()} °C",
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "Min: ${currentWeather!['forecast']['forecastday'][0]['day']['mintemp_c'].round()} °C",
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FirstContainer(
                                  currentWeather: currentWeather,
                                  headline: "Sunrise",
                                  subtext: currentWeather!['forecast']
                                      ['forecastday'][0]['astro']['sunrise'],
                                  icon: Icons.sunny,
                                ),
                                FirstContainer(
                                  currentWeather: currentWeather,
                                  headline: "Sunset",
                                  subtext: currentWeather!['forecast']
                                      ['forecastday'][0]['astro']['sunset'],
                                  icon: Icons.nightlight_round,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirstContainer(
                                currentWeather: currentWeather,
                                headline: "Wind",
                                subtext: currentWeather!['current']
                                        ['windchill_c']
                                    .toString(),
                                icon: Icons.air,
                              ),
                              FirstContainer(
                                currentWeather: currentWeather,
                                headline: "Humidity",
                                subtext:
                                    "${currentWeather!['current']['humidity'].toString()}%",
                                icon: Icons.water_drop,
                              ),
                              FirstContainer(
                                currentWeather: currentWeather,
                                headline: "Rain",
                                subtext:
                                    "${currentWeather!['forecast']['forecastday'][0]['day']['daily_chance_of_rain'].toString()}%",
                                icon: Icons.water_outlined,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: 24,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var celsius = currentWeather!['forecast']
                                          ['forecastday'][0]['hour'][index]
                                      ['temp_c'];
                                  var time = currentWeather!['forecast']
                                      ['forecastday'][0]['hour'][index]['time'];
                                  var imageurl = currentWeather!['forecast']
                                          ['forecastday'][0]['hour'][index]
                                      ['condition']['icon'];

                                  return SecondContainer(
                                      currentWeather: currentWeather,
                                      headline: "${celsius.round()}°",
                                      subtext:
                                          "${time.substring(time.length - 5, time.length)}",
                                      imgurl: "https:$imageurl");
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MaterialButton(
                                height: 60,
                                minWidth: double.infinity,
                                onPressed: () {
                                    Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>  SevenDaysForecast(city: city,),
                              ));

                                },
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  "Next 7 Days Weather ▷",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          const SizedBox(height: 40),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class FirstContainer extends StatelessWidget {
  String headline;
  String subtext;
  IconData icon;
  FirstContainer({
    super.key,
    required this.currentWeather,
    required this.headline,
    required this.subtext,
    required this.icon,
  });

  final Map<String, dynamic>? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 1),
            Icon(icon, size: 24),
            Column(
              children: [
                Text(
                  headline,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  subtext,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SecondContainer extends StatelessWidget {
  String headline;
  String subtext;
  String imgurl;
  SecondContainer({
    super.key,
    required this.currentWeather,
    required this.headline,
    required this.subtext,
    required this.imgurl,
  });

  final Map<String, dynamic>? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 20, top: 5, left: 10),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 5),
              Text(
                headline,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Image.network(
                imgurl,
                height: 40,
              ),
              Text(
                subtext,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
