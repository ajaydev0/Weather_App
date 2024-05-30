import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_apps/Services/services.dart';
import 'package:weather_apps/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Column(
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
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
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                          var sharedPref = await SharedPreferences.getInstance();
                          sharedPref.setString("savedCityData", maincityName );
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                        },
                        suggestionsCallback: (pattern) async {
                          return await WeatherService()
                              .fetchCitySuggestion(pattern);
                        },
                      )),
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     alignment: Alignment.center,
                //     height: 35,
                //     width: 35,
                //     decoration: BoxDecoration(
                //         image: const DecorationImage(
                //           image: AssetImage("assets/icons/search2.png"),
                //           fit: BoxFit.cover,
                //         ),
                //         // color: Colors.grey,
                //         borderRadius: BorderRadius.circular(50)),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
