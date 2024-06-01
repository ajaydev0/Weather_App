import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '7days_Forecast_Screen.dart';
import 'Services/services.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchActive = false;
  final WeatherService weatherService = WeatherService();

  Map<String, dynamic>? currentWeather;

  @override
  void initState() {
    fetchWeather();
    super.initState();
  }

  Future<void> fetchWeather() async {
    try {
      final weatherData =
          await weatherService.fetchCurrentWeather(maincityName);
      setState(() {
        currentWeather = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var kHeight = MediaQuery.of(context).size.height / 100;
    var kWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: currentWeather == null
          ? Container(
              decoration: const BoxDecoration(),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          : searchActive
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        right: 20,
                        left: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  searchActive = false;
                                });
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TypeAheadField(
                                  builder: (context, controller, focusNode) {
                                    return TextFormField(
                                      controller: controller,
                                      decoration: const InputDecoration(
                                          hintText: "Search City .."),
                                      focusNode: focusNode,
                                      autofocus: true,
                                    );
                                  },
                                  itemBuilder: (context, city) {
                                    return ListTile(
                                      title: Text(city['name']),
                                    );
                                  },
                                  onSelected: (city) async {
                                    setState(() {
                                      maincityName = city['name'];
                                    });
                                    box.write("City", maincityName);

                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ));
                                  },
                                  suggestionsCallback: (pattern) async {
                                    return await WeatherService()
                                        .fetchCitySuggestion(pattern);
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        children: [
                          InkWell(
                            onTap: () {},
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
                            onTap: () {},
                            child: Row(
                              children: [
                                SizedBox(
                                  width: kWidth * 55,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          size: 20,
                                          color: Colors.grey.shade600), 
                                      const SizedBox(width: 1),
                                      Text(
                                        maincityName,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                searchActive = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image:
                                        AssetImage("assets/icons/search2.png"),
                                    fit: BoxFit.cover,
                                  ),
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
                                children: [],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      child: Image.network(
                                          "https:${currentWeather!['current']['condition']['icon']}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Max: ${currentWeather!['forecast']['forecastday'][0]['day']['maxtemp_c'].round()} °C",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    "Min: ${currentWeather!['forecast']['forecastday'][0]['day']['mintemp_c'].round()} °C",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FirstContainer(
                                      currentWeather: currentWeather,
                                      headline: "Sunrise",
                                      subtext: currentWeather!['forecast']
                                              ['forecastday'][0]['astro']
                                          ['sunrise'],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                              ['forecastday'][0]['hour'][index]
                                          ['time'];
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: MaterialButton(
                                    height: 60,
                                    minWidth: double.infinity,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                SevenDaysForecast(),
                                          ));
                                    },
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text(
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
