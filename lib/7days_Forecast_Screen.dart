import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Services/services.dart';
import 'main.dart';

class SevenDaysForecast extends StatefulWidget {
  SevenDaysForecast({super.key});

  @override
  State<SevenDaysForecast> createState() => _SevenDaysForecastState();
}

class _SevenDaysForecastState extends State<SevenDaysForecast> {
  final WeatherService weatherService = WeatherService();

  List<dynamic>? forecast;

  @override
  void initState() {
    fetchForecast();
    super.initState();
  }

  Future<void> fetchForecast() async {
    try {
      final forecastData =
          await weatherService.fetch7DaysForecast(maincityName);
      setState(() {
        forecast = forecastData['forecast']['forecastday'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: forecast == null
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
          : Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
                left: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     height: 20,
                      //     width: 20,
                      //     decoration: BoxDecoration(
                      //         image: const DecorationImage(
                      //           image: AssetImage("assets/icons/arrow.png"),
                      //           fit: BoxFit.cover,
                      //         ),
                      //         // color: Colors.grey,
                      //         borderRadius: BorderRadius.circular(50)),
                      //   ),
                      // ),
                      Text(
                        "7 Days Weather",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(),
                    ],
                  ),
                  // SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: forecast!.length,
                      itemBuilder: (context, index) {
                        var data = forecast?[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                          padding: const EdgeInsets.only(
                                                left: 20),
                                            child: Image.network(
                                              "https:${data['day']['condition']['icon']}",
                                              height: 70,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15),
                                            child: Container(
                                              height: 20,
                                              width: 150,
                                              // color: Colors.amber,
                                              child: Text(
                                                data['day']['condition']['text'],
                                                style:
                                                    TextStyle(color: Colors.grey),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${data['day']['avgtemp_c'].round()}°",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Min: ${data['day']['mintemp_c'].round()}°",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Max: ${data['day']['maxtemp_c'].round()}°",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 20,
                                    width: 90,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Text(
                                      data['date'],
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
